Return-Path: <linux-kernel+bounces-841133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456BBB654D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D0F4EB431
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945412DEA74;
	Fri,  3 Oct 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVt6pl5U"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139F2D542A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482688; cv=none; b=bvhs07hvMMtqGwkSTVQUH5KgCHOvpyTBxqYOqtTiTW0hGr14m+3ledZkogv0kAu4K4d/7qM2tfgJ3ObqGYGOF4qbWEUpDfQ8tSce8kZYLmqMUL9b9/gvPxenJa5bf+oMDPPdT7tpUYnOh3Yg9F6CjrmR1BOP4AZNZc793YdRvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482688; c=relaxed/simple;
	bh=4Q3QaDycZlayj+5emorjUsIeZOosRc/NtSQvzYPykDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZWL8BSGRLa6jSulmfRnQh+k70YIHguFpQRvuPhzTc7us6cFdozodT8+9/FiNZOkwqu7T3sG7E+u7iofbFaekGkUdlQpFNHXJirN85TA64FUbd1PdC0AO+8S0XuHXXHF66iNSJYC0fdmXNvOWPQsYAEMo2iHoiKggCblKwGsUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVt6pl5U; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-58af7f8b79dso1886348e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482685; x=1760087485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eQrJ6U8zwJxNRHxnkX4GFTCD/jiPljD9W/O4v8njYs=;
        b=IVt6pl5UXE6PGHfSGbO+/hCZKaod176tZKEJaXBH0G2ru0SWWU8BSMLQFaZNEOPWT1
         s2ByQ9WKW3vxvOknLR7LTvtAiS9RDiR5kvp+tilyaXdxMQSBxbzRDt7W6NkHx+XpkvN1
         BU/jxVT2crmk74Lj6ITz/NwA8vjtNVAOV1FZseNLfB67MVISwx/evzMH6g7Lu2msWbn/
         kcgPKru/Dgg5/dYsxAQkrHbOCOGfvS8PvhDsSwClt1leOENe8bpbAm59qn2DsX1dHX62
         zZzGctG51V2OBr8kvQIuA1c+1m4BXiBLBpOqr6aWVTCQtjEdEdJ1EJOdKGEa1cpjeQq1
         Kv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482685; x=1760087485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eQrJ6U8zwJxNRHxnkX4GFTCD/jiPljD9W/O4v8njYs=;
        b=qB85jEPTuuVG7z4TXtd25S/Zp9ZprKADcGMrKNNauT/Bn+BCoFgGMtmbk4q2UVkCP3
         kdsIyS64pqn5ONNWhj9n5BVewXsa3zV3sZEpySg6qiIEARLzsN44O2vyFy45auuyw2P9
         Rohg8a/jqsgS7wnMYsgpNARAjLcSvVx0yYfeFwcGlrtj5h6jJ+aSXQBGEHd98h4EBU+V
         lO5FgO9TAFv1uw2R2J+tzXSpvK7uGBgo5jHOku9+LQaIN8juWlYGmCPCvHJU8HbIHJqi
         nzW6vYWk5aBusd4tTTo8zEksO1x4Q6RKKOOaH2QMy5mPsZsR+tPbgGpI1VOZrjsbX/Ev
         6o9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh6d7+6A85I89MDXHnKZJ9fN7NGcbFKJtRR4zkyD3WY7XNjDvNal0yfG3IBS8zZ4An5rb/IW7w2xFfRl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZYT95YMg/iVea2AbU0Wr+swXZejY5wWqaWAOOetMAhwp+hG/
	Z2djLxT+NMacr9nYWnLS80LyKsyRnew0UkdFOG0jz+UiGAY4dwt1fGpD
X-Gm-Gg: ASbGncs2L1O62Hhtmmq5lMh8MNW+cloeuti6TbeEJNWzltuoSiRECEF3N7c/We0W4ey
	pSVSJnZ/SLEtS4oA18QLYF+wZF2zYEnJav5YXnk9X83ssgY9fz3ld5X8c9ERTMFPuHuyk2kUSOJ
	MQvirlTQN0+nvjyy7+sOO+0sAvC8LFgAPAiRIWSX3EawqpFo6EK/bTUFL0H4V2/AomDirgNkBl7
	p4F0ri7kkbNtdCqqcgBnqodaggXziLrF4TgF3Se+IPk/Hd4I16+G7lQgTnfk2pgBQMtcvmpzklS
	mRYvOJ7BV9Kxo4xefb/As20n0wjG9sEmgSuHeQ5JiZF/hgKbillqA4y1Htgt+5Q6tJ4aqaHaam9
	NN8iG2IepJJBf91P92FqyOfYK8wDnJBxoheAABVHyMNvf+CmBRmyS6q+CJOXA63hOKvlEqEEh3/
	GJ
X-Google-Smtp-Source: AGHT+IEwOBi8H8vI0VnTgYiKNK/rmJrnMUq9+SV+Hm3XBxJGlKzU1nvTZo6tqvELeVVre05Nb9QfRg==
X-Received: by 2002:a2e:bc8c:0:b0:337:e5fc:d2d with SMTP id 38308e7fff4ca-374c37eb3f8mr7161301fa.24.1759482684821;
        Fri, 03 Oct 2025 02:11:24 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:24 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] NFSD/blocklayout: Introduce layout content structure
