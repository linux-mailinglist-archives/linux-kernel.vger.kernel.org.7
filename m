Return-Path: <linux-kernel+bounces-749204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C115B14B68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379823AFC24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39D28850A;
	Tue, 29 Jul 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="egcFT+y9"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013018.outbound.protection.outlook.com [52.101.127.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B022877D7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781843; cv=fail; b=GABQmxLgLEk/PJ46enKtcNZxCcSQP2PTuao0NNI+yilTIe1qytZH0gKNLU1DTEizhs3H7x7J/CwTqtnqdSkaHDNzavqiX3uG3giE0tTUiYf/rO7g4Modb18geKJGt5p3XYtAyHCb6thneJCTU/SUhzNykd1JO9Y9XWwHWmyI9ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781843; c=relaxed/simple;
	bh=4us/kS8P+sDK0Ps81ckHNWra6RyVaN8PoJr5+ZODsqg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CX0mDjC0tz67XPx68/dnaAkpknj/ZAU2w2vnKBw5LvXmvALPuH9PCJ6sXKT8IfMklkiEqZ7FBgFNPxcJC1bA7qEm+8eATMlc6q0ooAOr5O6kstsGkanVmXqcP6uSWD2IcbgwH9OcoQK3dSfGhuElum/WIP6rdGzUuDNuZIDjroY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=egcFT+y9; arc=fail smtp.client-ip=52.101.127.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp7Ej7Q9ZekG1yC2/d3BV2n9fwsAH0owORhRiJP0cLbbUzq/NvCJbN1PKYcTFRi83KPvc7iugA6+uA5GH/W9FlYmgA1/LjMRsw4k7O3f38nT8OMPRPQNR0r68zaWPHfMT9LADJa791gdSMTOaLqI8w6DK5qs+H7HcO4YWWc4W++PjZ2VYBHo0Nxz/K7SvP9gvTFuv5uD7NpeJskmW1JtEuXCFJ/jZIg+mG15WjqqungMkNUQyAHtQcSXPoheVVkU08EtTzeG1++nZNuLol/JUVFOmSfXJsKGsJ2UhvNIeCcGHOtz7pCk4NRboxKHwrwiQnOtq79J6LzPBz+GS12zSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qblioen5Ryzikn8EXSH9oxbouPowOHan4S4EWEYJGuA=;
 b=JYkgLdWwUMIUDSRy0A0kaSEr6Ripnd4ClAd16QxMnm/hY88R4O/ac1RRflcfowlMQSzeFxGCOqwScoIsa8B50jBjs0B8KSSA9N60twUHGE7zV5biQIata3zNpVnm5R2j/h9KdcGQjkwue9aX3DE2LDYumtEcD40Im+ByYf9FOxtiTrgF7+cJQ6zK2/GAUWCTe0PuiMpx3VNdo7m/ONtDAmu8lY37SgUzlSMGocqN6YnYaTeusVLbM1L+w5lQSP8aM9ayVN6jyL8QbkbAGwI4r5g+unnpoDPC9r7CB+oglHXz83NSecjvdPVGBoSpoKeBb8+Lfb0WagxJyS26ZtdV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qblioen5Ryzikn8EXSH9oxbouPowOHan4S4EWEYJGuA=;
 b=egcFT+y9Zd1jOlErauR4n+l8qgNASv0Egfry3ODLeZ1ztgrdd6qWiaj9+pKsBgVOX83tglDBeMWMPh1LI/creoCChr0HygBir/H/zEgSiJdJTB8vsWqcDjPDohgG7XLufadDuGrFbhDelQvWRPftmfY9NQxu7UFyvaGqIXe9hmLsQ5zklKjZ6wretwIikyUvIzCYwD0BFDshIdkq/5Zk7dpjLRPiUyulB+eqBX8sINgnHIJpIb0Pe8BsQFKoUCGXN9c43J0uR2oU0sMps0eETB9PI/yrHIFlBH9PqcG1ktgS3yY9eHGzLQCN9gbIxyrlcWoneK7MX6goNGQ5aCULbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 09:37:15 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 09:37:15 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joelagnelf@nvidia.com,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] binderfs: Use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 29 Jul 2025 17:37:04 +0800
