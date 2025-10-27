Return-Path: <linux-kernel+bounces-871819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03DC0E666
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4334E9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D552307AF4;
	Mon, 27 Oct 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGZgjZgV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1A1990D9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575183; cv=none; b=iUEAhQs8NwPARK/5nuAJ8mNFuIUFxbBspcHw/SlvcjaiFEWjrDkjINK3Zt/xGxODfqCw28SFA8GE5+gp2Tm8nQf0B53UDkh2FmFspzeOyy7ZYtiK35yZqurPFysUH+N+Xam7/h7jFmLgMMOU4YiFB797J4WwlKh2biTS/8Cv5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575183; c=relaxed/simple;
	bh=QNAs3eHNaBSl+WcAKCTKDlP8yKQtJYljBYe8BMyCs4U=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=DdJN40YTRAeggWznnJWs0FSOczBXqDryrY/eI8oIX+ZT+nlF5pavVK2eTFQeqk6slgdGDorwPzepimGQxT5wOIEcCS86GbgVhlFFhGuOueOKu9TM+GZ+i5J2eYbgZbsQpu2oppz6jZ3sE0VjmMq+1ekG55QI9epDs6de9RB13Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGZgjZgV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575182; x=1793111182;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to;
  bh=QNAs3eHNaBSl+WcAKCTKDlP8yKQtJYljBYe8BMyCs4U=;
  b=OGZgjZgV3HNYNgdwHxWyCEcv7cNFB4F3cC905i1D7aq2+M3S5vGL/Mkc
   UTAr98c9X4I28tS+zixAKR7UchqiIUwUc/NTS9zOXKjpfQSDIBP0mtZ1j
   wCoggCIBR8/kPgdWhXLCYaRZNLw+7Jf0h3pMMQNqtiIEPtERQo5gq4KZ+
   a2BOT4ksWGOxBcm1QOUxEZyoR0JMl7W6IL5cvofGCQE3dEMLtrjkuS/jW
   JZs+XSWPZ3naeeNKVRPnJj6Sdlee4l/pRBSbJ391j9Ni3WUNrv4vh6Vpf
   //I5SFvX2lxocpUeePAev6rDje/rHsYkev/LcDcLq7f81b57g/o4SWh5Z
   w==;
X-CSE-ConnectionGUID: iOFeo8B3SiuaINvV+/BK5Q==
X-CSE-MsgGUID: WRhDKoWzS0eFUFbmf+pP8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62860740"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="62860740"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:26:20 -0700
X-CSE-ConnectionGUID: isqAc+/CRvyduoczS7yjuA==
X-CSE-MsgGUID: 1GeXwvhORaCHOI6n7Qne4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="189093349"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.94]) ([10.125.109.94])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:26:20 -0700
Content-Type: multipart/mixed; boundary="------------NKj8V0uPjkX5pv7cv9WrvIpm"
Message-ID: <c311789b-a6be-42c9-acfe-c1fdd9f4e3e1@intel.com>
Date: Mon, 27 Oct 2025 07:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/fpu: Inaccurate AVX-512 Usage Tracking via arch_status
To: chuang <nashuiliang@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, open list <linux-kernel@vger.kernel.org>
References: <CACueBy7-1dMwPQ4mirrRjsOkKKyLchkBR+7qMVqxjo7Bbr1T=A@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CACueBy7-1dMwPQ4mirrRjsOkKKyLchkBR+7qMVqxjo7Bbr1T=A@mail.gmail.com>

This is a multi-part message in MIME format.
--------------NKj8V0uPjkX5pv7cv9WrvIpm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 00:50, chuang wrote:
> On AVX-512 capable systems, the implementation appears to record the
> current timestamp into 'task->thread.fpu.avx512_timestamp' upon any
> task switch, irrespective of whether the task has actually executed an
> AVX-512 instruction.

The timestamp update ultimately has _zero_ to do with executing
AVX-512 instructions. It's all about the state in the ZMM registers, not
AVX-512 instructions.

Those registers are inherited at fork and I don't see avx512_timestamp
being zeroed anywhere. So I suspect what you are seeing is that some
_parent_ used AVX512, and its children are getting stuck with
avx512_timestamp.

You could probably confirm this by dumping ->avx512_timestamp in
fpu_clone().

Or, try the attached patch and see if it makes things work more like
you'd expect.
--------------NKj8V0uPjkX5pv7cv9WrvIpm
Content-Type: text/x-patch; charset=UTF-8; name="avx512-ts-reset.patch"
Content-Disposition: attachment; filename="avx512-ts-reset.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jIGIvYXJjaC94ODYva2Vy
bmVsL2ZwdS9jb3JlLmMKaW5kZXggMWY3MWNjMTM1ZTlhLi4yYThjMTU5ZGU1ZTIgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9mcHUvY29yZS5jCkBAIC02NDgsNiArNjQ4LDggQEAgaW50IGZwdV9jbG9uZShzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKmRzdCwgdTY0IGNsb25lX2ZsYWdzLCBib29sIG1pbmltYWwsCiAJLyog
VGhlIG5ldyB0YXNrJ3MgRlBVIHN0YXRlIGNhbm5vdCBiZSB2YWxpZCBpbiB0aGUgaGFyZHdh
cmUuICovCiAJZHN0X2ZwdS0+bGFzdF9jcHUgPSAtMTsKIAorCWRzdF9mcHUtPmF2eDUxMl90
aW1lc3RhbXAgPSAwOworCiAJZnBzdGF0ZV9yZXNldChkc3RfZnB1KTsKIAogCWlmICghY3B1
X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUFUpKQo=

--------------NKj8V0uPjkX5pv7cv9WrvIpm--

