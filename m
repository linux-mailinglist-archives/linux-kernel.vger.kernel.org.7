Return-Path: <linux-kernel+bounces-840743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A29BB5216
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65ACC19E6F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937A2BE058;
	Thu,  2 Oct 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfhsP7Vz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8629BDB5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437100; cv=none; b=sJ2bF4DUe/RBJtAHG+WS1+jNo0FkijNzOMFuRA1mTD5y1UITzu4+sM+KhLn6nQbzMkDZe2+CvKZ3cOOU5Jw8EixGsH5bNgZ0hxeBoE984WSDsu3HTVRf8eiQDugmpeZSTU64qxKcWyvMJs05zuf8i18nPeZFQ6KtdP4NC6Nsmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437100; c=relaxed/simple;
	bh=Xz/6eqYYcI2AeHdk/uSMvcnM84/4fheOZAIWCeZxUfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOykAmtd/nlEYCVG2qdVeQ0Yi9q6Jh0n3hDLNdJ/AbcQFPbwZ089mgGBl57hkDNYVLSvpwQbd3WnG05VekWK06HhTPQCqlC9Ch0WOlqEzMrCJuYXYGAWec9aLQ2d/p2LKfFRNSEzYIJk3Bn21pdEK4LKvuaRvUrVYB0IXqsBUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfhsP7Vz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57e36125e8aso1426829e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437097; x=1760041897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6mwD1k8tJtPn/oG49qeOmgMB45GcYhaofTWn8l5t9A=;
        b=hfhsP7VzIrcad/G4SP2x+lSEDvZr4ZGvgbDyfQoJsmNCygESjPFW8vS/haOVuc+UGK
         iNv6IDj9f9ZlawTFwsIkgR487iOs/0iOp3MLrd2nWagFsJWqUsCZrv2huOVvF27Rb6B6
         kEEpqkJf3KH5yQbNaC1/u2Ref/eIpls38Frdr8VxlAKc21P7i3j3lVltFxstyFWYanB7
         r6bDVyKctgXJ0gf7dtwxKWGYNY31VB8+CwwHH/YMxqQfdhgRRIUOEA7n1EHt4VRDUc+9
         FTK2qSs9SWSfXbePVwlX+QN5QYChMvqKdV8NXMGhBMmsg0cK0HExYyowVras8jO+TbbU
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437097; x=1760041897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6mwD1k8tJtPn/oG49qeOmgMB45GcYhaofTWn8l5t9A=;
        b=r7J4EBpYv9gKDKlAClOF9lGE5SSRtcFCLZ+/wb0Y4S4ESqZ2QPz5W7RT/FcvRToy3X
         VMNk1FO592wWOdZUw3aQosW6EdiYEIMk3U2HgLcKKthYn3G4IXfE8TWtkgdEofXZ1K3H
         fGDjoJc24tQ0/wJ6o/6ickihruioeH/PueUvFX0zfsaQY2oqScF0Q/qJGtaBuTMn4PJ9
         2LhSGohX9CAQxZTAbRyMt+C3utc4CEypIelLQPbbCjYVZwQd02zWuXPkBavF1NRHgAYJ
         bTnyQxuz26KEXFBeZTqwZ7zcnUEoRXw32Z0CmMmibBj/rsjtnqrL9kx8ze6TzQdj9Xo6
         jVZg==
X-Forwarded-Encrypted: i=1; AJvYcCVxG1rETx3nQUw6jQAc96B0sVe29MTI1uSjFWF4s0SA0PDV1mw5e/O2p00t7crM48q+JTMr21gebQCFJ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwllVqBfnyVjEKW1LvVmHUamGgl1dmI4SufLeim6tAEtobSqI
	QxOXfvVtjAeZxCeexdn7xrumh4fah1ahesoWtGZZhn453CMHSyr1JoXv
X-Gm-Gg: ASbGncsnGOt/lOU14rwE27HpxMgAQyg7hJcGDEKTxIBgxGdKL4gx91UcsOcWdgqsLQo
	dO3aDDJ9xmOiYLFMxBdsZEssiw3ve2ybPNaiE13k08CIqlfog+HY8xJwCRpRrrQF4YMT2ottKeJ
	NJ/TOEy76Vroq4/ry1qMDUYhIGOA5BrdoKTiTTxgQKk+gZWi4zM/FZlXYmThdjRkObVkuOaHIuj
	quThOmokH2JLGlZZNJnNfUba/t3vwTsbihBIJzi8SWnlXpmDp1mEicDxXlbBLFjR0XJO0qndMsv
	LLKmYbC/wmXqLl+pwt1Dr1z1UX26MC5kAtmIdeWdFbSuGFVHxVW9XzsbjNE8UihcRUBOwMIPkFd
	Rc+E/OXMIyZctJqrkCGXlgIEbcFzOrStAKA/fVkL3MTBT/zNuSzm6KyYy9Y8j7RkoBJ9DCHdqcu
	hIkVt6IIEe50o=
