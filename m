Return-Path: <linux-kernel+bounces-899670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92340C58904
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A94A5D46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B912F9D8C;
	Thu, 13 Nov 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oHwcd8b9"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC32C3255;
	Thu, 13 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047985; cv=fail; b=Mj/Pq2+g8tSpx41BBZScGOImo5VK05h5ruWGjdckHw080YiGRVD8t28yZW9c3O1/r4f+ZuVateiiXbSA5C9vIqUd5NDjT88UMz0efyQAPM7ZHvIi3Fyvgaw2iFMcKAc8ECgW9LG2SjRxK3zcN/GQb5k3aOfH+DH4iGsm/TrKSqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047985; c=relaxed/simple;
	bh=NhhNqklUckIxqqI17TMhtzq73gWs9V6YjGp3oNl2HGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QOdRuwkPEe48Faj8OJaelXgdC9hkB5IFaSGNSLYIIwmeSVe6Vaa6nRve5j8tlxzXPzHPY2SRdf/xNJcFqdH6vMwmiifxQcu9awGUBL3bQuiWErxWOU7zxzkMAjNX19t3ENvi7+/Losm+W1IzqoIoc7Xegm4dcGLkiqMqhOJsKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oHwcd8b9; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF3LeJ3984336;
	Thu, 13 Nov 2025 16:14:03 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu5r8n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4cIt8RRD/23e9mOWbWviQ3QnUeA2OPwQLbhsF6LdmaPI2gpH0IXPIUOR+uc71CNDSCATOGKhZQG12rLMIHLKAYaSfQAO0KXFz6uvUW47Y78jPUxZhLmjQLaZV8l+nHbA68ARv45sAE7I1xv9a9M+2KjUr4TLku24ke6f5q2gTUSril9Ig6hqcMVHqYenijuXuJcpEEHXiji/ts9t6jbza6ReI/kTgFq3qkyBZPu+eio9kUQZLQ8knLRXPnTzrrskXMEE3XYbZJvS0HJUbdmllEUJrr0O6vuRw8teZdFh7QjmCO4bkutmIJATScc6PQmN/5gaEu5+qjjNO24zSjUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iitov3mhHE+W2Z/pcvw4H/SBaGFy3IKk5KT4Qg6ePAE=;
 b=AgjUDb9BK2M02GoL+PPRjrgI0uLwHm9RcyfKRrKI4qIZjlIM4YKxfR843q8baUqzgNw0PQbpddgnL7/AgtoqjCpG93OVEn56abItLuDqt9q5ZFtCUbaI7F9hB9DWNwAZ3ZydPzIcvRcx4vtaROl6UEhfL1k4sSNiinPpvj8fYmt7QRmHgp476fqzAono5tBzDfkrNZX+uYzkVj2fNp4TZZ83r+e3BGXAC/2iVethFnkpXfjXdD0H/c0RViZ33PbwyE+jAtP7/3xAMqfZsIwjpphMfhbvizEXWGZ4rlWFHNfQ2p3LwPjyQHu51UwonztYHvbdhIn1VtcbcpJdTxVDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iitov3mhHE+W2Z/pcvw4H/SBaGFy3IKk5KT4Qg6ePAE=;
 b=oHwcd8b9n6YvuQxopu1cRME+kFWDeAlXgBKlS8HLvfB/K2JSQk6slOD+4w9PrQqjnOBz9Gi8lo7SlHk05BPeRCEfuRqNIPjQePeQiu2I/g0Md1OndER1vJjeWXhfLJxBBgsSljZJQ5/BCEJqPwquQFuLGKn2mzt0PUaDwtW6rqKLQYoL3zuzc7z4ew48jEhQ1ru9d4lNTscbLSh+1JGemkUZ4Br33JrCpIz/zoXWFPlaY0XAuZeU+sez+7Pf7hC1waUlKFSowiIA5iHxUT4D3bTkwpHhk1IQU1cYphiqUqnkU3k8hOSfEfcTokgquOmWKDPv79MDnPDLfpYTGNtP0Q==
