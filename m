Return-Path: <linux-kernel+bounces-885722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1BC33C54
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B8D4631C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D26242D6E;
	Wed,  5 Nov 2025 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mpmw9BDd"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171323504B;
	Wed,  5 Nov 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309700; cv=fail; b=SSFGJSr1YlxzYp//JNh2JQH//I97VXF0e43gnwudwD6eVYaiIJ+FHqRD2VvMdTdtYehZ3Wk6a+4L9SK2oSDD+04gCkB/YDIaRSoQURneSYnD2QaIWreZM9mNRVx8PzU0b5GT8UwHTx0yv48WvOagDchnj0bwnXMEl20WaI2rnPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309700; c=relaxed/simple;
	bh=gWTj9YE9irKCXNz8rZm85BkisP6SvvjvTbANfQOFAts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIF5oDgQTKKPvgVqieuQUIwC+sKUnlI6RZhSmRmjZn2RIM+OOaxUC91cKAkns/lTZt9KOA8ajSubIhVhtBts1czlrE6qiaTFZv+UB8GgIwaxWhdEHagIquBpwSL8PKNZFepg8NM1E3tDcI/PycNSks6JIv4G/vaTDoThdYJdxHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mpmw9BDd; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XA7wBAy3U7/vhmhAGqiRPnhNTiO+NYdlqpTa2vq7/JlfvqwuJzyT5jvzLCyzlUa4jUBdf55X4Um1EifxIBHk6Txdg61q3FdZj449LRYZIJIfJQu41zJZGAvEnwXb/au8eVGqRWTBEwiWfFxds7ha+M1LfLa63OoF8UgAR3U1ZyrPU4Sp5NYFPnKuT8svYqXMjur48J1W4l9/0sOY0Odovk9OqIQzCtaaGsXeff6mnCRTnrOysCPshQPD7WscDZm9rK+2b4lOgfLXrk9lklevZN0BU7PkXWbEMZ9RxAArZWTuZ4lR+0ALTYQ6x41sLslxWknJMqERQmTqAUXRBMwx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH2UHyvXUcgeDfAYZWPQHJaQJ3YvINd3keccdh0bRj0=;
 b=A1NtauWhGMRdiDXktpA1Br+USdMZnOnI2bYS1KLabmhwdbWYdBTpGbeUJMmYDJM/M9s4fVYHPDdTHYiTcgPlgXcbjIgFHlQuoBtheB+d97RbT0/Ep7NR4Ro4IlET/BLOLyPYgAPGYDCcTgqA/ZeCuj2i1Srcfsir0uIir9H74W3rixyO8A+7AcwSpdL9kt3+9UhADFCa6A2gr6qHd5obU6Dv7djqT/L6mF3JfJE1h0fkzckRYmC+gN27PAgmBXm+BXvaaPI1sprjANmBpqNDh7XolG3Bf34GlqO0bs4cXza2qd39zhuOlFhFzJzp2bnyDLO/rncF9BE1D1z21o2dBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH2UHyvXUcgeDfAYZWPQHJaQJ3YvINd3keccdh0bRj0=;
 b=mpmw9BDd5KA68SOVJZTJdCeJtN1lSNkxmH4GBJdHJCwF4E6egoWgpniYccX9LiBIoM6JunULHNohskNOYqQi6Iot2aSXZSxfDTmGaUbLL1FgPruPILSUNsK4Ho2z4IjXrPHo9hti1mjBeFMhz/n1QVS44dEFb4OLfr27ExQemwd1pZ3lzjVt+QySHYAU5GdYG08dMzDLWzQLM1pNTWidn2zvFK0sRV0qXBLLPsDgnyfMvsO2wyrNaiNypZwqNWmKHIZyQCNJs+Jb72tWOwIhslxgtWu4B5yTGZOfg/bV89rt0t2h4bDLYDYRrS1D82bmFmSM6QuXWB1aM/HL770dJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7997.namprd03.prod.outlook.com (2603:10b6:806:42b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 02:28:16 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 02:28:16 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v5 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Wed,  5 Nov 2025 10:28:02 +0800
Message-ID: <bfd2d5999306c019dab8a157f122bf842a43fc6b.1762308672.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762308672.git.khairul.anuar.romli@altera.com>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA6PR03MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f84f874-0f04-4dbd-2f03-08de1c12fa08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7M8ApK5PFHWHWq866QNNagdGbMAiY0ALBw1urqPlc+I7l2LEYJJQW4zaQV0?=
 =?us-ascii?Q?2O2PnEJrHEXzA0F/H34oxJwJt5arzKpw0CRFn2EZfW0h2wk+c7aOiT4l7Ko1?=
 =?us-ascii?Q?YVANhN2syUBVW6fKdxY/UmDbLwSTlJ4eRy5WgZuxWJ+VhqCRM/ajQMiS6bC6?=
 =?us-ascii?Q?J9GnxlTl5+n+ieN8v3Kx91rh3eahqHEzX4DAuQ3q1ze23r2uryj/umCUbukT?=
 =?us-ascii?Q?SIl1yDrHvcDB8zADKcYKLSRoRhd1+ndWXMSbIWHk8hrQdqQEUm8ADAXaxkF7?=
 =?us-ascii?Q?Bm6SrnMS8ZnfhLBb1bxgj235QkpoNpjY8qAS68C6dPTi7N19iGFc81xCFShp?=
 =?us-ascii?Q?8qMSsTUux3LhxFgaEJaMzYOqQA9u99faK4uczVF0ezvO2WdmE96IimjEP4QU?=
 =?us-ascii?Q?tA8PEdObvIMs9pSO80RrRuCbEtTgbWXSXc0YdKdd7Oo8w8lm3Gff14ni6Myk?=
 =?us-ascii?Q?73/IUUSp5zdPZ7+egVWsopESkmIH5FV1CyJG3IfRBCoKftpJSoyTdnOvbONa?=
 =?us-ascii?Q?mlYGtpjA7hBKqbErnLPhcts0Z1AvZdl0LjCqDcbXT0jpKzpH+9wWhY0W6gjq?=
 =?us-ascii?Q?qdPNVZlzaShN8ds+Q/EqSIREZ0Dr91J/R7zOHtMygXGHpweXhqOcOl4TEPpT?=
 =?us-ascii?Q?xspEVYBxWYxk248tcJlwXOlFfKTk262YDeSf4LfepBu/M9jRngiFhc39UBvW?=
 =?us-ascii?Q?GL4gb7sa/Xy7Q25y+9elTvWokzquKaZGlJnkMZHP9Xaj205QGChF9+ikUHL/?=
 =?us-ascii?Q?BEimRwZrR+C8k5dxRhB01emf+bgg6nkBEQB9iXMuSpJLwHiHhaKQQRnXV2rK?=
 =?us-ascii?Q?nGu8RliydToP/Gv2adjT5+Xb8s9Rpda6mImpDEqZuxy51367+qj4aGBBFAhs?=
 =?us-ascii?Q?+kCIkyDykS/M3c3V45GerNuqPLGGJx2t2Z5DsJsrH7VZmEFtumg5nt+6qBre?=
 =?us-ascii?Q?lvtORepepjx7/gnwP8Ky/l4Yvs95aC1oKHQakejp9+ZX49KeKB9UU/NOd4aS?=
 =?us-ascii?Q?/dMkv24amh9vzas8NL4wAuHuNbK+bdqb+ynUkvzEaGp3L4rNMis1xaG6WwKF?=
 =?us-ascii?Q?DGeVwSJu3cHGaIe3Wng1yya4fvFRGxW5EkyzPqKe72JKZe/OfR7zv9JJLMYw?=
 =?us-ascii?Q?+T2yag1IeecIer3JfK4hIjbBGiuHZuU3WvBYHpoxdRIrXK3AMrrUHHmnYUIf?=
 =?us-ascii?Q?xgMyCL9yb9EpyQ0kUTjacbm8tSfhxOxHz7aZqsKXPdZXjzG1ubjeNz6YMCiR?=
 =?us-ascii?Q?6bB5B8oa+ppNsCZsRALY+Zfq8aUw/ccT/nl5GHPA/YfZXXRbQOyyDlUnG0Aa?=
 =?us-ascii?Q?OkkVF2L34th0mDz58NK4Nmb1qu1340nf9zSviwIYYovo+QPTyPbyd0UC4jRj?=
 =?us-ascii?Q?f7OC8ml3KXXK9hnjfbSLYgBi/I2ZSEPU8afnwbmyRQHhJvxbVIJvWQbS3nZK?=
 =?us-ascii?Q?kw8BQ8fTEDoK920OMvKJgs+Nj8XrVHo0QE7REw2LloLbk7/hdZeWP6CCes0h?=
 =?us-ascii?Q?p2i+h0IHSi2kLXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTOcApQpEu18VtgLgpEQJ5ynaBVQZsEFkArY0DZPD0Z3SAh/uhJgS5dvkj4E?=
 =?us-ascii?Q?MtJ3TK9CHUZJVG+17adi40PYJyEVvjkNJ5PoHZncGaeRjro1CLPFgCATBwKB?=
 =?us-ascii?Q?2Gha978H85sOkRLbyetQqlt3m+1RWHDXNT8aw3eFLel9/cvJgtjWxsoy4Xhw?=
 =?us-ascii?Q?wNCkPuid3QCK1GAJgg606skDuMZr2Rgpqtp0G8O7UAcuWQfZCLMhwAL/69cb?=
 =?us-ascii?Q?hwMkmQO9jZeU42W7FTke9bV5fJJjRKEnwHD11tGMBO7A8lgsuoyfSZ0sivWA?=
 =?us-ascii?Q?c2KY4FgnToYHhpdi2wGy82vfN6FeEAQrMITUvpLjgonxaCbxJMbU18EBy7c/?=
 =?us-ascii?Q?sHgGkRFE6wNx6Q+SqItu77mVZm+d8cow5aHbFJJMKerueaXCALJ8JvM/uGaS?=
 =?us-ascii?Q?j+nBg2x5KeABy8GvtpJ1iBTiW+KRRfsrS133H9ciKal6JaTVZHjsQ8zQLgfO?=
 =?us-ascii?Q?lif1/HELlDGFzg9nDoTy0rc9mwRG3YDYlgTOvSrefrrN2D+n67uki+w+Dd4l?=
 =?us-ascii?Q?LCAlMnvMOCly6dMa/kcJO93PWbGCmZDu+KEpxB5ih+aDibyv8ezgb3YRHPC/?=
 =?us-ascii?Q?JF5L0iJT0xLxJhjTFjNQUFoCPhwaqJcFVEbDda2XQn6YOAazyJZN5ofxlD96?=
 =?us-ascii?Q?PTdcQxGFwB0PaD3rCUGJM9JL3Db0HMpkGIANzrE9p2dqvfLENiqVkFSnHLMu?=
 =?us-ascii?Q?S7rHzC/jKHu2rqCAK+8BeTwS3f7vtj9Pt/SPwCMiMEZQlc9mcuuA7dLlK9qC?=
 =?us-ascii?Q?TwsB5Q6/E/fOuuVt0Lgch1b/s4C+1QVmchHHHAE6618K79oQr/dFJihpyGNL?=
 =?us-ascii?Q?0SnNZhei75w3C1SpLxC8Syr/8G2pIoGmXBnWc9ce2lQAcAOD3WtS3pWKxDd4?=
 =?us-ascii?Q?e5VMPZYCHZNrChiTG5rJ/OWolGFaWehAEkfuWm0+MQi5sPFxcMkMhMsS2ycl?=
 =?us-ascii?Q?79RqgxuVzWjCLpK2TQO1VqeXFuyROwuKeU4Tgn9PNbq5HubOYMnjPLsycRhz?=
 =?us-ascii?Q?EJiWi/LIhElxSU8VCh4oMfHmUzB6vTDG/KQpTVR8pBbo8DXX1AqCA9RGy5iV?=
 =?us-ascii?Q?lSZKHjFenZLgPHqUTj0DO59yxthg54G4X1EJWFYhUEFgu2eGPf758cto1sek?=
 =?us-ascii?Q?46XUBuCAroqksb66utaA3pWTGlt+l5L/YAI8F9m3s0KfxapHEHVwoChv3L7+?=
 =?us-ascii?Q?EUD0FfxJWPVIzs3RUFtikJNUVGMsNdqwJVoy4zboefEAr8n7BBUHeWC6pgXL?=
 =?us-ascii?Q?V8vRLDibkmR5TYkN0LzbSW4T6wj849D06v2XK6w7QFngT0ChJaObfkVqkmGd?=
 =?us-ascii?Q?6pT2IRm7p98El0EThCw/ph08Jc1M2N+XQfF/u3i+tkC2BGev3Nbp+xdAjzm5?=
 =?us-ascii?Q?aow45XKZs3QxoA7DB48PCmbZBHMVwkcBz7oDygTBv1eKotSw4aCGnnEpppUm?=
 =?us-ascii?Q?SahBPRoL9rlPM9/oW4DJuKVEFj+q+uOOVYhuchwVNHW9Gwpd6zKUHB9R9Y/f?=
 =?us-ascii?Q?tCh3pUPIO5TZ+DftbIT1nIWUdQGbtSjIytAUJ70MMmey393B6OvL0qDtP5MR?=
 =?us-ascii?Q?0PCmxsVATaefXGOIRb9dSP6Qs/cInQztvQr1bkAmKRYFSv2iDb4h+4ZwE267?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f84f874-0f04-4dbd-2f03-08de1c12fa08
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:28:16.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6al99VT8ARtfTWR1NpMYP7Sg6y7yAxA6O65UrzgI5JofxHQ348c5W+0792JnhLRoYreGk515IAFRfNAV8HzmS3PuduobyFEGMCMYWG1B/7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7997

Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
node includes the compatible string "intel,agilex5-svc" and references a
reserved memory region used for communication with the Secure Device
Manager (SDM).

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations, particularly with the addition of
IOMMU support. Unlike earlier platforms, Agilex5 enables the use of the
Translation Buffer Unit (TBU) in non-secure mode, allowing Linux to access
it through the IOMMU framework. This commit updates the device tree
structure to support Agilex5-specific handling of the SVC interface,
including the necessary bindings for IOMMU integration.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- No change.
Changes in v4:
	- Exclude peers reviewers in the sign off.
Changes in v3:
	- include iommu property in svc node.
	- Rephrase git commit message to describe iommu presence
	  in Agilex5
Changes in v2:
	- Rephrase commit message to exclude mentioning iommu
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a13ccee3c4c3..15284092897e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -841,5 +841,14 @@ queue7 {
 				};
 			};
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,agilex5-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+				iommus = <&smmu 10>;
+			};
+		};
 	};
 };
-- 
2.43.7


