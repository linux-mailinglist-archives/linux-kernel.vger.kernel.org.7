Return-Path: <linux-kernel+bounces-888444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2BC3AD22
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 535B534D9E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C24328625;
	Thu,  6 Nov 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7j5ya5I"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CA32721A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430956; cv=none; b=Y97ljAspzE3fgr7epaiYrUycUYi717bPE8xvMaoVJ8Pj6OqqxcNY4f6kSnDB4ozc57RYXpEMv1FCVD4IkL6BEsvmbretkwn9dCNFODv7Y/24LpHMZlPjiZbbu4sWH51vS1wJ90XBJsFN5heanEVNY102tzyXJ7yX3wIBYTSLlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430956; c=relaxed/simple;
	bh=v8C8yVAE9Ny+v9yDr6VsXp9BWcYD+xa4DF1KLCBpzIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dadu2dBkTu3URnd2o4S/eqKF+MyZmQz3AxNvrQ42SSLy6PZiEjxzRbIXfVDBATWxgZyzmxYfbaVCxWAsHxEs+tRxvjF87LIi5qTRyy05DjJbOfVdULUmjH/1o5vL+xlfY2qtE0IMw3qskOm6nP7x86idgHH2nM1GnMKWaV8Igoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7j5ya5I; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477171bbf51so6336675e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762430951; x=1763035751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oMi8GYYBlVguXP2AF0cTsK9jLp8lS1meVWWIEbSlshI=;
        b=Q7j5ya5IB0x/pr6ng9pNDPxd3spxe/lmh84QGr5w7rtlpjU2jSoOD016wYX40DuBFC
         tzhA1EUkfiZfQ0e2sO/rzgWxvQly7KRt1V29XvwnpohhMJibpgRIXnBbdGIks+Rq8y3O
         yV5ue0smcC3ckSdyj/fKrzffP3HoCTXxFNKv94UXa7Xe/GOpJFkbnHb1bbWh3zhw5VFE
         h4z2uwZsRJXMv1f9YmIDU7ty1ADHWubMcDVrKmXvzwnybAxO/wsrYd87dSXd2yyVpBmc
         EH1s0/gsTDUUWQ3daeFZKnj+hpPWDbSpwra1+31SNvEN+bbDKE6NxakDhRkaBQJOhYL/
         zXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430951; x=1763035751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMi8GYYBlVguXP2AF0cTsK9jLp8lS1meVWWIEbSlshI=;
        b=mS35wlfwM8qgEQq+K4GCOm70X+p7R6r9K9eUPKOGBXkdYUsGJgkM5Am8EMJISP8++P
         uRheL5OcDMe96UaPsQljDsRJpkk/RwOre+iDxY0IYLxvqa9b2Kfq9tU5zx+AhZJ95Map
         GsDxvp7X/cVElBNk6WTC3UAkRZ7Rz0bLlrNBEMb9/RpOQbgKMr5+NSM9ZcMUgspqdxUG
         sMSBQY2kp02Ly6wK08BMmRf16/luRzgjES89BwnytG0McAahlDqbnLGF5mpI7QHhZ60a
         2TAzNjb3LlB3gQFKXWQMrqlfggh77/1pBMlUIXpt0tk9faRQBR2LCiLWzR1GwudXSAb8
         Y6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX4gbSEVBoVJRVYmtVXJK4snS1R31r3zCfiOjnpEt6lI3vCFEMZGQLAjO1ZRnvg4N2FmNXC7ecxx96sibc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrVFku589q+e8Mm+Z9h3jdakYt1CwhsY/1IeupQwyZTLipMq8
	wQhNLvbx9PwlK70STs+k0MxtFvmwD70Eqi7IAMJFZlCS+ZNLXHnySKNORTtR4uEPTWgqfgSyI87
	LKMe/1gUP00jC0SrKHQ==
