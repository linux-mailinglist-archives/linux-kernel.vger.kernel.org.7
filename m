Return-Path: <linux-kernel+bounces-753898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD62B189A0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777505A2487
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83E28FFC8;
	Fri,  1 Aug 2025 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JkS333+4"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB223A9A3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092078; cv=none; b=ZocKFmDT3GLAysBjZlDPsHgiLbBwaula5q0vTWwNMc3d4jjgIgNhai12kCRaOVI+fo9IdTuhZm4UqiESUUvCSuRpmkrQ1RzVoO5mfgCtZe0EoIY8ka0HTW2cgnS18suZ0o5gVAD9QY8kf3DvCgP3LTEQxI+F9VJ2KaiXxHHrbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092078; c=relaxed/simple;
	bh=mwigh1V2idY6A9SL9/L28WFx/NM7jlg95nqe0sqP/+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hf7Rslj0UGN7GXyJRmAeFmAWruDYZNFqTomLy4vDr6ior65O1Gdo63IVM9OGV3dSn3YnRnF/qMfOkzAKFItoLVXX3Zwk00G2+lr3iWBpbjvrC3sPOWUYgeNPAtGBR66hUP+5iSVVMG809L2TsgRSN4SxRjG95nsysZkaSbi+uXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JkS333+4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoZh009340
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uwipLhSqn5UZC2Kg5fR+JZ+r9AkyBc1BguZBiS8eRTA=; b=JkS333+41vwn
	kPt021BWRQWDXTqSGe9/AzL3B8iDGkPqCU6ubnxO3W/AH47G2If56rMx5286oDEQ
	FiUKNGvaGaIfSGuABE6JWnMyrjNekv5IagiQdJfcmwaNjgUmJatWygsF4f1Kw4ll
	EmaSucgv9zpnIq318SV36w7qyi9CblG9XSloe56KdWPTHtS2MJFOyFouYHnYGV9n
	d9mcrpkmvM0h+EQX3Woa5enwDMagIvyeqZTQotxsuO4QgsC5wOuOFIq8qL6IMWtI
	FqWYNgpJO677xhUVWszpMcfVYF3R+IdIw7fubQfDm1W7rUVIdRuiLeErYfLIMTXv
	+9KjtD4MDQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 488rmtwjvt-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:55 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A54B73105E9; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/7] block: check for valid bio while splitting
Date: Fri, 1 Aug 2025 16:47:30 -0700
Message-ID: <20250801234736.1913170-2-kbusch@meta.com>
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
X-Proofpoint-GUID: ZepdBXsvEkDLcADmTJo-c0qY7pavh4aa
X-Authority-Analysis: v=2.4 cv=Vej3PEp9 c=1 sm=1 tr=0 ts=688d522b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=-ftljxYXmFZ9yweOdTYA:9
X-Proofpoint-ORIG-GUID: ZepdBXsvEkDLcADmTJo-c0qY7pavh4aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX0VDjKzENI4f+ bdaWW8Ihd0HYJbozXi2sJAf4wfD1BwqcCA5T3kMKTfLCS15ADA36ovWE9+uF7SQf4mdAd2BhJwE qU3lgnqKrXsldXzHa6/9r7G1LjnRoFAkZeTz3FDNOmxnIaBGrZnQIc94Pp3KlRQrKVP7IZUJDYt
 B61pI+YY8Sfqs1l9j7u6EbiKWmTmxs+hT/K7hlWysMbJqkfqne2Z7G59ySuVzb45koWKLTfakaq /kZZ4LTIzZdFmfLQzlrHfOZnbcrx8/pGj0KcN/EE4v4dKP5uHGKsjUFUTOvKP5aJB5kuKE6+2OW yIWQBO4BVDPoiWuodyf39g1YkZFGzER/9iE/ig6xRD3KpWz8B8FuAzjiqdppPpCp8G+yFjQkiVK
 p5QwFlACC9zeaU45b/pw82xswt26OySrO+IJyufrpY9W483rOiEdScVX7zAdv/n4Xfv2m38i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're already iterating every segment, so check alignment for a valid
IO at the same time. We had depended on these constraints were already
checked prior to splitting, but let's put more responsibility here since
splitting iterates each segment before dispatching to the driver anyway.
This way, upper layers don't need to concern themselves with it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..81bdad915699a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -298,6 +298,9 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
+		if (bv.bv_offset & lim->dma_alignment)
+			return -EINVAL;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * we do not use the full hardware limits.
 	 */
 	bytes =3D ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
+	if (!bytes)
+		return -EINVAL;
=20
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
--=20
2.47.3


