Return-Path: <linux-kernel+bounces-745007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E5B113A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B073A8BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218832417E6;
	Thu, 24 Jul 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VBFBsq7C"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58723C51C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395183; cv=fail; b=G+pTGr2nX+kfzbGqGRohkOuk5uwBZkl7XBZiWnOT9rY+jN+7fmjcw6BzWjtZYrbCNZGHL4ca5b8ZqXc29rCgOzNW+HZbceu8g+tsj4L9BcC2gmoS8cRz2wtC2SZ7YTi3nHssgOQBz1phyoKFeUP56av0SzGN0AzBxvsfOHQO9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395183; c=relaxed/simple;
	bh=RVwGPo+RnLGDJjnClM0QkjmgoiFd4O3QOkniDWOu+og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiioD9AGS8LgaRMP9pFXA0FNmO1F+LQ+OdlfxE1+PF+QCt5FIPJco1mZkB7/ldTEkYjSlz3s00zN82xC1K57xtKjgwqG7JNHFFI2zAxy200B1RvckqED5qDA3mEYziLHUauGahZMSTByOFPrW/pxs/++mDcYWnTPPKOhF4jONF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VBFBsq7C; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpeHlUzTURePt64LcQ/rNRwYhbxcRr4eg9OJxAV/1nXOkvkSk/qw//QJk7vpNAy9TqPKOQ20uyX5pMmGkzR0yxfVWJ5zvwjWAqUY46NPp1JiWWd8XtABxOgoOgtwqip0GSQplR4vE72FzjmWfeSOUDx4ntMRLkJYjkdQh+S+lMXUgpvn0Qh9S1c9UIE8U+SQUVcsrPWjHvGQw6mbIVAKmdPrrLVgBE3vrYBQ79w3iPLgnrVrPb7LmaOOiA0y/g5sJo3sc35lSRK1dbIO8TTCtihDftE80SiA8vGe89jnHdM1S7cFFhrZktv7unZ5DUrDgvkfkFBTsCIQmnViX0o/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcbv42TPa7Jcf4GEOFALnqkkmk7FqZ59lhPBWrpWfk4=;
 b=MxbnIH775EI7OjesfDzF+HZmI0bUjd7UQspsjBMllnA25yj8Gcz8eB4dkLO0Au/aVdGC+PmFrwLLaoFHOL6m38jHs5fpe8AtV6C3ZD8Pwu4RfPjtp9cc/48ozd4fHR6UInj8v+0gBR8WqNSkhOvptSPWw+xkiHgmY9fQfbBYppru0dJzdVqeIiCvKwK+cnat+4CRYoh+D+lRybb2J+nh/YBTnndg/N6tuweA32caba1W6GSaZb1BrAjDPY1A2wyO1Ah4dLMszr8Sz+psO8cgw5mFUEGnPegFC/TVC9U1TPAm9o93VEi0txNswj0CxonR7+0eKuSITrdYe0HJYZwaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcbv42TPa7Jcf4GEOFALnqkkmk7FqZ59lhPBWrpWfk4=;
 b=VBFBsq7CEhDHlIQBYWSqN09qb4dDh2D4zt79bQmRS1c6rbLBoOjyGNj8xL4b1BlGHgPmPQPhhaHedAQetR/WnFva5qTPorfb3cZ42cyzmh32Q8YbDqbmQwKkxjx6khXYUdXEh+b/i5+0zapjqpG8E/Z10GhMYBnj7MsBmBmG7iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8089.prod.exchangelabs.com (2603:10b6:806:32f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 22:12:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 22:12:54 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs
Date: Thu, 24 Jul 2025 15:11:06 -0700
Message-ID: <20250724221216.1998696-5-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724221216.1998696-1-yang@os.amperecomputing.com>
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0236.namprd15.prod.outlook.com
 (2603:10b6:930:66::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e629f54-783d-4313-3fcb-08ddcaff3c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cg4xlaJ660iOWKgTKOMtYzYmEsygYXMgU/ejrpr5ZN0Wgmh1Tck5HFD6PZyJ?=
 =?us-ascii?Q?jrh/V+aTOnoJE760fO2csvR2cb46jYeR6EXZdG+0GhxaU9KVj92FpUkJ/N9j?=
 =?us-ascii?Q?USpUTMjR+CvsoxUH4hEDG/jd3H18wv1HQ/g/xQcWLn3H2aHzEj5OJnYKKJbv?=
 =?us-ascii?Q?B1VrEy7Keh+5n1OehWiPSsflxJ5n07SRrfY9PrTqV+OtDOIuLcNcoBG73DvS?=
 =?us-ascii?Q?RYHLrAJt0Gysbe+d7IvrR0XzdL+VWbi2oBSQBd8RX3ZkAoeqj9/4f+HqP52I?=
 =?us-ascii?Q?CcC0J1HLEqWve6mE/sjLo3hJVDIVNg5xuCN3IbXjm0VbwIqmqRh1KHOAPkWa?=
 =?us-ascii?Q?S/BhC3SXFFfot+OYRO+loP/Dkg5VOPOZbK3fm1fgeAb7Pn4jw25TU4lxoNLe?=
 =?us-ascii?Q?4ZdWk9PCsDVIvrag8ZLQzQxthRKLPzmv8EtRARSwCtvsCKqgZblEfXINiIeE?=
 =?us-ascii?Q?/dEFjdUgYbjMd9PhFhRd83JBaPx4dUUpp+VWwjl93cTEz3RSjQWoNQHSIlPr?=
 =?us-ascii?Q?S4o1pOf3HmI0uPu9Gzy/K+HJXXtX9s9HJqjDWb02XbsR5mZyMwLzM4anMacC?=
 =?us-ascii?Q?zraUbn+FbpB84h2El0pNu0dq9rg6V1ylCD1lF4fkivyg94mKCp97sxdglWnq?=
 =?us-ascii?Q?RvrkEX/yqknJflRYTWZP3ZVKV9iQUG1r3Ix1AYo69G5Q5IHoPO1EZD8+oZyT?=
 =?us-ascii?Q?Ma9RLlNHcbLAIgeWyudNTPVPQ2mKtYafLoCrrqk6Dbsypuz7Q7JrVEcjxrQP?=
 =?us-ascii?Q?EdR511m/EHz1XndQttgkFPr3R6/gb91uTBvUQE3WA9maVNv8TPYxFgEzKZx4?=
 =?us-ascii?Q?umESXwEw/GXaNvK+bgsQsx0IomzZFzpnC9+eHPYHVPg/OAlGUkl3St7QbJ3C?=
 =?us-ascii?Q?iDbl8w6cmQoKnjOTrFDMUtdTOxorToXP/kFuBY3Lt4ToH7uAxlxizpvMVwHR?=
 =?us-ascii?Q?+2b3Ip+r8uee81NyH1StSLhYkUz6J0JaV7frKAKhlAUaW7quCNUODPIaW25R?=
 =?us-ascii?Q?ta+XCi4c4jwvHdiaE7huVIIR4xBPW9EgrZBWiX5kavk8eOcdnJLLDQPkWPa7?=
 =?us-ascii?Q?r7usweWVXafR4DiGAltOjxImhWfSUG/z45PI6kSo+IkmmrZyI1QYVZvM38om?=
 =?us-ascii?Q?lOQxJoymQlIzC7sMClbjw8HhAYyxuzoE4rwR36KKWz7mdjktbR6VAqHwGnsT?=
 =?us-ascii?Q?7IaMnO+yEuGOiqZ5AOuoJpEM7s4GZyrGdr+4ETdylh5LZdCNm2ptsiaLHLYc?=
 =?us-ascii?Q?0mJWRaGrcU9Xdd+VAsL7g7DKyPg/3c/ASvXUlah0HQQsHPnBVEL+y9tMQgR7?=
 =?us-ascii?Q?Mz5EtT0dDTqkLoEnH0lDDu3ZR/fI2Z7Mq9LxpoYN3H4BXm0CijXhS8cqch9X?=
 =?us-ascii?Q?ZgTFdV3Ex8HcOUUD+rzk/llz0WV29rsiycQY+0FHVkep7RWjJstCX22IHVbO?=
 =?us-ascii?Q?pe5BfxVqq3zcwFPjmBJnfvjg1Bp+FjiGlWehWvRu96Z3nzU7+NOV/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofyE3uJubak1LrTXXZ1ce3h1DixHLEkMTleChVGTWhWRN+W/z07Ioqjswifb?=
 =?us-ascii?Q?QaMkeZOQe2C7pglU6wBOtrhq9ISuavTDVeTxaj6QQDPzl7ruXdGXSsWvtNPg?=
 =?us-ascii?Q?7pg7WBt+PdzPTpt7kEpBbMQ2EQ7lxl332jF3bpKLkAJ+ZFZO+Ds9paby8VTX?=
 =?us-ascii?Q?qZwviK7V3iVr5V+2niE4Wq38yaNMDAQWFQ8bvCnRllbX1si+vGbFYs6NhjDr?=
 =?us-ascii?Q?HqNlDNK/Vv9nYUOu63h1J7HRqiX8JU2pAjE+2jy39/VGakbK46hK7RzC0pqp?=
 =?us-ascii?Q?QpBUt+l6JAKRiqsn11P5J3xKN8yyfvpXKgSNcHZMPWIbIlzlSjtAm+vr0fil?=
 =?us-ascii?Q?vIbblRCcb0pIsGGRXeFk4Ifn7LxttrUAGdSTBnTVuuHYpyJn80kKDzWaKuWE?=
 =?us-ascii?Q?fHUYKPcUbynPZRLUu5npHxMg+V4VnMXqbl5vAlayrZQLdAruXIsbm8m4IV0T?=
 =?us-ascii?Q?NhEiS2VRtn7dz4AfGcF08Ulg/RLp/ghdtR96rCW7JuC5crn6057kc+o7eGLg?=
 =?us-ascii?Q?UIUCwThmiKgyOQ8eLYx5l3Z/6FjJuFnSpC09gUrLtPgjZwvdNtaHFHaFt1dN?=
 =?us-ascii?Q?KkCs1aFtnfe72TlQDQWGiWdsQcER2Iz0zZT/noHUAlq0H4SCKnKwt++sKMIj?=
 =?us-ascii?Q?Hr8nPGK8q1j8latqFGbrtHSGbeQ+y5fM+5aeLyt2QZ3KxCbuO3PRDAUA44Ae?=
 =?us-ascii?Q?18YcsfNH4JqHXT/EKBYYVth/5EzIpAnbWS6Ni89G12hhNvxMivriz17mW0bH?=
 =?us-ascii?Q?lKy5d5wOOXGuJUe+MpZDLb9fPJs7FrfOdfhnvBWgvU5rhmAQPszkbb1+6tGl?=
 =?us-ascii?Q?Flo+wrvtQ+dD0iM5WWKC1KwlLU5YoD1p9F0CB0hWWtU4FnHu/0C4+jYFUJqZ?=
 =?us-ascii?Q?hoGvVFmCOIeUXCrnv10DPTOPvkNc3nDehyP7YL0MNrIonUo8va+0YyVvnm6r?=
 =?us-ascii?Q?0nQ+9jRSbCFPf6GQh0ulCG4DCCLBhklRnEqyABiFDcElFx2+6eYE5qtMaoxy?=
 =?us-ascii?Q?r9Z0WG5TvrgXhEnezALlkE3x9TpeoxrfAbhTkFZBrHvnRfaB/1svBBN5+f7M?=
 =?us-ascii?Q?n01jXPVFtD/VoXuOzVJFmvhvlBTmRFDC7uLdbfKL1jFLutcEFouHiy1ZJMbT?=
 =?us-ascii?Q?doh0hEQ+am5XuITyQ+8LcA/Yl4CcJBzrM1IYc9YbDzkiGKOAMU4ar6GrGe+u?=
 =?us-ascii?Q?2pSmnVClHDsP3iuBWRwszU1vNWezHoemYk7oLB/p8ZHgesLMIEEmtZXwgvCC?=
 =?us-ascii?Q?efrM9qEP4r0nLT3+erUJPDxY3+qqZ/6aRT0iAESmTdru8EYGwV8ivbUWj6ED?=
 =?us-ascii?Q?T2OvaL0QbqPmgJb6QDmvJ1RybYN1X2R5bb/e4oN/tbG0VAdNGpTPvN9acw4G?=
 =?us-ascii?Q?q/L1VWDt0N+yE+P7D1cYFZUrb9lkC2wCz9y+ytBX6zjyl4jv2NZ40hS+dBP+?=
 =?us-ascii?Q?y1oYTm+To2lQICtL/+nXw0dfxHR3qjycus8sIm/zLZ08pD71O3XH+yupJ4Fq?=
 =?us-ascii?Q?UIqWWv5hlvPsmH6XzYw/nt6xR8VUVSxk7/zFvVFJT2qQzPBJXlouotn/fwG8?=
 =?us-ascii?Q?9PQfX+7lQ9i+9LrU4kCp8tVhR36whhZZsVvDwQjUL5F6Sy00MhhNx0GgIGXs?=
 =?us-ascii?Q?wbC1OkleVHQD/ReMZ5RezGQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e629f54-783d-4313-3fcb-08ddcaff3c97
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:12:54.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUQQJpDrSMmf9UebFVpjQTRXvC3JxGXihCIa0pX42ZcnLTkMxV1Tiak9/oRtHjAZMrzJpkCWNAh3J8uuM2Sd2bRKEl3QZZ/n2wvy9V8pqwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8089

The kernel linear mapping is painted in very early stage of system boot.
The cpufeature has not been finalized yet at this point.  So the linear
mapping is determined by the capability of boot CPU.  If the boot CPU
supports BBML2, large block mapping will be used for linear mapping.

But the secondary CPUs may not support BBML2, so repaint the linear mapping
if large block mapping is used and the secondary CPUs don't support BBML2
once cpufeature is finalized on all CPUs.

If the boot CPU doesn't support BBML2 or the secondary CPUs have the
same BBML2 capability with the boot CPU, repainting the linear mapping
is not needed.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/mmu.h   |   6 +-
 arch/arm64/kernel/cpufeature.c |   8 ++
 arch/arm64/mm/mmu.c            | 173 +++++++++++++++++++++++++++------
 arch/arm64/mm/pageattr.c       |   2 +-
 arch/arm64/mm/proc.S           |  57 ++++++++---
 5 files changed, 196 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 57f4b25e6f33..9bf50e8897e2 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -56,6 +56,8 @@ typedef struct {
  */
 #define ASID(mm)	(atomic64_read(&(mm)->context.id) & 0xffff)
 
+extern bool linear_map_requires_bbml2;
+
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
 	return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
@@ -71,7 +73,9 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
-extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end);
+extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end,
+					unsigned int flags);
+extern int linear_map_split_to_ptes(void *__unused);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1c96016a7a41..23c01d679c40 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -85,6 +85,7 @@
 #include <asm/insn.h>
 #include <asm/kvm_host.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/mte.h>
 #include <asm/hypervisor.h>
 #include <asm/processor.h>
@@ -2009,6 +2010,12 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 	return 0;
 }
 
