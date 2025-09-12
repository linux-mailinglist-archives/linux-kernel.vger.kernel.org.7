Return-Path: <linux-kernel+bounces-814292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D35B55218
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901081CC32E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E8309EEC;
	Fri, 12 Sep 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pcXQMgOC"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EA30103C;
	Fri, 12 Sep 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688224; cv=fail; b=hRh4pMLwfCOD1m/rN9w0mbrHjdaLg19cx4v4Hj/OfXwtR1fOyD5ShhdVgqyOcnjsgEfmaOK26oOXaCv3LIiSgnOfZSouGdtFVNhLGtydXF8Z/Xx9z3UpK4HI59sQurNdAuJqUICOxxEVm0MozigWbjmev1J6JDLqIsE4xn/L/fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688224; c=relaxed/simple;
	bh=R2Z2qlybukTqVLR3GxpD2wUKPH9m61mHwWdsTfjhX/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qji5RFnwvjOfhiUrDM79H5dpTwEkcTKq8X3PFHj89YP8w9BJB1VmMo2rmyKiwNYO1eWp/fAkP4KQqyMIBlrqe1PesYLbQcste49bZs7HmOJqTX0v5J+jVFH5sHBEiyxKjqKDIzcZQZTCZ92wV+sBsLl/xOmTraizh5YtKeqX+20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pcXQMgOC; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDdHfb027661;
	Fri, 12 Sep 2025 16:43:31 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 490a38jg3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 16:43:31 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2nGFafNsCEmaoK6BCM4CDkcvw4OEVLz4sOw5hWdbisdvIPWJeOwccosdhGv8Kfp8Fhq2OOkqNnpB4PXOM7Ft04kRjFDlQOppEHNyIPoR2vl8TQQTUNET1bP63RzuhnyUosUetTy5IodP5YwkCVwJTLjSZW2jmD4CAJAfzB2NAVXtfYwaEKtNAwJvL2F+bIX3mKmy3apxKHp3DcU8BmpAoRxfbMfDnFZv983L7Z8Ziq/P1GJ2mAykxVhVfLee0/JwwDzR4KM8RlLUsqVQ8drPsr4Zpsduzr4OV5eP3bKNxF/0p58Bb9ZVfuJk9lBEDzjMndQwmyKI6T5Q56d6qEuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91FBpLffH826ldrFVLNMklJasWuGJU0MzKfrDvEjuWI=;
 b=eTdsRu30jhzWb5/8qDzJTkSpeheecyb4Jnl/3tnPtInRMftSuOq9t9gDn9/gSFx8m+ONd4KDnce+gj1ce2OBWrU0/Rfe+O5fP284DPdkp9YyZViYbBaOo10T/AZEnXcqqhTT8sm2oLY1zTD1pfclyanIPXQn7s0OwRMgSD2HTkUgYpJC2aIiM6jo50Qbazmep/zeq+KijVepnD90W6RmuJk1QZIX7qm2YP8unLcTtQYW2/GWdOtxJvZsw7E+OWEOOa2M1bxQwCOHG7XFpb+rPevHK2mZCGpjmIYJqyiSds31pozLB7LqD4+6jqfPCf5KT/2ZIej11n9yi0L2OcJ+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91FBpLffH826ldrFVLNMklJasWuGJU0MzKfrDvEjuWI=;
 b=pcXQMgOC8VBZ2T7ErHa2gSHVFx9Ral3Yy5rOWdTfhXn73tv2Bv8PPpoN69tKDCPtW37nro5ME7eRitdbuBkNxETM6eC/1wm/oeZWGSXipKXEIsmUiEMKgJRhNIy19ue7DrPf4/S2vZHy7XrNBpnZS82ESA+gxakBJUpSCTRMGu4oleT5UFkMs3sQrl3/KBY33mmHvmGnNhiDeGaZRAITtfIGozrkuM7mC2Q3pLoFpjw+yBEqT6lO77k3zSq548hRxZ3FibuDqT7uBGy1mVZFwcYfbxLhO5STR9sFmcTTGGmvNQiFV/AQSt1TENIFoaA6NQZLTsq71GnbcjlVyJLQCA==
