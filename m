Return-Path: <linux-kernel+bounces-877533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E4C1E5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE51402585
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BD30BBB9;
	Thu, 30 Oct 2025 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0aTCYT7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC92F60CB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799201; cv=none; b=lnZ959EeA0lAz187Me/R/Ti/UtoCFfCy61FOGXci7frXlVdgPtWvO/GA7KrrucOQhWnGFfCSuJWn6C+mV37VEYrftrkIwEOKstl+Amuz5NLRm50ojNx73V94V7bsshzdUqgDJhkXUyuAQZqwVu5zowKAD+AWhNcInzalagBz5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799201; c=relaxed/simple;
	bh=ylCmhFM7cJmjVhYJQQKlRmvgfFCYeLYyHkxtenDhaV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vz00MCaZaPGaTEJRT+nz96I24/w3p+2H3pfqJkg7MdcLxRrrEaMtrSYlg9ZAykagSu0Yl4jjKZbfUlmaWYpkz9TWPowSWA7haKAMzD8dIm04UcS0MBW+v5+JFI1bGZSjwdPIE4W9y05+HgEvu8tS17n1tCadW/f2Mm0FX4wXDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0aTCYT7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290ab8f5af6so4177285ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761799199; x=1762403999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dGqbfRti9hKegZ5HASb6KUqvXOdBftPi9jvd9UavZPQ=;
        b=B0aTCYT7K1yXb2RR6r/0i5hET/gfnJP2Pi/6iI2EgSmrow87oxpL19lDPrl6AT9P5c
         vpraF/Cne7tLVawv15lbI5DKs43TuhPzrcsqfnspHK3CuIYNdpWMKH3drN7ZeJbj3yJm
         dy/Eppp3qT28xty/vP9ah+I5Ogw5gp8euNWEkRuuVnaxiRcfx6E8VWSf1WOupSwBNU1y
         audHMcJ6K3Z0jis2Nwj0QTGDLDdOUInQRtRex6zCw7yNy4dQNDHb1fBn2wVZZIVNg8VP
         x+o9gINBDn110bsYY/9RGshiyqQMsqCd7WqXavjEds4t+rVNyNsxFcJtK6MdXLwNYDrk
         Rhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761799199; x=1762403999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGqbfRti9hKegZ5HASb6KUqvXOdBftPi9jvd9UavZPQ=;
        b=mYNNQBp2HheVVnKXX1NHNJLIJIFPowHBXJJeJzo+DXMFePPEPBjcqSc3aF2HGWeLVd
         2pLt57ThvTA8dDn4tFc14kGrNBMDCGUl1KX5xDPtlNUshcL8I8D8ObpLny/pNZzHHa5I
         W5EkCrUPtT0rGWA3DLmzUW/SpfcSDlGEWucWO6t/uBfvr1uAUbg4KdBtGsfLeG7MfDwN
         44cAoFXQzO+myVymKmpgYUEmVED3wJw8NS0bB7gyn2BfFfKiKT1vQZQNEpOMI2jtxU7X
         uoYEVcXhphVLTFCAekk5gg1yJPv0JO+Hc6AqsRlbirp4q3VGvA6C2lYQlmUtKzKhd9JM
         BbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUztGP1Pwf5JYgqq6ZBIIpE/w4TZfYmqLIgeOTFkkMOHjGA08tPo75sAKWP6SIuMLiQMfoFjNsBGNa3imo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5gtfHHNI3U1k/fy+UugqJVJCCaahhCeX6lEoPHNRd/g6FkBY
	3UvOjPJGC73/QV8Ooy/MK+BJT6ByNxxFasJVzX79Uijeo5LGukZT9g3sYfNyEGnClja9dWO28Sq
	UpyojpT+iXJ9KMQ==
X-Google-Smtp-Source: AGHT+IETAfRwSZjXvtbywaaxsUIs6gs/rosu5l5QM3+aYkJm9qGMcrBnPPBbsvi03WTHK/FOtH1RVHn61ndsrg==
X-Received: from plhs12.prod.google.com ([2002:a17:903:320c:b0:27e:ea91:acb6])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ac6:b0:290:b53b:745b with SMTP id d9443c01a7336-294deedabdfmr66533655ad.39.1761799198776;
 Wed, 29 Oct 2025 21:39:58 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:39:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251030043919.2787231-1-cmllamas@google.com>
Subject: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
From: Carlos Llamas <cmllamas@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
fail the data unit alignment check.

This was flagged by an LTP test that expects EINVAL when performing an
O_DIRECT read with a misaligned buffer [1].

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/aP-c5gPjrpsn0vJA@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 block/blk-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5a..3e7bf1974cbd 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -292,7 +292,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 
-- 
2.51.1.851.g4ebd6896fd-goog


