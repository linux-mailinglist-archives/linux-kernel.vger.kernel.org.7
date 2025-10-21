Return-Path: <linux-kernel+bounces-863257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFEBF762D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B092A355FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6A33710C;
	Tue, 21 Oct 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jc1us86k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QL5dJVup"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB012336EF7;
	Tue, 21 Oct 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060627; cv=fail; b=bRQn0axDg1GMV14bEYxrGryPaiOVkYec8aZEse9mPWxqokNBL0CxmSV2XZm1wZZCTu8//DiE0E6msXQjnjO1CZi54cuReCbkKBOC67DNT8DTM5w7q+Axs96QNiDdNQR2nZW+6sS0yWbpJ/7A2hGLZrFzHgIAJJl+osjZwdMU8Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060627; c=relaxed/simple;
	bh=05bOFZWeeehnOU7Hu/72yTTpRiE3b2ikjW9WgV0Tsfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=mL3HBZgx3aPmsAlbCF3yJioN7R16ZEsJF2APGHLe96IdydkQb7uY0UsqRHrVrwAGEWHhs/A9HV0Jqu8rayFSerCJZ2+qiZc7La+ECtwhbrmADlzqUmszYRcGcgHRZLdBB3S/uzETrfCeCXng5/Nl7ME09JOHJA/w48HqUMkEV5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jc1us86k; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QL5dJVup reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEJ7ox008700;
	Tue, 21 Oct 2025 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05bOFZWeeehnOU7Hu/72yTTpRiE3b2ikjW9WgV0Tsfs=; b=
	Jc1us86ktCLhfc7EZ6knvVPsuDLaQUAnmmK81f8edsZrXZ/IdP3XVsm/QMYvm9f/
	oC0T4D9cpKfi0OYO+xOGmKhEtH0RAYkYTl+ZhyQFXEtnUPE4O05+Nxo+hIEmniWU
	wjCPhTPw99taPfn+QbCX28c2kPBQ8H123UN69XUj5roeq3O6CFbdpo3A0KTz2She
	o9LdbPH+9vCorA+Yf0tEmF70NRSN8U/nwhoaIPPOXKPCc02xodRk33PUg2xhj67f
	7DPfa8uWXZvQGH2LDWjxwYurpE5brz3DLFeAZSCSBk1Bfi0+bs8LK9WYW2xyPNPT
	ilhiRTUxfdodbzUOwA5Bhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvwk7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:28:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LDrTl1032334;
	Tue, 21 Oct 2025 15:28:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bd11py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0GkbGmwEkksFnYw3ZVGCtiLbDRsmw0wFVpOX6SEGuzMiRBBkWqhCegriIioq1XE7md3rH/gYVLPAvMgOBVMk1K23doHes1yMYCimzpKZCdRp1vKz3qYBfGevOCNaMlh+Ykk95jc40eY3bLT6RTFWMU9O5/S7roIUU82PCBKhb7UlT4jzvqwbgzOAXA7p6tTU1b1Vq5OBD6gc7Bkkh5khC5vrR7S1DeClvhbIyF88P3wZ/0SMFM5f1HzZbkWkrKvraSvS6UtmXXruS39iaWqRM+vfRAMLJ/EGqVA5KJsr1yQsm3nJrCYHrVbFKG4HOtMV+dEOaaQ73kcCQqi8Ckixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNS1I0VU0iHg2AZN/Nsx4ePMYd1R4J0WpCdKQZ65l6c=;
 b=sSIQdIgijG0xoYwZ5R+Xffh77Vfbx8YCU1JMfmYsjaTYufYg5D8+xneMLK15Phwf8VYYUOs/VciaRdqvDyxpPOekZTcJGGbxGs74G0bYitPbTI2klS74/VSw6j6g0smCyDqOJPuiWK2SiEWhjyIOx1rk7t1h4QN2RxV6VMUs93JNDE6wtEoxeHHn0AoBAfLs8ubodwoX5gCcQfuGA96mLx4LA8MvXH32XOv9lhpoRM05yxtrSjwIPIj77WF2rKZfboUebHBtM343nFN2czwtfUt2NlvLd0bQ7rPJvLmMnEjQBriBnCoE77S0PjbfRq2x9BECobl0DbXaCq7qIvf1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNS1I0VU0iHg2AZN/Nsx4ePMYd1R4J0WpCdKQZ65l6c=;
 b=QL5dJVupgXEjjWcXCOfK2FoCSkyyhhW7ErBEtmfqGJepLCODvJVa7jiMSlPdqZ/8Kc1oQrEQmN3rR8KA0BHMPyKgkYQcOihhsRWOIYP2nUDcJTQ7utmmsobVdGE9IASwXm4vXlUh7VRuNKPtV+fhlPA6nSXfJqbfZEMikI7GI28=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6449.namprd10.prod.outlook.com (2603:10b6:806:2a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 15:27:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 15:27:49 +0000
Date: Tue, 21 Oct 2025 11:27:13 -0400
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
Message-ID: <aPemUXkliqL7QShY@char.us.oracle.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
 <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
 <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
 <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
In-Reply-To: <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
X-ClientProxiedBy: BY5PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::47) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a85c42-da50-4762-1025-08de10b664a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhyNCtTcUpVQ1J2T1pjYjV4K3AxUitxSDcwNmg2VmxUc3NUV2RIalVJNzEr?=
 =?utf-8?B?ZGFXa00xa1lzNUxNcS9sTlQwZDRiYURQdWl6bmVNQzkyUGxtZWVUY2x1NGs1?=
 =?utf-8?B?SVp3T2lsWVRob0tnVWJKMGl6aXVKM2huVUZQejlOV0tLVWVUSldUYUZOS2to?=
 =?utf-8?B?U3lVdHU2SDVjWWNIR1YrL0RORnA1NnhxS29Yam00MDBZcXUvcWd0QjBHNzA1?=
 =?utf-8?B?bU9kMmZwSm43bThReld0S2hIdlFRNEJSOVVscE8xc0M5OFNwSllTemRjSVdF?=
 =?utf-8?B?Z2hrNkYxRTdlRUUvS0JQeE15WHdiWUNLcDhiMUFnNHJTZXp2RjlLTnpRNFd6?=
 =?utf-8?B?VnJDb3RDL2Y3TGswcE40dStqYTFKaUY0Y1F4b1hQTE1yOUw5VzVGcytVZDRV?=
 =?utf-8?B?VStSMGgwZ21VenBVK3RuNHQ4dnBBcXNMQ1hReitRWHdRWVlxNDZ5bWRVeEJs?=
 =?utf-8?B?bHdyMkMyVjZTWE1KNmFQNVMyajdyaCtTeWVlSjFERExFZXA5enRlaGoxRHlY?=
 =?utf-8?B?OUZJcWFOL3hEc2lyUmFLZ2k4UzhpZ3lWZTVTNUJncHNKaHRWSEU1eEpPdU01?=
 =?utf-8?B?c1hyUFphb0hRbUZWRGYxNEtKckFWNVdQdzhPbzBRNWJzMHg5aVRENFQ2QjFP?=
 =?utf-8?B?Y1dEUXJjeDZaRkRkbjNHMDkwY1FpL013TDV2SXRCcFdOMzhRNENlQXcrV3hh?=
 =?utf-8?B?ZkpNVTFob2pRMWhwU01UM2dHKzZUNGhkc1FCU1VaVkV6d3htSUdKUUZDckdD?=
 =?utf-8?B?VVFIbWhjVjFUbkFmRXNkMFhyVlpla3JtcDA1U1ZUajdiT2xZYUhhYTNOTmFz?=
 =?utf-8?B?S3paR3lWc3dPRHA2QkdOdDhNdCtYQU5ua0xpL1oxbkJJV29IZXVQYmI4WUlR?=
 =?utf-8?B?Y1lKVlA3VEFNWmhCbjIxMW5KZnBOQ1VlWm9pc2QvRHRwUW5Ka01yMGI5WDJX?=
 =?utf-8?B?R3ZDV2xraGR6Mk9MQU5YcTZUT2IxWW5OeGZpNWMvTzcvUlU5Mk5JVEtFVEtu?=
 =?utf-8?B?TVd3djhtMGNpVmNORWVMRVUyNHprV256cHVYb0Z4alkwUFFxcGJiRjQwOVE5?=
 =?utf-8?B?SVVvcWJ2R0VxT0I5UThUVE94WE9XRHBWeEFwR21ZVkxxRWt1Z2o2RFFNV2Iy?=
 =?utf-8?B?ZUpUQmhtTTRGV2tRQXFsN2ZYb0RMTlFjUmFhVW5BRkFJVmo3WVZSTi9VWW9r?=
 =?utf-8?B?blhzczhBRk9TN0VPcjVxK29KeXppU0l0SHFiMXBJaTd3YW5jMVZXN0xaak5W?=
 =?utf-8?B?MDJZVFNRRjlINUVxenJob3Q1Vkhna1FVRVNrd214bVpLTmRlckVUV3ZvVjRq?=
 =?utf-8?B?eFNPcnFZS3dPYU52NVpFUUFpemk5Y1diaWJONkplY3lWZ0wwcG1HcDEyN0xs?=
 =?utf-8?B?TzVqZGZxUTNJOW94MUwrZ0E0SkxSRC82c0ZjYUVrQ0E5RkQzL2cwdVJYakZv?=
 =?utf-8?B?blplaEluK3VxWG8reGFYOEQrNTFUOUFxeU5TTlFYUlY5S3JqUkVUSmEyRmV4?=
 =?utf-8?B?SDIyYzJjNWFiVmZmS21UTll1Q3h5NUE1RjM0alF4Ry9oWjJGWnVvbFo3ZnZF?=
 =?utf-8?B?YTNzNlJ0Rkt6Uk1TVzFwYmtNcDJxa0JWTFJXdUNJT05ZZ0lwaXFIbm5sYXFl?=
 =?utf-8?B?NmRGOURMc2U1dHROd1hLM2s3aCtlaDNFZDZuVjJtdVFLSjNZRTY1Z3NPMmc2?=
 =?utf-8?B?YmFCSEZxcEpORmRrZzEwOWVxQzRvbVp6WHhaREs2VDJCUmZvVWw4OS92QnBx?=
 =?utf-8?B?bHNVeEVqL0VBT3IzTi85RmVsUWU4OFc4SDA3QkpQVkdpZ0xyQ1VqL3FOclJX?=
 =?utf-8?B?RlR6cHJkaFphRTJxTDE5Y21xVllpdGhJV280S0xqbUtFano2ZUlMZFlsSmd4?=
 =?utf-8?B?cXF6Ym0rTEVPdzBCMFV2OW1LNXEwOUFLU0puTS81MUxBRXVuME5teGxLS1Vr?=
 =?utf-8?B?WlpCaGd4c2xZWGhPQjg4SzRyN29Kek1GYS9QYVU5dmhUN1M3OGRzS0Jncmp5?=
 =?utf-8?B?REVtQ2FCVHpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW80QnR1a1oyVXRkUU5qTkJiRmV3d2oxeG9uWi9lNmwzelp1K25DYUs3d2VE?=
 =?utf-8?B?azN2MHZEM1hRejhTUytJMWhEd3QwMzBXVzZuVWNiL1dCd2Z2VTFOQ2phelZD?=
 =?utf-8?B?Rm00cnlvWTJoRmdmOVZDaEQ5UHFkQXZhZ3NneFVkNTc3WkdoczRFKzBIUjdE?=
 =?utf-8?B?RGlzTm1uZ0lLWmRBRGpadWVlYldibWVzdmdla01wdTdTVzU0ek1JRFlyb0hO?=
 =?utf-8?B?bjBBZ0xTVlNTQ3VGOGVVMm84eFE1UFVZYS9PWkF3V016OUQ5dDB4bE44THlw?=
 =?utf-8?B?MWhFS2NLRm9uOG93UDFEeXNjSG45R3dNVS9kVUs2VC91bVBGYTB3Y2FNSzZB?=
 =?utf-8?B?KzNCUTNobEwvdWJIWnBzUWFaZ1JnbHB6OTZoNWxickJpNFc3d3YreGsydVJ5?=
 =?utf-8?B?aDJtVUJySzIvbEwrM21vcXNsbE5vM2xoSURyUEN5U3JzYkg2R1N3VFhUZ05r?=
 =?utf-8?B?WG1VL3ppa0FBUGp4Z3dXVERFbGFIaUljd1FMZmN6SGVSYUlIdE82S2RrNlhE?=
 =?utf-8?B?eTNMQjZpdlI3RW14WStHNTlqMlhNbTVwL1lMcnNMRkY4d0JjMzlkRnFKN2o4?=
 =?utf-8?B?azQ5dEZDK1hzRzkxYkhFemg0ZUVNdFRnUGV1RGd0TWtkVzJUZjAxbWo3M0pL?=
 =?utf-8?B?U3BZMC9wWmRCTW9RY1h6cUhjSXlHbnpGbTY0ektuMjcyeXpxYlVVcWNHVndy?=
 =?utf-8?B?Tk9wT2JybGxrVWsvbi9Pa2JQcmZSZHU0QnR2NUc2SlNMYk5FemlZbkR0SFpB?=
 =?utf-8?B?RmhvdE5XL0U3b1hXZVJucWVBb3RhVUZlVkxMUmxXT2tnSmtldUdqRGxRSElW?=
 =?utf-8?B?Tkwvb05TRXVaTTZGcTNxZjB5YkRaNFYwM0ZNUVZHYW1vTEhiTHVha0k1K3JC?=
 =?utf-8?B?L0xGNzRQZjRucyswYVd5TERzWjJtL0pWNVJYUDhyY2tKL2ZvenFoMFpXMWkv?=
 =?utf-8?B?a2QxZ2x4ZkNBMWU3ZDRmWERYRzlyNjE4aktXNkR4SUhUN3NXOWVoMW5kbVpZ?=
 =?utf-8?B?RjFGMndQc2x2L2F4aENnaGRDQmROWm52S2hMRE9Eb3lucDBkUERYU2JXSUs5?=
 =?utf-8?B?RDNkRlZmY2NtbFJKK3FETWtHUFNKYU9DZmdSdERBT1ZGaDZadW9tTFRMeUkr?=
 =?utf-8?B?SG5FYzNwUEJVS0NlSWgxaUNBVmJFdlJIUEpnelVZZWhMRUU5V2xOUysxa1Uv?=
 =?utf-8?B?WXh0bE1XYmYyeUFBd0FhVzFQWFIxaVdLVGZIUFBGNVdOMzFsY3VnUVRZUTJO?=
 =?utf-8?B?WkU5bEJMS045bUtxalNiekJoWnRNcjZlT25sdjUxM0kzZ0o2cEJtckt4OUJq?=
 =?utf-8?B?MnZibFNZTnBoNWJmK3VVODRxU0hLcDM0NTBwa0pHd2FHcDF3azhhdXhVVzBh?=
 =?utf-8?B?eEk3K1pRYmNlK2JMbUJ1WTBtWEs4SHhXdkRKSE43NUZrU2lEQnU0YWJSam9W?=
 =?utf-8?B?ZGhFdGNiYUJLYnFBSFl3QVJUWmNFemhwV1hPdmxuT1R1V1luclVKMGZqNjIz?=
 =?utf-8?B?MGRvL3IrTDh1NVYxMmZodXB4bDA4YTdtMEE5VkEzTURwdWF2U0lYem5qcGVJ?=
 =?utf-8?B?blgxQTBCd1VwNERyWCtWVVFsUGtLV25kZHMxZksyTy9GQ2QxaDREajhvc3gr?=
 =?utf-8?B?ZnpMd002NFhDL0hDdnJvaTduVEsyZFRJR0hwSS9SOWtCKytNZVlQNE1QTGRx?=
 =?utf-8?B?OXlGYzJrcUZJQTNYaWRsU0NGSXZUbVZVZS9Td2VPeklHZEdEeUZQdkdiNnBt?=
 =?utf-8?B?VnpwUEVoY2tYckprZWNVTHI2RS9nRzZvcEYrZG5VTEI4Vk54RnBqM29hbGVt?=
 =?utf-8?B?a0EwdzBwR1ppVSs2SDVpU2xDcC9ZdVBiQzJJc01aQmJMUElpTVAvZXMyRlkw?=
 =?utf-8?B?eWFYNWk1ZUNrbHdGU0ltcmhzQ05YNnVTVllnZkQxZ2F6VU1GaVNlT05yd25r?=
 =?utf-8?B?TmtPN0tFaFhtaDh5WGMrMllCNWtQYlowOXc5NDZnOWFPN2hkcnhMbmlneCtZ?=
 =?utf-8?B?ZzdCVURrWXk5MEtnRVFkdm9yMXNGOEZkTXdOdytaWkxpWmZUajQ5Z1hHakJx?=
 =?utf-8?B?SmFUUTlDOFhZN05UTCtJQzV4ZHR2aDg2T3B0TDZ1WnhPNE5PaWMvRXBBR1BM?=
 =?utf-8?B?Q2kxWThZQzNta2V1dkZocTZGTy9xK2dNRStodTAxNzA2TjNVTjdNQVZ0eUdn?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h14cASJfkAN9XYLlWbJhF5DU0Bip822Pw21v0V72nZnNmgGXeYkwmGjLpf8L+b9G/XDWhGpdUhVQhhZ7hVBHGgQQJMNXLwHMqOp6nXRlLOUPoAbBZmdlAHtXEX9oqTxmfWpAJxpvYGUMSJbtZdmz59ruoOg22D1KM8qCRfq4QG8u7Kxui4P1nIRglEqh9jFcq13HFxOvC+aJ/Ce8Ox5mdoUudwPfro8TY6QzqLWD3i4YVtqmMFWSoImIszBOOeUJ4DXrf7g55WuxheiuGHjbhBTQNxKqS5OjlNMugzl4QSf7zgKQD1DJPlwef56KpZmlD56yxMO7N+fIfJ4ul2GowtWTTuv1HYaGxkOvSf6+y84Ejb+QFHeSI2cKYTDk3skx16qm8m27NWeHhBtvpL3WIVfd0o69xttKlDuQNZIu9R5Xld6T1SM48ImcSdsGc2zSr27lG2GK7gxvGd1tKtMmCSLXXglSCWVyOcE98u6gPzIXGSQPIcBQJs4dNr6pz9SeJM/1S0DJBEFJaWs/M5FY1PIXC/lf5p6ceN7ZSN2KdV4X/Ii2neqYieehEp2NQt8oZCLM3M0oAoaBxLK4r4uCXMhhutStqPgMvKcELGqCdkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a85c42-da50-4762-1025-08de10b664a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:27:49.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GILDrSsJBi4iyH6OFWCpN48aYvjS+gWGILaLeajjIV0dVWAR++wmysAzmf+oNW4nIXJEMTI+EjRnQrxRW3vUNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210122
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5rriMrsFAAYd
 WdP69iZaoqbzicXrvULdEn/PmeitMqx114Pg1xk6S7paQLodr3sFuNZ4QoVg0nkYREoEcBbcNAy
 32m5gRT1jUpwLIJ7T0iWxWM4ls7MRDano9RGMOInMYKBdDGQ/MZRxoHR2DSx8JmS4yhCQ3s/N9C
 aS80rcMqBsxlXWiSOqesjiJec7ipONJhatW/UrZNoIumHZDVRXLBnCT+0mXriO1LDB7QNi9+c0k
 WhNEtb+ewOU6sS0/D/84ai6nfI54xyy0NrFSfeL/6JQwBIyyhdzyEnNSIEGRDQJkNyjZfzqeicB
 xw3sI6R9LsV0T7gtn6l7qy2DCCyL2yDkaD11xet/xeX4Jph1FCYuwZQnT/5e3DfGYH7RVZvYnqc
 y/vVJEBzNeKpLRuuuhRYl/lZONWVOS0AY7UG2Vi7qb9jpMUpyXw=