X-Google-Smtp-Source: AGHT+IEtMPrBTDtt42DdHcV8/FsihzPxKe2LPSw5tuK9yCOfw0mIa+59YYpR7BHvm8ZaRw0lQbnZQ6EGDYgr+Nc=
X-Received: from wmf20.prod.google.com ([2002:a05:600c:2294:b0:475:d898:b23c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c1e:b0:477:6ae9:87d with SMTP id 5b1f17b1804b1-4776ae9091fmr2504845e9.4.1762430951751;
 Thu, 06 Nov 2025 04:09:11 -0800 (PST)
Date: Thu, 06 Nov 2025 12:08:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANqPDGkC/x3MQQqDMBBG4avIrDtgUqLoVaQLNX90Nhpm2lIR7
 97g8lu8d5JBBUZ9dZLiKyb7VuAeFc3ruC1gicXkax+cqxtW2P7RGZzXw/h9ZEQk4yZOz7bzbXS hoxJnRZLfPR5e1/UHM5X3umgAAAA=
X-Change-Id: 20251106-resource-phys-typedefs-6db37927d159
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=v8C8yVAE9Ny+v9yDr6VsXp9BWcYD+xa4DF1KLCBpzIs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpDI/m7X+heP/YqgbiZX1Gt1RjQZsNIEEXCXzkM
 sefQqICjj+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQyP5gAKCRAEWL7uWMY5
 RuphD/9prTANQ5o2yI3jFwYwwCJaJP3ixK22fADia1t5O/qL9B+1d6yYpVdN2u/RfEwC/g1ABXs
 2BCEY7/CfrP9K8NsZyPxeLjnWa4ERBRy/CsJ0Pqu0Lo1mA+o55HqqRqYwzetZA494s/64C1F9DP
 ZIH/M2VBqEfpJ+C5b0y/0T6Y8dBnUS/Btxp0VY70v4pA6JZCTv4CZwAVeZFHZHDvJ9Gh/qNBMze
 gfw6YhiTljh6i2G5OtAv8AI5ZxBQ5Tp90apmU7cuTD3plpBq9h1wlv6O6TqVTyJlGPpsdpLitoC
 NNT1qxk7DHxRoTm4rZY1SnU4MXQ9ndU6kiFY8C4UA2Qry3XZviHifd2vnTr3j9dCAkxm5iMWETu
 FPYaY3BKs4+SWb3BgmYAM56VUz5GfAQsNaY3s+nE1g8s+4s2FNBAUw8BgtCM+XKtb/JFslitoGQ
 +/OgREqCgLwnkkZmN1hqVG7CvOtYMlKqCFMYR+rpcUwKUzjjVmt49e1Dpby25Ca7XrPzBy60VQh
 A8f2v99WTaKkjIQghayogekwcgtrNrD43G5OWWnKjtRJCM5kLMamzybTILXaT1Jif4TPFh8IGND
 rjufLi8PUdTpvDFq7DWEnL3y3LJL64HxiOKvJOoeOVckP+HG5eYkgacNxZeMH33hGZoU2WWPZYr tzeN1RyJ9+cYBoA==
X-Mailer: b4 0.14.2
Message-ID: <20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com>
Subject: [PATCH 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This changes ResourceSize to use the resource_size_t typedef (currently
ResourceSize is defined as phys_addr_t), and moves ResourceSize to
kernel::io and defines PhysAddr next to it. Any usage of ResourceSize or
bindings::phys_addr_t that references a physical address is updated to
use the new PhysAddr typedef.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (4):
      rust: io: define ResourceSize as resource_size_t
      rust: io: move ResourceSize to top-level io module
      rust: scatterlist: import ResourceSize from kernel::io
      rust: io: add typedef for phys_addr_t

 rust/kernel/devres.rs      | 18 +++++++++++++++---
 rust/kernel/io.rs          | 26 +++++++++++++++++++++++---
 rust/kernel/io/resource.rs | 13 ++++++-------
 rust/kernel/scatterlist.rs |  2 +-
 4 files changed, 45 insertions(+), 14 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251106-resource-phys-typedefs-6db37927d159

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


