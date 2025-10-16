Return-Path: <linux-kernel+bounces-855713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0CBE212D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC83B5D60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D202E7F3F;
	Thu, 16 Oct 2025 08:01:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1C284B2E;
	Thu, 16 Oct 2025 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601685; cv=fail; b=HEmpQq7lIxesJNdzP26oZjas5GdXd5WQvpapONKSYL7Hegqo8XxmNa1yNnKlB2jHtpQKx6NzeyHBb+9vvsgTLYFWyqGiepe+ZgJWmIB3hEfJA1vC+SXASr5kSrv9JJoX9vMa4ynk2cesV07WX2jvabUrb1H1tTcHcyX4bM9KV54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601685; c=relaxed/simple;
	bh=LmFwg1pZJiirdmN3SzEW0bqJQpM5YxkR1NoHxjv4OWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N92JQ2edFXBSFxwzhdtG68kS7jshv5Ql4xu4+ZFc/FW0WFsYHAPjzhXN0nQ69VGonEI8i0kl15l4TwcZx1HlXF+qRDd4NuSAC7h6+7VOtxPStnf3Jo2wiLDSJFD8XrlpkcNod2Ov5PQfW2x8UzaM47ZZKCGkff5m7NQjtdo2IJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl3bZUf6MfOlGD6rRNzLTEZlGFEvgZL/zvdXI0D5jmmogG3heKk6IV3QHsdPAC+0fetmw/gKsN0TyPrZY85fRRY2s0YRVIe/7WH9p9ER4haYFRf0ijpTJJwd9w6JSXa0q+FMoAlUns5wPcsklWJ/n+nscJmGqSTAfFuUPj5/AOHR1naBSQytsOWfZCNkNmxPCJwk/B6GAp+43X3hTFgQXxHmpAq496RjJ5TGebryOzFLbzjzIleZHlTcui9DlY7aiuXddk90qN6ASATLjVDXxgP4Fi48docB4i1E+Axsqhoyj6PdFhbCo7IfuEjhAqXwsNVxEqXXIoZSE9HLXq94qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkUvNjxecFkqQ8vtad7khW55nIJKFheqDBO3iddTcNY=;
 b=UziWKQ8CDgHVe16uRW45cFqVCV+cq0PIyqQglAR5Q4P9kmvpz5te1Z6A0BexBCatlcZwV+4uLhpYTOGgg8NrKWOU2n1BYQr76OIh5vCsy7mU8GgdiBxOebspyKMGRwM6TwP2nyd/8saueUYIyRMHOEdPdV8TnIlJhhooUQ94n6zjZEjmKjCCMcYLQP83L2uxfMNEOWlo1cAu5h0W6SnK5+ImeWVHWSvoyNEGqeLqH1VdlTy2ZsgRK9bjorX5oimeA41N9jvo22X5E4g16R2NZ2TkaBrRBMnri0rbh40o3bk8UYlVhQ0Ycmq/Ii6cAaFliA+mvfsa1BEDgBqT9tdWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
