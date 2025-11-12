Return-Path: <linux-kernel+bounces-897429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566BAC52E32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA5A506772
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE134320C;
	Wed, 12 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="B5WO/pzM"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557433C538;
	Wed, 12 Nov 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958450; cv=fail; b=QeT0pRIMjIT+1KveOd31a/JmwlSNmrxZ1CT6B59Pq+SbucJq2faMo9c7w5s80Joe7Pl9KEWJXxdICPqzwnztne8cbhttnDXhcMA5dmwOAYAWRDjhX3rfbKgnpCL8St41ZOCWSDyVvpH/6ZayxPYdlTld8t0aG19RihtRx8BNLxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958450; c=relaxed/simple;
	bh=qYKp8OovI92GecoohfNr7h0HP3VXOLXPpA6ZMgWY0Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hW7d5rFYJ+RiVDUqdlxW0jSmDdscH0UHXzWbFFjBPggAIK1dLyN4chwI3jsd2v2/legFa3q19CHD5Acjq0CiB0hGe3DUTb1a1PHARffByt/LlkZdf5E97OcvBTHGd3YsmvpPSvS6rW9V/eTI+LXeSa+5NZNj3KyQyD6EiFo584U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=B5WO/pzM; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEX7VC968356;
	Wed, 12 Nov 2025 15:40:37 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acq20hfht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CukR3Aj+LaU6bdAQ5KXSy4ojPb97uSHTuWKs4F9eErXXPF2z/zwEbBed0VPBuYlP8b6tfZAE81PY+IDqdPcB8jPRMJX5eTEMFVxNrOdZ+N9xmVmHP/TYBuqh3rHIsi2slon6g4dbvlEW4cbqAKXKXsCXIBpw6ARUr3v4d4P4QT/fMm7KA03gtvJtEJGhzf+XxY5VzUkPLiF8B99C8Rc85sU4vjSrGEUTpWGQOTJOsUj9W54jBBmxbbThuwJqt6JN7PMbajlzF5AdGt3F7ZfD2CxPC9umyEGdfhmcIRfBqMfR5gKTZ77zfvjTDWkdfRa6lUOzCUXyUHOsYhap6quZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+rl9UgHHA/sUe/13L/rwNoq89UPoQvQo1v8oVVZYno=;
 b=jPtVqFG/bFu8tmYeJ0pGOBwd2parQhj1xlpx/DK1eTaSaQhJ8VI/yDNq7R+F/i5QunfRXcxpJELa48JlEkbHLrl8zYvjY+Cw69/F8k3kyg1Rwrb4870WrBGs4HXQPzn8ji1DU7cTxCVx1/ZagY8m60vsLTxJk53xQLMZ6tKW+UatHUuP3soqTB2cD1wQ0uLEWTc6EFHIvZ7oGUwfqZ3ZrRbxm1fCdq4WRFNXwE3NwdlZcedaIG70O4wWlBELPF8PiTyMWsKmzSTtv75H/j0DaUDS53eIfizGhu9Fxl+KzXuQlqLXgAp1ZrgKK73g7DbX6fDpcYGiPPMf4Shi9JCFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+rl9UgHHA/sUe/13L/rwNoq89UPoQvQo1v8oVVZYno=;
 b=B5WO/pzMZMbHWvZKnbo5GrvFSTxWFksAl6Ua2sOynN6ieNekVDKZ3VZR5+lpXJApolGdCEXUtVkhX9IhTybeHrg4JSX6mNnMXbzbrOKZvEtRevSI7B0W+KEy1xng+BHWDW3TGJn7HfK+DsOccChs4NfeWt4VbFlrC/cY4hjQmmdBlTZZWSVjNOoFA1GHFL1hZuZ3SCAo8UkTV5SRyetJt6ZgopmOdUbwh82FG7Ry1I+RqDBw+yMF4li4WSdb8rYKvcWmDjVjWx925BP0dEMLhbCXL02JiPNawu/9E65uFpKALJQcyeuJSs/4bO+XieR9csN8GsLR430TS5A4merC9g==
