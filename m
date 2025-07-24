Return-Path: <linux-kernel+bounces-743880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE5B104F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4DA178D78
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093082857EC;
	Thu, 24 Jul 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D7drhvkq"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012025.outbound.protection.outlook.com [52.101.126.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AD27280A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346781; cv=fail; b=czgDq8UWjtPsTrATWlun6/zgiM14Tsnc6NgM+zfvPIdX6UFQdSTPbSPhJ2fBjGsyk6vXvFaV3PNvaALEJE4YqQQfoaCIHq/y1cI+jMMY4kCl0n22iQ94eoTkEwvFPTN1sAl89le3SOEpRYwmMoftxjhblytDvSQji6ioJlRqQ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346781; c=relaxed/simple;
	bh=I6tH6qkHHhyHMLaeMCE4V4vi2piyxnG3gqNNWHo4UNw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWpdsRqLkyHL9DA+O6NHlZinWHJZxvzW4H/qCwXdrIomOrMYfuM8/RkCkoc2USChbr67wdNVBoz3UqM8c6VLpjZGQS+NEhnnOXkhGAejEPpULvuCy3GZHVJrI1E+iAQphHEMtMGROtp0ewQmcERV+43/LQuGnv9Xpv2+toms6/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D7drhvkq; arc=fail smtp.client-ip=52.101.126.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPXhluA6rOleEIVv+/7OEoOhbiZArW3W6DbqQeagxAMVKdmFSh4hquavbU5gBoiK335BL1iVJGLOuKzqgPZb/BP53Cx9S/YW3+2LakruCENmRgbB4KCU9oqmOFliNu+iJRcp3uKT5SFUfNxz+/HbBA1nKHrtbKHKGLZAh364jaX/BPCY+uCKFp2xBHvFIsKR5ZR6Vj6uNJF5VGXKWLzsWyrOUu/FonpVYNll/lAAFthtIfPK9v59UOtwumkSuho/d+48HzRts+dOx8drIqs3Xy4RuNj1zqfOs4V8qq86O+mq/yx5QuG0VhpTnySdm3W6GDhtsNv1hqjGVOTbAOxrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5wtyTBDpuAGN8oAcnPrIIqyr32bmkuPgplcfTwT3i8=;
 b=nXcb0FGKZKRd2AZ7nYS1xvfFgySUYuLT1f197UyjPycdYX8c0PKHQQuW5UWKIqnEPawOPvf8oeIXwQQ2JMqsbdCUAVP0sxrpShGUqIEx55qosY4zo8Y6yj7HVytZhUKBZahoSXc1OF/Ghqamp6DGGO8zMQkNoGTTwB3/cGWW6bhsKX6l1bzKfLuBGM5XfhBWUfQAWrgHjCG6zYvEaVhZc+qFNWPgLM8CBn+X9mTQr+Qi1WnRUfZVy5RyPBp2nBwkWYGihHDFLnFhBKoLvmeUoIocrACVu+br72LcjZXVnvb/+Luv6ZGVEWQqp2tsr9oh4GuHbvBG49l5CCQLP2I6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5wtyTBDpuAGN8oAcnPrIIqyr32bmkuPgplcfTwT3i8=;
 b=D7drhvkqCIIZkEFPZK8gQ3ZWMZMfrgBQvD5tEJqOkUm2GP63Pc4agK/czJkoH/e7e4xO8g3/in36zEdKi7pKdg4ldNZqHT3Gdes43li1YhH3Ml9nOaeGPknigH9OkqwlVoT0z3IJH90h8poCWEnHnKUVMYJnnbqLZW7v0WzBlqBxj0O+ItzlsYm9A5/gDManrfWjdtf46A0JLLUHzmN3Hg+bGeWpkeQT5QfsRJ6CwG8f7UuQrGdp+22VlbTy/rSQOEOnbKIbwPWvCvBU/npl3UhHmTrOhJa3ziq0HA3m0Uxyf1V334345peBqqnek1p+VTdQMA8ZzxARKIyoG9Njog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:46:15 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 08:46:15 +0000
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Huan Yang <link@vivo.com>,
	Christian Brauner <brauner@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC PATCH 6/9] mm/rmap: introduce migrate_walk_arg
