Return-Path: <linux-kernel+bounces-736180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF1B099C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E450A4811D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F31D47B4;
	Fri, 18 Jul 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvpsTCQM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFB1C5F14
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805817; cv=fail; b=R4aVpntxfVB3hXNVe/FnYbpHqQ8tvXtdhpwFv/DCIkBA1dOUiVLF3gbst16xOgymea11oaB3ys50b9to2CToeHUqpThV5lXIWpVhnTTsJDOOj9MJ2Z2fYR5KnVRFUVx22Jv63m2veNwCruDCYuXPvowFUPdlEMq9FOiaG84tzCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805817; c=relaxed/simple;
	bh=/RPj+VjAsKvhcC0KsLMNimAlAKZ5wv0JS8GnSnumIQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQK9TP1+z4eOlrvi8rkOW9pXS6GiyX5Q6PYDuvTt1PFj/mB12hnZggYt3g6buZOLW5rx7XQV6i2SIqq4W7z7YpE4GgpfW5xU0EKtnGnvjzm8vae/eEkStBr8NM9zfuZxSGx2ZlZzxEQVRrIcwFcs1PZ/1W4yLRcGN4al5VW03w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvpsTCQM; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODErQmLWvSefS9yiAQ6khx3cybhMtpn87Gu5mDN2cd15z27OjI/ZCCEqOqvx3KhHFPuCUzBduEnKmYCWqOI/ZNPu4YFmXiGqIvkbU9Z43nrkRwGhsFU7Zabf9vwFwCo4X2ov6FqnvXnzh82VW0t7P9oHlpC2XIxCDXuV1SMy9I9jaV4up7iqm6YdlYSGTl0Si6u3UyJJcHo3zI9lgsSKes74KbkSPMS395KdcVObirJP2QC9iEJC0ffANXKNTK/TX4MU+bnTQDV5hbBYL+pzxbqax4GWltCcE7iWKFKaRsLRYF9+pfmuMgFXPPRnuXCmNVq8bND7tvL/pF2XhX3wVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpAZTCpYv8UkzzYWrqRdpBMkYGcfQpkVIu4VPemzwSA=;
 b=VNvh/ylJBNwTrb6zW5QyNG6HIbhP/babdeu9kNUiCpiQNO30dsSrGiLzmLNdA/TeDT7ORbUIpFhJBcCU0nWnk/4laEOTIYdSPqMkMqEnRfpxcUwChVsNr6koFyiPG98BYQ9xmdcrAtCoxXOOOkC4/SkEKOqYBKv/hktGLS55i9fn8L8HNTw0r53vRTuP1Vq34ABSRNFoNWKB2lYGwfJSiuBL/bp7L3xgXSE+2kU+yPpatidQ0uTdpymNakRkRzp7/TPlfAiNQYjGkzOFiXwPUzzVuzsjbGf00AZ2i6Pnjs4vthFWmQbG5u6Lr7gmiPefA9cWyvbpmPC+/ak1Jp+TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpAZTCpYv8UkzzYWrqRdpBMkYGcfQpkVIu4VPemzwSA=;
 b=OvpsTCQM+97fO/wbIDN6Oy/iIQHtpWjjfMQ1A5eRevgpMcvOVnKTmfQkMI0TURD1Fjii6/ZFyPy02ijRqR7C5oriAAoxEY/HJWIS4aKZJZMaythkijEGlqtetOJQs49jiHqMwZKOUNRQ2gbO2ZQicwbbOcpGt9jqciyC5EYvux0Jd0RYsRtU3k9dJzDhkdSreS+5eHuLa2dH4xs09mfkEAX4XtecVYUR75gtED28dDWfaRgk+l3ejoIwhr/7IL6AbslN0Qz1h5PdSINv9IVon8CMwAz4Y0kFoskQse0pnos4OMKRWolZsVG/rR9Z/DGUSOdYxodCDdz934QwwQrwXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] mm/huge_memory: remove after_split label in __split_unmapped_folio().
