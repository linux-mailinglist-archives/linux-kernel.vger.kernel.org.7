Return-Path: <linux-kernel+bounces-774836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887AB2B837
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A91D1769A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7E621D3EE;
	Tue, 19 Aug 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="ixFLrZ9U"
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22812B73
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576104; cv=fail; b=AzvuJ9u2jA6CzLwQjWYxL71MsW9NpXbA0avzjs4H4991RldTBhCqVXl8YF6EbCEvQzSiSOu4bvTEzieFKE3S3+G9oikAIrnlRzAZLs43R9Srxot1pL3qJWXXHCRcniMgo0jFtceh/0WONjrfnzQcfSMr84ZSdH9X/gGkfgC3FFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576104; c=relaxed/simple;
	bh=AfppHicbhvvkoiUT1i6ESPvNECs8W97HeRtawQxGBHs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RyXN2DaxA7vZDBwzkD0003eE93u8l0b6rHpgl2pWATBWOHYz2AkSCJNPVx+n+eEus2raxSIzIP0rapCKquUZ1EQmBRV/I5kH+oaQm2+n6PzQDuLuHUDZXJ3uqXsqt12enJEYnUUEzDy+ePvJFknEyeWnJCIqWi/Z0Ft4WjLJu0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=ixFLrZ9U; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+Od10Vi6D4BqfgIPfECEib1QrAYGOlMyPCqyqHptBXxsTMNL34k1pZowxOkhQQ4Pj8wI2ckhRuAT5D9qkxpKaILsINnjsxxo0HYIW59uM6tTcO0NoumW3QI4OyFfX1Pz9zMVRezkczMCXL9H5wEhy+swT40MT8ADj/QDr7uU9Izjr7AEcXZVvgrDscc13wZB2McA5nDSxKdD5rap/5RnPjm6mqjF64nxA/1QOSmzFXUIvc0vQ72TtIDLIMD5AlljjTxd+azVkv48LsKxVbj2hr1qq59PfVWDi69mvlGcmpYrCFHIxg0RJqtDky/dTVov9sd3p3DjPUMm5XMM8VQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrTJwyIIF1J3ZX+td37rRaAeqmsbBsybN+QkE1/vPiI=;
 b=J+NOTDJprXQcj0Go2MobXKLSDyoptjUAbxh6q4d9585W1FA0jHNPXJ+dH7eZ1G1TcnxHd/IUZoyufFj1e4Az0aQ08JAVpJIIx9RlteqamydzZdLdUezrxcSbVbp7PcR3MtkJAvgo8hZ95aFpdHz6G1Wqgy/bphn8GJL+8rCtVFJpnQA8AJCPBHJvCZ1OYmT4xA0CW46/ZoY9i/zppYExAUebqg4leViGu1Qke8gMW9xffsVVsFLc0VHym8bV1WhAPq66TweF+KVSYEyAH+DhBphR2Qb6FKb+bo4H/xH31W9Smm//RkRQTcOpvNJgID9L1fejcp9Rp+3mBcHDpHpTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrTJwyIIF1J3ZX+td37rRaAeqmsbBsybN+QkE1/vPiI=;
 b=ixFLrZ9U2YUtHnaBTjjbCi0AmZXNkosrQl1RF35N+dwH60OJ8MFQnd9Nx4jT0IcchqHtEFXLWk3QQzOO6ZuvN+gH+90z4+2Kpb/TlhzokQeWz5J2z0PmltYXGjfHhXuPcX/nGIUXXgPTQq76ZnXxTNX9uULSFFhdKsT5aQeodNcQbl/cBXUszgrX5f17UPaNTV5MADen/rJ28WV+SHPr/jFgvpVC27CphQJHvHb4fYNHQqj+/x2zTCAIjZMyzz4WcRrCuLDXBw8eytLumax4f/HqGNcJC06/Onn81OhYCHpWhqqECVjj+MAeSrYXuScvFYMKfsKzuFhnW8Hmy9sCXw==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY7P282MB4348.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:277::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 04:01:37 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 04:01:37 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH v2] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Topic: [PATCH v2] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Index: AQHcEL31HDGlgvUC90yE3ejb6MQszg==
