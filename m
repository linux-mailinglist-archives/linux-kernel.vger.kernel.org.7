Return-Path: <linux-kernel+bounces-897628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EEC533C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B707F356DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD2343203;
	Wed, 12 Nov 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UUSHrnRE"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059A33D6F7;
	Wed, 12 Nov 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962530; cv=fail; b=psNvRb5raeIYrB2588JKCyIiTYb3zyryENeR3OOCCwu+7c8n8+seXwpViqOSnTW3NoOc6TRgh7zlzZWrw5eV4fPvi70diq6dcUn9C9nV8zpb1yPaodFwKw0SXZnui18t88jPoFvnYwbuEh7+hQdo99/ip7jr4FED6tMa/jbS5EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962530; c=relaxed/simple;
	bh=+NkG3DftdI2XqOxvp57B0Yz+f03j06gzUyLIZmPV8sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cMEscDGXeY6RJGFPP4fvQO9p07pVsJy8n61cl06ryQU9WLxopXZIoVCtgfdPTjaysbGgg1CHF8oJSrBDi5ClwdLI2i1VhagF68zpkFI393JtvcL3Er81+2Df8gccZvfmPSV+rjLHlWVr5jF2k2CcdreS/VdhuQjcBaF3sckHtVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UUSHrnRE; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFbFwP1508844;
	Wed, 12 Nov 2025 16:48:36 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret996k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scBw3BAw8tFFAdOeFTxAQtARD/OBv5i/xoO5GIrIsvY8F9Li2qopdImYVUvxq2gopykmQDCwHkE2Ij+y1/QcoTKuGJ3Ta7G91D0M0HEmkFuqFqTXtUZRFywrXx8wuBB1XTPyA2gV+KkRxabUBKxTyPlrC2GRaxiq78zdQZI3Wp2+9DTPcpziXlgH65nWdZVvs9t13Noy/Ur9Vut4Q/crtGAT/2rXVM4JJtCHFI67ussz545ewbTGumPr3FAoEectMaHqJnVG2YusG6aUFGn+vgD5Z0vLTeNsf+dGqACwq0/mYIH8wcCn+o8vbWHK6de9phIqKsUv5FVPs3X/2CfUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmwZaSbSL3mgtdkb/YdW/LVTaYA248r8c8D/lR5Lv/w=;
 b=Rz9Wn9u+LbIvM7Zplge7oHvoujRrrM1hg5UWtEXc7RbheIh33UH1A4pdk5zrac2eLqDew/pMCNGF59/8GC1D9/B5xU/J6h97oQifDu09nDmDfG3kvWG5P5fSfvHK+MVi7H+uNLYT412CYMBJXGOXNxY0PpZCeaNXxveWHVcK8IXEx1OiJczJfbokNPXQscJWUJqP96CprhFUbmwXglUQfTpRE+tMOOUPym/mj2tdmYiVF/oA2WlW/Eq7ugnaND2DhjsVZexAWhwbZv5fuZly756Yn439NOtYmwSVCJpJy/4b4Njg2GBBFnVPWKQS3nWX4qJ0BXR9TCzKl2oTmg9y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmwZaSbSL3mgtdkb/YdW/LVTaYA248r8c8D/lR5Lv/w=;
 b=UUSHrnREyx46N95ACWPP11cpB3mDnoEHhoOO7eNEM6HisKBEF4gLgb6PEYUuc610UeQYsZcCmD7KE37i4g/NXn1uWAeygmAHn4//7lILx4gYcVBMYVgp8d2PytVhpAr9PzPn68sLFbQu+isCfLjJnWAIC3kkpQPojwXnfxKLBLddgk3amKoERd26RfxYJHW1Akzrx3GwrmvN0AHm0ZToY+UG0nZQCN0OmEBLtAEpAtM5wnGeeVSZlYnpVzPUPBoYdrEKQJL76d93Jmu40GTLE4QXlwoVyxIEkAMKZu1597H3Tg/Yp7eqabjlZD9FtdHB8GEsLHVCs2va5Nk9C3aiGw==