+static void __init linear_map_maybe_split_to_ptes(void)
+{
+	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort())
+		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
+}
+
 static void __init kpti_install_ng_mappings(void)
 {
 	/* Check whether KPTI is going to be used */
@@ -3855,6 +3862,7 @@ void __init setup_system_features(void)
 {
 	setup_system_capabilities();
 
+	linear_map_maybe_split_to_ptes();
 	kpti_install_ng_mappings();
 
 	sve_setup();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f63b39613571..22f2d0869fdd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -482,11 +482,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 
 #define INVALID_PHYS_ADDR	-1
 
-static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
+static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 				       enum pgtable_type pgtable_type)
 {
 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
+	struct ptdesc *ptdesc = pagetable_alloc(gfp, 0);
 	phys_addr_t pa;
 
 	if (!ptdesc)
@@ -513,9 +513,16 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
 }
 
 static phys_addr_t __maybe_unused
-split_pgtable_alloc(enum pgtable_type pgtable_type)
+split_pgtable_alloc(enum pgtable_type pgtable_type, int flags)
 {
-	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	gfp_t gfp;
+
+	if ((flags & (NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS)) == 0)
+		gfp = GFP_PGTABLE_KERNEL & ~__GFP_ZERO;
+	else
+		gfp = GFP_ATOMIC;
+
+	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
 }
 
 static phys_addr_t __maybe_unused
@@ -523,7 +530,8 @@ pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
 {
 	phys_addr_t pa;
 
-	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
+	pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL & ~__GFP_ZERO,
+				 pgtable_type);
 	BUG_ON(pa == INVALID_PHYS_ADDR);
 	return pa;
 }
