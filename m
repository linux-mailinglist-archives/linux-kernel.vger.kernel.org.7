Return-Path: <linux-kernel+bounces-879893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A7C245A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02728189938B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B2334C17;
	Fri, 31 Oct 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CrrwoT5B"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA962D9496;
	Fri, 31 Oct 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904891; cv=fail; b=ERo/4I8/RSqCNLhvZagqPVkoHwtPbYUqcZriDiBbSJHCAsoRhESiKP4kGEvqE5ph3c0Epojuuphmwm+X+FywxeF1GH9PDcB92DIV65h41aJOtnatHTBalKs75aTYJSpsiPiptPF66hZRbfX+gl43g2YwvsXLiDFfx5Az0ClL6AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904891; c=relaxed/simple;
	bh=2lquPveRUdGsi3Y2TK+76PvefKqQEIRqTlKM3Fm91zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ra+fgLZt5hXB9xNPDQugYxM5HaDIS+2wa5iEcSl/4NCUQ3UFsUuILwJNavcBBjG/tJocpewjm0/RWGKdrLrBLd5JHrpCvem3c7LgG0GiSMW7PQFnBKV03cxu0earqSbU3l3fRj/zKVdjB1TOtC8WxuACtEAL2jGdvM6J0TiMfiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CrrwoT5B; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9u4pL3958809;
	Fri, 31 Oct 2025 11:01:18 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a4mjcskb1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 11:01:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdvWoj8kHFv0wfIUDt5ocz7ZjxDDzQaAeqv253FPAmHJjav33wMMMa7yah4ZuyKLZ5dC4+gyL0qfT1wvgwdD0Fe/0YJ35M8aJK/xF43ecn1GnynaNfdUanhNMg6zkWYlXAPEvUhrULpR0Km8PyeXVL1x2sGE7kd5CrtgNdndZBHr0ja8ltRmPUJDOJLfaAYVPzt0EtQ464cgdn+hKYLPC5ERrMR3uGY670pnLaXCo/iOFj8ya+xmVxvkORgdeLMRd0u4mJjSXsX1hw3Zbz40HspPWIVYyZbcie+6hHCMWP55NSaHg0bf6DNmIQuofRZoB4YjIqiMAEmPtjeYtlAwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXzTUy/wuiDEOSozhHPHWUmehMLsR8BzEK16zR56oiw=;
 b=Mke4uA1VIwPXlWakzQsYwN/kzvBiBgcxFLjX8DphiherTPLz4DZOT7qTYccJVrdpnVQSMLMynbebcv8qlY/BlRNGbf+UcNVerD+QkHXpt9xzWYr0rqy9ym9zlRZLjyKV428azXC0JV+pYVN1wnbWtPuilbPZ2z5gIbHEpSfpILTq1moIDlF1BwB1lKx0tJxWjuHM9SuIXrHF/23Gw42wM0GLn6vDqbgT2OghhSJkan8Rb/pKZii2u3ucaraOZqQUcMoJXQJNhIjOtuWrtGz90GzYFHPaE9hTpeIdSv7Vx2tBaLVWHvcnrlmfEXf/eIUQWZPP12TmlGAeS1Bax8qTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXzTUy/wuiDEOSozhHPHWUmehMLsR8BzEK16zR56oiw=;
 b=CrrwoT5BeaNrusdTWPRbnHxIICxxiEAexIGt9Xlm7KryL9QeLPspMjw0bsnSu1CI3lVRHAjMuC/in+rrrsz1bh9RfZ8wchsU08yHX9C9L/jha/FsU6ZCRIdCIa9M//0O3XuZmx4Y9ZEdzpc7a6C+ni1mUEUw95MiI/L0lNxG6laUMdMFAloHg7+8BVwuWnDCMBurKCsJO+Pj79ujP7MJMCS+5UtRO7eFlIMHg3ZhaMQMMvV8kqMldMvh8C6xtZqFd+riHfvRdtTA/Y5UXdtBqCBAbpTxWWQH8tlRQ2OgV0DxHqVDxw77L5tg5BkNGiBiK4jD5zSRP9f/3kRKsLIhUg==
