Return-Path: <linux-kernel+bounces-756566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34FB1B61C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A331883242
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB93275B01;
	Tue,  5 Aug 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hkR2yLPu"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B16238C16
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403093; cv=none; b=WeGkSDqX00jJfdXm8g31L8XeLNIa6H1zGzwrfM4QskJPJk3HEKv9yrKloXSi585zfthy0l7X+462yghA3QWUifGCXS5FlW5KlCr0E5xXbpSK2wWTDfICHvwH14Y4Ye4xbVzHbyOoPTASlbDAc59w/IOnEpuE4tkVpsxcYb/8xWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403093; c=relaxed/simple;
	bh=X4TiQRCAyimCy235Rs2X/10FtaUcKM3owhi+6iQOMAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zuxuu1EYyy+bScneP52nxSvZ4Oj5K6O5h7nirGo+5yC157TeLDE+ruqO9tnEd6f1qHlIRs+43TL+jNNGB5obPb5dlDI+Kt8MltxPat+a0bTeXmwZo6BapctzEkWWgPn4hwYAI/YKLKQFqve7Gx1V0eQsQw/yUEL0c9z26G8sEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hkR2yLPu; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYAn4012587
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=47Zm63PeojXkiJDTke1e+5K+CoKyN+QOtXjqL/eR4fI=; b=hkR2yLPuXL3c
	T4OJWpbtm0y6QaoX8srv/czAM5dXwaTUXGqfSfq7O4ijp3RhwkLuJ1FlAMibpsn1
	9twetMALR3ujiphrmmIkLNJZmGsJqJLzS/dybmEgxfvopSWHoirWgMSZljGBm5Lw
	t/mDsVZvg6XBtS3YWppCeIvrxGeG+rDaLDyxneZ8iok5fhxYu5WmqqA/o3jB7tGs
	DhGAl4kDQRwe+6FDpCFkAR3EBhSwtLijL2DgcfCNAMjUBKawOBdmq2x9xvOu9at4
	pi7NT8w+8pyovgjLlXyjgJ0mkXl2/GvCbl2HxRnQY1SNM2XaV3vMon5dDZ9mUBEB
	JjOFq9T2KA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5tacu54-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:30 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 041A14FDD55; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 6/7] blk-integrity: use simpler alignment check
Date: Tue, 5 Aug 2025 07:11:22 -0700
Message-ID: <20250805141123.332298-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aYltHR8OZ0u7PACpUSo8SNwvejaqEXq7
X-Authority-Analysis: v=2.4 cv=RJOzH5i+ c=1 sm=1 tr=0 ts=68921112 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-GUID: aYltHR8OZ0u7PACpUSo8SNwvejaqEXq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX8E812QucSl8G rZXZQ7BbswyjSSS7ANYhYj9HflwtT7NQBk+y2YKtHSAyqwpZXOUu4ll7jjNWo4nDhCP1vW1rfQN OzvITnLZab7qja95Lxzbpn76bVcl5YlpFRtoeETcVfhQzSO3BU9ZgOZGokdJyPv00PIbY4layL5
 bGcuGaY9HUgx17nAPO/E1ub6oYv5SA88DbmRII++tYUBnxqMT8jke1xNcPOxUu9xn2SfD2BoqM8 EDewlpkP22M9XDECuwUCi6hyg+/VUJhS1DftiY10qTKfp4fcYHU3oVj9kof9Fy3le9J0q3vAEdQ cJDCWBAvwdtdB9FKVl7x3r9VtBCLbchZfYNLJOXJ1r9y5lMUciQiJZi3BSHhrrM0kh1x8x08o+M
 Mt30jyXMXw8sxAOZdjHeeU4q/WhykOrsYpxmtEBvlFe0agK0hwSBjPRntm0yFqjeVLb9ise9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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


