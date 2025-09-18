Return-Path: <linux-kernel+bounces-823159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D8CB85B16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689FB48088B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDC313D4F;
	Thu, 18 Sep 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lTKMweHH"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7931313271;
	Thu, 18 Sep 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209764; cv=fail; b=d8Hcx3Nc4qkoxFAvcUJuYO6fgBD+Q0VsNFNIovg1UZtZhJA3fzeDHEfZQEPUU7L/eHViG3PzQi65kzByk7NiQweqCCASKMirGPLGNWkVmqRppnvBE/svfpsuw1ytVPuPfQguDsVUbpxXFlo+3HHQn15mAumHQscVpAtJzs29als=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209764; c=relaxed/simple;
	bh=6WpStQnS/EcbFZ388/C/DSspzbPShDOGZeT12ZQvOsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ja4JrM+orvCniBFucNFcWQxjbs0o5CT9DdZudzd66zUvvKxOqUFRXTtKmgHUrW5IKvZiuzAGmhWvVK/+RJ/3jWlGLOD4LonkBGIYtzNtvLPGTHN33EsD5p3PRAv4Frzaz2qHptnR+P1xLmj1pvh5Hgs8VVedo1JVI6LLd4ibjTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lTKMweHH; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEhPuu020087;
	Thu, 18 Sep 2025 17:35:50 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhsdev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:35:50 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtDgCNbT8qaCFUbAFipGxFHa71CYPSo1fkhc71FG98iFKQdz1l65eoGFDCU0ZbR75YP7GWpdi5FF+Y3VfTa4DTJE76l67tBA53sqLolInHSrgeOWaLSoVc5kqctvZo2LjPDoCeW7lFcHv8zZhn1FCY5GEe4V94022P16yyGHLamZybCuVGT90o+dEd1B8CRQOH/Ct8WmtTgQCKmYlUcfXwvJ8Wj0D7AjMEJSH3uZJsG75FD92ARp7cca3Qa9/J852qZ3UsiLaucL+UTMVGJuCnBMyRfF+LCwKSBErcihx2mA67qIGAvRHrvN8V6zPbMo5cEj3Qg1a8+anpM/bjKf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpCwzxHHUAX10qxdpsSDxsqaX8O+kYSgIXH9r0efL1M=;
 b=uMInKXtztNDvnzfKOKTn3i307ZAHofTZ/3GFd5oNwbLoilmW5Z3GsxwnLY1z7i4WgwT1uRXg5Tfygd27sPOYLa38zj7k87VagVxnKmj/3xwD4V7sIGJCmqvFVxKCfrLlszoNgGiut48xxKLX8NLdQ8zdx+ncDUn+i96N8FlRqDa0MpByRnNo7LsFGVHAJ2KDQCB9AzYCPG6vbSawys+mt2Y6l6H4/2KTyByCAHGq0M4+lQMnKhaw7sKkyG+81DAodxliowehAKz7tv67MWW1SKhxNGzhl+lmpz78BUzqsmJ3xJctDL8zByHKTOS5xxFgordYyezFM9dvur5FK7eWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpCwzxHHUAX10qxdpsSDxsqaX8O+kYSgIXH9r0efL1M=;
 b=lTKMweHHBF4Ca7slGOtYWf+Bt92CK47/YTsUKyqmqZwW1gYgzHXaSq9h95OOqkbF7jmuLkK1GrdH2LS7okpnXXPgNUP3dz9S+2+9gPGtw2uduZdnawyhWxGOLaCZ6fc3w6weVKHTN0sF4lg4QEv0sHqjA+DHGDsbB0t0o+Aka8QzF2qlivVTQNgfKXtJbsyx6iSklzf4YwPUhN/om1fsSonf58KuAsa/rOK8YTYChPaZ75eKjz5sRcE5kzxPy18y4a+TLl4cg4Afz17GKDpWsayDnbO0CPD8hr7FWG0vSND5LJVkrhY1/u13feN8ucNL3wq0O9r8yZMO5BURX/oieg==
