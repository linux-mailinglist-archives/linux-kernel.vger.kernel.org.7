Return-Path: <linux-kernel+bounces-897990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB5C5416A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B113B7C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072334D4C1;
	Wed, 12 Nov 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a59aUyku"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080434CFC7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974554; cv=none; b=G0l0/vob77cf5nvkjSwqqP13/WfEFHXyH71JEg85n7X4A50S/3NezMUOQ7X40CGXxOAxu3eLbeX7NKUP2B6xO0tBafLHa152Kz8znlmoK8FTmp0iKKCJsl/Jht2TnVqabomW4Ay0SSPO0j/qizhkpXG/bmL/10nBvFXb0OZEdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974554; c=relaxed/simple;
	bh=vCZSV1WWxWmjtBXURpOwW4cZm8n5J6wXTTO5rnBlH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayiuLSz+ECXm+phnY6k427ED9omJfJh9nZQlRNZYRgzYGJTpzUMjL8Tfn6WTNfdVzGf+o8i7Rx1v1GANaKy8y/4NmyNSVfl2uJvLXKFSR6wIzBO9N+63qCE62GvDtKlU98W8hNN3Mmaohm4pPJM/PA0YPvOZfe0UwUAsJ6oUy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a59aUyku; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4736e043f9so16864166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762974551; x=1763579351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4HxarC/0cHfwsXI7e4vj+A1IpTTWGHNmxw+3uenBi0=;
        b=a59aUykuNRw4+z3fOG8ikc96jaHow3Q0L4qu/mex+YNiU8CneTyklFguK6oco36jOD
         c3Iegn8U4IlzPlqkVp0htrKXaUx0HifdOur9VKnTXTiOl+N7U4NCtS06bwKZKYYzyEj2
         h8jD0faL2eGyjnY/xwb7OO736aT5zxLBgluctFZbU/2jcVFTPaVn0rM36cjsqL1Zhhni
         ZtYgHL6ODzjmifxrd9Eyi9t417FjvxIGQa1X7qDkLyEvq2lA/UH2UnMTS2MUb14BwVOo
         yP2u23I1J0h4JCgjFnch6NNmAwAdGmPx1yQfxOtEGUfa3gFCsy1zHvVA+5wUSreDUP20
         0ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762974551; x=1763579351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4HxarC/0cHfwsXI7e4vj+A1IpTTWGHNmxw+3uenBi0=;
        b=XFgN51LSKMrq901mLI9T9U1D4CAzAMoOMO08XnDS6EFoX34FIyolGEn0epVYsy2qYD
         OcHs1m1J4Sp7c4LgvlYm6yqWCHP1UbaiIMw/+rKJ0FvrYBB/eADS9ZVS6Sfn8sqJyKu/
         f21wF1owX6R6EYsJS43q94P+RMhHuPfyYhNGFjDwfuh4BAr2p6y8JtDC69s2yXRYldQu
         rr9WDy5R5+KcKPxNYMXtWZval0mO9MGo5XghCVKfQSxbtX8xX4DVjJK7QNhoE6xBEEb6
         TodLTCjYxeicp2K3va1hJwBakMwtSdqdEDfkXuYl0mAWSXBo3FUAIPLf4HtkVMzw4yoY
         GAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXifSPzcbGdDASaSruS0/S/8k6buh5avryHs7AXsviKJh4UJ0CgmfQPB4Ex4pnclHjMbD+gSkH6pGKXZXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaTT0tK1jG4o7JKNbQ08g3OYW2q/Hxts/rahTXUgLtDG8p5oS
	xqtXLTxf9hCBQpuQvAwi1LkXk4EGGn7RiCX7PNanUp2IUuETib7+UhY=
X-Gm-Gg: ASbGncvmtHjnzZaVHgQreR6SQ/o5viw+iy/i7GbpvROtahxuSQFn/VjN37neKIWWQg2
	W4bLvtSlSfQ+8d5USSBp+6FIw2RT5GL/uSxGi3AIxDSSOoLvJD21uNPda1EOp7DXDDlIH1Oya3K
	62Kps5K+64MbiIlRV4GI9SBusjG5psSM2Cg2iyIoQdSlZbgVcQ75HEBzMcee6triTteujGF28GA
	FTl9rsLJHISZFJHiIVR+V9gj+tutxtjskB5gY+gBNUD5ExezEQAY5JJvSs/HAyVmNymyJrrM4GE
	p1sYfW3jvT9FXINZXuZrcy9UW1JPDLMS//2P205MaeX2B4a8uLr35UgzpIZEuBJ4HPFXUSMr7aK
	TF2qf3Om2Vib6yCK+VT1bb9ovtfKh3dhJ9txsQeopKlfD+K3xO30wxT8GiNrZGHTEsT9whxpCh5
	augJAW4eFkV94UwnzXrx43Fhoc7HieomPySKmpNUw1cUHwMn7fA3RnRtc8iug2yCMfkOc=
X-Google-Smtp-Source: AGHT+IHxy8pjSz5ZXQAhsov6reJ0AmK0QM7dpISGdovz9adYZVIS0mObDjcrOiPl+EMnu74xwF1Gww==
X-Received: by 2002:a17:907:e895:b0:b5f:c2f6:a172 with SMTP id a640c23a62f3a-b7331a70378mr423238766b.30.1762974550736;
        Wed, 12 Nov 2025 11:09:10 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b72bfa24d14sm1659239866b.74.2025.11.12.11.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 11:09:10 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH] sh: maple: fix empty port handling
Date: Wed, 12 Nov 2025 20:04:44 +0100
Message-ID: <20251112190444.3631533-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle timeout response from empty ports of the maple bus to prevent a
stuck maple_sentq and a blocked maple bus.

When only some ports are used, e.g. if only keyboard is connected and the
other ports are empty, the device tends to timeout and return 0xff for
the empty port. This needs to be handled, just like the
MAPLE_RESPONSE_NONE response, to detect empty ports and to have usable
peripherals, if not all of the ports are utilized. Previously, an empty
port resulted in a never cleared maple_sentq which totally blocked the
maple bus to be used.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: This patch was tested on real Sega Dreamcast hardware and resulted
in a usable keyboard, even when only 1 or 2 ports where populated. The
hot-plugging of the keyboard does also work fine.

The description of the timeout response can be obtained on the bottom of
of the page: https://mc.pp.se/dc/maplebus.html: "If no response is
received before the timeout, a word with all bits set (FFFFFFFF) is
written at the Result address."

 drivers/sh/maple/maple.c | 1 +
 include/linux/maple.h    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..3d6c716cfc98 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -649,6 +649,7 @@ static void maple_dma_handler(struct work_struct *work)
 			list_del_init(&mq->list);
 			switch (code) {
 			case MAPLE_RESPONSE_NONE:
+			case MAPLE_RESPONSE_TIMEOUT:
 				maple_response_none(mdev);
 				break;
 
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..4ae3cc6678a8 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -27,7 +27,8 @@ enum maple_code {
 	MAPLE_COMMAND_BWRITE,
 	MAPLE_COMMAND_BSYNC,
 	MAPLE_COMMAND_SETCOND,
-	MAPLE_COMMAND_MICCONTROL
+	MAPLE_COMMAND_MICCONTROL,
+	MAPLE_RESPONSE_TIMEOUT = 255
 };
 
 enum maple_file_errors {

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


