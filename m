Return-Path: <linux-kernel+bounces-899685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10394C58AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710753BAEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE322FA0DF;
	Thu, 13 Nov 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AnjlFM7H"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0E2F9995;
	Thu, 13 Nov 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048675; cv=fail; b=XcMOTbTv+zGG/z7fhaco7bU5LxvFWwY8e2g84rXKZcqwM1XIKCbdAXuJY+v/Oye9ox7CLmqfYwNU+9+hlwzF872wtIuXKzM1JapJWtRck/8JiP9qh85EY7V64T/vGGK6tIJmINPo4pNjTQq0jZpSswT2HTsvO/5XW6IGxrqtzGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048675; c=relaxed/simple;
	bh=Wg2uvUCuKBCprCnD7LCic95+r0QdJFecCTaVmgJDK0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Jh9TB2w0Los8mPKhE9VJvujAH1Qd4HhbD695cylK2A8SzeGY6BH199tm9td2g3ZahHUIIkS7ydUIz6SeOqH0DL7FPGvt2bQjNSuEcQaDXxD85lB2CylC64G/bPoSOO+ylq7lLyTmqMN8rT6jjV2c+oEmjLbGBd+f0v94fK+ODx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AnjlFM7H; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF2Ig64118593;
	Thu, 13 Nov 2025 16:14:03 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa7e630-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuBQ47EHB0AlEIqaLPbRS6+YPtNwlAH+imd2QPHWL/DW8a2yU5kZ1duwpDh94dhKUtePeqv+9hIey5pctP2L1C/3YSYDTIHZMcQP4m/8Iwj2L0g14NgKakiZvfdT9kG98wJ34cUmlReKzK6gzUg8/oH5DoIId0nb/uCiJQ7uOVvycm81KPv2QG9OYZTK9uLo4zE/s+75z/Ju13Dqyy3kTfMlzasH3851mDd7MhB03XvYyemJipwkzbyIim7M41NPXFX37asM/tr2RrIe881Vc+T8nAszf9V7oMjYEWw5AQe9WmvISf4tDUHOJP5YuAfIxdVtuZZyRIGgHa7duBnTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8NlQdfXcveEtcPLAuB+E6YLR/5Ij587r8uZzOFnF+I=;
 b=qiQVtq2EJJagb7EPGDP8QSI1yuFLBxvQ88lFFVdM2NRakWwhy3tyGtM4bxUhDQu/KVt+rMlg2g/ydlvYVYAiTf5xDdwAcWZANUjLOanS5Pjv8Sk3s9X02pcyZsZDIjR1mGijNUfophp7fNwE2oGd3jX7LtiL0XEs9yTUKIEyx+RI0kAX9T9lb5T4aOWtxN0L9fGjqrGm3VRBjmR9+5GVdZN8WaWL3AFjwcDSbdE5K8IoYByg333Mg0gRaGalDCGPDcP98TtkcY5LpT9XBglzysXbjIhHzfh5T6sdEvwfBuHPzssZbyHeoia78vLQvW9UBLM5o8d8la0bEY91QCI93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8NlQdfXcveEtcPLAuB+E6YLR/5Ij587r8uZzOFnF+I=;
 b=AnjlFM7HruNmzsAxiWGgnP894FzAHm75SPsnwCefUgaK+OiAiKSFmX7XJt9NSS8TWXXdAeFYH5hZaUEGTQRjx2MPGnlUMC119pASWXKEhzu9NE1J9WesqWsQbjm8MDZhUOslsTMPG3fiA8ut0nB4NeSPVG/R3tRv/c2ydeYvG3GwwrhLMh4DYWb7Smxr12PEuAJhva1W7/XZXr6J1w/KYsleRxCl86vfBt7WMZgnfgK6Al3QAz4jGiR/5EqXcsL8Xmsx7NyMRXeBZUaIgywhCIWZhg/NRJNmDxancLlnskCdNl8BX0L21Vk4xSn4Zk8Ty7fKXWc0Y6fCcZWrbqyLIQ==
