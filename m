Return-Path: <linux-kernel+bounces-895606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA3C4E79C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A51C3A5BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9E2C2357;
	Tue, 11 Nov 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO5eNHGH"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D10A55
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871026; cv=none; b=BaZVjJuY4GrS9zEwhBhQQKCUfDoHr6OgLKxQjbv3p6KBG1zzb2gu1bZz6oRNCY5deBhDS217qACgYk8/9vazi/3FQzRlYaJ9rLFEAOz14ujzzOXwtKrpwaCSrD79S8viGbup5X7XU4eoHR2yKyk+9TSRF5EftdULUzXHLLl6BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871026; c=relaxed/simple;
	bh=oj2s8bO5lxhx+kKxRe74EFxM/F/qWhzbrg0KtIezBuY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RZE0XeZ4o6vFkGGbHIOjAtyvMdlmyqXJ/DFWzYE8xIJTkFVfJFLR3gtnhYZStljoLz18C8xze1/d2I4enNcdUwTUe/7wbtGmn9HDg6sPJf/6Hbr49e9/RjT1aI6Aa2k2hrYZc120kX7+kgYXhdaJV56KjBWK5WfOgIqlfHAJRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO5eNHGH; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so1463191f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762871023; x=1763475823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iTBpJ0w2os/1RvBWHXpd8TL34XRCPeFtbIxSDsdtlBQ=;
        b=KO5eNHGHPChbMoZMluxxxOTIUURGRU5v3cU+HpR0zaTRDcSwedi3JKdeniMG7AvsIz
         mwQI2yP3jdd+9lCh+P1JRSGm24uusOFeNauIm7/oNluqZSdBze6TvbltVlyHyYV8rrfg
         qtDLcUPYFZaP/SPCJabxy+gE4fkfugr3vmjg+Ioo1tEVAQE6r3O2xtnAMh59FeFMKS0I
         5hJeg+Or6IvvFGbgvjwnC2JWpj1A/ALmkfnTQgvrw2+c9/K5dk3fXdl7hflgkOA1lS2N
         I+a33YPW+6uM/WXceZzM1F3GBhErijo4goA9aJjdqndYRlM0lJ7qC/Ba0k21fNvRpJBL
         vAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871023; x=1763475823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTBpJ0w2os/1RvBWHXpd8TL34XRCPeFtbIxSDsdtlBQ=;
        b=eXess9PYwwn+/ZbDWYrnm+nrRPIjGDldTRsg16/mYPu3Va4BIGIThcLWeTuLftkSHW
         M3OXhNgFZZqwEDTPiSrhlzd89DENnb50En90hSdaJa1pXZHL2utbNXQ28kyOiTUQHyUy
         FQYAVyQPBKK0dElVUdVLmhQAvoRfp0pBCsfQ4ejSl7ZMPQCMzw5qFG7kf9wUzU9XDWDc
         hjuvaCSiYgkZVd9a/9IczW+2EahARvrBYArvIeGL8xU6X7Ani72znlqCZ4R/04ebNp+G
         7OaHhN/uFJ01eyjEcdPu4B47q9Lw5XNP7bm71J+uLibKqJJ2p3OJF2R3vsA3xOlnNhuO
         9VUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFfISGZ48bsN5iJVVI8TfGhBivOLxHmc1XEkRoHsIBL1p4AG4RlBRmxfJOYBkbl6O6vTdqJ26u0/iB4jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRmDiTTe72Mx02oFmdiF3IjzCdfyIa8/GFHrKn9lDnWJmwEu7
	YjdRX2oqj8GDs821TFFDsSYaYbUv/tTdF2wJYjPF3KsLvt5sKdvCEV1PF+XT0e5vg3/9GStGVPZ
	8HF83jrz8PZt+D5zNIA==
X-Google-Smtp-Source: AGHT+IFYs3kJb3BKRTegYAhCqWpXq9+rU3WS99Yao39uyZ1Y+HHPv27mS5SqNN8IIJFq2GgDoV2/NTcxXq+gdLU=
X-Received: from wma12.prod.google.com ([2002:a05:600c:890c:b0:477:54f2:85b7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310d:b0:477:55be:f615 with SMTP id 5b1f17b1804b1-47773224f5dmr106326985e9.5.1762871023136;
 Tue, 11 Nov 2025 06:23:43 -0800 (PST)
Date: Tue, 11 Nov 2025 14:23:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAONGE2kC/x2MQQqAMAwEvyI5G7DFIvoV8aA11YBWSaUI4t8Nz
 m1gdh9IJEwJuuIBocyJj6hiygL8OsaFkGd1sJV1RsGJ40yCgW/cOF0otB+ZsDbetr5xIfgWdHw KafIf98P7fiGHDFZoAAAA
X-Change-Id: 20251111-binder-fix-list-remove-41c29c75ffc9
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=oj2s8bO5lxhx+kKxRe74EFxM/F/qWhzbrg0KtIezBuY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpE0bpi/WI7dIpOwFKvWdRwVEcAo9vBbRNsfaxI
 Q0PzoEYrkqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRNG6QAKCRAEWL7uWMY5
 Ro3tD/44ZBOKxIr8I0ZmiJSpYwK/aReOFe101HeEva6QBMbGahZnUPutQnKc71AE7fTzvqQxyDP
 PHBtRnuilDjPCe5zxQxyn69IoJuP50x6Ty366iWizgfp1KL8tkNB17zIRfF00MVZyiW8Pvz8VqA
 qwQm9/YvR8daSorxtQjJOpUKbQFejmOg5oo3B++95hj1rRu5vFTUFVnfKxW0J0uEg5dImsoz7a0
 8l06vtacn1he0voaZ2sYlY3uJCeJyzP8JQ/nALRvzEjwZz9+d9khuifWH4nNLCdvHJayRmF61Hj
 dX4IUYgPLhL6Dr9eCll1CxAJIh5CN6aF/VQXD9X6DOUWMstq4pGJse+cwLk50vyq4At1PBZLAOM
 NnicKTyttD2HZNs0abHzoXvdiAAWCSNXW26mUldwMxGSoYFUAP5qW+kUB8avc5LfZ6SmYjx/fo7
 VvpI7Dj6zfvCK0EBrONW7chcgj6OXZccO7EvI2GkbfmqjRaaARAu06pk89c6YyXKuHzvs3pYVv5
 qioNRCHAT2K+t7gSCmn+rkqT002dzVJbf20rP7SMlGIbDTRKGS3NhPHoJLLq5wNpIfL/UJ/xIKG
 XE0lMJQIabn37UbqSylpn2+3kGq05KOmdJkhqPfhI8PXdPb1Fv3JtRjzG8bCfrdXZrFfmPM6qJ3 y+bGgzRTLiNDRpQ==
X-Mailer: b4 0.14.2
Message-ID: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
Subject: [PATCH 0/3] rust_binder: fix unsoundness due to combining
 List::remove with mem:take
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

See the first patch for details on the bug.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust_binder: fix race condition on death_list
      rust_binder: avoid mem::take on delivered_deaths
      rust: list: add warning to List::remove docs about mem::take

 drivers/android/binder/node.rs    | 6 +++---
 drivers/android/binder/process.rs | 8 ++++++--
 rust/kernel/list.rs               | 3 +++
 3 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251111-binder-fix-list-remove-41c29c75ffc9

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


