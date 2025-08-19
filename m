Return-Path: <linux-kernel+bounces-775798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94620B2C502
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230C81891ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FC33A038;
	Tue, 19 Aug 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L5kvTMGC"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012037.outbound.protection.outlook.com [40.107.75.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09F1DC075
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609227; cv=fail; b=X2vRJRv1tVYBaMIvotPpkcMBpNf3RHayFWv/ayOXGD+rXJfu7xgjbq8/mFnv+E8tPIe55KPHrpd1yimXOY16SFfXS0nuO4oAd8InH1hSAGwFrY9N8q8PRjdGjOh3NdVNXlwu6CORhNwTBiVT36EVOMqojPXXa8pTtsVnEDHoBfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609227; c=relaxed/simple;
	bh=Qj5yist7xCIX1uf07xHR3rHNZoA0mOU+4EtI0yfu+oI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NAgBer+JLViUpufORsA1yOduVDgbaBP+F0f2GA5P47XWBLXpnYvYeLmyyDHSkY8jctQkOci5tj1Cl0CL+gfAxZHhfIuhmgNmpiUqRO32725J14fcp+cKko0gtcE1a2tVEhkX5bnuIwSeN7mTg7YBboIUaHSscP462k/8k+OA7Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L5kvTMGC; arc=fail smtp.client-ip=40.107.75.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffc2N9u2ZOXZLggCxIckP0BKcQuw3sJ9f//ji0Rtv9eFryMh/PFc87jLlT7gQHvtoRCm4GUTkrn7qgR1/fls1jLdPxBygPlcEvsanIFY2uJtZ5JGQvwyI/6ov51adgNi8edh/JCfoFu1kny3gcie3GTKrlx4v/mbyf8QLeOLPtF9uHrSURKHBrOFEuBAjlMN6A540IiY5ar+rpIFGRsRX2JMyj780FPNPNPjwIl/qylUyeuefd0WF/eKR5+xN4fAE2DbeglyF1lfE8FUhJBRIYGRm+cSKWQgyduJWHujbuF+TaZjrDZ1lRsisic+S7eTpAMX745a0o4+i7GDwG46Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agDmren60eNDUjk68dlB+/8U9VRtkaeM/svZhN4BtFA=;
 b=kZRItSUFtZ4rX9lyDRXOGHTM5lJzL4S2NAzLADRW0BnPEg5bN6+e1NBH0ou1WB5RQ8Ii7P84DH91/3OzRyi8Yy0t3X7IVQ3LPOR2zk7KRBEpBvVmhfQX0oqSy27tEzZUFo8ystMUfeacdcMiYridxxSn9yEAEBFFx88N/SDl8K6U6ApPRAbO2h4Nixw7izwURv0j49oJDJXkQqFC7V8zVkMlxJg4ecLsJ9ebLFxLyazSgnlyuFqVG/7ikeHMXb0Emp4mj2LXO8qvNk6b2BzQMsi8a1KZi+ROwfO1j8X2jbZifMrQBjuqJL86Z8A+Q6h06768vnFc7yl36VvuXXZRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agDmren60eNDUjk68dlB+/8U9VRtkaeM/svZhN4BtFA=;
 b=L5kvTMGCJ+0SEZ2LFDalBENXppWTUK7X32Exzu4SitCG6pQQSmmZlrHkXf6QkAIRkTh30dCkEGkgcDm7oH4/qFWyceVropAnbZ4Mi2J+fW84zmsWvVAKIRb8IYHAIEALITjQDRABnH5iUNy4A2da4a7xxQJB5Lz7XghyqqUPEmtcvKV89/fg0R0/wVS8N2GOZ433/Nr4Uz6odwD1jMcHDfWqD+KjrhBR9NMjTXdtTHY0yaULAkYA0IgJHOyV2uAWYze+RvZhg6wsigkRav5+3IH0A207RNi202mfN0U3h5eDzBJHhLjJjGTDhFsKKYndGxvijQVhPxAlRywmFHZJcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KUZPR06MB8028.apcprd06.prod.outlook.com (2603:1096:d10:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:13:43 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:13:43 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Petr Mladek <pmladek@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alice Ryhl <aliceryhl@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] lib/vsprintf: remove redundant header files
