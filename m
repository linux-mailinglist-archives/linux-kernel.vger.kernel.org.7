Return-Path: <linux-kernel+bounces-811226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF838B52634
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA6466701
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE090241667;
	Thu, 11 Sep 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="h4lnyte7"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED21221FDD;
	Thu, 11 Sep 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555910; cv=fail; b=dMoiR0Ms0MB0fPQMNH3OkE3dFeA/O5M+RsjJTLXrZBm5i4M2Ok7K9mpkm+7DYxjMgBUPgQXSRQ7A7LDembJtPaoF4yH6b1Chl773hOen8P3hYlWdbsoRIWhBrDICE+TirijxfIE0CF/uYRwFB0jNrd5bKuvlAMkpO2equBBHgQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555910; c=relaxed/simple;
	bh=r03ffgJmfH4UPz8/z0STJbaR6Y3ITTbDVAfVjlEsMdo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l3FaJyck/dB6t4wyQfb8vRPVV6cYLmj8roqZeGr7nLw5T+gDf0vvi8r1JitBxg9d2qz+5eDZTt1ziKiwFyNC+b+pAZPJea1ZIgpU1byY9zsKMsT+U6kgz5adrwQLqASEn3HTxMvTP6P+r1U59unKuOt+3+/zKDqloWJ3mP+rJq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=h4lnyte7; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+MBItuf3wdcpBHLal18hBZr+p+e/5lCNAEG2No7OuAVwxjN0omtkdJ0OtQ8oPcnerH6RhYQNxNGz14Do8H0A5Sye9GdNC3MabyaypnAn3DhY1grgn/WO+Nv7c6BmM28rtY567VLQRdSOu8Kyx//lFqcI5ZIS03/T28vCLUaqVzc0a/nZ+/S2gJ2Pg/cLqbHaC1I20x0Pmu7/qzBr9cF2PkKp1vbBQnKXrVh9eLo7he9K8SdO3FNoovU6oeyTquqyHJoXoY/rXkcaH17q6Jsdr8xHXaRHj6srcVNlPb08ut57c+l8JP75hxpn99BYY9A2QYG+FStNEIjqoxlC6WXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcAqudSycRXMy7Ed02+ouLoc+H/FBGOPbmMNU/XgwDg=;
 b=pYBwKdOaCHgukzwvjJtGMESOCK1df29EscfdLAO8xkRdcVRU4jqtPFF5aNlVJ8zT8ietJOil6VQNf1quqMjGoAL28+eA6wmJEN3DhCmqbVOTS/qZ+9WF/hIqmsExZRmMDpqpJODpfhdUwA55UWWD2GN1/FdN72FeImYRaKMptBK34wRPNFI3W/NVEwLPqClraxIiIOxb9RhnVILh2BEtiw1czp0WZEegBEH9j6P56WUxjVk4hZ5tlgtputuIJ90ouufGd+5W+6C8zp+J48yzwigy0zvDf2FQgYxJoHFTvQ4vKwHdu0NT6bBxAXu6iFqncALF5JF/xEwY7Dy0sdG14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcAqudSycRXMy7Ed02+ouLoc+H/FBGOPbmMNU/XgwDg=;
 b=h4lnyte7lAqlVeRyUhMaJMzxnDaesAQzhrjOLAgCF/SHPTaYDbRTWye1wOpmn3+540b7iuA+tgxhyLafRC4hBDYih0Q8S9HMKiAklGNAtSaIgm0SDNBTT8h5IOn2o7bZPSg9M52cT5y9hXUnxHtg3CaYU/c15+7SyFw/8CRmxaUbL4czyAI26Kj0zn850DjfFgFCF+mDDyeHRuWz9OQlUbqgQxhuJnbU8K55zY6J+8MrfoGTTa+8K6f4/nSK3HNhbtft5CG1szxG51WP+ojQsphHQZMBpKv0x6jlRFX/ikHHiMIyIEIZShOw+JlWl5AyEm8NCW8E5uartgVLfwBeeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by MW4PR03MB6650.namprd03.prod.outlook.com (2603:10b6:303:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 01:58:27 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:58:27 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 3/4] arm64: dts: socfpga: agilex: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:58:11 +0800
