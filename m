Return-Path: <linux-kernel+bounces-753899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CAB189A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057BE1C283D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F941291889;
	Fri,  1 Aug 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Zxl0xZSa"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58C28F51E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092079; cv=none; b=YP0Dg00GYeeTz7QHAKc4oT9J0j1Ip6eQD79Bke33UEFNFIrfNyePB1JI1O4aDNyueQwGbiZL84PTYumwwFw22PVgyhSTI/vMIxiN3dV1ro4RvTU7bOQshLoaGeTlH5GSDt+ykHsSNqKmS4svZ5n76mN4FFPVT5W8al17iuJkTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092079; c=relaxed/simple;
	bh=OMeezIS6H4pb0DAO1sPwLmLYxQE9W3UpuZAe54uaBm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYqFIQcUPXaOZ1LGXbv2+THX14Hw7uJq56xjerfad/zdUR/uuhtOTIZAtpk2ytfdtaOedxk9XeE2JMkAsQF91ZOxInZOJqbaRO339DUWyg7Y1U5rCNtTGboZLi1HiPndvXbQSIvS3mQOlXDrHhqg6CiebrxD+fc7blafyno4fbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Zxl0xZSa; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoZj009340
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pnnkPBGQ0gRBLybx/TION3BTRcap0tbm0RMeiLyF+rc=; b=Zxl0xZSaUwtj
	aBOHhx32Oa8mYi4FkV+U3tNqJj36xQOgeLkrCxjO1iZY3cl+cFiwC8ShlJ0gE3H5
	yj9G5yp3uVPHxvOSTLtrUIga7E1JljZJOwAUHfSfKpqYQNMPImidO3lartdHxaKv
	i1kWYO1PGA3tvkVPPvzPZNaFvBIQvYSSiaGtYdmF6Fari8NvVkdwXqTIISeWlOkT
	F3/ckY4e8N2Z4r24yLl6qzWNqaaSywTY6q0k+zerMLgP4kJbvqbYnlSZNemnEjJC
	BOZBgaAaDmqafvDyLKrlbBHdO41WHbU8yRKWkqZBbAz/zYrA/dMsEgcPLZDxnnkJ
	v+GwUkIbVA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 488rmtwjvt-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:56 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C96753105F6; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6/7] blk-integrity: use simpler alignment check
Date: Fri, 1 Aug 2025 16:47:35 -0700
Message-ID: <20250801234736.1913170-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
References: <20250801234736.1913170-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: evrwWPH4kvouKPRLjZbBFXRjVpuTR3jU
X-Authority-Analysis: v=2.4 cv=Vej3PEp9 c=1 sm=1 tr=0 ts=688d522c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-ORIG-GUID: evrwWPH4kvouKPRLjZbBFXRjVpuTR3jU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXw3J2AT2TSi5l cN2LnqeNTi7POa96vbpNlzo1P9JPvlLSxsmD4wXoOFz3SoTwCPZe7TJlRw0F01RnMu07/aJBJCr XdpI+x5aic80ydkgUo0qBLMqpX5FZwRNSTYmNa1sjj1wejFxKjbX8Qoy6RXysLC70DT7piKTm7V
 Lw2l1vZaDQ2Z52DXTQVmWcRLZ5cMfq3gXrrt2ZQ6/saXjMHDOJj9rNzS3RUt0H+iMf5/LoJXsHf MhXDluNPPBijkrtQm8aeockEkgVGhReHbG4+vjjMb4IjZcoHjXfFtZuTrNKNZlvPUGeCBr0YZSs r6p6Wfvw4yiPDXLD/mlo++S45Zmn7rAwZinsOeafuFKlBQAUl2/qnEtgmpMIhsx+shNlHuG7Yq9
 rNpbTut6fDM/41QwJloYM3zSH15u/8x7Z9NwMjm0zi0D4OE504IgrKwUXsyx895h15VO+08x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..6d069a49b4aad 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -262,7 +262,6 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
 	size_t offset, bytes =3D iter->count;
@@ -285,7 +284,8 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
 		pages =3D NULL;
 	}
=20
-	copy =3D !iov_iter_is_aligned(iter, align, align);
+	copy =3D iov_iter_alignment(iter) &
+			blk_lim_dma_alignment_and_pad(&q->limits);
 	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
 	if (unlikely(ret < 0))
 		goto free_bvec;
--=20
2.47.3


