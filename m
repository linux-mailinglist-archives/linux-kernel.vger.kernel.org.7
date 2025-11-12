Return-Path: <linux-kernel+bounces-897624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAAC533A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88E8A356ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E7933F8BA;
	Wed, 12 Nov 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R7+DeI+G"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFD262FC7;
	Wed, 12 Nov 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962527; cv=fail; b=Ghaw4XnomtaSRae/fDK/oqnOWuS3+Fcm/eTEYG06/mqmh7IpQ5QaBDYGNJLz0RhGYLSYVWIFUS2uPFT1w6cbcwsdbFcvotlnTehnLHH2sMrqD6WFZSr8E+DTKOp6A5d20/xRpunHVNL+PrQJDMYDltpRo2iIO2LYjvIQL8pv+OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962527; c=relaxed/simple;
	bh=k8vGP0mt5tPp7DVejBMa+rmuTf6quhFz2pXH2Aj2xFU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FuEefFwQSv6BdSGJfe/TfFuHeGbCILUD+bjsOoDrF4TTyokBT9tPj2xBrs4JzXBIEFRc/58lHcu/iemtCHHylI9XlNiloGeKbC0MXotsOH9hHWB8NdJPN5B5GgVvW+O7PCdaHqbrpLThMK55LXsPto5ZF74ZbIb16Ef0slbdvGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=R7+DeI+G; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFSxUg1071845;
	Wed, 12 Nov 2025 16:48:34 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acq20hr9a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDPPWoZBC969okrCsLy+MwtsE+pOXvly3f0d3cX+zJdoOg1sVPqgGcmt1ovqPqpRizRFS4XINZ/+kxo7NlU/2VnPOZhB86urnHs30uHfLWkyy+Jp5xUsFGuKpZaL+fcuWkYjoQLZxr3VwqwpHeI+1rtdpCVO+/Vy/B7/PsgByt7D0HT7d+AcI+rVQPRFVOzd7+MQmRpxP0B5qxMmnveN72+K4hVQYf+/eA3P4VPsfcLDrPJuKl9v+43fra7LwPqlq4GMNDsbjJjvMau9DwKOkxdaD5KyksyG8/g9vqX4pzJLRjpeRV08kwWZiH5/8q/Je9EwIyRp2g8XXR/t6PlV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoNw+jHIyK2VEVPOiTMusYVARTqC4fev6GuE4iurvqg=;
 b=nE5wf2p+d4On1+E3CdCGr81OVlkGe/qEPG24cL4zMw20El9C0C4W/M3/TZI68FMh3hUkgSfyyqSfTPxalWrWkFa6v2v/pOaliXF8aWsXqGMx9AuSMtXyI3PGJon301TR+RAQg2Bv/ZvxWPtzix4z70hMi37a6PP5uZKnq/ZMFCnqhJg76vglqIlYZC92TTYU9pdxEMaacJK0dkvddzY6HNxxVdxRR+0kejzFdLGUywr0vMLS7wIUIDlIsn4OsYvxWCOC022n4TrbAqDld668j+Hcv6xwA8MmExPJmfSflXdnDKlfAXIFZPVqZ5xh/5UquMgocir+5aVpVNh/mpNr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoNw+jHIyK2VEVPOiTMusYVARTqC4fev6GuE4iurvqg=;
 b=R7+DeI+GnCtVnccrQxjyGFay6aS+PiQNUjToTmXy75nzgPcRgjKck1oJWUAxbHFYM28faj8hFyqEtshoZd8yMjLzI3RBvmFHLZylAWzNY0kL6zuJre79NB+sGQSPgji+h7MIUassG7ggK7qStaVBEnCMP8wrbAhiqjwajtr1fhONR58wLa8pHywjF/tPo6IPkaMPuiDdV/mpgm7R99hL19FOiJv45KiFa32JkIdv2VdpxWWCqu/nUFTJKt5zFBzPRDwnppx6rCFzOR7Y1Jg5M7GnV4e/KCjsZpc1ZUFajIK9DM9fiJOa5SlluX81JeF6ukg8/t2aw9L0yPKdTb/bFA==