Message-Id: <20250729093704.596293-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To TYSPR06MB7008.apcprd06.prod.outlook.com
 (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|SEZPR06MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 605167a1-f432-4f31-f61a-08ddce8380c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ji6mcOMuAHo2Sdb5BoAYHio58XPonuHw3aqUoB1ZplAPBmjUHlNjfVLtsnU9?=
 =?us-ascii?Q?/XJyHkUDRLqtyR+rSLT2uJhb3aBJHHjLLJsitI6zhXPR6NI/pUWRmkg554sw?=
 =?us-ascii?Q?oqNULhVDCpay5nmthix54dV5rQolK21+OUrLR8PlV2a/KL/UH0r7QRNmzjpg?=
 =?us-ascii?Q?UNwg9ccQRc+Kuj+SnICF0GeMofDoi0vWijMILSdg+ZkJqhKqHK/azv/771Ds?=
 =?us-ascii?Q?+cmYybJvi0/HN/8Hu6ZYTnEMw5Dd5tI3yslm+43AoVwDHQjUC8Mxt+WyKvV8?=
 =?us-ascii?Q?jFXhAHgMkU4x5ufV3k/vQ+qYhUqs1J7/9NYqRoMAfqFF+8KayikwNiUgIfGF?=
 =?us-ascii?Q?DqE8PLgxEGMFv/7hcQ7A2SwiUmQlgDYgCFz1Eytf7+7kkq0JmGs243VB2bmx?=
 =?us-ascii?Q?GksGW1/lFBYiTVl6tORwyPcqkv2JziDep1URK4CH0pnQSUoGn1pc8ESM8DbT?=
 =?us-ascii?Q?ees+OtO7zPLzAoyEnk+i2/ZmCvpWRIbrDxlT9zb9sctXvU79e5YCiygexKx6?=
 =?us-ascii?Q?EkxtTj9sQyUOfcjfJwa+HsH6v87c5XdshsZlsFaTmc0Wdq4ayaIVvtp6BmEN?=
 =?us-ascii?Q?nTXyFAiTXSNBXr2/VdDJJ6n7iCxpc0tKD4m4K4ALEkavClsSAH80POo1VfdV?=
 =?us-ascii?Q?K7R7JuVXuYhcUmxIZbeqyVvoQ7b1FR4XPa1AJ2EkpATEiB5/LtrCrT77ROcW?=
 =?us-ascii?Q?yRGxQuPbj5JhEGgKxC8TX6Ew9XzaUAPbqMFcCzuuoo40YM38k50GhLAumaAn?=
 =?us-ascii?Q?3SiyD8NGnC1BTTHhk09WpaDn8dhmWrcuraXOYkXFuvPbwHpwDJfY6QV0uE+T?=
 =?us-ascii?Q?iMroWidNRYntzlVuNV/wiUtW/D4CFoLFMxyYmHd2hWAERaNkcN+iubKRG9wT?=
 =?us-ascii?Q?Bs3QW9bxdocU8oV+QYbVxPpJi6t379RS56am7JpzxEbbhim/7RGcGYtlkex+?=
 =?us-ascii?Q?OQNdLbYPpqlVkuPzS5wHE1n63wF+StyOXsYY2wctF/MKKDs2dEvCsW378jtq?=
 =?us-ascii?Q?PeoVlKQjD//gdOhn1FuJpeEeB9xv4HXRkELZGAd0XqWpvylOeOaWVSxHYhv9?=
 =?us-ascii?Q?kz+7pCOn8IYEgnskha9RILzzuu+nYkK965BKOf0p0jTMC2nsq4VNq9kk/Wd4?=
 =?us-ascii?Q?KN9rCok6Fylw4JntN7hH9A62AjrKbjQ7L3worYbmT/1MJcVOQv9yviXZ23zz?=
 =?us-ascii?Q?5vJ9QNBtcv3v9Bxc8tVdLHnxnTbaOSC3NpK08yoUIBl6UEF9efShkcoaGF9a?=
 =?us-ascii?Q?p+R+UF6M3z+OeTvTJxZv1JOOVmzWengeAw2kzLRXLFWi90X1RfjG4C0+24lF?=
 =?us-ascii?Q?U8wXQHrwrZZqS/w7POayvwr9pziturZkUqVfK2sOgTZruNbL5gcaYkW3XK3N?=
 =?us-ascii?Q?sl0KPn50KScXWUw1p1CxzXkuDt1d24YHqEz6eiM3P2O+9hYquhIg7sKAZZuD?=
 =?us-ascii?Q?lAZPAg/4yja3pHM2ssQXGG+cOsSTMW2uIA3w2dGR5az2jmJj9vbFEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uhr7kSAW5Y7FMfTp/ryj0XbQUNT0hdiHjpFGn26y9c9wfvAD4cHDDqI/YOPu?=
 =?us-ascii?Q?VO10Pt7HQtqPEvkBH9ZvqMKjoU7yxA11QVmrZ0Ya9/Rw0TZQNAXALt++1K5y?=
 =?us-ascii?Q?gU2fbNC0QBS7zW/e8wPEVZMQ/Yomb/AaEz/vj+QkX7CmeseZ7V9ykXVtO6RI?=
 =?us-ascii?Q?sMXOoV3bVfWDF5p4XqfD4Eu5zve1xqqbaHOljSJt927W4kGPxK1VjOa6ruoD?=
 =?us-ascii?Q?bsVdHbez3iUuS2REpYjWwaFxKoPizIfcirEkAmE/etS/QPIAAh/AyaDlRDeT?=
 =?us-ascii?Q?Gxiwj5lIbTpRK0FxiHeJtbu4hjF0n6NfTAqm75l7LR7SBq5dM85THCRNR+8E?=
 =?us-ascii?Q?2zpIJhPIoBKRZp7/8i9LqmO2Rm6DR2u1SVZAzrMsd5Noiz79NIVTHSkbZaBR?=
 =?us-ascii?Q?2LjHC+JKHznVWUc3twxID417+iLSVxpQhw/WMka4tofCGcn77GFIGOvB37Ks?=
 =?us-ascii?Q?0u7o8V6D6/AANye+6jbhaK1GGB79nXAoqzKsXjmJWkMC8CICs77P5CngUqPi?=
 =?us-ascii?Q?IJbK6Iz/3BiNTQ8vE2kt2DoPhq5ZBt1OOSMTYB2e0qheXAmDO6hpClcj5EmY?=
 =?us-ascii?Q?jR+bqKlw8Oq7VNu0ZspVVXir/SO75RtXKiR/OUHR93y69X1Vc4juDFj5CFJ9?=
 =?us-ascii?Q?ck+mRee9HhqJvVy70Tg4dokArXcY3K/hbSxw5fJOEV6UXr8I3SJrr/dvu2A2?=
 =?us-ascii?Q?eXKYjTxLV3l0Vq8nUuVfpBVWrEQBW2RGzeB/4cqWhFO8xYGOV1PaElWoBtgX?=
 =?us-ascii?Q?f8HIf7Xl/euaczQn2/8UcDjsOvPbIBolZ22/pLnl2sj0fv2/NsPA6B3E5tQM?=
 =?us-ascii?Q?VyxekWLiw7xKM4LmvVSjNoo/XE/spscKPM9KcJEOOJk1l4CeVs8d9UWrhr+6?=
 =?us-ascii?Q?t21zroACGfC21b8HOT5VLQNuKAy5rfFU73QCPpcuBmSE8n+TCjCIzOm+78f+?=
 =?us-ascii?Q?IqZWXtzISsAMT/3HJ6ICCDj4Q6kdpd8VBjWf3Crc0GP5H/6gffNw52E4diVa?=
 =?us-ascii?Q?ssV3eDWme9kwNS9a2P0KHOqBu95FOMlUx6TOLO3frgTTCPMOM7l7hqJDVbFG?=
 =?us-ascii?Q?Xv52l4Al/DViZVKeNP6rwua28+m0Qx6ISAeSATUidOdWWz/Uof82RQcueBOb?=
 =?us-ascii?Q?suihm2LVOSJFZQaYAFfksGS8T88wPph8ccwY52mVdgduSn0QNgBc2M9ZjBfe?=
 =?us-ascii?Q?dbKjdF5vR3xw9sigAdVdz5B+zcRRm1RxL1oci93MG87IdJhpfKeBB4dbmt/+?=
 =?us-ascii?Q?cF+TeZanDlJUvTtFi4ORHbxF1UKYsd8jNj7aB2udHCxZcfyXqaDBfx8a2XYl?=
 =?us-ascii?Q?84+Kfl7A/XsByVSq35wWDCx7/VTghfU4vBEEHWSg8hOJHBqSwH1kxVimKsUI?=
 =?us-ascii?Q?G2o5TdEsX1zMnC4VCis+xTkecqHkklxJrwoXV/Z8id4+2xRFhrK8yPhzHEwS?=
 =?us-ascii?Q?voR/TLmgYFl9BSrJc4IYJo3Xg+6/BO2+OJdN6zHaASQezfmqlUsYrLWIBhY5?=
 =?us-ascii?Q?Lq3qYYWZrW6p+MjkMG0zaw6thXlJEGy/cnvzsm0ObvO4NL3QEcdbvkQBfmdC?=
 =?us-ascii?Q?TiO1MQyWvM08r96/p9QKDZSpoe17j/79i3zLQsGB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605167a1-f432-4f31-f61a-08ddce8380c8
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:37:15.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pucqi/9yfiSVUAXMcudzm6n+8qkD/zlVPqEtjUUh28W7RilFx13zHZYLNKZC6A0ojXFr+pNlZWy45JbtvV6+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7140

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/android/binderfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 0d9d95a7fb60..729e3ed94b89 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -598,10 +598,8 @@ static int init_binder_features(struct super_block *sb)
 	dentry = binderfs_create_file(dir, "freeze_notification",
 				      &binder_features_fops,
 				      &binder_features.freeze_notification);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(dentry);
 }
 
 static int init_binder_logs(struct super_block *sb)
-- 
2.34.1


