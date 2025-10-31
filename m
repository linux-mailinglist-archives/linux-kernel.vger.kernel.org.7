Return-Path: <linux-kernel+bounces-880380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD75C25A22
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E55405DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77DE34C9A5;
	Fri, 31 Oct 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IRUWm0rp"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4734C82D;
	Fri, 31 Oct 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921777; cv=fail; b=LKJr6eTXn4z+uVQ3KhoZHcSQ4zTwR1imxa/SmFkShAt8fy3Wpquw0cuDpN2P6JkXB/g1EpUNZ8Bq5hWBnq8avesNeu07KXuTxb/trC1gURlfSoAO2EgIBtZ8xJqs6L8h2G0VgFjpB9UTuU8SzT8oDnAM4mUhVprIfqZ2AqtDnXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921777; c=relaxed/simple;
	bh=GbTcGtdy5nc04bMN/Ppv/y+iotyRl6+ld55b/Tci3rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfsMQcNS9IGh4g2m1yqa3NA7NnMXAsYlQcXbQ5BBZlvudNne7UbM9snZJ+2f2pGEBjvvjBnQoYK8rPxEu5FqZnaYHLfHzJV6e5kY/7+fx0H+11v6TZkw4wFTLH36W/evrDh3+WjueUlYN/EsBkCL04+F5XgTzAiNUW7jrG0bMNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IRUWm0rp; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZtzxbdMGIMroQfSOzIWbDPhwkdQ3+mSiNWGVX0MDxaZvLiXU97WuAvD398D+HML88N60zmyCgCEj2tSZd9tpBNrtiiBvFFuRGFvON6HzMlhfGDUgNcVMH7nJAE2aSN5+1KYTnWvOXuCgaGkB6oOtegn07nJHL84YNqdJW8w0KIaLrXQ3nPCAO0rJLhyWxngEaJ9MiT9Dw/DC1gZZYLjmECKgbpOnm68YfxkegYODMUvwh6RHkGHDVN/Qvl/GQZqh2PGDsFYp4/biNSplR5PeNm5Z1bIsNj124b2EoB94J3z/MVEOMlbjiB2LWFzVbtDxxkOItu1Dm7ty6YYYoXxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jNgLgU+8Dhd7NVBFoNb21G3Q8hVCVLA9VFcRjhpm5M=;
 b=CnEcSH+l9gU7tdStpAoD3LzqHs+ATLDEslgHc2V/cDKeb9kdJdLRGNHxKkw037zNqF1F0p9l1Nd+cPwuJThnCB6f6hFjyaaqrbUYC05qX+HGP7XhkLAXhuCWTVSZoy10W6oVUCGvytSuVOE96pw6g5mb0y6B3t7qKixUs2T9HSdBp6bC5cBY5/hMgu316HgSHROkRGrqtvPR5VnVQs9ztN9sc6rhh7QXNXiOxd3KoRx5Y+mfLB9sCsloiOAjEPqcIhHffcnwX0k22Yl9dorxs5BvsKSmnLBKXpyDBku5KM7splT2680II0wVuTHfl9h8lEZhiLACcCmKQEnWDY/uWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jNgLgU+8Dhd7NVBFoNb21G3Q8hVCVLA9VFcRjhpm5M=;
 b=IRUWm0rpM17peMxxOktS2YirEKUZqPpuNv14V2zSzbQsgYrBa4KT0ibFxGmxiJOopFRr0Ub2etfC5YfDJ1YKaAW8ohBDaJv1qlmAmko1ao2IVRTWIPMENBfGYViln2J61v+QaliXi1xfot58K6WwmazcBsjFpznOWVfyTJMJRLQ=
