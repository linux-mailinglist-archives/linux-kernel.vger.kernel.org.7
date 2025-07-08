Return-Path: <linux-kernel+bounces-721484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AFAFC9D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F856236C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA152D9791;
	Tue,  8 Jul 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8O7ferP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA97237164;
	Tue,  8 Jul 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975371; cv=none; b=PrEV4CxwZIXDIKNqPeTdOKMJ1g4VR6LayhmaNz4TvnDzdEJkC3ckwv5L29ZiIn50Q1jX+KWkM9Pq7/6dxYxQiJNiiIdpVQETtXkMrESAc6jICzhYexHzJBwwO3+T7dHgKE3p4tAPlU7lCVY5GENlVupwk/v6dr2OQU8GYSex+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975371; c=relaxed/simple;
	bh=bTxUh0C++rwpN8L0/ZsPcjkYp+3HFUmkE6Dyy+7nxqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7Pi1M87gvJHpdQ8ZIwgIfOafsYquWe2xcmn0JCyc1RRtTxYcrQwnF6snl6s0bm+cXkZUFsrICTyKwHoQxkQfo+0Yavukb5ZsLRKDmy5kx2c0MXh9VevkvmN8a0KMhbLUtlprRy2dCyvyUSAnFs8hJcEF4821kVG59lgrOdYzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8O7ferP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cfb79177so23883955e9.0;
        Tue, 08 Jul 2025 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751975368; x=1752580168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0mp9XQ6xSabMpCCiCepDwVdANSTamJrN23jkEJ5pwQ=;
        b=N8O7ferPxZeW07KPOTfaSuIOQ8bu8KyCZF2a0EniKVFS/ej7mRWtCRfjOuAxy8LVcr
         cuufMefuM+0Ab4e9jqI+HMN5vVTvSLZlG9VHO6Atcb+6yFTgb40QD1CbDPyyz2nx/eb5
         lQExdPjB5EljVJDH76pKsNVlw1LI+6Uj0TaQDgy6GKUzJPEIKyI2mzdDbd+JChwwliRE
         GiAuEKkXSGK+1WiQ58aappqHQGT5hgnhlgDKImJjYB3P5YT+vRs2++Fu9SMFIoyvlH1+
         OnQ/g6Kh7j93tO8I5q49lGdXXpHMqbol1EoEOSPePaO2LTiaTOXEvK5Tt7UEZ64Bpsck
         Lu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975368; x=1752580168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0mp9XQ6xSabMpCCiCepDwVdANSTamJrN23jkEJ5pwQ=;
        b=Y6OhTMYQ3kjX+0+7OTR8csZegHLQ6S9Dhj/QI8gbDZPbM4vlKTO6vmo2Y39LntPBsI
         WFe9iN4p6HdWW5neeelzNXgw2zKgTFk8z25+vPsAp/D0NyP8d6PPQeCm7LiwpPBSGBBV
         VYz7eg8AOktw2g7JZ7NMZDEnP7OvMPUc5aE2shi4Ll7jGtyYfaDW3/XODx3pvhTs5QI9
         8QZxdGvHu4iNAP1ehKhBJK4c1FNdg+tyGiYUwXKfYLr2ru8pBPFG/RYeVoBm09ty9Cxg
         DvUMI0miamV9nR91MIc20EoXNs7x4mOaontfGdzBd9n1DF0IrtpLonDB2+npqTjyKB2D
         B1gg==
X-Forwarded-Encrypted: i=1; AJvYcCV3NpY+RSd0SJZi3/2unq8+OrDRmhW37RoVpX5Ojvu9JW85riMO8rlLc/yu0aNxWbYa+dZS+xaSPk7zwnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIq+5cyMO4sJOwjxbdpQ7QhAZSMll7ww6J9NI7cEONJSZKfvoW
	0WI7M7pAuDI4iORSKXThD1cRHCiYeeWOdIbI+CzWerJYGmr2phwFMAj7
X-Gm-Gg: ASbGncs9Dq1XldmUvbv22UU651J1KJNY/WOxNkFZuJ2C6703SPtSNlIjWasmP64qnkx
	WLk0ZForUdykb+j8QvqztjFhXwCFoXsjgWHvdb36o0ptWjvHYeKkk8mCr5XlekBECgKxKm6/EdY
	OPEm4myreGwihKZgJyybtcgPLJRxTKTOAR8/FuXk5fY0IQLqHUCl0ObBxIIa1MCXkgrKd9CW2Bd
	jGzKOWXZYeynIP+30xH06dO+mhN1qVm2v3dHr9RqzMjx5ciftQm8jWcKHhmJcL7G1rj72nksDsS
	/1yNLOUnTKl0GzZVHw4CIH4TkkNavAI1YSjlQAn0h+S4IukP1kmrFzKWA3aCkcxF/Wj6z+8=
X-Google-Smtp-Source: AGHT+IEHHpSUKa9e+nhJ7cjK/de8vdAko7uOLMFGsiKyc4WvaysDfRkK0/Y4Re/liXmLeUqcU/9S6Q==
X-Received: by 2002:a5d:64cf:0:b0:3a5:39d7:3f17 with SMTP id ffacd0b85a97d-3b5ddedc52emr2199011f8f.47.1751975367514;
        Tue, 08 Jul 2025 04:49:27 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47030bd58sm13065134f8f.18.2025.07.08.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:49:27 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] squashfs: replace ;; with ; and end of fi declaration
Date: Tue,  8 Jul 2025 12:49:00 +0100
Message-ID: <20250708114900.1883130-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous ; after a declaration, remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 296c5a0fcc40..b3ae3b1cc0e5 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -83,7 +83,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	struct folio *head_to_cache = NULL, *tail_to_cache = NULL;
 	struct block_device *bdev = fullbio->bi_bdev;
 	int start_idx = 0, end_idx = 0;
-	struct folio_iter fi;;
+	struct folio_iter fi;
 	struct bio *bio = NULL;
 	int idx = 0;
 	int err = 0;
-- 
2.50.0


