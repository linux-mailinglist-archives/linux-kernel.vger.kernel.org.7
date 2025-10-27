Return-Path: <linux-kernel+bounces-872629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C01C119DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10C9F4EB148
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A7324B30;
	Mon, 27 Oct 2025 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qae6kQ5X"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAD2F99BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602961; cv=none; b=CU8F7iBVpZ4SmTgSlwHFf7SVjs6MvIQkyUZCPU1ApJ2WVDOQ4anKIJCqNk7fg5T35xd6ziqFLleZCS2PXegQRpTBMZInhRxo5QxbfqxfNKwoNTQDCTAQqBzckzzHUX5OWXTc6gQkCqOso+Ieu93YHoTY+928jGfI5aByantpjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602961; c=relaxed/simple;
	bh=yXfJZ9u3Fbjfd2gJx08sRzobL8zpTJ5hQcZOUZCTRdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PAZgbgxHWtkJ3z9Spw2BhZOin9WbaPxPFMO8Zo9LAfvHMU3xUJEntT6olBnoOnZtvd78rOkkLyWLEWERIXOJ20PwZxQmCsmVPiPfiDFa9eLaJ78fqPhRMCc6BZGy7ioOIiFQhzV7P+KQZkfavd4fQvezH/yp8n9/IewuqzBuZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qae6kQ5X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34029b3dbfeso154660a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761602959; x=1762207759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dSGfQMNjri/IzdLNzyd+71NlCYDzISAHz9ggAxICGTk=;
        b=Qae6kQ5XvSUFsXrXJlpvJ7L/xGUDSCqpqCfTK79SSLUYie0oYiOMfaHOnvaCVIKq8K
         U4qCj+3+C9zZxX6xvqwgVv1lE3yJsghz68vGKOlPHMGr4V6UAaftb7XktT/EW0chv3eh
         BmgQi0HZXAUBq30x2fGx4peV7We/EbSMlGXEOHdGvhLz3SDjatmfzkIpkgRXQscuqIs1
         bf0+oePL6A4/T9r/yiXNBHx3ED3WB01Xf8FXn6fnLzPRgGzOYV7zBgZBimJUtvtN3eZD
         +Xqoia6UtIUK+IK/fjVNsAP9f3otHZqgdu9ChlmThknhQ/IhjmVer8JvZxQrAe1NA4yG
         TNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602959; x=1762207759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSGfQMNjri/IzdLNzyd+71NlCYDzISAHz9ggAxICGTk=;
        b=LIOclFM+X93+1Xt7F32jqehTabbgZumBfL97yOB5jHjDOpSoVPr9N/8xxnzYqcHw6J
         S3RVfZDw/IN5lu1pAZ4JsCBaZiKws79DV8KGwNO0aRT470DnZaeiB9jOL/5U7Uu5Gfd1
         f3B1qQq67E4QDXoiGYmJ2IAwo7qNvQV61PAocg+M/RrvidwX7CLcZogiR6W3T3NK0nbe
         nIOHu5NGkZtJKyUut6WpA+eOrz5UZ7d4+ABp7zq0lKpthgrLeXKeJTDh4d254sXnMnpy
         4XlojIoFAwYAwMz54dzWldzNgTXM4VAQ6rZA0HoRj0kYd9vc+V6VlNXxHA6VaKHEMIId
         zvDw==
X-Gm-Message-State: AOJu0YyzYzH5Ion+wPWmrZamWjq66G4FMVqgSq7Mz89hbRYffJLYBQEp
	rIKBQq52UKp6nae5zkqKiSVsbOrt4tjnBRPl1Ypj5oqHn5vDStixxrulcfaE44fE7Hp4eA==
X-Google-Smtp-Source: AGHT+IGS7xK7WB6H01wrhC/DTJJJdKCdhMHqBiqf2jyYVcEgqsh6sEw0yU2tcp1RCB979UO3Psy6Cak=
X-Received: from pjboi5.prod.google.com ([2002:a17:90b:3a05:b0:32b:65c6:661a])
 (user=xur job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280c:b0:32b:bac7:5a41
 with SMTP id 98e67ed59e1d1-34027c1c55cmr1350654a91.37.1761602959448; Mon, 27
 Oct 2025 15:09:19 -0700 (PDT)
Date: Mon, 27 Oct 2025 22:09:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251027220914.2665978-1-xur@google.com>
Subject: [PATCH v4 0/2] kbuild: distributed build support for Clang ThinLTO
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

This V4 is based on the reimplementation provided by Masahiro Yamada
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
2.51.1.838.g19442a804e-goog