Received: from MN2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:208:a8::37)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:42:51 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::72) by MN2PR12CA0024.outlook.office365.com
 (2603:10b6:208:a8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:42:51 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:45 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:42:45 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5V4024498;
	Fri, 31 Oct 2025 09:42:42 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Aniket Limaye
	<a-limaye@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <gehariprasath@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull configuration
Date: Fri, 31 Oct 2025 20:10:53 +0530
Message-ID: <176192142809.427883.385396429453219228.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251022122638.234367-1-a-limaye@ti.com>
References: <20251022122638.234367-1-a-limaye@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH0PR10MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: ed08deda-bb62-415d-5bf0-08de188bc4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1U3ZlQ4SXBuUjVrTjZPZHV3VlplVTNYb2lUaWxwSHNGWDZQNnp2YjVKeGNT?=
 =?utf-8?B?MnBFd3hKYStBUExWSCtKdXJSQno2dWlyNWxzTjRLbFVkb2U1ZGhvRzhVTTYr?=
 =?utf-8?B?NFdDdFljcWJ4Y3gwZUtMeUZjT1kxMTNienVRZ3N3ajNuSU5BbUZUN3VueHFL?=
 =?utf-8?B?WW53MHhVcFRDcmRyKzJzTjBWQ2MwK25ZZXNrQ1hVdEZtU3Vub3NoZUlFMGZZ?=
 =?utf-8?B?NzhSTnBCb3lSa3BPd0JFUkpLZXJ0V0o1SVFCS2tUZ3YzWnJsMUFNNGdwNjVn?=
 =?utf-8?B?OHJwcEppZ3VKK0VkUzh0ZWlaQSs3dVZLM25XTWg4SkhLQjF6ZXVJU2VzTlA1?=
 =?utf-8?B?cjZoL2xvR2dSRlgvMExYc3NHd1ZQVWh6K01ndURPdlV6K0lLYjNsSytZTVVQ?=
 =?utf-8?B?TUVEaEF2aTN4cWQvaXhUd1BCdlVtYjRaWVl5akNDUjRRMGhmQzhheGZtQ2tP?=
 =?utf-8?B?REhFTlNjT2o5ZkNlazRwSXhSc2lpamlHb1FhYzVuNHdYZ2JxbEpTOEVkaW13?=
 =?utf-8?B?RlBFYnJYWFhkaEZVc1h3UGZGNXQ0anFWVGVSdWU3bWNvRUlmd1M1SEJIbk5D?=
 =?utf-8?B?bjZNaGpSeVIxRm5qYkFEOS9JYnJDbXNQbTljOHAzdk1oWTlMMWxBVTEvQWpr?=
 =?utf-8?B?MXY2c01nVTVzejF6K3NnK1o0ZmxwUEljOVdlTzNPM0FuZngrekpzZlVEMmpM?=
 =?utf-8?B?TDRVR0JxemtZVG83dmszZ0F0RlVSRGZwZmFDcWNqNTJSMVFMd0RiYURrVWpJ?=
 =?utf-8?B?NjFSWnAwci9IQ1YyS2JyQlJvL3J3eG4vUkEza1pXS2hRZWFOUGV2MFk2WGZD?=
 =?utf-8?B?NDhnTnpPK01yaStQRmdjczdSZ2NBZnVuMlEvYkw2cFlDV1B1clFYTWF5c1VZ?=
 =?utf-8?B?eVFvWVBpRGc1WFFVNlZSeFg5VnFlWnJIaFlVMUZuOVg1U01KTUd4ZHhzVlZh?=
 =?utf-8?B?TzYxeU9XeVBwSUtzdkZPeTdpNmVNdGt2dXI2amg2cjZKSUMzM2dDMUdKYlc4?=
 =?utf-8?B?ejhweGpkNUVkSkcwdlJ2RkFxYXRWSXQzR0kyckgvNEsydDVHZUlqY2REZS90?=
 =?utf-8?B?U3FUS2JQSmxoRlJFMmtmckFId29OOGJ4RGlyMlNVVlkxbjU0UzJGM21nakVa?=
 =?utf-8?B?OE9vd0ZkQlpCcDZuT3k1V3FacnZnVzlwcmwrQU5LaUQ4a1gxZHFRVFlueFpU?=
 =?utf-8?B?MWZkZ28yclA0ZTdtdlZ2R3g5cjg4VkhqMmN0djR2Tk9ua3htSFhFYnUyQVNv?=
 =?utf-8?B?eFZsSG5LK2ZKbFl2bU4zZjV4dnBwSnE5ZktuZHpVNlhpeFFBWkhPSXBGMURo?=
 =?utf-8?B?QW5VWkczUlgrazJlTysrSzFuRjNEdklkUDlLWkwxVm0zOHErS21GNFpWU0dY?=
 =?utf-8?B?cjBqMGVReVp6ODdCbGFQSElOWmVPbXlmNHJjWkRCd2h1c1lCeC9YSjdjZ213?=
 =?utf-8?B?TmN0SGFyVU9qdlpTTzFFcm5rb3JFTHpwb1BSRVZOdkdOWkxLREJoaWxsWGNQ?=
 =?utf-8?B?cUl1Mmw4T3ZpbjBIdWVScEs5UFY5NTJyQ2pNMmhRR3hzN2plSTlTVElsdGl3?=
 =?utf-8?B?ZGdrckQxa2pWS2tCQ1o4aUNmakVrWkpubEpPbW5HbUgwOTFvQnBQTXpnSlpx?=
 =?utf-8?B?NmNVVUIvM1FjRFI1R0xkYStnUXFiWFltVWdsZlJMVzdGSlgxdXRobWtOSnZG?=
 =?utf-8?B?MHV3d1ZGVGlwekRKRHFhUnRRdys0bDAxOEtJaktGejBQWThPUDFxamJBYmJs?=
 =?utf-8?B?R3JyNUdIaVNyanNYS2l2NFIwN3k4QWtkZkE3Vm9tMGJDU01lN0RqdUJOWlFa?=
 =?utf-8?B?QTN3a2owQTFBN2xOTklObjN2VlJ5ZXRyZDdkMXE4QzFqVERSWHp1Q0Mremgx?=
 =?utf-8?B?ZThiRDhDTmhtMGpkMzZTVkxxdERXOGowZmEzeXdBYmVUUW9Jem9RTS9nOFhm?=
 =?utf-8?B?clZZZUgrTHN1RFFGUEhSb001Q0F4VUgzSlJvY1M5OVU1ZENUWkZwNVBSdVFJ?=
 =?utf-8?B?STc4cGlGUmNVUkplM3JRZ0NUUWFhejZ3Z3BjcXJQdlVMWXNmS2lRZ2l6TVdJ?=
 =?utf-8?B?dUh0UmlhSkMvMDJ0RDJzNnppR1VBalM2bnd5MWc2NEFkSThxTFhJUjB5U3Bx?=
 =?utf-8?Q?hOkg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:42:51.4500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed08deda-bb62-415d-5bf0-08de188bc4d8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209

Hi Aniket Limaye,

On Wed, 22 Oct 2025 17:56:33 +0530, Aniket Limaye wrote:
> The I2C pins for some of the instances on J784S4/J742S2/AM69 are
> configured as PIN_INPUT_PULLUP while these pins are open-drain type and
> do not support internal pull-ups [0][1][2]. The pullup configuration
> bits in the corresponding padconfig registers are reserved and any
> writes to them have no effect and readback checks on those bits fail.
> 
> Update the pinmux settings to use PIN_INPUT instead of PIN_INPUT_PULLUP
> to reflect the correct hardware behaviour.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4: Fix I2C pinmux pull configuration
      commit: 671c852fc53d1b6f5eccdb03c1889a484c9d1996

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


