Return-Path: <linux-kernel+bounces-811200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE2B525CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214587B4065
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F11F237A;
	Thu, 11 Sep 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZH2WqU8l"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D04315E;
	Thu, 11 Sep 2025 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554670; cv=fail; b=j+RlMvzkLfAD5o4l3GjDzxAAA79jAZ591BEX8oiaVFRjcu7qxEd8rgix6ji87cIruy6W/+i3If8dGOVoYw5DGRGpoaHBMRituuOvTcuu2yGFYA8GxbsqZD78hdfn028FDXNVrm3P0jxoYvqVuW8z0UOCM/E/hfTLiiUvVx4Z8Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554670; c=relaxed/simple;
	bh=gpnDUQdfDhAd6hRDLFPRxA7742kGfOmaO5Y8HexJqsI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f6dNFTfiCX3fkY5MFZuUCup0jHQ/57nRawNfsErIdLBGaywA3toRzXyFlbeex3jyaT0epI0EetvDCg/TNOkQmjH35VNS5h1fv20+sVXoT5SbMMXsf6T9dUFdiGmUJiz7LFm+JwpZgfEMkRNM6nvPIP/xVTs6P66w8ulRIfdrh8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZH2WqU8l; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSEkBc32klpNasNC+gqPR2l1sZX4+1VtupdTIRjTm3yjDuyhqNjAXDuWdC7Y2BO6R9q0Ez9QIWiYagt7pUA6E7XaEXue3VhiEysdpj7ZauZ7xfoXhLYu9UV0HNNd3lSUyWreL/60BU/YesOCH9mGKp2GIYq68ALF1zHEujKMuwXmbFNznmcw123bwpMNCvaQBhMYwLswr0/zaLMHJyAuGVw3ANsokppQO93HGsd0X7NFQ5PU99ZvaMOl6aFh9+ME3SpWHynMMinuIPy6/5qLj7b5o9Ozn24a1zwuOxYnBY2kJFXC6C3KnJT6i57hUPaqbQgG3u/LnPmzHlXi+U+hwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt0t5ZQyPuJdTkwyAe+4GjpPsfTFTEdCgtGX6MAI+nA=;
 b=dvoQABRZ+BGSsULBZrp7AMRMdkKr7q0Oh/JBi/Mrn/D0yQr+YHrSqfnsI2VbA8n4c+RGH5gyzegqNSZZeNYRleyIKZBf/U/BUE04oa9MEiFpfAF8Q4bhccpr9EZKzedDJreZkmUPRcqTu28hR09UX5sJFXIyI2LDoHnA3Y/TUCSGEmHituE2Il1h1OzP0nVuxnCShmIHQ9Je3Pd4W6pr6/RG0lyNOqUuLJgH3GxnTbNwJpZIHORI1u5kTpDmyKzIvkNCK0qNRc2L3ABGZ0ItdMflVpzszxMmIqsdM46XXFW9ZPsBKCIzVSQXEETyfYmkV/e8H8jn+05XRcfpgD+Y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt0t5ZQyPuJdTkwyAe+4GjpPsfTFTEdCgtGX6MAI+nA=;
 b=ZH2WqU8lFA63AKr5g4YxAejje+P9+SidKqPd8C7AoxdobPbKMF/WNf0bl7zaC8CIsBt7rZj8SgGMwYHRwxxIuXSOLXvPdDo9ZraRYpY0rFhFppxqhUtr89Xr2fK/IzcWI5I1KNjJ61vZ29MJQDwo1gZmO7rU1UyOK/QykTzftTVKch+EQWqkbUYvObJgkYKFce7AeS5Q/ZUeRyYmmm5YGa5HLmPjEIw4Yg792wEjzvegYZVIa7mnJTHDv9g8EINmQax+OYKjtWKyRpAqj6FEru4HD+6WhZZcoq8Vub+vTcgyFY1GJxK6WtqvlcX+m/bJCJlY4FZX/7BWKebXuYTPtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by SA1PR03MB8083.namprd03.prod.outlook.com (2603:10b6:806:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:37:44 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:37:44 +0000
From: yankei.fong@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/4] Add 4-bit SPI bus width on target devices
Date: Thu, 11 Sep 2025 09:37:22 +0800
Message-Id: <cover.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 85bcf4d1-2547-43d0-8d1d-08ddf0d3cdec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+WTXhf3Dh0QClx618KXXtK3CZcodlAPsar+DE2rMx5vvX2BKnbb96rWNALT?=
 =?us-ascii?Q?Y7NCSGr04ZnToffJGQsRQzk7EOhOE9ePhgkWvmyqJDHKxoJQip7K6mkl6li1?=
 =?us-ascii?Q?O3pIMjviEyA96T5lnuvem2r4x543btI5MkIoCVFNWJ72DxC0oOhHULI5pFsU?=
 =?us-ascii?Q?ZU5uVNgvCdM9v0Iw327HATlz7ZpGadnj0z1+ZiIA4QKkpCi2YMFW4/HgExeG?=
 =?us-ascii?Q?7uuWkcldSYoU8KHYRC95z9QoBw8LZPrKtpifiGlPtrRnYvU4p3TaQK9ujh7O?=
 =?us-ascii?Q?urkG6/JJ0jQkiu/9sVYU8ofqGGptd0xUY13s4LshA7WACgeDsRgC/k+pSqvs?=
 =?us-ascii?Q?gGhOz4HoiJD1g6N480dmfYUPDyXmOBDlTfIdAT2IQvJz9hKhYa5BKiw6qY1h?=
 =?us-ascii?Q?Y3rF8WqgiHYX3PDuUhBFcRPr1GFjM7qjcvfmOzovO3Id7LoqUPgbAYez7Bdj?=
 =?us-ascii?Q?RnUcVJfF1cnQXLdl4J4ehlN5OS8BSZMjNwfVq/pdEgtEI93o9gSK5mTryGTa?=
 =?us-ascii?Q?qY+pzYmlvCopO6Spr5rOqOSFP5dQQUpUlndVv8AehucCZ8bXWbRoxmMnyqOO?=
 =?us-ascii?Q?3TCjkqiquKdmi3ovN4YN49dQLImaQCQn2u/mHElpMozxb+JDJFfG98+yxAaG?=
 =?us-ascii?Q?4QDtqZfi7nhOv1Kf2MAeeC6S6zk9CwCPNrDt5vkrE9C2iJs+QLyzoH5Vxw59?=
 =?us-ascii?Q?26oCTHzwKLENDe7R/nE5du/qkgWubgQEPLhp8+UMgxLmzllqLJeLBKBI+ECj?=
 =?us-ascii?Q?lukDZnXDj/66INOJ57/eFo7jBD9FTr56/YrAH3NEJLjf+aBD+YTlobe+3KcR?=
 =?us-ascii?Q?COuqEBwx2jM8tav4GmWwAx2epvTxg9kby/yX+tR5Xl8JGdr2ZlrjaGZHgv9F?=
 =?us-ascii?Q?YuUeo8q+7fU40FC1dtckPcrdBTWbSC/ecJbjEcjNCc3+0Uy++8REvD5FDH6G?=
 =?us-ascii?Q?Z4YEKzKmVuFRrRNIHux9GhfGQvRBQviyq/B1yktvzJj9SIimn/qpD0uMQujA?=
 =?us-ascii?Q?Znl5zBz3GcY1DSq+n1ybz1Z93qDX1RMfO707meK8FIZPmpKLwIhqgKE3ckmS?=
 =?us-ascii?Q?P2G6SVTGpBOOLIvcCdeXM1QBkOLDV9dF+KfVrYdEAkMtMdSwTRNxIe0qTeMV?=
 =?us-ascii?Q?e26pT/TKs1W4XsMF+DRN+DlsUNc9E+KDfLxR4vUl7Pu7tInIdjaK+PfnmyAS?=
 =?us-ascii?Q?ozabXrMuWgSBb3xxwUE2sfL6JRAAXGIR1Vsgwvy4mCdHIfmHYuXPEKZ8Mrrc?=
 =?us-ascii?Q?8Nun3Me1sI88kYmx5B0hPOjwmjAWlVeoVyIultMwZgF4KCGsBQvZmXZ09mVV?=
 =?us-ascii?Q?pPWxjLRyKQTXHJ8N4Ga7rLDlL7VNr6khxahzrNzF5bWCFs/dK4gmFw6TteoT?=
 =?us-ascii?Q?hpRAbJRW4ArRf+hXSJ2UZ90NKZ4aXZxx4Jn3tYEdV06p4nPIkILMoRkZgxR6?=
 =?us-ascii?Q?x/NNhBQYnqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2KxzNkj2EZL1cGzJJyP+XrFT2EzNCD9QQTeFUmplqQ6aoGGiNE1TFvs5SiY?=
 =?us-ascii?Q?DXzL3RFwxFgaZvasc25Mv3q/F7xvA9HLcGAeyohzJjkiJQAajpY7Qp+Hs1y/?=
 =?us-ascii?Q?5LrGNhUGlsozYNEutAKVPYd1e9Fx0kOw4fXqYECXiFQRExRKZRNtyuAovKXD?=
 =?us-ascii?Q?8dBl+X/fxnwjXnW27a8KE49kQfrnbFM86ACOFbCguaeQht/iAjq2ABknCcUc?=
 =?us-ascii?Q?sBYRDMLW0z5a0kw6/Ocv6Xb7VmGmVbT7nssbeFftRRV6NRVYrFZrfTYgUzbT?=
 =?us-ascii?Q?R9BjOBA3kkWMiOqAdMHnhRmjryRHPBs9aSQkWXA7N3eoi+jWiwnMuhxxLrB6?=
 =?us-ascii?Q?urZUCxWfA9QD0Jww5AdY6LoDXoS9hZjzQRH9JwbYxYmnPrmndE185cTRGfqj?=
 =?us-ascii?Q?zBv6s7/FxiAR1HRJ0sphFZkxbEqL/HwVPXFG29pjOuJzsWUV+dlet8pkvXhu?=
 =?us-ascii?Q?2Nc2Y5Eb88eS8WaHHD77QBWMhnwChDVfEapSvC4zN3ZmnD/KVvAbKm51ACKB?=
 =?us-ascii?Q?V2FMOIUFskRfu4t8bGFMtaMI9sW7adi7eIgPE4tRmX1b5BQFo3oPstmTTojq?=
 =?us-ascii?Q?3aWtm17R6tQxGlokcxpwoKJVEA40TT0kvwrO8VdxOkkqCw7H4uPep5gQxg/g?=
 =?us-ascii?Q?xCC5B0r7vp7JQavt/IyJDEPSoa5GqB0wWWikL9KcbqedrV0/tFJE+wudfZwv?=
 =?us-ascii?Q?SEh1NZIvh4NT3fSEFN82efNvwqPtKfSLt0jhYYIzO4E0NjzxcJa0sa8ewXBm?=
 =?us-ascii?Q?D8WjTqhegzciLbb8llRIddPqF4SZ+2yEy/Kf4rbfZk1c1qcOe6Nm2oI/S6gt?=
 =?us-ascii?Q?YI4G0ZupAdobELKF8hDwEfmPBD6m3Kw2ynYO4olGTYyCvKmwEIxDCFOwKt+t?=
 =?us-ascii?Q?1MCGe95/IxoGe09mYG4+BdQqIgrYfyjW3qqeSHzr5R0U3cGjwGOjRaNpTxzB?=
 =?us-ascii?Q?rx/UiCvCard8Sivu0WzzDQIff3iXgzQhi1nMKZzA1q5genrncvg0fXmKfzGW?=
 =?us-ascii?Q?exjXRoZfpUEvit8sK10YhGJRZgFiCTyjXaeOylL1w0p3PIVy0Xi9QzKiB808?=
 =?us-ascii?Q?rElgjdYTnJSVQLMVmoG2NIF1qePBBGI5kXp91NoB/kX+AWx3UAipyMmh2i4p?=
 =?us-ascii?Q?wIQ/yiHSmOctN1JSRlNo+mgCKaXFV/ANA8hbIIa5w39aLieXLfMZmZWht7ET?=
 =?us-ascii?Q?on5qXDvfuUJqKS53GXuNumY+/eycj09QwwB3SVx7Qse2OhPjfP2SrUJHcakq?=
 =?us-ascii?Q?lYSRHV5z6j/+rJ7b1UEcd+Q7xGtTha3zQqyrRrFS6uD6cn4z3OkJePitwKlE?=
 =?us-ascii?Q?1NZ6B3UjTyPyCjdVB5CaBUtCC/t9t4ftvPnPJclftYCbgpRB9FCzxZNiFkyT?=
 =?us-ascii?Q?EOrxPFnBBLkuSoO9a61WTTK721PBfoZ4PKDOwS6nvl8AwESiaDTNoR5inQjb?=
 =?us-ascii?Q?2gZevomWhq5mfF6hzWpRbjXRRHaGlbn0tUC13xGyFK73cszJlF4gp/agzHkJ?=
 =?us-ascii?Q?XvLgvBCw7wX18PKlM7831jRRfgUhkwg+d4uLt19ipzGfN4Txi6PgUy9eTLOM?=
 =?us-ascii?Q?0mx0HcZXnDwunYwP4Ju9sMc1u7G0V9/tFYueeg8x208CUUwP/26ikVxTMW6a?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bcf4d1-2547-43d0-8d1d-08ddf0d3cdec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:37:44.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCfWfzQvtgAWoWgS3SfY17N1wHWEeP4QOGy41SyKrNnzk1+r+Q6x0spIIi/JSk+5yHgko2VWHmodv51j3g0RVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8083

From: "Fong, Yan Kei" <yan.kei.fong@altera.com>

Add SPI bus width properties to correctly describe the hardware on the
following devices:
- Stratix10
- Agilex
- Agilex5
- N5X

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
changes in v2:
	- rewrite the commit message body to align with 80 characters.
	- add additional reviewer
---
Fong, Yan Kei (4):
  arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
  arm64: dts: socfpga: stratix10: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex: Add 4-bit SPI bus width
  arm64: dts: socfpga: agilex5: Add 4-bit SPI bus width

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts    | 2 ++
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 2 ++
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 2 ++
 4 files changed, 8 insertions(+)

-- 
2.25.1


