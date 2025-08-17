Return-Path: <linux-kernel+bounces-772342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0700B29192
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE57A3E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9491FF5E3;
	Sun, 17 Aug 2025 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsUcBARA"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D982EAE3;
	Sun, 17 Aug 2025 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755406111; cv=none; b=PHZFpXz2DXRSmknv61t1DWPWeloafSMqGsgdSijpyQJFhoCCRYS1FhZFdqdtOYcSrEvim5G5d56sQjuCNDFvjjdUN3n5Lrq5R5CxN789jZEfZviYIZYv7LDaDexBn9c+qvIdh67ZB+iyir0mIqyHegFjpRJily68xVATeCZiESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755406111; c=relaxed/simple;
	bh=OQwbMoUJk9B3pAYI5oFFoHQAGaCqbjTOe0d5lzmvfhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2hBo5k49IXFWqfBUb/Ey/sxF4U3vyaaLZ7GdWc08usXzBMrRgW+2RaPvX5Bhe2Fdm6TfZZreGc39A4usUqYHTw5uXLoc/09UEqLoMSCLfrLxC/ZBEGGBnJ3gdoTOGc6+tnjoxweoFNcYQuLWsKSFTMfZjuhUPl7pF+ABLE08H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsUcBARA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4717330f9eso2210570a12.1;
        Sat, 16 Aug 2025 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755406109; x=1756010909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XgE34YgoS9IdCfo8BGLVKCTH/aDS4ciuQURnuclWlL8=;
        b=ZsUcBARABdqsDnomMwg7KSq45Xv4eSXYPZgylyliivcu5DyoJsQnJ/oVICvcROou0Q
         XEed8qTmIEBvjhAE5qk/gPNo7JYdEGo0ltaLMzbJ6XIDh/r8tTRsIL8VaGDyIxzrYWCQ
         e/alT9NLblui0UYrCJ3yILitvvZAAbYwGH5c7DZmWTGDPIC459TwL+Lmr8qLrVKO1rQA
         348pT+5BE/zjmcNL94zsmxH8s2aqO3OPYkZSyn8ECKaRmT4eFZEUHEuTkkoRraw01JYi
         gbvek0arZ6alEvhg/D9dlzCdxfsT/83IOhray9vN1XemP2zNCrlIaR9nBRMNigHbo3ES
         gyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755406109; x=1756010909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgE34YgoS9IdCfo8BGLVKCTH/aDS4ciuQURnuclWlL8=;
        b=HQs71QlQICPN6aUWVies43w+/BISrr+4OVEpG13U4GFbeRm74RuD0dBg2Qaa569lQ8
         VTQsN02Xiils4vXik3Reks6kntVDaFkEIeM+sjfW8hftoxC9mO5GobEB9wlSAt8BX3Qh
         nVpzFjUB6gAZcnCvc0HZoCeeG1Gqoq2aFN1CcigJhvbnZExVn1pG8+b62EhPYKOd1Gf/
         UwZDEEuYZXBIjjpGgY6K0xrSxNFKhkx7zNha1+SEEVtJ82PDGYSCSFhPLUWOPXyRdVgl
         +SnIgoh7jP6ofgoDNIcugSx7JfhYgAp4JRH3/TRo5iiA6+RyfIJvLt+69EMwQVahbHs8
         LYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt+M4NRRNxMdigC/dpN1jjUkD3ny4G5cdABJVaqzioETmFNX6lzXFf3lFYLk0dhJd0BsdL2bSF1SgKW2MNkLQ=@vger.kernel.org, AJvYcCXbE+7OQ5I2MHh4JfJ+rrBLbqBIMZhHlY3PcHbNtm4SED+GBIxvLynhQW/0wznWxQPJFFqOmMXDXgQEm0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwm1fcopzdE0j4SZB7g6CBjR6ui2e2hTOgAAV7NerDebm9acXI
	sYWAEHd2UlKc/+vn64r7XNnwm8XehxQPd4QbkvAmP5FB/VLZPiHvk6oG
X-Gm-Gg: ASbGnctSOZ19wDTWhuXyhQYjaWvpea86JGmIfW2JL76BY2B2H7MGLigHzCUxkrJVqFA
	Rx9PDh+xRjfTeJnsiivHmIxtJREFbprlRNhYKxBiXo7/1JjkEas2wFRif3k3GBHMhSBPkwFVB4J
	ddcby03+2oA1Yi0WIbjUzClhZJIJiSSGxn6Nig0dJ0NiQEwB+tOPFFdCak0qkHFn7HZ5CPhfprK
	JeEDgR8rcj3b8yCHtxOgkR2b+yxwETHUVxLub2sAQgjZNFB/mstro0pIvDKokt4eLYAmWKSr+MQ
	YYFnjjzzRhCkmLT7/Jlgc/nGRmRdFyA52Bvp73RER04Fvp7rKGORiM/MGlAD/cgPNXXpQp9oc5y
	1c+VB3sovjfLTF7W6cWq31rNAWDJDmAW5NMQtKvV4s0T8f2Jqw0y2I7Avo/lss/Ga3dNcVF0=
X-Google-Smtp-Source: AGHT+IG0WhsN3fcoBZeKGuWcX20d2nwVP8ml5xEvRJ3Cki/VWV600XuOLv7cSXLSklNRAd38yR3DAw==
X-Received: by 2002:a17:903:41c3:b0:234:986c:66bf with SMTP id d9443c01a7336-2446d6e45aamr110310115ad.11.1755406108108;
        Sat, 16 Aug 2025 21:48:28 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3234368aeadsm4740645a91.0.2025.08.16.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 21:48:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Subject: [PATCH v2 0/2] rust: Add read_poll_timeout
Date: Sun, 17 Aug 2025 13:47:21 +0900
Message-ID: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to poll periodically until a condition is met or
a timeout is reached.

This patch was previously reviewed as part of another patchset [1] but
was removed to expedite merging into the mainline. Now that all the
features it depends on have been merged into the mainline, it is being
reposted as a new independent patchset.

I put this function kernel/io/poll.rs. This function is not
necessarily related to I/O though. I don't think this function
perfectly matches the existing abstraction. Suggestions for a more
appropriate place are welcome.

After we agree on this patchset, I'll work on
read_poll_timeout_atomic().

v2
- make cpu_relax() inline
- remove the example code to call might_sleep with a lock hold
- move kernel/time/poll.rs to kernel/io/poll.rs
- remove the Option for timeout argument
- avoid the extra variable, sleep.
- update the comment and commit message
- writing closures directly inline in the example code
v1: https://lore.kernel.org/lkml/20250811041039.3231548-1-fujita.tomonori@gmail.com/
The changes since the last posting [2] are
- removed might_sleep() change since it was already merged separately.
- split out cpu_relax() in a separate patch
- make the example code compilable
- update the code to use Clocksource (MONOTONIC)
- call might_sleep() always (even when the function doesn't sleep)
- cosmetic changes to the doc

[1] https://lore.kernel.org/lkml/20250207132623.168854-1-fujita.tomonori@gmail.com/
[2] https://lore.kernel.org/lkml/20250220070611.214262-8-fujita.tomonori@gmail.com/

FUJITA Tomonori (2):
  rust: Add cpu_relax() helper
  rust: Add read_poll_timeout functions

 rust/helpers/helpers.c   |  1 +
 rust/helpers/processor.c |  8 ++++
 rust/kernel/io.rs        |  1 +
 rust/kernel/io/poll.rs   | 96 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  1 +
 rust/kernel/processor.rs | 14 ++++++
 6 files changed, 121 insertions(+)
 create mode 100644 rust/helpers/processor.c
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/processor.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


