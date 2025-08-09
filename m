Return-Path: <linux-kernel+bounces-761109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A0B1F47D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D29566334
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC227FB10;
	Sat,  9 Aug 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="t9MEV8mJ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466B18FC92
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740762; cv=fail; b=Sfqe2Na053Q/XUB7UGtYDXWvNQMYGn4n3pyMU6YEAayIprzNO9xUr+F2223nKblXUSww0qI+DUN0aud6AVcR/5rjwa3B/V+rRSUipp4ys51Wz//A9CXf4G3/dtz1gONuaw7fo6k0wLgq9fDcwA6XmP/f3Obz979+57L45jM80BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740762; c=relaxed/simple;
	bh=nxF24H3zGL5OaUdhGlr1CsDoHlYiSifb6amb7iTu4DY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aPzsyjWUmNaxlLyTdCDwmJrvKb2sRh2OymGw75a74YTunmf/P0X1fMO8d7LsbtlYf/Jt7A0yaT0jihX3FBRKjZscS72btmjxlsfbY1iMoe6TG+xwho8+4ZvPueuxOu8t0d60Q4zX8zXQiceGmXnhY2aFADqivlRGL5rhbxwgqNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=t9MEV8mJ; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQA3u7RKtV38neDKX5btPgVp6x5OFd1SAkTt/srnA9Q64/timFPkw+yFN/3IYSQzOiQKEgOeXW5ar3YmdbaqHhLVaWFxmgWH626iuHQobpTxAdmfkKAnUauvseubDxf9/8F2BqI8IFKcY+yxfG7u1zIUM2QftaxBDCE6Y/HQfL9SrCzEFspyKNDJRW28v++C1XJVEjIxrtavwpl6iklBFZ6926YZf0ut4anbUKVCNx0N3YYNlEvqIjNM6Eh5Lf+C383g/uksvGQfPDCO9WupZDeFzJXmhKftViFjsniOn6g8v0jngurbcL9ccaHj4A9u3NV1XKqauG95KSe0b2hEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpogrnmNXbs7L2SYwjsXSswHpfTMlfEwAVkljkW7XBg=;
 b=JCGgcwzMBXaHkVVdvYdpFkpe3gFyfVpso18q9j9QLfrYJAC5vxSC7/g6wMDWCjnS9SH6q7T0zuVHGkApdW47tKbl6xso8cKo/t1yIGGE02LGWi8s8YyGJ+sIkPZem15PZxrWwJfv/9hMg6T3VMv5cv8rUwB1uwZYMSAfS6lqcYxpmNIvnxKE4l9Po8hXSWt/CvCyCI3FhJ9dGp8XWan6WT5KzE06hNOlze5GcbDtFzXwKW7czUthsebV/q4JHsrydG0rkFhHyDr+A5GliVWZeLMxqmQLLuI39oFf7qA4OhTLidDIfqVIEmAPcBxrkiMb6Bm+nLmUA4iQ84CtJCmfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpogrnmNXbs7L2SYwjsXSswHpfTMlfEwAVkljkW7XBg=;
 b=t9MEV8mJOWdgjo3+NfE6Lzr3z2lMXMzuGOUfwldI6s8xFk/dTIctwLZ6D1koqikWt/jK5E091kuQTSRJCC7eVrLFxiM1qmiRC3A/l6qdElpZ6KaxYOvppWHYh7uhwxISikrqHO+Cy4nmQnrWlLrmTpo0wNZpM0FATxrjkjY2OAIqBU+gs3P0vxnUMpzhfP+xkIBRzu1ukJctpFxgOyMnPAtvzov2VxRsACTUzrRSfG0xCeb7pS/rq0CB7o1RlH9fZHz6CeW124+EFNGP/7RTOgdbZE3Wgu34OHeHMAoq3jmdvozI+LNPKA+OR83Mchgd361U/x2r9oAUKk3JvzaVnA==