Date: Thu, 24 Jul 2025 16:44:34 +0800
Message-Id: <20250724084441.380404-7-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724084441.380404-1-link@vivo.com>
References: <20250724084441.380404-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PS1PPF2A261C07C:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dbd8e8-d89b-47e1-a113-08ddca8e8ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHjnWUn5RMeGaYlqsmjPsnxKivWCEQIXlsrjz8CJmF8CSmyDZyfN2pFt8Urn?=
 =?us-ascii?Q?GhrBVuORj2554GGjIBWdHYSN8GhoGS7QfIgtu5Z2lCQgyMUnPI+J199Bjn9E?=
 =?us-ascii?Q?qeXixvS0M1dEKEhhCXu5LT5Yc+TCso96bYwnGuqoTfC2OwqUa/qncGR1DXvR?=
 =?us-ascii?Q?IvHSUi/s6iV7aAdUIwGIwawgOAeh7vSA/VCNMl31OGa7Jfr3wNRsz4+d2bDC?=
 =?us-ascii?Q?23pNhVhML+nMlsu9KFomd3Ok8Bvn+GDESl+xEnfbv/T9A2kZeGS/Dsh/NQEo?=
 =?us-ascii?Q?4GZPoGSxCWrAL18nouWkcNvsUhqDFbGwbWr+sm27Bk/otWGTVDcsGn9lLczB?=
 =?us-ascii?Q?IOYXu8VHWUHqkXmTIxTNUKtHyzE5dzjySGFBeA33IIa68DXzQnoIYkKetnMC?=
 =?us-ascii?Q?uD4Od4avXYajzHs65UFlKQND4UcCkDsCmcwBsYpwrZG3hIDf6oJlwF1+y3FH?=
 =?us-ascii?Q?5Sk1iJKIVPLGx/9yJ9K1p40xogRoIl1LCgbuenTJvZ3BCMRZa2proLVIuMjE?=
 =?us-ascii?Q?rsuiZgYbdL8slsEV+yEotTdO7KhTQfsBkKSG8OzDH37BYJd+RxLXACbk7CDv?=
 =?us-ascii?Q?BHBIOJ6J/1HZ1uplgg1KSPKhvwLryyAhPElgwU0FP48y54ZRxSISZeWSyv8L?=
 =?us-ascii?Q?xo7AMhznRE9swORImJwsDlSlOPfp+clbgnHU0iOZ+HKtjBEgK14oD8rMLHOX?=
 =?us-ascii?Q?Q8PnUbtRE5pyK33bm9Z/T4D3Tls0Yh++q79YCXHSoqTGZxIE+ENHESMNft50?=
 =?us-ascii?Q?yeuWbeqXkci9gJcLbZQaesPgofjXq/oYthiTRJj/ct/t0e2AS+62qaD4cJwg?=
 =?us-ascii?Q?tgA8/zv6bugvjrVNNZSi4llj18vfcWQv4PQtPRn1MxG+b/js/JFjKlh7qT7T?=
 =?us-ascii?Q?PZxDwScH9vT3Z0DJugzDXK42DYow73UqcKdT7kM987lOCuH9sprwy2Kai4j1?=
 =?us-ascii?Q?qF6zmmih/9uguRWIFZ7/yFjiRpfCP3hH8zTRmIUbyH+0JQfDSuY/T6S45rzU?=
 =?us-ascii?Q?pZI+6J4V7dqv6hLcpW108kc5iC/1Np2lG1CGApr47sd1xjacpY0t5JYrMTSZ?=
 =?us-ascii?Q?GXi4OO+HyZFKBbqH4ei4TEfop24U0Un2BlEc6L/KxaHl63VEQS+L4wB+TLqp?=
 =?us-ascii?Q?JNKZm5qF3CDx6ipcujizWXGUzKSZpbBDRyuC0O3jWSAI+3CAlSgPDCrRIUsE?=
 =?us-ascii?Q?zZqtdp38c6widQAalSw7LhszlJdWX/sj3QAvED1RpyiaMi0TKgInmQGDkQzI?=
 =?us-ascii?Q?98BL7Ds32WKJKMM/vjfgPXp/nS53EGXFJBUuDlOzrYUA3zqe638/CAhQBoRz?=
 =?us-ascii?Q?HcaAay+WBYSHnQCyzy8rKd250/lz8AMmv3xCMTj5mV3y97wO6ukbwBP+qAsF?=
 =?us-ascii?Q?wufS2ZYkqOwAFapKz+Qlp4/7GCtuyqjyJ9bpqQCX4dZq6BhADlTA51tmlXa2?=
 =?us-ascii?Q?3yIyBtasi0iVjGptoiwx6pnx/Y2+R9VYfXYCvk8Wd3p60u2KYZTrqRAcaQii?=
 =?us-ascii?Q?oKvEi+oxU5dMTsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQo4rC/Trp63SJ2iQlUX26W6+cCUJhhkp6VSiXEycQKn3k70ODIvxuZ8yBvE?=
 =?us-ascii?Q?uMW4aRtCjwf819IOlqO6+dKla6tt3peNLVW9OlokBXBJMrQk4shHEyyVq4LK?=
 =?us-ascii?Q?JkI0hLiNEvHwiPZYjMPK+m++7otFuXFt2kfBpTT24eKLWT0yLzzZ2EIHPM0d?=
 =?us-ascii?Q?sQ9iM6tJaYrqtHAyEKTKxID5bNtHWYlLWz/ewN0/b3DaVoUPKFr4o7MCCUJi?=
 =?us-ascii?Q?yqX5Y8Q1qXL2xrH1PhHGRnfETo+M/K1F/Ku/AYOpsPHVdzqXH9noSzb4MDXM?=
 =?us-ascii?Q?m9BjcV268Lsjy9ELZ2bGbXv+JbpjT17O3zCFAwRVaEdccjZiejFcXRDchtcb?=
 =?us-ascii?Q?CDZymzDERpbVAxKkTbldM/1lzTeIMSuXDYf5GgoTkVoTqqGrK2hIAFrk/eKa?=
 =?us-ascii?Q?cF1LJE+UX1GftCX87KfhRVCNIjE14bkQATVxT7pSrc7zkG5XlMgssmfoLK+L?=
 =?us-ascii?Q?DMKFVNdsvaNxizu9YWMp5ObG5kMEZuhPyl7zxYanxLxoDtBejNxvys4m4Vuj?=
 =?us-ascii?Q?s1CS1XMegLXYNc10KV6x8OwNWT9a5zoRaecq3GUwMjSq6dsr0OP4TpGvL3Np?=
 =?us-ascii?Q?BRBY/a+vzmvjQ2JeqRd23Txl9F7SDzVlBcHxnQEIBmLH6zZqMHTuum3cQLjy?=
 =?us-ascii?Q?PoRjc0vrjfQZqyrzvz8zSI1mV0Epe4nBeMa82Em9d79Y8qzEkSsLzgTwLV4z?=
 =?us-ascii?Q?5X4ix9CG5y9QR8NJokkqazZvyUR0zZyewdrJGq/rl3kQuE5Thiq/iqTbwunG?=
 =?us-ascii?Q?LpN4mDs65QdcpibY21Xy86VxsihAfOi9r2La80voeDlJXUTSPJU8moJJjD01?=
 =?us-ascii?Q?VEaprN3VgxghT2+TbLYgs9m97V/VyGcrqcLYV1RxEIbNKRSm3kpF3kiYDTE7?=
 =?us-ascii?Q?NIaROIrl+uJDgww/POjTNPkXAFnzQO2sL7rQvvJuWlGytNk+lv/EogwmJzoA?=
 =?us-ascii?Q?tXIkYThISC+EeVvfnAEXIEeGoJTO2GDRIesuirP9SCXu/v+hVtdzma0XWTyt?=
 =?us-ascii?Q?ACbhz4rHHUjISFtCBgCOpISh2z+MPBQD3aE5wCsCSOUIDfU5HThjI5tFtZPg?=
 =?us-ascii?Q?K0WW4LlL23A/sfbXqK5lXGtilgh5k85kTx1BQ91tysud5fNj5EOfjFgyZ5uD?=
 =?us-ascii?Q?uoBRRBRe3NT/kgKavh9Z6QE9YpC0Eylz5Pvf40LDyq4qVNUPUp9NzT3PIyl3?=
 =?us-ascii?Q?Dy0RyVpcVVDzvcEudkxR7ITfbttz9uo2GJA5l7X0adBxS3edtX4/meDsFKOG?=
 =?us-ascii?Q?5vSmCFltSdjNDBS9udynv+NHGVYn1pNBBEM4ieEHP57ETa5XJ8PihGhMdSH+?=
 =?us-ascii?Q?bm7B+bWuKaq193zhaVS3AtAdQ3LD4ZPBYRlv5cfXwI1xkMMV8MXB3WnDGDK/?=
 =?us-ascii?Q?0PBluIEAEIj2eoHK1IVTmTw7ajELXHEoSpaIkS30rE8r5tCUhlWnWdbsgzCu?=
 =?us-ascii?Q?abtpB2vlkp5Gvm/xwlVJf4kJZCEm893ic98EBl1tbgyEG+VqMQrLIjsM709J?=
 =?us-ascii?Q?Ff84JnyMxnulyiVt+CM+gmwfdEw8RYzo3l6t9e6/vJ5GAzstlTLUUz88A0WM?=
 =?us-ascii?Q?cpGNEqc6+r/oRKIXHa3oOd1MlTrS82thKPcXO15o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbd8e8-d89b-47e1-a113-08ddca8e8ca3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:46:15.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bmh0JuZiUiUeb6p/W7hO2rsnxDnHWo5jizMgg62toXVINuZ9KbIY+hQ+5erdMuCYwJCl0JmfrCCXYcO2RmvqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C

