Return-Path: <linux-kernel+bounces-882262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3BC2A02B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C09318899CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A2280035;
	Mon,  3 Nov 2025 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rRfTcdTR"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02286334;
	Mon,  3 Nov 2025 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142501; cv=fail; b=DN6iApCR7DY2CmYJHByJzEeBmc8K+omhkQqeO1JJzPwbtTqNkNxjZCwgJt1HUDMpeOvkhkJvlQU1KHEDX4yywlZptd4hcHDiRBpgVIFuD2UpR+RP+iASPn+kJvDgVDlWrznuuay5IVxl/8QEQ7skQAxYsvG/BPest3QpHDbOOvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142501; c=relaxed/simple;
	bh=q3wG50m68bThI2EJgtOIDHynswfXzzGjt/P4MyN83MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WGPAPQVVvr0HQUUvzNO8zZvSPS6/V1wEV0RQBCrxcmMtrT9fs6Urx3vwqx+8VdNaOn2HeR55Tu8bepIqAGqeRiGN3EPJfI7Ee1fGjVwT9buB9SOYHbojWRGFcdBEMp4ShMzakhj6dQEgwar8c62wgkn/UJLYOjhjLXLAlSGw9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rRfTcdTR; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf9AnvaGvlVWdlPLuRtnTkCRZ81+V3omyAWFZJoRPimCri6ZuEbVLzZ5qWfSCbG5UZh5vRTXzZyEPu7g37Kw5SVElvGTIw9zB1t1j+WYZnwGc282nFxVi40Y6FPjogfjvIhQjUDFgh6dSzygepRiLd/tnT35SzH3f8oIF2/6/SvGjy5ZHxnvT2eyoUsMBwpb07WOzUE6nXs6HN4yQahXQLlKu58J5Y4oIHgYz3mVGVqZWRUJmtp7Is/+RPds1kwEmynilx23ghqIxn+rCCQY3qoqBpxR3BIMyzlvUmzASkiPZu71PS3uECN7xSsnpW+cKhN3a2oYVY6l3Oal43xJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn4j80hA7XgX5eoS4TefDL2BpHUckUSEMt/txSYf9UA=;
 b=TfDmYcqHB881ONeOmI+47UEDMG+KUe/h6aBHxaEtZpDlSViMiF2fySDbMEU/7+kuAgnWtiwnf46IK+Zleg2CPjjM0hAI7/9Upy9eE7cfzqX/uhznml1OCKa3yzL4Q9zs5wn8u/Ew3kMrr5y2peaSZBTyHHLUxOSyfLlJSp/KasOEaYfBx8Mrebs1VkNo/+na1f4lMdHCkmUuiXdbrYxZWVO8dDiG3ZAY8K5RfdwjcCZkVobB2XIYFDr1EXZaGNbtQA7//pxKr70Aq6evl9ORRpbgNUKgRsFhoqXKPbfl2ueGL8wURJdzu1O7+b8sMOBh71v5Xoeq8di0/y9CfiroWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn4j80hA7XgX5eoS4TefDL2BpHUckUSEMt/txSYf9UA=;
 b=rRfTcdTRlT4XZzvPT8FSkA8T8r7E02fb561uKLpRNmoASd6v4VgMKrKVbCgUs8/9pqtOdhJwL/UObG7dpQVLr2pRzrlO2UCgSUdKqXzVSKB/Ut1T6PEWttB9IlZIXtwztkHl/19uDsj5BKwE1RNNSc/pcicTgsT6eda7pDOsl24=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by SJ5PPF8337777B9.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 04:01:37 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::ad) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 04:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 04:01:35 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 22:01:34 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 22:01:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 22:01:34 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A341U323454910;
	Sun, 2 Nov 2025 22:01:30 -0600
