Return-Path: <linux-kernel+bounces-885867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF8C34145
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C77466566
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80F2C0F79;
	Wed,  5 Nov 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="XyVAmAq6"
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012009.outbound.protection.outlook.com [52.103.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67D27F017
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325038; cv=fail; b=ai0AE6aLtIuAm0740LzgeZFHnZdf2Msnugo6Bvm/TUKz8riSjH6sukkvjrNXNCA0lPF2QNxYiDO2cLATjPHQOKTqlIkE7Q2bMTHwYRgdxLDOoeEUyMigN7LKhftqhH7p017M1XKIrtrsl9T0UpWMJj7DJduj225QvVkS8NdeLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325038; c=relaxed/simple;
	bh=tjd6XQlUypPmzo+vF8z0Otd+kuZgFhcMGH6+WU9uwe8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fn4KXp5L0RArR/DevrgHrRuMe9nXO+uU1xIOVzefDQJMGc7djuu32b+Eaaw8nr75PafEKiROoIAL8soZQEZgaUp2lqlHqd7Kwa3jojpfiwRa4mybAA57aQkR97q8JXbXfbAivGU87I01QoVb07OfVM3/pThqj84GoX8u/czjknk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=XyVAmAq6; arc=fail smtp.client-ip=52.103.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7wPpxvfMgXUFAal12JJxcrUR26o2Sd7YxAdxpzehsUNTDjBkZwQEXPEHL6TFEI3TeHkkwJpFAQXgwPuwZNipWiEgvjrej52uYSw7AZXHk6bEY8nD+ypJ+9GO04on9oNJXevLkK7Yf7XM5IYP/ZXQKt+NQqGF8ldMmdedoV5WcbcVoq08b96xT/3VLlXVgaZPcupfFhlloCkas+rqj7Q1YP5R8jJEwI2Pe6ED9NfPtumZJhEwSnJYfGoCqQ5hDo6vt079BSJD+AlyKbt7zC2tGxruMxm7RqLoxxaWyaX+7wrl5XdMJQB84VoO/zmTMroyJ31GZ/CqaOmOWIcvZmVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/+3BiZ+zXkR39Wt45AWHJWIo33siTF0Hrh6w/MqRKo=;
 b=RhscFlDptbYVTzLfhqJiOcq6L8dWja/u6UB/kbS/yWLJjpZQYa8Ehh3hWgQgHaJHpTPqx9orj2wRCE3CxE1gMWzP14c2yqgApV44hBDZ/CHVTr/LDcdxiQHEjA2WSdhQjrTBb8erMp2LKAaYILWIUy708xZb4IXT7+/d0fjYktlre7vkveo4vvglMHXomZHH33jR46oMlsp8XMWQrrlWEBYA4rOS3u/WlwkBwr8iHos1wt0BddpJ0eu2gdLVv37xPC5aQQa7xPf/I0e2pfYFXl2ZclR6wxEWIv+Av4VLhtD6QqGwl8cE2TXdwbAUkdZg4oheqEuECGAvTIeml4bBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/+3BiZ+zXkR39Wt45AWHJWIo33siTF0Hrh6w/MqRKo=;
 b=XyVAmAq6vABZaX8MS3fNu5SwXf1kp6xMVO8omlBsO3measkUmi08cVE2vceh9NEW9k8mvAr9IEMSl7plkpkP3bGeWpVS69X7WbUE4dtbNvwiOygXaOydbA8QXBqDYPaFD+zkvW1qJRKcM5oXupJ5BWJWFsFnFwTk66wbM86f6kjCXT3rCggYsvFh6O+KNoAGvhqBW1Qhs8t9FY0JwvPbkX6EffC6AgVBo+Y/PdiRGazpGabNVRWbyj1lQ7mbab9lop9qbRcdKYyWdWrplmScqrAvWGcRgW75cYVlcnQYfGBvyyz6AB7uQ9KTeP9V63pYmDl5TEeV92DLFKXFj8YXNg==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by ME3PR01MB6450.ausprd01.prod.outlook.com (2603:10c6:220:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 06:43:52 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::630e:e55b:4105:c99b]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::630e:e55b:4105:c99b%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 06:43:52 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH v2 RESEND] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Topic: [PATCH v2 RESEND] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
