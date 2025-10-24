Return-Path: <linux-kernel+bounces-869189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FDC073BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650861C271A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD1277011;
	Fri, 24 Oct 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVaS65Mb"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817A23C4FA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322535; cv=none; b=uL08pDGrFUvAAYAhV+SAJATOzxL40mp+b5ayCa5UFqLD55WTeYHcvsfZ88cwuT83nYljRYlziq+o+YY1RJlU7jjnwWaWD9dbgc/6cbPKOOy71lCmco+LW15EB3XyHpL63FR62bB1q4fv9LmaIlqodqXA1N/VlXgVuhgcdiNGM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322535; c=relaxed/simple;
	bh=g5pu4oioKeu7GYTHqDBdTbaeMBxq3QgQ9xmLe3TliBs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oODcGbkqL09vl5QNP6ZtCCnR6DRSyJxECA88oUu5OfLDL7IHWzbxxA2OuGl5QeA9Cl+Fh/25Rlss/j3MUCcEunVMmmToPw4Q08AgaPv8OQv0UBcrXv7Xn2FN6My9Cht93eC0CBWwg68PW9CMNBG31CZEoXSHvFFJwveJxOtzAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVaS65Mb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so2471221a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761322534; x=1761927334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Y5vab261nN4HbrWaFmY3ICZt5KOgfpuMWQxjGt2LsM=;
        b=dVaS65Mb5T8a6UeLW4qrvBz42t7Hf+0VuOHwTm/4ETKQxWp0BjYCfqrNr/Xn/tz3bv
         FxdzbOTLkpZAeIG4ls+2lXkJNigL24Dgm3MOk1Mr9QazJn1zB2gDUca1LJxVfbNMX7IV
         bdZt5FXj3ZwT4/fpQkf+cJF761HXlMZnVnC+x1oyQ99qva7QddahvqAcOu/1S2HXAELo
         v4AlBur8uljBvvZa4Rg/to8VC7qr2bSkX47zzhx7XDbxnchIUvTzctNylYKTvAHrm/lw
         ZPylIgga8dTdagE6uMNhLwRggpHA6eIWyJBu6Nztgds0X5uyNJI/lhQOQTSeROWegnSV
         sRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322534; x=1761927334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Y5vab261nN4HbrWaFmY3ICZt5KOgfpuMWQxjGt2LsM=;
        b=osxoagTu/qGegbxHYulIid8uwdfnMk5vPEGNH6WmXCk1svX9oVsmRmE4earGlcTpPC
         clUApLpUNn5EgBcujG7SfPbUMIPnVQNxYzyqBfOUWqM4p7b1mSGy0QXpCZYp8iKUaD8q
         1wWM7vWU6IBtgg3D2z1Hvj9NJRWrPSCeP8ESaSjjaQTG4yWPryB9M92u+hresuX0zjnf
         wn/Va9UhA/IASQ87rlhGeew5ENY+FSxHViK78yEux9Y3HSXyWl0MbslOkHfidhBRUG0R
         z7hdrAOg39AWPjS+hoCohinfoqYUghDi93gDqYxGqYxv8+2q6Asi9Ed6/bzAnNY/BA5R
         /IfA==
X-Forwarded-Encrypted: i=1; AJvYcCX2C3QLNdehU6UBc6NPATjMbs5aMdb3hGETrQIFzzCxnUr268YAMnH0TqqrWTt7ONya3BYIAG3p9LFSxEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3bVVUjMLDaa9Dkv1dO/dOXg8K38Prwa4kz9XUvGWWRscvagd
	qEvUutQRZO/gh1iqsps7GOe4VQ5FCfzWd04bll8Bp58hK/jVFIpEQHOCipvlPzTyi+nYFT/LbnP
	Jx19MzpItoGFwrA==
X-Google-Smtp-Source: AGHT+IEGSl74qxdR8AJDyMMaFPTRzN3pyDFKX2IEQz9TP5zYcRH0ihmtpuDkVAxY29RoIOZskGtEgm9HK4tUEQ==
X-Received: from pjboi15.prod.google.com ([2002:a17:90b:3a0f:b0:32f:46d:993b])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b49:b0:336:b563:993a with SMTP id 98e67ed59e1d1-33fd66b423bmr3722735a91.23.1761322533734;
 Fri, 24 Oct 2025 09:15:33 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:15:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024161525.1732874-1-cmllamas@google.com>
Subject: [PATCH] binder: mark binder_alloc_exhaustive_test as slow
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Kees Cook <kees@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The binder_alloc_exhaustive_test kunit test takes over 30s to complete
and the kunit framework reports:

  # binder_alloc_exhaustive_test: Test should be marked slow (runtime: 33.842881934s)

Mark the test as suggested to silence the warning.

Cc: Tiffany Yang <ynaffit@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/tests/binder_alloc_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
index 9b884d977f76..7f9cc003bbe3 100644
--- a/drivers/android/tests/binder_alloc_kunit.c
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -554,7 +554,7 @@ static void binder_alloc_test_exit(struct kunit *test)
 static struct kunit_case binder_alloc_test_cases[] = {
 	KUNIT_CASE(binder_alloc_test_init_freelist),
 	KUNIT_CASE(binder_alloc_test_mmap),
-	KUNIT_CASE(binder_alloc_exhaustive_test),
+	KUNIT_CASE_SLOW(binder_alloc_exhaustive_test),
 	{}
 };
 
-- 
2.51.1.821.gb6fe4d2222-goog