Date: Tue, 19 Aug 2025 04:01:37 +0000
Message-ID: <20250819031121.148616-1-s.horvath@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4P282MB3063:EE_|SY7P282MB4348:EE_
x-ms-office365-filtering-correlation-id: 1ac7c006-6342-4369-c6f4-08ddded51857
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|461199028|41001999006|8060799015|8062599012|19110799012|38102599003|3412199025|440099028|40105399003|12091999003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Pm7E6t56zb8d/mzRRPEBtwWuQ9alTFu3bH1Kbv8dJkfpJgMhP1KOogSmug?=
 =?iso-8859-1?Q?l4b2rIlKjSSXaalGqccvMm7riJGs4QIA2JvcNJ8Tvvbv7zrennCDK6Vg4c?=
 =?iso-8859-1?Q?Uq28PvDdh04XL755SL/fe6qPKJ/i7ini+QiW0qmMGF9VOsyoYt3dXb3ite?=
 =?iso-8859-1?Q?+7+IbhZ0tyAdOej8EXN0oZWJ8r7VDLU+QV+OdAfSZHIkR6sIDifPtPkvC/?=
 =?iso-8859-1?Q?o6EfJTg+U5L3N86RXs2Ul9ryXpEw1DTj+E6ZDKMa21TbK6/2MYuQgTJzI9?=
 =?iso-8859-1?Q?TI3b9hB2EErWRcXYYr1Qk2frKx0iF+ThFBYuQITatjkCXT4eomKSbfSgGJ?=
 =?iso-8859-1?Q?vx6po9d0xa0zvEot26XilzX6Px/kmt3osQSEIF83TaVtKSjLv+ChXVuiuz?=
 =?iso-8859-1?Q?nMlC6NdPo/Q65FhZYP+IjiBDalIWfrX7m+2E23yEuBSFnwUWqZOzFKCJY6?=
 =?iso-8859-1?Q?AaepQG5i3k/PfuspQjpyHTXAUtOBPjx2/KXu1rRGeVPLAHqQiD0hLRykaY?=
 =?iso-8859-1?Q?9xbAobk+H3YBVZDPeMSn8TyJWprodNCS8w48w6aS+g0+dGXoEyLlhd8hR/?=
 =?iso-8859-1?Q?xDljrEHXkA1AVBjEcjxuY+hlTid1hv5l/0+w6e5uboCtMEHiGR6vVu8061?=
 =?iso-8859-1?Q?KznRCl6PXU8OTH2eHSG+K/TyJQysC560EurQaxQJoOX8b7mWVhtF+qNWl0?=
 =?iso-8859-1?Q?WztkdhBuiQGi8YAr27sEaHXesNOfG0ARTcmFsK8hk55uQhi6dn+qTV6iEI?=
 =?iso-8859-1?Q?aOR6Vg9j81AKHLLXnamYuc1hlvetJs1j4VxVrW73JtDHABMZ7HFM3FrK/M?=
 =?iso-8859-1?Q?PUNkuL+ZJuydUZbAlOqsBgGn44bJwPGvD0I8iATbD9MpRd68SE1tiZVOq7?=
 =?iso-8859-1?Q?iSwN8PCFG27QbYHgW6A5Ki6a6o1fP3awKF6vrJiKCQjHeHWwn0TAuzOn9l?=
 =?iso-8859-1?Q?PLRQY4NF09ts5MZrRc6S0iazZQ3JtnmFroXWm8w6TdVHo+Rw75Y82wqLXg?=
 =?iso-8859-1?Q?H1JR5ydA+QTqWALfNboQFmMs8p38B4T4e6siF3Fn4vNQBlZs35TlkTVrqW?=
 =?iso-8859-1?Q?P2EVzHHj8m5zzJ5NnI0fNdMuGm2zsHEldMcLVPMZlZyW1vlCewK7TN0jeG?=
 =?iso-8859-1?Q?vlqjXymX1qdCwgxS20+HounfwYyK8rhcEmTZEMu48en2z5+3LrMTQ8QTNy?=
 =?iso-8859-1?Q?Qlvvcjk93dqxFGNqWzaVT9YScjeqDwFwEuq6qPDY/CD05s5SXVhKTTOwti?=
 =?iso-8859-1?Q?y/2bkcfAB2J0Noo4JyDa8kTww+T4QdYWfgH8Hd5m00r14qWO88GGXG3hD9?=
 =?iso-8859-1?Q?SOmsMY+yPxuaT+yId9Zpsw0Oog=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7+kGN8Vb2yxdL0ejcjDXuG1GoErJsDOhtNsgFX3OlGNAph+D7J4w4bPxmF?=
 =?iso-8859-1?Q?LLBWlEW21SFIpqU1qC929pBHznVg91XCWDRgfaA8oEdZqMf5aFi5ovra4N?=
 =?iso-8859-1?Q?8wH+k/8PAw2tMAu3lJBfbZzNPQSPeEUa7q6TJkTp2wAvOqKklIGyi/8qQX?=
 =?iso-8859-1?Q?VlMWMnxFuCOedcRMqqc2NkfKe5ZycW/UjpvzUS+ZOtF3GTtYRa1ruO94K0?=
 =?iso-8859-1?Q?dU+bx3NKt2ZzhERGPSPJdThHvAg6iMfxRybjMOig4GGDuCjzNP1ymE0VW3?=
 =?iso-8859-1?Q?x8blpByeuVZ91wo1y9f7o5BsLNzELaAkamXLjkd10xTse0Vw+kHIjCy66L?=
 =?iso-8859-1?Q?LccIkSHmrXUra6pUekBLl2h40tYKSrZev6VM+LSNXNuOr1WfRChqIs2DYS?=
 =?iso-8859-1?Q?GcNfuEZgZYn2ZxHfoqOKGiHTtg5AGCoaLer3E2kzhMr3+cmxgjqyz2tiJb?=
 =?iso-8859-1?Q?5ka1PtUMjEm2Vd0ZOhMqRE4JFOJ9px4WnnJ0mg9t343HvXt9mq4DnhAso8?=
 =?iso-8859-1?Q?/+p0pGxkoG3Axk/T7QNmEAp3l6fXZH36FtWTCbPNzhNKH4rF1ZiF7eSQWc?=
 =?iso-8859-1?Q?enQrDhcOFl65xaAHWcY02jH4q+EwBhfnmXK1VHI9PRzRB9fds4fpFsWGF0?=
 =?iso-8859-1?Q?/etR/aNWq6D31ZSEvNo7ZsQ7QnSLMgPUExjTdC3WQEi2YNtmgAPMfIzzh3?=
 =?iso-8859-1?Q?81jpkUtJu0AbUh6rVB3NNL4iWA3wFup/oAIlvyBHor3qFFzF7I7pUPY4kG?=
 =?iso-8859-1?Q?9P6RrBLA9BGyIFmFex/ONe51ZfleJB4UkHLYoulmXae0MyyVKZMKloGYW6?=
 =?iso-8859-1?Q?GORJ4Qjg/XRRNEqg3e8yc7Fc1lcLITZERVp5mEZUzZHGtOfOsfMV4n56Bz?=
 =?iso-8859-1?Q?ZuyD4O36/KvI2P3SpF0VJQVqVfRAi0b81yrPqGB95zSnufUIEf6WP4Tm/Z?=
 =?iso-8859-1?Q?Ae/ghZO3Yxu5ldSDbuim67bwc7OoB8+xz75t3Wanrc1JsbrLFXP9p4yBYp?=
 =?iso-8859-1?Q?LsRi/ywJRtRE1BGYhk7/bBLj6zZKxIQoUzfP4e+HaNk2YWwkYIH1kPir2x?=
 =?iso-8859-1?Q?l3qsacOwKjRDq+l7FgEvEBHif6ucEf5n0WSn5Ddlz4/daq07+VkduQlrA2?=
 =?iso-8859-1?Q?/C9RrcqnDV1nDMnWYhEhI+O1//S1Wi/TQfHd5jjCyq3Hmj4D7KeU2wOud7?=
 =?iso-8859-1?Q?ibmCZnRPtg5K1eNSoYaHfR3W+APH6CP3WoZVpIB7GfzmpCt5tMTRdwoqem?=
 =?iso-8859-1?Q?x4TYWZejkj/H5uc+4Brz8P6SjHwxgfWGVN+youbj8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac7c006-6342-4369-c6f4-08ddded51857
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 04:01:37.3715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4348

