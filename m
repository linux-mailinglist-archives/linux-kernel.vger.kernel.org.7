Return-Path: <linux-kernel+bounces-761004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA0B1F2DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD0F1659D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C8275AFA;
	Sat,  9 Aug 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqzZD8v2"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D521FF36
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724627; cv=none; b=nhKRn9IjOGv68zIhosHyqVbtxqZE+8xTZUxTqKQw1e7y1WJNCGFYDFEjw4OICjBYGrRQEV8xa/2ALp6w5VIEza2Pep7s40yYVhLhGVcCod/YaSuLayKPao1jbnOyX8PC1awr1kGKhiINmmaeWDlJStPyc+797o7voUmew+xVxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724627; c=relaxed/simple;
	bh=TSe4zATZxEk1cHt6ljAYPN/Q8Rj46mIVDklyTE8HiYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBJ9KhQdrA9f+wHQ8VhrLD4ORpcMhVUYKI0O7iKxbQazI2ORI1fIFtEMrWmbFgQx7xExW5azB0jygwRYXeVnS5FfvbRoqVJ4ylyMMPQ+Fis5kvIHgBN1DHgVCTY9u3HDe7FKW9P+7KRbUIzq8lzYIxKdnVFyFRrs3mNDuYPfDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqzZD8v2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso18378805e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754724624; x=1755329424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Do2sfXHGCwmTB0lD4CSWjiIo8PsF+oRbjI2uhqRToTo=;
        b=LqzZD8v2CVcutch932HbPPDsorf6TX4XzfQZA/+MgnnXuvX85c1ZTZ1irMhHOgzm2W
         jCXbkStAa8YuQdnCW/de23T1WdOLrK/tI0PJmNKzHMy5B7A/rF7qNj6N2RRsBgktxZnm
         C3pDTXZFWj50Uk77AAZBI2HnPQq//XAOFeMcCtLg5UTUg4F7tbNuNo0IPObPaPpc8ABE
         BVkw+/ybuvy8zFZB6ShQOlCpUDAWVR6MGl6Wi+XKIIjygkaNTQ04NCw0hyu78qBg5VvV
         9AVOW9OUzadT2/AQPoanlxIlVXs+rljHR9txnfFKml33WvD+ie8BnnU/aqC5ob0vJP/x
         F+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724624; x=1755329424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do2sfXHGCwmTB0lD4CSWjiIo8PsF+oRbjI2uhqRToTo=;
        b=behKJLEnzv9QDY6ovhqvoUb+QcbY6i2K+5J2ZyfYhiQp+unHH8DI7fsXZ6eVVw9snr
         3BQdpSikztgm0A5gFR9iOZXDm5xmepecBLauoluwW3Mv5VOqjRr9kib5/b4NcNHp0Xq7
         xjvp6c18voBiIwjh6nwZVGZD+Dm+QftXlGaeNODNTzXdELoPwh24fzfxmR8KuAfBZxeg
         /adN3+8tu0w90x8HuODOnvtAPRG8Hko6A5YHhER7Adl5iy7v1hiMo1lgOnImrBqlID7a
         QhjwX2uoswhym9kAEEtMb9hiJmBIkwejwDIadjJmWxE95f8g+vr8wGO7O4XEhAEEMPGX
         KBKA==
X-Gm-Message-State: AOJu0YwDYKPBajZ2CzFvN0rZsdUYUz1Dp9Wqmkw/66vyX9/DCGlIT4JK
	1FuV0Hset+/fuc6Zdq73BOtSEaZ1ql91BjYWalM4W2ze0HPHT4KcMUPF
X-Gm-Gg: ASbGnctPqm4tSGPFkkvXKJFmMWbB7vLHrsYLUdN9kGSO0RY3Eeu37kcvgqQniBVJSul
	T+yEiBUZIIibctIuKHIk8PjDXH0R6FPMWnSYST/iQm33D1QvTVLwhwKrA0UX3l7y0r464eCU5eL
	/cMNmBVNVYgolFTYmasEYCD4YhEJWhrIzm5NOKcWwpZQn+6vK+3hTBf5j8ITX6MXhYenhRhKc1V
	2y2P1OynyHqdZM82t1U3G+ObC8Ey+XNFXzPln4gVJO8+su7PylRBO4Yl5Kx695rBb5/kAJaWXM/
	rOsJmYuH1ZMyXUJ2cJIsmT1yhfNYR33q05D1pla9vrW91Vh/jsjN3zjWe7yHbBFR1PhT7AfPiaq
	edyYXDRvrSE1YKg8xwNUgGsOE7EOO2pMIWMqr5NBNpyAnKKOwTmPJxnIyQyon4l3Gpw==
X-Google-Smtp-Source: AGHT+IGEyXD2v4FZmrElYPrO2CCUxb7LYplVrp3/CnZ+0t+lZUa6Q6LerFPs3ILp9G4X6/kgUy1rdg==
X-Received: by 2002:a05:600c:3b8a:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-459f4eb5717mr49325615e9.13.1754724623326;
        Sat, 09 Aug 2025 00:30:23 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eff7918csm99430815e9.25.2025.08.09.00.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:30:22 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 634C8BE2DE0; Sat, 09 Aug 2025 09:30:21 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>
Cc: linux-kernel@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] binder: Add missing module description
Date: Sat,  9 Aug 2025 09:30:18 +0200
Message-ID: <20250809073018.1720889-1-carnil@debian.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During build modpost issues a warning:

    # MODPOST Module.symvers
       ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
    WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o

Fix this by adding the missing module description.

Reported-by: Ben Hutchings <benh@debian.org>
Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1587
Suggested-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 312b462e349d..0c2e38ff3a3b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -7090,3 +7090,4 @@ device_initcall(binder_init);
 #include "binder_trace.h"
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Android Binder IPC Driver");
-- 
2.50.1


