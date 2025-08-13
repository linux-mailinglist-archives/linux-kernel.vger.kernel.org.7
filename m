Return-Path: <linux-kernel+bounces-766396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A61B2462F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36891681C17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5202F5491;
	Wed, 13 Aug 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KmzrqHUX"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012005.outbound.protection.outlook.com [40.107.75.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3989212540
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078359; cv=fail; b=W/Ihr3RF8FfsrPIFT/UkJ+ZndgyGNJUe9h4krxllW8OdJxFxOjPJarxmq5Nso3NmSYGVfAfR+NFLov88NFAqf/TTi5cjJfEJYKC6WtWPqzoNhHJpUuh+fRUeoGpkIik1203PxenfVvWucfqCCG1IYTtGciMQTtBATEhwWOLJYIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078359; c=relaxed/simple;
	bh=QGCRfW/Z3nHj0Zl3tnb6XJXEDNk649Crq4j8uS8JO04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FTtXhvUnZdHGWtmYGoh+zVcnqbvB2v0TPZTIrHXcaAQMXoqti6DMkZ9MDdJ1KHS6s7P59BH+Rz+LkD7nfP964l/hCGWFY1jHmA7UCf0qSesl6ld/snT/1x4lLUS4ejJguC7AbcDomuHyqUL87LS7iMcfNak3nCD9c7Kx+6G+plk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KmzrqHUX; arc=fail smtp.client-ip=40.107.75.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAIiHz5iFUcPZ5Obi99Dx0+FCAYroaOIT8yaSIJlUugXeYo0Sg4BAjEK1takEMjoUUPp9LduPUlZdnEDm981TgOfcMNX1YT7hqKPc/CILUti80wyHbeI/5oXahj6GkD5EK2gdfMqSiEWxgB2OH+7xwov0Vf2Na7jlZpe1cBWLWxoFsG1FJDK/cz46Se5HukE1nU4U+uZzP5A5prYt/mlsW4NSnuviViv6D9XtGWic+4FpxTTnozE4Q8Wa43YjH0dgQC+0p+0OTYSImSxGOUmLErCj2SX+wRw/JGyuM75vTZCGCHTVJI8qqc4TWf/CyQURzoQMB9lFGDpg4xbu6zuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvwnVaExqycOqc0kwVLgGS03xUb3Edd0NEyIX+2ay0I=;
 b=kv8DCZrBmrV/VdN4ml9o2gqH0yiQvrYMI9NaoNOTAvlHAWU7qleY5NE5G2g/DeWFmRhGBTNK98bfKCePbjRsSWmchSQ+OfsPF5OtR1DqjpUXsEbTnNrOHByjPqhOob0UKSPERsC2cXDuJxLio9UCTw5o8LKlQRqEhlhyNY/AEN8seI/m43Q5dSmCGh13Z6aOm9Sna/RpSsLITNyT2SxjPstsDhI1kBgyZ5iAQ2nDuxcw9id2e+y46M4H3NEtZilTd808Y160scds+TjxQ6aUxgUHs/DdXQwRbWU11QMDoBwQp6rd28U1P7dqTtJJ6jv6PH7GyVcxNNBud9at65rqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvwnVaExqycOqc0kwVLgGS03xUb3Edd0NEyIX+2ay0I=;
 b=KmzrqHUXNFEveGun/n4jpX9sSOp4tVosVYNf63F/9zzVpTWuc3Ke1Yu55Ekw0KJt3Eq+FSZR09hQ8QGw45uQ8wltqHa0DUbrY9imDV2euZ3ajATNUuqWyKjxBNCmfp1tnUdvUt5tVuiz3E5zclu22ZH33zTz4raDuHMal/vVuglXn+TylzyO1lMLYn+BcBx6/s/gwesM6/IdwCQuJRfHpK2XiaN9W4J/EFAAKqZL16GfweVQ97AQsteXEtYo2Tth+ELPUqCKLFsZSLdO28T4SlC9TwtGYBYz6bYxbCFUVB31i8KxBvTcqF1gbCAIEsetcq76Vud0qb2H4paM8T4zFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KU2PPF4166F2409.apcprd06.prod.outlook.com (2603:1096:d18::491) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 09:45:54 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:45:54 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	maple-tree@lists.infradead.org (open list:MAPLE TREE),
	linux-mm@kvack.org (open list:MAPLE TREE)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] maple_tree: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:45:43 +0800
