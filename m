Return-Path: <linux-kernel+bounces-774083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FAB2AE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2A17AF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E4341ABE;
	Mon, 18 Aug 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maw53CTF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AF27B353
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535377; cv=none; b=h2esYAEDc9BGL1vhpx3w8lD62SUYjKfqdXCznRMj0GNeCfwV5ABn1TZKtWSywE584ds2hz4kYm2HDUq4L+jHT39XDRPY6FIWMinGnZTj72FbN4pygZ4AMTX/5YM4+f6uzVa9CtrQOAAKP7sXu8jx/MsFI2Qx789PjwxIcjSziIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535377; c=relaxed/simple;
	bh=FFRgUjm1Gro1I+69P/TMbAic2wfSm8DMVKGUgEm0vxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzo2Xh9tQ4rStYWrALxg2F6OFsUwKi4Ns+9I5JcDmBoCoqyGt7op2A4eqFo5VeRLMsmeg3SAjD3L1M8UelmVkeWLgyRoNClxy2ChKfINqS44PMZPx48nLXSkmGuCVoijDmrC76dL+iw2ovyGvoxZl/eDK43SONDnnDiT1kJLMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maw53CTF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755535376; x=1787071376;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FFRgUjm1Gro1I+69P/TMbAic2wfSm8DMVKGUgEm0vxw=;
  b=maw53CTFmkrYF7Mg2LCtKnBqlqr8Sbb/RPP+EJm8zmWfSaT61XZZBXU4
   uzUuM5YsNnH+h+v7ZK2E5iaxwGN9IGdPDYPcGPPUZyQ3xiomveY7MClfu
   7sYS5OlRprSH/q6PfqA9/6d2YfZccjDsYHpsyBGjuDnECsNO8tiQD+I9G
   PG37JQjHebWFMh+uv5D9G4QDnzxsd31LStvFS4sLEbNDSsJIphrk85nxu
   dpvQV9IumKLY1V0UCPLJ+nXtr3dSoGLgIIGaSPz9Qqm3LeuTkE45XtypK
   67Pv6n04/Bs0NVO+8EZFmYZxGBhnFsekTItkbygwPN7UcXvkI+TsUfWsA
   g==;
X-CSE-ConnectionGUID: mckg41UmQzGsquXAUXM3Bw==
X-CSE-MsgGUID: shb22CqcScCfa5D0N/GqtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57913905"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57913905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:42:55 -0700
X-CSE-ConnectionGUID: hg58vD3gT1C5B79/FUkiiQ==
X-CSE-MsgGUID: wD+yurJLT02ZIM7X6sfNmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167863384"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.38]) ([10.245.244.38])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 09:42:52 -0700
Message-ID: <d34ba6c8c68a2fa85f052bdb4d27be15561f4861.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Andrew Morton
 <akpm@linux-foundation.org>,  Simona Vetter <simona.vetter@ffwll.ch>, Dave
 Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Date: Mon, 18 Aug 2025 18:42:36 +0200
In-Reply-To: <20250818163617.GI599331@ziepe.ca>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
	 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
	 <20250818160726.GH599331@ziepe.ca>
	 <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>
	 <20250818163617.GI599331@ziepe.ca>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 13:36 -0300, Jason Gunthorpe wrote:
> On Mon, Aug 18, 2025 at 09:25:20AM -0700, Matthew Brost wrote:
> > I think this choice makes sense: it allows embedding the wait state
> > from
> > the initial notifier call into the pass structure. Patch [6] shows
> > this
> > by attaching the issued TLB invalidation fences to the pass. Since
> > a
> > single notifier may be invoked multiple times with different ranges
> > but
> > the same seqno,
>=20
> That should be explained, but also seems to be a bit of a different
> issue..
>=20
> If the design is really to only have two passes and this linked list
> is about retaining state then there should not be so much freedom to
> have more passes.

Actually the initial suggestion was two passes only. Then I thought I
saw a use-case for even three passes and added the multi-pass thing,
but I think it turned out we didn't have such a use-case. IMO we could
restrict it to two-pass. Matthew, that should be completely OK for the
SVM use-case, right?

/Thomas


>=20
> Jason