@@ -533,7 +541,8 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
 {
 	phys_addr_t pa;
 
-	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
+	pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL & ~__GFP_ZERO,
+				 pgtable_type);
 	BUG_ON(pa == INVALID_PHYS_ADDR);
 	return pa;
 }
@@ -572,7 +581,8 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 
 static DEFINE_MUTEX(pgtable_split_lock);
 
-static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
+static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			  unsigned int flags)
 {
 	pte_t *ptep;
 	unsigned long next;
@@ -586,14 +596,16 @@ static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
 
 		nr = 0;
 		next = pte_cont_addr_end(addr, end);
-		if (next < end)
+		if (next < end &&
+		    (flags & NO_CONT_MAPPINGS) == 0)
 			nr = max(nr, ((end - next) / CONT_PTE_SIZE));
 		span = nr * CONT_PTE_SIZE;
 
 		_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 		ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
 
-		if (((addr | next) & ~CONT_PTE_MASK) == 0)
+		if (((addr | next) & ~CONT_PTE_MASK) == 0 &&
+		    (flags & NO_CONT_MAPPINGS) == 0)
 			continue;
 
 		if (!pte_cont(__ptep_get(_ptep)))
@@ -606,7 +618,8 @@ static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned long end)
 	return 0;
 }
 
-static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
+static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		     unsigned int flags)
 {
 	unsigned long next;
 	unsigned int nr;
@@ -618,11 +631,13 @@ static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
 
 		nr = 1;
 		next = pmd_addr_end(addr, end);
-		if (next < end)
+		if (next < end &&
+		    (flags & NO_BLOCK_MAPPINGS) == 0)
 			nr = max(nr, ((end - next) / PMD_SIZE));
 		span = (nr - 1) * PMD_SIZE;
 
-		if (((addr | next) & ~PMD_MASK) == 0)
+		if (((addr | next) & ~PMD_MASK) == 0 &&
+		    (flags & NO_BLOCK_MAPPINGS) == 0)
 			continue;
 
 		pmd = pmdp_get(pmdp);
@@ -634,7 +649,7 @@ static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
 			unsigned long pfn = pmd_pfn(pmd);
 			pgprot_t prot = pmd_pgprot(pmd);
 
-			pte_phys = split_pgtable_alloc(TABLE_PTE);
+			pte_phys = split_pgtable_alloc(TABLE_PTE, flags);
 			if (pte_phys == INVALID_PHYS_ADDR)
 				return -ENOMEM;
 
@@ -643,7 +658,8 @@ static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
 
 			prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
 					PTE_TYPE_PAGE);