Received: from AM0PR02CA0158.eurprd02.prod.outlook.com (2603:10a6:20b:28d::25)
 by DU0PR10MB7592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:31 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::83) by AM0PR02CA0158.outlook.office365.com
 (2603:10a6:20b:28d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:30 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:39 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:12 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 00/15] Add boot-led property for STM32 boards
Date: Wed, 12 Nov 2025 16:48:03 +0100
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOsFGkC/2XNQQ6CMBCF4auQWduEKcEAVzGkqcxUmwjFaSEmh
 LtbZeHC5f8W79sgsniO0BUbCK8++jDlwFMBw91ON1aecoMudY2IWi1zTMJ2NJbIXENI6sFkXBA
 T01jpPFmhqKoGa6e5ddRayGezsPOvL3TpjxZ+LtlLx/jjuuIfW2ayic2HmgJx/i+5GWzVlnjGb
 kXo9/0NAKkh4MwAAAA=
X-Change-ID: 20251112-upstream_add_boot-led_for_stm32_boards-3815f2e9fd9a
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DU0PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9747b3c8-0340-443c-7d80-08de2202ed91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUY3TmF1dklVZldldFBabDFxdSs2d2NLZVl5d1FmMVVDTGFPZ1BQN05QSk1V?=
 =?utf-8?B?YW9VbHo1a0grQXZJa3lxOXVRUmN4MHZNSFpUUnBQVmNTY3FPV09xQ2xtN2pS?=
 =?utf-8?B?SkE4MDVjRXpIVm9qb25iVEVyTWgzVDgyTnlBT1JDSzJTS3Nua3JrMDZIVE5r?=
 =?utf-8?B?a2pzd1g2VlZTOG1WYWNDYlkzWEM3RTk0SlpDZTY2S3FhMGl2cU9JYms1MXIx?=
 =?utf-8?B?QjdXSHRzZnRSbnNCc2FQakVTMGZOUHBEclBpOG9wYld5d2VzSW56aDVDaGZY?=
 =?utf-8?B?eFNUMy8ycXRFY2Y5OWhWbVBzSGNsZzR5TUxNVEVIOEJHNFVUSWhZbXNYRFlD?=
 =?utf-8?B?bXk0SW9VTVlxZU1Ib2xPYnVjZzFvb2RNZVFOa2NQM2U2OU1qdXdncjVwSDJE?=
 =?utf-8?B?Wm5DQzhrdExoOThha2haY1VHMGtJblJHSjFxWERzK3BpbkxidTg0dDBURkU2?=
 =?utf-8?B?Ujh1ajh3eUlWZmV5bHpzclY5emlGLy8zcFBXU1FBeXZqWkhZYU1lSkVLaFdL?=
 =?utf-8?B?d2QzQWJNM0FyVUQvK0VkM2J3VHBnYTlvU05ZZ3FENHVUajgxZGQwN1M2bGRz?=
 =?utf-8?B?L0puM2RIN3A5cEZQZzA4bTRYNDlvK3Jja1FRckhvckFxbkNIVk1rNEFUMmNq?=
 =?utf-8?B?QlhTOWduR0JhZzFLNEhVVEJ6OHo0b3hVVkpkcVVwVS9INkRzb2NIV2Q1OGpW?=
 =?utf-8?B?UnVxUXdVRlo2OUw4QldhUmFENGwxbWJPNlpFRy9Ld3lacnBjNllzVzV3cFM1?=
 =?utf-8?B?eVRHVU4yMS9PNzJsVXJ0ZGUzTUpWdTdRRnVVUXJWU0RKNzd6SHZxQ3hIWTkv?=
 =?utf-8?B?RXZrY0hCMFpyTlVpSUViL0tOQzZVOG9VZm9lQk5IUlk5ZFFGMWxGSHdWNmZG?=
 =?utf-8?B?YWZURU44MXlVSXFjY0VSSkc2WDBrT1hlUkNuY3RJMjdaSGx6RmNaNm8vck9q?=
 =?utf-8?B?MThyakhHRE9hWnJHTUlPaXpuL2RaOXpadW5RS2M5Y1h2Z01rd2dKd21mYzlj?=
 =?utf-8?B?djRGMHBKbHFDM21SdkRQNG9NSm9Cc1ZPK24xbDV1eTBWVEQ3RDMyQkxVLzZy?=
 =?utf-8?B?aVVIOWJ2NGdLejRZcUlwZVo5SHRINlQrcWIzRW1YOFZmQ0hoM2E5RU04TkpU?=
 =?utf-8?B?SXBKTXJQZ1RLS00yL2w5SlJGOFM4ZWhTNkcrdWhTK0ovbVNzTUVrRXBXb1Uv?=
 =?utf-8?B?NXZzUkFoamk4czBIYUpaRWI3TWlqZXlGazdZOTYvbXZHWHk3OEU2NTZoZDZn?=
 =?utf-8?B?TWwzaFZZQ0FnRmNpdjYyU2dIQ0hvaHdRY1pLRWh4Z2k3aUlEZFk5WVRPSVl1?=
 =?utf-8?B?b1ZXYVg3cnYwa1d4c0phZU54R0s0YkVwMUNJOGE2dHY1U2pUZEJndFYrMTFl?=
 =?utf-8?B?TjdzZzd5eXZUZHk1QmZFRkRTRVQxOGhVNjVvQ0pDZHA0WVVrZUNJcS9oZ2VZ?=
 =?utf-8?B?TS9WclFSOTVBeXVITVZnOFNNVnBua3hGYmJZTU1NKzl1ZDhrZnllcnBzcmcv?=
 =?utf-8?B?ME42MkRnR0JFL2RMbk9yTGE2RnpTOEI5elQzTERHVGxSaTF4Tnl1UldpaGl1?=
 =?utf-8?B?VWc2UHQzTTRtc2s5dU1reG9ES1dJNHgvOGhmVVpHMlowWE8waUxvdUhSQU9Q?=
 =?utf-8?B?UmFnUWlwajIzbCtZMFRFOWh5SSs1NTIwQlpIbmJoNU5sU0hsWXdMd2lLSlE4?=
 =?utf-8?B?dmdpUGs4ZTNFcTZaQ2tkRURmbEVYS25sTUlsb0FpMzU1U295Zkh6U0N0c3Vt?=
 =?utf-8?B?Z0t4WEtpVVllVWNHb2UrY0E1anh6eStMeXMzdldaTzNUZUptSTdFdjJjUjBB?=
 =?utf-8?B?aXVtdEoyc3pHWWU3Mm94RnJ1VWxCK0dsQ0lWQnN0U0NXbkRkall2aDJTYnJj?=
 =?utf-8?B?MWpYSkg5MjVXQnplS3VBdkRVWDArdTk5VTNkOGFXMDdDcUlxWmFDT0NYTkhl?=
 =?utf-8?B?ZEw1bHFWcStneFhvRWlkZStqdmI2SlZOUHhDU2M1L1h5K1F2MTRBanlFc3pw?=
 =?utf-8?B?RTBuUW93UXFiS2FPU2t4RVhnc1lWb05MNVg0TTJobDFQT0FpZ2l5WEE2dDc1?=
 =?utf-8?B?Nnd3OVI0UFppbG4vVmlpWUZqY2I2ZjV0MzlwVnp6emxONStNVFVQU2RpWnl6?=
 =?utf-8?Q?pgu0=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:30.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9747b3c8-0340-443c-7d80-08de2202ed91
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7592
X-Proofpoint-GUID: 60NSgBCZ8Kk-oXiCbQ0ltYuRJjORPU_q
X-Authority-Analysis: v=2.4 cv=LaQxKzfi c=1 sm=1 tr=0 ts=6914ac52 cx=c_pps
 a=8tulKxTD3IOOOZcej3O8CA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=cBRSdZbckCehl9FLuCMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 60NSgBCZ8Kk-oXiCbQ0ltYuRJjORPU_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX+IMVtQF8H77c
 IHr0Z7/NmBt66S12sTyqHNDgG4NuR1dXniKV4F7ZICbb5vfQ1O5eVipVAzjwxQ9dfKpc5TPUU8P
 H2RNRVx4fCRoyPlTUJIwbe4A+LvzmD1ut3rEbMWU5Ii7XXUDm2uMYX9majDHN0AzsiJSBzF4kQC
 QhIre/0i6HvDR61exo74ERxvwpMLthLQ4psT5xBfI5T+S32fmWRg0WQOEGdVQGE7rY+6oEjFkWB
 wR3S9yQoLUoRzkOwzSd0F7+/0zbCsvFd0pWgWlZSx7fZJao7gGJDLSlv1UyQR44UeRocT7oM4Re
 olL4/FwOPMQ+Loc0bATVeqQBonO6iqNy61dpqjHU91RHruT7DWFBzNFqdlH6+n0o2gs66g5qq5s
 an2LRoOC6tJ8ji6HYjhuw7YDqV4WPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot for STMicroelectronics
