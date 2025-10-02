Return-Path: <linux-kernel+bounces-840742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52045BB520C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B9D19E6921
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD42529CB52;
	Thu,  2 Oct 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksl+zng1"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC5296BC8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437097; cv=none; b=SYDZMdyeS/an/jgkGWnH+8u6FvaQyDjolbEs3m76CBkoPfRRShNVIENGO5jEZ5E8FW3CLtjy3J4LZULBwvquL8cS2HsakoJyrsDbxxvJPNC5opjPcR0PMQLKJ0luzJU0vUJeU6/Quwaab7EtsKDegFhYS4vIZ7+FibXJmrZ4cNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437097; c=relaxed/simple;
	bh=I6rdzfWZcPvJgyeOvLi+c+eLBQbKBQcDt5Nq6d7BpO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfZtsj8G/MDgqyFw1itmIM9bPS/HdIYc03OeAHoEy5jeMRIsTDJkv+iAbzhDvjXuOYCQKVdW3tpoRXqg3vVB6nH3VioOxRcIjaA7buhkafRsX9eutSOM7DHqdk6+S26JgZaLxhiYEKOF1v1IEMX3iQn2nwv9GqlGIE9QjCRyftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksl+zng1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1983631e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437094; x=1760041894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URqcz1PqBiajUpbWyyVEtzMSrXQenRBULzsl914p9Po=;
        b=ksl+zng1u11CfgZoTQqtSDgDfh/TYHHl5AEaVeayb5Me6Lf985cacFKHfcfHf6fn0E
         W/nM58KgR6t0SqBbPNQAl+tFBpQJla0yB9A7FomQSY+w2hLTzIviiN+8fGW0Zni0E4jj
         /WJcJiZtsfL6cqjWUR70ckco7bsc4OAj2QVYAt/8ix+dROslb4CFC+dgdEWdiEDNRQF0
         5H0cuWcziVv070KWTcGSP9dWi7GACriPdvft7NmLYaLPpP28hDGsXC5fVFZwWVY16b7Y
         SftGDf33haxBNuO3N1YAiPRsZsC8nm559VyBO6wHrlUHsMJJToBne5V4W+mQfVg+aFPo
         C+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437094; x=1760041894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URqcz1PqBiajUpbWyyVEtzMSrXQenRBULzsl914p9Po=;
        b=MiLv1zWgGcXlWFGHzqsTZsILXMEBOlKlvpdzZSN2DF0RowDxqU5PsjpoTz1MwQ03Lk
         J1bLa0c5Zx71NEnEDMOLrNhkyfq7RqAfaLGAvweA9hR/63WjZo7AcSiv6WPvGZ1cYB02
         xm47+8JfMzoD76lo/ChiIVl66Si/nsvvf3hgAca5goMoKC9FA2GUTeVxtOcQRl46DwxE
         kauzJaSYrvwG/xT6lYK0G9icuyaZ1AkZkXqv8d7ssx2mvKu0CQg6S0LNu8N/5cpBvgAM
         bXNBxE3BKimKm1qJByxLNNXtZLbPxkRpWWh3BXqugf2K5P8bMKX+nCds7DNx7fJroVmy
         qqig==
X-Forwarded-Encrypted: i=1; AJvYcCWIFLAFAdyH6DPqYys0VU3Pk7mc/J75eH/hd16lCFp6kiULSKiOenAhw8f0luqbfgqUszEuNe/beipUb8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxAidBMYC4TTSRQBiPpGh28w8ve19wYeHVVtT6ZDkkoRJJE9y
	ro8D4Q55MgaY6EItl2T2ZvYbtLc90gOOozGs1URBDYM5UhwdfVMkqQIA
X-Gm-Gg: ASbGnct2EJC+bYvK090zQ7SqAX930lf170g4p4LKlnAiyWvyOcoFSPLKmnLEFVCzh5W
	ykWTfJR1DI4pTWhnGCOdvULpPpKjqhcUUPy0xL8EIlT8Wk58ZMnZto7zlT9/IybLBck2IZIiIQ3
	uvlNVVinioM6RpNqqslTMGK7y1G2z1D1ctW8mne3J47NLbP59LcGUjNBltrbNoxU4/x8cVGEGT3
	u1rBM1zDbyGmhc239SvrIV8LIXp3XXSYpT9jcsykXkQEdXahQENrQgNhIyXq3Se83GoBpd3WRoo
	vjMw/ej8rkjPJ3YsFOodnHpteGJT2ICWtyMJp5dYmAUJvqgeR1b3bnOHYE56DrbihOlJrvGIHcM
	cnMjZvZpGu5aJA9K2eqaqI3IZxqRVEKTyJxCq0nTLPYJo9wqYaNXXCYR2BIA0bZrdKiwAcas3dJ
	WK
X-Google-Smtp-Source: AGHT+IHWKAwAUfJW+XD+5V5RcRh9IVpwmdya52Ikx8ywWGkiirBkd8RMVHMZ7lX5+YUZDXR0SH0zSQ==
X-Received: by 2002:a05:6512:1322:b0:57d:77a1:715d with SMTP id 2adb3069b0e04-58cbb4417d0mr145968e87.32.1759437094010;
        Thu, 02 Oct 2025 13:31:34 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:33 -0700 (PDT)
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
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 3/4] NFSD/blocklayout: Introduce layout content structure
Date: Thu,  2 Oct 2025 23:31:13 +0300
Message-ID: <20251002203121.182395-4-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002203121.182395-1-sergeybashirov@gmail.com>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
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


