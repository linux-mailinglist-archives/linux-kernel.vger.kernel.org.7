Return-Path: <linux-kernel+bounces-786613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CDFB35F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9428365562
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DE3376BE;
	Tue, 26 Aug 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGrhB8D/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F432F8BCB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211355; cv=none; b=HMLRHLiU++aVYZOB12s6TuDDAZ5gqpJif/UwMI0G2ho3ta7VOIAaaf6Y0SqQsXw46/xU2tn2LnqZj4bOqyjOS0ITxIpVnRoyLV0OG8UyCsKjXTi64L0gb7M/maoz+/maxhWVWc8r69+5mM0PZCKxQb6YLHaWatiXDXVcUagcn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211355; c=relaxed/simple;
	bh=078pPOc4+Mrq2GiBTcZLDoZe5iF+QRu+RYWcOLy3N5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqXfP1oR0qa4sYp/A175/SIzAM402+VirJisuL6cC7A+Jgv/BHSk2AJ7xpdZrUJD6E5JOqy44dRZD6uAgNK9WQh+RJKDoMKtX6mDJyafBwkF0V6qCeJ0MO6aPaQqe5trWwbR3kDd+YVlhc+ORTBqVcJYRowIGMqzkhnzgBL+RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGrhB8D/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756211350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QDSuqgH2PK79DxalD4iHZQ97YhSiJJlN/fNRNiH/3wE=;
	b=SGrhB8D/dKSrGwS4Gkf8ZPn6JKN9D7Im7nF5GykO4Mwzs6TTej8ZtQzEnM/pTP54FoAFsA
	IBy4Uk6QPm6f8m28EH0d1lfBx+268S3xEmE+dIWHJJPnECCWruRrPGOs1bDpwtRkN81I/U
	91iagim2PiYc28nZ94s8/MpSEImoTo8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-xUirrdLSMv-88RbjdA5VMw-1; Tue, 26 Aug 2025 08:29:09 -0400
X-MC-Unique: xUirrdLSMv-88RbjdA5VMw-1
X-Mimecast-MFC-AGG-ID: xUirrdLSMv-88RbjdA5VMw_1756211349
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d9a65c355so89805366d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211349; x=1756816149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDSuqgH2PK79DxalD4iHZQ97YhSiJJlN/fNRNiH/3wE=;
        b=TUoPS/ES+tLW90rLzqJ/jSX8OpZ950F2fl7r1QahxbcWlkC4oBhj0Fl3gNSkQdcyQm
         xUDv/ZP6GejogVv7laIjJ7g1oVXWKy+nkThWPQSKETKmolsDRClhRn+bp6KVxR4vR7r1
         S7xkAoekTpLzX+CqMcMAGI9/S73Xv0X2Q/jA6YJiGnY/pff4EP7EhLP2DtqfmxDV+cwX
         aGBbCAqBx839lumPCpArErEAZRPMhpADVyr5a6QkldxgJW5P+NHqLog2+jX0sMExcxF9
         19LRGr4q2AmqrNoRUPzB/qFfeJLXu3LFDHmeMvDPPp/d7krskhVuyteCzCZNiDDHnUdf
         W6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSWG2K2QtQTztLIyyGSa7B5hWxViS86VCbWXTU8yDzJ6iyPzFq1ghU6o8AkHk34+Nrd1cnpvCJjYb8X3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSz4LUU7hx7IsnsZURAHeqomsuNEQqBi7asenQn3v0JgudooNX
	+QsGgM1yr37h+nNEWxeMESEs/i4L9qXygg3mgUfsySvKPve8E71k3PWv2FkdFoDrH5mjYZxN3NP
	mEQjJp0Z27GuZC4xMifQHIW2OH5zp9pwgTORTigd45DbP4NkFj7iB42pBO3kPnY78Sw==
X-Gm-Gg: ASbGncslOqCi2S1WN3jpx1v83HcrNly6THHw/FLSjSkqvszb2QWQCy/Akt5rCsFMume
	Nk+3XUUo8lo+s+JIYp97xcFBvWvjMFD3otJ8OY5chmcHqHqcL9aB089BWccF0J0h0WrmU0DOfNg
	KstYbguGtzoi0PErSlqWGqoC+3Q4QcSgiCwfVn0ZUPWOHuFOZil66aYUUUw9/94ovSryiUizPRB
	OgMAzEJVZQIk7jjN04UezUzzNn8yY9yX7oc+wRJ//MXWGh3grtx29v8w/FoSEvmTsWvph8KoVAv
	GTr7P11OVJSxF7kv3/sB4N1UcchXgNbu4TWt0jUcXIWHe0hW59U2sgDmfxNeFxR7BXvy2RBSeTL
	oJZKlUmXhVQ==
X-Received: by 2002:a05:6214:e4c:b0:70b:ca78:4f52 with SMTP id 6a1803df08f44-70dd59c1084mr12462986d6.14.1756211348864;
        Tue, 26 Aug 2025 05:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHohgBlgoi98YMsIeHajcZi5xUzGFlQJCfrBIsLeUqR6BIOUm9qjIn9QZofOTgx7sTd3jOHZg==
X-Received: by 2002:a05:6214:e4c:b0:70b:ca78:4f52 with SMTP id 6a1803df08f44-70dd59c1084mr12462676d6.14.1756211348313;
        Tue, 26 Aug 2025 05:29:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm63527046d6.52.2025.08.26.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:29:07 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] btrfs: move ref-verify of btrfs_init_data_ref under CONFIG_BTRFS_DEBUG
Date: Tue, 26 Aug 2025 14:29:01 +0200
Message-ID: <20250826122901.49526-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
removes config BTRFS_FS_REF_VERIFY and adds its functionality under config
BTRFS_DEBUG. This change misses a reference to BTRFS_FS_REF_VERIFY in the
btrfs_init_data_ref() function, though.

Replace this reference to BTRFS_FS_REF_VERIFY in the btrfs_init_data_ref()
with BTRFS_DEBUG.

Fixes: dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f91062fc1b0b..6170803d8a1b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -969,7 +969,7 @@ void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
 void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 			 u64 mod_root, bool skip_qgroup)
 {
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
-- 
2.50.1