AMD's Zen CPUs (17h and newer) have an MSR that provides the CPU/TSC
frequency directly, instead of calibrating it against the PIT.

My understanding of the PIT calibration code is that it loops between
two and three times and takes 10ms (or 50ms) each loop, taking at least
20ms total to calibrate. This patch skips that calibration time.

Through experimentation, this patch seems to save approximately 30ms on
boot time for Zen 4 (19h) CPUs (Ryzen 7 7800X3D & Ryzen 7 7840U).

This has also been tested to not interfere with KVM guests running a
custom TSC frequency.

Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
v2: Introduce per-family checks

 arch/x86/include/asm/tsc.h |   1 +
 arch/x86/kernel/tsc.c      |   2 +
 arch/x86/kernel/tsc_msr.c  | 118 +++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

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
index 48e6cc1cb017..f692b2d0590c 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -10,10 +10,14 @@
 #include <linux/thread_info.h>
=20
 #include <asm/apic.h>
+#include <asm/bitops.h>
 #include <asm/cpu_device_id.h>
+#include <asm/div64.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
+#include <asm/msr-index.h>
 #include <asm/param.h>
+#include <asm/processor.h>
 #include <asm/tsc.h>
=20
 #define MAX_NUM_FREQS	16 /* 4 bits to select the frequency */
