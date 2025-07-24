Return-Path: <linux-kernel+bounces-744313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E223B10AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6471F1CC2012
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE126529B;
	Thu, 24 Jul 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EChqeJB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2F184
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362086; cv=none; b=jL97sU3264j9W0XysFOonKd8WzNi3O/0yOiB+PUQsXhE95de+jRoydJKUcFTjET/nXdzM1SiAU10PHaBlV2yqq4Mo7u+BCDnANF81TGchzQm9i6fFgw0xFYyDPJH0In6DWtxXCkBc3Rhcb5IPxT0vkmsd+yxVsw2xTmxW73oLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362086; c=relaxed/simple;
	bh=X1gt0rB4BXfQtDvaqL6R+6uofnYdLYegVfaylDXX96w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldiFCttU2mELwyYceCrDxNAR+0Pi6a0MqxElLQ6leZXQxmiU0EcDIfryka+CCOYSKrwBdYEf4kFA+sr5x7cn9Q3HWVEyMDT2b8HRADkRb2IPb9wHkdxPoKYhuakC7hA9DutMj6GR4c2Ixho1KMvTEzEbKGRIVDPeGidMkGY2Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EChqeJB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F8EC4CEED;
	Thu, 24 Jul 2025 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362085;
	bh=X1gt0rB4BXfQtDvaqL6R+6uofnYdLYegVfaylDXX96w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EChqeJB0/ObgkQSrAUMOF1yJCPu5p+GAVOdbBMI++bPtxCH816pVP5tuhhxlR2uAL
	 +u0imyXSyDGdQBVjcveiZCjiu2mdoxDF/bPLVucOck0hMS8IWOk8wZCmY2GbjAEKfY
	 nfZKfKlw4tDh+gdoocYH8WWfchuFkvBiGPnQhowArARWHNOy/QgwaKD5z9uu/BdHMF
	 H5LdxsMoGcTP3+sBLMKRUD5/nsi4ZNKCP1oWUMiHT1FlHr3AzW9DUdt+tKPvPHSg8r
	 IfQT2WQdTiU4ilrRAaomvxGjCGUGqHu7l3igrBwB3z+znx5fRfEN9YtLaa/ZkcyGxK
	 xMH3/8aake6uw==
Date: Thu, 24 Jul 2025 15:01:22 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 6/7] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
Message-ID: <aIIuostDifK5ympc@localhost.localdomain>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714133050.193108-15-gmonaco@redhat.com>

Le Mon, Jul 14, 2025 at 03:30:57PM +0200, Gabriele Monaco a écrit :
> Currently the user can set up isolated cpus via cpuset and nohz_full in
> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
> domain isolated nor nohz full). This can be a problem for other
> subsystems (e.g. the timer wheel imgration).
> 
> Prevent this configuration by blocking any assignation that would cause
> the union of domain isolated cpus and nohz_full to covers all CPUs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

