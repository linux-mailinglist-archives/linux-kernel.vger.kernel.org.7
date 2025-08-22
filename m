Return-Path: <linux-kernel+bounces-781920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7172B318B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E71C82326
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254793019B9;
	Fri, 22 Aug 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="ZzQQgW7o"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB22FD7AA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867396; cv=none; b=ethnxUt1a6RVK+U8a9hA/DlSIWyGSaL4kmAWD2fcR4p+C8AuMSK2MJ6zOwkwSbsYAdszYhfPBImmIK4qLUEYWqtM5ECLbzYzk/cBxHfGTjxJ3GDJbL0UmSectzLqjWnV2sjlyp3AQP3EeGLwA56+cy1sGSArQZ37waZgXKICN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867396; c=relaxed/simple;
	bh=1nMyaUUKEGhRekyXqu7nR9wX+y2S3pEaBQ1AynCB5Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNlAUGxLGnvK7nfi8K5+xkqB08EL7akZQdjcoiAg3zt2W76vZnvqpjINku+G98IPQ+Ry2W8M9u87LqjG7W/duRjMsSdxxsbV5pEXCxv+MwgC3FF2/KlpVvorvzFlnOiIr1j/Si3hOsqvaFDeFCEdpksdUS+t0CMmpMDDoSgPyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=ZzQQgW7o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77031d4638bso532192b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867394; x=1756472194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ulg0un0kO+mVAmR2axpKOfpFutSEzipFHqPMKIsEvs=;
        b=ZzQQgW7oQPnYixcBvC2h4bSfNcIR6EmiPzhx2M/88XBXHwz1nLDIPwkzO1fIkGEJRM
         hUk0+E49Ar3BdBbWfxZmANP7xzqjvYWT5b10Jd9aIwknhC7bEgZ8Ap1lT9wZ1tzZTudk
         eaLYji/nzEcXMqRqyJ3MmtNbPkfxWg4q1509g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867394; x=1756472194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ulg0un0kO+mVAmR2axpKOfpFutSEzipFHqPMKIsEvs=;
        b=qwRKhZ6rK3ZeMoQF2bfSHA6Gz4yqn5+B5m5XgMCRbojMLxnoRICD4ozV5eh5HoAluh
         ouk3QIu0d2hrDsuzxzk53W98CE3j5tfuPCsRXGz1MfQYokce7NgY1AZr5YUhY/obC8CN
         9vLdH49tSjMpcVfAP/YX5P9t/wnX7VcMnNz4QKAMJmW9v9a48nUtpRSye7N/J83lUlCX
         0WWPGjZa6W6b209GLj2uyYN5lWzqDfwFEoZkBdNzB6miPsEP01/DA4ZOdcYFgtcYbjMN
         PWWUfgdV1sIvFUQF28/ZphUwvMtnmEnF7mdormocPINs5XgfEa5FwrAbfrUgpjmrWzbN
         SO2g==
X-Forwarded-Encrypted: i=1; AJvYcCXseStqpH8Je8i7o7uFHT1FP9jMdLKyLdwtzXqKHW4bUZX5fSBc2XZeGLjY0gin6MxUwTtU8WfYjaF7xQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPWGQJeS9oxhK43o1ElCFx+L1QadGIUkS6zq+7034RKA1JH31
	/OxbEbhKSAErkHux+WdPuLBfLACivlIUVMMPQS5b8aKR88d/aKVQ5bXoW3D+kUxdKBA=
X-Gm-Gg: ASbGnctx46VTi1lsG5dBu9Kq6J7iN9gVyTu2eHPJa8amFX80RZtYfeB48r5goPtHFc4
	0MIKNrnAiOeSlDHdlxTewJQjPD9hhNKMBBcKZovwrFLsFEXUAuuyud4Ae8knSPr1OW7XNx8F5vv
	AXpyrV6XUxzFgFwZ1PdcmZ2hUpF+fE1KEA6G8k1NUcyWW84BF7juM2CdjI+RvkVEp7+iXaCQvyT
	eKARp0z5D6ShPJcGmRiknOJQ0X7AWN3bNRe01wyxb4BB1j9/SHb49JqBaIWfit5iICoE8cXKIgc
	/5HQ5nECfByBCuVl9FmEKKx35iu+z3/hOsgEDMyu5RdUvkQOjWhrAakmKRatUgI4iRkgacWIVad
	Tpw47xQEnAdhbXM0v9iEAgalaEXhisbRCHLvvr624BrPaepd3dGnvoAgexQ1UiqZUCzVhrWeI
X-Google-Smtp-Source: AGHT+IEp+IhiJ5Y2qqThOY6Kgaz/N52FJgbWJaI5kfueM3u9gCmUlUWDGA1cE7aiJXWfaowDUnBfRg==
X-Received: by 2002:a05:6a21:33a2:b0:23f:3f96:ea1d with SMTP id adf61e73a8af0-24340d77b55mr4754737637.29.1755867394083;
        Fri, 22 Aug 2025 05:56:34 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:33 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 0/5] rust: miscdevice: abstraction for uring_cmd
Date: Fri, 22 Aug 2025 12:55:50 +0000
Message-ID: <20250822125555.8620-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the groundwork for using io-uring cmd
interface in rust miscdevice.

 1. Io-uring headers for bindings
    We needs additional headers for implementing rust abstraction.

 2. zero-init pdu in io_uring_cmd
    We need to initialize pdu for avoiding UB when reading pdu in rust.

 3. Core abstractions
    Provides 2 core struct for abstraction. One is for io_uring_cmd and
    another is for io_uring_sqe.

 4. Method for MiscDevice
    MiscDevice has some method for `file_operations`. This patch adds a
    method `uring_cmd` which could be used in miscdevice driver.

 5. uring_cmd interface for MiscDevice sample
    Added sample code for using new interface for `MiscDevice::uring_cmd()`

Together, these 5 patches.

 - io-uring headers for bindings
 - zero-init pdu in io_uring_cmd
 - abstraction types for io-uring interface
 - add uring_cmd method for miscdevice
 - sample that implements uring_cmd method

Changelog:
v2:
* use pinned &mut for IoUringCmd
* add missing safety comments
* use write_volatile for read uring_cmd in sample

v3:
* fixes various comments including safety related ones.
* zero-init pdu in io_uring_cmd
* use `read_pdu`/`write_pdu` with `AsBytes`/`FromBytes` for pdu
* `IoUringSqe::cmd_data` checkes opcode and returns `FromBytes`
* use `_IOR`/`_IOW` macros for cmd_op in sample

Sidong Yang (5):
  rust: bindings: add io_uring headers in bindings_helper.h
  io_uring/cmd: zero-init pdu in io_uring_cmd_prep() to avoid UB
  rust: io_uring: introduce rust abstraction for io-uring cmd
  rust: miscdevice: Add `uring_cmd` support
  samples: rust: Add `uring_cmd` example to `rust_misc_device`

 io_uring/uring_cmd.c             |   1 +
 rust/bindings/bindings_helper.h  |   2 +
 rust/kernel/io_uring.rs          | 306 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  53 +++++-
 samples/rust/rust_misc_device.rs |  27 +++
 6 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/io_uring.rs

-- 
2.43.0


