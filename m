Return-Path: <linux-kernel+bounces-876472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02CC1B919
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983F7188A15F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3D2DE200;
	Wed, 29 Oct 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsqMwvur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFC2DC76E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750409; cv=none; b=ECDVTji57Td3MeugWs9dzbvAAR+qvLkJXbj4C9HdHWiO57Ul95X1/xytP6+oyVeLdRmM+p4nEXkeDypWMiadpQlopIMDUE3od2U/W9nKNN2QhppGaH8Z6pLCiXiLfuFFEWJOnXiY9hfeo58XDmhk1zSC6/LsW9TDhzOLFHNo3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750409; c=relaxed/simple;
	bh=x4tq1577DDMCaHW3fTcMZ1a5KydbuBLTN+yqRePgwcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn1feNZifCdiNF3ORd1EMqQyLAcciMjox2QxHeisGcSd1+axGLlOsbHKwwhIZHXQE8KOyTaEANrUoWhf+kPBS1HR1cdnS2xEg/J+6OIcnCpDhxyCcxx406yIhxVrw4A5+FEdKZS70/OOzVk4Kzr86PWGgVAUQ7vI6G9RHEepKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsqMwvur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F2C4CEF7;
	Wed, 29 Oct 2025 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761750408;
	bh=x4tq1577DDMCaHW3fTcMZ1a5KydbuBLTN+yqRePgwcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsqMwvurh6t/xZMpEDwlS2InZJzz9Bh9oJpaJ9ISVQTJWSBOwYn6SZjMQvVyIoxla
	 dbjetpiIGRIu97loeqgJEZMZ/pHBMo7CKIoh+vcjq3HTfcknz/FC/NWpRfIxtWYXcm
	 21/11Z35cVqHB23xlDJUmHJI62tieaztlO3aOXty41BPNzjd8u/pXYCSRMt3bjVZns
	 EM0zNLHYK0LnzEtmlb+yjBqZ13A5WQknpqvNcIyk2vwPKOC/DwoWJTmab1pGeBUmKw
	 9uQ1QsgUkwzlMgBUzsGXIWtWLRX0lJ0jiUy7u0ZrgjTOhUyQ0TbKCu81PN5QaSJX9A
	 eNCReRnTcEkfA==
Date: Wed, 29 Oct 2025 05:06:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aQIthmQmKfztyaQZ@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <2e1e9d6f-4f9e-49f7-90f0-6759c260701f@amd.com>
 <aQEkq7DYy5/AaJ4R@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQEkq7DYy5/AaJ4R@lstrano-desk.jf.intel.com>

Hello,

On Tue, Oct 28, 2025 at 01:16:43PM -0700, Matthew Brost wrote:
> On Tue, Oct 28, 2025 at 10:32:54AM +0100, Christian König wrote:
> > On 10/21/25 23:39, Matthew Brost wrote:
> > > Drivers often use workqueues that are in the reclaim path (e.g., DRM
> > > scheduler workqueues). It is useful to teach lockdep that memory cannot
> > > be allocated on these workqueues. Add an interface to taint workqueue
> > > lockdep with reclaim.
> > 
> > Oh that is so wonderfully evil. I'm absolutely in favor of doing this.
> > 
> > But can't we check for the existing WQ_MEM_RECLAIM flag in the workqueue handling instead?
> > 
> 
> Tejun suggested tying the lockdep annotation to WQ_MEM_RECLAIM, but the
> entire kernel explodes because many workqueues throughout Linux don’t
> adhere to this rule. Here's a link to my latest reply to Tejun [1].

How about making it a WQ flag?

Thanks.

-- 
tejun