Message-Id: <20250813094543.555906-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:405:2::36) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KU2PPF4166F2409:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2cfb78-7065-42fd-a23c-08ddda4e31f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8I+MKYrrJ73fk3Ok2jSlpBFskCeQF++q2YxKJ0gUO9hlagMvK7mPZGUq99M+?=
 =?us-ascii?Q?nhontKAV+PD2m4EVNzd4BcFNN9Lqf8uivOdA23FC1jx4TR9C/+J+dRt0Uu6i?=
 =?us-ascii?Q?CERlBM7IuWIFBzp7wyV+5n3vij4pLebrxlAWuePKeP0P0vEPCRDRwGsg9+7P?=
 =?us-ascii?Q?1rRhn8nZW3RoRrmGzhzvy+gQE5g/rpUycpEolUAxATqViwPg3gr3nogJ1i5Y?=
 =?us-ascii?Q?7Zu7q3z1GF+PO65rniRrcdFSigN2JyhW4tZpIEs/ESkoSQ+XIWkmKI486+1A?=
 =?us-ascii?Q?F3OWG+FmtbsJMWhoXwDXxHrdZ3BBLPnSmggi9q3cmiVQNZOUDISvjeA/gXU7?=
 =?us-ascii?Q?Wg6G4LAwHiAXxClZ98BYsAP2DVbgJVt/mhYWbm1tdnaVekVO/hDeDHYwgKH6?=
 =?us-ascii?Q?ljtpqLdyE/ynttN1PimZYH1gn+sqvYI/iazSnpDh9XKtu89nGyoRuHX4mHy3?=
 =?us-ascii?Q?/+e67zOjZ+1plqVmoMoT7Fi2HDwiO2fqZjjGznpsqamUPj6yeD2k0cNIB2+G?=
 =?us-ascii?Q?G5ADQkLppg1Lp2YeWDsz4KPuodYzjrcHtzeeVbcO7ig1MDRQyAPdSDmfaYF8?=
 =?us-ascii?Q?CTTOu4zvt5rZ9hwgCAoE4SG/vRP353j44pLdeugmz+o4nAE7ZLYg5SSYbhlP?=
 =?us-ascii?Q?2E7S1M1sQ1J+zjHtr6XCcDpBX5o6sULYUaRMyme1F+Gt7G5BavQ8auh9zCmk?=
 =?us-ascii?Q?Y6r3Z9/VVJMl4upO0ibyZQB4aEmRPFa1VpD5flaSzy3hYz8xivCjoRJxNOSA?=
 =?us-ascii?Q?EsE4sg79UYZqz4OME3K7FnbDADJjiYzc7k/dWdHbELpD/r0vlZmFcRnHymvp?=
 =?us-ascii?Q?2tpnBprFCLjUzVTmgLVcJyMivhvKbKkRhRMlDXFohPnv8U7TCiQwSwZTam3k?=
 =?us-ascii?Q?5EL8GTh2fCbroYqiyqHDDlvdUTPq+fqYVSXSPp7oQUZxefkZhSbAhau9KsI/?=
 =?us-ascii?Q?NYzOk+cS+B5U2220eeVN2al53adbrFCvX1OTfk3gI940oo3llPOS+FLd71kK?=
 =?us-ascii?Q?TIJKgauAbucQvr4w1dwEIS2M5vbFrLzylFaOq5l3yN8GgUCMBZMvKV6RveKO?=
 =?us-ascii?Q?HJngSlAiSbDMBCok1fSvYWfwvoqudwwmfl6EmwlaS4//0xju/MhQL+SZg1K9?=
 =?us-ascii?Q?AqOnRjb0C/P7+Bna4eA+wcXqkU9uzuTywOBsEouV79NQnK08gSMV6DHJwHlq?=
 =?us-ascii?Q?3S6b8m77hRn6qcL/z2ghmf+5HE4aAVvA4A+dIkB5OSyzg4+V9awgLnjBkqZS?=
 =?us-ascii?Q?Kw6RmwZm4iCjx75xhOjnPwFdbet9yBT9jXBIIjfXwGfwP6oRldFjxOnTxnU+?=
 =?us-ascii?Q?Q1WLgdM+8MRtAPL/PpJUpwTV5ouoUafHFiPzZV+nNY568yejX2gLN3OIsGbF?=
 =?us-ascii?Q?BCToc2qnyx3S581hPwTsAilW3uvo8p7PsCM19nlEz7axrW5JF45ZDBgY2eO0?=
 =?us-ascii?Q?wtz+DnMrtwbRtrI+9hKEq2oaWhQTM7F9dUXC4XPA1dD6IlVjV/vIVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkA+N4Omtu3etpytK/SDVyk6t4ufjoU5Bi0/6w7e1G4O76AucX07lLcDRcm2?=
 =?us-ascii?Q?UeAzlhIqXDP7h4YDOcHJVe1lOLkffyLBxDY/X5EYDxMVZMbIgWqTxmBwjJNY?=
 =?us-ascii?Q?9M7PDL2SC4X/8tAAFMIQD7zUvNI9yKh5gKbTN3/X1SdGJz23WHpD6mtVyC8M?=
 =?us-ascii?Q?W3Xc2OqKhSHz5f5Z6sE9WM8JpdSF3rjeZfPiK5HAcONBGSUzX+Oj3hOUVMhw?=
 =?us-ascii?Q?YJxpJtTCSloQoIHRgRSutL39cl/6XvnxIlzuM0+VofqQYfJcylna8pQ82OEM?=
 =?us-ascii?Q?a6Ko1SEoQcQFm4ZHTpcc6mZGeVzFZnL4BFHoaAfQYWRLhD45xM4V6bYpayzx?=
 =?us-ascii?Q?tW53o4CtH7Sv/08eEXDPLogb30Eh8TUkO5CKE0Ky/ZYoMdLW99v/OzB/Os87?=
 =?us-ascii?Q?vJsrdORU5ICrC5jMYbEowle/TkaUftAP3FRI3aEHUHsuqQJDk9H8fvKy2Plh?=
 =?us-ascii?Q?sHrTyWJTEMEElZ4FUqDBrWa4eFVoikwZGZQS7S8q+G6enBVQQlJefJ9dASZ7?=
 =?us-ascii?Q?S96rxAGBvVM15nUN2MiRZTZ6D3vxApFx1jpxH5zJxzcadKZnpN6k5fPvV93d?=
 =?us-ascii?Q?+3EFUuq0rg5foXmnPHOAxD70mqLga546qDfQ70UGGNWEn8mRtiz+YrmjzmiK?=
 =?us-ascii?Q?6IHop8J6FOsPnBlbrZYgTgHTnJijdQHXrlNuiL1JCd1mYJa+HuqlN2SuFJd7?=
 =?us-ascii?Q?X70pbs6cq9Nik+wkCMnzSjijhF1Ck9Emp3YWB9IuqU9Z5kXiFYPCZKWGh3dJ?=
 =?us-ascii?Q?eeSroagBHP01hSEzwhWzDCDx5DL8ymgf6u9zxeNDlyLfd5aN47G9kQP+laFv?=
 =?us-ascii?Q?4H66iX/wQz9lcr4wd5hN+qOgIS8sKQKqRbwTvGwALVBvrf8xy/DGoHGMW9KR?=
 =?us-ascii?Q?uQeNKFz3f9cD4fUuZPVqSnZD53X8H9b8Ofy08/4O25H8nd2ozrFkWO5g4aP9?=
 =?us-ascii?Q?7OzszvYescr0F/jCmhngbiOZmEiIAXtqh4KeXkII9H8F45KkzlRFpiT68rjd?=
 =?us-ascii?Q?5QxS3Blm2mAxq2PeCKJWLxcFjt6MbC7DgCKLFcLIoGahQupYPA/JbBrh/C41?=
 =?us-ascii?Q?AbKoL1Y+iLXmHaiHnmRM5An6Dsi6ZoIcBE1i5uUHeQFFv2Z+XyjPEv6kQZ1w?=
 =?us-ascii?Q?IMafB1R63gPQAuNlxlvPrtVU7NsSP8IrdCa5EikfE+X2v3d7shcDNK4TIAyV?=
 =?us-ascii?Q?wqsGY7hMVovBgI1c4cUB8luB9r10HaTnZQZrJ4PNshZ1NNtbGsS6iPubTGIS?=
 =?us-ascii?Q?z+ODkGKkndEko13wdP/fr31r4eaZYfBdbPNtbPppsp51+y6RiTyh04u7h9qe?=
 =?us-ascii?Q?lS4WKl5oQTY0j1R2PY1NDp5nhokSxa8bToVLByV86X/TvL3yqweUjr3mzcqk?=
 =?us-ascii?Q?tA2suiZOXUfmysDCyGFrO+1yZMuRo0dcZgPUa9UXoJqCpVkU6TSJDxfVUvQz?=
 =?us-ascii?Q?nuuyreOg9qmFHlR+lnFGJwYnKai2jD4lYdfUCx7wfsXlWBnjogiOfjTIKuHV?=
 =?us-ascii?Q?QvzOuafHJ0CYWxp/Cih7IZ7pdG0VuV/V01PTQao8WyD5RBVM3nGhd6iqMf+k?=
 =?us-ascii?Q?ffOHha6kGQV44uSNam9I+O3snXwT1hYkq5SYUGia?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2cfb78-7065-42fd-a23c-08ddda4e31f8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:45:54.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8eQTQNpsXUkrEopkf9jgGJnRRCVyUxE+3sq08prcRBeLc0D7QCMFWrh8IP0D5RJVEuf3SpwyplLV30AS05nXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF4166F2409

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 lib/test_maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index cb3936595b0d..1433ecc854cb 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3562,7 +3562,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* find: start ->active on value */;
+	/* find: start ->active on value */
 	mas_set(&mas, 1200);
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
-- 
2.34.1