-			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			if ((flags & NO_CONT_MAPPINGS) == 0)
+				prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 			ptep = (pte_t *)phys_to_virt(pte_phys);
 			for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
 				__set_pte(ptep, pfn_pte(pfn, prot));
@@ -653,7 +669,7 @@ static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
 			__pmd_populate(pmdp, pte_phys, pmdval);
 		}
 
-		ret = split_cont_pte(pmdp, addr, next);
+		ret = split_cont_pte(pmdp, addr, next, flags);
 		if (ret)
 			break;
 	} while (pmdp += nr, addr = next + span, addr != end);
@@ -661,7 +677,8 @@ static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end)
 	return ret;
 }
 
-static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
+static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
+			  unsigned int flags)
 {
 	pmd_t *pmdp;
 	unsigned long next;
@@ -676,11 +693,13 @@ static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
 
 		nr = 0;
 		next = pmd_cont_addr_end(addr, end);
-		if (next < end)
+		if (next < end &&
+		    (flags & NO_CONT_MAPPINGS) == 0)
 			nr = max(nr, ((end - next) / CONT_PMD_SIZE));
 		span = nr * CONT_PMD_SIZE;
 
-		if (((addr | next) & ~CONT_PMD_MASK) == 0) {
+		if (((addr | next) & ~CONT_PMD_MASK) == 0 &&
+		    (flags & NO_CONT_MAPPINGS) == 0) {
 			pmdp += pmd_index(next) - pmd_index(addr) +
 				nr * CONT_PMDS;
 			continue;
@@ -694,7 +713,7 @@ static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
 			set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
 
 split:
-		ret = split_pmd(pmdp, addr, next);
+		ret = split_pmd(pmdp, addr, next, flags);
 		if (ret)
 			break;
 
@@ -704,7 +723,8 @@ static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned long end)
 	return ret;
 }
 
-static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
+static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
+		     unsigned int flags)
 {
 	pud_t *pudp;
 	unsigned long next;
@@ -719,11 +739,13 @@ static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
 
 		nr = 1;
 		next = pud_addr_end(addr, end);
-		if (next < end)
+		if (next < end &&
+		    (flags & NO_BLOCK_MAPPINGS) == 0)
 			nr = max(nr, ((end - next) / PUD_SIZE));
 		span = (nr - 1) * PUD_SIZE;
 
-		if (((addr | next) & ~PUD_MASK) == 0)
+		if (((addr | next) & ~PUD_MASK) == 0 &&
+		    (flags & NO_BLOCK_MAPPINGS) == 0)
 			continue;
 
 		pud = pudp_get(pudp);
@@ -736,7 +758,7 @@ static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
 			pgprot_t prot = pud_pgprot(pud);
 			unsigned int step = PMD_SIZE >> PAGE_SHIFT;
 
-			pmd_phys = split_pgtable_alloc(TABLE_PMD);
+			pmd_phys = split_pgtable_alloc(TABLE_PMD, flags);
 			if (pmd_phys == INVALID_PHYS_ADDR)
 				return -ENOMEM;
 
@@ -745,7 +767,8 @@ static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
 
 			prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
 					PMD_TYPE_SECT);
