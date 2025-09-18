Return-Path: <linux-kernel+bounces-823156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D3B85A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222DE7B8B05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC231280D;
	Thu, 18 Sep 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EpTEZTma"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712B1F0994;
	Thu, 18 Sep 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209759; cv=fail; b=eKuPoxIVH/W3V/HelGr/Qf7wXxgq9YhHda14w7jgNarS84KnG1RfQtE3lzJJz5zN+S8DM2ubJcnLRfNosUhFlDSUM81BrxQ5GXUbLKVDHtyyIAoWSVB7j5E01f4tvedvbGw3oo1vDjFGhvHZqqyyqsh3TLK7rWyOXfWsq9XfW8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209759; c=relaxed/simple;
	bh=jlw0VjbecExv1JPy1kgkwsTdLFkp3Bkyh5itW4LVsIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Uq0A3iuwchwCvVAUoJ7omfJXoqCRLEa46xkxqOw4Nn+NJIQ7PkUf1JpaZk0G532LJaD9RXRpg3qY9AvyRSY5A8DnrYzFX/Uv36XT28hDT4fVrlnsUEr87kkBNZAsupTIPAbEJI3OSkY3mpIt4Aq7tgDayH8KQFEAJb17M27VwiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EpTEZTma; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDNeR0011813;
	Thu, 18 Sep 2025 17:35:47 +0200
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxv1hmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:35:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0kVl0OPpENghr5V5+a017qfw/cZA3Ggkm3EYnjd1aH5186m+OJlZEdnwsYsQJXeD7J6jNxPvpkLJn6zGsR5IbWlnAHgPoviinq47aSVMsMqPaSFzwGVj4NdvhUMEy7FfAWcWlrO/fmRXySYqB0JZRjtxL197MhKLriJcn5cpNMGHkypkIl++CCdm3vZnxdwfpwmAjisSHYezwoNKvJX0c3bMBA1qHvkCYbjNMDmmBMrspXeyhv4azKTpfKr51cC7+Kg/OvE5iflpNKUrRaZ8gLQufUThd4wthDT8+3t3l9HynH2g6X3DphEcoxCxKTjhnEq5pvXu8Mp8qWgiUuymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwCcYaYiztNJGQLe10j8vcl35a1R7gH+Qjqr/1KxYVQ=;
 b=ssNz8d/sb+r7OtSFVlJF5HJ5oEWBDqGyuQeDdzP5pJBFwoNsX5jvqXsZj3bz1VslY6xkiutqI4w8/0TLWSthCM+uZEPNAcMhgVYngqzAL6jRGVaU6JAm/9jIGNGB0+aWd+lO1ynbfIx60AU+9UbbFq3GMuUflLHfpwp7JqZ7FVnILniq66jDlTbPWZkzG3glqOI/EaDuAcP5XnH7x2K2Uj9kh8E//k4HayNJQEYw1E7TwyfbW9M+ERTEeudimmex197xTUFAt2n963bATciCqi1SZ/GD7aBAWRVEN+vRCUYcQL/QGxfA5kF3IbSTUHx13cD10dJVLosJYyiVHb/31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwCcYaYiztNJGQLe10j8vcl35a1R7gH+Qjqr/1KxYVQ=;
 b=EpTEZTmaWAhZRGlH7xi2t/eqbkQtwSZGBQWZkwoGxI7EjafITYMKBR6Cx6TyzPorDIdYYLlNjuwIyqwyDtKN4PJqELRKCaIgOFTwYMMtl/N9YA24ul5MrD5TuGpnPZo5crhAB+ovNofhqL2ho5YuKRDWyYdByX8l3yZL8KFXg7Im/nz1Ru2tj+PDyZwygF79NdfpzxlKc2kb04eSIVM34qb/WEFh52SGU5uYvUJkpoeBVcKxRaqhig7uWft51VGhKUxjCjbPSxCd95zcMsIUteO3f5ifK22Xus9z89Y+GmqO4+vsjuUO9pgqJfSRMgPrP+7IP48r1CRlsUSMY0Iu8g==
