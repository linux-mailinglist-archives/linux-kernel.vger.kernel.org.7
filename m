Return-Path: <linux-kernel+bounces-899690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D3C58AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE34F0660
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A22302156;
	Thu, 13 Nov 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kwF1XETu"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAD30148D;
	Thu, 13 Nov 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048721; cv=fail; b=Q+oJoBaXom1ZyTbmNATMjHnxQ+h/hCJLbjjKZJipPuubcuZQt+ZuoIYs+SuxQhGd8kYEd+6vmI5o+NrU2f9azbZcoHx4zmLyE1f28q2kLuf4Wcm4786ymWdtjuEDgY9fFOOQxWfuXlp8POKETCG2FYwq2SAogxdrTdqcndToU58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048721; c=relaxed/simple;
	bh=R8XbhgBld3NVjU7b72BAi9c3AwTQ/Xcc5k9Ly/h6q0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oqWqvHeoYZ2Wkf59MwttwCnSoIFdWMzQvdywXrCivsLNr0+ca/ZgeU0eGXbRVVMejdFM1uj7vPFvRLaxi0EA3DRe2BvugljqpLie5aPeJI6DU5TWnONZZ/Ys/Ff3xNHpCM0/OtPRuksE4q/5jWkbo/va4tpzL7GaDTNGH9WOn3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kwF1XETu; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADEmhAb3956822;
	Thu, 13 Nov 2025 16:14:09 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu5r95-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGl+AFPoRN3BV2zcWPXjLV5Qe+py3mae9HguAk+A4/sfyQTvsvMF5CtlKj9llMjuZ+1kvelrnKV88uF5EGNL2rHlRKP3A16oKwthEfd8KYTqkBwlfQD16YHmcQsM+28mXIMs3u+QAH8Ewzfiynw6Wepf6aY+sLmWa32lnKEhBMcCbL0GkWpcthWukzOWLbQ4aXPSDDUP1YRCkMcHp/TJgZJPunQq4a4hlLPpw3ZUp0TsmdS4UCEiXPawWVEApgv5FX3asbaw9Lz+zLI5hGFwxfSmNU6fC/Xi+zRCx2RV8ZZsyjKsWeedmcdjsgItpJU0vCUYNTK4PkKBNvwEcn7dQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPtR9rwMQmdKENXSjfV1I/Nk66rIVGFYYRT1LbE9K00=;
 b=nbG61quHupK8ctQDt3PeuUaTjTpxZxYtFNUEDoldVqxilFody54fH8s5guzNVLbj/QC1st0pmHqAeWoWBGyEYlUTx7Kc3WSlHw4nkToAgvGiyX55FQj5dB45NWmBAVF3Y9QzroHC6N6+IKjMS/dSiPWvjNollYPsUYWcLoJWPW6v0USB2Qxks5AgyLNdjr2cYSfw8QTMrD62zLfi+uO4DwA2YcyrAoB9WDovPDLvMcUmWBk06bwqzo/NJl/BvZzTDeo38rkZskIWjaxk43kFJ+jP9MhEYNtxqEhx4xooGisTAneXXhGQQCeHzoQwS7d9rUoz+lkmPrSAVKOtMHBqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPtR9rwMQmdKENXSjfV1I/Nk66rIVGFYYRT1LbE9K00=;
 b=kwF1XETuNbtKoFjJgGeWX0Vm27dwyoca20PnHOZIxrzEkG26490Z62KkM4kqpIjvzXTw9mpnYGpBFoN/Hckl3s2pkiFlrOVgMk1tKmv2lgXn3jZtTM4wRNBPu1JBwILX0dk/8KLp3ohpnBgOHz5bNp1nYl7r2pOOiMplS+Ul2S1Puh2AaJLPAwO6DbWqw13nJPUU4sRKBM9+Hj1IjhNBs4IQ7CuGSz+BSVk2v1YGZuhM1O0imOXzzSLQ7EtBzjqSkltHc2TIvODetYqH/SKMNr8kPqo6XqBhL38hwtEeBcyDv+PZNaUhlAMFNQSqQ12s8QhAW4apsrAEF6mbqmXJcA==
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by AS2PR10MB7550.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:59e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:14:06 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::6c) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:14 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:04 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:14:04 +0100
Subject: [PATCH v2 13/16] ARM: dts: stm32: Update LED node for
 stm32mp15xx-dkx board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-13-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AS2PR10MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 176e9cb3-1ea9-4864-084c-08de22c749c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWNqZjVqcXpDS21UYnF2RjZvWVZIT2p2eHI2MVdzZmt2blMvN2dZdEFvRmRh?=
 =?utf-8?B?bDlvT1FYNGoxcXlWYWhKYldCNXNoK0sxak9YOXRMakwzMFlTaHVORlZ2dDRL?=
 =?utf-8?B?UklWSFNQNTlCc3NMMWVKTFdCU051WTdHaWpaWXpVRWxQYU9YejRHeHdhOENV?=
 =?utf-8?B?MjdYY2doeFJzakdkWEcrejd5L3FaUEM5WkRUdFZVTzRTbHc4MGVLcTBuc1h5?=
 =?utf-8?B?S0hqRTBnbzA2TStndlFOWVRSQVNTWmdLQjdKZDROWlRrZEJrVC9ZZVNZMWM1?=
 =?utf-8?B?RVVjUUJUMkZQbmZpY1ZYd3JMU3JaSDA3Z1FJMEh0ZmJyeGN2NWhuK0VxTXFs?=
 =?utf-8?B?K3JieWdobTI5NHRVK0NEK0J1MFZsdjQvbUdlMk9UTDlGMkF0S2x2ZVpDQjJr?=
 =?utf-8?B?V3huSncwWjRCUFZFd2NhVDU0dk9OMmROSGRtN3UwbXRGS2RRY2tBUkY3OHpE?=
 =?utf-8?B?L2dXYzZFQ3NEUWJ2bFViRlRBZFN3bkJSaW1Uc0ovOGw3L0JIdlVocjR0VmEw?=
 =?utf-8?B?Z01XS2Q5eitsbi9zbSt1ZVgyZzdTaHFEdTNIcnA2RHV0N0V3VWxLaE5DaUI5?=
 =?utf-8?B?S09zUURUZnE0NmM5ZlYraWpvaGZmZFJSVXpvNjNmVVREeXo4Z1h3WHlFUEI1?=
 =?utf-8?B?VDBWQ0xqc0lsQlEvMGRpOWJFZ2t6bVNwamxhWVdYN1FVYmZOSEtIZTc0WFJF?=
 =?utf-8?B?Q2VRcFVOWUt3NFhhaFBqQ2hOTllhOHo0TlVHM0tqYm1wbFF6bXRxbTEyY1Zk?=
 =?utf-8?B?UnRQcmUwelpzNkxpUFNMM2MvamVJRkxWbVhRNldaREhrNll5ODZhS2NsR29m?=
 =?utf-8?B?M0RMWVR1SG5Jai9McGJubWpMbTlRTHJHNzhTRVZSdHIvZWw5c081VTljZnlE?=
 =?utf-8?B?bnplUFhNS0dBb0lwUWR6R0ZDK3kyMnZ0b2Zwd2RaWmJ6QTE0c2l6MytoeFhk?=
 =?utf-8?B?SXlNRmh5S28vdGk4clF4NnowU3hjWnNGOUtsU0lRRC9yR25wY3llM0hsKzZr?=
 =?utf-8?B?NDd0aGkwd1doWEpsRlg5WWtSVWN2THFSU3I1ZXg3WWY4a0dlbVpkd1E0NVFi?=
 =?utf-8?B?Mk9HeENNUEpBdkJRS0dIUWoycVFGelE5Y21lU0FkNUxCdCtZci84Y2ZyTy9W?=
 =?utf-8?B?MXkzU1Y3V2g4T0ZWQmRNOFBReXFIQWFSS2h4bTNkNU42RGc1YU4vdG5pVFVO?=
 =?utf-8?B?eDlwVTQ2WXV0U2NsY2JYV0pwT3BQRlprOEMwbk1jMjM0TE1lK01QeW9SdVFZ?=
 =?utf-8?B?VHpxVUN4Y2owK3dEV3BNbWFrYUw1OWJvZzlaMSszVWxMRDl6WW1pRGpQUFdS?=
 =?utf-8?B?R3lHUVZKcU84anFVR1c4L09rRHZOellDa1hGb1RsNGNON2VNbi9acmU5RWlS?=
 =?utf-8?B?RTRuOGxmMW03VU1INXNsQW92SjhTNXQ0dmZDZWliRkFpR3pKSzVET0FEZDJH?=
 =?utf-8?B?OENPTEx3djhkUzlqVmdsUStOUXgyd1ZTVDhNMWhmN1Z1MGsycWlxV0ZjYzMv?=
 =?utf-8?B?ak5ObTZXdWtoOHI4V1dHa0RrUVdtMVU5TlZ0amdHOEhaZENyN1phZHlBMkFM?=
 =?utf-8?B?SDFzb1R5dWw2OEFsS2ZPT1lLUTkvZm4vSkljVkhDYldlbDJFcG1DK05QL1Zl?=
 =?utf-8?B?TEcvZCtFS2FIUS94dHNWUy80NTJDOHJkaVdXTnZDSkxpUFRJVUhkdlliUGcv?=
 =?utf-8?B?WVJ4djZDMXRPS3pTb253ditkR1Q0YjFzRzVtNk1VVGlkdnB6Y0tqbllOMCtn?=
 =?utf-8?B?SzNZTlNOYVhnMDEwbGFSRVZYODdpSS9RWUxoeDhZQ2ZONTJTT0tDQy9BaG10?=
 =?utf-8?B?MDFyRDJxZTB3QmlmZ0FGdi9QQmgyZUdkZWtDRitscCt0d2gwdHd1blJ6V3BY?=
 =?utf-8?B?bE5mZ3lacit6MEk2WUxXT3gzV2JyRnRiQkowK2hUNExkUTBCbTJPdTFXa3F1?=
 =?utf-8?B?NXRqN2hCUW1tdHpuS1d4MnpCczNGUTVmWE9yMkdpM2g0eTgvVEFSUU5td0NS?=
 =?utf-8?B?NWVQc1llejhlcytYSHJFUlhTalBIL3NnR0wrN2dScmZzd3VTR2FkVkxReXg1?=
 =?utf-8?B?aGtwWmFYM1ovMk5jRk9XdEFwK01sZmtjM20zWExXYVI3eEJHZmNYSUpnektM?=
 =?utf-8?Q?2FQo=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:06.3512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176e9cb3-1ea9-4864-084c-08de22c749c5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7550
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfXzFUOCiEckCLh
 8sAEG0IUlz7CiiveP/vkNXK1RwHP/oVmvMVcsiohmTYLkvL0WdK+J8QCD1csBUcY8fJOj/obsuu
 qF46EEHV1kwtcvRk/lq9rnF39hVwvJdNDFoAV8X3Ib9XJJZh8RD+xz8qfPkz1j27pkLE7YMQ6L2
 r9J5FNwDKYniimvwd4Cu6pNB1Ej62jIsyMNWOcczv1HomMN5JMY5ucSVq3QMmtgmkP80qc3Ldeb
 wE9KOWUUBwtP3Spl6oAeDew1WVDH0jg7qK41UGGOuzGWtFol/FPO0utwKmBmMVB9VdQJdWROTnL
 XFCj6+eF2hZmxtUuRgi22kIiANFqG12oidE0ORMKM9S0yhSMa5Fp9ylwiF9Y+sToToBH+xLRjL7
 JEHFPcGLjbOgDWkOy9vKO+OKz03zQw==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=6915f5c1 cx=c_pps
 a=oulOI0It+5OVOIW5avmraw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=WzzFcJAODjsVfCo3KYEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ingLYQqlkMnpOgE6S2wsYiwPmon_DSVo
X-Proofpoint-GUID: ingLYQqlkMnpOgE6S2wsYiwPmon_DSVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add led-red node for stm32mp15xx-dkx, this LED is used as status
LED in U-Boot.
Update led-blue node by adding color property and replacing obsolete
label property by function property.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
index 8cea6facd27b..fc0ff818e1fa 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 / {
@@ -64,11 +65,18 @@ retram: retram@38000000 {
 	led {
 		compatible = "gpio-leds";
 		led-blue {
-			label = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
+
+		led-red {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	sound {

-- 
2.43.0


