Return-Path: <linux-kernel+bounces-737777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFEEB0B078
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169771895796
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AB2877D9;
	Sat, 19 Jul 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="k1GEk6Qs"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139111E0E1F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935650; cv=none; b=aShfq5CpR7xb606nUq7AQjyz1EyFE7aOdZQTEp+v71tMMvU3QThh6hPx/lOBCgEH0rUM117W9kwDAQxajNEVV1RGEtKJlW0wHTip5vNHavmE3gd02WpESZcu2sms/brVNnjfkhD4zWRZ3gyacv2QaLwhI/hUp24DLl4rX3vQfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935650; c=relaxed/simple;
	bh=cIlsCjU60tcTX9pCHNYoUdcY4K8aiFQvCiC3AoK61jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIbPbpwjcrGc/ppj4zncmmWE3a/ubYmfELjy8GVIKrj7uWTlOvxcaeJAX8CIHZiXWfafFr5RAPnOJNj1g5Fktnf3/w9iansKtEflM21sDRJGw5VSWNe9v4wvwR2w5WWGAuAwduHO2PRTxfqefptGFIbFWfA0b81+Feo2jms5vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=k1GEk6Qs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167afeso30139785ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1752935648; x=1753540448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgLQWEfUsgUd4bc4XTm4Fj5yFjdCjIN4tWY9zvoyEr0=;
        b=k1GEk6QsJy7Gr8V2GkgXwYyY6fMmoLO+SL4J7RMq41hSdzOp9o7tyyzHeBiKm6ic6F
         ByVh2CPivEttJ2usjF56ufvZlU9JjpGinv6GUPvnjB8xcKYf8isEJ9ICp5tVoLek3arL
         pxAsLWu2HYjm2eyXB4rKpOIJHBq4/V0anUMtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935648; x=1753540448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgLQWEfUsgUd4bc4XTm4Fj5yFjdCjIN4tWY9zvoyEr0=;
        b=NnFOGjIpY0C7wKLh/skbLDSsunDvboThVz5cLY7/w/yS3vj0rZI/4Xg2G5WxUpxiHl
         PjYMibrySlk4kDl4LFG9dge+9rwdBiFJZ5YF6V2J8Gk4ICN22vxlr/25J+ILQce9KWfd
         DXaX3rW6rB5t5IHd22zQiVZe5klvZZGVYfSs9cj+UW0uwdmLzG2qAVcBeZBGrjdGvcXf
         fbwHYnsiHGRhIPElz6f8AcQD4PWMdi9XMr3Necy7OVIjwpus+wtb+U36uApb28GOalmJ
         EtI2TE/DQX1Uzozfe4a99WW8a7x7GSI1etRTwPYjwvbBZxpm0PxpONE/WJ0xJ6duXBUL
         CSLA==
X-Forwarded-Encrypted: i=1; AJvYcCV520O9r3IL8mA3xjpUhSHZOovOUzGDzrRswdXFZYHzk31wlwXxrHgHOrF2SypI9xw1RRqmAhiTxmywTvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0eXQk/YWlff0BBSdx/sQ4rwsp5tS4ISqN38JmWUD/bf0/pdo
	ySNq1ymBauTFn0swoD0B/2klD6yMKvbTqJ14L8sERl3jd4VFdzE4tquoza6n0j3/fAg=
X-Gm-Gg: ASbGncumZvMTXdyQV4J/0f/4aQMROdD+XtTIQ8rMrI1divtfgrxzSQMcXtSxtifEWrP
	u8mWo4JGexwW4WD5TZMjPDvzcyOWhkK2nD1Z1wPAH4yclCDAqt/xzI+AKuxE9+fnWl04g0nYU2n
	T535QvHtDoVx3EbsQ8B1GjHjmHgY+A6+ZYW3UV9qVcnqScFzahN1k2kGZyrlQja8P5wZ5zZytnT
	vx/2gXvE84ixyDM9bQWBlm3xaPQGZoljPymVrhPBQtn9yKnlmrwY9s5l3zqQDyJmYVawjjkk5lX
	wEy5+38AMeH3Cb9NxlhzpM6KuOU02Pl7XMCT/gQo448ldIY+DbWdIkg34WnBdEG0rJF0or+MkUP
	KeWZ3rbFmwB4xdnaAePh+l23FtSjuKNuokcSZuUsE9nMNH5gOqpiJAcW1WFE=
X-Google-Smtp-Source: AGHT+IHmqgL62d37O3Ajjc0SWP3lfmOKTeqf3aN029Y1WM6pxkfJu+Z5abVV+qUXutkwbgMwULqrSQ==
X-Received: by 2002:a17:902:ce85:b0:23c:8f15:3d46 with SMTP id d9443c01a7336-23e25750d9emr181722575ad.37.1752935648180;
        Sat, 19 Jul 2025 07:34:08 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm30017525ad.23.2025.07.19.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:34:07 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH 0/4] rust: miscdevice: abstraction for uring-cmd
Date: Sat, 19 Jul 2025 14:33:54 +0000
Message-ID: <20250719143358.22363-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implemens an abstraction for io-uring sqe and cmd and
adds uring_cmd callback for miscdevice. Also there is an example that use
uring_cmd in rust-miscdevice sample.

Sidong Yang (4):
  rust: bindings: add io_uring headers in bindings_helper.h
  rust: io_uring: introduce rust abstraction for io-uring cmd
  rust: miscdevice: add uring_cmd() for MiscDevice trait
  samples: rust: rust_misc_device: add uring_cmd example

 rust/bindings/bindings_helper.h  |   2 +
 rust/kernel/io_uring.rs          | 114 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  34 +++++++++
 samples/rust/rust_misc_device.rs |  30 ++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 rust/kernel/io_uring.rs

-- 
2.43.0