Received: from AS4P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::19)
 by PAXPR10MB7926.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:43:29 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::9) by AS4P192CA0025.outlook.office365.com
 (2603:10a6:20b:5e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 14:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:43:29 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 12 Sep
 2025 16:41:06 +0200
Received: from [10.252.28.204] (10.252.28.204) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 12 Sep
 2025 16:43:28 +0200
Message-ID: <7f75a59d-356a-4af4-a1d0-8fb1261397bd@foss.st.com>
Date: Fri, 12 Sep 2025 16:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: sti: remove dangling stih407-clock file
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908-master-v1-1-98efab52f143@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250908-master-v1-1-98efab52f143@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|PAXPR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b0b5aa-c0d5-49f6-06df-08ddf20abd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3B2aTVzS1VqMmtjdkZuOFFzNHlWN25rZlNOR2xEZEYrMG1lN042dkFTeXNE?=
 =?utf-8?B?TFIrUmwrcE5GN0V0akUrM090TFBrN2Z1Zm44MWdSSDZ0a3dPcHVURGZjWDJK?=
 =?utf-8?B?dG4vTnRRazZvNTc1TXR0bUFNNEdDU25acW9HTWE1MjdWYmVQOEIvUzU0T00x?=
 =?utf-8?B?cHlieXQ3dHYvaGtWRXZJN0Z6T3MvUFZEYytWQUY4dDFjbEEvRXhRSFo1MGtK?=
 =?utf-8?B?R2t3amU5a2RjNGhmK1l3elhPYVlaeitHaWp2VzRSLzUyRjNoYi9MUTZSeFJa?=
 =?utf-8?B?SEh0T1lQbzZ2WVZSNDlILzg5a053ayt4SHd5b0tZNVU3K3d2T1kzSW9QSGpH?=
 =?utf-8?B?U2l4RnFZVG9xZ2crM01PWUJMVTc0cUZ0VVAxYXJKYXRlTVFacXQyWG10WVo2?=
 =?utf-8?B?UHhRVllHYWhZQzA2TEUvTzM3bHExQzRUNHdkdm9iOWNVeE9DcTA2ZnJyWkJl?=
 =?utf-8?B?ZnRQRXRFR0orQkhUdjBNZ09sMjl6S09NNFlaOEs4UFIzNDBTeE5RVXpiU1dZ?=
 =?utf-8?B?TmRDamUyZGpmRVN4aC80TUJmYjBndytpTkpDNWtoMlNWVExxSmlrVjJick1j?=
 =?utf-8?B?Nk1QLzYyaHBQUGtTOThjSWRHaUxRNXRvZzF6SkZ6N2tXQ285ZDZ3L3dKRCs1?=
 =?utf-8?B?T2Y5UEhlbGc3aVk3eFlHOFk2bElhbHVjMk1CRnBHMG9tcHQrWVA2aWdyaTNO?=
 =?utf-8?B?SWx0UjE4NkJVL2xzLytMQS90MW9UNU9LeTEvV1U0MWJTWVplNmR6RkJVOStW?=
 =?utf-8?B?N0JXZGpPRHl6WjM3V0dYeXczeEtBNFp2V1NvdnBSaW1HRVJGREFwMHF2cXBy?=
 =?utf-8?B?eGhPSHRqeWR6bUQxN2V2WWg3U3JyRHQvUVgzRFNBK09POXJFdHNRc1FraXAw?=
 =?utf-8?B?M0ZwcGxMVUR4RnV5V2RXa2x6NG1ZQWdvcHNnd1dWVlpjQ0RVRmFPV3NSQjlj?=
 =?utf-8?B?TEFPZDUwWmJuYmNxZjJveVRNRDljZ21hK1FsYmZtbG5kVHEyVW85LzlodW5O?=
 =?utf-8?B?aFM3NkpxNXlWNnpIdy9HYTdjTjdZbDk2dTh1a202dDBOdjZRVU1yalpZem9K?=
 =?utf-8?B?MU9HN1hvNW5NcUFsRHVkSzRSd1BDd0J3aWZnenl0cWhwTDQwdjNEdWFTZGxR?=
 =?utf-8?B?RTFnZWtPS0swOTNKczY1TFJsOWcyUEF2QWVoeFdHdy8rNkdtTndjNnNNUmlh?=
 =?utf-8?B?RGMzMUVDVWY4RG04RklsQkcwWWZDSy84cjduQjh2WXdoMHIzcHdOcnNpekxZ?=
 =?utf-8?B?ODZkdVZ4ckJsc0FJM25wQ3h3NG00UVJNajVrK2s5RXYwZHRSbmQwSGVrbGgw?=
 =?utf-8?B?Rk5qRDJjQ2lhR1d5VVYzVTdCODVzSXNlS2lHZWdQVTJUclBhMm1Odno1OXo1?=
 =?utf-8?B?M3ZFNFJweXR1a2dqclpkenRpR2tSSFFmWWpTMlNEVTRhZGpWSmpDL2RPdnlR?=
 =?utf-8?B?Z0E0MnptZ3ZoeXZNaGhPVjJJSFVWTUlmdVNsVkR5b1ovR04zdmMxN1ByKytw?=
 =?utf-8?B?SGhiOVp4OGhST1R5QnNQcDBrRGhHbm9ocVNqZjQyQTVSQWxpSkhFdTZmZFlz?=
 =?utf-8?B?UGJ0eUk0dFl2SEEwOG1PSE1vUkZlTkFFamY4TXJjUUlSYjZ6ZS93SURYWEN3?=
 =?utf-8?B?cGljZzg5WUc3LzltWjF2TkQ4WllxY05pNVF2OUltQzNyV1ZsQVl0bWZtQi9C?=
 =?utf-8?B?WFBSZVZ4dUd6RmVwdzh2R0Y0VWFNS2NzVTNaN3Z0eXN3RmNWVVVDMS9icEJa?=
 =?utf-8?B?dmxVbjRFbHhQTXJyVXBWOXBEajIrZUtVajY5NEtUZEN0N2ZtTVpKaE1kVXI5?=
 =?utf-8?B?NHZIOGtJeDRiTEZnTUMxVW1PdUN1Wm15Z1dFanhsNzJPTGlyRS96bUU5aDhQ?=
 =?utf-8?B?NVhheGZjUEIrNDY1Qjh4NElmYVk5VnR5d285S1RyazFQSkd1cUI2MkI2ei96?=
 =?utf-8?B?SkJrdVVUUzRVYjBVMUZ1NDllRlpDelVVUEVibS9nR0RmWWpmZ0FDcDNtK1JP?=
 =?utf-8?B?NkN1cy9mQ1RYZncvSHRvTmlaV21NNUhrSklWVmZCTUtTTnVUb3Nnb1JIWWlE?=
 =?utf-8?Q?CtPFWM?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:43:29.0252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0b5aa-c0d5-49f6-06df-08ddf20abd03
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7926
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIzNyBTYWx0ZWRfXwQuYzKnsz59X iHp4GcWX/ZPmXVOGwApXO3FKJDbcABhvmz4yPW24CXOiJJZMwuHE7BTYbn0nF8+F7KRXumttTgo unzYuKcJ7S1j5RkCG9kzy3mV03RB6DFsrQlE1YwhjhtCKS9Pba82b1CcoVVUEZf9kRRmj95CjoT
 VmF0py8fACDGOD9v4pzVAzna/Q4jaRmuakS6LUnckCbXixZiIfMa95KLdKya+uSt1Hh2vYrhXzK /rVzfViKfhLLR+dvnlratmC6cW1/5/AcrBdDFt8Lo0q8FalQqWqx/sJ0NINav/lwE28MlN1x3nY 2oRFXBdeXaox8kF+00h5ykt2YAyAw6NpMh/J1HX2o8MqeaSBkQvVWc92w7y1AYbkOLFs8R/lRd6 NSRbPx1q
X-Proofpoint-GUID: A7anHXdJrjQG36TXvo_U1g8gL-kBiDKb
X-Proofpoint-ORIG-GUID: A7anHXdJrjQG36TXvo_U1g8gL-kBiDKb
X-Authority-Analysis: v=2.4 cv=WLB/XmsR c=1 sm=1 tr=0 ts=68c43193 cx=c_pps a=bHKZNIyHCbFJbiklqM0gWA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=d2j-ISUXm-8A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=tTjMO-w7lF877O7V2JcA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509050237



On 9/8/25 09:21, Raphael Gallais-Pou wrote:
> Following the removal of B2120 board support, the st/stih407-clock.dtsi
> file has been left unused.  Remove it.
> 
> Fixes: dee546e1adef ("ARM: sti: drop B2120 board support")
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/stih407-clock.dtsi | 210 --------------------------------
>  1 file changed, 210 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-clock.dtsi b/arch/arm/boot/dts/st/stih407-clock.dtsi
> deleted file mode 100644
> index 350bcfcf498bc410ebdb4fd00f2e1ea496a9c8be..0000000000000000000000000000000000000000
> --- a/arch/arm/boot/dts/st/stih407-clock.dtsi
> +++ /dev/null
> @@ -1,210 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2014 STMicroelectronics R&D Limited
> - */
> -#include <dt-bindings/clock/stih407-clks.h>
> -/ {
> -	/*
> -	 * Fixed 30MHz oscillator inputs to SoC
> -	 */
> -	clk_sysin: clk-sysin {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <30000000>;
> -	};
> -
> -	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
> -		#clock-cells = <0>;
> -		compatible = "fixed-clock";
> -		clock-frequency = <0>;
> -	};
> -
> -	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		/*
> -		 * A9 PLL.
> -		 */
> -		clockgen-a9@92b0000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x92b0000 0x10000>;
> -
> -			clockgen_a9_pll: clockgen-a9-pll {
> -				#clock-cells = <1>;
> -				compatible = "st,stih407-clkgen-plla9";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_m_a9: clk-m-a9 {
> -				#clock-cells = <0>;
> -				compatible = "st,stih407-clkgen-a9-mux";
> -
> -				clocks = <&clockgen_a9_pll 0>,
> -					 <&clockgen_a9_pll 0>,
> -					 <&clk_s_c0_flexgen 13>,
> -					 <&clk_m_a9_ext2f_div2>;
> -
> -				/*
> -				 * ARM Peripheral clock for timers
> -				 */
> -				arm_periph_clk: clk-m-a9-periphs {
> -					#clock-cells = <0>;
> -					compatible = "fixed-factor-clock";
> -
> -					clocks = <&clk_m_a9>;
> -					clock-div = <2>;
> -					clock-mult = <1>;
> -				};
> -			};
> -		};
> -
> -		clockgen-a@90ff000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x90ff000 0x1000>;
> -
> -			clk_s_a0_pll: clk-s-a0-pll {
> -				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0-a0";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_a0_flexgen: clk-s-a0-flexgen {
> -				compatible = "st,flexgen", "st,flexgen-stih407-a0";
> -
> -				#clock-cells = <1>;
> -
> -				clocks = <&clk_s_a0_pll 0>,
> -					 <&clk_sysin>;
> -			};
> -		};
> -
> -		clk_s_c0: clockgen-c@9103000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x9103000 0x1000>;
> -
> -			clk_s_c0_pll0: clk-s-c0-pll0 {
> -				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0-c0";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_c0_pll1: clk-s-c0-pll1 {
> -				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll1-c0";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_c0_quadfs: clk-s-c0-quadfs {
> -				#clock-cells = <1>;
> -				compatible = "st,quadfs-pll";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_c0_flexgen: clk-s-c0-flexgen {
> -				#clock-cells = <1>;
> -				compatible = "st,flexgen", "st,flexgen-stih407-c0";
> -
> -				clocks = <&clk_s_c0_pll0 0>,
> -					 <&clk_s_c0_pll1 0>,
> -					 <&clk_s_c0_quadfs 0>,
> -					 <&clk_s_c0_quadfs 1>,
> -					 <&clk_s_c0_quadfs 2>,
> -					 <&clk_s_c0_quadfs 3>,
> -					 <&clk_sysin>;
> -
> -				/*
> -				 * ARM Peripheral clock for timers
> -				 */
> -				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
> -					#clock-cells = <0>;
> -					compatible = "fixed-factor-clock";
> -
> -					clocks = <&clk_s_c0_flexgen 13>;
> -
> -					clock-output-names = "clk-m-a9-ext2f-div2";
> -
> -					clock-div = <2>;
> -					clock-mult = <1>;
> -				};
> -			};
> -		};
> -
> -		clockgen-d0@9104000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x9104000 0x1000>;
> -
> -			clk_s_d0_quadfs: clk-s-d0-quadfs {
> -				#clock-cells = <1>;
> -				compatible = "st,quadfs-d0";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_d0_flexgen: clk-s-d0-flexgen {
> -				#clock-cells = <1>;
> -				compatible = "st,flexgen", "st,flexgen-stih407-d0";
> -
> -				clocks = <&clk_s_d0_quadfs 0>,
> -					 <&clk_s_d0_quadfs 1>,
> -					 <&clk_s_d0_quadfs 2>,
> -					 <&clk_s_d0_quadfs 3>,
> -					 <&clk_sysin>;
> -			};
> -		};
> -
> -		clockgen-d2@9106000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x9106000 0x1000>;
> -
> -			clk_s_d2_quadfs: clk-s-d2-quadfs {
> -				#clock-cells = <1>;
> -				compatible = "st,quadfs-d2";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_d2_flexgen: clk-s-d2-flexgen {
> -				#clock-cells = <1>;
> -				compatible = "st,flexgen", "st,flexgen-stih407-d2";
> -
> -				clocks = <&clk_s_d2_quadfs 0>,
> -					 <&clk_s_d2_quadfs 1>,
> -					 <&clk_s_d2_quadfs 2>,
> -					 <&clk_s_d2_quadfs 3>,
> -					 <&clk_sysin>,
> -					 <&clk_sysin>,
> -					 <&clk_tmdsout_hdmi>;
> -			};
> -		};
> -
> -		clockgen-d3@9107000 {
> -			compatible = "st,clkgen-c32";
> -			reg = <0x9107000 0x1000>;
> -
> -			clk_s_d3_quadfs: clk-s-d3-quadfs {
> -				#clock-cells = <1>;
> -				compatible = "st,quadfs-d3";
> -
> -				clocks = <&clk_sysin>;
> -			};
> -
> -			clk_s_d3_flexgen: clk-s-d3-flexgen {
> -				#clock-cells = <1>;
> -				compatible = "st,flexgen", "st,flexgen-stih407-d3";
> -
> -				clocks = <&clk_s_d3_quadfs 0>,
> -					 <&clk_s_d3_quadfs 1>,
> -					 <&clk_s_d3_quadfs 2>,
> -					 <&clk_s_d3_quadfs 3>,
> -					 <&clk_sysin>;
> -			};
> -		};
> -	};
> -};
> 
> ---
> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
> change-id: 20250907-master-bb115f5b67ad
> 
> Best regards,

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