X-Proofpoint-ORIG-GUID: iPhrKOPws-2xKZDmFxwZ_ZcfHY5gSJ3f
X-Proofpoint-GUID: iPhrKOPws-2xKZDmFxwZ_ZcfHY5gSJ3f
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f7a698 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=s2Io-HG2iaxk0UaDc0sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624

On Tue, Oct 21, 2025 at 02:39:15PM +0000, Jon Kohler wrote:
>=20
>=20
> > On Oct 21, 2025, at 10:01=E2=80=AFAM, Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >=20
> > > >=20
> > On 10/21/25 06:40, Jon Kohler wrote:
> >> So to simplify it down:
> >> A guest VM that updates to a ITS-enabled guest kernel sees performance
> >> impacts on non-vulnerable hardware, when running on non-BHI_CTRL and/or
> >> non-ITS_NO hypervisors, which is a very easy situation to get into, es=
pecially
> >> on QEMU with live migration-enabled pools.
> >=20
> > By non-$FEATURE, do you mean that they chose to not enumerate those
> > features, or that they are completely ignorant of them?
>=20
> Both cases are true for QEMU.
>=20
> For ITS_NO, it is an allowed feature, but its not part of a QEMU model by
> default, so the higher level control plane whatever that may be would nee=
d to
> specifically turn it on, its not automatic.
>=20
> For BHI_CTRL, depending on what QEMU the VM was originally *started* on,
> the guest may have access to Sapphire Rapids models, but BHI_CTRL may
> not have existed in the QEMU source at that time, as those were introduced
> into two different timeframes.

QEMU provides now a mechanism to update itself to a newer version. See

https://blogs.oracle.com/linux/post/qemu-live-update

That should solve your QEMU problem.