Received: from DB9PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:10:1d9::35)
 by VI1PR10MB7879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 15:35:47 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::9c) by DB9PR02CA0030.outlook.office365.com
 (2603:10a6:10:1d9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 15:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:35:46 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:28:43 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:35:46 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 18 Sep 2025 17:35:41 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: add the IWDG2 interrupt line in
 stm32mp131.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-iwdg1-v1-4-02c2543c01a5@foss.st.com>
References: <20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com>
In-Reply-To: <20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|VI1PR10MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 668bdd41-cb89-4a63-7ea0-08ddf6c909b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVdOSVNTbXArSStlZ1pJMktvV2RsQ3c1UGJSVlprb2w1clA2TnpMWndNZy9Z?=
 =?utf-8?B?aUFrMnU4Q2ZvT29ZdG1BS1dZU2hjQnlnL1dCQk96MkZvN2VaNnVrR09lTzky?=
 =?utf-8?B?VXRFYUQrZlp3QkFvYVNVek1oYXl6NWlwZGdIUm9VRlQwdWlBQmFoV2w5cUIx?=
 =?utf-8?B?WGFiVFhOemVZK01ITHhLdXhjOXYvK29lN0Y2UzEvYWpGMWJrUzQ5dW9UN3Rr?=
 =?utf-8?B?emRDdWt1Zm40TmNYL1VENjRGQTZlZlpodll4eUhXUG9jeDNlNy9velhrVUJk?=
 =?utf-8?B?MmZqWjRld2F3L2xuVnFsSU1KdDlncGo5Tm1DQVk0L0dUKzd1UHVicUNHTDhE?=
 =?utf-8?B?d3BidDVKZllQT3hoVVVjZW1EcitQZ0NpejRZTVU1SDJsTkZUeXRSdVU1dXVU?=
 =?utf-8?B?R1EwZ2lUMHZxTDNkSjNZMk9wZDVWR25FemhzS29sajNpaS9ERjU4VHpGOHM2?=
 =?utf-8?B?QmRKY1Q2VllWc0k1OWtGdFN3NC9vdEtMbjh1cnhSRTdGTy95Y0Y1VFJocHdi?=
 =?utf-8?B?KzJCWVhUNHVSRENXS2tBVkl6Nk15MUJxNXRqVllHRTJpSTIrdEk0Y3ZReGUy?=
 =?utf-8?B?QmJnczZJZnJsOGNGTWtHenJxQjNlZUdMZzZCQ3RkZHJIWW5XaEkzby9XYzFG?=
 =?utf-8?B?WWc3MWp1MnlZdmI3dzBpTlNQS3Voc0tFVDRqVWpNSjYvdlRiS2tVcHBaYnpR?=
 =?utf-8?B?RG1NTXhNeHQvUUFOZEVma1ozL1BFdUhrZ3hoTnNWQ1ptd09GNDJja2pRR3do?=
 =?utf-8?B?VHdKUkI1ZnBUU282aXJrNUdXUHJ3YzZvbkNpVnBadDlrWVlrRytGKzFsSWwr?=
 =?utf-8?B?Y1Jpb3RyMGlQMWhzZ1FHMXBKbmhxNlEyeDZEWWxRaEUvdTN4YVVxV1FPNytK?=
 =?utf-8?B?Nng1bjJVWlgzS1lHbVkwS0VtTXpUSzdoNUhVQjY0OFJmRFlERjRETXVlSHN4?=
 =?utf-8?B?VDJTYVAwU3pyaEtUNXVTSmJ1MHl3d2huazBsVTJERVIxazkxb1VHNVRTcmw5?=
 =?utf-8?B?WVkzeGZlNHFOVWQ1NS92UElWMUR0aE15NGVYelE4ckVCdTdsWWJIeEsyZHI4?=
 =?utf-8?B?clJQYkxtNjY5L1RVWkk4bmxqLysyYWMwUDIvZDVlK3BRakJ6MC9IRzhtL0JM?=
 =?utf-8?B?VmZzM1NzR2hCWnZ2RlMvUVNRaWNXbm4vZXVuc0xEOTA5Ky8xbFlSOWJIUnYr?=
 =?utf-8?B?WTV5QmRRdGdub08wOUE1R0hDWTZhMTR1cHljMEdtMnp1UUlyT0hOVXYyVzVU?=
 =?utf-8?B?SCs5VGgwQ3R3MHB3Z1BZNUttcmxKcGltQnFwZlBHT3dVQ0E0N210Qk5PRUFW?=
 =?utf-8?B?bTVPbTVWd1BrTTBkUCtYRnYyakhYVHVsVCsxU1NQc1lseXNBYVhBT3ZNTktO?=
 =?utf-8?B?YTFmYVZRSlFzUmZoV1daNWRYUmxxVjNjQ1g0MzRnVFVyL1A4QkdyU2FnUXBz?=
 =?utf-8?B?ZWxUVUJPenB1RlBFSG54VFVLSlJIdEQxS1JVdnZvOFVFc2VmMmdCNWZWZW53?=
 =?utf-8?B?L09YN2laQXRyR09LVlNlQWhSajRLZFNXbi9XNFY5TTdEU3E2dzlPd2Y3NGVp?=
 =?utf-8?B?a1FIS0tnU1VFdnpsdFVkUUh2Njg0cy80RzZvdXVTT21PZmoxUmNrc3lRVjFV?=
 =?utf-8?B?KzlROVNDbS9lTUhuWjJuRytPVVpVSFVMMU9Pb01tbVk2Ym5tdjdhL2FPL3NL?=
 =?utf-8?B?c1VZZ2hKSWxmeFROOE15aGF0RFNGTyt0RjRZbWhiWGh0N0dBdXZycmkyRFRO?=
 =?utf-8?B?ZyswcHVIMzlOQ2g4eVdNckptSi80dDBjMVN3bWljaUVEZzdjRTlSR2NNTkFa?=
 =?utf-8?B?T1ZoUDN4MGthY0tZUGFSVVFDajBiSzNZOGpXMDJkSjFjZTNDVnh3OURvUUI1?=
 =?utf-8?B?R2o0QkExMmlhNUZaMnVwQ2ZhcStHa1Q3WEFtWFJ6WS9KcW80QlZibG9SMm9a?=
 =?utf-8?B?S0FJSE5PUkppcG5HYlVQWUhPS3c1Z2RrSnNTRkNEV1BzZnZOUXNCY0FWWDBp?=
 =?utf-8?B?clduaDVCSjBIeWRjV1V2Ky9XdElUMml5MUNwRnVFZkZkenZkVEpER3ZGZDF5?=
 =?utf-8?Q?97XJdL?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:35:46.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 668bdd41-cb89-4a63-7ea0-08ddf6c909b8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7879
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cc26d6 cx=c_pps a=TR6k4uXGNafvMVVnxx+vUA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=eJwOq-yx6V0eZgEjZuQA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5/1zMMAnAAeS YXXkNIPVHRplwICf82AEmaSpS/840roKhO0zsTLW2RHMOiOlBuaVKUsE4+DKKOsiXbhxUcvySGq BcjtAhdUuzlkM/xZvlN/aRjRUyKA/Y8xFUvar6k6nvtT2TCpvld+0ic48LaRg/NueOjy0JZimpk
 /tiCrBARfR99fEIlqqaBPXd5T1l9nHw5wOr6gTG7I+KA8wBE68A8cc61vHcg44N5BwO8lQNcSt6 7mpOOFjxp6fW05cu7p/hoje9hMs/pzpNccFaEItEhfeWg/3aaLK/WF8WRfejd4lZLXw8KM86E1l /uF1yvsYnbGA8jkQQ7WlHyYOZjb2W/qRdK7ngog4dIEKTUMQx1HhS3i731EzbtMYN9lMHaMT8aT 05llfowt
X-Proofpoint-ORIG-GUID: m5fP5nsrXwQHzynqESYxHrGITY2aVUVS
X-Proofpoint-GUID: m5fP5nsrXwQHzynqESYxHrGITY2aVUVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add the interrupt line that can be used for the early interrupt of
the IWDG2 to the IWDG2 node

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index ec385ad56bd42b694d2eda6a4a98c021fb3f25e7..a8df87611879858b7f70b2689be177085482e2d0 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1006,6 +1006,7 @@ usbh_ehci: usb@5800d000 {
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc IWDG2>, <&scmi_clk CK_SCMI_LSI>;
 			clock-names = "pclk", "lsi";
 			status = "disabled";

-- 
2.25.1


