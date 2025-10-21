Return-Path: <linux-kernel+bounces-863286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD31BF778F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB7A1899C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243343446DD;
	Tue, 21 Oct 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jDl61jtZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Td/CchyI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549721F2C45;
	Tue, 21 Oct 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061659; cv=fail; b=S4TX1vAmX/KyXyjNFiMblM42Zn9Ifwj0QRG7ee6O/9mLvVQlQf9ySLxDywKp7ua0apwGVmery8TeAtqLUtGTCFY7gexd50xOXTWS1EtxoOhjEdMLt6pTsksnZyR11lTJsP+Diz0CTLbOkg0d69ZCh4kpUJoDZC6ImOya1QGSpyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061659; c=relaxed/simple;
	bh=K/hQThnFOzlPbbEQqwfMU58UqADNydlKGfdx7y4XC+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=YIGxV3UyMIy2t6Qbc92ddFbYig8Ov5KCHBO1xMAlWgEtJ4nwmIy1Da6ZXC1AplwRi5ZXglssQP4BvNQxrygIaV14udCHuZXKJnBUkRo1O8IxMTMArU3uaB9lPsRREM5L5Iuy9CnHWRYs3P/9wjXbniaoVqxPT59+6gOX+mx5bXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jDl61jtZ; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Td/CchyI reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEIekr002160;
	Tue, 21 Oct 2025 15:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K/hQThnFOzlPbbEQqwfMU58UqADNydlKGfdx7y4XC+U=; b=
	jDl61jtZlsQ/7D4Pm3TtseL0GKxv4Q1OAn1yDQqahPFLgLNgOpdOUEbVIQE6iOis
	KtZgpvKnrSx5W5VUbhH+yD7mvl4v0AyOB0RLvdOcHX4TNoIhJYjhXw5K/7Q+xm0A
	TpHQ41rhrAYuywlghoTfjGL00P+X7ZzTH2rKvtsp/jEszdZulPiQD6b2Hxm4SHGk
	I0TK9/6NKdyNs/Y1Ty0pLgCbHe1VkgN/QDN9Uw9BXl68CYOgVpyK8LcAMuaEaJBZ
	gxpBx2tQ4nQTgzExvetPmPOGFwNxcGtq/62mrodzj1KqPjEwP8yfSd5+lZFN0/bs
	OVFGh/vAvs4oXHQ+PJL0YA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d5ssx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:47:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEuAhv013110;
	Tue, 21 Oct 2025 15:46:59 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc0k6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:46:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psEa9EF3rKmEhCwTamug6WS7fMdIprEHYyNDPBJCMxKGc7mleSERvDTpQZyT0kmnmhfMzDAkUPSgtSMRaUMSBGF2kqxKfaOZ8IdPcby+Nnhs0XCgWzWp33Nvkqa0chX9Csi1TB0dx4r7OhxfVUU9/Ir2bEScxlHd4BLWbo5R6dfndBH3qe157kiFLY5L2uvPG/7An3BtEcQ3yEReymz+gjIdP1K1zRHz4glMItKkP2YPqk6iXBVbv38omGfo+rRh10emvtnRcltF0ucWscGe/aC8WW57eE2d5dSxkxrrACuMihgSHyX/77QVjSTY830cjQxqO8+6TUPTGqh8n/j6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6fHHXcVyGAmVLzCuMsh+YXIKTQA8fyHIJCHDhn27cI=;
 b=VcIHsquFF/N04xfBeYQpzedF2owtoA+C7OfFJucnBsDOV5PYZORCR/k6Ib7TmjhSxdRWDmeLrxFYfI1rV7dkz52ALCqWIvU0SViq2DHPwGR2KzvTtdCW3kZ414tFoLIM/gjAjaA/f3s2+FEIw3ochlUp5gTIcjyH/b+Ox43OOLKmJIT3+UKYY6wled/dIHFZS0YpxHWZzuIMPYtcWO6XYKAfqrhZ90lDWLoKwHPfNTuKGAqQoKpla4ri4EW8ec6sF7EuY/feHsr/R2YcDeMB18Z1YnYJ36qTOf5mOG1T/wZog7nEE6QnFEDBMpisVK51mw2ybZyB5O32ZThLnoGh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6fHHXcVyGAmVLzCuMsh+YXIKTQA8fyHIJCHDhn27cI=;
 b=Td/CchyImuVfxk+m50iTYBMxfYBRnEAFv6c/PjVnBzZP1lJFOdOjlGyq5QmrJUFnf7xNNbmol3I2gOvzvYZALY5uUB3XocfzY2IxDx6Ln5DLpB13CKVdX8P9GtyZfbMqSbFBI7mGeatf7173wbe0A850syLw94Mle/uh7oZA/f0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8400.namprd10.prod.outlook.com (2603:10b6:208:567::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 15:46:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 15:46:53 +0000
Date: Tue, 21 Oct 2025 11:46:15 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>, Brendan Jackman <jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Message-ID: <aPeqx-qNnE5_w9PA@char.us.oracle.com>
References: <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
 <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
 <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
 <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
 <aPemUXkliqL7QShY@char.us.oracle.com>
 <5E09F6D2-F6E5-45A2-8264-34DC6DF679B5@nutanix.com>
In-Reply-To: <5E09F6D2-F6E5-45A2-8264-34DC6DF679B5@nutanix.com>
X-ClientProxiedBy: BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 22facb8c-78d1-4ae7-6bad-08de10b90e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEhpSzdCcHlqbS9JbmFPUXp1STljcUh3WGRVRHhpRDVFdUU2T2Y4VVBWSjhs?=
 =?utf-8?B?VERmNXk5bDN1Yk5HeVZZc0dLZUZTd0FuQjJyaUNpeGxQMW5nTEVjeWxqWEZl?=
 =?utf-8?B?aGdxKzJYeHBlQ2JNTDRuVlZuSWZuQWwvWHFBMmJBOWhJdEVTYlhNTzZzRUtI?=
 =?utf-8?B?TFl3M2RDc0ZaU3BRTzNEUjI4UzJYbHM2MWxQWlN4QnJiYWdERlZJS01BZjRx?=
 =?utf-8?B?Tkp3ZFpHZXNsVnRzdGFIWGpObisxalpJUk9nSGhvUkFMdEU0UXFlajBYZUNv?=
 =?utf-8?B?c1hUa0ZuMzV1cDNrOVpKSVJMWURraFg0aHZVWUpvR25MYy9IWkErWnpSOUpz?=
 =?utf-8?B?SmJpeU13ZjYydE13M2NPcldHa1huaCtiUzFkaDdKdklkN2pvQkd1SkVDdW52?=
 =?utf-8?B?cWNvZUMwaWFGdUZQMjlET0JUVUZqeSs0YmFVdXZMbWxjTzYybm5Wam12bjFF?=
 =?utf-8?B?TW5QSUNYaGpQMmFFUjNNT2pHR0g1NkU3ZWF4RmlVZE9ZejE5c0FRRFB6Y2tQ?=
 =?utf-8?B?NmFpTnh0Ymp0Y1MrUGNiM3V3TXozNHhTSjFNbmdrak96VU9mRmRWN3N4bUhR?=
 =?utf-8?B?bCtLM005STM0cXYxaWp1alVPRnNYSVlCeUF3dmxyV2FYVFBtcUxhV2ltOTNl?=
 =?utf-8?B?QUFIRmtibmNJNzVWZlZDY3VDSzQrbTFSd2JmWHJGVkpXY0RiQnpkc0VaNDRs?=
 =?utf-8?B?N3FGYjN3NkJuY2xJQ1QrU3J5QWswYTl2em1pdXZkZmJYOW90N2ZFVXJLNkN3?=
 =?utf-8?B?UUVxS2M4eFkzSXJIR0JBRDJzVTZsS0ZYdEhPSDY4RTlhQmlWZXhQUHIwY3hP?=
 =?utf-8?B?QXdSRi80dzRxdzFWaGpyKzYycEVoMmk1NUlyZ0l5ZlphZFNJMGtxUmxidy9O?=
 =?utf-8?B?UkVHSnV0UTk1WndLZkE0Z1BDQXZ6ckJGVEpLZkRtQWpXaW9pUnpYdUM1cXBL?=
 =?utf-8?B?VGU4QUczQzV1bm52TldHTWF2U0JSVEdLWjdibnVMNGVGT1dSMHBBZmQ1Zlpa?=
 =?utf-8?B?cnhrVmFqVW05TWd4SVZZQm1Zb0JvM1N3SzAyQUc0RUErTVhzTkxuRXBpR1V0?=
 =?utf-8?B?VWpid0JvUFVJaHVvdy9tNnNmQWdRb0gvVXhiZDU3N01nNis1YmRUaE16dXNm?=
 =?utf-8?B?WWZGK1lFTjFhQTBkY3oydlRTRjJiTkkvNmh6OWs4TjlTZUJOUjdWSnp2bGhD?=
 =?utf-8?B?NHRaZlhXQ2x6aEtoR3BQUjVBTHN1Uk44djRoVUZNU2JkOU9KdnJxcUYxSUNN?=
 =?utf-8?B?UnVaV21IaUtZbmVBSS9yNWJrNkhpbTRqV05kR1JTdDVLcjJHTXliVWFTUzZD?=
 =?utf-8?B?UWo0THdUdXpET005V1dBZnRCaDdQU3Y0WTBKbm5EdXBaY1FMR0V0N3h6SlhH?=
 =?utf-8?B?d0s3QUJ0WHIyb0Z6ZWpZcUhsdW1TUG05eWpCYm1Kd3Z6WExWUnhvWVc5anFI?=
 =?utf-8?B?elQyZlo1NnJ2UVFMOU9zakcvQ2xZQkRlWEd1dG84Y0ljNHllWEgwVFFZR3Iv?=
 =?utf-8?B?bk5pYUlNVWdYMFI4cjRCRWpxUmNZNDVIei9QNWV0QzZJWkN6Nm9KSUdZenpl?=
 =?utf-8?B?R1MyVnNkNkRTc29TZTZYcGM4djhHVmdrakc4SGdJYS9WNU9EV1JrRmlZSlNV?=
 =?utf-8?B?RGZ6TXFVMFY1MlpMKzZFRDdEclJHOWR3T2k2bzBrMWJhUFBPMjljYlo2OHdF?=
 =?utf-8?B?U0VCRHIvM01pdCs1NTdoRC9aNnRTQzIvUjJqOWFHMmxpakRnalFGTUVYMUs0?=
 =?utf-8?B?L3ZlWUdTa29aVUlDRnRXeENIVGJiRGNwRmU0WGJpaDFBMktvVGQ1U3VZakh4?=
 =?utf-8?B?N0U0V3JKTlA4dkdqM3ZTSk9EcmF6WTlJRzlVQnRaZkl5RmpIRWRCTlVFbDgx?=
 =?utf-8?B?U2U4T05xaUtvWUhaOVV4NndZY0xZZERmWVZSUEtiY0w5UHFyUGpqQ0lud2Fs?=
 =?utf-8?B?YUJhWGZiWll0dWh4YVdwS0pELy80US9zelIvMzFQT3I3ZG5YUnpJcEkrdWZQ?=
 =?utf-8?B?T0trY3BERWtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUtqa0RVc1d2bjR6bXNxYVRGYVhDYkFJaUJYWnU0UTNZZjI2eGVRT21wM1ht?=
 =?utf-8?B?Mm5VYjVHQ1FyYUJOOVlQdTNiNVB5S1JnV0Vnai9kVUlZNm5VdmQ3aDZTTTZy?=
 =?utf-8?B?M0VlNUdIUDU1T0Qrd2xCcURRQjdiTWF3aGU5TE40b2k0SDdXNHkzOGZIVHgw?=
 =?utf-8?B?MkVML3NoeGpUcGFuZmhrNElNa2lKRzNzSWswa2w1Mi8rbUJjV0NWQVEwbkE1?=
 =?utf-8?B?REFSZFI4V2FCdjVJSlpSTTZvYS9lUzJJVVRjQ0pDbHdTUXd0UjNPaHpPMm5a?=
 =?utf-8?B?cmJaUTFocmRrUG4vSVBOelF6bVpKMmx1NHlDKzg1NXFvTWhqd1lEY1Y2Y3JH?=
 =?utf-8?B?UTlTSFVwNU1VaTVNNEJ4enU5YVFsaWsyYm4zVWhzNlJTeWNvR0RnTHg1WGcv?=
 =?utf-8?B?RHU5OXlHODR4YWlBdXhmVVEzdVB3NEZpakczRDdEVzdhT01lNmNSOGJzVFZX?=
 =?utf-8?B?TitmQ20zcUJKMnlndjJlRHQyaFlwQW9kZVR4clloWFVzOS9kbVUxYzljRFJG?=
 =?utf-8?B?WVJGMnF5UzNqeVVZakluSVBtODRCTkVOZkVYWFBDaGVCZ1JtQTBhZmZBRzdr?=
 =?utf-8?B?YmZDVExLZS9COVFZdFVqbzBYbnpXNVpGdzFBUHhzUXdHQ3M1WnQwT3hOZ00x?=
 =?utf-8?B?Vm96UTFNNVFSRldneEhqbGQvSXlPelhUNllwZ200SXdFRHRoaFJVT3VJMVNZ?=
 =?utf-8?B?ZzQrSzlsWkY0cnlTTE1HMzlMRVArMVBIdmhFcjF6RThZMDQvaGlzclB0ZmFB?=
 =?utf-8?B?azZrSlEyVENHMHV3OUJTTEhEM2k1cXBaUjU1STFNa0JMOUU0K244RENySnU0?=
 =?utf-8?B?Zy9ha1lsK1F2UFdicm5Oa01NTmh6YzFJNGhxeGpVdTBQMHdmbnYzZVdseDcz?=
 =?utf-8?B?ZU5oaGFlczZhNFVKS1d3OGhpaDNVOFFnYkZhaHVCRzY1NU5rVnB4Qy9DZTJC?=
 =?utf-8?B?WTR1UXpsTis0RWc0SDZ3NWU4QVJJWmhnQ21Fd2VuYm9GSzdvWWdsSjBXT0Ro?=
 =?utf-8?B?azdLcDd6M2xEUDVMY2diSEtqTUlscCtXL0F3V1FFMG1ONXVlR2dkNEgxbERY?=
 =?utf-8?B?UmxXQ3llSlRXNHd1dXVBdUFiUm9Rd3RaZlZNakJTc2lEYTJIYjZoL2xSbEdJ?=
 =?utf-8?B?d3VjeS82a2FsMWEvM3lVK1VOY0tsWElKMlhzdVdUelJ1Y3pRc0x4MGNYSFpQ?=
 =?utf-8?B?REc3U3ZWRTIvb0EycENsSC9HUUlCNGlKTHRJVlFDSStBbHZjMUJQTDcvZHhV?=
 =?utf-8?B?SHNqckZYZ2QyaUJyOWdkNExEYVNMdENKRS94dzJCSTJjZDQxVjh3Q2FUN25Q?=
 =?utf-8?B?aFNNSldRQ0p2SFhYUTVpTXBjc041MVlTV1pZR3VLd09sVm0rVGFySTFuK3d3?=
 =?utf-8?B?NTZMQzBINmRQWGpvcVRJa1RNWFFFYTNhZTRyZkVqcmNrUEhLZVdLcVo3dWxy?=
 =?utf-8?B?clhFSjJOMFFlSHpBZmhhZ3ZRSHo5RU1mYlluaENHY21JT0RRRUNXL3ZzSE5a?=
 =?utf-8?B?TjNYMVdMR1lhQWlmYm9raVVDK2hBcWhIbDlJekJoU2YvMHVUWi9XVjV3R3FS?=
 =?utf-8?B?UzBwVWQrUS9LRlVJY3ZENUoxd2MzUDBaOC9rUVNXc0FZSi9rOVZhNmk3bTZs?=
 =?utf-8?B?c0NFNnplVFhoNEJqVXhJVjN3eW1LVUlxbTl0emMxTEdnd3J5RklIemY2QlQ3?=
 =?utf-8?B?eGEyVVJYcVhCNzBCZS9oS3BQLzRzUHpBUEtOOGNDcERmVFJvRmxSVk41cWtM?=
 =?utf-8?B?QzF2azZvRDBiSmI2YlJjZmkxU3JpSVJvLy9GSTNEYWxpS3JwdUJtNFZnOW9h?=
 =?utf-8?B?Tk8rdnJTM3FDSW84K2s5MkZWekhqcmM2dGQ3dDhSSWpoWkJJMUNLY1M4VEZl?=
 =?utf-8?B?TTh6dWMxeno3YTB0WEZmVDZJRlVKSloveXdPYzQ3SnlRcEZZZU1pbFVkSExY?=
 =?utf-8?B?eUl3ck1Ma0RqeG1NMzZaSFFMRjZpZWJVNFBUc2U5Sm40Y0twVVFsS3Q3MGlY?=
 =?utf-8?B?MFhPSVkwTXlLemFpeFVyK0I2T2tRekhVSUhnUnpabkhWc2QyQ0dxWVlGQTVQ?=
 =?utf-8?B?dUZQZ3FxWUxrY2VxbXpFZzJWMGhndGdWSHM2N3FVZGlBOENoMzRwU3BLZWNC?=
 =?utf-8?B?ZDlha3VxQWRhOEF0ZERPOVBjUTJTSVA5OCtMc1JNcVU1U0VJRHVRbzhqUEdF?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ilCHc6O1uzqDGnW4YutvEgI9HvQbYnaHgMRQUXcqQGshpBdUAyAMFloX3O/KID0RjQxB21S9ddIeQDeVgpDayYi086glCxE1kh04ddP++FNJFqI5O4YnQkkQ+eQQ2J93D1Z77hVzPKfX+QoWQwsTZmUvP89EE/hdf+HrnYunGcsAZgdXO57nGE1x5CD7l12CiIpcnvuIxL9UG/3W0XNufh8z/d0YNAXN1wPFtHYUlvl2PupcsQqsrPW8nixg1bUK0EcgnCiBJ3/J8DACRHIqQCap4KGHQQ5Lu0kbWjO//fmBcJWVDkKnu4BEmLQ90sDkkKVb0oFNMZhJey4ZTsxSVW4VVEGsXiqZOzAixAC1GTbrHUQvxTecBvHtqrEPv7cyLf2YkcCm9fUDE/usxn+m0jqHNWHiij6+bI96nz0dEjPWxHX5Sl4HevwFnpTG7QAcfYnUczZjU5+C20mXzqbxbCDhfRvMg4xdPvs9UL/AeCDS+CsEwY4SEE80tR5rgFDoKCrS9BbEUY9M4K69xOziZgJgHaF/9h2YjBozdqp2qizShLpLkibcPo+8+YMIkXLbKGowhJcinpKCmUY4UYt3++tZeEZqYkIO42Ux8SHJFkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22facb8c-78d1-4ae7-6bad-08de10b90e4f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:46:53.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37My7nm4KX3bYKv9RvEd3PIhRNM9isAIA9+7B9ajdG47kDTgFXBH1lA/Yld5E5+S21iQuUhXgiXCPU6fdXN1hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210124
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXx2lLJ/iZOdxL
 wByoqMb9lpGRp/9+tUFyu9rkYqf0zGPxuaoOyg1+BeilTxbOYsn5pj1hNWwv0frvUVL6P2iiIUp
 vDnSK2PIpJ/qUdFiHCgWzjQ6cH5ei9LVS7oRUFdl7T4j7PEQ8gQtbrBbPhQ93s4eroGhDAmSYkZ
 efEgwXrLx0GHF9IZqCKNvbMEsS9dhRWdclPMHfdLvPA+ztsYUWIazDN4ylS/rJblhV+EGKHrROY
 7SJ3WdCTnKAzn8ghdATL9j6i5SO6ngCYoRBxbvymGYCyyqQLZ6TDAEhN13GjCljR67rEZr+Uvox
 t7h0OlYHWa+zLE65qHkZFOZLIpR9YXy83rUwU6vzOY6D2dgAa/L3txzeaG9t7dQk4sLVClb3xSr
 SPXgT6Q6LP/mab5qeqqCH7qijKqNXg==
X-Proofpoint-GUID: KShn7oyNodkS4Eo1WbS1X2_pVf0GyrDY
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f7aaf4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=gs9Pb4jnFpyxObAF27wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KShn7oyNodkS4Eo1WbS1X2_pVf0GyrDY

On Tue, Oct 21, 2025 at 03:35:28PM +0000, Jon Kohler wrote:
>=20
>=20
> > On Oct 21, 2025, at 11:27=E2=80=AFAM, Konrad Rzeszutek Wilk <konrad.wil=
k@oracle.com> wrote:
> >=20
> > > >=20
> > On Tue, Oct 21, 2025 at 02:39:15PM +0000, Jon Kohler wrote:
> >>=20
> >>=20
> >>> On Oct 21, 2025, at 10:01=E2=80=AFAM, Dave Hansen <dave.hansen@intel.=
com> wrote:
> >>>=20
> >>>>>=20
> >>> On 10/21/25 06:40, Jon Kohler wrote:
> >>>> So to simplify it down:
> >>>> A guest VM that updates to a ITS-enabled guest kernel sees performan=
ce
> >>>> impacts on non-vulnerable hardware, when running on non-BHI_CTRL and=
/or
> >>>> non-ITS_NO hypervisors, which is a very easy situation to get into, =
especially
> >>>> on QEMU with live migration-enabled pools.
> >>>=20
> >>> By non-$FEATURE, do you mean that they chose to not enumerate those
> >>> features, or that they are completely ignorant of them?
> >>=20
> >> Both cases are true for QEMU.
> >>=20
> >> For ITS_NO, it is an allowed feature, but its not part of a QEMU model=
 by
> >> default, so the higher level control plane whatever that may be would =
need to
> >> specifically turn it on, its not automatic.
> >>=20
> >> For BHI_CTRL, depending on what QEMU the VM was originally *started* o=
n,
> >> the guest may have access to Sapphire Rapids models, but BHI_CTRL may
> >> not have existed in the QEMU source at that time, as those were introd=
uced
> >> into two different timeframes.
> >=20
> > QEMU provides now a mechanism to update itself to a newer version. See
> >=20
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__blogs.oracle.com=
_linux_post_qemu-2Dlive-2Dupdate&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3D=
NGPRGGo37mQiSXgHKm5rCQ&m=3DUUSvpPViiTB6CJQtj3GREK4bQFz7MT9uNiAu5AL3O23d6I1y=
k4vheLDyR41ZcbRI&s=3Dx19gwHU3HGXSlGkK0ppkawex3SIbs8xHj5hPtwNCFwc&e=3D=20
> >=20
> > That should solve your QEMU problem.
>=20
> Can this live update feature change CPU feature bits (e.g. add on
> -cpu ModelHere =E2=80=A6 new_flag=3Dyes) during the update?

It is possible, but a pain in operation b/c you have to keep track of
the newer parameters you are adding and if add some device in wrong
order (wrong PCI BDF), well, things won't be nice.
>=20
> Can it change CPU models during the live update (e.g. change
> -cpu Model-v1 to -cpu Model-v2)?

Not exactly. But you can modify the built-in Model-v1 (in the newer
version) to have the newer CPU flags and it will carry-over.=20

Anyhow it is all in the latest version of QEMU.

