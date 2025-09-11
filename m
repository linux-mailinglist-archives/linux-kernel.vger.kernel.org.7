Return-Path: <linux-kernel+bounces-811204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306DB525D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F28F7A42E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3B02367A0;
	Thu, 11 Sep 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="M/rOXW+H"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE79225417;
	Thu, 11 Sep 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554682; cv=fail; b=gosu9/0PqbxdW4dxWNy5ZCbHjHGPR8fa3rV7kGactK0BrJGCh0vw8zmcyVo0tmCvzEr8YF7BnkIKy5Ck/HF/lLl1UC2Y4+SsW+DxPuWMkRJEIYj6vUvhDz9G2hmAmLiZQFqoaQMiWFbW+mXoJo+ehJSkbcy39eq15nvOU8zpSnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554682; c=relaxed/simple;
	bh=AkCIq/fz8vBNcBQI2sBlSPHDFOricqZEvhZ7ifW66xo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgVTaiNc8dNCZt2AXowF+hS2q+NInhaQrkFJ37iuxJClb6aa6WhRmSIrM6EPNAM3hJAvEDhDF5isq63kz3fPJcJViurPyK2RwpeqZ+VRuKF5sz99vzWZudY3yGG9eCPJ0X9UmmlrPHuNItEFomdwySGBxVazbvytLwygrpA3IYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=M/rOXW+H; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inr58aDUVL+sWlbUiagsV0b4vTo1ka0hNGnq5HwX4wCPo8JyeE7DnmCnr1Qhwongf/i8Eqma0VP/0/D3fFx5LCOLKWYB3r2Pfe9b+6KHYOQe/QcSkboiJNfz9S3JlPaCuL4IlwFewgkJ18bnt8ANyWYiY6jHJhza5E4yV52UIaoKUPOSQzPSKRpTo+TMCq2ju0e/cs3jr7detkFOK9r1mDhy6aDDGAouVVMOjKTqhPnk8GWwzmbJo6fztetqkig4TvdD0WNmiM/wLQgKYNz6FdusF5haj8jaS+qQjGtPz4lObYsk4ft9+fL89bmZMDFVcgJOx2vbhZm67PlOY0yMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDMHvBnQSGmRPmASMohfPswEN24k+OtDpKrdNcNIOms=;
 b=mKqIACz8qGHGue2jswvve7pwO+fH8CO5kSdBYwMu1VdEePB3QSaPwd7x9HBwncOk9l2eV/8w6tFro/sDhj6qgeKLD32fH4te9gY1ljGzKENcHO+LnvK1KtcPViTqVZs9EjVQspLV9DtIxMcTZ84d9D+WhlZrGS6tla0GZXWBofK62banf2tEJsedRUg9CJp2xMQi3knSW8Dxtoj2nBSxINZVJ9Bt5l6McOVkokgDyD9t8559sIkVTgxdzygFuu5eX9tpCrf+d9sW6uTv5ECS8XHIkLw87YREe3c01BZh9cyJp9OYQjNBKxDv4vdPXDHejd5OOeueDhfwScZ8JGae3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDMHvBnQSGmRPmASMohfPswEN24k+OtDpKrdNcNIOms=;
 b=M/rOXW+HXyVxC7MPBMIj60wheosWy/9dJbaPEpHEVsIeIkKlfvEQcnZJLrmPc7N4N47NoFCfjwTFBk27dIpRM0QpEf6cIwR7jf1SPD8FNsbSbGthTVrZUVtNAVcM6bNHllf4+Z/Ty72rqaQPTljaRe7BvKhhXzjolJ8Y7HxjvNBe7t+xcnNiAASl68fDYGXOnHiCto4ZcK1ovu437/HbdTzpLSVlgLAMlUyC2DLXFM6sx3s7Yn3y+w+ICSIAQslZ4agmVyfl45E5ilxd7yq8/CbpSyF5FkWbgKxmAogzhVBkSiJHzoTUTyl8ph2d84vS8Df26pOZvi8LeqAwYWPbXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by SA1PR03MB8083.namprd03.prod.outlook.com (2603:10b6:806:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:37:58 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:37:58 +0000
From: yankei.fong@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 4/4] arm64: dts: socfpga: agilex5: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:37:26 +0800
Message-Id: <645b91221320191844b2fa700832f70dce9f4fb7.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|SA1PR03MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: f228434d-5a98-4030-3fbe-08ddf0d3d666
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+s93lTFAFuDbKn4vIea9ujQ7z9p0GHRZJ+khmx+HO2WdW2kBjP9sjfOqXFp?=
 =?us-ascii?Q?tcnt7q6rfOo35QEpinmv7dv4jAtEtgzJ6HHjlaIdDbRH3pHBuqSdlNufC1eM?=
 =?us-ascii?Q?Y/KPBheZWcHxWi7XCuZpPWhb36D30YW71eBi09AEtKDlCYe1Ochp+Q7WoLj7?=
 =?us-ascii?Q?ClBZNFiz0M0iOCbsJ30+XJC8yD9PqL1I15o+c1JXuU95ErBCIc+c6Nx6soMa?=
 =?us-ascii?Q?oA7nLaOMxFLChZXNalo1JkqEbQ54zLnWhgL6eV5G9djKc9qmsYSOsUKC5y5e?=
 =?us-ascii?Q?n6K5kICnKRVc7izTXa9NMlZ/pL8s0kJ3opuERIU9cKoGSpE6iGu/3ZnB4wPx?=
 =?us-ascii?Q?2ngKH5DlTtEwVURb7G2poELenaBNwDehd9N7Dm6wEi4MwJzGSigowi/tAvWo?=
 =?us-ascii?Q?A5gwji5jbQg/3jbTJAUeiiv2XfsnHiaLcwJfjyGsQVy3sNLAZMPneUovrRHg?=
 =?us-ascii?Q?Ng153J++yFjRRAIYldN/tWZmZEr//kJCR+El9yxyGHmad9mS5KCUwVHzg+fy?=
 =?us-ascii?Q?zVYhtsC1euOTHNKyUbMKvGyIeHQUwjZ9sZEXOcBdcu9QCxEvBwo7FiC/nfIE?=
 =?us-ascii?Q?Lao0yDdeI3Lasmojye9PGEJlqtgDP83YrWBpG4Uw8vXCR0GRV8yDplc5Ajz0?=
 =?us-ascii?Q?vW96xzKhM+sTOp/mcfdWK8gyMP+VzHmrl1yQrmcvANHkIrsboZ6uBq2qivOy?=
 =?us-ascii?Q?E72OhvaIP0JOooHUWEQFqvls7pzPh+K8pGumdXG+Votu8cHMwvLdzgj4bU7h?=
 =?us-ascii?Q?OkVlreTAKMA8kOcmN8TWf+n38ue+mb/MFjvIRlZ8nLf8a8xTPBnXHNhKODbz?=
 =?us-ascii?Q?tiYz3e9UP322npFVOZ64wAWPJNoZRfThiWAp2Ysl69zGi2HZXZWfIR+oudwu?=
 =?us-ascii?Q?b3lMz0THTKv672AQ4NOZ2tSSaZ5yn2GIVZlPxPa0phebG/zUySpFIYMrR5Cw?=
 =?us-ascii?Q?IsbbmNHYjKN4D3VVUnvBfdvgePk0ucNbZTzAq14yIi3xGY/7ho09nq0zRled?=
 =?us-ascii?Q?Z3TupewDXVUgoTK2bCigIGzkGrdhofTYdtTGJSgMO6598p7v/l2Rf9gAoJ8w?=
 =?us-ascii?Q?cd5wdZxGeVOav3JgkyGQ21Z7rqOH3FWtlIt4z6vI8dDYkcka2bTm6kOCQMPR?=
 =?us-ascii?Q?BqurqvNA5ftHUXIZNA6adz+fWGyqpOTIjdesOcKSqMf7sarsZU4nlMSx/NST?=
 =?us-ascii?Q?sF3F2aphq7JKVHqB8Ot5pOWrEWXM02SZzYHeOIpkrBK/llHtsU+EngXHJNEp?=
 =?us-ascii?Q?JJAFI5lv3shECCnR4hUnlfTWwyV9jnOpi/T3TMaHJcYgEjnICh9gjDzuZOiU?=
 =?us-ascii?Q?gpggFuwrtgzh1JzWibVBD8pY0NEGwis5DRB+CPVv9kgngvIuipd/2AND6PMp?=
 =?us-ascii?Q?FxRNH0Luvh1/BYeIdX5+EDem02bFOge4599MhTZu+E/Af0uKz9Sv2zpFYYnH?=
 =?us-ascii?Q?/rqzSTxQG5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tNorswXNA1l9zVYKByAjrQtDmWin9+CtC0usaqOEB/0mjwUAHTdxU1NnYO8C?=
 =?us-ascii?Q?mWFhj/MHvcCBL25Z8YUdI1gNlvgjD2Z5UDItTUK17SybMSWi5V6UVk0kpCCt?=
 =?us-ascii?Q?Dm1fDgVF5+qmGufDsC2f2n8PnT8hz7F5WeyaqBYGMWWBQjCr6+I9ivZxHhKE?=
 =?us-ascii?Q?1mNrYIsXYd73Zb1iHZpZGKM+k1xztO77GXdQ4IXAYCNfxkZj0iCQdmIyn+BY?=
 =?us-ascii?Q?ANE8vsfDVGAlH2IuPejzBeA1zgaT4qpkiZXev0gVz1x9zfw9yzJen+61ce46?=
 =?us-ascii?Q?cvbWWhrf14mBtLSij2Gg966BI2piHnX2ti4Q6tMYMaOfBszwkcLNYHlbC0gT?=
 =?us-ascii?Q?HBy756hJGPzmZWQU77EpuZSkPBNq4afX1qunWUy1D2cWZrQZkq8rNKtCeG5U?=
 =?us-ascii?Q?W3riUfCWsokd4RH71/JneG1KOtVnVSkyzuOzyCYlkbz39WDuIyXkvPG8nvam?=
 =?us-ascii?Q?IbSpEB7XAxpFd9K4412yjwjF3Rq0BXkOK8EF4XNMh6QruscImdBJxQSzeeXg?=
 =?us-ascii?Q?g8NVONCbE9Nr65knqcOsc5Jew/pNUYP102pzV6l2h1x/iXmzLy8L3Uaw44dQ?=
 =?us-ascii?Q?Hqea7RfnCr8UqxpSSuQv5Uq95auWvERMhM/gFE3lKf2uxo12Nv8meJglRVlU?=
 =?us-ascii?Q?vmlq7fgDvqnnnyXIojuWgsLLmgsfV7gNgsxdIGAQff3T8DsJRu0Qd/TvLhLb?=
 =?us-ascii?Q?F0dZ03lOTVofnXt7bx+LVcJau7M/GUyD5oT187ps1WbHX9+JI5tvbmTZvZt+?=
 =?us-ascii?Q?2ls92qOQlQH371j3sXpJcmG1fjoaMDZNNJyMXJXHVzdYJqabCph2OZ8AYwmr?=
 =?us-ascii?Q?fwvOcU15LKSxUSy3dQ/b7vxUud72gsBE9HV+rz7FptnaI3VuvzYikKzuDjL1?=
 =?us-ascii?Q?T3iZ6lPBXdm1F9yH9GP5FaCXB8dFlCTImToRuicpR13hl7g09rKHLbPmsiYd?=
 =?us-ascii?Q?MCQ8Zztb4+6/wBeVktycxPwbAJYlQlFVQXmoM3OkvqvZPabfDHxet+HvGmdG?=
 =?us-ascii?Q?VRuHe5PpIK4UGFitCToZThMAHgH5CmVouE3287p2B48+N+BAOZk2KfJIv12g?=
 =?us-ascii?Q?+gtxshZYGgZMS326r4HTCuZi/j0+juVGEzdo6BXEsoSKnowDHjxYW0XkqHDN?=
 =?us-ascii?Q?hEMRKO1ynq7ct12yEvZisGjD0bQI9mmdtjdC07a8AgR0s74O+tEfzhQ6wDFt?=
 =?us-ascii?Q?eXeh6ExWOG/glX5fC8mWGkcvbGh+YX/Mz555E3zVFOWmU1LfCRs8L3GQH81H?=
 =?us-ascii?Q?riJMfsjEnrLyeS6/EQCP37lYGJcxNTcOfElgr63am3g8b0G7mlPHJgTFTf40?=
 =?us-ascii?Q?uPkbih8TNMre5LhhdPxJxBodc7940SZyZiqzCZ3oQm8RN3WmpoVkwzFH33Ez?=
 =?us-ascii?Q?E/felWM1kSbizk8DMLx/WTGk0+23OG0o5I5JzWVBZ5WCeD9L+hJpeIlYJw6A?=
 =?us-ascii?Q?66/GvzUztpQ/0ptNPvxjg6JtTI63qeu6XBkNKKz2xqdYkdOgjFdVNpi2Wdsd?=
 =?us-ascii?Q?4oN2YuvhwTf/Rv1+zVDvSCz+YCR6z3PuyKSbEiSxeO4gnMguXk5drzcQTa8A?=
 =?us-ascii?Q?7+M2/GXC5gSIy+iFtanZTYdiDBScgBDvwH6YDoHn?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f228434d-5a98-4030-3fbe-08ddf0d3d666
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:37:58.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j8m9wnbG3q91a1uKRuGCz5GziG/m1PmGUgF9U2F7uFezRzVi74AppLNUV5O1snEjV0p3b2J0X7cAoaNU1f06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8083

From: "Fong, Yan Kei" <yan.kei.fong@altera.com>

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the
agilex5 device tree. This update configures the SPI controller to use a 4-bit
bus width for both transmission and reception, potentially improving SPI
throughput and matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index d3b913b7902c..853e260c3976 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -57,6 +57,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