Received: from DUZPR01CA0187.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::17) by DU0PR10MB5311.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:14:01 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::30) by DUZPR01CA0187.outlook.office365.com
 (2603:10a6:10:4b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:10 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:00 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:58 +0100
Subject: [PATCH v2 07/16] ARM: dts: stm32: Update LED nodes for
 stm32746g-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-7-45090db9e2e5@foss.st.com>
References: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
In-Reply-To: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DU0PR10MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e08069-2e6b-465e-b968-08de22c746a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnBpZE1JNGY4eWRlelVOcW9XSDZlTGRod01jR2ZUaEVDR0ZXMHFOQjIrQkZx?=
 =?utf-8?B?NjBmMjhhQjFLeUZOUUgrSUxDTlJ6WVY0aU9PNWVlQnFCRHBYRU5kcXU0dE95?=
 =?utf-8?B?UEZLMEtvQVJScDdTQWdlUUpJV0lXdXlJRHNBVTUveDNMMDRheTlyb3VWdUxk?=
 =?utf-8?B?azUzOExTRmtqUFFHOGZFUnhYUXpleXFaU2lHSHYxNmlMQ2NJbHBCa0J6aG9w?=
 =?utf-8?B?WGw5dlhsQXVSS0pjZ0ZlL0FKLzVEUDdXTFl6eWg0a0hlVng2a0VLSHYwYi9R?=
 =?utf-8?B?UWFEV1lyMmhBejFyWlJFUGFPcEs3dm5ZcnEyKzNJRlg5a010SWtHSUM2cVZX?=
 =?utf-8?B?SWpCenlZeFhpSkk1NzdTVEVkbUVibStZSkFCQkZWSGl3WFJsU1VQRFNPUEJM?=
 =?utf-8?B?MSsyM0dnK1UzeXB0eEpMcTVJVDdVZUkzS3grckdUUFo5Y3J0NVp2NFRMamNZ?=
 =?utf-8?B?RUY4aTZJNG54eVlXYUI3RFVOaE5mUlpZYkdOWHBEVzBsclVEaE52azgwMFVN?=
 =?utf-8?B?dTlyNTZqRTFzbG5pcjQ3dDNiZ0RTVUVzczdXZm4xM1JTZGtVUjBxaWUyVkZK?=
 =?utf-8?B?dEFaT2lrSkM5bXNhK3dLYjNpV1o2dVVWQzJxSnIyTUQxUGx1WkNqcDFNbFBz?=
 =?utf-8?B?dHVBdU8yd3p6bGNIY1RIbklvQ0szUE1HOS9jQlJTODJ6MnY3ZmYyU3hSRmFT?=
 =?utf-8?B?Vm1uYktZVnpxRjdYb2tnY3Y5R2pUV0t4eGh3a1M2enJJSmYzckRXTk4rTU9v?=
 =?utf-8?B?WjhrQUU1dkNOMnhKQzJjY01aeWpMTG04bDJQOEhxMVNrNHVDWVhtemZRQ3h0?=
 =?utf-8?B?V3BXaW05ME5sd1JXSi9PZkQxS1F3YktBRVVFYXBYWi9oNUZvTCtXS0JsODBx?=
 =?utf-8?B?R2xXNzF4WWU5VFNMdW5Tdkc4S3k0eDVrcW5XcE5ZVnl2YzdLY2dIc216eFpz?=
 =?utf-8?B?WTdVcmxLOXpPYUpiWVVFUEF4Tm5YSEEyQittM2Evbm1zSDE1Tlh5OC9Wb2F4?=
 =?utf-8?B?YVRqRXJNblR3SUNkUmNQNE1pV3VKSGJKQWtWOERrelgxSitWY1BFaUR6cjFU?=
 =?utf-8?B?YXJhbGtndWw1MGs2VzlHMTJnTktZQWJwYS9rek9GWk0rdVYydHhjL0l4T2V0?=
 =?utf-8?B?NDRlOFB0eHBrOUZhcTkwaFE4S2owOUtFeWJEVWFaSW03cjJSbEJESnh5UTE2?=
 =?utf-8?B?MmFwL3VxcTl4YzZZMkF1Y1c2Q2hGQkY4SC9GdE5MSC9UMFlNSERvL1pkZGZP?=
 =?utf-8?B?dWRIQmlia0lxMGVvVGtJckN2UXRFYk1jYnVaUlV3SGhIbmtUL1BpREtNRHk3?=
 =?utf-8?B?VkFjZTVxWFp2dkRGSUVQb3pFdExqQ25uQ1JsVmJYSWlaVU9MdmkxYUFIQzY5?=
 =?utf-8?B?ZVNZMGhYWFVKZm5XbjJDWXVFb21hUUc3Rlpsblp2Q3NkWXlhaXhxOHp2cGF0?=
 =?utf-8?B?WUpYNjhMRC9jNHFnalhDUHNtUFVxc0NxeWVzZTUvdElpWkJPR3BtT3lzcmNN?=
 =?utf-8?B?aUNCNUtRN29zYVU0TFpFMWgwS0x6TWFnS2Q1V0NWRTVvRlZHN0xBOEdGVEFK?=
 =?utf-8?B?K2dxaGk1dFVLNXRrVUp1d3d4U2o2MHFHVXN2ZDFPZlQvMDhabnVnRjQxWFFN?=
 =?utf-8?B?aTZDT05rSHZMaG9GeTIybGxORmJSMmFsTk5lZmo1UzhVQVVaNkgxbUxWMm1q?=
 =?utf-8?B?RldIdzVRby9xMEVocWxoVFNiQzJQRW92NHRBV1prU1lIVWtZcVQ3VGRwWlow?=
 =?utf-8?B?ditIRGxnQ2U2cmRaQTFFVTZxaklUMVl2c3RxMU05eU13RXhKSFE2c0U3RHJl?=
 =?utf-8?B?YmxqcDE3OFV2S2NaMVlhb2tmMnc3akVuVnBaZzkrYVltOTdSYmFJUlhYNFJX?=
 =?utf-8?B?dFJPc213VEJiNjdqYTlZbWlaZURnRnhvY1BQZTZwVW4zZXh6VG1mMVVJdG9D?=
 =?utf-8?B?WDVlb2pldURMSlRwRHo3bHd4eXJpZlU0MkkxbThMZkY2VmlnSmExS2o2eGdY?=
 =?utf-8?B?RTRrcXJod3NXdVJGZkpBM0M0YVVGbi90N1BIOWR4ZmcxSTFMR0Q0bVRvUUNx?=
 =?utf-8?B?NnJkbWh5aTFXVUV1N21DQ0ZybnpzOGZrbXFHc1ZKTWI0OTU5cGlSQjZTeXJI?=
 =?utf-8?Q?sZQE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:01.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e08069-2e6b-465e-b968-08de22c746a6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5311
X-Proofpoint-GUID: XH0ioPIDvxNxttaYXzbQ9PB5BHN7Bdsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfXxSGHTY7TUKbu
 atk1b9SuL2/thD1w9+Qf2j7AZuQWrbOJHNlF9r+CXSeJHM5Jwkd0+v4X+gSo6MtpdeTTtJUk5lw
 pbmWI2p5FZ1QoYrvcx6NV4zq3c8RkbtJ+wM+kAN8CyGjQDAxY2SUp2WdWFVGBmoJS6LLwTrNLqZ
 rikLjTUvVQL+H0cRuDVS3KuF2wasqGJvv52TsPjoogExE2Qfu1EW3Gipj9KMP2zRQz9CWYsMmS3
 gx/Y1DcaXQmLKHvlh8HD0DVvTqVgzR+uWrFYY4wVgSYAFJslZYnug6asINkAx85SAvH4whF67nb
 4ChTEKF7oqEefLpLdZdLu3N9/uZ9Xng2T1yaIYOVg80eCb5PB/gbbU7mSlpIgCKw+pNGfyE5ecq
 XUKyaGW4sL2m1g0gQj67KohWv2ioDg==
X-Proofpoint-ORIG-GUID: XH0ioPIDvxNxttaYXzbQ9PB5BHN7Bdsd
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6915f5bb cx=c_pps
 a=MFwqwqiNWLUu7SydzG1yOw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=jhUhpFCSItG6WmWFtkQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add function property for led-green node.
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32746g-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
index e9ac37b6eca0..78ceec4a9487 100644
--- a/arch/arm/boot/dts/st/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/st/stm32746g-eval.dts
@@ -45,6 +45,7 @@
 #include "stm32f746-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32746g-EVAL board";
@@ -67,16 +68,21 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiof 10 1>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&stmfx_pinctrl 17 1>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiob 7 1>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&stmfx_pinctrl 19 1>;
 		};
 	};

-- 
2.43.0


