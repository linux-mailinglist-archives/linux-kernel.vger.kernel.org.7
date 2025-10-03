Return-Path: <linux-kernel+bounces-841134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FDDBB6553
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F03BB532
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412942E8881;
	Fri,  3 Oct 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFdYOeXr"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B02DCF55
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482690; cv=none; b=mcbcVOdGIbIjtAUpK8ln/qGPjEgipLataaAwNXBvO8VVWFdV/yzoqjMdO0MOPzPL7SelEJDIhl4EZ0gORmyGN28BdBLuDenD8cC1Y4H//6GN53lvcam6UDAlPATZ7PrqeepHTkNG0uVhvxb5f3njbm6bRUsTxtfUoihoGAEwBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482690; c=relaxed/simple;
	bh=CyDxCOa9a0UVrko0lulNFRdftqZ5S6iGAtvQspBwLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVfrPyKhHZfeNY/BwbSn1pWRmGC89Co4n2SgciMyrzGb6AdaJlZ2B/7Z0biSXvFPGKIWAZoP5CS87yeSr55vFSjHAZ6TGXPRjR9uJ5uMDDLuSHuqbPN+XI/6/Tr6k+A5/UEh9INl0N66Yfa/F42V0QMA+J06gD7kkOvqcldmIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFdYOeXr; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-361d175c97fso18576701fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482687; x=1760087487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MLh0YP6jyjvkv3OLtn1P1Rakr4ufZXEBiz1IixS4zk=;
        b=ZFdYOeXr92NrVKtMA94H4t76UNUcH0uMU0EuffRK41GUzU8x93v00u6ylE2Brwp3Yu
         GHJe9iYsP3Xn6MUrlOYMi8joT/xr9KK3maly1fY0H/7P2oqBhNYUolBg5cTsYqC4Qzox
         H8aYqxTzyJLnBNWnerHdSQSaISIl575j8tYPvBNTNLFghZApG4jVt/e/JclLMtWa5UQa
         douLQqEiGpkSZoYma4bvS2GjIqZ0MQGrVDKoh78hOMo8ABlyAEoyHnQ7q2yVFnoyqUxn
         gJnhm73FSkzf3kkcNTAXuMRAzQEAZr9tGD2yfcvCXN4Eyszhf207hTBQCar+vd2XolQd
         OVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482687; x=1760087487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MLh0YP6jyjvkv3OLtn1P1Rakr4ufZXEBiz1IixS4zk=;
        b=iD6grb7zhGwwRSbmW9vcQrwQMU10NN9/md9o9B4cE7TnIx0Xwh1468fkXc4rSE4ASC
         OUFYOk54yzWJbYRHfif95MavJ2ee2ZqLJvZ1nmyV8sUH0uIFVQ/41PrZafq9ABqNNEt4
         acXPowLkay/vxf5y91AVTGz9HtJwlRZxDjAoaOjLhbwmgiaMCRhtaXfhSZaTLhN5JuIC
         3Qo9F1g+Lg+dWXXBdYTuS9OD9jKhOYsFolotB2cvl7VgdAgcc3vRJoXXjEM5ilmO4IEW
         VZpli1S3LLzI2huhBzuA5br+HaSpQu4KOLMqSUkfrXSWcR55ylC35wZo+Fw6oYVTIzvo
         MRhA==
X-Forwarded-Encrypted: i=1; AJvYcCU5n7qKrq7oog0URy9qPWVIc8tAQKVzRGBhuO5HVPLbzdQxUY5eOQ+7PLHsAt7G8C33uCzYpiht45hUMU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSg4fuddv43dF63Kxidmmu3c/Gf4cz4TraTfjJgUY/ByPd/gM
	u/zgozAEh99YSmBXDIs8COXK59fdfZ664VwHfPpbKtMTAdIR1qF/Vm8O
X-Gm-Gg: ASbGncuz2x4pQx05TU628BvNIh2NJYNN+qMEehRWtmHtCF5+Iv/5HFsaQZMPFXexFIv
	SpOHRzkMTuCPC3c9Hk6znbySnTLYr4JuHt48ORnbPgIPGOR1+0onSKX6rxpb7mv1gbmsNHP6sA0
	2wavFz2bBuc8EZl+fwyZ5RzSpDABtrZf3jtOjtilNfGAcJigprnxr9ZH0PQ5BVEzu5K77sQgHrc
	b8L0J4AnZmZuA375Uhdmcq2IKRpovbHVBu+K+yXRWmHNBUIZtX3R/o92bzCMsVZYWuQ66h5Rh1S
	0asFXsm7aV8ehk9WyKHfUNnr+N4kt0KIzakrgEZc1u6pXx+bWuQ/yyU3ZlOXHZRZEHvbi2T+Ru+
	adDnOXyETLBsC6Vd5FcfjRXNkLAG5VaGHVDy20vwA9D+RsbOmGPYd2nKsq9Thhw47f3q9SjLNcl
	/UsLbJv7VQXXI=
X-Google-Smtp-Source: AGHT+IH626lrMrW4/tqV77SvAxhxkxsSgiUJLrrNrN0WsdcdsYjyni7R/pZ/Q7HnGJRn81ZtrVV7wg==
X-Received: by 2002:a2e:a802:0:b0:36a:8c41:643b with SMTP id 38308e7fff4ca-374c386153emr6284711fa.43.1759482686606;
        Fri, 03 Oct 2025 02:11:26 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:26 -0700 (PDT)
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
Subject: [PATCH v3 4/4] NFSD/blocklayout: Support multiple extents per LAYOUTGET
Date: Fri,  3 Oct 2025 12:11:06 +0300
Message-ID: <20251003091115.184075-5-sergeybashirov@gmail.com>
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

Allow the pNFS server to respond with multiple extents to a LAYOUTGET
request, thereby avoiding unnecessary load on the server and improving
performance for the client. The number of LAYOUTGET requests is
significantly reduced for various file access patterns, including
random and parallel writes.

Additionally, this change allows the client to request layouts with the
loga_minlength value greater than the minimum possible length of a single
extent in XFS. We use this functionality to fix a livelock in the client.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