Date: Fri,  3 Oct 2025 12:11:05 +0300
Message-ID: <20251003091115.184075-4-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003091115.184075-1-sergeybashirov@gmail.com>
References: <20251003091115.184075-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a layout content structure instead of a single extent. The ability
to store and encode an array of extents is then used to implement support
for multiple extents per LAYOUTGET.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c    | 26 ++++++++++++++++++++++----
 fs/nfsd/blocklayoutxdr.c | 36 +++++++++++++++++++++++++++---------
 fs/nfsd/blocklayoutxdr.h | 14 ++++++++++++++
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 35a95501db63..6d29ea5e8623 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -88,9 +88,10 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	struct pnfs_block_layout *bl;
 	struct pnfs_block_extent *bex;
 	u64 length;
-	u32 block_size = i_blocksize(inode);
+	u32 nr_extents_max = 1, block_size = i_blocksize(inode);
 	__be32 nfserr;
 
 	if (locks_in_grace(SVC_NET(rqstp)))
@@ -102,16 +103,33 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		goto out_error;
 	}
 
+	/*
+	 * RFC 8881, section 3.3.17:
+	 *   The layout4 data type defines a layout for a file.
+	 *
+	 * RFC 8881, section 18.43.3:
+	 *   The loga_maxcount field specifies the maximum layout size
+	 *   (in bytes) that the client can handle. If the size of the
+	 *   layout structure exceeds the size specified by maxcount,
+	 *   the metadata server will return the NFS4ERR_TOOSMALL error.
+	 */
+	nfserr = nfserr_toosmall;
+	if (args->lg_maxcount < PNFS_BLOCK_LAYOUT4_SIZE +
+				PNFS_BLOCK_EXTENT_SIZE)
+		goto out_error;
+
 	/*
 	 * Some clients barf on non-zero block numbers for NONE or INVALID
 	 * layouts, so make sure to zero the whole structure.
 	 */
 	nfserr = nfserrno(-ENOMEM);
-	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
-	if (!bex)
+	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
+	if (!bl)
 		goto out_error;
-	args->lg_content = bex;
+	bl->nr_extents = nr_extents_max;
+	args->lg_content = bl;
 
+	bex = &bl->extents[0];
 	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
 			seg->iomode, args->lg_minlength, bex);
 	if (nfserr != nfs_ok)
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index e50afe340737..196ef4245604 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -14,12 +14,25 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/**
+ * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
+ * @xdr: stream for data encoding
+ * @lgp: layoutget content, actually an array of extents to encode
+ *
+ * Encode the opaque loc_body field in the layoutget response. Since the
+ * pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire are
+ * the same, this function is used by both layout drivers.
+ *
+ * Return values:
+ *   %nfs_ok: Success, all extents encoded into @xdr
+ *   %nfserr_toosmall: Not enough space in @xdr to encode all the data
+ */
 __be32
 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp)
 {
-	const struct pnfs_block_extent *b = lgp->lg_content;
-	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
+	const struct pnfs_block_layout *bl = lgp->lg_content;
+	u32 i, len = sizeof(__be32) + bl->nr_extents * PNFS_BLOCK_EXTENT_SIZE;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
@@ -27,14 +40,19 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		return nfserr_toosmall;
 
 	*p++ = cpu_to_be32(len);
-	*p++ = cpu_to_be32(1);		/* we always return a single extent */
+	*p++ = cpu_to_be32(bl->nr_extents);
 
-	p = svcxdr_encode_deviceid4(p, &b->vol_id);
-	p = xdr_encode_hyper(p, b->foff);
-	p = xdr_encode_hyper(p, b->len);
-	p = xdr_encode_hyper(p, b->soff);
-	*p++ = cpu_to_be32(b->es);
-	return 0;
+	for (i = 0; i < bl->nr_extents; i++) {
+		const struct pnfs_block_extent *bex = bl->extents + i;
+
+		p = svcxdr_encode_deviceid4(p, &bex->vol_id);
+		p = xdr_encode_hyper(p, bex->foff);
+		p = xdr_encode_hyper(p, bex->len);
+		p = xdr_encode_hyper(p, bex->soff);
+		*p++ = cpu_to_be32(bex->es);
+	}
+
+	return nfs_ok;
 }
 
 static int
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 7d25ef689671..2e0c6c7d2b42 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -8,6 +8,15 @@
 struct iomap;
 struct xdr_stream;
 
+/* On the wire size of the layout4 struct with zero number of extents */
+#define PNFS_BLOCK_LAYOUT4_SIZE \
+	(sizeof(__be32) * 2 +	/* offset4 */ \
+	 sizeof(__be32) * 2 +	/* length4 */ \
+	 sizeof(__be32) +	/* layoutiomode4 */ \
+	 sizeof(__be32) +	/* layouttype4 */ \
+	 sizeof(__be32) +	/* number of bytes */ \
+	 sizeof(__be32))	/* number of extents */
+
 struct pnfs_block_extent {
 	struct nfsd4_deviceid		vol_id;
 	u64				foff;
@@ -21,6 +30,11 @@ struct pnfs_block_range {
 	u64				len;
 };
 
+struct pnfs_block_layout {
+	u32				nr_extents;
+	struct pnfs_block_extent	extents[] __counted_by(nr_extents);
+};
+
 /*
  * Random upper cap for the uuid length to avoid unbounded allocation.
  * Not actually limited by the protocol.
-- 
2.43.0


