Return-Path: <linux-kernel+bounces-761773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA3B1FE49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D0F3B6B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89D258CDA;
	Mon, 11 Aug 2025 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNdGVFwR"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC231922FB;
	Mon, 11 Aug 2025 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754885510; cv=none; b=Fpss/oDSn1DXmnYul0cbgxPg4jQZzqyCG/oxQzKg6FnwOeAAfwdkr9IIfO31p4CUo6osKGOPjkaF4NGy5tQm0vu9T9APzU2rvq4Dm3R9PgWA25vlmF0hfJaBaNSCrM33WB5rC0h/vLq31YrRlFeIhSx4YOpZQ8apRuGCSX1dmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754885510; c=relaxed/simple;
	bh=ozBmv01TU8VYbUeLHAHmwfW1hl3cYS2YuZwVngtIrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/N8mk9/f/9t4/+dK2E3qhgD6eXCcDmNqULUAdU12DS8Jsg8bQf39/suPsZ48p5d8Tlmgc32XHHoDjhauHCwOb/Y9FpwzYwPm+Qtndz40QYXjIEV+Hqu8WhhzLEqhWNUG7+jqZ/oHBG6oILnDBeegtOGdKKPjz2qyqPxaUUb54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNdGVFwR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34c068faf8so3666564a12.2;
        Sun, 10 Aug 2025 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754885508; x=1755490308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqaPdhaKWAqsoEumDKbxaYVHoP/sbDNuQzVATa9p1XA=;
        b=KNdGVFwRk2jyIZhsDUe1v5ZhKCTNcJe+Od1WGLCkmtdy/CoHn4ZhaKAq5X6F99n61M
         p2oY+5Krx61LWtFiNE/w8tm2eB8oSf3zlTLQoz36NrsKL+q/ogI836bopmbV3+MVRKF9
         6YnigGV97U/ujf+b2kSMBeLxtxjaiDtA9ZkVC6os3wLw4Suu3Ot2AQ0FQ35ONN0HzHA7
         B+XRMcBv8VUUpWI/sselE0GAfIkcKTJRbV6HuAVbAbF3GB2N68CLlHxoak1nCB+crqAq
         Ls9xQOuweox/6tBPLCub4HIPfiigHjWmwM4o3ur+OkE9lv+xRaH27ZHxojcpYLry2fy5
         3qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754885508; x=1755490308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqaPdhaKWAqsoEumDKbxaYVHoP/sbDNuQzVATa9p1XA=;
        b=dgtVsejnxByVsmSAypdY1Prj44kyTFp0Uf8CMALZ3M3mjv3GL6SC7BhM6BW7NbmrLm
         neSQFwghyAhGlZ8/qgbPZps3Tg8Yz4j8C2sw1E7qv2qUb4NyNpXQdCLUwX7MRcfWS1ZZ
         DrWjbn8KOZiRYVLtFdrR+NU2JBVlQfEnRbat1L7KLBf5+X+bR8z4cNZVh6p8LltNSFLC
         HeajGZn8skom/VwjQK960lZwWrRMckbFQ4CkkHASdPvLVoWP+KrgeKW06++Vc6WxP9+f
         CaEH3fMwQPI+sUqOsO/CcTOLy/MJzf3yA0/hQ1Uf+NGO+/eIY3Ja2RESDtMoSLNV5G4O
         ODzw==
X-Forwarded-Encrypted: i=1; AJvYcCVGRdaVrAzdCeEvsOdK38+0UPuIlm7+7Phk9d53jTql1QJ6cYxHV7TEwWxfIuupwc8cWGiwfIJQwZ/YcQEGF/k=@vger.kernel.org, AJvYcCXDK010+ow2QTsp5Ev7+GTDOFpRT3rh5ZbwsaJz69oX1/gR+btrMCG6ZcLlKlURYKABOrb6bKTyHetxoD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0OFcBLubXuJzJChwWPxE/byDrxL6uTQMdmwYK/rCZpK1BGePQ
	ltvBY/zqi52eSJzacIyarvEBThUpJmPRzNXha1RDmJ/qKaGXuUswv0KD
X-Gm-Gg: ASbGncvvtK5rfb2FLnQRpM7z7ohB8PmRSPSOC2P4juB/DrpDF1/8mHrGxpUTqihopsM
	Bb3wLRHTmqhSS3NIj2CW+e4BbCUUkoZAmZ9mIgItPP6F5wXLMPmBx+EojesEsloXMfq7foL0v2b
	nF0qThIFOEsRhrM8RVXhA1mLFwL27TpbvODFckwHCM9BKvD2XHx3hhcwhb8jvDrkidkeuI2/KRy
	mpfau3I2SiEHBUlaDHYlLdxRHG6qfK2xbsd6uPPzlsEY1WUB0wnbBW+CkVw4XUesnujXjWEVhM+
	WTrmRQjG9BCJ+pdmDaFpMWCoN2LzJ78asxWPnY/QEL5uxrhqemABlc7823vwXjLGat3uuGb7dCh
	FZE5zzH+8aMUgvfhqeJdzZ4q7p7Og6XyIhYFoesJRMxTs/sBIim2fnkGSMKEdsbpv6SbNDzo=
X-Google-Smtp-Source: AGHT+IG8A5z6cYfsRMN9AjR5TdBhfGfqEHFOCg2DqU+NsBp5HMTCt7KwRNWHMh9th6a+kw7RceppGw==
X-Received: by 2002:a17:903:3c66:b0:242:1ccf:65df with SMTP id d9443c01a7336-242c200850dmr159327225ad.13.1754885507695;
        Sun, 10 Aug 2025 21:11:47 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aa1asm260029025ad.122.2025.08.10.21.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 21:11:47 -0700 (PDT)
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
Subject: [PATCH v1 0/2] rust: Add read_poll_timeout
Date: Mon, 11 Aug 2025 13:10:36 +0900
Message-ID: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
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

I put this function kernel/time/poll.rs. If we follow the C
implementation, it might go under kernel/iopoll, but since this
function is not necessarily related to I/O, I think it is more
appropriate to maintain it as part of the timekeeping abstraction.

As Andreas pointed out [3], the test to call this function in an
atomic context doesn't work nicely; we can see might_sleep() throws a
warning in an atomic context. If such cases cannot be caught by the
test infra, it would be better to either remove the test or change it
to norun with a TODO, I think. Also, it might be better to move it
next to might_sleep() if we keep it.

After we agree on this patchset, I'll work on
read_poll_timeout_atomic().

v1 (the changes since the last posting [2])
- removed might_sleep() change since it was already merged separately.
- split out cpu_relax() in a separate patch
- make the example code compilable
- update the code to use Clocksource (MONOTONIC)
- call might_sleep() always (even when the function doesn't sleep)
- cosmetic changes to the doc

[1] https://lore.kernel.org/lkml/20250207132623.168854-1-fujita.tomonori@gmail.com/
[2] https://lore.kernel.org/lkml/20250220070611.214262-8-fujita.tomonori@gmail.com/
[3] https://lore.kernel.org/lkml/87y0wx9hpk.fsf@kernel.org/

FUJITA Tomonori (2):
  rust: Add cpu_relax() helper
  rust: Add read_poll_timeout functions

 rust/helpers/helpers.c   |   1 +
 rust/helpers/processor.c |   8 +++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/processor.rs |  13 +++++
 rust/kernel/time.rs      |   1 +
 rust/kernel/time/poll.rs | 104 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+)
 create mode 100644 rust/helpers/processor.c
 create mode 100644 rust/kernel/processor.rs
 create mode 100644 rust/kernel/time/poll.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