Received: from DU7P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::21)
 by PA1PR10MB9411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 15:13:59 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::fc) by DU7P191CA0021.outlook.office365.com
 (2603:10a6:10:54e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:59 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:09 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:59 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:56 +0100
Subject: [PATCH v2 05/16] ARM: dts: stm32: Update LED node for
 stm32f746-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-5-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|PA1PR10MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 9291ad41-b290-487c-9056-08de22c745d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJtY1ZRaURRaFIwM000anZtbGFQbVgxNkhtLzh5blRVSFJGRStCUXprWDY2?=
 =?utf-8?B?YzlGYi9GQ2JPeDNJMmVHaFRhZkVZZjMzVTFMWXE1T1grUEptaExtVWMvbGRx?=
 =?utf-8?B?Ukp5MEdiTEJOVVFQSVVxa2hBQ0RLV2FONklQVTlrNnJlM2tpN25ubllEN1BI?=
 =?utf-8?B?bXRaM2ExeUhuUnlqc3U2S3BPQVpRblF4Q3FReWV6aHNFanpFOFFNZlJ4Z2Ns?=
 =?utf-8?B?U1hRS2Jwc3FKUnA3ZUw0OXc5S2pHck9Jd1Yya25sRXNLTDZyY1hkQ3VOdnhV?=
 =?utf-8?B?S0xYbkY1WC91MjZBa1U5VEIwdllPL2V0NmxaNnBjTkZwMGN6cVl5V0I4UDcr?=
 =?utf-8?B?T1YwUTVmUDRrdFZvaEFnNStWTXowamNlZnBReWdZL0dKOVJoSUJmZjF1WThk?=
 =?utf-8?B?ejIzaDhYQVJVOWdIbVR0ZXMvQUM3dGFwblR2V29jQzZOakk0Z3BBYy8wSzha?=
 =?utf-8?B?VlR2bHZQbVVRT0NRUDUzMGlHV29Pc1ROWkdwOG92c2dOSTRvbEZJYzNFMzhh?=
 =?utf-8?B?TGhnRENiK3dFN1NjMVVCRFQyMXhrVUk1VWJjc2JDblI1TDgxM3VaRmJCOXhL?=
 =?utf-8?B?YkwrWURIMGNWajRmQkxIN0lOcG1OY2tvZ0pCa0h5M2pvNVBHYTlCSE4xQXFv?=
 =?utf-8?B?ZEhXZ2h5Q3hTRUwzSitPUnJVMkpjcW83WHNZck5GY29pZmdad09DbFFYMlE5?=
 =?utf-8?B?YlpBeHU4akpmTnVYR1YzaHc0UmFoQ3RwWXhLaEpCOHVDT0g2UE9xcUExWlQx?=
 =?utf-8?B?Y2UxSHduYi9oMFpvVEl5b3BkeFlZS3FVR1N6TjFMV1NCZlB0RWV6MkxIOXoy?=
 =?utf-8?B?TVNieEJvZmZPS1JxSkpCV3prUDVvOWZIdURHOC8zUUNUWGNNcjl6RTlPTmk5?=
 =?utf-8?B?bHdMUGQvWG9aMlhGWk1KUDhuNjZYZjhyaEtFRURkRW1zcHJpRXc1dGI0Y0Nn?=
 =?utf-8?B?dkNLaFhncWhYcUR6bEVwcVNlam5Idi9XK0RhY2N2UEVEclFvSjRrNWdnOWtk?=
 =?utf-8?B?KzQ5YmM4T21FVS9kUlJ0UTFxSmtUR0RWWTRPZlB5cnE3NjI0bUpJbnJOYVoz?=
 =?utf-8?B?UmdXZW9JemJyU3QxN1A2eTdCeWthbnJkbHJqTy9tMkJ0VXpkVElsaml6UDBi?=
 =?utf-8?B?aHExdHZWVjBQcFBPR1FlbzBwRXZ5b3NTdmM4UGtLQTQrd2hUOXQ0aklmUDh5?=
 =?utf-8?B?cU1TV3RKWGxaOFpsaEpQNE9BMVZYNkNWWTF2R2paM2pSWGNWdFJBS0pXditM?=
 =?utf-8?B?ckNLNGJieCs5aVdFcGlIY0F6cE9TL1hmZXZMN1JuczJINXpDbGxEOUZtaldQ?=
 =?utf-8?B?WENWRHFKMG55SXRVejRKTk1Cbi90L2hQNENpZlhiVWNPc0xyTjFUNlRmeE1K?=
 =?utf-8?B?MWMvNCtqclA2KzBCTTZocG8xeFVZdjlXOXAvYUJvRHo0NkJPRUZ3NEQxTnFu?=
 =?utf-8?B?cExlUkdYTC9XaGNvd3pnczhjaEIraWk2WHVZenBwbGEyVE1IZkg2azRYZmtU?=
 =?utf-8?B?eWxTSmR1VnB3VTZHU0N2eUhRY2dkZ0tKSVNscEFYcDhaTEV0WFAwUTVBd3BO?=
 =?utf-8?B?eXZkOUQxM2NtV1RPZFZyRTR5ZGRoVHpJdk15RW8vSm5HK01KTWxVS1Zld0Nw?=
 =?utf-8?B?ZHN4U3JFaEZHajNHRlFmekVRbk1aK3FFU2xocnRLUWdTVzNGMENhMnZCMWlO?=
 =?utf-8?B?N0MyREdST1h3REJNRzYyc2l5cHhPRVVkcThMYU1JY1E4a3hPM0lPb2xvUnVr?=
 =?utf-8?B?YzNNNDlhejFCazRnMVd5U0o4b2JqZEJ2a1B6MUNJRVNhLzhiTkZUMlNWN0Vr?=
 =?utf-8?B?elU1MFlWL2xBWDFTckJtSW10NUVFWHhKN0h2QVA5dHhmdkhKOWY1RDdiOXVL?=
 =?utf-8?B?bnVvdml5bTJzT0cyUEVGWUcvVTQrSjQ4TGUxNVdhVWZPODlGME9kMEZCWnM0?=
 =?utf-8?B?d3puV3VqY0VzaFRZcDJMcEJZOWltZjNZaS9JQUFidU5Gc0FzWHFvQkF0c2xS?=
 =?utf-8?B?Y2Z1L3BYMFR3a3FzWXNWa3p4aHZndDNUY3ZvbHdUeUY0c2J6dlE0WmVFMFlH?=
 =?utf-8?B?eGR1VTdpY1JGTDNuSkovMStrdEU5RXZLSWxIM3Zjc3FaOS9HSG5kdXhZVk05?=
 =?utf-8?Q?xLXM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:59.7276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9291ad41-b290-487c-9056-08de22c745d1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9411
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX/IV8Y4sLgX11
 98fAmelZvmyiu1W3CFEjG0NsWMrp7hJri/kXyQtfSPKybhlVXbHL3/ZoeiDosu5DMjiDFGVJxt8
 ihsaH9qEYB2OwRsJTDcRIfJVNU4sh4Vf3q2S5UhnM108B/wHv8LGT82DXZ4t/4KCbX/SdWamYMX
 UXPsrbeRjyzSXVQzEmiqVNGy2iltWNRfu6NM/HrAykP73VCNk3ajc1pjbSqzI0rL10OU0UVJHYA
 zJByVKoQQ8jJ0/Ze29JL2UfIWFWeN6avFyVEvZ1nmLAuG6RJYtmcQN26Trbgy1wUjmV+bLO4RY2
 6Cs418ZqarghczgDAFG7MWy4OoyREO6tb68TbUMV9jMo5doAyOzc4QC9eb3Ro93+iaCUAEffG6K
 RX53oj8sR8HDc0HhUBEAp1vtsM08FA==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=6915f5bb cx=c_pps
 a=dNrFwgn0Rq8ysk2JmkLJkw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=CuO5bkMBkij6vSMvJcAA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: WEvIwF96W3NgFwPFrU6bonV67DK5Hzbu
X-Proofpoint-GUID: WEvIwF96W3NgFwPFrU6bonV67DK5Hzbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

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


