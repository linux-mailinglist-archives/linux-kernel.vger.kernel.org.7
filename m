Return-Path: <linux-kernel+bounces-892628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2024C457AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6334770D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB902FD698;
	Mon, 10 Nov 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="npyzmxsJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27B823DD;
	Mon, 10 Nov 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765149; cv=fail; b=Bc0ahTN1euYqHz7BB4TA7xZBiw8caRez68wveTYvH806VJ1TFcZvZS005SV7eb7t3P0W6gZi0EJaojudqq0PvqCLC8BmovnxoTiK673H1rrJLLrAbFNIjIStb1MHzufhFSLI9No4bZh2NegAZNo71ZdthHXMaRTxkIZuhBDss80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765149; c=relaxed/simple;
	bh=0bJMt7D/mcRwkeh9tqY+RV7f/FS0ww9h23xT0sJudsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rKrFqC6Gxc1jCYDDT74O1EVxWI5PAHPRalELEkjVV3JJO/i4m2p96nQpOqtpPE0whhgXBRU9pWjerQnJD7vLC778kAp0mqtSaMLxfaMR35mGK1VQ+33mWTUMDdDe3eqtUWdZdVoIELCHzyN43DOJaYcWGFbTzzJ9GX5ZbO7KBH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=npyzmxsJ; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8lX7U2873346;
	Mon, 10 Nov 2025 09:58:42 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a9xxhe2em-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 09:58:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbCUhzOBvP4m14pZLf7Snq8Td39TaRxTSxewVrIioU48EN1IRq1bStR3yvdi/WtmhzZQD0fURX09xI5xmN+Zf1UT+IdhN2d1vHUEUynW8w/KqwWuB83zm4q6fzsWWdcHOttbFEokyQOPFpH/myGK2fyy79IKWg+HiQoOgDsDSCJnZqbXW2edShrz9MqBpxKAAt+mtY7S/3sOE86SkLmYzo+MykQ/yWn+iU2tod8ZkNEeY0eOFCo02f9rEzOLvlhCLrEUDWraB6VJZz/p14iOlE15UAIuwQ8HNapC31IQEQzjfi8/SkosRuuqED80t0fI3ZDLaRSchzjOVq5oNW3Qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BNkBiS9uRU1ObziAsTNVE4BVY3K8W77mfshsH7Ggxo=;
 b=JLK2ojHWojr3vd5bXgA1y6lKRUXec+YNUXVzcygX5MqScOxnyEvOYsTCTjoIrmGCECw1kBU7adhvaNEXZxzpXrLGFRssrInO0J8HMBQh4iE1biq2W7kx9b1rGQMH+XDxnJqWYrNTBXzt0aT0ydfLYnBzcb/oURdHsPEcLxnnNhFq03OPiGWUszijhKdl7zIe2jZLPqjiABDXltWH4O68Wolypy2F5w37QorXZqAhu82OYoMuEobLCdCRxg6kzE36toi1TBcInbTisVjg61Np3zkwfUW+UPs93DRlFcr6I5UHn9FGt1VLxDLRNpO9V5sp/3etlLx+EEEnVIx3xJ+v1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BNkBiS9uRU1ObziAsTNVE4BVY3K8W77mfshsH7Ggxo=;
 b=npyzmxsJW1QAeUMZA+NiWiQfxsCkYOV/EaDpsHDYY9ua4JiVm6sbpSvjjLWYShqj2Dc6ThwXgtVTGpgoDpRKw3elnz4L/dAve/DxwJDWmWbteg3/JnDOU7HTg9AqoOv60OSGLBSz5rXShWY6U7yMmodgS5+OYhHoe+aLwG2NBkBeWr2bdeEHJoOqQO7HAUm1wN4n+zTFi1rhYs07iXAl3Zw+7nyv/U3tiwBIPDS/1MtNxga96p+wkgyamRih9nWKAhrXiBIlvNwvixNu9n79e/hY8uiCyqzRulEFdOj2XGTAvlmjfQz6EQtnD43ZREd5g2PfIMR3TPKk6m8ZtHxVzg==