In try_to_migrate, rmap_one as well as the done and exit hooks may
require more information from try_to_migrate to assist in performing
migration-related operations.

This patch introduces a new migrate_walk_arg structure to serve as
the arg parameter for rmap_walk_control in try_to_migrate.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/rmap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 66b48ab192f5..2433e12c131d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2261,6 +2261,10 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
 	rmap_walk(folio, &rwc);
 }
 
+struct migrate_walk_arg {
+	enum ttu_flags flags;
+};
+
 /*
  * @arg: enum ttu_flags will be passed to this argument.
  *
@@ -2276,7 +2280,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	pte_t pteval;
 	struct page *subpage;
 	struct mmu_notifier_range range;
-	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	struct migrate_walk_arg *mwa = (struct migrate_walk_arg *)arg;
+	enum ttu_flags flags = mwa->flags;
 	unsigned long pfn;
 	unsigned long hsz = 0;
 
@@ -2575,9 +2580,13 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
  */
 void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 {
+	struct migrate_walk_arg arg = {
+		.flags = flags,
+	};
+
 	struct rmap_walk_control rwc = {
 		.rmap_one = try_to_migrate_one,
-		.arg = (void *)flags,
+		.arg = (void *)&arg,
 		.done = folio_not_mapped,
 		.locked = flags & TTU_RMAP_LOCKED,
 		.anon_lock = folio_lock_anon_vma_read,
-- 
2.34.1


