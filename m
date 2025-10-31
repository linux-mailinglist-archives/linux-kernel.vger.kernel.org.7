Return-Path: <linux-kernel+bounces-879894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB9C24581
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47ED3BFFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645217D6;
	Fri, 31 Oct 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EwU2UPgM"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722ED2EDD58;
	Fri, 31 Oct 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904902; cv=fail; b=RTK0fD3K0Z2d4GWLDf14Tg696ei8QUP1uEKhJM5lgq474992+tp7A6Fs0e8spOJK0AlbvMfKWae8eF+f+ZoZuzps2rusNNBYiBvIYYACpgYfTkInlLX5MN0pt021zfpC8uWTdLBLfnrhtGDl36gOx75cIZ3dtxGg1Ch+TXOwqQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904902; c=relaxed/simple;
	bh=0TBl06slelVb6lhReFwgH2eo/iKeMALzW0t4SM7s+dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TqrIbQVQRutA9wuTV07ciHvDp51VDlOKI6urgNwak7mdSQI8ZqIU36PFUMHLn+lrn39wSj2c7+uZU9dJg9PeVJCwEha7sCKRK3mbP7RM9HdrMC9LpT2VIWG3cZwejG8W49bYoQn9Uiu8BDU9opcCW4rxOU64cnqFhJMwgS7PAWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EwU2UPgM; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9sP8n3997573;
	Fri, 31 Oct 2025 11:01:27 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a4tcyg5w9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 11:01:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azhYc9WAFLF6IZGNPkGu2hfMW+mtNtzp2e0d5iIuuyEWNBl0CyAQtm+ZRubA7FBYbDrrjGTUVDHbOjw0SwT+7qIB3wUbpBtBT9zGUIq4BcqwuK68x+lBtEQUphUiH71P2pkc8UOVgynGwrxwZ72LBoL8rSgoLriIgAzuQKIesP2AcmdF3o0eUwdH61RUFDHqrylfM4EUl+NVFujYrhU/9KC+C+xiOs2LGfVt/AcQuF/jom/8XdrkCe1ZHqkjR1YKczPxT59rx/gYvbyYC+X23tkP+FZdEwgRwjzaaFOWVPgr09+TAtE5S8R1UV03DmdNiEG4LC3OnyM4ti5VpSCB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB2Z9UKwB268eYe3yFFIkltQ/7PQ2yd/PlVZJpg9InQ=;
 b=vaepFrq5JPGJ58X1Q/GJ3J5j3l7HcF1ckmrp1/CA+o9KbEqRpodcaAShBEyHGSMReSLip20HDw7n+WJI+kjqWI8fj65h67IGGbEMeSZbBltbR5Nwz+QAV67bFl1iVQkp+F1uRws2xWRA8QPz8AD+9KNUUfTlrSir8316JfRSrNJMGVxFiVQEuQbtIzvOCE53fk9P6p4rdiTP6sGyvpM1f5xWv1U8UFkxpQLwfczIW7hO6dn76wKVGYhEMFXNForeQktHAEmmViNwnj9hS0CSz+p/+6NqCYfPqa10wb7tWHVTR1uthtMfUqlKtzbVJR4oheRRFFIv6hn9PrS2/IKcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB2Z9UKwB268eYe3yFFIkltQ/7PQ2yd/PlVZJpg9InQ=;
 b=EwU2UPgMW8Zn3eFzz7RGIJicdauGFouzdox91UiGHTDqZdCehZc9qBgWBDvjIUA4ccDwtlWX+xw8CKcwSVnVbWoqC2ixlbqr1ByzbX5zYwjk4+70P8qOywwWnh7lW8R9cg/95IY96Wwl2mAQppY6rXij6SFEHJHNOcaat6VJRfa8fq1647fUuU4Hu/fb99YtOrKHT4rjZ+0b2zG78QQzC2ET1ApXni7WTutO0bPQYwOgrRYRmoJpqlBwLlxSYqo5AWbdlaonEb+h1Xk7FanV428cSCIJbh9QTJ9jZpQ5SCOBxGedCFrWb3KPBfM4N37AdThwcEnlE3ciZq+hCoLGdg==
