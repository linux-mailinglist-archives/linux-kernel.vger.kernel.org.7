Return-Path: <linux-kernel+bounces-856856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF83BE5421
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30519428104
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72682DC34D;
	Thu, 16 Oct 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cXteP9mc"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1A14B950
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643645; cv=none; b=NQxOZZH6erDgGO70pONiQCvr93poJnK3iP0VmlwdA5xS3l2n5o5WB78OGnG+eo5q5ITUc5FuUvPvO3K8DVelLttkDqItDfGFsd946sqq+CK9XqRhed3CmRNGuoqwSPOf6PBzqmRrk+5XQJV5oFxFD+ePnDoulUd/3dwGs5JWwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643645; c=relaxed/simple;
	bh=DY65VxxKn1BXe9WsL5yzDtxoiB5NEVPPo+vxCMsBWh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tbJ7nsJtxbZsAdxu0K/RDLe+EsJTpyDC3OP00a4yQ+LANi8HkjrRzwsjzqdrzB0aMqexfhpY+oYz35rIxCz5+nEQgLvGiuqGEPuczs9ATEfhhT4V/hqksTnIHC4Z1Re4tJizfThU61xR0aEbYbcoLRF+MmkIN58u9PI1vGVnln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cXteP9mc; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net ([192.55.60.44])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59GJdnNm3222897
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 16 Oct 2025 12:39:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59GJdnNm3222897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760643591;
	bh=ST7Mqr9+xVBmWcU8QHNlH2MF5sUZZWNoagXm57gQXpE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cXteP9mcx9taMV2cv/LHptulX1/vvBLknGCjLESRMqEVChE4IBBFYIxFhQ2VqSBpW
	 YJdtTildQYQVpV0fbYxwhX7axWCcU+1oOBg+uX+saSMm8zGULnFAEuHNTvGg8lKEkC
	 E7GPUF/hgVAUZ72ARyKSS0EKranIdGjMogyy3DNgppnFyl35FI3utKR93ml4rNU/ac
	 edAnRYZlxbk5cxjAO2McmfoM+MGT3G0QaUpnba8YlACLncGESlRrnL4Wj7C1qtJ1fb
	 FfcZXzLbyiXTMZjtbkhXQXYBfzpVNtKuTwD2u0nBVwBxhR6wCMAd5btYXSuZbaHcy8
	 MA3QCAJRB5SpQ==
Date: Thu, 16 Oct 2025 12:39:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Gregory Price <gourry@gourry.net>, x86@kernel.org
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
        mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
        me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
        darwi@linutronix.de, stable@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/amd=3A_Disable_RDSEED_o?=
 =?US-ASCII?Q?n_AMD_Zen5_Turin_because_of_an_error=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aPFDn-4Cm6n0_3_e@gourry-fedora-PF4VCD3F>
References: <20251016182107.3496116-1-gourry@gourry.net> <aPFDn-4Cm6n0_3_e@gourry-fedora-PF4VCD3F>
Message-ID: <94BA6EDC-5C44-490D-B6F5-0E38C8822F7C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 16, 2025 12:12:31 PM PDT, Gregory Price <gourry@gourry=2Enet> wr=
ote:
>On Thu, Oct 16, 2025 at 02:21:07PM -0400, Gregory Price wrote:
>> Under unknown architectural conditions, Zen5 chips running rdseed
>> can produce (val=3D0,CF=3D1) as a "random" result over 10% of the time
>> (when rdseed is successful)=2E  CF=3D1 indicates success, while val=3D0
>> is typically only produced when rdseed fails (CF=3D0)=2E
>>=20
>> This suggests there is an architectural issue which causes rdseed
>> to misclassify a failure as a success under unknown conditions=2E
>>=20
>> This was reproduced reliably by launching 2-threads per available
>> core, 1-thread per for hamming on RDSEED, and 1-thread per core
>> collectively eating and hammering on ~90% of memory=2E
>>=20
>> Fix was modeled after a different RDSEED issue in Zen2 Cyan Skillfish=
=2E
>>=20
>> Link: https://lore=2Ekernel=2Eorg/all/20250715130819=2E461718765@linuxf=
oundation=2Eorg/
>> Cc: <stable@kernel=2Eorg>
>> Signed-off-by: Gregory Price <gourry@gourry=2Enet>
>> ---
>>  arch/x86/kernel/cpu/amd=2Ec | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/cpu/amd=2Ec b/arch/x86/kernel/cpu/amd=2Ec
>> index 5398db4dedb4=2E=2E9c3b2f010f8c 100644
>> --- a/arch/x86/kernel/cpu/amd=2Ec
>> +++ b/arch/x86/kernel/cpu/amd=2Ec
>> @@ -1037,6 +1037,12 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
>> =20
>>  static void init_amd_zen5(struct cpuinfo_x86 *c)
>>  {
>> +	/* Disable RDSEED on AMD Turin because of an error=2E */
>> +	if (c->x86_model =3D=3D 0x11 && c->x86_stepping =3D=3D 0x0) {
>
>After re-examining the results, this was also observed on
>
>  c->x86_model =3D=3D 0x2
>
>Maybe this should just be disabled for all of Zen5?
>I will wait for comment=2E
>
>In a stress test (link) I found that my Zen5 chips have a bizarrely
>low rdseed success rate anyway - so it doesn't even seem useful=2E
>
>=2E/rdseed_stress_single_core
>RDRAND: 100=2E00%, RDSEED: 3=2E48%
>
>=2E/rdseed_stress_multi_thread
>RDRAND: 99=2E99%, RDSEED: 0=2E33%
>
>Link: https://lore=2Ekernel=2Eorg/all/Zbjw5hRHr_E6k18r@zx2c4=2Ecom/
>
>---
>
>diff --git a/arch/x86/kernel/cpu/amd=2Ec b/arch/x86/kernel/cpu/amd=2Ec
>index 9c3b2f010f8c=2E=2E54f07514674a 100644
>--- a/arch/x86/kernel/cpu/amd=2Ec
>+++ b/arch/x86/kernel/cpu/amd=2Ec
>@@ -1038,7 +1038,8 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
> static void init_amd_zen5(struct cpuinfo_x86 *c)
> {
>        /* Disable RDSEED on AMD Turin because of an error=2E */
>-       if (c->x86_model =3D=3D 0x11 && c->x86_stepping =3D=3D 0x0) {
>+       if ((c->x86_model =3D=3D 0x11 || c->x86_model =3D=3D 0x2) &&
>+           (c->x86_stepping =3D=3D 0x0)) {
>                clear_cpu_cap(c, X86_FEATURE_RDSEED);
>                msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
>                pr_emerg("RDSEED is not reliable on this platform; disabl=
ing=2E\n");

Let's be blunt (and this applies regardless of vendor, the same thing woul=
d apply to Intel chips): RDSEED *must not* be allowed to silently fail=2E P=
eriod=2E The whole *point* of RDSEED is that it is to unconditionally deliv=
er a fully entropic random result=2E=20

This affects user space applications, not just the kernel=20

As such, it is absolutely necessary to be conservative here=2E The vendor =
(in this case AMD) can then root-cause the failure and provide a narrower b=
lacklist when the true extent is known=2E