Received: from AM9PR07MB7811.eurprd07.prod.outlook.com (2603:10a6:20b:303::22)
 by VI1PR07MB6463.eurprd07.prod.outlook.com (2603:10a6:800:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 11:59:17 +0000
Received: from AM9PR07MB7811.eurprd07.prod.outlook.com
 ([fe80::6891:ab46:309c:2ee3]) by AM9PR07MB7811.eurprd07.prod.outlook.com
 ([fe80::6891:ab46:309c:2ee3%7]) with mapi id 15.20.9009.018; Sat, 9 Aug 2025
 11:59:17 +0000
From: "Subrata Nath (Nokia)" <subrata.nath@nokia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: prevent RCU stalls in kswapd by adding cond_resched()
Thread-Topic: [PATCH] mm: prevent RCU stalls in kswapd by adding
 cond_resched()
Thread-Index: AdwJI9DGIQFwZQopSbiFIrzGx24uNg==
Date: Sat, 9 Aug 2025 11:59:16 +0000
Message-ID:
 <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7811:EE_|VI1PR07MB6463:EE_
x-ms-office365-filtering-correlation-id: 3ccb08fd-ad17-4d9e-8be1-08ddd73c2aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RMB9sr6FPiomRbAjBuO35cMh+4Sosy3nDOno6a0KQuFA4TsAfwzoNyTTGk8F?=
 =?us-ascii?Q?zfpcmqk4U/mNBMyAvFKwAvWxJBG32fZdOR09VgCUTrs7IhrprXFxGg1ryoAg?=
 =?us-ascii?Q?bjGEjmI4FwllyenXoYi43Y9oPoW0s61q2db/QW091v+hHvmQtSdKdLLPUAKG?=
 =?us-ascii?Q?VRPywqg0Xqjk3fFkZeLscxJOICrp6kx8H7h1Rucghi1T8NlXKYMPaHj+kUk3?=
 =?us-ascii?Q?4fhpUaauBia6EFml4YIOugEi+0D/J+v5r/z4Iosq2gN9Qx5y/UMWdTzo0eIM?=
 =?us-ascii?Q?SMQ5vVveKEtKpMRVKqNHmin3bcbn88rtme6gtVmnQMlw0btMYDkDZ0GKvhZA?=
 =?us-ascii?Q?CXggic2FWrwLrAFGrctRxIwsSoHN2+rZH/YsQgcfZKndxijg3iluOouu6UIe?=
 =?us-ascii?Q?qcXLXxxkpkV84FGV3WVcs/PZeV+AcOyzLPI4xy5DlNzH5T+54f9BuNq1tltv?=
 =?us-ascii?Q?x09ZjJgiS7FU/uM/sdVqkuk4ZwihKaYE60KwYvgFL/jVBcxDl8wAAv3hAxrO?=
 =?us-ascii?Q?fYqib1KkWJ7axJFkM4zSDDWmDrYhW3aLKAxWCFMjtSaVaHFszDG6QP1POKl9?=
 =?us-ascii?Q?BmDm/OENHqQpkJXc/izjxkQ9pKojSN4XReoAK1pskQ8g9NXyAJgVX5JooQSW?=
 =?us-ascii?Q?LVArncc1gnKhvzck79jfvxseKCOmzllcjzo8sz8jISHrFklDW4WbWrrsm1Si?=
 =?us-ascii?Q?HhdjuUs7sAEuJzkmgvrucF7JJLPJqUNykMA+iTdXhm1ZokpJeiBkueyPH/ln?=
 =?us-ascii?Q?OwH42D/KJNfvwMKbdPpc27twRr0MwTXn5j72dCoQA2YSzrEBHEn5KmPYNt98?=
 =?us-ascii?Q?Yy6K34sXqWOi7DzIsNWretFJ/jmU+wTL9YczAvrOYsaR+R2zGdsj2N6LBKUv?=
 =?us-ascii?Q?Ooj1mWVeVa+bP71R7Yqy4m1eLarz/W9/xelW0NfxZFlhrxf/T1lAf5cuRSVs?=
 =?us-ascii?Q?O0DoQIOAbq6F2F2Oq7clo19ef60a08qZvqzNNED3kiOaxfgIVPUz007TSHjj?=
 =?us-ascii?Q?KcMH6YJRf94xKREqt9GviiPZRJk4V7f3UPwIhNSrBLxh4Uz52r4Vn4BR6rTw?=
 =?us-ascii?Q?607Hai0AzanWgis0sQ93B2srmKrWi35rlo8cejvRr8cckX5epnuGLNEwHRjF?=
 =?us-ascii?Q?LoCJHQaFFmblvxteKGxcjU88cWXlbQAiVyWOqiQhFjoa/+vHHx95Ea+d4lqD?=
 =?us-ascii?Q?9slx60i1Tg4pCFdqBE3S9286DcQMz3P99qXx9SqctjHHB5YmCVqqG6PnsSrx?=
 =?us-ascii?Q?vRVpfCLZbJ7wI7W/OVLy0Hcq7/KlDwWzAKY0FPDV0uG1Bw6PQRIXnWb271An?=
 =?us-ascii?Q?MSKMQHRAWAA3KfhkYjkh4iQWXir3Et4Xh4YT06lszG80CNS/9PVogb4sBpw2?=
 =?us-ascii?Q?MNJ8DrhL0Xy14x5H2lQNx/JG/vRkwglfYPwjpFSG2VO8K+gJ17URPPYThrTa?=
 =?us-ascii?Q?WPeIa8jQsQW+q8VSAQIl5XBHohoRjrGxSXhijbXzMP8OOVRlL1uL5Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7811.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0LxDjCjv5hhKEfPSOSBPwz1f1Pj9y7+SbEDIqsE/Wt7jJTPraN8+e/FIRAZi?=
 =?us-ascii?Q?jgepohsAHKY40piE7mLWZ/YxuMd3EfeRzOMEjP4okoE6GMRXkghE2APnKhy2?=
 =?us-ascii?Q?IO51CfcIfabdR7EfA0b5gn0CfMlphwO0+8q4T1URapEx4eWQLBRBBzLC5mxD?=
 =?us-ascii?Q?L4sgmKRaSDZZs74MOzs4cSA3bAIgeTRi/rI0mU99iVrSgim/DTx4eKM2o/IF?=
 =?us-ascii?Q?M+lxjejoF7K2JXYCOYxg0rO2yD7xji6EZVAeCQsmA/mlbqG/pU7Rcm6F5E4a?=
 =?us-ascii?Q?67Af6/Gg2C+vIzZs3BrGZQKJ697HYNLryIPT6armZUCSZouiwtpOwLK59kh/?=
 =?us-ascii?Q?pEEviDWWpkaOlITnaW6ajmwK7r6Ws+ObMIoT8cPj/ZywC3rS9CWoZfUfezWq?=
 =?us-ascii?Q?NR0T3YeV8b40Y2Jbgf0KdFJy20q0gJEX/o4OL5Fvzg15yS0Krj+ihj4OCZVz?=
 =?us-ascii?Q?HXxZ1YDLqajANu3NGeZ0HJ504yWzXNAkcjPExMBE8hV24AsmCdfZ9P6KJhFZ?=
 =?us-ascii?Q?r8JCGB6BcfL+dSn6UTqgzYzUoB9L+/28/NwfjJSXfYAtaHiEGTrzIgWpbmCi?=
 =?us-ascii?Q?sCNGS6SqCg1HiY2mngQ4K+I00T5XwT71gCb4X2Yq7mt48016z5lTVXd0BPmk?=
 =?us-ascii?Q?ixn8Bp2KnCbvkzkFKPHTcVc/t1X0ruL19NFGVUaAjUqM2qDFeayIVyKCkZ+s?=
 =?us-ascii?Q?7nLOE/VkgDzvs2D2bsv3AvTVEVKnCYnBHcRpC1MSP1n70+tnTrYG0Lh3XvWv?=
 =?us-ascii?Q?QqvAe4Ert2iF5D0R6an2+1qnoo74rhV91qtIUgaoZ2KVkySqGmbfXeuXxqvX?=
 =?us-ascii?Q?GENbBUyWOCbpYcHOn7rukPni/Y3HT89uE+nP02OsdA/uQJc3HQoasP9fA953?=
 =?us-ascii?Q?LZUpln6tdaKtJLaePlKN9qgne2S6a7cF/xPx8nR9paXHDw4M4K393z4eNsgd?=
 =?us-ascii?Q?hPBQhrXGUQdK4yt6PrY0tH4+MfUCiwZsVZgKKVzwHnjYwgetpvY0EKRMmekG?=
 =?us-ascii?Q?kp38UUlDT3oLZuLct5q0yd9PPAocOfdIbTGidsk39zuNLQbsLxFZMIpxSmOk?=
 =?us-ascii?Q?ANytgaGn8Qjbrz1grsruXjd0w+yAh5na9eIpZjkfIhit3of8/SQDaCB/+Cp3?=
 =?us-ascii?Q?tVzzDZB5+EzE7tr5bSyqzQqRu51QNwUbXneI8L7mlVUYG2T2czOLNhvhbkoP?=
 =?us-ascii?Q?CycTzcSWf+g5GzzedhQHjBVwTp3cZJVY2GWAhxLb/XgzAOuu6bOd9b0vHDtf?=
 =?us-ascii?Q?Kqu3FAhS2siFUrdYx/3UOyHWyeF/Lb1xsAJ7Zm7fUXMKNMNDE7pQuodt5DHw?=
 =?us-ascii?Q?harhbarF1CyA5pA55bwpbOwzuqhajMxe6BgpC2zBW8c66MIY0bEenzjvLQFt?=
 =?us-ascii?Q?x78L6QRHcVvJn04SJI8oROv0Clb85tGweQqCO+7bT06G+mPyvYRU15WGy3wM?=
 =?us-ascii?Q?cdIbLjREQA2T70NiHyiMsQoRgx4m7u5YuhVH202aHD0u6yJhyjUYA9uIdW78?=
 =?us-ascii?Q?KrQfyHuT4H2Eh4FdondpEK/3Nn8VZiyx8T7KtZFiesgOmLPcHfHykcreTJAV?=
 =?us-ascii?Q?rZ+wfOcC+HjvM8MYQhrPEnkNBOnnN/X6h62VgV8e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7811.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccb08fd-ad17-4d9e-8be1-08ddd73c2aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2025 11:59:17.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfcaBNudHSIcTA7yWLWEAsiYIGxM64aH0jcmAXP9NpBHYkFn7/pHCbjNKTjM/m3O8E3zzZu1Bh6PQAKprrIK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6463

From b21478b5333e2bf48391914d109bfd97a50d5203 Mon Sep 17 00:00:00 2001
From: Subrata Nath <subrata.nath@nokia.com>
Date: Sat, 9 Aug 2025 11:08:30 +0000
Subject: [PATCH] mm: prevent RCU stalls in kswapd by adding cond_resched()
Based on: v6.1.128

The kswapd0 thread can spend extended time in
page_vma_mapped_walk() -> queued_spin_lock_slowpath() without
yielding the CPU. Even with CONFIG_PREEMPTION=3Dy, the rcu_preempt
kthread cannot preempt kswapd0 because preemption and interrupts
are disabled while holding the spinlock.

Example stall report:
  rcu: INFO: rcu_preempt self-detected stall on CPU
  rcu: rcu_preempt kthread starved for 65939907 jiffies!
  Call trace:
    queued_spin_lock_slowpath
    page_vma_mapped_walk
    folio_referenced_one
    kswapd

Similar stalls occur in shrink_zones(), where long-running loops
prevent CPUs from reporting a quiescent state during the RCU grace
period. Without such reports, RCU stall warnings can escalate to
soft lockups or OOM kills.

A quiescent state is reported when a CPU exits an RCU read-side
critical section, enters idle/user mode, performs a context switch,
or voluntarily reschedules.

Fix this by adding cond_resched() after all spinlock release points
in page_vma_mapped_walk() and in the main loop of shrink_zones().
These calls, placed outside spinlock-held sections, allow voluntary
scheduling and ensure timely quiescent state reporting, avoiding
prolonged RCU stalls.

Signed-off-by: Subrata Nath <subrata.nath@nokia.com>
---
 mm/page_vma_mapped.c | 3 +++
 mm/vmscan.c          | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17..7775c151f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -234,6 +234,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *=
pvmw)
 			}
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
+			cond_resched();
 			pvmw->ptl =3D NULL;
 		} else if (!pmd_present(pmde)) {
 			/*
@@ -247,6 +248,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *=
pvmw)
 				spinlock_t *ptl =3D pmd_lock(mm, pvmw->pmd);
=20
 				spin_unlock(ptl);
+				cond_resched();
 			}
 			step_forward(pvmw, PMD_SIZE);
 			continue;
@@ -265,6 +267,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *=
pvmw)
 			if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) =3D=3D 0) {
 				if (pvmw->ptl) {
 					spin_unlock(pvmw->ptl);
+					cond_resched();
 					pvmw->ptl =3D NULL;
 				}
 				pte_unmap(pvmw->pte);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index be863204d..02064b4fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6415,6 +6415,7 @@ static void shrink_zones(struct zonelist *zonelist, s=
truct scan_control *sc)
 			continue;
 		last_pgdat =3D zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
+		cond_resched();
 	}
=20
 	if (first_pgdat)
@@ -6490,6 +6491,7 @@ static unsigned long do_try_to_free_pages(struct zone=
list *zonelist,
 		 */
 		if (sc->priority < DEF_PRIORITY - 2)
 			sc->may_writepage =3D 1;
+		cond_resched();
 	} while (--sc->priority >=3D 0);
=20
 	last_pgdat =3D NULL;
@@ -6508,6 +6510,7 @@ static unsigned long do_try_to_free_pages(struct zone=
list *zonelist,
 						   zone->zone_pgdat);
 			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
 		}
+		cond_resched();
 	}
=20
 	delayacct_freepages_end();
--=20
2.34.1


