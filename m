Return-Path: <linux-kernel+bounces-841132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E9BB6547
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD133A7A56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35422DCBEE;
	Fri,  3 Oct 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvMsbvbX"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBE275AF2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482687; cv=none; b=BXr0/hG5r8/EV+3nVZLtUxYsCDMkndWY/yGHgvFdupltJ5dxUvG0m6TNkGwpi+UhMl3+Zvjwij4fq155ScIEcr1zpB7uLOfKRnxBYC2RxpUb+VIEeMGfhrKej1iIn9VGnbnxtJ4rtXVkB9vKB0rYBoBEUYNLkw0VAubRrWZTLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482687; c=relaxed/simple;
	bh=bIFqvMBhqhwmcgcZ4MQVyIHVC5lZccPFA8Mv6XHN7AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUDI6sK7J+uXLlNFNa8PbNK8sPF3fe+OYvt0Rp+McwO3pFT3HCfh6CTnIGSVbDs4B38O/F1Hdd4yxI3woNtO7CsqYQ3KOwDglNtVMxr5wzBMlEbkFCi+H6F4RRZQhuRevQtYuzzLXlulo8FmFeXsUonx8hDJk6Dxmi8GtjE5Tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvMsbvbX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-579d7104c37so2828789e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482683; x=1760087483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pxsmtIah7HBjRLQj3EA/UxoyVXQkam0zyy01vtxYeo=;
        b=DvMsbvbXYd+B6Q9R0+cjRF8DG1pW75yyFcwVwE7bZxwDOxfg8m8ua+61RwhDO/mJK8
         ND+UNeQxJQRzFNEuH3RAC3dHxfzamSaiRG1uZ1H6jVB5u29x6mOxXA3rRpdsJTJRwIhN
         eACxG3eFX1uSq3QxnPKVGSsY5dAiKdfouepfd3jZLUP5UdajvCDxrdYII7qFM3Bn2wW6
         maFTJDlxHisMaTXacnDMy81RvJGeOfBdY2kuxpT7Lca0OdtuXNsRqY43MWdO5DOLD26p
         yHF7tuiN9cjjlI0gHVrNMf0loTmJoe+hnl4eAJTwk3KvTbP6OATNALmNt38zGSUUAizu
         PnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482683; x=1760087483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pxsmtIah7HBjRLQj3EA/UxoyVXQkam0zyy01vtxYeo=;
        b=D5vbV2UlWYjkgJnw7lMZd0uAoggpuuco95Ah8aKTSG7Mpw/LIi8CnqhIC367hlCFgI
         2w7oXjeh+6vh0auxydvHa/q680L0Q622VsdrbxEwm+X13DAMKjQbkwL2reejde5JDA89
         fFi/E0W7S/rXYmI71cS2nTLWcDuh1TmdIb4VSuJuPmHElGZZBUL1QShxESxLkUBwo+yR
         qUW3GwidRUG8EDKTH48IbuG8zOrJl5zL7rC5gMP6ZkEz4ZUPBwEInFK3qnXyCCjhQsPS
         2Jcr6L7GN8lhfyzIBkcl5eoF82ipqFnQNNXOqRHMQ/xAzBOHihmP3Y7UgbGc4X0ptFoQ
         90bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtU6N71QjVHheXQ0MrRmlW0pXsRDBLDcUzzbyiNBIC1dcyY3lYtEp9455KJQIPmWdGSRizFnu/6nwSjEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtX8h3pZ67u6h38SRPiZJDbmkyZmEMbpzG2njOo+l3mETUczp
	phtIh+3gc9/gnFUdO4/LzdCSkuyBORtswSEjexpBjKdeNuLY+zfm8PG4
X-Gm-Gg: ASbGnctSUTbdQdzaXXXRiRdXueQdgo76IxtuUcgJODyD9jGYJyx1kpGB6QcllhfwLV/
	GSgd6yhLpRYfk4BCD5AbCzbrOon2ptEhzzOVrgpBm++P9oz1Wztt3DFu4UhiX3pLwxsLBSZrsgQ
	7kfehLVe98yBHnqngUK0DDDwjxOmaW5VP61atxTP8HPztpC/ZEnfcc11u9PpEMWi3bs0zPqddxW
	8fZVPc7wVxWqtyz7neD0QfrhVrkAMmr+WWoeuQvZX6Iv+pjp2ZoijwR8IqUGzQwQLsEcNMmiKhp
	7Pmy0cqdomQAXb5aIX9lIZSXQFUTrTp2Q3gh8J50pzyQR45CjQDsLMatSzgJXkN3wZbULEv5D7+
	nbvCo4rVzQ7fAQMOKnT5LUme5WM23RR2ooDRISlZkqaRFfefL0yOVtjqm1GpFa0BUTSH1Afv1qz
	bO
X-Google-Smtp-Source: AGHT+IHW9T7WlOK4+T0hBfSAzghb7rtXEr5URd0twIoAFnjTsNGrfGxgzL5o3XRAYloFcEblSRmzlQ==
X-Received: by 2002:a2e:a987:0:b0:36d:4996:1c4d with SMTP id 38308e7fff4ca-374c36c4b2amr6307481fa.9.1759482683019;
        Fri, 03 Oct 2025 02:11:23 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:22 -0700 (PDT)
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
Subject: [PATCH v3 2/4] NFSD/blocklayout: Extract extent mapping from proc_layoutget
Date: Fri,  3 Oct 2025 12:11:04 +0300
Message-ID: <20251003091115.184075-3-sergeybashirov@gmail.com>
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

