Return-Path: <linux-kernel+bounces-787287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A26B37418
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9E1BA56B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF162F6597;
	Tue, 26 Aug 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+njCu0"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2566287252
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241792; cv=none; b=C/XkP7N4q3+dCKRjgTs4C1OOMfNL8cxzcmDsz2dDG5XIxaYz3rsMuhAqpsVjFWC7hTngA+pAliOOV/OmneS4hIp/a6K02rrciR/JzBTIttxVlwMYCW4lVdd+KFgBFaJeno5JGwsYY8cxCtSazzkAvaJQ4fiNlq1j/rj6Qy78QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241792; c=relaxed/simple;
	bh=L9mBqIG1TiHreIDV8a0dfjkIxduVLSZagZOu8X4AsI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORxNRgcsM6QQVXlOCA0tqBO9rz9rSiHsafZGQCM9HTRUnpiOLypPOUiWxiYS0IsVMvSuHepT/hGJpVxOHfuhRfEeGGcMFTAAJfRfDLFUAiyApLVA/sCMohAF/IkUg02rBjqfLbSZOYo9a6qq8Lan7djRvWqFo0b8zYSCyM9eBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+njCu0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771ff6f117aso860128b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241790; x=1756846590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=bG+njCu09Q0gg3MORvVbazy5TRZ3xu+yMKXQ+CWOCRoyNWIHUixAoTVxJE2dodewWq
         bOOhFKjAe3JXn2TSkXOzGbsXjVGQgUxpLhZOOyJ8GIlcAgzkz7chMujVSyM0uBF9TAMS
         hZJAWAYM0vRY0VoH1U7D5zxlWBIpW4tO9Yck8LtVaNzbsvMy53t9NB+5iYqIsn0vMv2J
         c/cddTu6TPsY58D7/uGqBYGa+P6LjxA9yGp8ZB6kGqV3dY5pFRk+hb3BYmshplLZztYZ
         /6CnYUpIMM7eIks8X15zRr8jN1kIqMJWtcoUbYRgcjsLlPPD3dB+OIlCh6/7ITTK74xE
         1RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241790; x=1756846590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p96JFKpspRPKBmH2rgBynj/gu4bh0EGooQeUZ0NhcIU=;
        b=lu93f+eK4+rCXaBYL7YEDPiyn0XmhcJtFVCH0gIcSGxLXohdWrRYL/bSVqxPHADiyh
         cTrydnRWc0jIfbBSC+Q2kSYf3CqlsoDYtaetIHfUAm7QwF42ug3db+BFuZmOONndBnMs
         gSI050L5k5dULOn2JT/1IYIkobjl7z4lpCaPKyYALGcsCGYfP7YihpkUfiTkVozAPbGm
         s4l8jjkmZ3sP+h7gnqCKuw/QZYS5Pf4nemNw6+iiZBnV/Fg/eF8rOYjUlm8u1x1yhwMa
         kg8tpV2Mpsb9NuyslwDLQ9RWT6HKyne4hxJhgEwxbLRwMUZB/KY7dvMDDaxElbjIm/gY
         TjkA==
X-Gm-Message-State: AOJu0YwYZB5PUsNLQCvW37h6ojmzHGVjZDBtNS/4uoPvPA/6saft+qf4
	W6+3wTZcb/6Z66XU2ZCfQ9i2GPbQz0My48S6sgkJ7ERvAB7pucGtE5Ri
X-Gm-Gg: ASbGncvZ7FA1Z4IhcQOBt34wRKZLmSCpYeESt/Fc1H92dtdz5C6f4CSM2CEQPgpBgNk
	pZ9lYGoh7xySaiTBR20B8/PaOrb/nPPJBNU/QIBKNFeZNiHa2ebnBj7WzO2pP3//7ztA5X4s3us
	MyutjU3CZ2oJiz29nsSVOYlpQmqQGSf3w19OOK6SikfZbvuAa1tUab19kKc8c09yMAa5pn5+xEp
	pQeTg78fdGs8/dLP3nd0F01SKSszFNCZjAs+VFOESve3nmVc3KupQTs8SVYYKmfAKy7PPxOaPCa
	+6kr6N2Okpc8l39akb702+DeA5SjwNTU8/H1QCNosr/z6qBxRyNe/uaFTRUCh0akXaCS9sUMXeY
	FyJDqOHohSMpyqD412zoT8ibAm7FvWW+PaDF+egbL+8CDl7llfFLLNA==
X-Google-Smtp-Source: AGHT+IFOjLvK0nFgsEOyBO46ifHUqODgHu2tpGV0k80H0vvFtGAR4qckJwDeMLRyP7djf61/uqXYGQ==
X-Received: by 2002:a05:6a00:1387:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7702faa6402mr23492301b3a.18.1756241790196;
        Tue, 26 Aug 2025 13:56:30 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:29 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 2/7] aoe: Stop calling page_address() in free_page()
Date: Tue, 26 Aug 2025 13:56:12 -0700
Message-ID: <20250826205617.1032945-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826205617.1032945-1-vishal.moola@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_page() should be used when we only have a virtual address. We
should call __free_page() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6298f8e271e3..a9affb7c264d 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1761,6 +1761,6 @@ aoecmd_exit(void)
 	kfree(kts);
 	kfree(ktiowq);
 
-	free_page((unsigned long) page_address(empty_page));
+	__free_page(empty_page);
 	empty_page = NULL;
 }
-- 
2.51.0