@@ -234,3 +238,117 @@ unsigned long cpu_khz_from_msr(void)
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
+	 * Families newer than 0x1A haven't been released yet.
+	 */
+	if (boot_cpu_data.x86 < 0x17 || boot_cpu_data.x86 > 0x1A)
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
+	switch (boot_cpu_data.x86) {
+	case 0x17:
+	case 0x19:
+		/* CpuFid is the first 8 bits (7:0) */
+		cpufid =3D pstatedef & 0xff;
+
+		/* Values between 0Fh-00h are reserved */
+		if (cpufid <=3D 0x0F)
+			return 0;
+
+		/* The PPR defines the core multiplier as CpuFid*25 MHz */
+		p0_freq =3D cpufid * 25 * 1000;
+
+		/* CpuDfsId is the next 6 bits (13:8) */
+		cpudfsid =3D (pstatedef >> 8) & 0x3f;
+
+		/* Calculate the core divisor */
+		switch (cpudfsid) {
+		case 0x08:
+			/* VCO/1 */
+			break;
+		case 0x09:
+			/* VCO/1.125 */
+			p0_freq =3D mul_u64_u32_div(p0_freq, 1125, 1000);
+			break;
+		case 0x0A ... 0x1A:
+		case 0x1C:
+		case 0x1E:
+		case 0x20:
+		case 0x22:
+		case 0x24:
+		case 0x26:
+		case 0x28:
+		case 0x2A:
+		case 0x2C:
+			/* VCO/<Value/8> */
+			p0_freq /=3D cpudfsid / 8;
+			break;
+		default:
+			/* Reserved */
+			return 0;
+		}
+		break;
+	case 0x1A:
+		/* CpuFid is the first 12 bits (11:0) */
+		cpufid =3D pstatedef & 0xfff;
+
+		/* Values between 00Fh-000h are reserved */
+		if (cpufid <=3D 0x00F)
+			return 0;
+
+		/* CpuFid: <Value>*5 MHz */
+		p0_freq =3D cpufid * 5 * 1000;
+		break;
+	default:
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
2.50.1