-			prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			if ((flags & NO_CONT_MAPPINGS) == 0)
+				prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 			pmdp = (pmd_t *)phys_to_virt(pmd_phys);
 			for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
 				set_pmd(pmdp, pfn_pmd(pfn, prot));
@@ -757,7 +780,7 @@ static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
 			__pud_populate(pudp, pmd_phys, pudval);
 		}
 
-		ret = split_cont_pmd(pudp, addr, next);
+		ret = split_cont_pmd(pudp, addr, next, flags);
 		if (ret)
 			break;
 	} while (pudp += nr, addr = next + span, addr != end);
@@ -765,7 +788,8 @@ static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long end)
 	return ret;
 }
 
-static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
+static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
+		     unsigned int flags)
 {
 	p4d_t *p4dp;
 	unsigned long next;
@@ -776,7 +800,7 @@ static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
 	do {
 		next = p4d_addr_end(addr, end);
 
-		ret = split_pud(p4dp, addr, next);
+		ret = split_pud(p4dp, addr, next, flags);
 		if (ret)
 			break;
 	} while (p4dp++, addr = next, addr != end);
@@ -784,14 +808,15 @@ static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end)
 	return ret;
 }
 
-static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
+static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end,
+		     unsigned int flags)
 {
 	unsigned long next;
 	int ret = 0;
 
 	do {
 		next = pgd_addr_end(addr, end);
-		ret = split_p4d(pgdp, addr, next);
+		ret = split_p4d(pgdp, addr, next, flags);
 		if (ret)
 			break;
 	} while (pgdp++, addr = next, addr != end);
@@ -799,7 +824,8 @@ static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long end)
 	return ret;
 }
 