Message-Id: <112410d51ee916590b974b07a0a3e082ac09aa68.1756881243.git.yan.kei.fong@altera.com>
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
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|MW4PR03MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee3850e-589e-4ebd-4dcc-08ddf0d6b2cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?97Slb8NHtK5iK89oysYdNSwvaIOplusqmsjur99fgtg/SlkNsk/vnvlHUNcQ?=
 =?us-ascii?Q?QRJn2Ys2iLwyQGZA30kK85WUAf933KclmyEdkPYRJYSQ0nj2bsSJbRVcNW0j?=
 =?us-ascii?Q?ty6eWFgoe3XNclBj1Je4C0A94Ktlc4f4aHWTFtVbI//NdgblrknOCqkClmil?=
 =?us-ascii?Q?AecJ/8dmU7bsyPdLcR8+tOVan+lqsKdP+GIyL2l3LFJzjBQIF+zY266RTIQG?=
 =?us-ascii?Q?RMt8U3UIVBTA1H8Sfvnf6YJ/nwtB+SfWqYAu2i/LG9v6QwtjsE6lmuveKo5q?=
 =?us-ascii?Q?UG/wT9FAn1WlHMBOJ1XyNAXC7XTMqjnY0DGj6f9iWdHmR7NrBiJe3MQSxx76?=
 =?us-ascii?Q?8jtReS0b+jHTINQ8Sm+QQPxvsr9ZAJGpxF1Vt2MQhZ/1G2vK+zynnDW2rS2b?=
 =?us-ascii?Q?1lU4ihvRLi+PbrzY0DFzsk7ghw50TBhyE146qqIPruJR4YOPftxDcBtKdEXU?=
 =?us-ascii?Q?u+V9R2v9PGWtLrH3nHhc+FllnN6W1js3ciuaHs15CD9RE181Po7rpHA55SuO?=
 =?us-ascii?Q?L3vN80aMW74rO16V9OsC4JD7DKu9IxtURgHPdYpYKNlhZx3wt+lPoQeiXATr?=
 =?us-ascii?Q?FIkR0NABx3Is1a2gcqodR2WubSWHbgOvcGt4B+aApKc2QPshWQ+6E9BtKEBm?=
 =?us-ascii?Q?XObTC0aLfKRVskz8KqzCacFx6dUsO3W8NLazEXAWVzY822DnBvCg7QAmsojy?=
 =?us-ascii?Q?9Ra6M+CfnNFtkYi1XqIPIkwlR/2MFZPxV6leSJ399I8JC1EQA4hVxg1ADzCj?=
 =?us-ascii?Q?ZyhLK/OEJyIQ7AvDWWB6jki/u3U/vUUpEf3uTGBAulrInlZC5waPu7VoapQx?=
 =?us-ascii?Q?3X8H3FULuPoy+GVs8rzAoVrfWq3AO5INJVakMrYYke1+WUFS1WLx9VEv+n3i?=
 =?us-ascii?Q?sZV4p5p7W4Mpgfj5DwC1QyDTsbnZQa7NhZMcu3q7bDMjd6/afo2vs/MSlkgT?=
 =?us-ascii?Q?ftpiMjnQvqGJkI0bOQQtvK7YU163q083qdXCcZUv6Y+7PaLxenGG1ssJVtSe?=
 =?us-ascii?Q?rPrD4jmtxH09RKvBuHNRw+gihJ7vm00HdO00pr+XxnUQcCPPfXEEX5wvEWq6?=
 =?us-ascii?Q?IVNEEHt1KlbH/k6h8yMfh4nkOH50Q/QYg7ZWu/DEFOC3s2bfl8XssSkVqxWH?=
 =?us-ascii?Q?Wp9ZB6qdrTH7XUifHCGDGK7+7ZMy0NpVWASiXVBiy8QcG0X6klIUzx24qfeg?=
 =?us-ascii?Q?FD2E20qZmSiJcN7fVQc3Eqt6pdFofnyT+gGOAm5gti/kGuI3R5JPcygYDfSW?=
 =?us-ascii?Q?2XX1VQ1SfXp2RR9igEfeREBXKDQISc6SYMRKuukaEkP7E23Ur0uPXkNdnXPA?=
 =?us-ascii?Q?j00Mz7boMzwg4WX68SsGCp5QCwm8SiEEZq6oSc+4VLqW/2+6F6VmDHjFHNd+?=
 =?us-ascii?Q?CmibX0cgUrI9EjHFOZpHP5fF7o9gEVCj2kkcvD7NSfh6JWONSP2d4RmkPvrr?=
 =?us-ascii?Q?ymucwaYcnWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhBSonIeCbV0v/Hco3JDq4da536vVOMQETwf+GYo9LRGfd9WyWzcPifPy3dl?=
 =?us-ascii?Q?PH9KyYObV1t0fiybDAiphc+40LNZ2EtHtEGCzeboo4OvdgncmTZrjAa2E5+z?=
 =?us-ascii?Q?f2BvPn/2bn9Ok4a6phkws738AdVuSogc4ZYfOd9Ghs1Zu1jCLGv7XBmjog3P?=
 =?us-ascii?Q?C55jQHwfQJK5uRPM0kSBP1LfekeGeKSBw6Vgz2zdFxFTP3pNq9VLCWa29zAl?=
 =?us-ascii?Q?Eptui1HWD5v0aMnUFaIFUMLF4xMNHNnRZRPNs/GqHxq1geUq/nx5sDH270ZX?=
 =?us-ascii?Q?UeTvK9T0F06ICr5T+WESyQ6ovUG72SvZ3p5WwNJ9yK/MgpAK41emXp8aB3gy?=
 =?us-ascii?Q?IpVtxLWc1KKDsJ+z6zZykShe5pexUvPbpX1uw/kSL//3hBCwByYJe8i9QSI/?=
 =?us-ascii?Q?TyKxi9P8hgMDmpqx7HCbSATZqkmDC2rgD0ddCYEYPWA713StBG9ANIDHmsjM?=
 =?us-ascii?Q?fGsG9F5Tp28iuenke5Xp5coZnszfut2cFpi8RtWRP6Cwanc+BTOaQZu7TIMv?=
 =?us-ascii?Q?7hfLX2eC/HFFHDN3AsL26q+vrVSZhUddtEOZV6nhMgQIma5rpnfAqdedsk7V?=
 =?us-ascii?Q?NvJi9Pnhqc9SPwGx8l6uqO/wX3gGCAPe5WvYY/7IQ3l6JxihQZgwZ/Sq5ZT6?=
 =?us-ascii?Q?6h9B8CYe33I5B9kq5xyCpozo147RVGtRcrBxENdHsU+xnYSG+TNIiwcS6ptH?=
 =?us-ascii?Q?/BzkzTLeYsJQOdoFATQVjo4ZbfLrVxx7BZRKIhouOaXeONbIQm43c2IwSW1p?=
 =?us-ascii?Q?uq5niHDkNleY+Xbg1aREZ4/HZxFuJ5qQjZiTbbY9LiaXOM4i/cVK4OeQmToz?=
 =?us-ascii?Q?qkqhonnHH6E7lux+4mzZSIi2byvEY1OYt5uFIeYvNyUfrN0+53znpxe7qGTG?=
 =?us-ascii?Q?z7X1qScfEYQ3ABAY9NBwZpKbT+BFIU8DJ5UPNGzOmTzs6OD3exV0linNqozh?=
 =?us-ascii?Q?Fw87M1ciQiU/iU4Es7ccYlOzAa2VFpMmp3omp5H7qUItNlyzSbYQTfAnaWVN?=
 =?us-ascii?Q?YvnHFpmuaylD6JCUJLHn8vKUZ7wuNvzuNQwduZg/5fyWXMZgW39JGoo7Vn4S?=
 =?us-ascii?Q?PvrFTljqhLIhvD3sTTYQp167pqGTL+jiRmVqZSsAUORaR4te0eQ0Y7PyviA/?=
 =?us-ascii?Q?yQfl884Pwcu9m0tMTuNeNq8oquLNVcHJNO+6Jj+pJxpgeEeiFODHhYbxP+44?=
 =?us-ascii?Q?R2kL0nLXNUZIdPPRryRgN2s1L9c9ycsy8qMR645hRdeh5qTbDF676Aki8RNB?=
 =?us-ascii?Q?VrOfO7gGoo8dL0Eu8hsCYv8Cq/gQNg3dkrsKSPDIu1CnwwtVydER57BfzeNJ?=
 =?us-ascii?Q?w1P50dWNrLvysLTVaE/vsltIjmdc4OeUnU9caFBabgWTnlIHHYNKlrktrXEW?=
 =?us-ascii?Q?SXL4/stEYAG9INyYlzK8wUVzVUfZxHzncvaLElX82yY9ksJWOwrUQAKTc8hz?=
 =?us-ascii?Q?3SGHPWZELuS0UTC9gi7syZLRyPx2szgHdiAsJ8Gdj8aKcSzMrLbTEiSSRQRm?=
 =?us-ascii?Q?m9jHS+yzKEEbWQc426HlGeus0IE7AvZlbynTXQEo//yktV0mojg0NneMjWQi?=
 =?us-ascii?Q?vTHqG76r3et5ZZGyeBqBgGanWHHhoyCn3p1EY/nTkgU4TBoenMGer1OBmezh?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee3850e-589e-4ebd-4dcc-08ddf0d6b2cf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:58:27.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /99oMWJ877KAYjcVnpQImueaXIZXGZjuDnrJ9nYwCqliDPMd0Ve2X1Bcf7VrX7jgKYeM6HCFnGidXXaoZlJOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6650

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the agilex
device tree. This update configures the SPI controller to use a 4-bit bus width
for both transmission and reception, potentially improving SPI throughput and
matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index b31cfa6b802d..9ee312bae8d2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -116,6 +116,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