No changes in functionality. Split the proc_layoutget function to
create a helper function that maps single extent to the requested
range. This helper function is then used to implement support for
multiple extents per LAYOUTGET.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c | 115 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 425648565ab2..35a95501db63 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,68 +17,44 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/*
+ * Get an extent from the file system that starts at offset or below
+ * and may be shorter than the requested length.
+ */
 static __be32
-nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
-		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
+		u64 offset, u64 length, u32 iomode, u64 minlength,
+		struct pnfs_block_extent *bex)
 {
-	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
-	u64 length;
-	u32 block_size = i_blocksize(inode);
-	struct pnfs_block_extent *bex;
 	struct iomap iomap;
 	u32 device_generation = 0;
 	int error;
 
-	if (locks_in_grace(SVC_NET(rqstp)))
-		return nfserr_grace;
-
-	if (seg->offset & (block_size - 1)) {
-		dprintk("pnfsd: I/O misaligned\n");
-		goto out_layoutunavailable;
-	}
-
-	/*
-	 * Some clients barf on non-zero block numbers for NONE or INVALID
-	 * layouts, so make sure to zero the whole structure.
-	 */
-	error = -ENOMEM;
-	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
-	if (!bex)
-		goto out_error;
-	args->lg_content = bex;
-
-	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
-					    &iomap, seg->iomode != IOMODE_READ,
-					    &device_generation);
+	error = sb->s_export_op->map_blocks(inode, offset, length, &iomap,
+			iomode != IOMODE_READ, &device_generation);
 	if (error) {
 		if (error == -ENXIO)
-			goto out_layoutunavailable;
-		goto out_error;
-	}
-
-	length = iomap.offset + iomap.length - seg->offset;
-	if (length < args->lg_minlength) {
-		dprintk("pnfsd: extent smaller than minlength\n");
-		goto out_layoutunavailable;
+			return nfserr_layoutunavailable;
+		return nfserrno(error);
 	}
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		if (seg->iomode == IOMODE_READ)
+		if (iomode == IOMODE_READ)
 			bex->es = PNFS_BLOCK_READ_DATA;
 		else
 			bex->es = PNFS_BLOCK_READWRITE_DATA;
 		bex->soff = iomap.addr;
 		break;
 	case IOMAP_UNWRITTEN:
-		if (seg->iomode & IOMODE_RW) {
+		if (iomode & IOMODE_RW) {
 			/*
 			 * Crack monkey special case from section 2.3.1.
 			 */
-			if (args->lg_minlength == 0) {
+			if (minlength == 0) {
 				dprintk("pnfsd: no soup for you!\n");
-				goto out_layoutunavailable;
+				return nfserr_layoutunavailable;
 			}
 
 			bex->es = PNFS_BLOCK_INVALID_DATA;
@@ -87,7 +63,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		}
 		fallthrough;
 	case IOMAP_HOLE:
-		if (seg->iomode == IOMODE_READ) {
+		if (iomode == IOMODE_READ) {
 			bex->es = PNFS_BLOCK_NONE_DATA;
 			break;
 		}
@@ -95,27 +71,68 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	case IOMAP_DELALLOC:
 	default:
 		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
-		goto out_layoutunavailable;
+		return nfserr_layoutunavailable;
 	}
 
 	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
 	if (error)
-		goto out_error;
+		return nfserrno(error);
+
 	bex->foff = iomap.offset;
 	bex->len = iomap.length;
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+{
+	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	struct pnfs_block_extent *bex;
+	u64 length;
+	u32 block_size = i_blocksize(inode);
+	__be32 nfserr;
+
+	if (locks_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
 
-	seg->offset = iomap.offset;
-	seg->length = iomap.length;
+	nfserr = nfserr_layoutunavailable;
+	if (seg->offset & (block_size - 1)) {
+		dprintk("pnfsd: I/O misaligned\n");
+		goto out_error;
+	}
+
+	/*
+	 * Some clients barf on non-zero block numbers for NONE or INVALID
+	 * layouts, so make sure to zero the whole structure.
+	 */
+	nfserr = nfserrno(-ENOMEM);
+	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
+	if (!bex)
+		goto out_error;
+	args->lg_content = bex;
+
+	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
+			seg->iomode, args->lg_minlength, bex);
+	if (nfserr != nfs_ok)
+		goto out_error;
+
+	nfserr = nfserr_layoutunavailable;
+	length = bex->foff + bex->len - seg->offset;
+	if (length < args->lg_minlength) {
+		dprintk("pnfsd: extent smaller than minlength\n");
+		goto out_error;
+	}
+
+	seg->offset = bex->foff;
+	seg->length = bex->len;
 
 	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
-	return 0;
+	return nfs_ok;
 
 out_error:
 	seg->length = 0;
-	return nfserrno(error);
-out_layoutunavailable:
-	seg->length = 0;
-	return nfserr_layoutunavailable;
+	return nfserr;
 }
 
 static __be32
-- 
2.43.0


