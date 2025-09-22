Return-Path: <linux-kernel+bounces-826892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67839B8F8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0181B3A9BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B8284B33;
	Mon, 22 Sep 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaUiA7u1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F827A10D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529988; cv=none; b=FF3iijlRo3qLCyfS3cWztiqExF4AhE+ei8ch0alsKN5ERxaoQv76YfyKdNrTHiKGtAImAa8ayzxFAooAmx61qTJhh+mxohh7yIZUMnxwyobUx6MJnfnVJyMWBcvE5XYi1ox/olsqLv2WlbZ3ASd6SZ+u4sGfuRFgRvIkjdJGOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529988; c=relaxed/simple;
	bh=TUI935ItxNpscDFWb4m1nohbc9W1iX69LCA+S9hjKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao7IjPBWILBMGNFXadF/PFMGbLZWoV2PrbZy7QdTgAvu5tihtpqmG8/8ERfFgBLpO2AGq3w1r3JjILvGGf18CoC3JobRVPw2akPu4QCPoO+a0tx3e18YNkiUefrpyk99nrx5whnH8lp0e2dqjFYgcNm8ve4bb5jeqDbO9HRsaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yaUiA7u1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b256c8ca246so515544566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758529983; x=1759134783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=yaUiA7u1evfxzBqxE1ucDiUZbqjEa4j+v2tjSVi534mIQeD8L/n3tABs7RTACGTrmF
         p/saExUy78UEqp95unTG4m4Cd3prTurGCFsdf3elCcBd5AvW/ZeuqiEkS0e30zTae4c7
         yocrb5equcldLA952hC2ZAOVwxkr1InOhA8ruJoUKYAmPSwogR+5K4WU3dN9blf2l8B1
         fXjG4CK9TMZAddlGjju6SMjB4frHSbEb86tUuZCFSm3ktRxpSFZXRJBfwqQsSgu3jpQM
         R8/cEuyAavU5qV41Ccde4zWoXF7ssCvq/JaSzuhHxYJLmmo8xqJag3C2f++2TiWDGy7o
         vZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529983; x=1759134783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=pgVSpyvhNO92hSffkSeTX6iq4cYFMbNlg+e0pVqLP7tnxhQKVmkN9JerXk3unvFYiZ
         K0tHlRUjqV99hTEgwDWjXQ2+POA/nlzIQpTiD1ws5TpGh6zlYTlga+6Kc3NE45O8IJdZ
         V9C8kGDHDefY4/wCZJesZXvGVWL64QYeXfUNzUJtnp5hVMavyb4pBkalfHwZp9uf2uE6
         3SrJb7WUliZy7vetBpE/0oQ4iXIkwQzD6fStedCwCMeBa861s/ncwPrPPZQ/e0AzQbnL
         bfxQ8nZICsO8i5cSBNcmc4C0GUyRzcIMCj5ni/bgg9VAYbANTYxaAwy03QNPcb6tKim3
         hXrQ==
X-Gm-Message-State: AOJu0YzupxnZvY/O3KO1bfiEqcRtKHaEDKlCECxgwr5K6K6IQH/C7e0t
	KD0pKWVDSJCRdYUj/260KiNAtd12JJjth6ob4DjS/P6Z5/U7mgtGvrFe8sEQ30pLEXAdedyrZsO
	3mh5WLus=
X-Gm-Gg: ASbGnctRJ84wak4w5NMCTDT73/YtqjpAZFNSBzlcnRtP+oMH8ZuCnGH0tnUu7v2FyHc
	ad9ZR1tMMVs8u5A87HPb3RbvxSzBqLEBOJcFa5r7r2KeEhbaEmZ4RsA0WMUCgoepinQviDAL2mX
	oKC7Qt0d4z6fzezro2Q2zaq8sx69fBE435mnhGZefb4xcTNj6AmftJ1Z3uDLtKY33kobBfRPif6
	0fEqOsG9xGVL54hvl670GyRQTtHKij8CiI/fdgsp752S1Orai//AtZxWzJfuiWc6xL868m+jFMi
	bJxuMYd9EdGwhOW9XKt0qr4aSqPe/xEcZrlHQjq3dIP9NapWjLRZRDawwNUYRzICcEeqWe5DpG9
	XBAO7iqXWAvdTt5gur7Ph+6es2v4RklzVenWLmgHU7oxX2KIkByiKAnDT+DT93nk124XHzmR60E
	Y=
X-Google-Smtp-Source: AGHT+IEbPgqjM7/4K73DMablLEbgOSElJBbGuyrxWLRLXPYLxggtPsrNtX/eVEM7H+fF9kMNQPcKqQ==
X-Received: by 2002:a17:907:3c92:b0:b07:e3a8:5194 with SMTP id a640c23a62f3a-b24ef97943emr1080157566b.22.1758529983418;
        Mon, 22 Sep 2025 01:33:03 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52a2sm613789966b.53.2025.09.22.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:33:02 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	stable@vger.kernel.org,
	Masami Ichikawa <masami256@gmail.com>
Subject: [PATCH v2] tee: fix register_shm_helper()
Date: Mon, 22 Sep 2025 10:31:58 +0200
Message-ID: <20250922083211.3341508-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In register_shm_helper(), fix incorrect error handling for a call to
iov_iter_extract_pages(). A case is missing for when
iov_iter_extract_pages() only got some pages and return a number larger
than 0, but not the requested amount.

This fixes a possible NULL pointer dereference following a bad input from
ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.

Cc: stable@vger.kernel.org
Reported-by: Masami Ichikawa <masami256@gmail.com>
Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
Tested-by: Masami Ichikawa <masami256@gmail.com>
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Changes from v1
- Refactor the if statement as requested by Sumit
- Adding Tested-by: Masami Ichikawa <masami256@gmail.com
- Link to v1:
  https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklander@linaro.org/
---
 drivers/tee/tee_shm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..76c54e1dc98c 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	if (unlikely(len <= 0)) {
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
+	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		/*
+		 * If we only got a few pages, update to release the
+		 * correct amount below.
+		 */
+		shm->num_pages = len / PAGE_SIZE;
+		ret = ERR_PTR(-ENOMEM);
+		goto err_put_shm_pages;
 	}
 
 	/*
-- 
2.43.0