Received: from AM0PR02CA0145.eurprd02.prod.outlook.com (2603:10a6:20b:28d::12)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:31 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::1d) by AM0PR02CA0145.outlook.office365.com
 (2603:10a6:20b:28d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:31 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:39 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:14 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:05 +0100
Subject: [PATCH 02/15] ARM: dts: stm32: Add boot-led for stm32f429-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-2-50a3a9b339a8@foss.st.com>
References: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
In-Reply-To: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: c680b495-111e-4361-01a0-08de2202ee75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UktTaTJwRnk1dHR5RjNJNEUvTG1sbGlBMXM3T1pqdktGcTZZS2I4RW9wanJ2?=
 =?utf-8?B?MlpJdVU1UTVHakdXT25TK3R0aGZKUWhJRmRxTFV3U3doNkZvS1V3azM2WFpN?=
 =?utf-8?B?dHZVTUNpM0hMeDF4SHQwZTNjT0xYZW5QRlZ4ZWFlcVpoUlcva0xXd1pvbmx6?=
 =?utf-8?B?YkM3cExiZnczQjFCYlltcEFQbDJWaTFNWmZuU0JmMzdlcVQzNzN4UjEwMTVw?=
 =?utf-8?B?LzJHSTEzWlV5SHpwYkZRT25GV3k0WGJpZ0J4dzg1VGcweVhTTjdOL0VaWEVv?=
 =?utf-8?B?cWhEbjl4MVlVN0xaUHcyVzA3K01Scmw5UXRPMUpHSVd1aWc3b0VOTVlHQ2lL?=
 =?utf-8?B?M0Z0Q1lURmN6WVgvbmNPVkRVQ3IzOFJaNENQdjVOZ2V5cC9OTklZT1pLME1u?=
 =?utf-8?B?aG9jOGllR0drMVVkQjlyc1BabmtLMXUzSUFzYnBySlltcDJ3c3NteFV1WndS?=
 =?utf-8?B?ZEdCMHNlUjl3bGpwZVlPZEpjRlFvbDJxUUV4eHR0QUdoUnZLc1JxS3prVXNH?=
 =?utf-8?B?TXhZMjRaWlZ1ZWxqeGRweVFmMWdrWTY4TmJGYkdJU3BWTEdmS2x2QnBJbmFD?=
 =?utf-8?B?elc1TXV2Tk1rQkFFZnBnS0xYYjNqRVNDOVZEU1czNDhsTTJQazNtQ3M2NE1B?=
 =?utf-8?B?R0tiTnhNZVRWQnFnUzlza0ZMNWwzZzN3UEJWeUdzZHdUYVpnbWd2L2Vwa0NW?=
 =?utf-8?B?Zlcva0p0bFVGVFhZYmhIdHJvYVNkdEU2NjBwU2VwMHZ3L3pUczRJVHE3WWw1?=
 =?utf-8?B?cVBGcmVXVUFIVW5lTnhvM0ZEeU00RTFHSFpIb2M4V3FkenFHQnovOUlpSEs1?=
 =?utf-8?B?dUJJZWpOT01xWk9PZWQ3cmVsNmZHQUV3NU9jd3lTTmFYUzhLVk0yTmhMYTMz?=
 =?utf-8?B?b1p4ZVFQY0lnamhqUzRqcHF2eGR0RW1Bd2JOU0lUbXNTVHhtMlQ1VnZtcWF0?=
 =?utf-8?B?MGllY0pVUmVqTXBnZWhvNnJBaGhwbVZEU0lLdlEwb1pjSDZ3SnZHaUFJeGxw?=
 =?utf-8?B?aU1ZdGxaQVdxT0l6RTJZM1U2RkVvaVNQcjhJOUM5Zk5peityN1RQd2llZHo0?=
 =?utf-8?B?TEhCanNJSkVreXo1VnBNc01ud21Va3gyaExuL1paVE54alNMNjM5dVFqa3Zh?=
 =?utf-8?B?bWcxUTd3MldOOG5CdVlPRkZ0NzI1d1hxMWZ2OXBQYzdoSTliWENEdFd6Y09M?=
 =?utf-8?B?RmczREtIazQ4TUpwNjBDSmJ5ZEJzU3QrYVNWV2E2L1JPYVEwVXJ6T1gwazZS?=
 =?utf-8?B?OWJtd0gxZXVuV3FMbGQzUFpudGY3Y2dlRzJObGt3eG9DWjhDYy9FaldVSXFO?=
 =?utf-8?B?UGFTbHNmOStwTno3UlZHNUpSZ2dnMHpiOFlHVUk5d1BwNHRCMGRGRWlzRTFh?=
 =?utf-8?B?NUcrd3NzN1p6RVo5WDNUMDVNQm5wNzhrYTJYcTg2Mis5KzdJQy82dzFVSkhF?=
 =?utf-8?B?T0EvczhCUGRrV084cTZRcHJ4amVWWEVjUnZOMGtPRVdLWk1iUUYyQ1U4VThU?=
 =?utf-8?B?TFBMVUZ4M0o2TVFXZ1l1RCtKMTNmcEMxejZaTXU2bHhFTGlUZDlLU1BYa3BL?=
 =?utf-8?B?M2FTaUlYUzRkNXBFUzJ2c05yaHIyVm5XS2lOR1hUd09rN2MySWhCRU5jb2k2?=
 =?utf-8?B?cmpSY3RaUXBsUnhmeVp3Z2NmMlc5ZTB5bFR2cTVHWnlCU0JPeW12NEN5VzlX?=
 =?utf-8?B?R1QzREIyWkJIeTB2SXJ2NlBiZlJ3cEdBNEdJTnFMZFQ1TzZjd0RFaHhqOHZB?=
 =?utf-8?B?Zk5IYzJ4d1dKWGZ0NWtQT3g4dEhNbjlONnNhVGZ4WjZlTzVRNEVGd3EwZ1NJ?=
 =?utf-8?B?SThJdWZiOU4rNjJyRC9BRkI3Yk1DQ01RbzVicTBGZjF6NitqYXBuY3NWM2pi?=
 =?utf-8?B?MFhKcDBDZ0xQRGMwSWpVVzZOL1hFa2llQXdSU3NmMmMxMGdTZ0drUVcrUnBI?=
 =?utf-8?B?bXVvR3FNeUtmSTJqS1pUUm5DVXdhV0RWa3FRWGJYRU1NME1oQ2ZkcHM5Rk15?=
 =?utf-8?B?WVcvNTNla3BtZ1d1UndHOVhJNHUyT1ZkZitlWTJyQ3pFTThZZVhYaFd4NG0v?=
 =?utf-8?B?OWxKNHY3Qit3MEo3ZUU0VXNtd2dLaTM0bGg0VTZ6Qi8xZG4rTHcwYUtySzRs?=
 =?utf-8?Q?cXcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:31.8273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c680b495-111e-4361-01a0-08de2202ee75
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Proofpoint-GUID: RkoxzRXB4vch7ELf1DHAm3GfsrUk3Rh7
X-Proofpoint-ORIG-GUID: RkoxzRXB4vch7ELf1DHAm3GfsrUk3Rh7
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=6914ac54 cx=c_pps
 a=IZAV03aadox+VGuitpplQg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=0iCDxg-yZm1uZczScZwA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX5WwIS0Fw5bvN
 iMPC3ccdA9wf+UzaRDHsub5OnMphfRldAMJKoYcLA5amhs4RlpLpdanAyPtnT0nUB23N5StYtgg
 MxAzrhGm0gskWUfLfqsnYKnYwOtqphFD+hcaBXIvDglA9U+G8lbHIz3kFCXGgrQQrDsarbgbnOK
 nt3xrtWTE8qi7njYbeNqRin/3gBT6gxMN7FTFAQZdkB0AFVMoqjcG4VALVMY0xrlzo9R3MitpiK
 aZmtr82UrVvtc7iTVLReShBz7mQEAhFYfZsirk0vI57M9YIEQeYx11623wAEmItySYbb6ZYXhvS
 rWdQfrwUHcVV8OsvJsbUlye3LLBKQ4jW7di6cTbPc4F/pw7RWSw9ilzY3X5Yrc8w8Ogtl7SjZsQ
 DLfTFudCKKVIVxCSsfk1UKf9VAjUtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f429-disco.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index 15f92842c8e1..ded369abee4f 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -77,7 +77,7 @@ led-red {
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiog 14 0>;
 		};
-		led-green {
+		led_green: led-green {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 13 0>;
@@ -95,6 +95,13 @@ button-0 {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_green>;
+		};
+	};
+
 	/* This turns on vbus for otg for host mode (dwc2) */
 	vcc5v_otg: vcc5v-otg-regulator {
 		compatible = "regulator-fixed";

-- 
2.43.0