boards.

The heartbeat LED is used as boot-led.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (15):
      ARM: dts: stm32: Add boot-led for stm32429i-eval
      ARM: dts: stm32: Add boot-led for stm32f429-disco
      ARM: dts: stm32: Add boot-led for stm32469-disco
      ARM: dts: stm32: Add boot-led for stm32746g-eval
      ARM: dts: stm32: Add boot-led for stm32f746-disco
      ARM: dts: stm32: Add boot-led for stm32f769-disco
      ARM: dts: stm32: Add boot-led for stm32h743i-disco
      ARM: dts: stm32: Add boot-led for stm32h743i-eval
      ARM: dts: stm32: Add boot-led for stm32h747i-disco
      ARM: dts: stm32: Add boot-led for stm32mp135f-dk
      ARM: dts: stm32: Add boot-led for stm32mp157c-ed1
      ARM: dts: stm32: Add boot-led for stm32mp15xx-dkx
      arm64: dts: st: Add boot-led for stm32mp235f-dk
      arm64: dts: st: Add boot-led for stm32mp257f-dk
      arm64: dts: st: Add boot-led for stm32mp257f-ev1

 arch/arm/boot/dts/st/stm32429i-eval.dts    | 8 +++++++-
 arch/arm/boot/dts/st/stm32746g-eval.dts    | 9 ++++++++-
 arch/arm/boot/dts/st/stm32f429-disco.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32f469-disco.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32f746-disco.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32f769-disco.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32h743i-disco.dts  | 9 ++++++++-
 arch/arm/boot/dts/st/stm32h743i-eval.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32h747i-disco.dts  | 9 ++++++++-
 arch/arm/boot/dts/st/stm32mp135f-dk.dts    | 9 ++++++++-
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts   | 9 ++++++++-
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi  | 9 ++++++++-
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 9 ++++++++-
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 9 ++++++++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 9 ++++++++-
 15 files changed, 119 insertions(+), 15 deletions(-)
