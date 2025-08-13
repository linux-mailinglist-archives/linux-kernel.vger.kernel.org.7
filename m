Return-Path: <linux-kernel+bounces-766569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEAB24868
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474DB1BC30EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52E2F657D;
	Wed, 13 Aug 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="MUfke70C"
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010013.outbound.protection.outlook.com [52.103.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877311DF27F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084226; cv=fail; b=SbgauVf+YZ/5V74Nq2L7/x4p/1VkynaPBcoy9dtkDZBeG5XuNwf9h4r74KIySKkZt31VvFsaENj/cncJXD0lNOXMReatYyV8cjxTjWeK6XUWZOEr5rqz0u2xQbMmt9xhw1R8F6vllHi7O8MewT9rbKpwCHo8tGsgNrUgQCTKiCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084226; c=relaxed/simple;
	bh=t99lMVUBdP8O8Y00Ux7hjtewweeLB9ZNCILGZ11dGIs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ogVidLuHefAGoVnZVl5tGpvUCPF4Adg+HAp+F6JRAKHidbNxBGkVQ4SGaHcLpRJbXCiotEmpYX/qKzWMHzvqskCA8wWW4ZjAV8RSYstNuB6EXFSB+rs3GBJy02+JgdsOaRGsHfWJy0feXpu/jfD6ZMdwe0T/3avjp3zw6RoVGbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=MUfke70C; arc=fail smtp.client-ip=52.103.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cONQe/66wQkUk0StAbhE1+/wyfzDhR39W27o/+wjP1hOPfaYH/O68AYeQTib2b06+zE6riEFtzXSr6c4UP51vmefxQzsqITe49hwa7L5/zGmwWX6Fs61QNomzIjPqNzfEYZlRc3lzNCGCTGZV8fLsUq4PMoEEZIfSaK6gNNuuJIdK2n13T/ovYJDVZA875RGYS3x74DFrv1P/ptV/kY8+oejzn2P5j1B2CFG4RC7Mw8IP854tj37SwGCKsLKPBqNC/+fv4Vjs57Fu8ZkmlXce5wDiNxqpcWupJREwHmmGNpN19s+5KnLSVpkOhtvV8Clg/QIsZ/rQa8d56pAqWnJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBZa2h1jW29gULcO5MNSswIdzoKoBShEoqzCzCBakSY=;
 b=PF9BqG9bC8xgi9ZXAczFIeY/9uroIu0cEEVsQKr3eIZHXToPMt3JtMebY9abXuesrflBUXbHeeCqyd3r6XrjBE38kHROfg96VRlMaHRqesBu7t4ut5h6iGcT3fz2FIzlX8mPRxzYNx/9eyBAM1OmToJAoqodn/hYOMiDC+wbEjRQtzJVRt7SibZn+C0o1ujGotlZ31JQ+CrFSQqRycV/KKn4es/BL9tsDNFSHjuAs0uBfx7gEAaj8Ksh+SgavTueXZU70eeHsQFteOdHY1iOoI2Mg2pAxYF1UpuYTcl7kOC2zFTYiBXB1+vVRM7LWEaOEfJtmi6irTu1wxyl8P8BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBZa2h1jW29gULcO5MNSswIdzoKoBShEoqzCzCBakSY=;
 b=MUfke70C2X1LcZ7gB3tpu2Z1yYQYkjsR0nb83lJSilieKxVRDud8Vyyw7uRAYofrvN9G2yrr/Hbr8xd2GISudnxXfT2leHxJqZXWaS/iyePVMNnE1nlXRAhEGvZPcXFosBG2Tb12WAF0FIlzVRs1XG/kebwWVBPtIORsQJzdXOMC1U0qvrhEjufDIsCvI8Mwex8WFs0VPZ2CyaEY6GJy1MeVhQmW3dXJptVv6o7QNyz8tmZlaPqMgQ2VDR/qb8UewfeoDoQHBlSDi59CmYTe0x+kCIlk8LJgTypkPdztziuG3z5gcAdldob9y3yURBK8XDYERWunZCDDknmwyK+Wow==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SYBP282MB3687.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1a2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 11:23:39 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 11:23:38 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Topic: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Index: AQHcDES3Rcz9Ud13XUCtgTvWlw23QA==
Date: Wed, 13 Aug 2025 11:23:38 +0000
Message-ID: <20250813112020.345622-1-s.horvath@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4P282MB3063:EE_|SYBP282MB3687:EE_
x-ms-office365-filtering-correlation-id: 38d3e808-806a-4337-2987-08ddda5bd9b0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|41001999006|15080799012|8062599012|461199028|31061999003|38102599003|40105399003|3412199025|39105399003|440099028|12091999003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FUbU8nQGDOfKN2PBecR+rnuqFP7HFEdykXoewxlLtj21oTLsPBbdj7S41e?=
 =?iso-8859-1?Q?Z91IyNVya4cawbslZHupj8Y1ReY406JK1TO2UpbjNRMDizhRCvjtC2Nlrx?=
 =?iso-8859-1?Q?PMDOIlE81ry+m1/a+c8sM9vv+4rKFbA9hHDOeV+4j7Y5Zfl868CNPzhDI7?=
 =?iso-8859-1?Q?3olKI0dshzd2914ds2mSnDlfjfpfQfIkx88shr7ZaJR8MDjOxVdGClCSLC?=
 =?iso-8859-1?Q?l6LgYEZGAlE8Zm2GUY5VNmpHDPsYSXb3uQluom2lqlWJA/NM1CE5FQ7z7N?=
 =?iso-8859-1?Q?OdIR9Kke/OjNvfbo1/kV9lJPv99GrUGPYka9vdtI0cYf08eJofpCtAWuFx?=
 =?iso-8859-1?Q?9/4Qc0A3g0yZL7UnisEfcFcT3XlOHqYX4Ptr5R/yg94jr2AzdPyxkDejjr?=
 =?iso-8859-1?Q?CCNNwuljeYOgvWUiJi2PIB19FpYP0wQlbfk1nPNUXb3/joaYBU+xapjBhI?=
 =?iso-8859-1?Q?yLYwX14EedmQV4J+f5RSGa7FPQx/aYzVEuPuMu3UVGts+EzCIplZIFniDt?=
 =?iso-8859-1?Q?9wbmttjCwvQsk8LCBKP4rGGofZ+IQ3LesOfAmxOi626/tJs3wGENGKABvg?=
 =?iso-8859-1?Q?wpUgAZo6/8Xga2FA4l3W+4DfpkfWpzUV5RT/1lf8cwbpe49AA+j/jsOVO5?=
 =?iso-8859-1?Q?7+6h+4YMhtIRhWTahwpU3hmwjP+5mu/6lFJgM6zUKmvUOCU+2NrccGzBqL?=
 =?iso-8859-1?Q?OjbmUKt+D67NEMsyHgl85GLi1C1CBzyK0IbWRQ3kKO+XEAAeKVtp53a/IV?=
 =?iso-8859-1?Q?z1JXiL+ztTxexq6+/eHh9VwSFvIGlHhbl4eLoKIZVzilJTqHU0HyJjIkZ+?=
 =?iso-8859-1?Q?a8xqwxfWwBG6olyKPvDc2Gc10mgyqBs+fydBZPengUZKpdtoQW7TIaNZFQ?=
 =?iso-8859-1?Q?JuOPeK8bl7i94ZxdWVpn/BaBvqfT4gw5oFBNFy04UlbrFjO5tFVKq9A/8I?=
 =?iso-8859-1?Q?VErYFDCi2rMBkn9bjJhkgFTtDGFfVi3l09E9UkMuHKBl1+f20dvcFyk+sk?=
 =?iso-8859-1?Q?/FwQuueUArtBTFJt7e21b0RFaWtWvnYorMUvXdM2O9ZYHV/pytA/pxbBIc?=
 =?iso-8859-1?Q?aIkMTQY6MBXKx8xpR9Dokvz7rTrIjtslGKo9Gh57BDwuyx46k3llzrPelo?=
 =?iso-8859-1?Q?SHLdHnLF6guULx4HVXycP7fu2S5s75asYJZ8CezLuDNpR2xCmuc8J0eLK3?=
 =?iso-8859-1?Q?yfoCLDWwI4Cq7uOFYaDJdQioD9Q/MG7LzsCDFObPL23WvT+0c/oBCWCOSL?=
 =?iso-8859-1?Q?f1V5sAGRN8g2ird0L8Yyy3JD1RwJ5Ug1N/GFG5iMmNnFRWe46rzOPoZ0g0?=
 =?iso-8859-1?Q?vO8l/cq9BI9tMEybUsOcUzRCxpKmLQ2YyxRdUFaE4AOmpzI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I1mml5M2tNCJYSDdf9yHcxdCvQLojLJ1oEYevhQiG8ZPGaSzFqCP0OoYhD?=
 =?iso-8859-1?Q?Ko3lxRbZXTCQ+ZJ9TO84AUQGl4GJhqH3wvQL0kK6YYnjOUkQJOcbYhVdIR?=
 =?iso-8859-1?Q?F8oQDYfbsVKV0eycry2sh3ITSCX89jJ1g1lr4EImpbMke2QJLaWStZeACk?=
 =?iso-8859-1?Q?eP+PQ9Khc7JpUL3iK/ntVzLS+obtnWak7y59Hkr/Wndqs/hpZzl0aVybaA?=
 =?iso-8859-1?Q?Y9W6yqP2l0kA7I+HxXt40O9yNZNCfC/j0tYibjEPmZwGc5YJcyJtXeT9OW?=
 =?iso-8859-1?Q?WUzV1rWf2fmWF9+/wo33Xgu33GdvtV5DMGWgJYvvPC3zg2pRRXCnuvTxJg?=
 =?iso-8859-1?Q?TMfq8UI8KgyRF/672ZHUgV0qFO9YwD++5RzgfycTftEejrPtWqZkEG40Wt?=
 =?iso-8859-1?Q?ANcwM1AX2uQxpMNq14MZczKB9HZfc/f9pkBgfD/h0iB8eLjdd5snmihjAZ?=
 =?iso-8859-1?Q?+y7T10e9at8KjPj/MzcAxS/o8L/28rSxwqV+/F2Sc73SJMmTiC0OztHRAb?=
 =?iso-8859-1?Q?Lcoty4Zx6s+M26SfUaZVHcWyclPUhg/os+7JrDSgz+BnmixOGCTwiTmkgi?=
 =?iso-8859-1?Q?+yye9UalSPnyZDao4vsXX/TEt4njHYSp6xyvQ2iBwxTZ/1OX5eDjld2YNx?=
 =?iso-8859-1?Q?JgUXhfQ7YTYls2Se4uOgA8BYk0CJ4CC8G26aM1cGHNA0xLzcf+ossMQMBj?=
 =?iso-8859-1?Q?jMI3a/TpNk8VmqduEP/VpbM449ucIsv1hI1nL5AWHn8ffeEo4TnnhUf5eT?=
 =?iso-8859-1?Q?E2d0TA3QPKUVeKw4EuN2kYT3YyUuRehbiE3LxOgk7PW5rZeMO6fAMFp+W8?=
 =?iso-8859-1?Q?McNhyiU3XHzFfHP4+izuGJtfSW17hsla0+IB00beYoJlzFwWUXYIJbuMkI?=
 =?iso-8859-1?Q?kSULiW/srxgjXGfGjwDMTKgV2k/iOUjObKX+jbX15IAslF2RuELj//Dd2w?=
 =?iso-8859-1?Q?9Yq0cPgP9gWPXY9Y5RNQHd2h+He3kl3pc15oeIIw6WQuFGQln60GFXxSIV?=
 =?iso-8859-1?Q?s9tySGF0dl8WhI9uCTqFJycDSr/09z2Rd3G01MXMjm2JtV5O1PQ+P1oLLX?=
 =?iso-8859-1?Q?VWl+6GdSKJ6R7cl7+TSGiHPmZleAVm4lwYFQWNQ6Fyhj96EWTAuJZGj/l8?=
 =?iso-8859-1?Q?9UjHkjq7Tx+nU6bFTmLTwxEpncUMyCGzjEpS3XdyRrRtSrc2z4IweNv/aP?=
 =?iso-8859-1?Q?slBIwrdRNacW5QnSVTM5ZwPqCoL+KkDjZOWm6qzu4sGlEDpUPN8Vf4hp7m?=
 =?iso-8859-1?Q?YqLL42MP/Aht6SVEbsUzTH+jbd8exljaZTj63XD3Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d3e808-806a-4337-2987-08ddda5bd9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 11:23:38.5479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB3687

AMD's Zen CPUs (17h and newer) have an MSR that provides the CPU/TSC
frequency directly, instead of calibrating it against the PIT.

My understanding of the PIT calibration code is that it loops between
two and three times and takes 10ms (or 50ms) each loop, taking at least
20ms total to calibrate. This patch skips that calibration time.

Through experimentation, this patch seems to save approximately 30ms on
boot time for Zen 4 (19h) CPUs (Ryzen 7 7800X3D & Ryzen 7 7840U).

This has also been tested to not interfere with KVM guests running a
custom TSC frequency.

Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      |  2 +
 arch/x86/kernel/tsc_msr.c  | 98 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4f7f09f50552..a7e2710aa7f9 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -119,5 +119,6 @@ extern void tsc_save_sched_clock_state(void);
 extern void tsc_restore_sched_clock_state(void);
=20
 unsigned long cpu_khz_from_msr(void);
+unsigned long cpu_khz_from_msr_amd(void);
=20
 #endif /* _ASM_X86_TSC_H */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 87e749106dda..9acb7d13719d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -911,6 +911,8 @@ unsigned long native_calibrate_cpu_early(void)
 {
 	unsigned long flags, fast_calibrate =3D cpu_khz_from_cpuid();
=20
+	if (!fast_calibrate)
+		fast_calibrate =3D cpu_khz_from_msr_amd();
 	if (!fast_calibrate)
 		fast_calibrate =3D cpu_khz_from_msr();
 	if (!fast_calibrate) {
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 48e6cc1cb017..bea62f8f1eb1 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -234,3 +234,101 @@ unsigned long cpu_khz_from_msr(void)
=20
 	return res;
 }
+
+/*
+ * MSR-based CPU/TSC frequency discovery for AMD Zen CPUs.
+ *
+ * Return processor base frequency in KHz, or 0 on failure.
+ */
+unsigned long cpu_khz_from_msr_amd(void)
+{
+	u64 hwcr, pstatedef;
+	unsigned long cpufid, cpudfsid, p0_freq;
+
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
+		return 0;
+
+	/*
+	 * This register mapping is only valid for Zen and later CPUs.
+	 * X86_FEATURE_ZEN is not set yet, so we just check the cpuid.
+	 */
+	if (boot_cpu_data.x86 < 0x17)
+		return 0;
+
+	/*
+	 * PPR states for MSR0000_0010:
+	 * The TSC increments at the P0 frequency. The TSC counts at the
+	 * same rate in all P-states, all C states, S0, or S1.
+	 */
+
+	/* Read the Hardware Configuration MSR (MSRC001_0015) */
+	if (rdmsrq_safe(MSR_K7_HWCR, &hwcr))
+		return 0;
+
+	/*
+	 * Check TscFreqSel (bit 24) is set.
+	 * This verifies the TSC does actually increment at P0 frequency.
+	 * E.g. VMs may be configured to increment at a different rate.
+	 */
+	if (!(hwcr & BIT_64(24)))
+		return 0;
+
+	/* Read the zeroth PStateDef MSR (MSRC001_0064) */
+	if (rdmsrq_safe(MSR_AMD_PSTATE_DEF_BASE, &pstatedef))
+		return 0;
+
+	/* Check PstateEn is set (bit 63) */
+	if (!(pstatedef & BIT_64(63)))
+		return 0;
+
+	/* CpuFid is the first 8 bits (7:0) */
+	cpufid =3D pstatedef & 0xff;
+
+	/* Values between 0Fh-00h are reserved */
+	if (cpufid < 0x0F)
+		return 0;
+
+	/* The PPR defines the core multiplier as CpuFid * 25MHz */
+	p0_freq =3D cpufid * 25;
+
+	/* Convert from MHz to KHz before dividing */
+	p0_freq *=3D 1000;
+
+	/* CpuDfsId is the next 6 bits (13:8) */
+	cpudfsid =3D (pstatedef >> 8) & 0x3f;
+
+	/* Calculate the core divisor */
+	switch (cpudfsid) {
+	case 0x08:
+		/* VCO/1 */
+		break;
+	case 0x09:
+		/* VCO/1.125 */
+		p0_freq =3D (unsigned long)(p0_freq * 1125ull / 1000);
+		break;
+	case 0x0A ... 0x1A:
+	case 0x1C:
+	case 0x1E:
+	case 0x20:
+	case 0x22:
+	case 0x24:
+	case 0x26:
+	case 0x28:
+	case 0x2A:
+	case 0x2C:
+		/* VCO/<Value/8> */
+		p0_freq /=3D cpudfsid / 8;
+		break;
+	default:
+		/* Reserved */
+		return 0;
+	}
+
+	/*
+	 * TSC frequency determined by MSR is always considered "known"
+	 * because it is reported by HW.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return p0_freq;
+}
--=20
2.47.2