Thread-Index: AQHcTh+MoqnZmviSB0mexMmzdBL2nw==
Date: Wed, 5 Nov 2025 06:43:51 +0000
Message-ID: <20251105064231.220065-1-s.horvath@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|ME3PR01MB6450:EE_
x-ms-office365-filtering-correlation-id: 2c9a0d20-90e2-4dc2-4fb3-08de1c36aeca
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|38102599003|31061999003|8022599003|15080799012|461199028|19110799012|8060799015|41001999006|8062599012|102099032|440099028|3412199025|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zYfSjROLqx+wiWJd28H4OuxeuzE8UnXn0GCSRbvhyy3eWi6KhOOiwVZMd1?=
 =?iso-8859-1?Q?/o3smgf5xVihvEttFd6bxfLtvbSDHpJkG2UJ62aIBaf5dIjev3zAxKL5i3?=
 =?iso-8859-1?Q?1koZObGLBp6Y6qP9fO+CDTICZ1h7RG/FbruwhoyRGdp/3tNJ5a332amMJA?=
 =?iso-8859-1?Q?/kMimp0h9dFiOiUUcRmZwQC1m1N6/ij0baXtuzOlNJZ0H+kfL1FowtkHgQ?=
 =?iso-8859-1?Q?j+37N7aGaep0p8XSSmzaNppGt3EP3hew77gyhm/a1JF2WF5d/0hI6s1n4s?=
 =?iso-8859-1?Q?R1NfOxpE/PnoGoE0yRwObZ/VpHAkZH/qU+T+UdZH1/FAiIp6HgQ1pBn88/?=
 =?iso-8859-1?Q?9tr4QBtK2b9S1WKGudbx4PZQ4v8CElnhMTnPCaMEivzTXYeDDGz4LaUfl3?=
 =?iso-8859-1?Q?0FPH1pfEVyNS5xtdD/3DOCSjtq4VvIESy3EuR0x+U4CQ7x+QjFpD90Daud?=
 =?iso-8859-1?Q?+xCL9AY0LsphI4N6LWBif6vVGHCm1chCMsfVnBs6LHXoHCBexwUCKUqebb?=
 =?iso-8859-1?Q?84rXKBS0fUxXp/2eFsAjuzBesA2BTAKihEJSsUTtHfJLItb+iD2Q/S+np4?=
 =?iso-8859-1?Q?4onlTXK9lBUVpdbKPzMdJZ9MjBKKW7CRpa9j79LUf2LsC2xXCRlCjvHOuv?=
 =?iso-8859-1?Q?wOHZSOqh92gG1vWWEgksF98rinseDyUr48D8FZCgoE2g1QHNe04m+mrimK?=
 =?iso-8859-1?Q?M0wD2EZplmVDf6P8DjOkaRKb4tXQpRrg67oq/KF2+r+kDdPhhA4Joe5puY?=
 =?iso-8859-1?Q?f6sqlVhR8trNcVENfwjhT/gS0tPkC2hJGEH0aNCRW0ImFnFP+fQGnka8n2?=
 =?iso-8859-1?Q?Tjk6M7UTm4NuHVGwaQIdrN6pEbCRwMuFciCv/uqqiXC0jPVNqbRuw9ogiG?=
 =?iso-8859-1?Q?eDhQD6T/r2TvNyEjqnOJPQQPiokF1xMrmiFiIMn8GHqNf4OzsVYVbw8nsb?=
 =?iso-8859-1?Q?OvrmD524wPyG+pDVOFCZg7qTvntLvZxfzpmJHNFr8DD6RO+kGIiF/GVXPb?=
 =?iso-8859-1?Q?UypDNsrx9kPC+EA29NlROhMWY96OV2rmtfJuyK499GVSMy0PZo3b2hDkF8?=
 =?iso-8859-1?Q?ZKrvsjHB8oykgSmjrh3vOk8FmEweOCD4jdiq0aCI5QCE6NfzlgYJxT9FPk?=
 =?iso-8859-1?Q?Sfeww5ULyNoOddIBsbOd36z9GsUWCXseqEP8ctMl7bmo0uxJMgIk0JLiKu?=
 =?iso-8859-1?Q?6RBYczNzLN+bxjK/6fsVl6wQ3D+BXpUYJ3YOhr45Pi4aorS8XIq+mxFytT?=
 =?iso-8859-1?Q?MzLCcATyZMhI9fDK3T2zGOhsgmETjabE+4LxShiTtrRpLF25Q5UUo0g2v8?=
 =?iso-8859-1?Q?o6jQsV+QrEeMnYaTy6xyhRIeKAAeIebj++Nxxw2NQiOy/DA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iG1W7YGD5xJQuXXRmVV3wJOHdhJI4rsFrN1Y6+bYoREho5aJgoocCTZUgU?=
 =?iso-8859-1?Q?qyrONMtwHb1lHvqfy4d0/zDMxmx9v9VhSooT2PvM0QQk9nnPVpMG5a+/oS?=
 =?iso-8859-1?Q?Lp8eU3eZGwaXmGgbInLWs7tsv3OqfsgXt67GicVLzj9WHodkIgNGVECC/W?=
 =?iso-8859-1?Q?7ZBwAL0+wtqhOIYca1NEp1+8yxkXihOUAFJdQURdzXSlB6Y9QVLi2Wdbjs?=
 =?iso-8859-1?Q?ZT2rai90MQod/LPasAEhsqE49yx3N8JPLMce6ujTQWOMX4xOGODadSOyz2?=
 =?iso-8859-1?Q?yxpU+Md2BmdCP/ENu+xpUW/hAmxldH4ZcYgsRSSmo5AlHEcHxF0kz08Nd3?=
 =?iso-8859-1?Q?tj3le4ogxIgb8ge2Gsl7CTK6nETkSnmAkil1pktZebKI2QrlLow6M2+Zz2?=
 =?iso-8859-1?Q?mCs6EOpchz/WpFTqhcDjZjAjGEtGYf//lBnbTZI+2akwUDmlVSrJjEleO/?=
 =?iso-8859-1?Q?yR0DHZmqG3RFRDKqKeOz4IEzx/q9yBKalFY6yk8AKYNjJAz9ffvEbC8FO5?=
 =?iso-8859-1?Q?xoGKYoAmXXLTDsLff+vqFHnrBAYxgt4WGQ8eOs0oLcl82fNIBpmIiJ8Jhw?=
 =?iso-8859-1?Q?Xhnc1TETys5s41r875gjjaoEyWEwzx036RN8JO1qRLraLErkSohvUAwyKV?=
 =?iso-8859-1?Q?YWa5nAwXys9tmMx5a5xungH+O3VwcVHgvxjyVCxH8cgkDCkeLPbCmnvjLa?=
 =?iso-8859-1?Q?luw4mHBl3ULKYUMyaEENLreUb8cXI5PUrkKXAwNt14parEQN+R/LOxuaYI?=
 =?iso-8859-1?Q?mwCNtl2LizsQlxyRjMlJxbbyXjw2VnbU2TMFl3AzLpOOyA4mahI+d8T1hd?=
 =?iso-8859-1?Q?2g8+AtQrqyGwjc7ZncZ98/+2V+X/f+AFu9dRMmgkFFnCf/AYB4rP7wnEq3?=
 =?iso-8859-1?Q?Y48Y1XTs743ivONibSq3KG1lq4t5aGCp8PQfi30ycTWF+hCu9nesygXq+n?=
 =?iso-8859-1?Q?CWPOkAesrQRy9x+tPJZ1iriRBrbCDmzRXnvNZOateoKp4GN/EI3OfnG+xf?=
 =?iso-8859-1?Q?CMZ3T50a8Y26xaeOCbu4O3/eMjmQqrHonw/zstFg5CpUEpOMAI6g5YbrYN?=
 =?iso-8859-1?Q?WQHoZYLixUUvWs6OQPU7lOoIlpXFz2bUuYplujnhQlPq1A6Wo0A9GvWtEw?=
 =?iso-8859-1?Q?4bjPE85/OnIdp3f/hrY5tpprZNRHqBakXUJp6/nkcUZmLSCrZAQPZtzNES?=
 =?iso-8859-1?Q?OuAMx6Nfg0Tjf8qDeNLTZnEQObWCKj5AbVAZNTtHqM0qHTikhdYQ46ddvA?=
 =?iso-8859-1?Q?3vKbs05ue0/89FMistBHXu9jXgmg3uQTvzb2NNHLI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9115-0-msonline-outlook-64061.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9a0d20-90e2-4dc2-4fb3-08de1c36aeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 06:43:51.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6450

