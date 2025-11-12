Return-Path: <linux-kernel+bounces-897432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC9C52C84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44C9B348614
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB7343D64;
	Wed, 12 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="STMvTE9Y"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE933CE95;
	Wed, 12 Nov 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958451; cv=fail; b=uogjcVpRPm/I/xjh77Y3HZzxabxYt9qWgv4cE4tvSYAY44AVw7jVGto9LLKhnQCqu8OUeIOqEztJeIYbivQS5QqlRVHdeUzLlZurKcV1Lf+JCAcgqYpxsyXahTYmjak8QamD7WruBD+VGDk2cA7p0DKx9nWVptCJTCbQv1refh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958451; c=relaxed/simple;
	bh=NhhNqklUckIxqqI17TMhtzq73gWs9V6YjGp3oNl2HGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B6A055+8pbTZmTRGnZu9YT73fDaYJ+n5T9BnfMr8M9z4bdxkM9TBGVCsVJ4CxQptbuYPEBXO/IQ7kjCTHiz0gecRpXGk21m4c1/GdOzMiVfNz24NPima9kdqGNaDGiopnDonNwT2aYcj996C1m24W7Eq9OEJisZszky2z0GQLj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=STMvTE9Y; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEZCiU1393964;
	Wed, 12 Nov 2025 15:40:39 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret90dg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD5VGc+xoLCUKyb5Xy6PHE2Qs4TrShHoSp2gREwNNhRVHBP5QeziSAsW2ccMYK+eNfi2iSonHywMRe1m3ABVcHwbti8ww5hX4JTmqe82wzNQWjYlPeknaz3E8EumO5DZ3WsxR7T7WzBNZe+bVgNqEvo3iHqTIL6ff2CdQFe+5uesXGmjXETKJi27KGgBYZnIwQVovipVm0oW/osOLrtSgd+VkQGq11MLDBj2NQ9XoHjw8C+aRp+0ZQEh3AkmoWkXYjZ5ryaa6F9c8qFq+BKFllathRonXBCdHITnuchs8I28dqCHCZ15dXjQOzZVCkDvHzv5LfP7YBpphOyTk+95oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iitov3mhHE+W2Z/pcvw4H/SBaGFy3IKk5KT4Qg6ePAE=;
 b=vIAm2egSHqgql04e75ow/iv9SX6OUmukK0LNJ2wpBbzQbs4YSGkVM6v6Jk4WduB0PU2t3zOih6kbiMehE6bFR00MFws8l1s7tkUj4YU/YDA7x2k/WKFF8I+7K0lwDz7jopGpQt8u65eDVCtg5qkK2A7OZla3VMKOKsgolMwhIRLxshKg9Nc26hv21OB6p7wdioEdiqFkGvZ+lQdaF4GoHMkHZ7Sq4uvZyumMCtb9OsgBIL8xOen2qxSRucvUGfK4ILjW/qHfpcFdWEXlfZ3wXu+eIKOkxzGr6yDFYZifBpC7IA2Y8KICo1N3WybrLFmjI2vu2j9dMVVaJKLCBbFVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iitov3mhHE+W2Z/pcvw4H/SBaGFy3IKk5KT4Qg6ePAE=;
 b=STMvTE9Y+bt1Ioq6vMb5MsMFJ8mfR6mmN979DDwL2+8Elrg3TOZgIPGtP6AbXvWDodOUJdydLc5F1nCJxW8Pj+VWUCo+Pam7vF+Ppanl41ID9unD+URn/VVoIaWugwF5Jyftn+cbkX2VilgCUQI0zdlqQstYZCsJtBdr5gZVxpiOMARUKZjLflBvTvNN5g3GgftyNHEx/K+QoLDw3IZqXLrpVjp90JsOcqHMJivrmdZQAM3Ww3gmFJZyhKVVe2QIarN4PwGs0ila2uFJWnqc3a+7DzWYGYXJVmJ64YCvkx63qnv1iJ1+CvlAOmLEvFKnnCQUZqRbsQCxbkjgGYGNCg==
