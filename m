Return-Path: <linux-kernel+bounces-811225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B99B52633
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93674668DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B723BD02;
	Thu, 11 Sep 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="svZnGp4k"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B32AE97;
	Thu, 11 Sep 2025 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555910; cv=fail; b=ayf4K+Tb/QKyl67aRKq58JBpIMxK6rYmSdgozlVRiVRqqdRKziWtehN77gmFchk4Dcp2mm2/qOy7ZpPUkPFOnoUZ41pJVbWOUXakP4IRTAHcIXyiMmwC1mOk+CEidaB5aQvxrW+4jmMRVmiNZCHi35p91/wq843GhH/ycgVd4o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555910; c=relaxed/simple;
	bh=4jU4CihW8JRXyVPipv9yHv7QKEt6MYFAYlAIzaVANcg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vq6njic7IcXoHk7tymvvwm55q+hKnx0NVBF4YnvUiguzdv5cslU9vimnWpNd/J5kDdwEhshuSgqz8dmiGdeoTx9dSaxxzAvgPPTdEDJEq6o+25HUNyQ+tKpnuxQpCN3wPbMmNosHhGm93QDOd6avDJvAjHfGoYtLf0CUmQXA9kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=svZnGp4k; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FN03yY+Moow5ngpo4Iv+D1H6gQQqYuZj7csD7qTzNss9vFNt5TMmkhTKJXvJYas2JehFuOUaobZ2TopI1pulxKr417NaMsQlLqn6nCnEjMw7aM4ZS+I8FEeb77vY8S3/kmWlHFGrHBJ81a0a9vdZGFXQIoeopGlFtNPA9z/O/80LGYXz2EZyMSsoTrY3luBc+BvCqZdDEOMlBg1rPKfzk7UTK2o4jA37PwLTlxOCQTOfZtIUICqpfklkppHQ44rfWg3RVF2rCZcg8elpwmomQVq7Lwu45At7r2cSnWhavDEIIdN95nAD6M815kKq0Mw+Vy4tyi4asO3P7AH+mMSlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLtnGoTM0ls5mCW11xtDMHFRCdHEMpsEr4X+r2A/JyM=;
 b=B9zOvfzX6BsEWHpKbO328k65+wqSopqvTReIWzVeGNtDghz6vjpyCgxvD4ZQpBlN78nyDHUQIbNgwNU39UmmZ88m7StCkDflJr2FJ3N+tDhE/og/F5DGv1qmTFPMu9LA5ChWvEo4bQjndgd4gUVvocMMslmSZw+P9Xb6vrLXpsggLvkM/CKMFYyBaSVTSGva8iRXVpQB32gdythCq44Jp/9RxEEVWmXZxAnn+q7YDOkMnLEKKqc79xaG0pdCdO3Ygk0APy+YIRFAy3nM/ZExys0Z1SbK+lFNs1a9SutMRFtIkdFMoI1QTqoBFh8Nufk3t1QHb8TL5EK3iSHvUO8KPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLtnGoTM0ls5mCW11xtDMHFRCdHEMpsEr4X+r2A/JyM=;
 b=svZnGp4kuW9qWJwCXSotyALvqJx2TQRvd5QcFprSvgkTdxFs157jU6P+f62ngmI1RvLHIljKOsRtpGV9TNeePdqdjIgTNofUa3ESFNbNITHyj4FH22W1Am9gS6PWXoul8I1iAp0zeiAvZQWzva0J8Gpk2WYyCD58yQ4n0xkKrCdNSqPaQrnQ8kJBp+iB3wNjLbH1+1Js1VLbIjtxIWlw2aWOQxg+yhpzGG4UiatRJBUTMNjYyte3k2zopZgGuGnKGyr42Cum1O3WN5r1kh4ofZHELXiGRgvA0ZBMi595tKyY1XwIh8klF+v7BYAx0lQLbIT/jNyZFSJrf9FdOn9uwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:58:20 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:58:20 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 1/4] arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:58:09 +0800
