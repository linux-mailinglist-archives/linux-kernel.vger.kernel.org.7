Return-Path: <linux-kernel+bounces-753893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1809B18996
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68547AA662E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D5242D66;
	Fri,  1 Aug 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dl1NAjHo"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11A23C8A8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092074; cv=none; b=R9QFq4EAIwyB63EaEvauY7dRe8lJ4GF9Eo16LaY8tszW7M0ufJkDj2tFza/5HX/RlNEqVSp89+gIuKodJ8be9mUsyYTJWjB50oG3rheXQLKYHamKBdCMloi+AeG/JxpvpTmQ41X+7N2djQKlDTDKjkAFhOYOGaBRD8pebwxxGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092074; c=relaxed/simple;
	bh=gdIVjT3vlKOt+2mbfWTWwWZ2gPoA7XxoHfplCpsaon8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3LSbVAplP7ap+40fkQ5NSB7oVINI17xfqACxonT92FY7cLAnmHqDmEBvBxghBJjqwsRnJ+YbGqBnpoNEm8GcR0eFDT31L+9D7yRAckRAD6dLK0ZL1jVLKnBqmvauTBpE0m8z06eWxplfSYZp83DuhTMBaPh3M3UTHWxkOczzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dl1NAjHo; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoZX009340
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=1SMXkSebdaxUaoNdomo0qGyDMDQR8jUQzMvUjgNXeBc=; b=dl1NAjHoKtdf
	40azB8cH8aKrpu4U3nB5u/zuNbF0DRTB8fjdNMKIwt1sD9/ZeCMQdBAP4GcG5Ym+
	x/9j7HeJROiIgrlrGoEyeqLQTcJN+g/S+Yd0S518B8oKpx4uxfMxAoIhY71F4jvx
	5hbH220NfU28MPv8DuCuEmRnOZOWM+ZueLSTdESDWlH8u1I0dcFU4ItUKAJAGhT5
	vCbHMj9VZvn6pZ9R4I3+Pj+Eajbkc9/9bELORqhwDRn4hOxJagchN/iVX0DIDNQI
	z0b/tI4dP7rTs2d6YCdGfQVRnhjHtYNd5854I1HhNYrOKnmPOQTioiEpvV/b8rX6
	n9yiGf6ycg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 488rmtwjvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:51 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B2F063105EF; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/7] block: simplify direct io validity check
Date: Fri, 1 Aug 2025 16:47:32 -0700
Message-ID: <20250801234736.1913170-4-kbusch@meta.com>
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
X-Proofpoint-GUID: kWSwjiF5Msdou-mGkN737JN8qvIfc4Ev
X-Authority-Analysis: v=2.4 cv=Vej3PEp9 c=1 sm=1 tr=0 ts=688d5227 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=IZBY3vBkjIs1pqmLj1YA:9
X-Proofpoint-ORIG-GUID: kWSwjiF5Msdou-mGkN737JN8qvIfc4Ev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX+rMQWI48xmSQ IRErfzqAtCe8u3oI65y/cTSnLIb4OSRAiIE5FeUjHyp8lcrWvjbaPev44uhrSyWwfbAkzmGyqSq 3uH68Z7qH159/349yYHa4edTmer+I5jviAzQrQ8T6G81E6u15fYbL0Lh3MhNUk/RIVp9KNvVfB1
 BM+3iTyqVXZMoKd6mqeLqmwoK0zh6BWlnkwMP+oBbW2UUQmPVv/6BEDhAreoKIY0RYtf1VOl2SM GMSA8jLzZM9g4mfkFy40TN2SKNwvO2s5poDUV6kAzwwwXm3SovDb7eLrR4spYmJCf8PWSYKSOw3 qBGf0WdC+2Z+rAFfluG0+mN9T+kbu+7cqBOc9qsJlAZP3ADgzcP2uwg7fnJuXYnMh8eeRJ5WUma
 L+8wTpUsEO9R8inPsGwR/vIrencBR9s6ovf3Ol9MdgqnCmWIuizmQg07etLif6KrBi0CQ75J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..820902cf10730 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *=
iocb,
 				struct iov_iter *iter)
 {
-	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
+	return (iocb->ki_pos | iov_iter_count(iter)) &
+			(bdev_logical_block_size(bdev) - 1);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
--=20
2.47.3


