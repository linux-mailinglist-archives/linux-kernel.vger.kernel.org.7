Return-Path: <linux-kernel+bounces-835573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2DBA77D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9893B62CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FF296BC5;
	Sun, 28 Sep 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTTVeIaP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B7198E91
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092748; cv=none; b=skP4pjzF4bdvj6K547LkgSmYQ9mD8vlPWEsglGXVeMNDc1rpX51rlmSjlxEbCN0dcF3ZYt7iDKfcRg6mT5M+4/iqswz4oDFUrFqGxIRR6TbV0JXjQEeiBrT87PNhKhRFaqkUEUVTIa54/1mlUlQMT/h78YuWqp3UKATY6klAKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092748; c=relaxed/simple;
	bh=e98vTeFyaAgWFgxnGmLXanTnqZtnyqXFYo7jrzYxNBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLkAHTiXvsWPDiZZc7dohF+V4G0HnHi4jGzc9hPZT+FSmdTO4o5lSU0hDN0u5n6EXyLZU3NKsRbqb5alk8sDNl/KiKCtbj6RO9ydOSWlb551gR8g/TajB+HajIYWSRm197h0UvGUD3qbI8OY6EwellYqTRrpvMZXuL824auPaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTTVeIaP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so39334945e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759092744; x=1759697544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdcg8roz8JsIpFhZQKZgK4s/UlvBbPmXf0POSYEmKPg=;
        b=aTTVeIaP06ACnPHLGePRRl6NFZ5RmNTdN27dxQIecWcoqqOYlBGKGWVpscv6wu4EbM
         RN6itPnRBaW3xhNO75X4PKtwCk50PynQAQP851qZMGUn6/H1EY7yIb4rAy9Pr67upGH6
         9n2/FDIvMPOBlfMYWUNB9A4pcgRUR+a5WnQtdeB4BTxnCiyH0O02qHmNk02mty2dsPpL
         VKlh3kDUgvYKOBGjEGb4Z1EtNOA8ak5Peu8L8s/TWuiAdl193G9DsDvwV1Be4oeQqBUu
         kiCLvndp5yoPCAveOtwM362p1sWsmGK+0lpkdmhYDlcs9WK99HIXmdZHl1exQzU8aeBT
         s9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759092744; x=1759697544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdcg8roz8JsIpFhZQKZgK4s/UlvBbPmXf0POSYEmKPg=;
        b=c8J6usIxBshGo2gX6ISvGfz8IjaPTxTQWaeT2Wn1fNKUBsg9Eo0PczuT/7i8nNez4b
         r96UrDZRzEJO9AmaCHOBLcKQRkk/550K7qipqYE7Jzcak2Bctq+4AgpxKaFwbHo9A5sY
         mb8jh3mtFpwAh1U1gTOXIMkMFyFTKzAvGtChJr8v3Ufr5TGlzrBTDAPa+1RzBo4ZJhVx
         pDvEKZdX7mTqDiQzxZhDJ7tx34z/rONqokGSSrUnmPf7L/WeN6YkSaKwh+PAmqU1JO/B
         8XWIr/EqnC7RY6lFfGj6++lyOKjDnwmWnPU7zqCM4VaMhB0ycslQ7ZDBfrb6sWg9r++j
         e+tg==
X-Forwarded-Encrypted: i=1; AJvYcCWJtwDg418l/c4BywHkJ5xkQto8Y8s7MbjyneAyUpo7wESHU41bmy7hIJSZHFVpq8MSf4nkCyVS/U23zOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAr1slFtfm/lwNeENSLz1RSopuhUvz5wDwKcQGeEdXA9Q8WIwz
	JE7zhE8bCAB8k9eqk9Vv5RloMy/70zIfiOPgUEdfXSHGAxULxRGaEIIo
X-Gm-Gg: ASbGncuz4uRD1WahFnKFcrv0dHCZMjqunwbDeU9EqRB3zPCwrpa2D/teuObS7iIIvNH
	f1HMdyTt4qZlD52doRjGSaHPAt/4LwYnznrrPqhZuavfxfYx2WUa46gImmTiTTGNx9XcCkze6DZ
	kUrmHHTd30YlhmXnREGZ8yRBTulGRqeFqeS5HEQt9u67ScC2d74RrjKPbKYWVhSiUZa1rILBTjm
	f3LEseYbfoQaybg38/ZKQswy28USHR1rcGaJkXyJ0QLPoWXnTomqAPc9XczLH/3NUwO0HO6nWqw
	IlABWeSpHNSmPRJnsVY/5ROU7oGV0YzWooIaGFO7R5X/IdpY6c4H4gNK79zZWGKTW2JbD7ICQPk
	bCjMetx/6RpUtgoqzMl90+1HL1kfvsUYd
X-Google-Smtp-Source: AGHT+IH+osSnEPKgJeRhbgORMbw8I60o9JFRVApJP8/1VVoNnTb9GbeS662wmp/6bN/fBTGRWd9/PQ==
X-Received: by 2002:a05:6000:2381:b0:3e5:47a9:1c7a with SMTP id ffacd0b85a97d-40e4a52475bmr13435225f8f.62.1759092743838;
        Sun, 28 Sep 2025 13:52:23 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb9768bdesm15725382f8f.23.2025.09.28.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 13:52:23 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David E . Box" <david.e.box@linux.intel.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] tools/arch/x86/intel_sdsi: Fix spelling mistake "Licencse" -> "License"
Date: Sun, 28 Sep 2025 21:51:34 +0100
Message-ID: <20250928205134.241041-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a string literal. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
RESEND: send back in Feb 2025, not appeared upstream yet.
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 766a5d26f534..0e12b59976de 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -315,7 +315,7 @@ static char *content_type(uint32_t type)
 {
 	switch (type) {
 	case  CONTENT_TYPE_LK_ENC:
-		return "Licencse key encoding";
+		return "License key encoding";
 	case CONTENT_TYPE_LK_BLOB_ENC:
 		return "License key + Blob encoding";
 	default:
-- 
2.51.0


