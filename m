Return-Path: <linux-kernel+bounces-736183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884CB099C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72C01C4369C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA061E1A3D;
	Fri, 18 Jul 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="scjscGpf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA21DB54C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805822; cv=fail; b=DnMJ95PtN6bgkJG9SVnErOIeq5dFK9LZC9xwQ3GWu6CU59tM6Per31jlTQcksaztkgIDiQ3EM9INyGixT0E9uzYLIFr/8JGVEqVULVDfvtHAakkkK4oY1EyEOqVrHVdVewE5sy6zT8HhcDkNyOTl5fuAy9D0FI+YBL0vkmYkYcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805822; c=relaxed/simple;
	bh=aDVjL6HmjfVmYts9JIEDa+GF1jyAcfZDulZKqhArZtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+EU5UGeshFJ2H9w+iT4ugfCgC741Quu1rK86RQSH6KTwl8yfB5Y2cZjz1vOO3vSUUv6vO70o38vrF/cQJs1XwRksVFeVpFp/sETsmZT+VlZYyr58C2cPCingtexCsvOd/krUB9q1qRhgG/qWUB4+Ba3OqDTxCwD56DT0EYfuqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=scjscGpf; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA62JYxi/PIKYM3OZadRwcbg/ZUbgEXLeLew6p5PsrKFgSZlW3paWfsHR1lYMgZP5Iz/+ZaRiTPI5jPOiD4twyAAfjsi7iPff1MXgk1nhZthvKR5lu6GSUtxCILJfuZhlCk7prGmNOXlRJc/ytKgBpBSWZhMXvefEcaokBa945UCVbuUs4U9kP/paYm8cUj/j8/gIcpraPqpLJWJ3nb97pNcDk/i8SYFJLKno87l7M7YXRREqZryHgxoRPuoesb2GEP0qs7CvRHQOhTckTHcDecvYU19Yvv/brddgFLLQ+4FT2lukljjVsLfAFUA0M7S565ul/jELMFkvePyy7T1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StO/GyGqr0tgAmqrJOOwBQstPMqGzWFSG01C/Em4QKE=;
 b=YaIScnL4G+swTANxJIW0lT+658u+bYjyAoP9JuGYDMlkIJWNRg5YoXX/LOWa0WQ155yv74c7GHgqNsQba+McFYEMjW5rTC39EZ59quhkRmM8nOg8BrBOza7BlxMrCofMG4hvmeEiNL1SobJL2yY+JPsw0o6HiMGuH16Lq89ZQgv9GumiNsSZiT4G3XBKvlJvN74o4hFXLnTQzVJX3yhmn0qU//nZdUl40tjG2i/70pGy64yUcmr8tqsVAbZz2RKNBmM4hD8UKRxojSZluE0COg73hDPPxb160f4iKxFh5BNAAwszF8BXK0TOINv9tI8OmfgPNc+3bXB7im+1Xh40yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StO/GyGqr0tgAmqrJOOwBQstPMqGzWFSG01C/Em4QKE=;
 b=scjscGpfxr0EcShSDxnPTfxvybXkanEv1GeJlhZ2imLirejNJStN/qwVThsUmBgdtZ4AL/dlSg/thyB5ncrU4g2Hh4M4GAQSdMvfX8XkG9YEkMKABMgGMtse7Ym4GIHh2nBf7Y98aGwTEWjiJjkN9hEa+msQRWiQxIaGt8rRS2n5VBLdgBdiiFo0+nwfDCKyKOUXx/faN87+4LqUgC56NkkpAPhp1juFdeh7fQkhcPZLd+CgNEoNPh0aVss58/9sQPgxS37hHFDYssK5gKw88Va+F1U0PPJXHexY6R7cxzZ5Tgt4MQR7EhrtgUBdZplZBokgH4BF2c98QGzVl9se1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:16 +0000
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
Subject: [PATCH v4 5/6] mm/huge_memory: get frozen folio refcount with folio_expected_ref_count()
Date: Thu, 17 Jul 2025 22:29:59 -0400
Message-ID: <20250718023000.4044406-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 414d551a-4d04-4df6-07aa-08ddc5a3080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z92jP8DkzelE8NvmVhLLRRZ216ac2JPwq4Cg9TUneI86c/JdQGjFWxVdo15d?=
 =?us-ascii?Q?cGyQVCcwddceCTtd1IW/NA0KbiEFU9rlAPcEvqWq+CjcHqj38AK/06L6qGFc?=
 =?us-ascii?Q?0ZQydKNDotvP/K+/4fkp1tlReb9QqLW0OLgcDCKg8FNrXBf+gqI5FSNIwOeq?=
 =?us-ascii?Q?W/DWVO4Rtq/JQx0ND5wfSRy9c95T+sFxpvpdnp4QjQvo9PheGwPwMHUJ/AKe?=
 =?us-ascii?Q?MnPiLDsgFGxo6dw8/ufzkAdCMh0sWZWYKdx2bBktjaebW4zrPWH6nJ4HzalN?=
 =?us-ascii?Q?Uu8u/WnsGDkNXJgR5bon0fLClr8Wa+WwyshD4Zw2a5BNjJdOtAnuF5AgLZWm?=
 =?us-ascii?Q?BkLK6+ZlEeZLO4MdT37rx+8I+vOA4NlOgQiXNN3I7pDK5XstQgejEYEtkabE?=
 =?us-ascii?Q?vgGf787watASB6591NWL+SrCITkOO99TYaoiyGBmXDMGaIyu5lOeoVOUk97n?=
 =?us-ascii?Q?yiWYtSlyptk2iivKBRyosBcJhX7D+Iifgf0Ay1Pr6qWPkhdmr53Br36Ncv8p?=
 =?us-ascii?Q?7K6Lp4AyI2/LpDMfMBlURI95ILCPPc0t7EwXDBjikOzRBKUwU6ftnBKsomAz?=
 =?us-ascii?Q?UHmLmWdI28vlv4sU1H9hUbcdHUdVkHKqrWRDEcfiRG1tUcmQoYowJqeUcqlT?=
 =?us-ascii?Q?SoLlZP/a0oYxRgUNSQGv0HK/pGmtEodFfygX0wKhs35J+s8CsaZfDg/JA0ME?=
 =?us-ascii?Q?ioK0srCQ9XJyRopMeiPVOHn3dw+mlBWccxgmU0tgbwdAcPRq7POn1ENsv6qo?=
 =?us-ascii?Q?JTkpTQs4V6wbdOqMEs5go6tLQyydw+FK4McXok+apivqK69xXQ5Rgk6QxhSa?=
 =?us-ascii?Q?uoCVN5U1HsDAuy9IANVDcdWpk9ubuq85NpI3pcCWGbgoa3cqP/S5cEqEgA8R?=
 =?us-ascii?Q?6Tfpy8i/JUFbea8HokClSyr6o6y3RxVEJya3xYBnNHEjzPR61ioWaDd/7g8f?=
 =?us-ascii?Q?U8/vqD0qq3GqyAZ91SJYjn3qvrTPpecc9p/xyjlWKv4mZEkIbR8pcASwHNEV?=
 =?us-ascii?Q?mdDuPNtbfHrTS/mutssPqJyFKXGqy6pYh8fnXUZjRh5GQMgZGUoxo9/+9jO5?=
 =?us-ascii?Q?FBB19BEMEXMwPZladQ6GbJ7AdVmKCyVQ0acE9tnSDXAqmhcOpCgsLw4HxxSd?=
 =?us-ascii?Q?UPrVrvzf1HdClHszrVDctNltxDXPJ8Tr05NfTHO9F/DYi9IxqKDffcGI9IP3?=
 =?us-ascii?Q?6fL21ksEkPwQRbn+8fKMaFiDR2Yzh/zKHwCd4+NCksqlTfJtdPY4S+i4InS0?=
 =?us-ascii?Q?QsojrF6Kz3PPFcmqEjEeZvm5xYuliuJLfLBPjuDWO4e4CS/cpl6S22Es+LWe?=
 =?us-ascii?Q?vRhMLmH9ER3g0zkt9jwhuiwWBQ+5+4KntU8asRvyv9fgOviocRgXct0ie1WL?=
 =?us-ascii?Q?Uvuer96pnid1+Ja45nAgEBoJpojj9RKExP6SRx2x6cOU9h9VfU0JacAtrJXz?=
 =?us-ascii?Q?hvgk2YpmMqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?day7Xl7nhi58Q1jOAKIwgmw1UfwmRXL9Ki6wnxw3k5BXrSNNDGPnkMyAey8+?=
 =?us-ascii?Q?Og9IHvXYep8+xZd+Kr4Y0Unq0nMhW1HG1JCbq0dV9RLL8RCYEJS+PRzdymvu?=
 =?us-ascii?Q?i27rID/5zur2/X9YC14cRpb3va/vfJeCibv3j/sUMLGeSyFM1cHofB/RPDJ1?=
 =?us-ascii?Q?ykxFQyliZZ8yfm+na3WVAbMjJ5uMohlDobMVwTWVnU8kItVflQP2gJPemJuE?=
 =?us-ascii?Q?L9WZ8S/TBoBAcUs68y6SGS6XQcKntsJHgwb8Oa3jx2Tavu6IriHI1Ku7/KXg?=
 =?us-ascii?Q?orPW7BbQErUZZWBNA2bWyz4pW8hrLxbgzJQTuBbhobCOzG8PwfA/7+FNiN6O?=
 =?us-ascii?Q?moObPjn3G2MwoLYJ6ZkBaTlmHIVnN0pVMmO3R9Vme9iLoHukZY3ZMvu3chI0?=
 =?us-ascii?Q?iTnu+3mWqeXPyBz+hLA0bmhCT45WQdgztvE4VOIWMXMPiihrywFQajyfCvxv?=
 =?us-ascii?Q?msCDuF7kNPc5jAVzdFibIl3Ze5P3D8lHc5xzduV+CzP5wuZ63t7rxAk3eZQ8?=
 =?us-ascii?Q?RcXtRI8cdzKod/0HWXpVY9G2ekcQdiN61ZMWYeDT8Wbw4zG0zN2gAMlYHpXR?=
 =?us-ascii?Q?ESaCe3BSmmEY3fUk/O6RJ5nhwlAeGtewFfXn1RgQvhHYszu76v5C0DIsuJpJ?=
 =?us-ascii?Q?WZKRkwSx5XT+jOx4wdDn+6Vgl5l89x1PaOtrv0AaOAwxa0dIYj0YfG1j/OHx?=
 =?us-ascii?Q?Xu1oF0c7skgByGpvC03tLVQVgTxZ/HU73GTDY1yRQ6UyfgKeP8GSwopAxP7e?=
 =?us-ascii?Q?UdyGp9l3NIo12qP3WXhsgBi3CQOhc5Wg7E0RP/zSkQSY8liDij+mIuUyShtA?=
 =?us-ascii?Q?vPaDLhRujJtGARWjrM4Rv6oqxwDqtHqjRw3Kq7HsQcMTbyiL34Desg6WQEK3?=
 =?us-ascii?Q?SYjDGwZudsf2uwh8zirI6BQB2InX3OOPe68gCFk8Xc4zJ3rLtZA7eJWZkHuJ?=
 =?us-ascii?Q?SBkHh/1pfSm2Le2ATndVuuZ6tYAZAEhnmi5g/FwW1RPPcmCiZqQZKvqJY4iP?=
 =?us-ascii?Q?I5QqYG7fPsjGGl5p79uY2e5jEBIoPVt9TnhxIWntiN03Pl9YNDL8iW7YOWrU?=
 =?us-ascii?Q?+as9G8wFPQLnS5rryu2UuN4u38e09gICG2gQ73WCLXnCGwIlX/6TZVLrNe+g?=
 =?us-ascii?Q?TOtLC1bwHJLl0uMOXCPSGGYxVnA3V/1YsEOHH+mt+wIw+rfcep2lkvdQXzGj?=
 =?us-ascii?Q?SLsUoL4DYkNKzKIuDGKy34D0ZLZ9KZ04uAKKTe3DkE+5LMY3+RkiaoATZlnQ?=
 =?us-ascii?Q?WTihHy9qNCuq/zOj+sdKj36/LxYli6u4HTJsvm/h/S7Z+FLKnNqdBro7hMPg?=
 =?us-ascii?Q?zFBR9Lk+kkywt1Kh31S0AkN3DF958WjMEIGYCiXq8fYunsnWQ6hnfw3WmEiw?=
 =?us-ascii?Q?T0F6itHQJu7ei3Rpj8WoKi7jDkWznhwfZCpAwy214toYO9lMPJmojVADBAVo?=
 =?us-ascii?Q?z2tOaAIqAzMl7FS6pCLve8H9sA6dnp7Vh7Ro/AeqGknbPrzGhmvc7AKJqBHZ?=
 =?us-ascii?Q?vxFer3YAQNeRzunqG6/hyQHQT13A/oPIDY9o6HCGs3qCskqSxmVfVyy0RcaO?=
 =?us-ascii?Q?heiFfFkOcK/3JXScX1FrGTBrwlwn40iu6QkWIuPY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414d551a-4d04-4df6-07aa-08ddc5a3080b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:16.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+sGCPLR4D5OaSnJxOf7kvoY44XkaQBHy0LRbr9OvmZZrLeA5ljAfp+gDxZdJ+As
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Instead of open coding the refcount calculation, use
folio_expected_ref_count() to calculate frozen folio refcount.
Because:

1. __folio_split() does not split a folio with PG_private, so no elevated
   refcount from PG_private;
2. a frozen folio in __folio_split() is fully unmapped, so folio_mapcount()
   in folio_expected_ref_count() is always 0;
3. (mapping || swap_cache) ? folio_nr_pages(folio) is taken care of by
   folio_expected_ref_count() too.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d6ff5e8c89d7..4db67970ae69 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3737,6 +3737,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct address_space *swap_cache = NULL;
 		struct lruvec *lruvec;
+		int expected_refs;
 
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
@@ -3800,11 +3801,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		     new_folio = next) {
 			next = folio_next(new_folio);
 
-			folio_ref_unfreeze(
-				new_folio,
-				1 + ((mapping || swap_cache) ?
-					     folio_nr_pages(new_folio) :
-					     0));
+			expected_refs = folio_expected_ref_count(new_folio) + 1;
+			folio_ref_unfreeze(new_folio, expected_refs);
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
 
@@ -3834,8 +3832,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * Otherwise, a parallel folio_try_get() can grab @folio
 		 * and its caller can see stale page cache entries.
 		 */
-		folio_ref_unfreeze(folio, 1 +
-			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+		expected_refs = folio_expected_ref_count(folio) + 1;
+		folio_ref_unfreeze(folio, expected_refs);
 
 		unlock_page_lruvec(lruvec);
 
-- 
2.47.2