Date: Tue, 19 Aug 2025 21:13:27 +0800
Message-Id: <20250819131330.153128-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KUZPR06MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ca564a-4182-4f81-61b1-08dddf22389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdkDhAF+yuxuMguBfQacnZ8WGyVSTroYg0uArJ9cz9HEXPfn4cx1c08CROmW?=
 =?us-ascii?Q?6aHAHxRv08SjsqxJJ0/GlDgcNxmVFjnUypwqx5e7jhLhsulJZ3QbI0Tvrt4P?=
 =?us-ascii?Q?VeMX1uXm/UaGX/G3SQ4YxhfGq0KVzS86zjMOLH6NKMYFAIshky5e3zGPKbrw?=
 =?us-ascii?Q?IJsi5j89/4XyZciOVWvMyLHObWrYsIF6YbwKWNqcHGdfZT5uXeutQ97wejGA?=
 =?us-ascii?Q?aL5YTGZXPG7c8NkagC+EU2UZsp7P3s2UZi1863qff9rymvsj+94S/GRvEo2A?=
 =?us-ascii?Q?fmdvOmpNQZ5k/UviGQtnsEzBOBdaG3ADM4slo0ISq504sdrUnIPlkJKUA4VA?=
 =?us-ascii?Q?IFKHY4FE2JwmYRNPqmD7FGHGFWwWMsLaVreHgTn/Ejxs7mcDibRQMuA5iRt3?=
 =?us-ascii?Q?8TU398gisxQsIjGD6SGV9xsF9olH4TPRvAKce1bvMKQ3r7ULQdDFLJZnl+iy?=
 =?us-ascii?Q?6IWLUdU0bwYkMsClxA5pyv1mPmnL+PNatvezyUNZRsh4QDD084De1eHpksHL?=
 =?us-ascii?Q?3tA0pJ/ln/H9S96lTNAN8n9YG8nvG0HS3v7CwvilOQ8QRKcUZ6/16Tv4QerA?=
 =?us-ascii?Q?y2vtA5evU57Z26d6DOA9cOofdzR//jWjk7lnk9lMWodvVAKwZthD9oyENxwi?=
 =?us-ascii?Q?xfmLAqkzlsscjnf6YOmEKiud56Sjq/XFXEfO44I15EdH+515H09mhttvdeLi?=
 =?us-ascii?Q?lozmMOdVf+VNId9woepROLHqFAtAwFQUvvdK3HJn8sZY1VJH9AEGItr6P+bG?=
 =?us-ascii?Q?VtTTsG7y56n9SFgxNWDILxI+t0DlcffvJbQVcuZSXUPrrZvap+qIQ8PO7+ZW?=
 =?us-ascii?Q?zAlPrzocJ4wJc98czVL79CDgZu9k3vEfvG1wSAs3qYq7ett/RA+0OYCPBLpG?=
 =?us-ascii?Q?SMOuPstpeLxRHyH+YcX9fFoLC48E/bCXWND6+9uOr4U8b5RNGkr+isLIYK8c?=
 =?us-ascii?Q?lDehqEfiLTVrrg3E6oSvAnZSfD1e6AZVMI5el8y9SxU4SLla10Y93eHmtvPM?=
 =?us-ascii?Q?uuVPMOgXNYJBoyd6Qwkg0/LHHFIr1SfungErJCF5A5Ni8eIEqh5Jaq+85NBn?=
 =?us-ascii?Q?H+8PkyWCJdCKbZnCjopuWz9IANPXw+UUKD2nV3jyGd3pvqVAvlFdNumD52f6?=
 =?us-ascii?Q?cumjNLh0AGAn5qkMwe5m5L6mj46XlZUWyVWKjsrj3sftQBwfATQzti3/mzJg?=
 =?us-ascii?Q?SY4aliVUA1fEEd9lpJ8wUMoadmRXmqzPG0zSHqC4zFe0lVoixh3M3wLgsUM9?=
 =?us-ascii?Q?xL/DXpSwvORFtyF60dCn2MKKtouHh1TNh/Xdfq12tPGNn2wm9bScF3VFppF/?=
 =?us-ascii?Q?0YimrkGdl1Z/XnlVMAvyuPSPH0X4OFlmNCMfMoGDVQRZV1LlFsgUN0Cs0jVb?=
 =?us-ascii?Q?9G9fQGzHcaJQ4fSJEKnfLLSnPDqNdRfY0P2PI9bnXzQGnfPXYsBc0J6LHtfO?=
 =?us-ascii?Q?UJuVqrvpc14/AmYI7pRAF+5+D1X4ndBT0VVJXKXO6jyJJoG0avEPFpmpBZ+s?=
 =?us-ascii?Q?ZLZOrQ8747lFur4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wroSTMTbncy+fAnllmBdA2N2jHtG4wG3QCRrhWYgl5fyTsflSCq4eNAMiUaj?=
 =?us-ascii?Q?kLvgX5InqgP06CR1TcDKb92szQ4GA7mVyej+MU7SvTbmhZRnKpwMYEwxJnid?=
 =?us-ascii?Q?WqJ8pmGjlCG1BleVFSjEYXXYwz9lJxSLikEa0i7bUFopLEgvdYAu9sSWQTFi?=
 =?us-ascii?Q?wJUNcth4QZZ2t8ABu+ha94LnB1VVKRXqUzs/akmViQHH3VIZOQHOIzUv43Mb?=
 =?us-ascii?Q?pAnSeTRBqHbdIU0xxzoEtFlTnhlZP/vYjxsgqiAhaxdc2IzQ7SD75RhfR5ox?=
 =?us-ascii?Q?/5KdwgEUidbakOZYDh3GVqPQpVM/mlAHwzL7JV0NppQ6ICnlnh6bLs1/Iv8N?=
 =?us-ascii?Q?TfLd1gX3CzpYNt4kkv0f1h080Lm9iJa5pJerbtSaNK1P73MrlGp+rueCwnNJ?=
 =?us-ascii?Q?Z8V7KNNXDorZokPo8E+IakbTiDYGx6t7QZE2tSvmAD7O48jS9uG4QkhtEJBA?=
 =?us-ascii?Q?48ThXFzxQpCODMKqgKx7LDizdz5H9H/JdQbOM4s0MNzqxRyI2HYdqvZZES/K?=
 =?us-ascii?Q?/FZA6yzMWMskfYFgupQ6I9k1/ExBzGR6iDvptqFTcxyXkxg4MRdkFNoWVDn3?=
 =?us-ascii?Q?T75LvUxkAs6HGl/30zR3yDvjsEXq4ajDWdu7BtyhmjtlE2F/MKIO7jtK5TEm?=
 =?us-ascii?Q?QSRKs6fdWi2HQy8GO69ID0glpAX+N58ZS7HTG7MaPYO7neRFe2MwcWt2OMkn?=
 =?us-ascii?Q?8R+gKHYxO9RnUNYdx4mhycvl15NhFU+snt48hThtbyHrNUj7/vrEjtBVNLyu?=
 =?us-ascii?Q?ABRFVhbYdrDghX4DxKOnnM8y3I5ilcqrKYzt2KH1M7R0aSq+RT1kVlr9tcUy?=
 =?us-ascii?Q?tLAYY5UKar0jCvSS44ee9pRP5nbCgs0cs7jG3l8E0Q0MZwqSG+hq74z2U0zY?=
 =?us-ascii?Q?nKSTQl9K5W+95Sv725D/oMgv4bMOsvtvPumSeLcmsqOoz9IvoM4i1fV8653V?=
 =?us-ascii?Q?82EogxU9wpV7hdttdFOSAu6yM7Ycr6zZxzBZ1vh9O9/veUK6cg0fGAxtNwtX?=
 =?us-ascii?Q?xjk7UTD6t22Z8y2aGTL/mN+soEmSo8a4DuwjapJDE544mz12eztmlETxzAq4?=
 =?us-ascii?Q?QgywQpdmxqelOQNxI7AGWNWpSJ7dC1cr6xMYG052AAvumqLaqQlPlLJ2GKsf?=
 =?us-ascii?Q?nyYvdg0dvhUIFDFLEZ+DWdXyPZvht4VmuaUUfYlOwAv2agOuxKpMPl3aV3qK?=
 =?us-ascii?Q?+0U3xxQubEs1l9DDyZJGwcrhdw4FtlTKhO9N+uMy4q0LFLzNIWljn1jrf6YO?=
 =?us-ascii?Q?7MDmvagcb4Xdntrtce+f7/MI0TMhvG1ZfQVJC1CbHxXSHDAI79U8bGV6Aklv?=
 =?us-ascii?Q?YkN5/y4XxUOdB5bP6PMpGqPOv5a44T8HUvyqTsaRCUIrU5QJxK1CTQgQT0cm?=
 =?us-ascii?Q?1bTFRYj9cd1rqX6p+Y21zdaf98dI3dka0sO9ncP1+raBrg9nvkLyH95vTtYg?=
 =?us-ascii?Q?jL4WP0pQSolcwV+3cG9R+g4PsrjWJRygFtIa98A0bRM/80zbSvqpLqSTDYNI?=
 =?us-ascii?Q?Y69bIIkBVuI+tkK8K2LaS7w1RWBD2YOmZ2Bql6axPuJv3iuQR4bCyVj5MvF0?=
 =?us-ascii?Q?NVuuwPHWRvjVZm8LgxXVWrPwpxdzMp3yoeYpYm/W?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca564a-4182-4f81-61b1-08dddf22389f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:13:43.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLZ4aiAApR5pvDqCjYk00LecAFuRwLuMtLxqTvvDC1Z8FHK3QRfxUe/2lA0nxKJ+SVIwpEPQ/JXxOwUe7hG4mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8028

The header file <linux/stdarg.h> is already included on line 6. Remove the
redundant include.

Fixes: 0dec7201788b9 ("sprintf.h requires stdarg.h")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 include/linux/sprintf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 8cb32b777d0b..e57a6d6fbd93 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -5,7 +5,6 @@
 #include <linux/compiler_attributes.h>
 #include <linux/stdarg.h>
 #include <linux/types.h>
-#include <linux/stdarg.h>
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.34.1