X-Google-Smtp-Source: AGHT+IENhMFofFuRpfmNhDfNDvAuH5eKkEts3QazVzdgUeI7rcIWdGPMuHSPpz9M6PfoWCIBMKvLsw==
X-Received: by 2002:a05:6512:2396:b0:55f:6f5b:8e65 with SMTP id 2adb3069b0e04-58cbb4416c2mr109330e87.30.1759437096449;
        Thu, 02 Oct 2025 13:31:36 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:35 -0700 (PDT)
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
Subject: [PATCH v2 4/4] NFSD/blocklayout: Support multiple extents per LAYOUTGET
Date: Thu,  2 Oct 2025 23:31:14 +0300
Message-ID: <20251002203121.182395-5-sergeybashirov@gmail.com>
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

Allow the pNFS server to respond with multiple extents to a LAYOUTGET
request, thereby avoiding unnecessary load on the server and improving
performance for the client. The number of LAYOUTGET requests is
significantly reduced for various file access patterns, including
random and parallel writes.

Additionally, this change allows the client to request layouts with the
loga_minlength value greater than the minimum possible length of a single
extent in XFS. We use this functionality to fix a livelock in the client.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c | 47 +++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 6d29ea5e8623..101cccbee4a3 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -89,9 +89,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct pnfs_block_layout *bl;
-	struct pnfs_block_extent *bex;
-	u64 length;
-	u32 nr_extents_max = 1, block_size = i_blocksize(inode);
+	struct pnfs_block_extent *first_bex, *last_bex;
+	u64 offset = seg->offset, length = seg->length;
+	u32 i, nr_extents_max, block_size = i_blocksize(inode);
 	__be32 nfserr;
 
 	if (locks_in_grace(SVC_NET(rqstp)))
@@ -118,6 +118,13 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 				PNFS_BLOCK_EXTENT_SIZE)
 		goto out_error;
 
+	/*
+	 * Limit the maximum layout size to avoid allocating
+	 * a large buffer on the server for each layout request.
+	 */
+	nr_extents_max = (min(args->lg_maxcount, PAGE_SIZE) -
+			  PNFS_BLOCK_LAYOUT4_SIZE) / PNFS_BLOCK_EXTENT_SIZE;
+
 	/*
 	 * Some clients barf on non-zero block numbers for NONE or INVALID
 	 * layouts, so make sure to zero the whole structure.
@@ -129,23 +136,37 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	bl->nr_extents = nr_extents_max;
 	args->lg_content = bl;
 
-	bex = &bl->extents[0];
-	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
-			seg->iomode, args->lg_minlength, bex);
-	if (nfserr != nfs_ok)
-		goto out_error;
+	for (i = 0; i < bl->nr_extents; i++) {
+		struct pnfs_block_extent *bex = bl->extents + i;
+		u64 bex_length;
+
+		nfserr = nfsd4_block_map_extent(inode, fhp, offset, length,
+				seg->iomode, args->lg_minlength, bex);
+		if (nfserr != nfs_ok)
+			goto out_error;
+
+		bex_length = bex->len - (offset - bex->foff);
+		if (bex_length >= length) {
+			bl->nr_extents = i + 1;
+			break;
+		}
+
+		offset = bex->foff + bex->len;
+		length -= bex_length;
+	}
+
+	first_bex = bl->extents;
+	last_bex = bl->extents + bl->nr_extents - 1;
 
 	nfserr = nfserr_layoutunavailable;
-	length = bex->foff + bex->len - seg->offset;
+	length = last_bex->foff + last_bex->len - seg->offset;
 	if (length < args->lg_minlength) {
 		dprintk("pnfsd: extent smaller than minlength\n");
 		goto out_error;
 	}
 
-	seg->offset = bex->foff;
-	seg->length = bex->len;
-
-	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
+	seg->offset = first_bex->foff;
+	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
 	return nfs_ok;
 
 out_error:
-- 
2.43.0