Received: from AS4P192CA0041.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::11)
 by DU0PR10MB9361.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 10:01:25 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::1a) by AS4P192CA0041.outlook.office365.com
 (2603:10a6:20b:658::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:01:24 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 10:59:07 +0100
Received: from localhost (10.48.87.185) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 11:01:23 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Fri, 31 Oct 2025 11:00:43 +0100
Subject: [PATCH v2 4/4] ARM: dts: stm32: add the IWDG2 interrupt line in
 stm32mp131.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-iwdg1-v2-4-2dc6e0116725@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|DU0PR10MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ee878f-ddec-4994-6a2b-08de18647376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHB4WGZuTkl0WFBlTXBwcEJUYTdmVG9zc0h4cFl5Q0RsZlZQVUZ1MkFMdnJ5?=
 =?utf-8?B?YTBTSnZtak1GaHc2NEdlRFFuVWc2Mngyc2JiZVlMckpmdEtXWGF1SE5sR3dW?=
 =?utf-8?B?S0xOd0FLWnRQaSt0Ly9BOTNuUUkwU08va2k0RjJYYnc2eVlWU29PWDV1Vk1r?=
 =?utf-8?B?NXpzWEtTSVFHaXRQbFZxMlYza1NlZFloWG9SRHFVVlFhTkVORlFoMm9DU2Zo?=
 =?utf-8?B?WURyVTVLQ25tQ1pSamVnU280cm5ZY1JyTFVsSVIrdlR2cDIvanM3ZzgyUDNL?=
 =?utf-8?B?YW1BNVdTaHhXU1lNenRJeHdDOU5JM3JGdHliOGVJelJwMXo1UVNRdjVrRkcy?=
 =?utf-8?B?YjYvUlhCUTAxMmU0NzF2dmt4ODNwMk9JOHBiWWovREdIYjZHU1BVVWEyVFR4?=
 =?utf-8?B?eVh6VXlVUnFHVklyYVZyZ1ZTNzFxMnFKZUdtbmlERGpnN2xjWUVhWk0vVmx4?=
 =?utf-8?B?QXhyNVJJL0RLSTdnNnY1T2Qya0JXdXFwVGR4Vm1MaHBETVlNdVczUndTWEs1?=
 =?utf-8?B?YXY5djVsUkZWUFhhNjAzMVZoYUlBQlF2OHhnUGxwQ2dMVldlT3U0OWtJUkI0?=
 =?utf-8?B?N2VOMENNajlSVUNib3pIbEVGa0UwbExVV3J3OGc2bG9RMnByZy9Bb3k3bGZZ?=
 =?utf-8?B?cGRjcUI2Y1NNV2hrYlBGWUgvYUZnclBGdnhCUGdmM1E4dm9rTnJtSGhEbDEz?=
 =?utf-8?B?YkVkeFljbm44aWlqQkNYcUYzMG1RbmhYNmVjZFR6a1RQc2FYazNKOTA4QXo5?=
 =?utf-8?B?QjNQNThKTWJiZDZGUDZXNkhmc2VOOTdxODFUUlNOcTgwUkJQM1lEcUIwa0JW?=
 =?utf-8?B?QUJsbjA1VGU4T2ZmazM1UENRTE80a0hHMyt1UU5FRWVLZVR6amtRWHpFVXo2?=
 =?utf-8?B?NFRlZWNGcGtzQnBiS2NsNW1GLzdEM2xvREoybjh5Z2RNWVUwZ0c4eVdtaS82?=
 =?utf-8?B?djFVWjFDNWhqdDdwOFZCa0ZiUUxOa2pmOGNWckNIYkc2TTd5WlVjdWNqbVAr?=
 =?utf-8?B?cFVCTEtsdXc1S1NFTlJuZVE1NHphOHZWUk9hbjlYU1RIeTBKd014SGc0L1Ny?=
 =?utf-8?B?YjAxTFFFTXZFdmZ0T3lnUjhObTVzcGJVS3RrdlJnVHZJd1E3RThDeVVZNWlo?=
 =?utf-8?B?dWpsbW8zc1VGaEZ5bzNiYUFwYnR6ZTRLVjMwUFUzWWErVjdJSzRsU3RMV3Nj?=
 =?utf-8?B?N2NjandpNmF4NEs1NDVQcEM0OGkwODdLMUxZelVMTGRkU1c4bElGM2w2cWlH?=
 =?utf-8?B?M2hIQWtnWUlGMlVHZ0VPTVRNMUc0T2ZvOFFVZ2crckQvbU1SdDhxcUtjMmJm?=
 =?utf-8?B?Z3o3OVhoNzJYL0JWRGZrSThKdjQvTXdvZTE5QTdBRUljc2I3c2trSEtMbUE3?=
 =?utf-8?B?QjZ1QUFqL2QvNTZzZHRaTGZWZVlMZVl0WndTeTZlWFU1T3F2U3VDRmEwQVNO?=
 =?utf-8?B?bnU1dzN2RW5aNHNWMy9CRHVoSkR4cktSU3U5dFp2MUZxUzEyRzY0Vm9MK1NH?=
 =?utf-8?B?ekN1WVgvZG1BMUFVSXNvUE9aWDVoc2ZpUWpMaW1FUkJFb3lTSUVSTXY3SFNY?=
 =?utf-8?B?aDdGbFhGRktJSkpVbUZWVXBDMVNSTGZRMzl5U3hxb1ZudTAzaFRaQmlDY042?=
 =?utf-8?B?VUtNRnF2L2pSZitYRkFlc0lNNEpzOElkZ1lQQmhlOGR6V3pTM1dxWTdqajlo?=
 =?utf-8?B?Y0xiUWtDZnI0UWdjNXRBaWxkK1hvSkladk5kR1NGRTBIMDVHU2F4cEJjay84?=
 =?utf-8?B?OWx3a1Y2TTJMN2JLYmw3Z1BWVDJqZExoSTgxbWpTS01uZjhDRGJneWJOMGY2?=
 =?utf-8?B?T0h6WE45RVJKL2kwZWtJZE80OUx0NWdRbld5WTdabDNvMXViclY3b1pkeC9G?=
 =?utf-8?B?Ny9aeElvS2V1ZUlTV2JqbDR6K2FSbDVaam1tMW1tRVgycElhZ253eW5KaFcx?=
 =?utf-8?B?clZ5bUp0OU5FajRMNVV1c0pqL09xNlRKYjVGSVZCM2x4MlJGdHVJUmx0S2hI?=
 =?utf-8?B?OVdVZitWQ1hSQVhnWXNad0ZhQVdrdTZCWFljc0o1VFJLY09PYmF5OVFGdmNG?=
 =?utf-8?B?eW82cEwrdy9xc0h1WVRiclVyTlV6UVFUdkNqTUlNb3hHQWFFcEF3R0FQcDRV?=
 =?utf-8?Q?xBTs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:01:24.5019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ee878f-ddec-4994-6a2b-08de18647376
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9361
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MCBTYWx0ZWRfX8gXIb1Sg/Vm9
 dYlq4TS7UynPXS2xRBNeCZnJv5nfw204gtYT7Lt6AmgZzo5KOHoczast1os0yN7ZiGEjWMzRU0L
 Sq2PCgQA1KGUXVP/oXXkfmt0UItef/AOrGjd8ltYvqsAz7SpQrnNIVYt6QjB+vgSuUo+O+Pv+q6
 l5Tf9N9JZGfSeaw8C0B8FGrQQQDg91ifK2nVQSevhL6rSoCI2ixqTgDOC5JLL/sG2HQJYtaLqJj
 V6s9Zko2EOVcN138cYmY3uN6/k3RbjAGDmisIuksaKH3DrOTpusN/CfOc9Ie7d6vSevirgiPHjg
 mgGEccL/y9WZOfKJwD9MlmuYZMTzK1W4MybvYvb/q+KCjOmkM3+TxNhfTrKqB4qAeQBu/S+GIsP
 +hsjXIodVO9+mx8cRK3NhQHZ77jx6A==
X-Proofpoint-GUID: 1pfiUzIYaiheO2WiR-IQ5EM18bQPatRJ
X-Proofpoint-ORIG-GUID: 1pfiUzIYaiheO2WiR-IQ5EM18bQPatRJ
X-Authority-Analysis: v=2.4 cv=HecZjyE8 c=1 sm=1 tr=0 ts=690488f6 cx=c_pps
 a=zl0lK08+uPTYLSgcG3rUMA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=eJwOq-yx6V0eZgEjZuQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310090

Add the interrupt line that can be used for the early interrupt of
the IWDG2 to the IWDG2 node

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 6506b9109b90..b9657ff91c23 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1006,6 +1006,7 @@ usbh_ehci: usb@5800d000 {
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc IWDG2>, <&scmi_clk CK_SCMI_LSI>;
 			clock-names = "pclk", "lsi";
 			status = "disabled";

-- 
2.43.0