Message-Id: <379e68a1f2ef4f691507e66af21557c9375e897d.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|PH0PR03MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: d344c4a1-8c3b-4dd8-d1d0-08ddf0d6aeeb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zfnf8+eGVKWnYZH4hAG810DVm8yTI5JwDnqJAYnqd2Wvsw3129ZRMOuWAySN?=
 =?us-ascii?Q?XLvgTtHAdPJ9SVGZAas9soRihX71GB3FrlTYawUY72UiQVWZsns6bzwHd3as?=
 =?us-ascii?Q?ESEO5TtBMWcyLlRkSMFGPd4S5EI7MvA7nzzihiJR5vwbbsnYtfh+/6QQ3V9z?=
 =?us-ascii?Q?5+XKHHB4s61xs1wEVMlgFbUBVhub54raOdKoBu52yJ+dvGgN/v+IA2cLaYVs?=
 =?us-ascii?Q?4ztqt2WRzgk4TFdzE+5Tak7TowmuxJtalDVjd14FBWy+7i+Yc9W8UeotjqO1?=
 =?us-ascii?Q?jFyErNmyD/mxw1m8xAyWmD9UAaSj8C2Uxg2/iO9XyQ6sA4+cPSyJGcTbENux?=
 =?us-ascii?Q?0U2SlN2y4hMTOlZ9P3YmFNHc/jll+82nRmS9m4GFQVAY1heEa/66qjlarohi?=
 =?us-ascii?Q?hKRyNktFVmimoxPHQSqBsSuIk//J1ZyHAKsgUPNzZQY1P5bSjh7X8oyeFXQg?=
 =?us-ascii?Q?O0/QSpXZUHiDTUrlq6dwP9f3mUHzdY3DhZXLGqHq0/bSzYHOj+BpYTdKGkCf?=
 =?us-ascii?Q?Xh6FfoeuJb2DZUqrsKbQEq2hrDpwnUxxNf6WW+4tPO2S/0MD3IDOTzppWczB?=
 =?us-ascii?Q?UwIGaHHIIO+aUxFWxMWkca7Dhm6C6r+whDbpGDUI3aXidAN1k2F4LDEwSYmB?=
 =?us-ascii?Q?yN2UwRWYPN0hlxM0LO/4L/CRsguv7j0OB+OhRqdSTKZz3YKvJtnMPRzzOHaf?=
 =?us-ascii?Q?eKfR/PltcT2Ioj8O6vBNHx8Sru2D3HUkyNHXgyZjXCN9THO4CGHQ+31Qug//?=
 =?us-ascii?Q?6VYvhh3DvYn4HLF+6dI2HbF3YmVi3yU1i9CDjPULPSqf9w9dYnjT0OxXMB1R?=
 =?us-ascii?Q?oVjIPZ48NQpdGrdPlbN4gZ/r4dfR0l/ebrsBXPm+h1VnFwZ/9P7G1QTzHxU5?=
 =?us-ascii?Q?eBms1MfGj2y79sylsI7xZKXqOaWFw7FCq7/PFbhNPoZQa+OGKopzsWcFtN/w?=
 =?us-ascii?Q?LBKFtJsXOCmvQ56TJ9tFjcgyYNLL5qGnkQOjVcC6RltlZURbIaG0XxcYbRoV?=
 =?us-ascii?Q?NdJd/xAK2r9JmEgQOibdNQJ1gq2h+Nnhx4pCxkFsweiFx/nEUtskS5KmGMMF?=
 =?us-ascii?Q?rUmmKUTlucowYLWBB+wDLNSiAR4SApqHEkQu/k8nZDYULeAyspQmXTenwBR0?=
 =?us-ascii?Q?5I9Fhb5hKY6usv5zF/DaTrWLcIomZeTH+I8HAJjSkfRSlDDz4WabjbFH72Ib?=
 =?us-ascii?Q?1b4Le4MfSwXIGh7kjv6UuazVzW2zwqj3qO2LCxWUWevKDwmM+hweiFA5F+oS?=
 =?us-ascii?Q?9eKZAcQ9DtGxi59AA+UnKrWhRtDZYTMb9YHTUgexQTGGf3ftrsQTsc813sN6?=
 =?us-ascii?Q?DYtmqnGHmByM9oWzwkwlXHhybXEv45TjocCH0sz5v/Fhjv/JzjYiD0TVnWJG?=
 =?us-ascii?Q?VQNJTIjBxSIm5PfotTsiJaKVtTudvngCzr8d3kq3MxpbPSLdJpbYI1i6bhr0?=
 =?us-ascii?Q?Og+zYkm6fhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jxc1dHqXYzsD9NgHsNffEUdq1SAoX0AlEahy7FMCOxnV/9aLF324QzmStT3x?=
 =?us-ascii?Q?mXetmc/ujwjF2ShZAXVTVZeyYGgn0GXHZt2+FH5Fsu+MzJpoy8p6UncbapnC?=
 =?us-ascii?Q?j92DM5DUlh7e86qeu5d40tPHpIXSveaOn/yaY31jjdl6pSENcWvlEFL6SOoW?=
 =?us-ascii?Q?IzQQkIY8nAfPdOYx4pA2OkFl9SzFH2cjeyt3qYoXV/k69Zs5roT9vYB6kdks?=
 =?us-ascii?Q?lhZiCUC4k8erwH05VxcHgPjQBouIJ7GnSzvpC5aO8uuP577wwUTcdJeaKKeq?=
 =?us-ascii?Q?FAyXJ+MmowAJktKcA3Znvw6gcPeDEu3Fb8GSJvjK8jTWljJ1uJOKL41iiotd?=
 =?us-ascii?Q?WonLzi7HeWzsvWcI3apCVmRIwzrat2lDw9VszmlhuqKXRHffXF5AXiqGOFI/?=
 =?us-ascii?Q?h2V+KKy6vCk/CE0Qtz7xFtbDwHI5rkXzFFzK2I79rSJRf/bCqEIhzhLWxdyc?=
 =?us-ascii?Q?p3wyWV75DdbbJtx7gXN7ipsbq9wf6IYyyw5WUG4hfpU0Q7RxnW7Epy6dK6bf?=
 =?us-ascii?Q?j98g7ddqb+raCqZkj4bm1aTlmymzUwH8IRXw6eDvTfJ9VMNZP7J8Y3WC3Js5?=
 =?us-ascii?Q?m3WYTnEoe24Ruao6FWvx9eQsYdiUD8BqQIo7+rN11nos2gI1kGMsis4LdoFt?=
 =?us-ascii?Q?xDSHGmfLgyT/Mnh2hdjPbPv7Vex7WQyGPd1k1daAtJ+eVGVfivEHe0iudNOW?=
 =?us-ascii?Q?Szh2yPDxT9cZuTjDT9taRENwDum2mZH7Rf6N4jo8Je2val9Z2JJnoDW81rlf?=
 =?us-ascii?Q?73crV8GRgxZCmo4/m1p3mbx5TRzz3PlsQkTrCOPMrHLO4ATyXBhuvIyR3orK?=
 =?us-ascii?Q?dziVRHCQR7rhemHnV5Uk64winzAu2xCCOzNm/6ZA+WloEl8DzxWHepymHK9p?=
 =?us-ascii?Q?ztaGKPrrKeVWAb0yxkJ/ntdyXNV30rjPhoxCAUyL/pBzvdpLrNABOH9ifEMf?=
 =?us-ascii?Q?I+jPJnVHnoFKv0Det+YQG+IO7TOpUDVIletyVhqHswgdyCmoFFFcWp3TsbzG?=
 =?us-ascii?Q?tApfFjhguWgPgYqvxgtFGXZjsXo8wQ/1X1zLz9Y4bg9WN9sBwD9NEIb6SE+b?=
 =?us-ascii?Q?ccTM5JXfSe4crzbJ8A8kDS2dQzKReZy/R3asEfN8zzfI7/exsaWmQgfbRK6A?=
 =?us-ascii?Q?woLGHgS+POMJYnWEbLA+PgFHScXSgWFzgsl9lVmG7xODhAz1xb4R3gAoPkMx?=
 =?us-ascii?Q?eipMW/l/834IfcfWslplvW3nZ0aBxXsTyoOzmmNZCiGk+YfV3QwoQPJ/qMPa?=
 =?us-ascii?Q?8xi9APblkJJGEr7t7I13IVd0oHXp+JSs5+fYgB/2QrkYw3J8jjXmBuQzSq5X?=
 =?us-ascii?Q?DGVQzBFGKdnLq5DwH/RUCK9jv909yDA0z8V2EjLm0/wO86onFaI+lqJ7EdUv?=
 =?us-ascii?Q?xlirokals9vdgQiur3bZMYnXype4xLmTpJontFfGrJRn+hJ7AOuEaPsRv87a?=
 =?us-ascii?Q?PcM/QvKSU1Hvzp08+YBu0E76OHwfbhgHQHjuCA/nd9yW9HlVA8KN5XCxDxVc?=
 =?us-ascii?Q?bFFKhZzZp0g/LM3FTtXf0Cvk9QzEoKpKPMpw1IJiBKJ7H/lZtNfNG4fxaVN/?=
 =?us-ascii?Q?s2NVLMSrnqz/ZWD5Ql45aujaeSezhYrv2jZemyZUed0h3Yu5B/9/v8BJmmxk?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344c4a1-8c3b-4dd8-d1d0-08ddf0d6aeeb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:58:20.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kkj7XBHK1Z5tSobGGu9a6N8nx7kGBuqvWYvnHcrXw7Cly9I4kHhn9LlA0Np/v2rytppi7vU1FPD2c0XuDai0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the n5x 
device tree. This update configures the SPI controller to use a 4-bit bus width
for both transmission and reception, potentially improving SPI throughput and
matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index 7952c7f47cc2..0034a4897220 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -93,6 +93,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


