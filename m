Return-Path: <linux-kernel+bounces-756570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C9B1B608
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA047ABE63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416F27A11B;
	Tue,  5 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="s6UVlmlM"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B927932E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403102; cv=none; b=LezTEUQrWV+mBI96xPHRKxbfh+kDzWRYt0U2RHiNSf79sAwfTo47eX8Ns38te1Il7mGmZl011h4otByv/mQmr+GY148qmWoJMKgDtXCXYNClvrnanu7FZ7rQAMPpYXRUkI0mSZe1KDJ8Fk58L+f24ZoueG9o3fr14x01N4hX8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403102; c=relaxed/simple;
	bh=217BAp3N2TcMgRHsWuPsd7Pnl1izLEcPCuLPqohkSIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtEkZhwp4khFthw1CLnVkhotmggmRW4FB4pp+pfocJOzWQpAcBGCEzSdUzdU6QWwj4rl0Z6ArQ7R8NuRO0LRgOiX/QmPW6/NMGr9I1ELRNvv+qx38ll5J3pAiAkQnwJMPLBMPfbPMOPJm9AHGWYqadLdaIDijP0YG2padRT3sDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=s6UVlmlM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYPlB027939
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zgrNuG3G/M3gaTF6K8yK6qYWoGlB4OA/aJqjedkrpCU=; b=s6UVlmlMIiIA
	TpXkv7Vxwkl9yMkKwq/Ni5s976jMHaLZb8cmwuGGc9bdQzWqnbaHj3QWtOBI0DWw
	dFueFntnI9VQ5U0eX5eyHcr/9eYVDYrBg5pE+keDARyaglOkp6tUp+hcvTNlad0q
	7kSPIEp2HuI10MV+xE0TkQ60s8txfFIGOVoUJ4po6AnSMsXr+uuSv7p9kUK4s3op
	9+5VAyhVht1TwMmJcH8cdXEIuskRRSBM5Ka3EHJ8kHIM+ROOMj//h0nWooQvOT1s
	M4ZT8zGsvCv8vuGQJoVXzQyQmSvyIZMlPoTgzA3kilAQ9q5XNpXNKh+fQt/s88to
	ablk7ET6Sg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b9033jak-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:39 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A0FEC4FDD4E; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] block: align the bio after building it
Date: Tue, 5 Aug 2025 07:11:18 -0700
Message-ID: <20250805141123.332298-3-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=H5Pbw/Yi c=1 sm=1 tr=0 ts=6892111b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=o-Erc7oKPJV9jR-t85MA:9
X-Proofpoint-GUID: KCS1CChV_RK-3RUAURPKsZ7JlJYiVKpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX1BAM+Yw8lD2m 3vMiQ5FgCizv757stLIuzzRXj9o2315CqLJQ50ouiuLUICeAWIgRqkJPUxyxnzSbOYXSNwuizgX b/t9KFqKx1OBonq1hg1Li0R9pQWCeyWVMBSzH/99vTlJWukff2wfMD7yPxtNnBaXDLUCtx56Iv/
 zYLR0C8EmIWPcIL2LPUU7er4RnI89Mwk2gzAVqPGUKzGJOPaO5tA8T2wHY38JpRDxFJild4cIry 8tLMV312MqhoTy0VvHfPST/togiMYP2C1y42wrnR3cSaNP8FEgVroQvuoskT+0a4EiesngmqL8j 3rwMuoWbPNvzUbO71PV6B+XyRACwgoK4rF4X0pP4Yz15veHS5JXdyDhqQUP2LVGRttzyIHpsziR
 POSJQuWDyfcRb9IkR6yUxSkz1+n9NKPnhZMLq44jHM7aGhe7EfbNpOb0rSbzH/SltWfRoii3
X-Proofpoint-ORIG-GUID: KCS1CChV_RK-3RUAURPKsZ7JlJYiVKpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Instead of ensuring each vector is block size aligned while constructing
the bio, just ensure the entire size is aligned after it's built. This
makes it more flexible to accepting device valid io vectors that would
otherwise get rejected by alignment checks.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 60 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 92c512e876c8d..9ecd546c5b077 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1227,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |=3D ITER_ALLOW_P2PDMA;
=20
-	/*
-	 * Each segment in the iov is required to be a block size multiple.
-	 * However, we may not be able to get the entire segment if it spans
-	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
-	 * result to ensure the bio's total size is correct. The remainder of
-	 * the iov data will be picked up in the next bio iteration.
-	 */
 	size =3D iov_iter_extract_pages(iter, &pages,
 				      UINT_MAX - bio->bi_iter.bi_size,
 				      nr_pages, extraction_flags, &offset);
@@ -1241,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 		return size ? size : -EFAULT;
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
-
-	if (bio->bi_bdev) {
-		size_t trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-		iov_iter_revert(iter, trim);
-		size -=3D trim;
-	}
-
-	if (unlikely(!size)) {
-		ret =3D -EFAULT;
-		goto out;
-	}
-
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i +=3D num_pages)=
 {
 		struct page *page =3D pages[i];
 		struct folio *folio =3D page_folio(page);
@@ -1297,6 +1278,43 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	return ret;
 }
=20
+static inline void bio_revert(struct bio *bio, unsigned int nbytes)
+{
+	bio->bi_iter.bi_size -=3D nbytes;
+
+	while (nbytes) {
+		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (nbytes < bv->bv_len) {
+			bv->bv_len -=3D nbytes;
+			return;
+		}
+
+		bio_release_page(bio, bv->bv_page);
+		bio->bi_vcnt--;
+		nbytes -=3D bv->bv_len;
+       }
+}
+
+static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
+{
+	struct block_device *bdev =3D bio->bi_bdev;
+	size_t nbytes;
+
+	if (!bdev)
+		return 0;
+
+	nbytes =3D bio->bi_iter.bi_size & (bdev_logical_block_size(bdev) - 1);
+	if (!nbytes)
+		return 0;
+
+	bio_revert(bio, nbytes);
+	iov_iter_revert(iter, nbytes);
+	if (!bio->bi_iter.bi_size)
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1336,7 +1354,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct =
iov_iter *iter)
 		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
-	return bio->bi_vcnt ? 0 : ret;
+	if (bio->bi_vcnt)
+		return bio_align_to_lbs(bio, iter);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
=20
--=20
2.47.3