Received: from DU2PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:10:232::20)
 by AS8PR10MB6971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 15:35:45 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::e) by DU2PR04CA0075.outlook.office365.com
 (2603:10a6:10:232::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 15:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:35:45 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:28:42 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:35:44 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 18 Sep 2025 17:35:39 +0200
Subject: [PATCH 2/4] ARM: dts: stm32: add the ARM SMC watchdog in
 stm32mp131.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-iwdg1-v1-2-02c2543c01a5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|AS8PR10MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7b0040-0ba6-4b29-281b-08ddf6c908ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZEem5mTUtBbDJtNzlZSWtCSXB5Rjl4Mi81SG9QVHluazlPMS9WU3FocVF3?=
 =?utf-8?B?TDFhdUc3RXFBWXJVNWJNUFpHNmg4WmQvYWxEM2JSLzNhNE54Sm9zRVpVMkZQ?=
 =?utf-8?B?RXBmNHRERHJ5VWpFSW8xM2NPSE1JKzVqNkQ5VnFBSGkzKzBHWUxjdEdBWG15?=
 =?utf-8?B?RmlmNXlseVIxR0hzUmhmQVhPK2tqd3liUXp1QnNZaFVkRnNPZUpHODBqZ2xM?=
 =?utf-8?B?QkFxZE9MTDFnL2JpcUFjS0ZqeloyTnJTbzVSZ0h2S1lTSFpEMmN1QmNoVkRx?=
 =?utf-8?B?d2FkRWZIQnF4SVVna01uMGJlRFlCN3dTcDlwY2lLemlKclhnWXpueHNidXFY?=
 =?utf-8?B?RWJLb2lpdDFuNkp4TVVlRnVoYSthcTBoYVlTeGpHc3RQU3hXQTVnKy8yUXJT?=
 =?utf-8?B?NHhQNWlOVDJJUFRtdk9SWXRjUDFIL3QvVVA0bEZob0xOVHJibGlKdDIyaGtv?=
 =?utf-8?B?K0pjL28vaWJiQ2xEQnVDb09mdmZ5ZU03b3FFZGxWWXMyamkvUVg0RTc2UW8w?=
 =?utf-8?B?Y0I2U3Zmc3hTMFBqVWNjVHZaWW1sTDJ2a2FYenJaMGdQZ0J5VmZZMHVuMWIv?=
 =?utf-8?B?WFZaRTNmTFZEOEt3WjFCT0tkVFNKL2RKRDlnM3g4eHBNY2hmZW80MGpqZ2F6?=
 =?utf-8?B?T3pPeWFHbHcwQm5KaFBhakVJUnAxaWVxOWVpNkQ1OVlaVW5jNkozaE5McUgr?=
 =?utf-8?B?djFvdU84R1hCQllWNGtQdS9JY3k2bWFtVkVaREVaWGFQbUVSYmI0cWJ3aFJI?=
 =?utf-8?B?RDluZ296YWNBcVo1R29TYXR0bXVOZUlBNlIyYUJhTGhuOHdGV05ad1VzekJ2?=
 =?utf-8?B?SWRKZlpaMWNYK1RNeGNnemhiWEZMZlF5aDlsRjZybkRGVTdTNzZSYytnMnZZ?=
 =?utf-8?B?dFdaYmFNdzBIano2MzdDZ2NVbHN4eTZSdDNrbW5KRGN1SngrSGJUdlRSTG5M?=
 =?utf-8?B?N2lmRnpRNEhPckdFVm5NckNyQXZDa0hiREQ3OXFNeG10SG9VVFlhRTVVblZ6?=
 =?utf-8?B?aVhhQ0NYT1lSeitFU3JzUEVPcGhLRUdVZzh6WUJUVzdRVUo2REZZQk4wZlAx?=
 =?utf-8?B?ajErZ0pSYU1UUW85MjczYjVPVUdDS3JSRTh6T1ZOK1dhNW5zNkRPY1hOSW5w?=
 =?utf-8?B?YnZJWmRjM0tDWFhKLzBVaFhpUE9IblZBTGFhUFptSWZLZ21MV05tVWI5Q09Y?=
 =?utf-8?B?TEF6TVhpTWNyTUFHY1VYbUY1RGJFdW5NS3ZLN2lZMXhLemx4TWplWmh0MEtY?=
 =?utf-8?B?b2Q1OVZPWWVhekNnU1gzK3RMeUkzdzIwZmdiaERLdEU2eXVTeVora3JnbjBy?=
 =?utf-8?B?ODZBY2daVlpiME9hREJpa2FZQTZPUE1DUG4rOXpsRFc3N0xxc3lNYUhjSHM0?=
 =?utf-8?B?NGdGR1pWTGw4bTY2cGwyS1UrWTBxcGZkZ05zMHBKK1VMcHhEZlNpVXZqdTFo?=
 =?utf-8?B?OGlEbUVMeGtxU2paZXZVQnJycnNjSkZnM0NLaWZTZjNtZWtZTDg0TkxJaXhE?=
 =?utf-8?B?ZkVGdWI1QjlkWFh1aHNYNjd6TlpyNjQ1dWZEYlZFSmhSdGp0a0E0SGt4eXNx?=
 =?utf-8?B?YUQyRUVyVTE4Q2dKSWhlLzRSWVhQaVQrQnpSTGwwS3krTUtUWmo2TUlCYzFy?=
 =?utf-8?B?d2t0ZURPYTlSZFZKVVQvN2xtSXFtT3dXOEd0Ulh6UUtGMVFDTXNDT05mU2VC?=
 =?utf-8?B?WGx5Mjdic1hwdFF2a0pjcFU2RXdkaGo0K0hhSWpKeVV2RktEamZBckgzUy9M?=
 =?utf-8?B?LzB0R2UybHdKVEJ0NlpRNiszYXkyUSsxSjJMQkwyN1BiMDU5eXZpTVlJcWRu?=
 =?utf-8?B?dEt1aHUyY2E0OCtDUmxlQzliZFY5MEFuY3ZDOWVCNXM1VHNmTDlCSmNiT3F1?=
 =?utf-8?B?N1d4VldWL2crL2FlWVpJSUZPcXhNelV0d3lJdnVERXVnMG5sZ25tYWt5WEUx?=
 =?utf-8?B?RUFGR1FHKzBkalZIVmFoTVZnYURDK05FYUFVcGxVUkcydUdxQXJwOEM1QmtR?=
 =?utf-8?B?UjhsMlpBdG94am42R0loOERVaDdxL1VLbDhiM2l3VGJLeWl3MnVRcDBJbGRw?=
 =?utf-8?Q?JyN7oh?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:35:45.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b0040-0ba6-4b29-281b-08ddf6c908ed
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6971
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzL//lEdHUakW fSsFDHc3ptUzBvbcmkFC5toOR2JgOncMcXh7QJR0S6IQD651JmGoHFpGTNKkE/VRiBMdPLX5pNk gvdtXL4+A7hqdV9zvzS6MUN+kZIEB2+AsGzOXzJZ/W+V3GYV0J/NAzProhTF8Yu3ufx1riZtDCf
 5WxAA4G2I5wzK9yk7t6K6NM9t7+4bRKPfkcaCUVqM8+JkFd5zRMSq5wVXJn2718nsUbKg2tODY4 DJQnkXFn1i6LBWiGeI79DkRpNYWb6B0O+NviZTxlPV9MpVM9H+OzdEYR9zVlW3TdJAL0GVBtlEt hZj4+k8yimdGWx7cFDGiuojaEys3qvruxmwohQREa6xzwTtNd++Sl7rNkfbvs4v2krkPGvo5A33 O4d9nQoo
X-Authority-Analysis: v=2.4 cv=TtLmhCXh c=1 sm=1 tr=0 ts=68cc26d3 cx=c_pps a=5ek8fjnuUT40V7IhO9r0iQ==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=2HN7e8rGrflJ3QlucGcA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: vtjt3QvkGjoz2toFdmeaFAjzkNm7bebt
X-Proofpoint-GUID: vtjt3QvkGjoz2toFdmeaFAjzkNm7bebt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add the arm_wdt node in the stm32mp131.dtsi SoC device tree file. When
the platform watchdog is managed by the secure world, SMC calls are used
to interact with it.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 583938ea5c08163b1b100a2aef5894f4a7f34a51..ec385ad56bd42b694d2eda6a4a98c021fb3f25e7 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -29,6 +29,12 @@ arm-pmu {
 		interrupt-parent = <&intc>;
 	};
 
+	arm_wdt: watchdog {
+		compatible = "arm,smc-wdt";
+		arm,smc-id = <0xbc000000>;
+		status = "disabled";
+	};
+
 	firmware {
 		optee {
 			method = "smc";

-- 
2.25.1