-int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
+int split_kernel_pgtable_mapping(unsigned long start, unsigned long end,
+				 unsigned int flags)
 {
 	int ret;
 
@@ -811,7 +837,7 @@ int split_kernel_pgtable_mapping(unsigned long start, unsigned long end)
 
 	mutex_lock(&pgtable_split_lock);
 	arch_enter_lazy_mmu_mode();
-	ret = split_pgd(pgd_offset_k(start), start, end);
+	ret = split_pgd(pgd_offset_k(start), start, end, flags);
 	arch_leave_lazy_mmu_mode();
 	mutex_unlock(&pgtable_split_lock);
 
@@ -851,6 +877,75 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+extern u32 repaint_done;
+
+int __init linear_map_split_to_ptes(void *__unused)
+{
+	typedef void (repaint_wait_fn)(void);
+	extern repaint_wait_fn bbml2_wait_for_repainting;
+	repaint_wait_fn *wait_fn;
+
+	int cpu = smp_processor_id();
+
+	wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
+
+	/*
+	 * Repainting just can be run on CPU 0 because we just can be sure
+	 * CPU 0 supports BBML2.
+	 */
+	if (!cpu) {
+		phys_addr_t kernel_start = __pa_symbol(_stext);
+		phys_addr_t kernel_end = __pa_symbol(__init_begin);
+		phys_addr_t start, end;
+		unsigned long vstart, vend;
+		int flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+		u64 i;
+		int ret;
+
+		/*
+		 * Wait for all secondary CPUs get prepared for repainting
+		 * the linear mapping.
+		 */
+		smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
+
+		memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+		/* Split the whole linear mapping */
+		for_each_mem_range(i, &start, &end) {
+			if (start >= end)
+				return -EINVAL;
+
+			vstart = __phys_to_virt(start);
+			vend = __phys_to_virt(end);
+			ret = split_kernel_pgtable_mapping(vstart, vend, flags);
+			if (ret)
+				panic("Failed to split linear mappings\n");
+
+			flush_tlb_kernel_range(vstart, vend);
+		}
+		memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
+
+		/*
+		 * Relies on dsb in flush_tlb_kernel_range() to avoid
+		 * reordering before any page table split operations.
+		 */
+		WRITE_ONCE(repaint_done, 0);
+	} else {
+		/*
+		 * The secondary CPUs can't run in the same address space
+		 * with CPU 0 because accessing the linear mapping address
+		 * when CPU 0 is repainting it is not safe.
+		 *
+		 * Let the secondary CPUs run busy loop in idmap address
+		 * space when repainting is ongoing.
+		 */
+		cpu_install_idmap();
+		wait_fn();
+		cpu_uninstall_idmap();
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_KFENCE
 
 bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
@@ -1079,7 +1174,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
 
 static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
-	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
+	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
+	  bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
 
 static void __init create_idmap(void)
 {
@@ -1104,6 +1200,19 @@ static void __init create_idmap(void)
 			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
 			       __phys_to_virt(ptep) - ptep);
 	}
+
+	/*
+	 * Setup idmap mapping for repaint_done flag.  It will be used if
+	 * repainting the linear mapping is needed later.
+	 */
+	if (linear_map_requires_bbml2) {
+		u64 pa = __pa_symbol(&repaint_done);
+		ptep = __pa_symbol(bbml2_ptes);
+
+		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
+			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
+			       __phys_to_virt(ptep) - ptep);
+	}
 }
 
 void __init paging_init(void)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 6566aa9d8abb..4471d7e510a1 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -140,7 +140,7 @@ static int update_range_prot(unsigned long start, unsigned long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;
 
-	ret = split_kernel_pgtable_mapping(start, start + size);
+	ret = split_kernel_pgtable_mapping(start, start + size, 0);
 	if (WARN_ON_ONCE(ret))
 		return ret;
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 80d470aa469d..f0f9c49a4466 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -239,6 +239,25 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	dsb	nshst
 	.endm
 
+	.macro wait_for_boot_cpu, tmp1, tmp2, tmp3, tmp4
+	/* Increment the flag to let the boot CPU know we're ready */
+1:	ldxr	\tmp3, [\tmp2]
+	add	\tmp3, \tmp3, #1
+	stxr	\tmp4, \tmp3, [\tmp2]
+	cbnz	\tmp4, 1b
+
+	/* Wait for the boot CPU to finish its job */
+	sevl
+1:	wfe
+	ldxr	\tmp3, [\tmp2]
+	cbnz	\tmp3, 1b
+
+	/* All done, act like nothing happened */
+	msr	ttbr1_el1, \tmp1
+	isb
+	ret
+	.endm
+
 /*
  * void __kpti_install_ng_mappings(int cpu, int num_secondaries, phys_addr_t temp_pgd,
  *				   unsigned long temp_pte_va)
@@ -416,29 +435,35 @@ alternative_else_nop_endif
 __idmap_kpti_secondary:
 	/* Uninstall swapper before surgery begins */
 	__idmap_cpu_set_reserved_ttbr1 x16, x17
+	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
 
-	/* Increment the flag to let the boot CPU we're ready */
-1:	ldxr	w16, [flag_ptr]
-	add	w16, w16, #1
-	stxr	w17, w16, [flag_ptr]
-	cbnz	w17, 1b
+	.unreq	swapper_ttb
+	.unreq	flag_ptr
+SYM_FUNC_END(idmap_kpti_install_ng_mappings)
+	.popsection
+#endif
 
-	/* Wait for the boot CPU to finish messing around with swapper */
-	sevl
-1:	wfe
-	ldxr	w16, [flag_ptr]
-	cbnz	w16, 1b
+/*
+ * Wait for repainting is done. Run on secondary CPUs
+ * only.
+ */
+	.pushsection	".data", "aw", %progbits
+SYM_DATA(repaint_done, .long 1)
+	.popsection
 
-	/* All done, act like nothing happened */
-	msr	ttbr1_el1, swapper_ttb
-	isb
-	ret
+	.pushsection ".idmap.text", "a"
+SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
+	swapper_ttb	.req	x0
+	flag_ptr	.req	x1
+	mrs     swapper_ttb, ttbr1_el1
+	adr_l   flag_ptr, repaint_done
+	__idmap_cpu_set_reserved_ttbr1 x16, x17
+	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
 
 	.unreq	swapper_ttb
 	.unreq	flag_ptr
-SYM_FUNC_END(idmap_kpti_install_ng_mappings)
+SYM_FUNC_END(bbml2_wait_for_repainting)
 	.popsection
-#endif
 
 /*
  *	__cpu_setup
-- 
2.50.0