AMD's Zen CPUs (17h and newer) have an MSR that provides the CPU/TSC=0A=
frequency directly, instead of calibrating it against the PIT.=0A=
=0A=
My understanding of the PIT calibration code is that it loops between=0A=
two and three times and takes 10ms (or 50ms) each loop, taking at least=0A=
20ms total to calibrate. This patch skips that calibration time.=0A=
=0A=
Through experimentation, this patch seems to save approximately 30ms on=0A=
boot time for Zen 4 (19h) CPUs (Ryzen 7 7800X3D & Ryzen 7 7840U).=0A=
=0A=
This has also been tested to not interfere with KVM guests running a=0A=
custom TSC frequency.=0A=
=0A=
Cc: Borislav Petkov <bp@alien8.de>=0A=
Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>=0A=
---=0A=
v2: Introduce per-family checks=0A=
=0A=
 arch/x86/include/asm/tsc.h |   1 +=0A=
 arch/x86/kernel/tsc.c      |   2 +=0A=
 arch/x86/kernel/tsc_msr.c  | 118 +++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 121 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h=0A=
index 4f7f09f50552..a7e2710aa7f9 100644=0A=
--- a/arch/x86/include/asm/tsc.h=0A=
+++ b/arch/x86/include/asm/tsc.h=0A=
@@ -119,5 +119,6 @@ extern void tsc_save_sched_clock_state(void);=0A=
 extern void tsc_restore_sched_clock_state(void);=0A=
 =0A=
 unsigned long cpu_khz_from_msr(void);=0A=
