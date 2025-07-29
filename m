Return-Path: <linux-kernel+bounces-749430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A84B14E47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED25F5456C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB941B0413;
	Tue, 29 Jul 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4p0JICv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F44CA4B;
	Tue, 29 Jul 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795194; cv=none; b=fWdTIyamraPuga/NvxGILCTBKcYSo90nU2KMI3GCqftTWjNT9Wi3JZc4taX0IK15vwXQzpvkTjDSUkyl5h501kHCAq3f2zCvNaCiYVRSqHarYpBZ3u4ek4BUEMQV2CIjGNOhOUyWpH6V0ZPG/y4wteN/Jwo/cNHXpajz5uyHxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795194; c=relaxed/simple;
	bh=YM987/82foYTtFS7Ru1EkSgshFaDDES4SWlKS0fv0Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ube+BBfFSe9iYuHD35aQWio+13Ntk7bmtXfCRDWBKht7xON157WBkx/LSzDmTDqPezMsfzTNxNjTsJ3jgiMWA3uxuwniDNI0WIRJX/fUbjcYkaZeL4x9WQT3T7xlgFg/jaeQQ6b8vJ5QaeJpwq84JXy3ACh4UpIHcu8SozajAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4p0JICv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753795192; x=1785331192;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YM987/82foYTtFS7Ru1EkSgshFaDDES4SWlKS0fv0Ss=;
  b=R4p0JICvrGVTv7/zD6go+StFVAopqynyDcLPRlakQOpJl/OJeAYhhd2v
   X3iSmacF/hPV8tCvba44K/fho/wKy1quApL1O1RNSnmIOCn39QJoI7wyf
   pZrXBJ3o4GS8y2tAL3AMRrsJg9k3l6Ui9dCumjXyRaS8yhiBnVcuC+/+P
   3yQJqWvdUtpMsh4qjjw4u+UnlwjeArxgG2NYaaMkuXPW6tMC/YWSXVlV/
   XOWoEd3SWgbfVqi+K22/tQ0uxsVP+Gyw/K5CG2zXjKFc1fP/fbzmlEuPj
   fptlb3TxwdX64eH6ovDTaZjY6UM8SvBcRYjWc0ODpqCq1LQjD3XPJG/y3
   g==;
X-CSE-ConnectionGUID: WdgHt8qWTXGsqNNbMHdzTg==
X-CSE-MsgGUID: xIpO3TmXSqSs8jXc+O/dMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66628639"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="66628639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 06:19:51 -0700
X-CSE-ConnectionGUID: 1LjYHoaKTOSWMv7O/LMNVw==
X-CSE-MsgGUID: AWTWK4uMQcqGahgEGQDp0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="161967838"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.22])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 06:19:49 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Akira Yokosawa <akiyks@gmail.com>, mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 1/2] docs: kernel-doc: avoid script crash on ancient Python
In-Reply-To: <8251d567-5218-4fa1-aed2-f38ec089989d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <dc75423e817f92cc6b8369892ee79166c2fb5ecc.1753713955.git.mchehab+huawei@kernel.org>
 <8251d567-5218-4fa1-aed2-f38ec089989d@gmail.com>
Date: Tue, 29 Jul 2025 16:19:45 +0300
Message-ID: <e9cf21e5332616f2fb58a90fe8ba6f91359915b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 29 Jul 2025, Akira Yokosawa <akiyks@gmail.com> wrote:
> Hi,
>
> On Mon, 28 Jul 2025 16:54:28 +0200, Mauro Carvalho Chehab wrote:
>> While we do need at least 3.6 for kernel-doc to work, and at least
>> 3.7 for it to output functions and structs with parameters at the
>> right order, let the python binary be compatible with legacy
>                               code?
>
>> versions.
>> 
> [...]
>> 
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>  scripts/kernel-doc.py | 37 ++++++++++++++++++++++++++-----------
>>  1 file changed, 26 insertions(+), 11 deletions(-)
>> 
>> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
>> index fc3d46ef519f..d4f9188d6a19 100755
>> --- a/scripts/kernel-doc.py
>> +++ b/scripts/kernel-doc.py
>> @@ -1,9 +1,19 @@
>> -#!/usr/bin/env python3
>> +#!/usr/bin/env python
>
> This would conflict with my existing setup which has
> /usr/bin/python3 only.
>
> Please don't do this!

Agreed, this breaks more than it fixes.

Python 2.7 reached end-of-life over five years ago. Do we really have to
cater for ancient stuff? Which actual real world cases do not have
Python 3+ available? Please just let it go, and see if anyone ever
notices?

BR,
Jani.


-- 
Jani Nikula, Intel