Received: from DU7P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::25)
 by DB5PR10MB7776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:01:14 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::b4) by DU7P191CA0017.outlook.office365.com
 (2603:10a6:10:54e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:01:14 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 10:53:48 +0100
Received: from localhost (10.48.87.185) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 11:01:12 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Fri, 31 Oct 2025 11:00:42 +0100
Subject: [PATCH v2 3/4] ARM: dts: stm32: enable the ARM SMC watchdog node
 in stm32mp135f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-iwdg1-v2-3-2dc6e0116725@foss.st.com>
References: <20251031-iwdg1-v2-0-2dc6e0116725@foss.st.com>
In-Reply-To: <20251031-iwdg1-v2-0-2dc6e0116725@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|DB5PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 91da3976-9b5e-4470-cce2-08de18646d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdIcXFZTUkveDVqUm16L3BvSHVFV0hFWTdyYVB5Yk14Snc5dnIwWDBSN1hV?=
 =?utf-8?B?WTNLTFBiTUJDVUR5OE5YSHJVQ1FjZ1g0NUtlUFZkUkk3bDYwZXFJSkdjeUlp?=
 =?utf-8?B?UEdvNUZCaXJ1a21ZemlrcWxzNnBxcmtQS0o4MUV6WDVvUTgxNWtHSitWT3JK?=
 =?utf-8?B?c0xTaFYyaXQxVzNqRGZ5UWJFZ25QOHlqSXZ3eklTUk5nNXlZSUhhOC9XaHVv?=
 =?utf-8?B?TktYWVZaVG9FRW42eTRIai9CQmVkNU16d0lZSklrYkkzTjhBaStEQ2tySlBJ?=
 =?utf-8?B?MFJCZUt5bmYyb1lzcmRTVitSOFRNdEhNZThoNVI0bmsvTnBxUkFnS3pEVVZY?=
 =?utf-8?B?WkxsQ0FWVFdyM29vNVRGSU10dGh1T0xEMnk0aytUMEdJaVRHQnVtSThIc2hs?=
 =?utf-8?B?NlpvVmwrdjVoSzd2TmJwdWlBcTVuUUdMUUlWS2xHZ0NCcDZiZ0pGL2V4N09P?=
 =?utf-8?B?QlZNOXAwOFJyTjgwbU5nbUV5dnc4bTJpTWFJRExDU2tldGszTjRpSXFQUVd1?=
 =?utf-8?B?UXZmdVY2ZnZSMld6TW4vZ3RFeVZzUjMyc3N0Z0F2MTZjOXV2NzhwR2xaUS84?=
 =?utf-8?B?RjJCaVhPcEhpRzJLekk3Ym16RmRBTUV0a2drTEdxbm5wYVZCVHpiM3VnaVd5?=
 =?utf-8?B?RzJ3c09GYjZWT1d5MS9uTzhkNksyM3owakhEZC9tbFRDT0k1S05RTGlYT3Zz?=
 =?utf-8?B?dGFmV2xjc1p2MFpYL1pzbFcvRzhWSldKN2F4MHBwQ0tZUGxoZHEvZjZCcGR4?=
 =?utf-8?B?cHhWbVp6QmZrUkZ0elFVWFpVMXZxUkFEWVEyMUxJVi9wOXlJckRIazQ2RmxN?=
 =?utf-8?B?LzhKMmU3czRQKzJxRDE2VXQ0M25HVzFWcGN2d3c5Yi9MWUxyZ3FDSFl0a3NO?=
 =?utf-8?B?VVhCbWlvK3drZEd3OUo0ODhmUU1mUDMvUkhsVjFDb3lzN1p5Uk5JVXZXVTVW?=
 =?utf-8?B?ME1nb2p3QzJ6RkhLVFVXTnFyV1BOWjNwV1doS0NIc1VsS0hHT3JKKzZNcTA4?=
 =?utf-8?B?K0VqcXRLamJ2dU5sZ3dXWGFzQzU4dXFia3FMRWozeWlkRDhHZ2hSS2thZzU3?=
 =?utf-8?B?aEE0ZW9jbFFuRDV3dGZzOFJYVmk4RWZmd0tTSk1DdjQrZ3k0N3QvQ1IreS9C?=
 =?utf-8?B?WVEyWWU1N1BtV1kwY1BNYnA2aEZwUHM5UDBWVjArdklPeVJ6elROajMyTTdO?=
 =?utf-8?B?aHFFOGp3V04zSFFrQnowZEQ1bkIvaktmVU4rVjUvZTBqbnkrS0dKaUQ1OEx6?=
 =?utf-8?B?MFR1Z3QvbXh6N0VJeFhsdkpIejZaYVdVdFptQzdPZ0tKZnFmSVdIbUE0dlQw?=
 =?utf-8?B?L044QVVaSzQ2WU5jTFQwTis2Y2V2RVNNUE1jalFFSktIbXV0UnFRZHR0UHNx?=
 =?utf-8?B?Q1hUM0FUY0E4TjhGL3B6aERaWk12WVp6WUMvY0R5cS96YUFyV3d3NlhHUktm?=
 =?utf-8?B?ZEN5WEkrbE5sTGUvQ2N1RDdEY09XQWZtTUJzVXRBOVZuVnRjVmY5S1hrc2M1?=
 =?utf-8?B?VmQwbDZNei9jT0VGMXR2eHRnQjMyM2tXWHoydGUxenluRHVQZVp0ZGVya3BN?=
 =?utf-8?B?eDZtb2xKd01LTDZSNW0rSkEyZDQ4ajMra2xmbFh5L25NT29OdmFUWURaOXZV?=
 =?utf-8?B?UTBibEIyODNDazNXWDNUaWczTEF1OXpMTW0vQXNuRHdXSTVqVVNzNnk3Z1JJ?=
 =?utf-8?B?K3JueEIvQi9BWmpvQXVpUjExRUdsTFYxVll6SmtpcjdEWGRhY0xzeHQ5OXZB?=
 =?utf-8?B?ZklVWTRhUDE1eUY2MUJNVTZrVDVUeXlPdUVxYTFFWHpZd1V5QkhmT215NUNC?=
 =?utf-8?B?WkEySTVvSmlGSkZBMWlYQmh3dFpQaXVXTWV5czQvU25ldFVmaEZIVk5IdWtT?=
 =?utf-8?B?SGRSZS93V3E4YXZoWUd3N1NFRVJpNktoR0t1elIwZUw5bGhNTjgrNWdGa3p5?=
 =?utf-8?B?UGdqTXJ5bWpQT2ttVEc1d1VGejFRdThhL3NoNklGL2wxK2xEWXZKRHhYN3Er?=
 =?utf-8?B?OTdLRkIzNFM4bkJPSElJcGV4NE10K3E2Z0EzSmkwTXo5alc2dHVqbm9MMEky?=
 =?utf-8?B?NWhERHgvY2RNNGNWZ3BhaXQwZy9USkNaVXZHMHhJdnFDRjhieDg3UUJJSS9x?=
 =?utf-8?Q?01VQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:01:14.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91da3976-9b5e-4470-cce2-08de18646d5b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7776
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MCBTYWx0ZWRfX86kP4jQHN+D7
 1RMHUjRDwKGPoSnO3qd2QtJ0hoGvbVkMY4T2vQQiX0pgOhwyGPOlKqWnziPkEl7CIWknKgCicut
 Fk+/Vf48oaEK5msjq1aeX6b81EFclp92D3oZFbWt+dl4XIAtwCxxYBpMxxYfBIvKXR3ZSu2FZOR
 ydxv/OvfMMOAi7CVI+eAA6mB3UuPUlYXr2zlAy0zz32GOBOI2nzGBB8DYDj+3hXkRdkqmBzUUCx
 fM8acDSiVr3ycGVh3wmkCwVWkXFV9OUzozxRq0pgJsxbLikxq29qm2sxN/Q+17AuABGSLZNvAF4
 cPeQHJYt0D/MrgK3NEb8ELU8aodfa6Kp/ByIOT5OWmNc+AuC8z98etAVA76/jZPwv0j1SjnAWiI
 tNm9xDfQIA8HDGNTns7fqSTaAgiQzA==
X-Proofpoint-GUID: KD7jW6FLVAdTh9ZzNCn6DEMBIz4ypMei
X-Proofpoint-ORIG-GUID: KD7jW6FLVAdTh9ZzNCn6DEMBIz4ypMei
X-Authority-Analysis: v=2.4 cv=Xtn3+FF9 c=1 sm=1 tr=0 ts=690488ee cx=c_pps
 a=sVz80lr63r+noJKTyf6duQ==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=Uqnf_Yzwn4G3_ghC1w4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310090

On the stm32mp135f-dk board, the IWDG1 is secured and used to monitor
the cortex-A7. Use the ARM SMC watchdog to communicate with it.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 9764a6bfa5b4..f894ee35b3db 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -161,6 +161,11 @@ channel@12 {
 	};
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &crc1 {
 	status = "okay";
 };

-- 
2.43.0


