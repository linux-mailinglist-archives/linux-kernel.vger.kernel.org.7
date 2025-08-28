Return-Path: <linux-kernel+bounces-789664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BCB398CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A59A20155A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061672F290A;
	Thu, 28 Aug 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9sf9fNk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4022F067E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374705; cv=none; b=FqmNaRcaDT6Zs4qcNUXbsR+sss2Mu8ORdM7MHSJoSRPpXpE3TLSTugBSWq4/n92VLwdqe510NqWYXJ71927cSV4cojXZoanbvAoXvC59/9uyMBHer/sb77EHqpZ3qcjA7/9kA9nn2ZDW2LwAGlI5nVQPY68JAwba6KD1murV2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374705; c=relaxed/simple;
	bh=KBVgzYFp4o1xKDTa2u5bq3VPLI9X1xG7F0PGV3+qckQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EeUQA/cHoLZncUrnSwGUQ0f7wLtmvBt3kRa8COr+mgPKYJ6pAP0rnyeTAsbZtfNwXujLzephqbvGMiTcSoV6kqa1E5NrA+vFFer945mY8ae9fkwsxpvpAOUQuqNOPPW1AcyInMHC5bQQznkkMOR1dy5POxngjxbLCK/KgMPI2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9sf9fNk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756374704; x=1787910704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KBVgzYFp4o1xKDTa2u5bq3VPLI9X1xG7F0PGV3+qckQ=;
  b=P9sf9fNkx/xE9zrX4EbvT8fFSPvbqvU0TK9Ha0e/MnR5CjuB63psh7pJ
   1IYYpldYpAEh2116cJhJanrxJ1CB0GKOpsHC9KLXarBFNlba+94fTerJc
   sVuDDF49rS0X+vZd+an5p1Q9WgoXTSlkjL+WyHzYlkLAJd/5KZGEn2WgJ
   IolyN6kc3H1FslnHs+dO3Fshyeb8DkRmtpP+IlBwVj94tVFryVGGBKyIh
   y68TQe/n9pqEFuxkbM/XuILSm3mExa4Q+f2i86pObbkjjP9O94lS9bcKr
   9bSV6bDc4HQ85QzqnJoNliZJOZ3rB2i9z00swJB0Fk7wMbCGj5jsJDS01
   A==;
X-CSE-ConnectionGUID: YHVXzJUAQxW5z4DBHh2Y3w==
X-CSE-MsgGUID: Yx9ReSWRQMuSilwKuMSEtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69231695"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69231695"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:51:43 -0700
X-CSE-ConnectionGUID: RDkHFOboSUKLvNYzjmhKPA==
X-CSE-MsgGUID: 1JlfaReGS9O9kIb+GM7EYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170877253"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.10])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:51:38 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Dibin Moolakadan
 Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>, Imre Deak
 <imre.deak@intel.com>, David Laight <david.laight.linux@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Matt Wagantall
 <mattw@codeaurora.org>, Dejin Zheng <zhengdejin5@gmail.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 1/3] iopoll: Generalize read_poll_timeout() into
 poll_timeout_us()
In-Reply-To: <20250826121859.15497-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250826121859.15497-1-ville.syrjala@linux.intel.com>
Date: Thu, 28 Aug 2025 12:51:35 +0300
Message-ID: <c34ce332183d24ed29ed23852238fd5ca948d4f1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Aug 2025, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> While read_poll_timeout() & co. were originally introduced just
> for simple I/O usage scenarios they have since been generalized to
> be useful in more cases.
>
> However the interface is very cumbersome to use in the general case.
> Attempt to make it more flexible by combining the 'op', 'var' and
> 'args' parameter into just a single 'op' that the caller can fully
> specify.

Thanks for the patches!

Since there was no opposition now or the last time these were posted
[1], iopoll.h is not in MAINTAINERS, and the previous changes to the
file have gone in through various trees, I've gone ahead and merged the
lot to drm-intel-next with Simona's IRC ack.

I'll be rebasing and posting my follow-up i915 changes on top of this
shortly.


BR,
Jani.


[1] https://lore.kernel.org/r/20250702223439.19752-1-ville.syrjala@linux.in=
tel.com


--=20
Jani Nikula, Intel

