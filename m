Return-Path: <linux-kernel+bounces-874517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D611C167A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF71650128F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D214343D7B;
	Tue, 28 Oct 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVqNRb2t"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFC340DBE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676110; cv=none; b=WdirnkjyayJ+zrcLc3pmUl3EaGOEK5l2Fbi4+6slN2TdKUjDFEbVokxXkTCjixbSqdQRxxYtdXK7Wr+5WEjbfqF3sywOrs/YiYgIpu/9GdkwvpWzSxs44xJDBQL+WZDFM3nN4FSM8iBllVg5gYxBsWDL07ZLC5WR8Gu834tv6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676110; c=relaxed/simple;
	bh=fX7XbLSp971rMTg0UpwRdyUHxI4708ybuHhCpWAllo8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bFBhsUrl0y55VYYU3fEdAhPAUi8ouTUiJ8Nxp1EKLibz9xwldm/VGQG+k/kSDJVQP8jo4TidguA5rqAcxKWDEuRxveVIpH5wPahct+LK2vjMRPQ4xRhRfumF9ZhzlqmiVyMlDoxHIEuOOl71GlaHAj4KIJEoFa0Sb7REiT8sOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVqNRb2t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-785c67bec06so69814197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761676108; x=1762280908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/B5eNcHD/N3E3+kFhoRC2kLmuGEBa6rnxq3ZrWjw6Q=;
        b=QVqNRb2tffJLZ+8SRCvfiosa5+FYEvqOtdhvAuwhMFCJUlAwRbuvce3nxWfSMyyMqA
         fvoMtY/U4/VqtlilhD5F0++IWbxXddnrQIa2n3M9xI31fHtZ81iH9sq9OUDwkDz+4m9a
         mVHveltL8nbGnn4pj8BIt0O8/wCbkl0bhc7uo6RLuEvq796kfPmzbYTEfcAGRCnUS+2Y
         VDEvFmKFoS9rcEbQLGVABsj4JL/ZV2RQ14We7YjQcb67KOFq4macUpvohNcZbT54m5DC
         3+h65ACSNoRH5YfYRJiusrQgr3Gn1W3hH1W/Oxyy0ObjcaTa359IA66APB5H/7/IilE8
         rULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676108; x=1762280908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/B5eNcHD/N3E3+kFhoRC2kLmuGEBa6rnxq3ZrWjw6Q=;
        b=WsmvI5BYGllSPKMINl2QR0/jD32vLuWcWQyYamj5vhM5JGoKVukaCTT5Vo9wRBJWx0
         EKx0FXFHtYP2q5mVBhxvtEk7Cpc+MWHhMQOZsTuoD04DyzVJzVztHbGMC8GdF5EfIx0C
         yM+KPUhCfhqvkk9kPLUftv1TeF0Mw4gu722DvuagnofOe3IMZ9eFhk0Yj1+tH4H6/Ny7
         dRKsbDUQhPCTAENpU3d/Vw4sFkOfc+/xsEJjwoiUYbG4xW5gkGtE5p5bOuiVVQ+653w6
         XG9TerbeglY1JI6zGSe9wE0sldk/9eqZn4EFEwAHDwBQbbLQGWJ9uzEXK/UwpIKFPy08
         GYHw==
X-Gm-Message-State: AOJu0Yw5JCHm5DoJ8/1e4X42QEj7BO6y+lzq7cpADsrKc/L63iQweR2H
	wSIViwsWyuyAyT9s0QgBOZiDZitF1sUSa+QmBbEnMLxEGc/Qj4VdrNnD/qfXu1So1ZNzjg==
X-Google-Smtp-Source: AGHT+IHKgweEeaLJqEq+LQTEeKUy21GxhN+HXb+lwE/+WPniFQggWEwGckSmcOi3srPPaBPmXdnrZsY=
X-Received: from ybsa8.prod.google.com ([2002:a5b:ec8:0:b0:eb6:c177:51d8])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:9985:b0:784:a119:e71b
 with SMTP id 00721157ae682-78628f87d9cmr2297817b3.42.1761676107702; Tue, 28
 Oct 2025 11:28:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:28:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028182822.3210436-1-xur@google.com>
Subject: [PATCH v5 0/2] kbuild: distributed build support for Clang ThinLTO
From: xur@google.com
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Rafael Aquini <aquini@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stafford Horne <shorne@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Piotr Gorski <piotrgorski@cachyos.org>, Rong Xu <xur@google.com>, 
	Teresa Johnson <tejohnson@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Rong Xu <xur@google.com>

ChangeLog:

V5: Handle single quote escaping in echo _c_flags to fix
    Piotr Gorski's reported error.

V4: This is based on the reimplementation provided by Masahiro Yamada
on May 26. The difference is that this version now saves the compiler
flags (_c_flags) from the Front-End (FE) compilation and re-uses them
for the subsequent Back-End (BE) compilation.
 
Rong Xu (2):
  kbuild: move vmlinux.a build rule to scripts/Makefile.vmlinux_a
  kbuild: distributed build support for Clang ThinLTO

 .gitignore                 |  2 +
 Makefile                   | 25 +++++-------
 arch/Kconfig               | 19 +++++++++
 scripts/Makefile.lib       |  7 ++++
 scripts/Makefile.thinlto   | 40 ++++++++++++++++++
 scripts/Makefile.vmlinux_a | 83 ++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c      | 15 +++++--
 7 files changed, 174 insertions(+), 17 deletions(-)
 create mode 100644 scripts/Makefile.thinlto
 create mode 100644 scripts/Makefile.vmlinux_a


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.51.1.851.g4ebd6896fd-goog


