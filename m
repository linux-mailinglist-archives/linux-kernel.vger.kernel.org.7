Return-Path: <linux-kernel+bounces-897430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88BC52C81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 545FB348A71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66E343201;
	Wed, 12 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VbEIb4Bd"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F833C539;
	Wed, 12 Nov 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958450; cv=fail; b=EDAOKdbcJ9OdJ7YShhGoKuMrg9AWmTD6wu4hglpFHYXNfR17D2cMOJAxuG/z+O3lwwL1pjYZCdis7O+JJn00WSECbvc9gOvHuhCZqz+FP+1yyu9GW8P5yqaUIQjrNfF7I0I+nWdz1SkZeXl3zxWapOWhNptCuLntbe2o+hsPYzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958450; c=relaxed/simple;
	bh=EPs8O8naWGwH6Hf0V3pcpCxgtuZvs8UlTNTZbueHpR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X1cJxbmLvITP9p0ovp4hpDCLXSV08joQRAMxPe/O+bGGcpTldRU/GCumaEW4+eHkFPVcaFLI/XBEAxt0wQ5ZBIn4JRHF6VlFNakDN4OzU8IQbaBTDAme0PUMvyG4O3McVsmQqWvLQIqcu+jB0xHyQZ6zHdMUs2iwyF7Ib10dE1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VbEIb4Bd; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEDKQn1457886;
	Wed, 12 Nov 2025 15:40:36 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acfv8b5a7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwmqYtPy075FJ/a8fueeWB20QtQPCFJIzgXXTEbHqj3i2wxpp1NtEn7kbvxRxh+ZNVxpO4pxErHU9BYQs1VV7E9e6AKz9vkV4w2Jx+TzOEVRxATLk46cSVxb0y6wCWry2dyNAZsxkZlvaqDGGmoB9qRbmSyEX9qSvvVhos34oomoiqcXw55ofFb/UdX23pjis0Lms1NF+/2iCpCd7B9oKl/KaMNy2yQx5N2IlrlVybNbwVHnMTzvmE/gwin/nUXppecjn5F0tXK3+WMt+IjYA3qZgFZk3C/zvDFAR8ThmJy281UD7IbR2/2DaiF5W1w1+ok3DgQz3WaS52LaWZ8Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyQltLARqUdb/+FtUu1BahZmFyG459uceMGeo21IhBE=;
 b=aGnAiW56cBK0ba2mXi9utbRuDgoBDNkvxgHAlvrEb2KaxxrV0uy/OdSYj6qRDN/YWLMqXe9oiYXF6XSWecgZ7VerzXpK3DCklzHfqjD7XnbsFQ8vUGG/QcR3Sb4ZMcsTO1oiVqMnnAkG2rwT1LBhYGRmsW0uKG1gD33s36FcwoL40NHe6Ave9y76k3NhSEM9FjpMLQJj1fVSfYUGUb1ZVGpXz0N2mjKUdQy0e+HkpLlcy3FcB1BcPhgzrqO4elRqzngipfAZQD1lsUQ0SiUkv+ZRwQblr1QKFmWEkoIHBnewyiI2upUKCbY93KXeDLJuKcaZ1piYcLHSVrnq728S7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyQltLARqUdb/+FtUu1BahZmFyG459uceMGeo21IhBE=;
 b=VbEIb4BdNNBnk9LHh5BEcWkumdTqsXEbIThpBRbzlSG9trR8omWBmvUYgrKyyKOyGeYMUc/bcpNnLIH6vOh0iCnlwcZ5JNjCZNCO54pWU6IlVUibjytvY4hDLedY+wRC4lPT7DyjMYS9zFbGGK5sauo0SfmjtlcX4dkksPO8eXAlS37RaJ4LBXIfrOa0vgXi3c3e+tT+PUBtBjzhBUbC3Rmc7li2ZW86Qy7Y7qvgV3Faj2WZg+I51JD/ZPBhdMPVdYD7Vj7uZmvNRyHD+vu53u5Vay1dKQqtOoSziAilZvmI0z7vVvUlqTDI8rrPlvmjurU6OiMatdih8DPG2c3cLA==