Received: from DU7PR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::23) by PAWPR10MB8140.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:38b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:58:35 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::29) by DU7PR01CA0010.outlook.office365.com
 (2603:10a6:10:50f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 08:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 10 Nov 2025 08:58:34 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 09:58:41 +0100
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 09:58:33 +0100
Message-ID: <69be697d-71a1-4773-a6e9-7e506184609f@foss.st.com>
Date: Mon, 10 Nov 2025 09:58:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: lxa: drop unnecessary vusb_d/a-supply
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>
References: <20251007-lxa-usb-dt-v1-1-cacde8088bb9@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20251007-lxa-usb-dt-v1-1-cacde8088bb9@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|PAWPR10MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eaf570-5048-4f3f-016c-08de2037547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZucVM5SnlwNzE4TUVzQVNXOVpxUXJrSkpod21Yb2VQTUhTV3hTUHhiUlBZ?=
 =?utf-8?B?QWxlZFZlemR2L1c0NDRwN1JjWG1PWXNlTmMxSGFGRWkwVEoveG1OcEdEdExr?=
 =?utf-8?B?TEhVendSbmllUUN1WmN6YS9Mb1BXN0tQWjRCR1l1TFlXZWYvMk42QUhSQm8x?=
 =?utf-8?B?aFY1Q0Rsb0sycUY2VnNZWW9CcEo1bjFuQ1FoYnJKZzdyeXJwZU1rSXJnMENN?=
 =?utf-8?B?Ym9zQk5LcndNRURqMFFPaGIvZ052czZSWEFBTmJOQ2k3ZzI0R1l0V3BwZGp5?=
 =?utf-8?B?R2xQQllBZzB4LzdlK2dMbEVPbTZhZHUycTlXdXpQanErdGcybHI5NEdOREdI?=
 =?utf-8?B?ZUlTbTVaSEh6dkdBc2w4TE1GQXVtSkM1QUN6SlRmVUVXYURkek43Z09KWFkz?=
 =?utf-8?B?UnQzamphU2xCRFFRL3pRbzErSTYwMmczU09xTVluOXN5bU9aUDhSUWNEWnFn?=
 =?utf-8?B?QVFDZU5ZbjdxRE9jcjhYSUREWjNOckVoM3BVUE9pN08zdldXMGFXTGtHQzMz?=
 =?utf-8?B?N0x0TlBFNmVIZllCKzF3VXJPOVZBSUVsTVgwaUowdG0vMzhDNDFpVkI0VHZ6?=
 =?utf-8?B?ODF6Z3doMTdySVdsOWNtQ0tXdGMvaDMzeXUyaC9adVkwRFlTUVh3MW5NUVA3?=
 =?utf-8?B?TVh5NkhvRTlDWEZDUEdRd1RNNDlWT3NUS0MxSGl5N0pqb1phUmYzYWdOL3px?=
 =?utf-8?B?bnA1ZHphOXByZWhGcERoUXpCd2ZoZmNwTUtaLzlzd0RZblp1V2xuNm13Y3NE?=
 =?utf-8?B?Rm0rYkR3ODFXOWh4bUoxMWd1Zng0Q1VWVkpmbnBvMzZmTXVYVVlHbDBkc3NQ?=
 =?utf-8?B?Ylp6d0luMWs5ZUtoZjJhUXhzSU5UWU01OVhya0xwUE5KWlFOMmJadDBzQnll?=
 =?utf-8?B?SE8wS29WcUxVckdQNmFNajVFVllLNndjRllmNk94Z2xGR1BLMDdFdW9WdlB0?=
 =?utf-8?B?cE5zcEFsN0tGenBlQ0E5VVhGa1djQ0ZSK05jUUx3T2dWN3NDWFJkaFgxVmpR?=
 =?utf-8?B?Tlo5akJqNTkwT2MvU055bTJ0Z1RyeDVCMG82U1NNN2pUdlVrbjIwL1oxVEo0?=
 =?utf-8?B?aldxNkNMY0gxOXViQWZiZ1RHSXljUWV5alZpelpxQjdzVVRpbGUyK1hPS3Zv?=
 =?utf-8?B?ZEZiOHk5N0pHQTR3UTVIdXVXVUZmR2VFTnB2Qi9mTnE4OFNHMWd5S0FkTUFl?=
 =?utf-8?B?Um1DRWFXcW5nWTdnQmhaNUV1RGlOaThWZFNwd3h2aDB4RnRnTVBVVWlzakhU?=
 =?utf-8?B?eHlnUklELzhUcU1hV2Zvc1JEcmM3ODZIUE5OenUxRWNUYktRMjg0MGxxNUEy?=
 =?utf-8?B?akhyRnorbkpnUFpDM1B5aENpRUxSZ3VoUXlRbGwyTTZFZWdoU3ExcmVZS0Iv?=
 =?utf-8?B?alI2Vmo4b3U5N0dFU0N6OUFsQmg4b3BqK2xuRkFoWWsvQ1Jmd1U1Y29VVHhD?=
 =?utf-8?B?dWEyZ28xcVA3ekJldW5oem9yL0ZXeS95UDVRN1FoYTlZYVJyOWtSTFI1S2Uv?=
 =?utf-8?B?N21idVZFZmd2M3cwcmxyNzg5dEtNekVyeGEwaFVXSC9pQXdzVVJSWXFBb0lV?=
 =?utf-8?B?UWxMYVZ6VXU0ZjZJT3ZtSVRMUzcvekZER1grOE0wQWF6M0E1bG4zL0FwVkox?=
 =?utf-8?B?eERKSjV4cGVrUE9JcCtxa1kzV2FIYWNmZGp0Sng4QWZpVnFQMDhucWxwY2R1?=
 =?utf-8?B?MGUzNnR4KytPYkRyUjRsRnVnMGwxZll0ZFgycVNoUy9ZQ2lkemR1RnJ2Y08y?=
 =?utf-8?B?bEN4L1pYeWZ4aW1JcDZETXZ4WW1BcUdBVmp6YjhqRkxZSVpKODdRekJYa2Nj?=
 =?utf-8?B?TEd2OTRnNzFsRDhkWnl2SjFLWkI1UEVqYWhvWnFvNmJZWGRBNEpkcEpBdVlY?=
 =?utf-8?B?OHdkanRqbmtWYXJ0OHNJQW4rK09rcEJOOW1wWWFZNTN1NGc3Rjdady9PajQy?=
 =?utf-8?B?Vmw0UXZIbVRLMEFYM2JxcnZZUmpzaUdQVUczWXNqeUZKL1AxV0huSStWUkJk?=
 =?utf-8?B?RjRUK2Fwd09nbGxEWWxqNmZjU2FGZWFBQ2ZRVC9ML0kxdmZuQ01PWGNteXpa?=
 =?utf-8?B?aW1SMlZaSm4xWE5KbUcxTlVSckUzdlFWVG0rSWVNOG0wWk42RUxJVFJERzh4?=
 =?utf-8?Q?2ruw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:58:34.4680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eaf570-5048-4f3f-016c-08de2037547a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8140
X-Proofpoint-GUID: XhyV-CcW6DHplCQcq60RJPaMFhupHCJd
X-Authority-Analysis: v=2.4 cv=coSWUl4i c=1 sm=1 tr=0 ts=6911a941 cx=c_pps
 a=8ykVyqDJlzDQ0mKhN7ROtg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=daQrJQBDHcRNGfF79E4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: XhyV-CcW6DHplCQcq60RJPaMFhupHCJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3OCBTYWx0ZWRfX5DzcYTSz/NMU
 PLgDYcSF+51KcreBXVj8O3qeXYdQzDahBUUbZv5OOBPE+KmxboQne3UTzzY6txCeunnUfHEN6Gj
 scuFit6PfI+Nq0yk/ZNIm4B1EtCvHCJvayjUUzDrn/zfj5I0IHRRouGrl1Ub9AjYNQEy8xJh0mP
 3/GJMmHp+aD6GVWpemDgoq75QJf+tCWj37u4PXCZsu3OdBDEk/nbD2wqmNGLbR7tMMHPcJKN01A
 185uUc+DxOsau7X2AA89t8rMrVll0abUaFTCI3aBsyo7yK93gmv2RRK9Dv+4o9bLmqxcwPrWiW7
 36QADxLg33nzgq9z2ImyfV8TqoO/rBK8SBaDqHd5ASdjFIBgys0iQQ5OEcI9be9hVzM+CB+KoOW
 gNxnw6qoPdXmXplBXJ8NpWw15bMi0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100078

Hi Ahmad

On 10/7/25 07:36, Ahmad Fatoum wrote:
> The LXA device trees are the only STM32MP1 device tree that specify
> vusb_d/usb_a-supply and apparently not for good reason:
> 
> - vusb_d-supply (vdd_usb) is the same as the phy-supply for usbphyc_port1
> - vusb_a-supply (reg18) is the same as vdda1v8-supply for usbphyc_port1
> 
> and usbphyc_port1 is linked to the usbotg_hs node via the phys property.
> 
> Specifying the regulators in the &usbotg_hs node is thus superfluous and
> has been even found to be harmful in one instance:
> Linux v6.10 was found to lock up every 50-125 or so reboots on the LXA
> TAC when the DWC2 driver probe enables the regulators in bulk, unless
> both properties were removed.
> 
> This issue was so far not reproducible on v6.17 (> 500 reboots), but as
> these properties are unnecessary and different from other STM32MP1
> boards, remove them anyway.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>   arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi | 3 ---
>   arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi       | 3 ---
>   2 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
> index 9eeb9d6b5eb0ed35d4a83b743e8007f19422e2ed..7d3a6a3b5d09ea06689ebca11eda48785207aa31 100644
> --- a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
> @@ -374,9 +374,6 @@ &usbotg_hs {
>   	phys = <&usbphyc_port1 0>;
>   	phy-names = "usb2-phy";
>   
> -	vusb_d-supply = <&vdd_usb>;
> -	vusb_a-supply = <&reg18>;
> -
>   	status = "okay";
>   };
>   
> diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> index be0c355d3105b89d4374d4f6972c7927970f06b1..9179075f2ead14a4deb45fcd2cefd60ab426a8d8 100644
> --- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> @@ -493,9 +493,6 @@ &usbotg_hs {
>   	phys = <&usbphyc_port1 0>;
>   	phy-names = "usb2-phy";
>   
> -	vusb_d-supply = <&vdd_usb>;
> -	vusb_a-supply = <&reg18>;
> -
>   	g-rx-fifo-size = <512>;
>   	g-np-tx-fifo-size = <32>;
>   	g-tx-fifo-size = <128 128 64 16 16 16 16 16>;
> 
> ---
> base-commit: 33f3d92bd1bee0e37d68124dd6e7df793a6af745
> change-id: 20251007-lxa-usb-dt-ceb0189396e6
> 
> Best regards,

Applied on stm32-next.

Cheers.
Alex

