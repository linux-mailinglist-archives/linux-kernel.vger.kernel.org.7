Return-Path: <linux-kernel+bounces-756568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E1B1B605
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838653AFA07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04327934E;
	Tue,  5 Aug 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vR4z1u3E"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7223F295
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403096; cv=none; b=H+fgxvlc+VzA2PR8kcGhV27qMkgMZDh4URHhZhPUNrCLpKACYXVzxw+Au3NxxqL/z783D08dEbdROzpa/A448RTvtIP2qFdLRu6F6/vzU9gIOdiOo3ovRwBpl7dnHYx3Tv7wI1IXX2Q8abgKmO9zeUUXcfcWcgbTYsMVD9yqD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403096; c=relaxed/simple;
	bh=UVyMyNSWmKVpdo2b8zlviQrB93mojZdGTaqeAGXZkZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MetkCUW+eRsJGEUJ0Zqtld6I/2vtDU46sSoiEfad1NhfPkh2MmVRBoehJr9z2RyK5PlZxYGe7BNaGqkEc+2zQEwIEKi+3K8dn+fbwqXCNNzQ9RitsBIIzIRSPJbhWFfpETzlktgV8ojX2ndUqPMKh0k46R1XLnkCZ0s91SclJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vR4z1u3E; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYQMd015353
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 07:11:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=q9rfR/CPErdS7PfZ2eWN7JXXGJ1kaWhdntYdyMqVQE0=; b=vR4z1u3E4IGd
	cvf9AjEaKuc7OIhjv4AsUrX/xXOWuXH85irR+j9HGampukqIwqcpl5jBcWYf6O6A
	FV23TZPoMIko8cyNDuCHbe2Uqc6stltlfgZfCoi8rKU6I1amt26q5MGvqYG/wW+a
	BR7glaVT09yW5h7UZg0fr0yWsDOzz2LuWJ36gDSykO3/DlrfNHQksVKDp/2aRRvI
	WJWrLNh5XgBMyEZBhHvMaXzO5jND42+HFhEct1aKsT74bZA7cFiCph+d20R7aSsU
	8Jq/CjlW1+YWu46EYIuZx/HVydb+FjvlrshKVf4f7q30V/ziS1mTExPtG/3smSOi
	VpTEQKQpsA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bdg9aay0-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:11:33 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 05F1D4FDD56; Tue,  5 Aug 2025 07:11:24 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 7/7] iov_iter: remove iov_iter_is_aligned
Date: Tue, 5 Aug 2025 07:11:23 -0700
Message-ID: <20250805141123.332298-8-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=dLymmPZb c=1 sm=1 tr=0 ts=68921115 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=S-mNSWGAXQVMvOK0xjcA:9
X-Proofpoint-ORIG-GUID: GFOKqPGi8s2sQ9K8oWaLFPNaiIJFLeTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX7/2ZOtY9qXys m0R4gNefI442CYuFQU75Elc3sOnT6vPa8d625P4n83PzIi6aOKBzgB8YPBvKYwmNyMMFlSll6Pr /1GLAUkRxpilGCTqB9Ts6VE7z1oE+JRzC5Y3gqANOIwhNFFc3tvWHIOkBStJsFTUxVDJ5ZEiRSF
 GDERkkHXD8BKPLQ+St70U4I90kQnxJahcRwzxpVpbXM9X2cnqAK6crJSt9wJRs7ZDRswISuHWoi tvlyPcZjS8TRE52TG11c5JS3IcGd+frFZOTZDn1TIwiCPYMNX7nU4s2c20SvTKys8l14ly6v64M iV/9bve138IXntJ1MxaMHf0LnVsWROfMNXSc+JgcybFxMZoELxp8Sust+xfMK1EGEWp/PxKtsC9
 kFeeFMa8c4VCAla3n9iu1XeNp+Xo7b1/n11uLy1Oyo7XZ+baGUP9KOCQ1crIHZWf6x3zRmS9
X-Proofpoint-GUID: GFOKqPGi8s2sQ9K8oWaLFPNaiIJFLeTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/uio.h |  2 -
 lib/iov_iter.c      | 95 ---------------------------------------------
 2 files changed, 97 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e86c653186c6..5b127043a1519 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -286,8 +286,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t byte=
s, struct iov_iter *i);
 #endif
=20
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const str=
uct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f499..2fe66a6b8789e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -784,101 +784,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned =
int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
=20
-static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned ad=
dr_mask,
-				   unsigned len_mask)
-{
-	const struct iovec *iov =3D iter_iov(i);
-	size_t size =3D i->count;
-	size_t skip =3D i->iov_offset;
-
-	do {
-		size_t len =3D iov->iov_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
-			return false;
-
-		iov++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned add=
r_mask,
-				  unsigned len_mask)
-{
-	const struct bio_vec *bvec =3D i->bvec;
-	unsigned skip =3D i->iov_offset;
-	size_t size =3D i->count;
-
-	do {
-		size_t len =3D bvec->bv_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
-			return false;
-
-		bvec++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-/**
- * iov_iter_is_aligned() - Check if the addresses and lengths of each se=
gments
- * 	are aligned to the parameters.
- *
- * @i: &struct iov_iter to restore
- * @addr_mask: bit mask to check against the iov element's addresses
- * @len_mask: bit mask to check against the iov element's lengths
- *
- * Return: false if any addresses or lengths intersect with the provided=
 masks
- */
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			 unsigned len_mask)
-{
-	if (likely(iter_is_ubuf(i))) {
-		if (i->count & len_mask)
-			return false;
-		if ((unsigned long)(i->ubuf + i->iov_offset) & addr_mask)
-			return false;
-		return true;
-	}
-
-	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
-		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
-
-	if (iov_iter_is_bvec(i))
-		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
-
-	/* With both xarray and folioq types, we're dealing with whole folios. =
*/
-	if (iov_iter_is_xarray(i)) {
-		if (i->count & len_mask)
-			return false;
-		if ((i->xarray_start + i->iov_offset) & addr_mask)
-			return false;
-	}
-	if (iov_iter_is_folioq(i)) {
-		if (i->count & len_mask)
-			return false;
-		if (i->iov_offset & addr_mask)
-			return false;
-	}
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
-
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	const struct iovec *iov =3D iter_iov(i);
--=20
2.47.3