Date: Thu, 16 Oct 2025 16:00:48 +0800
Message-ID: <20251016080054.12484-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251016080054.12484-1-hal.feng@starfivetech.com>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: 1921c4d8-c43d-4bfe-ef6b-08de0c8a272b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	t44V/qNzxjjQNjnShWSfOFA0/MAan2YZkKDWleZehr/TFURmp7FFDOB1oBO8XJMRjQ6S1dlQQSY4WtjoajxV9k6VtSI/DoHLUTbhH+MCEmaxHjnOiCAi/X/lz6x2KcGBnlVa06vB1+BM1v8shmO5aDj84v7ZFZuoo50c3X0UxJAe9yTeI+TapkUBPCJ3l8gRBYmCx8+i70l8y01M5EXLVZwYyZDJmZSRU/6UlG/C6Ha9O9dWInpXDJ893qGEzEnRJkr/EvznvDY8vVDkR0I6kyjiYl4sydK/hLQZN2kiV9a+Z+oDzlmxK/9l/J6UDLU2YgvQtVZs7pK1UcTjDt8Q8XaOFV9I28HWfclbq5tE4uVOz/b2XVkt8XnrwBy+JZRscc1N4Kt7praD2svzPZJND1tAxxfFn9AK/TEP4Aa7tAiEAMnqFFiwkVXso6vM2nUN0DFPtUmj9GcH7YbOjTjnF2xor0KuBMItHR5lt4qBcjoB23wwE1oA7mtdkzX+SDQzQ6xgex+BCy1FDB51lFH3vKxhGXEbaIQU53DYpR/ZJDVAfIPKCB/wmgh68Oj9nJi+er92MBUGnU9ZviAMDZjNd6x+39ya1p5aoC/u5D9IYDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFPfxuQCvdrKZNgdTJ+CiOBYw49ZAeMUPzoxcemVZCSd0F1HN4hs6w1dIVxs?=
 =?us-ascii?Q?56YXYI8vWuME47ur2lEjqirjGypdE00YTaltX+BORN2vQNeGKVdIzcz7i7rz?=
 =?us-ascii?Q?QiUEfHCvI4yOq/woo5khmMqr/qZ8QJxAUeTyRMlyyE3mGx8vmhL8FJ9CY02T?=
 =?us-ascii?Q?/ZWhjiI90Wo4LLdOSU4B94hrMxpXgcfjzEzZ/p/N8nXQSpR6Ijwy5A+/AVBk?=
 =?us-ascii?Q?xvgSCfuKe22NA0vPccsOjdav4bsslta0pfqlpGOMifVYHYpx9ZairN/+MtZy?=
 =?us-ascii?Q?Y9F+3NAKiQptHI4KAM1/uKQdUNXTfcedwf3XFiApRZIKVsxbBD6xmt7qipv3?=
 =?us-ascii?Q?foXtLyK90hqZqeu9rsZjLP8vl6H8YwGIsleuhLx+qGLa0wy5rGbF3dmz2ZQy?=
 =?us-ascii?Q?DT0EFG6E4k1uljVzOn5tZhWB0NHMpfLEvX75TTfxpNu6+1i6nvOBO18ZysDK?=
 =?us-ascii?Q?GkTZMz6YBThs6A2lIV/EjeTZkpOQdui6ePjPf9V66ranrT7ABf7BMopDon29?=
 =?us-ascii?Q?UYg4uO9yX2CcFBrrEwHsDIwRobFqW3/jIf3tYFJStFYqo9zLCWXweYZjxYUm?=
 =?us-ascii?Q?MIp8FlUbmUCA+W1HXilyYB0a7TnGZjj8Dd0aqTQuJuwEYSiFBEU6nrQ5eGSC?=
 =?us-ascii?Q?bmC4QFBVoUr6BfB96WKvTt8zUi9SX95Upa1Q+Lfa2n/duhzsG6+94B3VW2TF?=
 =?us-ascii?Q?2BRAI7iKOU9IlUj1C2HZ0DuEeWiEIUxxZCgFSMQ4kdNj97w15YVfeuCzhF2i?=
 =?us-ascii?Q?mVJqapJMt5K4uj876S9eWBePn/mnax757kiI65FrSke63TwVMrFYeeDBvlkE?=
 =?us-ascii?Q?3AOiMFj79YE7E/uGMWYc168vKqaV3o3GAtHx7CljzueOLpCJr85nupNPOzIm?=
 =?us-ascii?Q?VTMfRSs+aMNi4wN+04hta58nLrx8gZ1TTfeDMt4Skvm6OKIgjLoNES5OPcGo?=
 =?us-ascii?Q?aGHAXHZaKp/3F1EGlvk15q+bgcOmq6eGnchxtvXRxTjDqCatjoTIUnA77qdj?=
 =?us-ascii?Q?5zI3T77WnGUBmE/jqUWDwPcUGGQoiqmS9WD2XAyQ8Xe8bSA1Lo6uuB4cPWZd?=
 =?us-ascii?Q?xw4ppUMwN4iPe0yK8za6S2QjlOvFAVkA2MCqliQtRp74sfVqhQy3D5AZR+Y9?=
 =?us-ascii?Q?AtIEd0YOGG7Gf0gKERTyi9Rt+WK+ycBJQLaBN0Nljy9R2V2DyFr22vCwrxPp?=
 =?us-ascii?Q?VCuBIFRLkMV8NwHI866SV0LoSAbphwGx2DZ7sTYSHupmSpSPjIBdZo2ygbeR?=
 =?us-ascii?Q?Ks9A7+dQznAPvXyKhSUpxdUEvItRFXaSddLtFuW02TWpqaT+d/T9gohNd0sS?=
 =?us-ascii?Q?d0IOXTtJWr4qfcjiwHlkql4gYPEAE1CseFV6Cer8zid1COnQcs9IddZQS79d?=
 =?us-ascii?Q?W4n8O/wG13LviaF8/kxezS2eBa/pRZGxGqawWNbLDBR+FjR1VUi9tcjvbH1q?=
 =?us-ascii?Q?KxlxRYLN5chhNmLTe12JykURlIc4v7Gj6/D5+17NPf6uBO5hswqbsk9Rh+c+?=
 =?us-ascii?Q?Z5UeYocUdhtxWc4ZrNYxLXFX6zJ+CpUBiqQakkgd0RNaVi6bViNuKa0IwWMd?=
 =?us-ascii?Q?Hjew5Vtr5Oc8QjbeexU07+P9fVdo+sMVO4shNMW5fIrEeppLJrkWKRpPQHUg?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1921c4d8-c43d-4bfe-ef6b-08de0c8a272b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:03.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onXZEDxqAzWWUH9V/t788ANWdT6Ymql6xjmL53F6sXxDrjOtYDPbE/C6/meSYF1OSZCgNbFnK3FQmxMvhH3O7KHbX7uf5en4tU74Xl1/MAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

Add the compatible strings for supporting the generic
cpufreq driver on the StarFive JH7110S SoC.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index cd1816a12bb9..dc11b62399ad 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initconst = {
 	{ .compatible = "st-ericsson,u9540", },
 
 	{ .compatible = "starfive,jh7110", },
+	{ .compatible = "starfive,jh7110s", },
 
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap4", },
-- 
2.43.2


