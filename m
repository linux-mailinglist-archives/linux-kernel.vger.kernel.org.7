Return-Path: <linux-kernel+bounces-766394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B514B24617
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237CB1BC6E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF42F3C31;
	Wed, 13 Aug 2025 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yw7q2bx2"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012058.outbound.protection.outlook.com [40.107.75.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B62F1FC2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078303; cv=fail; b=R0stOWf/y6GnIiTx3mCY5FEh5R+qgIqMhAf+8+ps4O0wtwymC+z4ljay8nHMZuH4pspiTZaEGCCRk4JuzOEXPqHimarDEzoWs0x8XREr43hPYPU1D/5aJcoEkrO2uU6E1ckVRLRWjTMZeYBE9YSN2kc+Wv+CfQY8sVDJ/PWMqk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078303; c=relaxed/simple;
	bh=KFiNqaI7QG2TAc/kg+VqpwJw/Wkl+PLq25lDA5kOFXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NiXmg80/rz/KCRtCf8uCzPRlO2pTcC61+ENowLoQRWutwRGNMCM17YbNT/dTpvHPUFFJOQZ1rvmnBr5oHoQShXrDFXKy4wT90IKV7XCS0OSPqoj1ZKQiL0a8vUexWf7zKPwVFWYxQ42MVEHZvPtdiJ8YvskdNoOPe4NU5A+VPtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yw7q2bx2; arc=fail smtp.client-ip=40.107.75.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmeO7DLYrL5fTVYz1C9IKu4IYIeUdSlAfeSHopLytjh8cYz3jFonetmFsegldIqyI4qQtzmxQPmkD0l5ZurNLQw3/M6GnaYGpHJgaq+H0dajRFBuob4wHhOOUnar/+jMxCZq8yw14lvgcdPgPuru2WsCjzz9KIo+l8XiqJNEFhjXZK7S1JLrs/oKbqS2VSCcxxN2g/rtfkvS8Fnuk8l+TYGRGZIVfw4zs9moTyAZtEQQNDhRx6V4XkR/tXK70M9W+YWdad9/D4R/Gv3KW2Zqxmc96hQ9cNjeIjNk+2pQbXQPafXQJfV/VJ0jwQt9myajBb/f8aYDUufYrY0RSTMltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUgOfkr915ycMrM4wgKD3e9rmZHv3ootNwuttFc0Yxk=;
 b=cc/oUXuGesaEze8UUjV4kWvxLq2uXk8Uoz8yXbeF13gqvJt9JzYH1e+lt6TdyBDdsHSA48p8NazJ+OvkmRfhpG4kqOSZL2/8o6EV9YoLRZq/Ns4WsnQYd6ZzQMwn2UTyH9mUC/YxIfKK8LRZdN90g4bB0RACBmmy19PV7BMBSgsrcqO1TeUN/KXVB9/8ZiBde7FeAZka12x1fVxa3BCPWCPIC7nbT02Vc7g7Bd7OmDh2rKlmo9YJ8j7nkdP183SvYIhvBYKaGLzW11cHtYyNHkyPHPfttKWbwgRHLZ2HO3v7TqD/K59xTNKmCMxEtZlTR2298MkAHbGClXc6f6VQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUgOfkr915ycMrM4wgKD3e9rmZHv3ootNwuttFc0Yxk=;
 b=Yw7q2bx2vidFo2HIBCebag2pIZZkHlcnnT0SqANIK01RbU/dhrQPT5ANdp85xzHmmO6wjp+izEG+G40JXsrFyBe4OaH+6jDy85aksy0ZRqTnYZVatXj4UbyOuL2lgzyc7eksYLt8uy/cSgjTm8Nkbkt9C8k7JliTtoBnXrJ4KXImsBM1ODD7VXw54Ycw/uPpftpiEN8XmY5o0tjgtFE4My05ipmWjf+UP06o1zST2eqDAgZKIp7M2gKCKzTzsXYrOErx8zkt7LkRKgU9VLV1Bgpzf1LHNvWL3geJTHQtfx9UQXwW7l61l4BnOEbMaoDq29nQqVD4V610keR25rm2lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KU2PPF4166F2409.apcprd06.prod.outlook.com (2603:1096:d18::491) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 09:44:58 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:44:58 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] lib: zstd: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:44:35 +0800
