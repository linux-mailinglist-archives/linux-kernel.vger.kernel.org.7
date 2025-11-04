Return-Path: <linux-kernel+bounces-884211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53118C2FA13
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED91B4F307B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23391307AF9;
	Tue,  4 Nov 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vY3D4WC3"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F45126C02;
	Tue,  4 Nov 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241492; cv=fail; b=IsfYMQX5vdQx3Mxym0prnF91WlGeifXuK+K+sPXNFmxddPwx/AKZAMWIyIlc3A4z1cnlLShvb2aSnw5Kd+owpBdEYdR8fMwRvCqLzGvSScbaZlFEV4wi1opeR5VlvqHMzHNANhwc3/qIvH8/fu/EkyFJkWgyUY0DYSJWFBp2alo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241492; c=relaxed/simple;
	bh=IU/zrRNm5bjszk2e+QG3xg7nTjEYTQTr7SmR3+hEqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlN8k7a5Q5k1PNoFv6grzj95zRtYXD6G3iVxYmD9Daay5xWNeGNFVatq4BW4p3K5+kxzz7U2iMYBXVIlbNwzwQ5nQ0c1f1M3PP8YumpaLX38juwGcaDsvFqi+tuMov+Wz4O5KX3W/iB82yDl6XrfsEazI72Tmb1BaYGbexumE7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vY3D4WC3; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSn9lLzGiUq/kjHXUrFHLSBsFBtey0AgRFQ7rUKzJjXIcdz87nYe6ifLlYLAdKW8DwWeJ6tMfSrOeTYhNgH+YzCkjcowgok5GG8BYit3JDiTYDLKuk0Am48H9/Rk9GrfK4nD/ErLNtHJwrkET4ALPYgTjaRdWiOHLeSN5zh6CQM9n0Pd01AYiZQOFvPUYelyp5g2inZdz2TfnSIqkbSNRIFysZ9h5LKktx7Zqa1el32UaGJj8CW1mLnCfm7Yps96kRhn4KS7TMWr8JgCQYP5Cu25JfxakKEZeMQJ/hz3k9JKvSIiAsGiftWW9+WUxGrkpYybpsyHwEGRwD5dlUp0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukWl9JWXL3JdBvct6OgDQH9cv4oC+ooiBUqWCWVfJec=;
 b=eZKePUEDIs6AogTmYKMD/VWN1RaVtQiX0XV+7pKPy9pfRVR71qtumzl4UeK59fCU/LoN9LSxVcSFLG/8650U4PFqwc2L7VMsLZNFgYBWUmgzySVjG13CzeVRqqU+svhtAz19AxTJv1Vrk70jW/cKU4G+ihjWHq1GZMcHdJzCqrOoD6rBo7Y1h4erUFCJi+g1PpFV80EuZpw7ro2656ODb+ocAxe8GD1Xnk4mjZDbgD2V+A8btL4QW60GWmYOR5JwWm06hqAfMpmH24LQwa1aH0sdIwduaLREPyjH4YBErKf2AG+3dQcUNX+F1pXJeNw6b4JIAQpxC0+WSutgDIM8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukWl9JWXL3JdBvct6OgDQH9cv4oC+ooiBUqWCWVfJec=;
 b=vY3D4WC3WrTQZ2s52Xmbbx9yQ4mPqCsKB9Ki1wqWjeeG55gveNrYbMfCcQRz6tSma0PBzraCmM/T2t6PYKsqj6C1q43q90dEaZF0MchIL9+W+Sdxt9mqSAFuu+ROOnSX2Qg3BlwQrAtGEziJXny9LWtAXeFPtqgYvMmf2ltfpEdi61yEC1hn/wr/TlQJOUiTAvHBVWlZPThCsaQt7kteYAq7eEAOscQrBSKHRDDujPHakX4crXqu6n6GLS7NwmfzfCtw5pLDwS9BHU0tThR5iVCK/XP9ZNnPWovnAxScOv6av0fFVO7iS6gg43zsUefj52fTgqig6jl8ZM73LmFYYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 PH7PR03MB7509.namprd03.prod.outlook.com (2603:10b6:510:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:31:27 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 07:31:27 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
Date: Tue,  4 Nov 2025 15:29:06 +0800
Message-ID: <4ef059b129e9457eaadcfa6b996b9b6b000c7dba.1762237922.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762237922.git.adrianhoyin.ng@altera.com>
References: <cover.1762237922.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0016.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|PH7PR03MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f972d1-2232-4cbf-273b-08de1b742a80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAAeppMlJD+0OOcZhLstRp2A7oVrjwwqSM3+/Z1DJ0yg+CilaI702gAwd7OX?=
 =?us-ascii?Q?kTwYiMSXU24qrLgBd4SwE0XqFwPce5XtLn3NdFQZ2L7SPF/+Bh+z2lh5oNCT?=
 =?us-ascii?Q?24ccJ53CqXhh/ivPUI/a8s5CaLNcolKTjNita1wyGEudg7eEMQ6EHI3T3l3f?=
 =?us-ascii?Q?jsNoNWL18MDL0G/3xCwO6JrU+C109DSAUNWhGzIOiPR11GOa4TQVAYv6OE0N?=
 =?us-ascii?Q?x0m3Czg3doTPEkaY4wOiC4Y3m7c/bjFj92tIrWxxBp1hkyNUz25jX7EVqta6?=
 =?us-ascii?Q?nWP7vceQrd87bdTYJBNoWjG71O5K1WDFlrCKD0/Kzcqp/1s6d+h9mj5bnlmm?=
 =?us-ascii?Q?B9op+cjbRqtNCXfoK/S89WhZGh5AOSI0xfwSClkuHVdsvYCmEb2pn1uN8z3d?=
 =?us-ascii?Q?aqGfPx613LxsU1utBZQ9K8690Xc3v4IAUhMcu0XjsNjC4Jw0IGr5RkdbZGlc?=
 =?us-ascii?Q?jELNVEl2lD0DQDoq6FM80urLrMhHYeYq6/aFxtX7CYiu6TvgbI6dRVcsO2+j?=
 =?us-ascii?Q?z+QQ9ugt6InLUp9Chk2bcQjU+5Xu6H1F9nJHATXgehOuwbWECL3nFf45q2CS?=
 =?us-ascii?Q?1VX8X6zs0vNQKMNX51thJZ0XThtE/h0GyZBHB6rAjcAK6tAJxKimVjPW3AEi?=
 =?us-ascii?Q?qWNxfOpKtTpYnYxXFZU6J8XAtkrAGG8VCj82mIYdtYnOSugS3zwFDPjLPyIi?=
 =?us-ascii?Q?FGRfYk5ywzBkJkSd4td8fGHUeY/koKYkDud1cfyZ1S1wfEb5XuVFbQfN7cRv?=
 =?us-ascii?Q?iNoM2o7T8CxBEZz1S5MZo+w4T2xQKtv2u9UXP0kpvRa3gOBAPrZvSWeipWii?=
 =?us-ascii?Q?KZ5CeDdoHXIdBWPgqzywew352TGpiEZtvXEeX0HzU3L0s6DuDdgFjy5KDyeP?=
 =?us-ascii?Q?No+VpLmwptg41TgOOtQxyoN9PFjGAeDleLT13EdxNaI7GI35hEgICvVMmjrC?=
 =?us-ascii?Q?u2XjTtDChgUqbN8Vm4nX4HOeojKdllHe0VcSHmbb5k+4ETjxE2hPGWJe9aNF?=
 =?us-ascii?Q?VVLp7UEd6K3zENWYvIqBN3+wFllZr6TG2GVr/I1ubTL0m2XhT6BXg+NLAoWj?=
 =?us-ascii?Q?uRivAwzNE67SoWU2kfRu6UvXPMZgxyLDaFWYKb1WZ+lq3cXji065WhVBIu9p?=
 =?us-ascii?Q?ePArOJ4WRYg/rdFfiY3eq6D2Li9rmp5E16JiA+8PO2/M5KSiSiLRZVfapcDo?=
 =?us-ascii?Q?WrS+sC2ATPsdXUX5MT0cUdIAagrziElTS/L3aaRN72LzvHACv1bC5Icb6n+V?=
 =?us-ascii?Q?2bsndgLzjZDVJn1E1YakwF1t4KA+XQgtun5VWE4RggMpzX0LRQQB37oi3ivv?=
 =?us-ascii?Q?hv2e1hLfBjdYADa7OZbD7yUf9EsR9ZeaL1ARWKFU8NHZejpxLy2QWgbUAoyd?=
 =?us-ascii?Q?psxXHW+vGEqSyfwmEl8hu4i9SXkRAyeBr5Dr2n5cRBuZlW/8WqjIf5h5D+9o?=
 =?us-ascii?Q?EC9dy/rLcPkpt8FBOwb118m+cT0WNqQJeVdp6RLYGMSEYPoJSoFtQB9Nc+3A?=
 =?us-ascii?Q?xHvWCE+id8mFseY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nsIlwTi45CWRRWCU3SrhBSNYIJOQF4+145q5S4EMLuy+G/bVBLw/pI+ySwY/?=
 =?us-ascii?Q?vw4XcEgJx09tseO6EjlgYCuwTuQ4h1kChiTVu+gsPIESVnPokcgBDCW083UD?=
 =?us-ascii?Q?JneP/SFNkTLIcmVCQhYkYonucpj+yPH/wjFF204fQMDb3kuO0GuCprqREqIR?=
 =?us-ascii?Q?yEBZ7haiyfxcfBY/+pkZHpa+Y2D3CO5AN/Tq1004thwdzU5Yl7U/lTkAkI8E?=
 =?us-ascii?Q?Bm5cfjauH9OkZocRaznDgWrPHEIUO1Sed5NYyivHCnBKXTi3FWWIYtRTsHFk?=
 =?us-ascii?Q?ImB7cWnTFtzRlKjmHXmuiGHH2dMaBXXXeeFAeVxMWphw4Xl5DL1AO9zssWpp?=
 =?us-ascii?Q?4mHn3p5cNhgOJ1gdo35PoDgzxti0F5usKZejjXakAhiLgNwCMhphIalld246?=
 =?us-ascii?Q?ZeTOWcHY2N/EsXkp3koKsG/RCUjZodUsWQYdYF2l9SWSgxdNeK+Fwr+g7qW5?=
 =?us-ascii?Q?voX0iq0chwyKYsPn0hcxGXH9inTk9ip4rDc4hjQTGMFhPNKR822Am3AH9uPW?=
 =?us-ascii?Q?pHbOjX/ubT9no1BQv/kxgzxNJ3LuSfrn8leC4GDfoJW2C8s1TxPluZBYEW8r?=
 =?us-ascii?Q?gnRbEIAA6okKC0bHAgRNR4MGt/Z0Gjt8GugNcHnr6KqUrzyImieCyRvrRLd8?=
 =?us-ascii?Q?6djB+qzOtXxl1jcJ6A4F0IKxrQef2c209TFzHTUg72Sd7f0FixfhVwhf6EWo?=
 =?us-ascii?Q?MQFTsXxZScEYcZH3PtI9DITNAxFjvxgtVK0HqBRb3+asJVL1I/2mJhgIG+IH?=
 =?us-ascii?Q?9sdPTeCjUSa5i51G3kxrDFS5DrGAGMp3dIEovsoxB9RlLADTytcoVkj1JDsy?=
 =?us-ascii?Q?XRhflnhi1LvwYWqWqN8GItIaQVUAjKM+2Y8xjqwmTrMZkrLgnS2fEdbeDq9k?=
 =?us-ascii?Q?LPLVNoYq4eU8FykLi5QNGg4Xu1qYAQkmVBL2DeIhbcxdNe6iGIO4dwbRac4I?=
 =?us-ascii?Q?x4Qh/lbsgwBLxFljPEfAGR6/yBV9d6yNpfWWRWuLED8u40Q8I3z5eb4Xs7Pk?=
 =?us-ascii?Q?qviSB2Jx7WwY9V2kP0HoDCMma1Ud6HaIVtpBJ55J93AZrCImjz5K4asDQcWa?=
 =?us-ascii?Q?txBHGt6Op2dzpSw53xz4yreuK8EgXrN/0WBuNvokKxdqzXefhkvE6/SOLa4T?=
 =?us-ascii?Q?iGJLpCdRHqMjVzJMhCpVb5W0QHwQFwVyfx8bV5yv9SETJaTqulpb8dxbFG1Q?=
 =?us-ascii?Q?6iOU/wZFXgDQvAhkaNxkLVasS2HpU1NGlw2nxDmV341NQidA8yu+hNQ5Gklj?=
 =?us-ascii?Q?EJnhKQuB1gvFnfcyeZzOmy1n2hbnBaZb7BvTZZ9fUrAOO+E6AOZyLbPj7FUG?=
 =?us-ascii?Q?j4AaNfMjqrJ57IedTUiOZAt6nCpjYPJJ9RdW6liYOp7ADWhvIuhrgBLvfDdI?=
 =?us-ascii?Q?o2lmgQAQQPEF9f12qqKeOgl9aAzJAtBxj8L0i5jnasUYRVwqpXczCKZdVhLo?=
 =?us-ascii?Q?DQTy9uOuoQQawWJTL6iWADvwP1BRl6/G3OPsmqN8BC+yDLRg7Uy5975fOo9i?=
 =?us-ascii?Q?k+0fmQG+TFy+DT+UtcM88Q3gL3CzlPki+4/NhEqlpab28W22wPE2uB4A7vLM?=
 =?us-ascii?Q?URf3lV1t4MUnf/baybKjm0ZkcKVcHMPNSazj1VgjiPyvkCRy66IVqJa+okSi?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f972d1-2232-4cbf-273b-08de1b742a80
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 07:31:27.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mrc1ubDtVOgcZZ5H4mBAXjHpvDJmajWiAJP08oX8fc/jvoO9tIDyGnGUtxDbxCoglZfybiqtThZTCSZbF1MhaNAHwC1QV4gQESDGcaih/LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7509

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the "altr,agilex5-dw-i3c-master" compatible string to the
Synopsys DesignWare I3C master binding. This allow Agilex5 to
use the generic DW I3C master controller while applying any
required platform-specific quirks.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 5f6467375811..e803457d3f55 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: snps,dw-i3c-master-1.00a
+    oneOf:
+      - const: snps,dw-i3c-master-1.00a
+      - items:
+          - const: altr,agilex5-dw-i3c-master
+          - const: snps,dw-i3c-master-1.00a
 
   reg:
     maxItems: 1
-- 
2.49.GIT