Received: from DB3PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:8::44) by
 FRWPR10MB9464.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:34 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::2a) by DB3PR08CA0031.outlook.office365.com
 (2603:10a6:8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 14:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:42 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:20 +0100
Subject: [PATCH 03/16] ARM: dts: stm32: Update LED nodes for
 stm32f429-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-3-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|FRWPR10MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c150763-7adc-40b8-a1da-08de21f96faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0pTWTdKNXpRWWo5TTJCK2IxUVA5MDJRVmlWUkIyQjRhcFlhUDI1cU9TN01m?=
 =?utf-8?B?RXg0OElNSkF3YkU3Q0NRQThhNUM3QU4zTnJhNnhxdFdIT1JlcmhaZCs2ckdQ?=
 =?utf-8?B?Z2RlVlNadmpJdThCWWlKa3lPYzhtbHB5OGlVczdtZ2dZWkxDYmNnbWNtZFZp?=
 =?utf-8?B?SFByZ0xGaDdUNnRGTWhwdDkvQnEybXJ0OThFTHYzNFNaZFZDVGdyZ0NVSmhG?=
 =?utf-8?B?T0tzSXZPMEZHbTRBaXFuMTFJU25DRkRrSXRHRTIwUGJCT29TcG1oTHFQayty?=
 =?utf-8?B?dGxMejJsalJIaG14eStZL01xUmY4WjdQa0Z0UzVicjMxcDE0MmJYMUJRNmlB?=
 =?utf-8?B?V0JGeDFGc3pxTkpDYkx5Z1JuSS8wdUNHcFNkSTlsaWlyYTZOSmw0K29YbXpU?=
 =?utf-8?B?QTdZMm0wdG1ZelMzZG5mUk0rNVIydmN6bHhiSXErTFlRVFhPR2FUVHdaeGd2?=
 =?utf-8?B?bVAvSUgzY2FMWHR5M1lXVVJueFE3TDJhZGNmcVIyS2tsdHp0T2VYaW52NDBo?=
 =?utf-8?B?Q0JXOHRSdzJZWDZPUGdJVUg1d2UybWVOQ2VmU25NOUlYR0ZGSHZRS21sZkxN?=
 =?utf-8?B?ZVJOVER5T3c1MWVQV25ycWJYNHN0MU5kckFoZlZpNjhvNVJxUTdIKy9Mb2gz?=
 =?utf-8?B?Zk1LSmwxai9CUU9mejJTTFNJaDhtNVNSTGtmMklQWkNKZ0dqMmdaOTlzeFNB?=
 =?utf-8?B?cUtnOFFNTmIzMkR1ZDE4Z1pNVmRyRkRISVJXY2hia2hFN09VTGVyamJuc1Nk?=
 =?utf-8?B?ckdkSEJnT01tZUFzZ292TFp4eHc3bkNFOHBjWG9FSFBhb2hMUzFoUGZRalNS?=
 =?utf-8?B?d2RucGt4YXgxd01DQVZPcVBFK2ZLcEJlaWVHSzRTRmVlYzVJZlFCOEpYRkhY?=
 =?utf-8?B?bmhuanBJU2REOERvQVd5NHFvWlpsRHVSck5mZkRrRld0S0xSMHQzdmlFalY1?=
 =?utf-8?B?OFJQVGxzeTg1UWw3V2FwUEpwajFxQlpzd1RyV3FSbzJyUnJEWHBjaXAzb1JQ?=
 =?utf-8?B?VU1iK3YrcHA3R1dtMmRTYUo3SlRRM0VOeTdUR2piaDVRbm0vZmtPZWN6VDht?=
 =?utf-8?B?WkRESW9VY3haek1Dd2VIZEhHY1ZWWUlSK01IM2kwcVEva2NBeHVGeHU5dFRa?=
 =?utf-8?B?YTBYU2VYTm13bkM5T3ozcmM2UllUcUZPYUNBWHJuUGt4NjBuRmhXb3JwRVVB?=
 =?utf-8?B?UHVUNWs2MUxkSXkzU01yeUpzNlJ2dEIycEF2c0cwbHRIWTdoSHVQbkREbEFD?=
 =?utf-8?B?ZEROdTVWS24wd01JYUVPUVptZWNCUnJhcDN1d3QwSmtHL3I2blh4dTM5OG5R?=
 =?utf-8?B?NmRwUXExN0NLYUZTQUxtblBpOGZmV3lWSy95RlFmeUZFbWZ0YzdvdTNDNmQ0?=
 =?utf-8?B?ZGFrdnlnYVVrbHZWTWQ4emFWQytjOFFYdkk0bk9QYjB2azJDdVJWd2xYckFR?=
 =?utf-8?B?QmZHdXBOSHA0N0hmTm1nTENyQmp1UW1DMWV4bzh6SEMzcGtBQWIxQU80YUxi?=
 =?utf-8?B?SkxqNEZadHlPT1BrSnV5WWRJdk5ZaGlrN1JVdmFlRGFRMEhWMTZMcmRPbERL?=
 =?utf-8?B?Y2FBQ0x6YmZOVEFYdVB3Tmdnd041WnIzaFVNY3Z6VGV0WERVR1lQdnFZWGZt?=
 =?utf-8?B?Yk1HbDZPYlRaQkdXUFp4WFdiVnkrQncrd0JUVlgyblpzQWM5OFJETm8zUmgx?=
 =?utf-8?B?d2VWVnJuS0R5UEZtdUVKZ0JUWEFMRWdMK2hoUE1lcFF2YUwwb2h6dTFkdWly?=
 =?utf-8?B?Smc2NkY2aXlKY2F3MEs2QkR4eGhEN29manlUWWxPb3BEaWFncm51ZlcwL1pk?=
 =?utf-8?B?WXpjY3VzcWJhY2ZRRzcyRUI3TytraVc1NE40UDJsRk93OGdScHRkSGJZekE3?=
 =?utf-8?B?K2hzRE5JTmZsSVllcE9XaEdNbmFPcjRQVlJVLzJlYWJtRmxFL09jSE1mbnpB?=
 =?utf-8?B?WHhDUFk1Z0ZhdC9NZXNlZE9ncDc1ZXB1TEdFNUxCdnBNY1hBQzBCU2VyanlL?=
 =?utf-8?B?SVcyWk1pam1RZDZURE5QbzNPQWpnVTBEMXN0UTJhdnRiOXhrSmpTQmxvYU5K?=
 =?utf-8?B?S01idnB5aCtvSHh0bTVvUC9yaXE2eDJwWjlJZlVra3A2ZnA4UHhpY3JESVdo?=
 =?utf-8?Q?cX30=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:33.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c150763-7adc-40b8-a1da-08de21f96faa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9464
X-Proofpoint-GUID: cxTCrek_3OxHLgtfkCTPR24jftKPptJh
X-Authority-Analysis: v=2.4 cv=LaQxKzfi c=1 sm=1 tr=0 ts=69149c65 cx=c_pps
 a=m8iHvvLLOJGK8HPsQbaY4g==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=LGokPihkvKNT9fXVwzQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: cxTCrek_3OxHLgtfkCTPR24jftKPptJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXyxnTcwMPhwhh
 i6DyZxEsoPfGqXhyBmDV2GTF0NiOyfxCi7qwSHp2s/UnQBI1un9PK4l+GbtDZQCI9P3BX/rH6zr
 Yj9cnO6ODGbXrxZgXXG4QB84vzheUMKyEjS7CTSiBZZp0vb8ODgWaDZRarhx23F5k3xRWUOcP8y
 ChpC0VpwwcNH1GA+O4lvRAe8+hc5ut9B5n282IihEEqR8eWhjX3xQN2wxFr+m6bUfIFSIoo/rcI
 NVRYs8sF62WNxpV9YmCz2clMEwJH3gT6hxIw7cUXIXWAieZNHnXqYiike0wDb9Rs33AeTdaIfdj
 WTnhWYygHsOHXw3/8yO02zRjLA3s0XbyIniKZ0tJ8lKm7iFsUSPpcITGwK7st3MkWJYlYa0fxj+
 p8SlfqL9BjWko6IhIKD2UJKScxpkeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function property for led-green node.
Add color property for LED nodes.
Reorder include dt-bindings.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f429-disco.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index a3cb4aabdd5a..15f92842c8e1 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -48,9 +48,10 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -73,9 +74,12 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiog 14 0>;
 		};
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 13 0>;
 			linux,default-trigger = "heartbeat";
 		};

-- 
2.43.0