Message-Id: <20250813094437.555073-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KU2PPF4166F2409:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a2a50f-1a23-44dc-6acb-08ddda4e10e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7+dky8fi68pP7kVgWjYQq525D96OThSFL5Hbjgu5O/gXnpVi85kBJLwshWp?=
 =?us-ascii?Q?e5URhvoLmQqFCr3Cki97TF4q3R9NS0M4upy/TCT8uwFoN/vHxPoHQv1r7aZu?=
 =?us-ascii?Q?ecXniIA+rZ8GDlC85KbZqGq0KLXPQbO5ZYyQFsILcR05z6lDnsjw7G71M/RN?=
 =?us-ascii?Q?k3kEyzw83VNe7/DkH1NVYsYauPi0IQ7CKWZTZ40XUhgF+WKwAwkIVMuqlXZV?=
 =?us-ascii?Q?2FCBiE0R4IKd3OMjL2zIe+Nhd9x62Z99AfuAAnWv5obcn4V7JIRGGl1XijI7?=
 =?us-ascii?Q?Zesechqv3ifzxiOeW9IZdFATyQxZVdgUBN3Jc9Ap2n3NkjNnllJRbVcgKOVZ?=
 =?us-ascii?Q?C9CSHhFwiO6zvFcdJcspPKEJxHrV1avhpo8qUSF/nm+XTOUfZF5OWus9x4V8?=
 =?us-ascii?Q?zehfFImSTNQTrRP77sqQ+vulFV66d2u0GrZlyAHpv8vixiEe6sKuXZpSmL/V?=
 =?us-ascii?Q?x/lHr21fpy1fM6h12B3RdVy6O0ZoZ+riWuyxEbVl33By3RRYkMhBd/pFBT+W?=
 =?us-ascii?Q?IMK+yOxoiL3k7Jwqg63l3kanLD1BKdn4IFESXDPJLZhgGv+VXs1Ts2ToqgNd?=
 =?us-ascii?Q?cMwJ0mUd0Jan5MjRTZJTfJZyUkQeJBd+A0ohtCLfzS+4ECbUBkso6Zsl4T9j?=
 =?us-ascii?Q?2PHudDd6WiX/SkRRojVGwE9imR+WycCuPrjisOWu6TbZ22B8zGuHfvNWs+a9?=
 =?us-ascii?Q?gXBMBxmKuLrkUEz+2wt2iYiBif+OyAPn86RN8mCkQTfH6JZrzN1H9AnTbtOg?=
 =?us-ascii?Q?VZpQVGRmlhZGqK4zL/V731usAPdZ4XvVJ5uS8QZOSr0e5XX0DvbBdryeuDQL?=
 =?us-ascii?Q?MuzIdYQBT2WxmF9t7Y/CcYWlj+h2z51yI6I3w6IKK+OAZ9GCtKfyI8ShKn8M?=
 =?us-ascii?Q?jhsNC965nP0hQ/0kLHPPcJEAmp1/DTeo9Y3VlTx8uZ8YjPTB5UkkHiAcTqRt?=
 =?us-ascii?Q?OILCz/2YXvkNQwpP3wMB1TUPO2pq4cjopFfKLVn7PRoAcIRapbifJmjHC9Xk?=
 =?us-ascii?Q?ztUpYj7/z2ne5jiLEz+CV5t33eM6G5tY1GT06HN1h7RzQGT10yvbdx/1m4/o?=
 =?us-ascii?Q?w5euVgKw/DzvSwdB6oBcIG/fnTQ7QAgQfLofQ58oNLxQ2BM5Lm0MBPlfWAo7?=
 =?us-ascii?Q?Y904b6d4vO3CBo9yPjUpyRCOwdNFs+ZdeZRhl1Ua+k08nokEOAraVLQ6VA0X?=
 =?us-ascii?Q?ar1VfPGhqgQEdj7TZOVAnbud+2597F+vFm3g9FAvwu/vcLCIrWy2Hn+SI3yu?=
 =?us-ascii?Q?09DndiHpy795/ELJ2GQ0drAt3RlXLw8erTClw1jwPRxFrR59w64A8vVMav4j?=
 =?us-ascii?Q?kHywqNEdASoRc0vfg+dAAUYAUxnyYXWRfD8p/RuocRNFU19JJ89/X9T/tDB3?=
 =?us-ascii?Q?UrXFw9VPoh7cdkaDvJMztnN1LGD1N2Zz0wQs/KTRsGuoakkf03mvgAy/JPfY?=
 =?us-ascii?Q?fN94JXofDZ/zf8gzxgcv6m9FsXymaCaftSd5FhC6TIptTM1S1fkFdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGLaAmPZsXTZQ90+JWXpSFYQh4giMEoUgFewYj6SSEL+Nzb/eabnBQ/SaywV?=
 =?us-ascii?Q?xTvm84QwMNBwjE4qK5nL3edBkPPbwFoIV9sMksMPG4jKEz6TxPhodQH/0k72?=
 =?us-ascii?Q?iwkoQdDsr0xi2eokVxp3kFHfEWmt9Ewe2ugWvUfxxXS+ds2YmI8GrJnvCDw6?=
 =?us-ascii?Q?+PI9Aa6I61spb0A1rlMvWz4VXpd/vPbvoISiu2hUPvZlKdLtf+YnXGC2eGcw?=
 =?us-ascii?Q?BdavPb6u0GO2/nJpsdsBuB2KFNHDnh8gKENsS5wwqcTLhzRLx1KKYUD3/DgA?=
 =?us-ascii?Q?yjR7gqvPfRbKCqzsBWHAAjfhtVBwnERrNn8gExMct6CoTlIJQsK3g/rEpqEr?=
 =?us-ascii?Q?XawiLCwrV6zYl4//W8xipzvE7Idsm0HtTMAB2mpbh9TYgdI6fw/Y71SZoQyA?=
 =?us-ascii?Q?63XQtZgoeKq1xw/8SL3NvZB1aOcGU7/n8C7tPw7fjgs5+xVFauKxLMZ4whLw?=
 =?us-ascii?Q?G/f4kNyiLLobj5Q+zAa39kERXP9VibQ93xugMJtoPdNIVZI23L7gDLg2lpmD?=
 =?us-ascii?Q?6Nbn9PUllHD0frhl9OUBKWiPQSiJesD2DMmEp5kaI7SKKq9AjfZKy4y7YvP1?=
 =?us-ascii?Q?5DjQH9NH5cGEuRb1QDUZNdgzWYSusPnBTQhcyWrCRv98H1FS3KBSwkIe7liD?=
 =?us-ascii?Q?LbyNfOv8zfbXTaYObO2Uyro5VcFNBmsrAgyctFhXA/0CeKW4kzoE/C2BTfkn?=
 =?us-ascii?Q?uaMlm0rZ8CLg2OXDbmPcrwWmZQ/zja2Aw5AUdSKNDOpWzftB7TmqPbl5+Njl?=
 =?us-ascii?Q?OgBNvJVDKEKsjp+aF8gD7hexlmdSBT4WYxWojmVg9pJoW38Ok7Hqo+DZAgpe?=
 =?us-ascii?Q?BKdqG3cVqdtEsCSGFDpnkgU4pzFHKzCwzeKIdNjJ2AAKgmj+qFgMgTk9vafy?=
 =?us-ascii?Q?Tkp3JJZwMcG2GHrjqSdga2VJ4vWdLJRAdcJe1XMqngwSHX2YOScdt9hyduH5?=
 =?us-ascii?Q?tcQnKIfaUAbhMZMHtZtTBbZi6zVlda0gvb4lN0+8n07YzhB5cwdvAPLXvA54?=
 =?us-ascii?Q?7v3KaoXZQ3xKZDO99Tf8XYuf1IkwfNkjDiI/hd92QmSYhzoBusAvDF4tIphs?=
 =?us-ascii?Q?zhtSAKQ3UE1DA5KXqqGKHmilVYMjoH8zdqgL3B0LZIn/7t2wfe5LI6I6T9UM?=
 =?us-ascii?Q?7Ibxi4pnFR7wguJ/o3D0n5W4qFYXGhXGVIBLnQuosxH8wFRHNHm8+9K54n40?=
 =?us-ascii?Q?nzojclctU7joE7AFUR7CFGGCfhkEN4fgXkFShv4c2ggjpH4heay0v98R45sd?=
 =?us-ascii?Q?TccOhMCAKVoo/umz20SVt81hunL7RO92b5+rh70dAy+bpAqaRAJlKV+wRPlP?=
 =?us-ascii?Q?jNEIIBFlr2G9oW6gNTCo4cUyhMG98aKrRJN9qIPiV/T4mPqjZG8KzEfmx4GS?=
 =?us-ascii?Q?3aNBI0ILyE2KLn9dRC/JcJSrKmq/HWNVAfaF/VW4CfyQDlNIScOgBrzE/XvO?=
 =?us-ascii?Q?4paB4o6Mesm1qj4UOSWvOZTlH8Wj9kcxORUfCJGNMyXp+tQ3Qqf/YPLFaF6R?=
 =?us-ascii?Q?kUXVCBwrrD4bYirZjYU4ZA4Bn0jppiN4rubEtdxKs3+avYYnvCk6we+VyjIN?=
 =?us-ascii?Q?zGJo6HHqASTN8gNxoOn94UlQQPoZcGunL59iJSHN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a2a50f-1a23-44dc-6acb-08ddda4e10e8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:44:58.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJKY/JftoSN/IvngB0y0wGEMgtyF4lUeOI4PUhq+tZcNVWRzB/Pt0NMILkRDDl5oyRlQ/7Id1q3u+pJanDq7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF4166F2409

Remove unnecessary semicolons. Adjust the position of comments to conform
to the recommended coding style.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 lib/zstd/compress/zstd_lazy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/zstd/compress/zstd_lazy.c b/lib/zstd/compress/zstd_lazy.c
index 88e2501fe3ef..d0aa8eab0311 100644
--- a/lib/zstd/compress/zstd_lazy.c
+++ b/lib/zstd/compress/zstd_lazy.c
@@ -1612,7 +1612,8 @@ size_t ZSTD_compressBlock_lazy_generic(
         }
 
         if (matchLength < 4) {
-            size_t const step = ((size_t)(ip-anchor) >> kSearchStrength) + 1;   /* jump faster over incompressible sections */;
+            /* jump faster over incompressible sections */
+            size_t const step = ((size_t)(ip-anchor) >> kSearchStrength) + 1;
             ip += step;
             /* Enter the lazy skipping mode once we are skipping more than 8 bytes at a time.
              * In this mode we stop inserting every position into our tables, and only insert
-- 
2.34.1