Message-ID: <ed1317ad-72a2-478d-b931-8f08d8c7e159@ti.com>
Date: Mon, 3 Nov 2025 09:30:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, Francesco Dolcini <francesco@dolcini.it>, Wadim Egorov
	<w.egorov@phytec.de>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Daniel Schultz <d.schultz@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20251025073802.1790437-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SJ5PPF8337777B9:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d0340-b680-436f-f6f6-08de1a8daeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|34020700016|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a05wSXo2YThqRkp2d1RiWkVwNTFpT2xhbDYxblB5a1hYckZlMGJIYWM4RVQ4?=
 =?utf-8?B?b20vWDhwbTYyemNFUHZncVlKTjNrWXMwbkRRVEI2ZTVGbHdvcVovMWh0TWhQ?=
 =?utf-8?B?WVBRdVVXNUJXZDJQMERMeDc0MnZNWlY3LzQ4aXZJRjJEaHdZK1JMdGpDTGlE?=
 =?utf-8?B?VjQrVzNwMGZOUmo2YW9MejdLOFpTdEV5Z0VpRFgxYzdiQ3pRV0todmFEY3Ji?=
 =?utf-8?B?M0htTmQxQkFWVVdMVHZuVmd5Uld4OC94dzVjMGRTeVFMWFJsK1dpUjY3UlFx?=
 =?utf-8?B?NlpOMjBld2V1cUNWTG54ZDBHNkxlN3ZBdVVuK29oSVpZdTRNejRqZ1ZqRTc5?=
 =?utf-8?B?NnhtZnBDUVQ2OHdmbjJQTjAvVUxzbUtKQXIzQlJqK2FjM0xmR205dlR1RjR2?=
 =?utf-8?B?aGVXakd4V2pvQ3JrZTA4L0tCaGJENHBZaFRDSVd2d1Zsams5ekxva08xbHhM?=
 =?utf-8?B?dThac2puT29OL0NnZHcxVm85S1pmcjh6TEhYMC9DWUFQWU0vWUR3N09KQUtN?=
 =?utf-8?B?TmcxZXBHZVB2QmNRYTlsMTlCbDNvczIzRkQ2MEpHd0lEZ2s5TklaYjdwV3RS?=
 =?utf-8?B?aW4zUTNRRGY4cXVJV09tYTk5cENrTzJnelhPSlpnZkh1QjRWVzgxMnlmVDJt?=
 =?utf-8?B?bFI2TUxFZkZUUktqYnVLc2JyZk5zZUU0QlJZWk9oOVZTYzJ5UG1iUEVjK3dL?=
 =?utf-8?B?c09paUtvQ25LaG02QjZXUlFtNEtKTlhGbVFHVUI0NVdBT1g1d3dSWVEvK1dH?=
 =?utf-8?B?dUgyQW1CQldTZlRNMi8zVld2ekNzb2FORC8xNE9DbXJLM3VXRWFsK1FjblFW?=
 =?utf-8?B?RytDTHVKWWlHYUlRa3hVb283NmJDb1JRYkZkejJHV0Z5YmNXZVN4MTZ3RTZl?=
 =?utf-8?B?dlh0elplY1RnajkyWVZyZnFoVWJhcWNWc2p4Z2V5RkVRWHVTZmR4MVVudWY4?=
 =?utf-8?B?Zm9LWGdGZ1VqVnZxaTR4amlnZnZXY255KzFpa2NqUHprNDRIejdiN3FiTmtW?=
 =?utf-8?B?R28xb1dpTklPQkhDN2twWDI4UmFuWFBSdlZrbXZLNnlmSUhJbjZIYThVd2tW?=
 =?utf-8?B?UHphSnUyZFdkbW9OSDdoS3V0L3VBdDhYaVFQZitJcWpsckUxaGs3UVNzelpm?=
 =?utf-8?B?Zyt0QWpiYWgrdTVsQi9SaFh4Rk5PNDJUeVdWMGxuWEJIK1UzbDI0ZzRnNzIz?=
 =?utf-8?B?WUJlTDRvUzdYK2ViT0lQR21IeXFTZExBTVRBTmttSzVnVm9LdjltUk80Ukp0?=
 =?utf-8?B?K2dpd3NnanUwRzB4VTUzK01EZWJMVEs5R1Q2azdPRERNejB3dFQ1M284NnZl?=
 =?utf-8?B?OS9CR0l3U3RjNjZtQ24xM0x6REl0WGlTUnE0ZXFYdTJkREpxWW9CdmttdW5G?=
 =?utf-8?B?L1JFUHowcTBXaVVJN2dLUUxJUUw5V0JTbFlHMHljMktRcEc1VzU1Vk0rWFAr?=
 =?utf-8?B?N0kzWWZUbDJnL1k5cmYvbDVVcjdxdkdORjZEYmxZdzYydWZRTGQxV3MxZ0hx?=
 =?utf-8?B?bGREalBnTTNFR0Zua2g2ejRBR3ZPYkNJSWVnUmIxbU0zNjdGVGJjMEhFSFdB?=
 =?utf-8?B?ZGFobjFDQmJFZDlQZFI3bmRpazQyNEtPUGNYQ2xBT2JvT1c0dm5wNEpUa1Y3?=
 =?utf-8?B?UHNoWWF1T1BLQ2MzMHlaVVFXVWx2RUFmMTFZU3I3eGd2c25ZeVk3MVFaT2o4?=
 =?utf-8?B?SElSZVBzUDBLTkwydlNaUmNiS2hqVWFDeFFUTVFIRUtqN1ErQ3l1bll0RGZS?=
 =?utf-8?B?RjhPWjBtZkUzNGF0Q3RvcFhqUjdtRXZXYVAycVpiaTRUYkp3MkpxeDIwMUEy?=
 =?utf-8?B?ckhBdmhSb1dkUXhHbWFSRVZtNmFxRmNxNUZObU1sV255K1Z0S1I4YXBmODdr?=
 =?utf-8?B?Ynh4Q0pqaE9yN1YySzh4SWF2ZXl4OG5GdkF2YTd1NWM1N2lqZ2N2a2greTRG?=
 =?utf-8?B?MzBOSVhCdHdmWFNaMk4vTHlPR1FJVTJNNHk2SmU3cEk1OXRZTHpVZXBRTk1n?=
 =?utf-8?B?c1M3RGptbU1kS3J5UHBFSEhYL2x4WmpJUGJMMmZNanpSWVQvK3RKYWVIa3c4?=
 =?utf-8?B?c2xLSjA0ZWFXZlB6djJCVWIvK3hObUJRQmtaZ3c0K1ZBaHZXcHhUVDBJeFlL?=
 =?utf-8?Q?316THWfCEvbD9iKM8FrYWRkyL?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(34020700016)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 04:01:35.5796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d0340-b680-436f-f6f6-08de1a8daeaf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8337777B9

+ Francesco, Wadim, Daniel, Matthias

Please test/review

Hi Siddharth,

On 25/10/25 13:07, Siddharth Vadapalli wrote:
> The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G and
> CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. This
> correction has been implemented/enforced by the updates to:
> a) Device-Tree binding for CPSW [0]
> b) Driver for CPSW [1]
> c) Driver for CPSW MAC Port's GMII [2]
> 
> To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
> 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
> 'rgmii-id'.
> 
> [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example")
> [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
> [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII ID setting")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20251024.


What boards have been tested?

[...]


-- 
Regards
Vignesh
https://ti.com/opensource