Date: Thu, 17 Jul 2025 22:29:56 -0400
Message-ID: <20250718023000.4044406-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:208:238::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a540b10-ded7-4d77-e3da-08ddc5a30570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?St5mYxgFPH0RUi9v+gh02FSDkD1GU0Py7Cn8K0j2yih7xeFOEOaua0IwwyV+?=
 =?us-ascii?Q?Kzq3dDgT+PyYQsS6Nl2DK8qD4DW12pwDjdZleDOBndIR+bpZLp7c1dTXjbGD?=
 =?us-ascii?Q?vkiC3jBTFC1URzw6EaMm3aZdSXsvaStRwzuMSe09vfuE9ePNXBmxDswgN+Ek?=
 =?us-ascii?Q?dR2Dadc0PfCPd/CCnrjowp6+YE6QZo3mGJcMB2ApAewEijpjrU3Hv/MP9XZE?=
 =?us-ascii?Q?Wg3JyBIBAFzfhPwbB0eulfaFZM42pH0rdriW1GblYBwufTU97SlO5tAW2Fxm?=
 =?us-ascii?Q?O3Mr4a+Ff9VODfUapBoxDfAZUeY4rx1z5lMCh8LHhTc65YKJ9tIwifJsz4tX?=
 =?us-ascii?Q?OfONgdAQKH2kgk2lxK2wvq5W2hRDU1ngJfMXfSXlrSRdwnm8X8Kwk5gV2UmT?=
 =?us-ascii?Q?d9RGJWFVkNzdcQqKKwawjYvcT3q9BCxuHHdfQ/RNO8YILLNksVofUttLV2Sg?=
 =?us-ascii?Q?uwyxwnMeeV1eSSUJex/7UsmIpd1b1nHw1GqAeYR+rLmZjqRuzNUkIojr4t8/?=
 =?us-ascii?Q?Y3coNFHDoz2VzwOLF9IQu/NjMifUUPKB7HhDj8OdirGuJnY6/X/06d+GCerg?=
 =?us-ascii?Q?lNFC7+qKyWbZDxN03fym5wbsrlm8RUeoY58/lS5N1PCXlv5xq7yHVsDk5BfK?=
 =?us-ascii?Q?rzPJmE10Adi4rQwtoKRywVIEn1FEnZlKRW91Hu+buG+y1vT05Mo6g/ghuVkS?=
 =?us-ascii?Q?EEXelncT3ZvgDtdpsHmJr6Vw2l+QoxQHkOU5jPJZu8xeIQvgBehi0A4o0VTB?=
 =?us-ascii?Q?WHVrDZWk7F6K6dCzqhmkjit0y0+iuS/xc6QnVKNYYTtdaNY7l+qT5Llhx8rv?=
 =?us-ascii?Q?3sROajCfwM03dPkOHh99OKYDteM8WNa5ifHfyXgRV6PjcrABvEPqGRBKGlVv?=
 =?us-ascii?Q?n8R5edyt/UgpPH6JbcBCshyxP49/Xb0KfhKRkjrjDyhEOoxrv15TvoYPvJxe?=
 =?us-ascii?Q?50xQEFknwqAAVXwZ+gwbigNE/7ppj+eyndhtVn1OoG4AB7V25NuaKHMuDMwa?=
 =?us-ascii?Q?ECZ641sqjEvOrEa+vNsJGv88QIgR79egz+PELwqSjVCQuefkx3ZDfHY5MESI?=
 =?us-ascii?Q?QwYljnU7ePfgvB46xyYX9p2chMnPBMqp56T4NPSkVN210kHVb6ZvliSSf2Qe?=
 =?us-ascii?Q?VF2oRWaxviydhZs4p7Zp5UIaIfN0UZkwjVXoN0yx02xlF+Vznk9i9rmWOGxt?=
 =?us-ascii?Q?wSuR4hUGkg2NwM5A8iHECbjsOdYTw5EeIBHww66SawVZGDPFv2YqecBbrtLI?=
 =?us-ascii?Q?1X1HwNHkqJS2BJCoJ5fZjTJaZ5lcj8xsvcnsiy4OK4EELXQxrf1fKEQ4CWim?=
 =?us-ascii?Q?I3XI0lxv+hD/nQ3147aortlOeqSqUeqE1xe2stMzikNdT1YguQ7dLdYZnk8C?=
 =?us-ascii?Q?DCnaJVA5vS5cQpxyMqQDrcXzGBZyOnfqYrvRW1sYxmkUyyKEgJiMCPYDxy5B?=
 =?us-ascii?Q?8cmAmbGx4xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2PMjWHttEXKrOnfZkEIbWLImEaC1KCKRUISzHJcfKnBzbf7NZ0iqCdwR4Vv?=
 =?us-ascii?Q?/nlKurgVBCIwcMdXsMH0Noc+faPkjPPQhV/RtJM++9jdKGXpnFBe6iczG4CX?=
 =?us-ascii?Q?VfDK+vVDtbE5EqkLK+0iSSse6iSbB9CKOxTB9dL8qBWslZL5LCNZbxa9Pj7U?=
 =?us-ascii?Q?J4BlLAEvL0+Tqj2fuwrek6AU7txkKLqsbBFFZQoSdGYiD8ajuS0mjcAvbTnr?=
 =?us-ascii?Q?P6rkHN8Fh11QLP0210AAnEguNlHRrUULNp5eWWaYPDlZETM+dWg+1q/5WImQ?=
 =?us-ascii?Q?ULeEORM90G8YqSwZY+0fxBOu33Cyd+6II80EGbyGprmGsHatgLyP1ygrDy0G?=
 =?us-ascii?Q?9ZYflBzrLro5LDP+8i6PHjsm1FJ6GjQY5AOatnRqrbBAZMhDKfPLXez+BiRn?=
 =?us-ascii?Q?7I0I/PWMkVA/2YhSEWeLIpjvEYjhw7IoiGzzvYl04OuB8lnwMYrt1WfFcKoo?=
 =?us-ascii?Q?9Fe1JM5Ntct3XIbl7ST/KsNoHdrqGG1b5F79u8bm9bXLtokmSWJbYOBYNrd1?=
 =?us-ascii?Q?vYoHfc3B4d7wWE+fExUgkHiShRMWOrEXxvv7Sx4GntoycWhjfOcG0hdJHkTp?=
 =?us-ascii?Q?1yRSLdb7jkInTbqXESwX0Oc6VuUtCzqXB9n0ZlxxFzS+P45NuR1IomvJ/JpI?=
 =?us-ascii?Q?aJiEw+aleosEQ/ixFDE56h9vW4V2l98MCV9b1cpYHurUJL1ylb2goVNe9hRe?=
 =?us-ascii?Q?9mScfUzViKioyjAUxxDHc+7Hesl6PFs7kh5L5ZjGOSwUOIWARPAePRTyzWtb?=
 =?us-ascii?Q?5PsceriwR7Cp1RwLSioOiAnfbsqAFT47tjYqQRA6EEzK+UtIifhAqsM+nHBB?=
 =?us-ascii?Q?ifW2ROITEmN00RnOY6V2qXJrVn8qopr3qXOKnFxp2r1vsEPw2AgjVNdx/wQK?=
 =?us-ascii?Q?rlHqRHPN3m9PBVee97HKmAR6jsjILuM0OFHmPzJyRZQBvFMSnZGDecFw7Fbw?=
 =?us-ascii?Q?O7lrEPN7OouuUf/wHgX4PfcbXuBZ9x9Dqg4O9N7eH9zTsJtpirrgeO/UA0V3?=
 =?us-ascii?Q?bDmXY4LZxcl2mtIbWbJhkaY9Bb6lcV6dGQpeE//KO6y1+PpcjL19WV/tBG9B?=
 =?us-ascii?Q?FBUI8nhMmaZeN6QADKWOVXGXYhXXXh94kvQkmdQWh58pTCkpQGLA6obrhDDl?=
 =?us-ascii?Q?oPhq6NgDeMZ6Ks7+tF4UncZVCrpK9cKe/cajg+Sr+wMz6rbuclsGtWAGg83f?=
 =?us-ascii?Q?BSIlk7MHJEdH2jBHyQNDlCtRDr9NKXLggueekmSci9EHNRsTznQPgH7FyIjt?=
 =?us-ascii?Q?OiAkU5oKYo6s7bxNiDm1m59B8ow7/ssp3zdgfgmbYQ/kCjhfqudotF3TEFZC?=
 =?us-ascii?Q?+6KvAHjBfM+uabRzo9khQPxk49ua4CS8TZHLhTFx5URyYWu81J7obxPkB2Xi?=
 =?us-ascii?Q?z7D+QQlbnWIl48u0qa7zOgdj6onEdFKhh0mgiwTLPafuLm1SwL836ZZ9wTDr?=
 =?us-ascii?Q?2Rqc3mgrI+wFxRlfanNzDSGmYh+L8bll34c+d0K9zJLj91GZ9ifJUzapDkd+?=
 =?us-ascii?Q?WCrJhtXjVSOyqLA1/unTLXiN+QMm1u0MN60Padeyc/vrBbRPZ9CjD1XkKddE?=
 =?us-ascii?Q?votXkMjwa5hJkHizPzRihIkChW80DCsG24jA5oXw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a540b10-ded7-4d77-e3da-08ddc5a30570
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:11.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBFPJ0g8KIi8aKRGWr2tvj0D9VGjjNVd2PSN/9YolYHUWgR6dLQm9lYBkAiR8Urh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Checking stop_split instead to avoid the goto statement.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63eebca07628..e01359008b13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3463,18 +3463,18 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 				if (xas_error(xas)) {
 					ret = xas_error(xas);
 					stop_split = true;
-					goto after_split;
 				}
 			}
 		}
 
-		folio_split_memcg_refs(folio, old_order, split_order);
-		split_page_owner(&folio->page, old_order, split_order);
-		pgalloc_tag_split(folio, old_order, split_order);
+		if (!stop_split) {
+			folio_split_memcg_refs(folio, old_order, split_order);
+			split_page_owner(&folio->page, old_order, split_order);
+			pgalloc_tag_split(folio, old_order, split_order);
 
-		__split_folio_to_order(folio, old_order, split_order);
+			__split_folio_to_order(folio, old_order, split_order);
+		}
 
-after_split:
 		/*
 		 * Iterate through after-split folios and update folio stats.
 		 * But in buddy allocator like split, the folio
-- 
2.47.2