Received: from DU2PR04CA0211.eurprd04.prod.outlook.com (2603:10a6:10:2b1::6)
 by DU0PR10MB5432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:35 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::f1) by DU2PR04CA0211.outlook.office365.com
 (2603:10a6:10:2b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:43 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:34 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:22 +0100
Subject: [PATCH 05/16] ARM: dts: stm32: Update LED node for stm32f746-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-5-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DU0PR10MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: bab5001a-e0d9-49d6-62c7-08de21f97089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTErdTNiSXVkekplZldoUmluQzRXeThiTmw5bU1YZm1UWW5TUHZDbWUzRGxF?=
 =?utf-8?B?ZEY4RW1Ma2RQZldQQ3JXWXFVQTEwZTZGdnVuWVBINmU5V3FaLzhFYmMvSFFB?=
 =?utf-8?B?MU04UVkxSEZVWUxZdXFybmF3dHRZc3J3alg4dFpPVkN6bWpOWG9KaklpSUJH?=
 =?utf-8?B?WHQ3ZzY5UHMxbVBNTlhhYzVxNVpvLzkySTZnT0pyRTAyaTNWOHVPdmlUNTB3?=
 =?utf-8?B?Smp3QXQ0SDJ0WVNERWVVd3pQNkNvNW5Pd3pvUDA3Z3JQcXJsbDU0N0VNWTQ1?=
 =?utf-8?B?WCsrWHdtbGFDQVlSY3RqZVRTTnl6YUU1WHFBc05JZkF0VGVSN2o4YldhZlJh?=
 =?utf-8?B?RFZqSGpueUVIems1Y1V4eE1BUWFJWW9lREF6UnhmSjVOSTFhMWQrSy8wWUo4?=
 =?utf-8?B?ZjFCeXl4d2FXSmNoeWlFOHpFRUpSVVI5MHB4RU8xeHA0R2N2MUs1aWtzUnBB?=
 =?utf-8?B?Y3pCN3JPOWZxelBnV25xdlpzUjdFTHdSUWF0YTdhbFZkUmxzZXh4WjVPZW1u?=
 =?utf-8?B?WnJ0aDFoRGxqNUFEYXZPbzdoNkF4c25JQ0Mzb1JTNkJMUUVta0pLYURSU1k3?=
 =?utf-8?B?czZNelN3cVhJZzBoRURTb2FuRXBjc05ReEJ4TDVKS3dHVG9XODRZUWFXU3hS?=
 =?utf-8?B?dDE1dHNZRzhXNFdDaWk3YndYTlpTNEkyRGJKbE5nYnc1RWdpOWVRb2J4MFhy?=
 =?utf-8?B?Z3EvaEJ4VmdPKzBVVlJ3V1paSG4vMkxIOGIrWlJrL1BYSXpXWE9ISk55MGYr?=
 =?utf-8?B?U0ZpK0trdnRVQzRJWnhHZHBoczJReTR2VHltNzcxVDljUTV5QzBIQWNoSVJW?=
 =?utf-8?B?KzlSYXVab3FTRkxEWEYyUFptbTZlMU5wNVk4c3JFNUJQOWNnRU9vQWFVeHpS?=
 =?utf-8?B?cVkvd01BZHlWY09JRW9Fck9Bb1E5WWdLTWJkZEYzTExKSDQvSUc2aGZBQjB2?=
 =?utf-8?B?L2QxcSs3SEQrcncyVEFwMnBBenhzcUZQaHlRYnhVanhJVHN3Sk1ybUVjdUJ3?=
 =?utf-8?B?YXdMUzFQUkJ5ZGFpTDJsNDRxVzdKbnRMbFBoTkNIUTVLdjRSUEI1UEZKbUFs?=
 =?utf-8?B?ZkdQUjNBemdPc0dhS0xaN0VzOHZsK001MXMzL01iLzViMTBHZHdhK0Jnb1BF?=
 =?utf-8?B?SFVqdFNTYWhKY05iaGhiaGk4N2F6WnN6WkJqSEptZWhPckRGeW54dFdrSlMy?=
 =?utf-8?B?a2YyQWRiMlpLWlh2NHFZZVdMUWpYcjNIa1BzNVplZGQ4U055ZHFDMERXNW9B?=
 =?utf-8?B?MGtMbnQ3Z3VJR1crUjV3bFVHQzRzNDVYZnhrZDRoT0NwWEE5blpSRVg3Vmtt?=
 =?utf-8?B?VzNxVE5sUEoybVZtMlFEUHJEVXVPdWRqMEJOK3VOTlQwcU1GZFdtZDdNWkxk?=
 =?utf-8?B?aVFVSGVYdjJsdlVDdFVuZThDWVVweVhITktrZEg3Vk56dVpFZkRJUmNYN3pr?=
 =?utf-8?B?OFNaaXo5eThzbHVsRnJKQU1aZGlzb2JnRDFjSjhiMkxtcVB2TE1VQkRiS1ZD?=
 =?utf-8?B?aktBazN3eE9YcnhUMkNkSEpEQ1hhUnF0eXJ3ZGZKOEgyVTlDQUtLM0JTY0Jt?=
 =?utf-8?B?S3ZQVkZyT1RlRXQwU05najloRkVVZi82bzkvRlhGMVAwMDd2bW8yZ2dVSzdB?=
 =?utf-8?B?ZTlZVTYySGpvUk9zWHRkSVowaEdVWlRRVndxTFNJTUVRdHVkQ3ZreWcvSm1Y?=
 =?utf-8?B?SVluYnlkNmpINnFpSEsvcGdnRGd5Z1M5amwrbE1JOW8rT2pXZExzSHBuMEVY?=
 =?utf-8?B?cTI3WlpGL1dlbDdlekRxUnR0RlpZWnpKaWFxVCt4SWR1SUZuSEpYd09hMVc0?=
 =?utf-8?B?cCtuVk11RllVYWxPemhJMXpiM1piNUZ6eEpDOVgzeTNoNU5TcjNQL0h0WlBh?=
 =?utf-8?B?VWU5TjEyeEFoYUVjNWpDT1pCaEJIMEVnNGhYK3ozMFRVMlg4RWpabmltang5?=
 =?utf-8?B?NkJ4UWp5cFRCSGdVeldhVUdPeGpmcUVmVitNcEJGbE1XMjQ3NHgzbzRFUFdz?=
 =?utf-8?B?TTlsVmROVndIcjBCMUgrU3EzSUdoblhYTHM3bUVESFIvZ3BqTVpkR1dpeThi?=
 =?utf-8?B?enptZWJ1bEN2QThmMjFsSWhZTWtCTS9iOEVpdkRKNm1ncFBaZGVQQkpOYS9D?=
 =?utf-8?Q?J7PY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:35.0697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5001a-e0d9-49d6-62c7-08de21f97089
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5432
X-Proofpoint-GUID: BeRJ-jUXGe7z1xQvCA0XGctJW_HiOatH
X-Proofpoint-ORIG-GUID: BeRJ-jUXGe7z1xQvCA0XGctJW_HiOatH
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=69149c67 cx=c_pps
 a=8AuLY88T6dJdEsujnh9KxQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=CuO5bkMBkij6vSMvJcAA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXw3ZFqbEYKs+F
 nTdUQlHAAU9oWxbTWLa0GqchoX1WmO6+a1dssbxmLwjl48wIxXJeMSymokn6O+qBP6aH1/MNUzJ
 BB21Y64c/g7nR4hPltcNV/g6FOGcOYtR+1HW8w3sto+Fg5FKjEWCwvEEPWRhjY0Z+s/mqK5CGpa
 IOAGQuaiUX8uZZSq6wPhYYpzK5XqumWW7002/uOFR8akMLS6E2+r/aQUhlZPxlyyn6VzxXk18v5
 oBA6Wq5Q4Puxc5d2Lhfy05by5awj/DEKiKpxhVDekCItqn6KG5P22G5DjU3DQKRNfntt1yPSIF0
 1mVTythZBI3Xcu8A8lnwiPfe7T3+CHah5/n+0Y7oD7DN2DIFbHWykZ3q9kYyRpzFhV7WrDuEadI
 qOnKwbyAwYl8D/YpICGbgjnFOS4CFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function and color properties for led-usr node.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f746-disco.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index b57dbdce2f40..2e6086eea6ed 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -46,6 +46,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F746-DISCO board";
@@ -81,6 +82,8 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-usr {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioi 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};

-- 
2.43.0


