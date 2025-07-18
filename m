Return-Path: <linux-kernel+bounces-736182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B37B099C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BBC4E84BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9371DE4E7;
	Fri, 18 Jul 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="An4UEKgX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EF1D5CD1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805820; cv=fail; b=VWEvfwab67jUQqX400kCequ54pa4hRvXvbdCIaltllrEjO9KxaoxDbagD5mNPQ3yJ96xpjFYg+sHr+SdeAaGgjjVJL05DslUy/d1q9YbL2huYe9UdCoxKSJaPNqJ9gfsG4CKmxvaA2zDsaRdZkDdCqj6URAVLdAD5gXLG1wRJLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805820; c=relaxed/simple;
	bh=ZAW5VIPQqh5H9dr2HY6waz2TTPeS1pq4vRCWakAVAXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwKbEXKEu6KzkKww22BkRm2CWRAwunCgwlbGLuqBs+VDB5HZLpyUXZhbPU/7V0QIeMB80qBMCfrPrpbS2GcWsCkICcuNpTngrX0rI0D/Vlz2kYrzJGeldiLEcdAup7t8qCVd6E56FfaKeqsLTLiBa+wnoW91bqgbLDEK4T2oXro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=An4UEKgX; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6w7De75Z7iYljLrLR/RHWrcWceXRQlWI7BCM2i4pzbW6q0ZE9u9gYkUniCGVZwSNxLfWHXTQ9dKtdha69jueFVhBxUQnx9MVMtrwFjNCThx/EbjtVpRj+j5HVaRFHllscgbHmWQQaY4fb28zg+O/bxqsZ8bCYzsqpm0q/97pITtkurG1JohSqe+I+ogqaTr8Dous1ADjfjb1Q+SaK1ETfKGE+EP8V6NNFRxJ6Yne/fOHAj+IwxGqD2VrhEfkpTvyWZ3SucrJZU+cFRIko3lhJf+i2JSCAaasCuDs+HTPJPjnVMCsyTOIOUR84NPRLmTXZzjhJ2+MqbX37vwZHzIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05nwIUeb0py2hT/mK+lSNFkh29LCuwDfA7U2QUefuDI=;
 b=DdyBf+F5DMKJCNW/dlsZs1aVg8KdD+B+ffygQpLHVLigIi0m+MffQDZypA6h7I+TGm6AXCI0tMyQDUdDbcKiyKliKuFtL85cd2fQY3cLlMoM+XYpMqKbVgNmW1V2eYB75Qnc+qV4yf+LdwtTUjKqT3QXlug7VFHDdbYC9ZyA8HYAEifnSioz+CEr9jxqziauktxMp7JxhNfUIfa/CYAsuzNoEoBUfvPbCqabbw7UMFnpPwsosQcHXrWPppFmvaGcinf81rA0iMsN/ZYWIOTddZn3emd3LOuhDoLZpHKQUyaw8jeUfZcB3FrdcnKyeRjyYAV2OMlUhwEGK1T8K3NhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05nwIUeb0py2hT/mK+lSNFkh29LCuwDfA7U2QUefuDI=;
 b=An4UEKgXA3HJUhB69MVcSgZhhXUdSnsnkvW4Afdmv48LH+3CD9u7hP9CtplbAzsg1/fi18lqvT2L33yx47RwOqTeN/Jg9URpxif3U8+pkDzqiFL+c7/WaOC0r2tHL4lvyEs+BenSRKF+C6EO9wZd+HPMhdk3FryfpY37VORdjQepeayZ9EyQDeRVCS+CjgRYrHP/HhaKb2bDX0TtBqtMnSVdrN3rCkURNTf47veoNObR2ePKcMuyvwPv1t9RYUHpRLuK8Ovj/CaJb9J04SuTIEv4pW4Sw/KQvjLpIHJwz9UKonJ4eZEI7nIPFyXWH+aIvXnrf98SUzJf9v8y01LE7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 02:30:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 02:30:14 +0000
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
Subject: [PATCH v4 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in __folio_split.
Date: Thu, 17 Jul 2025 22:29:58 -0400
Message-ID: <20250718023000.4044406-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5511ae66-bf90-4d9e-7adc-08ddc5a30731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiiCkXnoCQVoLG8xtsIf/qZVNkvhtSzrHnaoqHAlWRNZRawLGTyhI1/U0UE2?=
 =?us-ascii?Q?6J6Y8Yc18fTOCc/U4pwdFbDjvybHn5QH5fHx216NQ5LUhrWdk45YPeVeHezg?=
 =?us-ascii?Q?O3HlFrChR+ECVxSI2mKGBH+7r598DWCntQBdNaK5PuOAdkPbkE0fHfzSpnV0?=
 =?us-ascii?Q?k0fgZwWRwVb3RivGDfuxh3KKOKweqnBWpVGpjAc+UIdxvp4gzPVqAjlAAOgy?=
 =?us-ascii?Q?+T6vIFFRXEiW/c7eEMmcXTMWOLYW5+yR1IumC/pEvrQFBWwcowPkkuRFILCi?=
 =?us-ascii?Q?87fjckBTPeJKRaZiUzC3o1ust2844QXydziHrrMJDmJ9cyl8ovRXneTMGLjH?=
 =?us-ascii?Q?0EDIwZETdLXq3+qeNKoD0g3Quq7oi/eXTYAKheMeQtYUxc+oEbd+LjOKIZxz?=
 =?us-ascii?Q?rV6IXlMcVO2f032iyUruZ6Btd4Gdz7DxkVq2vPQSDessTTcWBumAYf79aI3T?=
 =?us-ascii?Q?kYzNSXBG1GDrox/d1dBIB+NOuVltQ6MzRD2NuhVY3ugNkW7bF77UJZhaTO1w?=
 =?us-ascii?Q?CrBwxkbmptM7uwb0298UI6Iw3MNl4ClWGS9fwRV8+H5V0waA5DboHv2VnVWJ?=
 =?us-ascii?Q?XEKHTrNIhp4dUSk2ORv/GnTKXA/TvGqv4R5d0LVJisSUJqTm2zUa0WrQQnmb?=
 =?us-ascii?Q?bXS/J4MYZBRbAgzptmXxu7Bn6wbIk5IN/mcYsOpaWofEURme9RY5qu4ePG80?=
 =?us-ascii?Q?5eMAqRPLntKuCWxUi08SrA5kcEHudILetuXr3fP4/Y+g+jIBTzw8cozJXD41?=
 =?us-ascii?Q?LL+7oCUDXMm3yxY2EzjEWT5nsdG2FTlGGhqruIZDvGSMPxzXT6qOD3zVyAMr?=
 =?us-ascii?Q?571bgLU9oP2NNG4VhAi6tf/5r7Vo+RNpr5M6Xpjm40QCelb5H/3w+ljuTxaB?=
 =?us-ascii?Q?I4sBZJ9hYZRkM18Cf1aA5GvlSi1/f3acGlN+Sfggyex+kkQyxLqzNOrh61Sb?=
 =?us-ascii?Q?T5fsvEvFIuKn356v/Gu/iW0OXw3svIKK3DF/RxFOezeBmOwWfc3Z9Uombs2f?=
 =?us-ascii?Q?p897H00sNtDZrZNrnbh89nOklDu/t9b2DWZhi8c0tK6Z6wx/d8y2c50xgoot?=
 =?us-ascii?Q?MX8u3QT88YA3we0ggphK3G2eNkW9Mxvw4pS/9SA2b9vCPkFMwmmYkoNWmLVt?=
 =?us-ascii?Q?91A3jaY0qFXfuiRrNXFj79pkTOd4FGA2Kc4kmug2yql+S+HndhHICnlPo4oQ?=
 =?us-ascii?Q?J6IR+S61GlFj2eWcrOttkcNSbmSOD/2Pw34DJcHCEfF8JRhxM0fAVmWUBPUm?=
 =?us-ascii?Q?ntEvs5NGenaYYWGxihzCBy5CrMV2xn0wZMbCZ9zdfwooqc6euvJV12KqdWCr?=
 =?us-ascii?Q?6k3fqsuHyVil2PLyYYMcZX79+U36/3sxJJJo2Sb8QAcsx+lzQFbFUpANXibC?=
 =?us-ascii?Q?2c9UwwiG+lhqcS6e7r6SfoUb44A/9d+lUDx2vdR8FhvXJkmj5dz5EiPkSA7n?=
 =?us-ascii?Q?py9uZ97JeX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YMd6mbWW/RH0VH0GkcinDnswY3Z+Eofc/mIMKaUdLq6QpefwlhZixsFv9tp/?=
 =?us-ascii?Q?MTV4G3jkz3YKfnVtVHaBptMKe1b+yolHVUIbxGrBmEIgr9odigcKc39TEtYx?=
 =?us-ascii?Q?sbPfO3Nc92I0OHY3yqPCIKqKKT9E0U9l6qAxwGpL3Vg9ZpIrimbxLQcGMpDO?=
 =?us-ascii?Q?1aNWWHwM/0J3MmcRzJokVspl0Dgb3OFxFT+52PPZpV/J5NldDr4AiO8XhUB4?=
 =?us-ascii?Q?C5Fwr8oPmewevzMXDaV2jFoQxcmF59uIo9okwHjkZq/jdmrUGjK7QrxsIi2I?=
 =?us-ascii?Q?BOI6WwIgpOj8nigBnh/PfpaS6pALTscd0nsIW5PykGZqbR7vJLYj/BSn9Jvn?=
 =?us-ascii?Q?AdWrdHxf0ZeIMJUp/0Mu2gjImLWxBbJuEchtLOw2cUXmPwV4MlR03zJ0rY4K?=
 =?us-ascii?Q?MRF4UtMGwYAQTHF0kEIoP6RuOnC30hS5FxVa50PZxqrcPbDRcQttX3xzatWU?=
 =?us-ascii?Q?bDSiZrk4CVyaaTokXle1N4NNrFZJIRRPh8Ybqb+yxuC5jqEq0xkVT0IRZVtT?=
 =?us-ascii?Q?0sS/DtQshv1K4oayKn9s1r9gBwAw8QBcwzfDRR/OC7Gw6xGrbMR/okqX849d?=
 =?us-ascii?Q?cGL/O2hZ/K6+j0fj4u2OymIbmZoZq2Io91m1aIwsxLZ/61s7wU61uAEy0kKd?=
 =?us-ascii?Q?s81z1l7dGQhpIh1jv402xR/po2qg4S6c9knMo8ydlYirIanYxHSDRpuKWKKO?=
 =?us-ascii?Q?FR+iHJK82v899uZ449r4y+d2dwmarcudn4/UVwVapsxaEkJEkPwcPrcxd11z?=
 =?us-ascii?Q?MjKdFa8rPHLodDqzUJ00FOkbpfVUH+BYPS/SPZ3BX/padxBih6x6TsFCvkEi?=
 =?us-ascii?Q?A1hHJLO5l0beXnDJ9aeo9rDjtSfGoVEhHp2t0VQnLXwAXngCagCZUvTT5zwo?=
 =?us-ascii?Q?jSF7uZmvlN1RXtlEWU7VKkJEgjwfYqi67Doof+Jqv3mkVHqowBO8WXPZwTG+?=
 =?us-ascii?Q?6FxXmqx4CML6RuG+I7J6XpKxZbNpteHgi0v3ltPuoZGytpAK6GPyL3fVnxM7?=
 =?us-ascii?Q?p7AizkBJ8HR4YukiVxNjiKf6HfmchPOBl4O7JR9bmDYvR7oo77EHlzblb4K6?=
 =?us-ascii?Q?OKNeJB7ylAyWM1aB6chwc4TB+6D12ybYBnVAUHRvIuPh3upugHhyrcrdPSaV?=
 =?us-ascii?Q?5wUwmRrLnKcYFODMYLTFn/f9DDeMJs4zU5PBSG/qDpDsmgFK8couB453aUOT?=
 =?us-ascii?Q?msaqg4NTu7ecIEfUBwTGB1L7S7JgfFEoh3Dj9/xImUhejfruLSfytYxteh6V?=
 =?us-ascii?Q?NKFknZmS7gOJ80BXJHlNgOgHYrXkt9bARa4l297Qm5fzthA04S/mJIUjUB1u?=
 =?us-ascii?Q?LyZAXogqiYH0Igznf/H2H5e5iPXFH7/y2eL/CY3HNtvyDbqL7FFNAOJyShGq?=
 =?us-ascii?Q?w/xzM67IgG3qu7iY7V6hI8MnpVwbue1iO0aeeQqjJS8YVHHlxbYSY+eeWaqM?=
 =?us-ascii?Q?E+WYDXAGpuEe1QVTppyaIXJYdf+zisLXvlvwRFcKxTQm0jgHh4Zw57Su46aI?=
 =?us-ascii?Q?rwsf/dKREeuErsalHUW3Q1AIer5qX/RWP/5pgr97l+FZ7PkvGngHxb1obgHv?=
 =?us-ascii?Q?SN04yhp+hLr2a96rPojRvjDo7Y/vtQh2e/GLe3MD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5511ae66-bf90-4d9e-7adc-08ddc5a30731
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:30:14.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FZsRTATIgOaPRufKAvW+N+ErxvGr49A1L2ppT/1MRTS5NjguWbsOawIEC4DziQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

These VM_BUG* can be handled gracefully without crashing kernel.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d36f7bdaeb38..d6ff5e8c89d7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3601,8 +3601,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	pgoff_t end;
 	bool is_hzp;
 
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	if (!folio_test_locked(folio)) {
+		VM_WARN_ON_ONCE_FOLIO(1, folio);
+		return -EINVAL;
+	}
+	if (!folio_test_large(folio)) {
+		VM_WARN_ON_ONCE_FOLIO(1, folio);
+		return -EINVAL;
+	}
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
@@ -3766,7 +3772,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		}
 
 		if (folio_test_swapcache(folio)) {
-			VM_BUG_ON(mapping);
+			if (mapping) {
+				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
+				ret = -EINVAL;
+				goto fail;
+			}
 
 			swap_cache = swap_address_space(folio->swap);
 			xa_lock(&swap_cache->i_pages);
-- 
2.47.2


