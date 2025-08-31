Return-Path: <linux-kernel+bounces-793337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCAB3D207
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8590944245A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10822253B58;
	Sun, 31 Aug 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMpzJTe+"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563F253B40
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635240; cv=none; b=M6hG2hqrt/gZLM4lgsaFaLw8WoIubQQQ+NLS/qDYhK5ai5Y7ZpTkmoe0OA9BYPZUcMTy2pGXnn6C0gerE/fuQf6AwL0Klbz+/Pp9CeC6CT3ZrF73i3eW/AthnQ3C12/fEKQKufpvX7FpQCP88cPiz1Ys+SCC+Pj8/n/kJWjKoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635240; c=relaxed/simple;
	bh=D3PAz7xolElE1kPDF1ZM09nYrEAsUXU4EAkgU2JL/Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/i/sK17Fi1IOxoQxqCtkOLPpNEMXurbp3BVd5SPPrE9Hukpybq7zj+r6pfAldhcbROXCwcYfjh2YjGxCS2lFkkn95rvhxEdT/WxU6k+S2bhWXZzxqeeuuZLIW6WTlswmt+ORn07A74hCLB0+5479DGnwOXvH9DEb+V08bsXaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMpzJTe+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b30d09da9dso22746671cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635238; x=1757240038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwLs+yd7Js8fsBQIKUi8xZzZqVUjN83bbv0x9rLvc8Y=;
        b=MMpzJTe+h0Pd8goULjF9U4mrCaozQBWGXTzUhtl3upK+o7rTqDplubJCKyeleWGUIW
         bbohM2dFfpW4A/H/h4ve5EJYCW5IUG4PikWGrjZO5xhXsHtrpyLV3GnD42uCL8gh/h9V
         zbTsmIFvltzopPwl8Vuf47h/1t2cg+nlIwwMIljLr3I1CZmFFtNv2WUeMRHh+U2oZ/ZL
         i/fqsrFnNLmQ4QpZ+Our5ux27unDDTJVHy3IgcdemFNlwHnf/4m5AcTkFo6HjErsm6FQ
         m6KXN34E5D38PlnflfqJXlUvUyDp1VZUTke0zrryAD9EslzYdpbIQzX7VOpUL6/QSIDW
         0ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635238; x=1757240038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwLs+yd7Js8fsBQIKUi8xZzZqVUjN83bbv0x9rLvc8Y=;
        b=nCgqo9YM5W/DLlunkcOxrWv819tPo2CYQUl84jnxZZNZB5tPMxiiCDI7KlGZTcsj6C
         SNrlfFv3StISpIlFMUuGKB1vY6Lz0+CLKBG9ufkVTYbhqeNUHc2B4GgXNV0NlEZk7UjJ
         LdTx+8SeoUSi4TKLutWR+FchU1YWb4fX/uIDQuFJxnamkxUO8Z3PPJlI/gzC0o4P6Cs3
         WRHRiCFYaj5uekmwZvBsONnqEyaPAdMq8HCC1bed24V8gJ4ql6fs9VqlnH20O4TzX6vD
         2T7TSp3iXF8+s5gKRWKL9u772UWYF0FGT0WBjdEZ48TGGG3gz5oORXXZUMOW7xfWqTMk
         Q1LA==
X-Forwarded-Encrypted: i=1; AJvYcCWCfiFQB66QFODw65Rfi62JYtxPzRJYa85Sr64NOHvaBI5csg3goo4daw0nRkzI42ijmhRrhroVrrJFC7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMM9SEweyEPCfLEiZcLeF4hpL5CIOKa9FMj4DbfjX7WJ4Xjkn
	c78EQm+PZo9BzL3I4tFTteDpvZgsrn3HG/1v4FZR5Y5AMz/7gxc5+Ed3
X-Gm-Gg: ASbGncvnEpmJbE9pSnGAAFPAiNRYUwSoOwpojyIfTMO4cfH+otx0JXKJdfyffFkeNHA
	PLDK/TGVqgOEskCl+f8rqAESIkSHL09+2jfjJHHJiQRJ10U9cTbBMYpI5CzCyCY9fy1WeDi2kdW
	HE0SwV9EntWhy9r0wMM+j8uj65fE7tfmnzy5sJW3g6M1iGL4/X0MtqgByWNByQD+4Hx1siYYzlx
	lTpQ7mV7Jjbu0Y1PC+zOvzHjapZaY7bU9eKmGiybCkLvR4MzEAO7tZ8w3IFqDVpTgqYAS08NUT7
	NMFTtGEq7F1ZUSoSL66WJWhwA+5x3DqkIqGFcBWrWA1c4bhK2l3eVJvWPu38amTvAe8OLVEvwtE
	WLJ58KbdoY1SvLzCZiNZTcUrUY8mttlKqR2HZ8vCPCu0e/byMmOiVhS1PHwRCjiW/pesnQJFoJA
	touQ==
X-Google-Smtp-Source: AGHT+IGF1YBb6Svw1j1OAHo2SBJH1f0rWNyLdHZ8Z06DpzWmnkcg9yYT6YNGbdQBHFRvMK+G2mCOUg==
X-Received: by 2002:a05:622a:413:b0:4b2:8ac4:f099 with SMTP id d75a77b69052e-4b31b9e7837mr67848031cf.35.1756635237791;
        Sun, 31 Aug 2025 03:13:57 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6e98f7sm43727141cf.46.2025.08.31.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:13:57 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] trace: fix grammar error in debugging.rst
Date: Sun, 31 Aug 2025 19:13:30 +0900
Message-ID: <20250831101339.11324-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831101339.11324-1-seokwoo.chung130@gmail.com>
References: <20250831101339.11324-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 Documentation/trace/debugging.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index d54bc500af80..4d88c346fc38 100644
--- a/Documentation/trace/debugging.rst
+++ b/Documentation/trace/debugging.rst
@@ -59,7 +59,7 @@ There is various methods of acquiring the state of the system when a kernel
 crash occurs. This could be from the oops message in printk, or one could
 use kexec/kdump. But these just show what happened at the time of the crash.
 It can be very useful in knowing what happened up to the point of the crash.
-The tracing ring buffer, by default, is a circular buffer than will
+The tracing ring buffer, by default, is a circular buffer that will
 overwrite older events with newer ones. When a crash happens, the content of
 the ring buffer will be all the events that lead up to the crash.
 
-- 
2.43.0