+unsigned long cpu_khz_from_msr_amd(void);=0A=
 =0A=
 #endif /* _ASM_X86_TSC_H */=0A=
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c=0A=
index 87e749106dda..9acb7d13719d 100644=0A=
--- a/arch/x86/kernel/tsc.c=0A=
+++ b/arch/x86/kernel/tsc.c=0A=
@@ -911,6 +911,8 @@ unsigned long native_calibrate_cpu_early(void)=0A=
 {=0A=
 	unsigned long flags, fast_calibrate =3D cpu_khz_from_cpuid();=0A=
 =0A=
+	if (!fast_calibrate)=0A=
+		fast_calibrate =3D cpu_khz_from_msr_amd();=0A=
 	if (!fast_calibrate)=0A=
 		fast_calibrate =3D cpu_khz_from_msr();=0A=
 	if (!fast_calibrate) {=0A=
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c=0A=
index 48e6cc1cb017..f692b2d0590c 100644=0A=
--- a/arch/x86/kernel/tsc_msr.c=0A=
+++ b/arch/x86/kernel/tsc_msr.c=0A=
@@ -10,10 +10,14 @@=0A=
 #include <linux/thread_info.h>=0A=
 =0A=
 #include <asm/apic.h>=0A=
+#include <asm/bitops.h>=0A=
 #include <asm/cpu_device_id.h>=0A=
+#include <asm/div64.h>=0A=
 #include <asm/intel-family.h>=0A=
 #include <asm/msr.h>=0A=
+#include <asm/msr-index.h>=0A=
 #include <asm/param.h>=0A=
+#include <asm/processor.h>=0A=
 #include <asm/tsc.h>=0A=
 =0A=
 #define MAX_NUM_FREQS	16 /* 4 bits to select the frequency */=0A=
@@ -234,3 +238,117 @@ unsigned long cpu_khz_from_msr(void)=0A=
 =0A=
 	return res;=0A=
 }=0A=
+=0A=
+/*=0A=
+ * MSR-based CPU/TSC frequency discovery for AMD Zen CPUs.=0A=
+ *=0A=
+ * Return processor base frequency in KHz, or 0 on failure.=0A=
+ */=0A=
+unsigned long cpu_khz_from_msr_amd(void)=0A=
+{=0A=
+	u64 hwcr, pstatedef;=0A=
+	unsigned long cpufid, cpudfsid, p0_freq;=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * This register mapping is only valid for Zen and later CPUs.=0A=
+	 * X86_FEATURE_ZEN is not set yet, so we just check the cpuid.=0A=
+	 * Families newer than 0x1A haven't been released yet.=0A=
+	 */=0A=
+	if (boot_cpu_data.x86 < 0x17 || boot_cpu_data.x86 > 0x1A)=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * PPR states for MSR0000_0010:=0A=
+	 * The TSC increments at the P0 frequency. The TSC counts at the=0A=
+	 * same rate in all P-states, all C states, S0, or S1.=0A=
+	 */=0A=
+=0A=
+	/* Read the Hardware Configuration MSR (MSRC001_0015) */=0A=
+	if (rdmsrq_safe(MSR_K7_HWCR, &hwcr))=0A=
+		return 0;=0A=
+=0A=
+	/*=0A=
+	 * Check TscFreqSel (bit 24) is set.=0A=
+	 * This verifies the TSC does actually increment at P0 frequency.=0A=
+	 * E.g. VMs may be configured to increment at a different rate.=0A=
+	 */=0A=
+	if (!(hwcr & BIT_64(24)))=0A=
+		return 0;=0A=
+=0A=
+	/* Read the zeroth PStateDef MSR (MSRC001_0064) */=0A=
+	if (rdmsrq_safe(MSR_AMD_PSTATE_DEF_BASE, &pstatedef))=0A=
+		return 0;=0A=
+=0A=
+	/* Check PstateEn is set (bit 63) */=0A=
+	if (!(pstatedef & BIT_64(63)))=0A=
+		return 0;=0A=
+=0A=
+	switch (boot_cpu_data.x86) {=0A=
+	case 0x17:=0A=
+	case 0x19:=0A=
+		/* CpuFid is the first 8 bits (7:0) */=0A=
+		cpufid =3D pstatedef & 0xff;=0A=
+=0A=
+		/* Values between 0Fh-00h are reserved */=0A=
+		if (cpufid <=3D 0x0F)=0A=
+			return 0;=0A=
+=0A=
+		/* The PPR defines the core multiplier as CpuFid*25 MHz */=0A=
+		p0_freq =3D cpufid * 25 * 1000;=0A=
+=0A=
+		/* CpuDfsId is the next 6 bits (13:8) */=0A=
+		cpudfsid =3D (pstatedef >> 8) & 0x3f;=0A=
+=0A=
+		/* Calculate the core divisor */=0A=
+		switch (cpudfsid) {=0A=
+		case 0x08:=0A=
+			/* VCO/1 */=0A=
+			break;=0A=
+		case 0x09:=0A=
+			/* VCO/1.125 */=0A=
+			p0_freq =3D mul_u64_u32_div(p0_freq, 1125, 1000);=0A=
+			break;=0A=
+		case 0x0A ... 0x1A:=0A=
+		case 0x1C:=0A=
+		case 0x1E:=0A=
+		case 0x20:=0A=
+		case 0x22:=0A=
+		case 0x24:=0A=
+		case 0x26:=0A=
+		case 0x28:=0A=
+		case 0x2A:=0A=
+		case 0x2C:=0A=
+			/* VCO/<Value/8> */=0A=
+			p0_freq /=3D cpudfsid / 8;=0A=
+			break;=0A=
+		default:=0A=
+			/* Reserved */=0A=
+			return 0;=0A=
+		}=0A=
+		break;=0A=
+	case 0x1A:=0A=
+		/* CpuFid is the first 12 bits (11:0) */=0A=
+		cpufid =3D pstatedef & 0xfff;=0A=
+=0A=
+		/* Values between 00Fh-000h are reserved */=0A=
+		if (cpufid <=3D 0x00F)=0A=
+			return 0;=0A=
+=0A=
+		/* CpuFid: <Value>*5 MHz */=0A=
+		p0_freq =3D cpufid * 5 * 1000;=0A=
+		break;=0A=
+	default:=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * TSC frequency determined by MSR is always considered "known"=0A=
+	 * because it is reported by HW.=0A=
+	 */=0A=
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);=0A=
+=0A=
+	return p0_freq;=0A=
+}=0A=
-- =0A=
2.50.1=0A=
=0A=