Received: from DB3PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:8:1::29) by
 FRWPR10MB9290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:17a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 14:40:33 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::f1) by DB3PR06CA0016.outlook.office365.com
 (2603:10a6:8:1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:40 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:31 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:18 +0100
Subject: [PATCH 01/16] ARM: dts: stm32: reorder nodes for stm32429i-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-1-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|FRWPR10MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fad99d-ace4-4630-c6fd-08de21f96ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWEyQy9XNUhXUnY4aUdBdzMwdlZDQWpKWU9UNE5GREpKLzFhaWdseWFNSmNE?=
 =?utf-8?B?V3ZGYTlPNWw1VW8vVjZZZlRscDZWeGJvcDc2Ty83aEZoTVJWM241b1k3MWky?=
 =?utf-8?B?UThuZ2NIUEdrMWZqTEZmNWVKcjhZTlQ0ZUNoL0RZZ0J2RkhBdmRIU21TTHdQ?=
 =?utf-8?B?QThZT05KNDhLRGRGQU1rNEgvL2l6UExlSEdKZlNDNHRoaGNFcnN4eDVkTjc3?=
 =?utf-8?B?TGdZenUrcDNxOVFFTHJkNC9UZzN0Q1pFblQzbXJsY2hhSk9Oc3YzMWs1anNG?=
 =?utf-8?B?Y2prT3J5anBGbkhNSGVRNGpUNmFkQ3J6aFJwOWlLb3ovemN5TWYxZ3dhYVZk?=
 =?utf-8?B?cGJwUmQxMEpxRUZzV1V6ckxIZzIwU2NHVTBZa3pMeGxYYmJnTFBuMWFwMXNJ?=
 =?utf-8?B?TVowSEo2WWZUeEZIa0dDMG5adzd4STZsVjZ0ZXFIdVh1NEtiaWQ4ZXhhRERQ?=
 =?utf-8?B?bHJFUUtDM1FqMEFzQ2xOYzJ5MEdqdFI4RTJ1M1A1Um5DenBRRUJBVm9lRVVk?=
 =?utf-8?B?SE16N2lOV05SZ0hWZDJzOWI4TU51clVsZk9YbzRlTFNFSk92cG56bHREMzVV?=
 =?utf-8?B?V3RvYzhrcWdLSHBLb3pYNzZ4SVZCbS9hckhRMkp1eUNsUHExUko2MVlpU1BU?=
 =?utf-8?B?d3VjWDFQcnlIaE5xenZ4UU1GVDVCN0J2alZHeFlpT2VsYW1abE1LdVFlSmti?=
 =?utf-8?B?SU4xQjc4dVozdTRCamJaeDk0dmEyNGVkcVY3K0RMTXBRa1R3UWorRExacHpD?=
 =?utf-8?B?cjR6em1nbGZNZzJ0N1crN1UzS2NPa3IwajcwdnAwdWdTdHJzdHFDYWhtUzl6?=
 =?utf-8?B?UFl6YnRteTlHQ3ZTYkpVNHVjdGVrZXhraE1ndlVRZ1RqTVROdS9SN3lGYVQw?=
 =?utf-8?B?RzlSajRGZmdaSSs5VERqdTFmajRWTVo1T2QzU21uU0o3cnJGTXFEQXRRcDNC?=
 =?utf-8?B?QlRWaWRhM21WY1hKL3ZHYUEra1l1TUhaMnVsdXpkOWNmbzVEdnV4alowZHFm?=
 =?utf-8?B?T3VsZFN2OE81ZEQzcElTRFcwUkhadkpDYWN6M2ZIQ0ptQk1PN3ovQlJ4TE9h?=
 =?utf-8?B?R201eXhITHFSZWtmbmJTaCs4YTJHeUN1dHM5WEFEMDRrK3VJVzQwL0hubTM0?=
 =?utf-8?B?b3AwTlpQc215ZUZVbXlOQTNhM3cyc1MwaHlzR3lLc1NYQ2wwQ24yQVdlK2ZX?=
 =?utf-8?B?Q2hJNWcrN1NrZXYzaEhSTGxVd0k1RHFsVFdwZ1pWdFpHNkJ4Zk5WQnJsQzh0?=
 =?utf-8?B?U3I3ZmRJRVhtMWx6M1pXUkRaTEJ5RytEbjUxSlhaTWZnQkd5MEkxYWVmRkJC?=
 =?utf-8?B?ZE55Q29qbVJQTlBNcG9oenVhOWowVitBMlc0NjhTOXRaQ3B0MDNmQTIvOXlZ?=
 =?utf-8?B?K1FZZ2FERXNQV0FUTVFRd0FlVmNVVUdyYUxCWmhLLzlsL0Q1aXhod2pQMyth?=
 =?utf-8?B?cC9yWGVIQ3hlcU96enI4ZFlzdmtmdm11NlRZMmhaaDNkMEdwcGZOUGJoRXVI?=
 =?utf-8?B?NUxuVW1LaldSQ3ZPRGdGUDJmb3RyR1c4ZnJGaW54RVY5bVVwdzI0MXdrMTJN?=
 =?utf-8?B?WWF0QWg5S2pGa0s1ZVlxUTNKMUR4WE8zandwRFpTaDlRTGpZc2VHTFRkc2wx?=
 =?utf-8?B?TnRRdlA1dUtWaU82MDhpa2tUQWkyQ2RlQWJUWUc5UWk2TXJ2aEE1TUlwQzBo?=
 =?utf-8?B?THpNd1VuNERYSWlXVEQ5QjV3Q3k4R2dWSFp4YkloNjZ3YjZucm00blp1RzhX?=
 =?utf-8?B?dzBQWEExOUY2TFB4dm40VUc4MjgwZzRNN3FMVHNvK1N2S00yWjhPV0dPQ3FQ?=
 =?utf-8?B?Q2xyenZ2enUvNGJSRTRkRFVFVUdDMU1aYnQ0Y3hhSkNOenVrbW1OZmZRZjZs?=
 =?utf-8?B?OVdZcFVnRFo1TVhLNStnK3RhNUlsNWlkTXoxWDIrdk9qTnROa1pOVzhGY0ZB?=
 =?utf-8?B?ZHBCbDN4S1c2dzc3MndUQ0NYRUROSkZhc3lwUExZM2o1SlB6dHRUNzdzOGxY?=
 =?utf-8?B?THlucWpIZjdsOGVhZjRlTjNObHVIeXZsZkpKbTIrWnhrU0h1U1d2ZTA3bHp0?=
 =?utf-8?B?eXVDS0hmZ0xIQ1VtZnNjVWhWd0h4SjFqNXhTTVJUSEVLRmYzeVhpL21XRERl?=
 =?utf-8?Q?8JHw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:32.3183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fad99d-ace4-4630-c6fd-08de21f96ef2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9290
X-Proofpoint-ORIG-GUID: mhlBbkER-rBDwRPh43Ain6ByM3n6EoYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX6fsesn+20Oip
 9LkfACgjwSGfGnEBynWJA6Mo7qRFdI1egwJ+Q0pNAIzK8Jgl0ceTkgMjlMD569CcZe7W5zYGkiN
 WQ01B6YiCIckY7ZaS7M7OWWD9HItFc+M54PDmw11FWwiS1k13/uaUnA0/yh/Z9B2kgBxdlzzf9i
 gk5u1GHpx3UgDcWwWc1OrHN0KgH/CA5OpT1T+seuij2mLwVhqQd0os23HfF1Fv82mIJB345BHfa
 xef+qDKR3BLpAhOSfH+Uq6X7dISKdkMSFPir365XGCbUCbogMFE3YI1tv7d3dco+qyGTC+EjyNS
 IIch4VGSCuEFyiOzn62N1AaVcuKg9SVG6Djgx82f0mYLFx2ndQ7gf4vEgVx5QtxNGcaiPvbarAS
 CltkpRXW1/RFe/53vnVCKWZrRutspQ==
X-Proofpoint-GUID: mhlBbkER-rBDwRPh43Ain6ByM3n6EoYI
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=69149c64 cx=c_pps
 a=CcFEla9EprtmhgrLblTNNw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=sCyeEXTu5xOGXj2OjYEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Reorder nodes by alphabetical order.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32429i-eval.dts | 57 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index afa417b34b25..aa224d7a9e2b 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -82,27 +82,6 @@ soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
 
-	vdda: regulator-vdda {
-		compatible = "regulator-fixed";
-		regulator-name = "vdda";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vref: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vdd_panel: vdd-panel {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_panel";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		led-green {
@@ -135,11 +114,12 @@ button-1 {
 		};
 	};
 
-	usbotg_hs_phy: usbphy {
-		#phy-cells = <0>;
-		compatible = "usb-nop-xceiv";
-		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
-		clock-names = "main_clk";
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 	};
 
 	panel_rgb: panel-rgb {
@@ -153,9 +133,30 @@ panel_in_rgb: endpoint {
 		};
 	};
 
-	mmc_vcard: mmc_vcard {
+	vdda: regulator-vdda {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vdda";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vref: regulator-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	usbotg_hs_phy: usbphy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
+		clock-names = "main_clk";
+	};
+
+	vdd_panel: vdd-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};

-- 
2.43.0


