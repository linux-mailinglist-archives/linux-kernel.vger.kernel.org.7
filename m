Return-Path: <linux-kernel+bounces-734459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595DB08219
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5739C1648C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69381A4E70;
	Thu, 17 Jul 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOjBXfpY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA81CAA6D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714622; cv=none; b=cVixnaZzXMp9BhBmiDNei/6o6gkRmtqNUq4ku/MK8V6cI5nelUb7nYO6CtkarA9DkmKwkQ2gZ0TORjoQX6fAlHqrP/JYZ9fiGGvvSGBX9v+gWq/eSkh9RvxOhq601+yys2r+U5ETuTGLWI8kfPBMewEM9EkiKegm0Ytkk3dvvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714622; c=relaxed/simple;
	bh=tIPGEFHSsr2ODa6GIudg/oc/a5xUiSZoosuxsXWDsBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rQVbBSVciBKp5qtqg0LeewMAadu22lh7ePT54zYIDrjmliuahaXVkTbt7Wegmy2PBmmPNC3amflkwIR3dvKoEXgE6mujlurDsX8olRTN5JCZraOhPETxbKpDi1WLpar0XBj40kaXSROMO4uHtAXz054qWN2/Zuu7wiDhnGAcgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOjBXfpY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f30d56d1so186183b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714620; x=1753319420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXYnyktGm60WOJnLhvXwFUhbTbABdh/mFZxi2QEZBo0=;
        b=GOjBXfpY2LfKhJX/pM1gYU0H/qe8qEkKiBQKKxR+8FGmwgr0Lj+9Gt9sQ0tUG3EI3N
         Z+9KOLYNkcf2ztxe3TikO56EcRKLsHe+SJx+nZ9Zqex/GjwFrq/btVP6y18gH0Z7EW8x
         wZKeWAsalpXEg8GKyvvWSf8/RAL7fgBGCIm8a64dqqqwocYbgY+YyZpE9D6bHEq2OG7l
         uMKkX8pi8qpw/ga3i5J8/ZRMxvFXH+cK6/mZzCRVsR+a3X9eTmZAE9fQ59Blq9auMF6k
         HJFzuxbvVftlgXIPJw3az9r4Q24BItXZuOS+QbmlUohHmK6QG3j5SIZlNAL6bqstO81v
         bY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714620; x=1753319420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXYnyktGm60WOJnLhvXwFUhbTbABdh/mFZxi2QEZBo0=;
        b=RSAaFIKR6G4EQQMgBM9uwQMj2JVcSESHYo3uOTtpKEzN7O0Duo8VS8XNQz/P4kWgVy
         fL5KXddvZhufiriDYpBdxFR6hRW82hEUOIhFW/IMsNUth+udKRmZwvuAaNJFC3HTZb3W
         bVIwn22dTuMngcVRfhQa1Fiyd34vKk6GObNVwa1bx1vNzcRNwv1wVyEJ/ui3x5wU0bgE
         2PFhoI43fpijGUTAZWK3SIgUqhDPW3Su4OKC+57zo4cehFw9ayDLjZtf341lOp6/I2mN
         kZjBHsL9UyJm9ISASmjqOtl7PL7bKqEJS5fY85BGfDmH18o5xMteXdG10We8evzzeLgk
         qK/g==
X-Gm-Message-State: AOJu0YwMuNe91gbReWmEqKzAimsU0aCm4xrYyIwQFjVhkzZiiaaZX1QS
	Vz4X/fy4BpHVBzRjlCX6fTDrHHk4bd76GEcdxeOy4C4SL1o87+OTgZgFkEuLOQTKIrxGDXfbGQ4
	noTHZJpNxSo9hVatFGFqR/UAD6iYiJsWc4H8OQYqngFuYAe3EVHZUhS9WhmIMJFNj2Fz3sSk+z+
	KyHh69xIX8renkHTHMc84cpj90K7ks7bJ+ZtSRK6+HfuX04avyOA==
X-Google-Smtp-Source: AGHT+IGZCQV61cHQmaZLL5LWYSAB2/YmRqw6hOQy3r+6HYDMD4gqbEEsPZwQADhr5AYbRuuxb06gW7BaO0uw
X-Received: from pfbki26.prod.google.com ([2002:a05:6a00:949a:b0:748:f3b0:4db2])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1410:b0:748:f41d:69d2
 with SMTP id d2e1a72fcca58-756e7acfa48mr7805647b3a.4.1752714619969; Wed, 16
 Jul 2025 18:10:19 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:04 -0700
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717011011.3365074-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-2-ynaffit@google.com>
Subject: [PATCH v4 1/6] binder: Fix selftest page indexing
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

The binder allocator selftest was only checking the last page of buffers
that ended on a page boundary. Correct the page indexing to account for
buffers that are not page-aligned.

Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v4:
* Fixed unaligned comment
* Collected tags
---
 drivers/android/binder_alloc_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index c88735c54848..de5bd848d042 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -142,7 +142,7 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 	for (i = 0; i < BUFFER_NUM; i++)
 		binder_alloc_free_buf(alloc, buffers[seq[i]]);
 
-	for (i = 0; i < end / PAGE_SIZE; i++) {
+	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		/**
 		 * Error message on a free page can be false positive
 		 * if binder shrinker ran during binder_alloc_free_buf
-- 
2.50.0.727.gbf7dc18ff4-goog