---
base-commit: 329ef1e3a91600940cae9adbae08f2a157aa51c4
change-id: 20251112-upstream_add_boot-led_for_stm32_boards-3815f2e9fd9a
prerequisite-change-id: 20251112-upstream_update_led_nodes-30e8ca390161:v1
prerequisite-patch-id: 67ab2e4482e0edf07c7144922669aaeef75bb800
prerequisite-patch-id: 83333194d9de46872e5fdef3a7c28246c594ad89
prerequisite-patch-id: b5c7c9257a8e9badd14efc3d325ca319c5c2bb17
prerequisite-patch-id: 11ddd0a8da81152cf1614fb7f7c46e7f090725c6
prerequisite-patch-id: f3efa9052e5d0df9ebc55b91aecabbd7cd2c7bb7
prerequisite-patch-id: ec053fcbced6d1d0ba61b7d40d4f14d2a14fb680
prerequisite-patch-id: b2fe9787745761fe56529f033f0a713f140e4280
prerequisite-patch-id: 8760acf7bf81c0969307de081efec34032a4f57b
prerequisite-patch-id: 2c27c9bcbaa4961e6a907e269b46aca7cf40ca38
prerequisite-patch-id: f79aa19a1e76b0604d410e5dc56436ef7884d60b
prerequisite-patch-id: 1bed61c35e48271b4e56c43695edef2e0c819d55
prerequisite-patch-id: 7f73889eeb54d1d54f5c441485e211aa45b94035
prerequisite-patch-id: 78a98bdbfb3a13beae5fe234f799239be7b4b3fa
prerequisite-patch-id: d066a879ebb950227d941f6abac320e00e964b50
prerequisite-patch-id: 3540a2861aa07db77641671ef32823779fdf69c1
prerequisite-patch-id: f361e230ad24fd006396fa717ee517d72ad6ca40

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


