Return-Path: <linux-kernel+bounces-590092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B8A7CE98
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A75B16A467
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5232192FB;
	Sun,  6 Apr 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b="auTOm0uI"
Received: from wiki.archlinuxcn.org (wiki.archlinuxcn.org [104.245.9.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680622094;
	Sun,  6 Apr 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.9.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953365; cv=none; b=dtFkCElRmdgH1B+JSek42Lpr6Zef5stWP1FmztPtU4/XAQPjP9l7vHaauiWipVCNCOQicfiSbyskK3HwVXyIjs9SD6VfmvYVpItfy+ajKoCyUb6o4nyavkXUR9vqOwilH3ou33PkXAT27bbWnfYbIMFB3MXZUrIec99To+DhPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953365; c=relaxed/simple;
	bh=TYBZUuHUqvDPqBnKn2e0E6xVHecAUkufAnyvzOq1LQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p15K8NdhvYTsUoBoOA+Jf3DAuA7//Db4u9MmgbBivmrSOrArDKfYhT28XR00cZCOHsegyyyLvOeGnN7hcTYwEgku64mMmV9In2vm2T02dQ6Vhg51zwBno/Xc8bX0QfpVNzIVSZTUPfdSZx8kqWhfh52t8L+mhNaBH3d3Xx8llkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org; spf=pass smtp.mailfrom=archlinuxcn.org; dkim=pass (2048-bit key) header.d=archlinuxcn.org header.i=@archlinuxcn.org header.b=auTOm0uI; arc=none smtp.client-ip=104.245.9.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archlinuxcn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinuxcn.org
DKIM-Signature: a=rsa-sha256; bh=7x9nCLujvtPy4qqwxA8mZXtQb2XCIq2HJEbx+uqLric=;
 c=relaxed/relaxed; d=archlinuxcn.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@archlinuxcn.org; s=default; t=1743953353; v=1; x=1744385353;
 b=auTOm0uI0PjHyhy3x6MMt9oEW8vrU89BrrbWk5JavB/PSZ+z4KZFxTQzpGvKoPLEpEKbDVbv
 kUeaYrww2ylfEHQQwuldAUh2B6EYt6dca5UE1/KULz69SJ0vFahabPusigESvuiiyxyCsjArf2M
 c5qBRpl6fn6uG0olxRZZwNhnVe/OJdGRB+bP8fftNVUc5rMot0vRrB3IGbcgzUGYlCDxjGBygdn
 WbDmXotqpLfdKYFFYkXYlZ2r6IJ1OM1lUdV9CcbW3LLlvO+u1aTSH5xzPdnpf0r2YLuBpvGrA8a
 PB22SAaLceiQLfW0xAiZ4Ipqs2Xuffb+Mf133C2zpS/Sw==
Received: by wiki.archlinuxcn.org (envelope-sender
 <integral@archlinuxcn.org>) with ESMTPS id 40c61737; Sun, 06 Apr 2025
 23:29:13 +0800
From: Integral <integral@archlinuxcn.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Integral <integral@archlinuxcn.org>
Subject: [PATCH 1/2] bcachefs: split error messages of invalid compression into two lines
Date: Sun,  6 Apr 2025 23:26:59 +0800
Message-ID: <20250406152659.205997-2-integral@archlinuxcn.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an invalid compression type or level is passed as an argument
to `--compression`, two error messages are squashed into one line:

    > bcachefs format --compression=lzo bcachefs-comp.img
    invalid option: invalid compression typecompression: parse error

    > bcachefs format --compression=lz4:16 bcachefs-comp.img
    invalid option: invalid compression levelcompression: parse error

To resolve this issue, add a newline character at the end of the
first error message to separate them into two lines.

Signed-off-by: Integral <integral@archlinuxcn.org>
---
 fs/bcachefs/compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/compress.c b/fs/bcachefs/compress.c
index 28ed32449913..d68c3c7896a3 100644
--- a/fs/bcachefs/compress.c
+++ b/fs/bcachefs/compress.c
@@ -714,7 +714,7 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
 
 	ret = match_string(bch2_compression_opts, -1, type_str);
 	if (ret < 0 && err)
-		prt_str(err, "invalid compression type");
+		prt_str(err, "invalid compression type\n");
 	if (ret < 0)
 		goto err;
 
@@ -729,7 +729,7 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
 		if (!ret && level > 15)
 			ret = -EINVAL;
 		if (ret < 0 && err)
-			prt_str(err, "invalid compression level");
+			prt_str(err, "invalid compression level\n");
 		if (ret < 0)
 			goto err;
 
-- 
2.49.0


