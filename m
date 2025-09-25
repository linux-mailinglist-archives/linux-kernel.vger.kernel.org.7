Return-Path: <linux-kernel+bounces-832576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B33B9FC42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0D8188EA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D92D481F;
	Thu, 25 Sep 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbV65Ngf"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B12868BA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808526; cv=none; b=ajpBi6VqBf46YTQ8ZTE9mk+bNEmxYeFiaXjteVrYUSa5bnO4wHCKkHgtc1d4biGYL69HEAQ3lPARQIvzokdkjNIuDZ5NnUcz0I2IDkZ+3Ea/ILTbTeKDOOvq5yGhJGXR+G7Xi3CI6GliSUQb3OZ/kXAEj+40P4uCEhklhUMW8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808526; c=relaxed/simple;
	bh=G1wsZhjB9YFMrkpz5gcBxDMgotSl9l62JYKqp+2kvv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7aSAVDOOfbQr+q/JbAzIhgDcXnN7VH3BZTwYmG+aGXkEIw+la/QmOxcM/aGWXEcqi8EoksgzMZBay+bURqIO1xG5AnCAYrEL/FIFH0XQR6s3ZTPpyF/UlWjyCJS4oMf0YyUoNJtOO5jRMkac75k4k+oWrjWabD9JQiH87ix1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbV65Ngf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so8918736d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808524; x=1759413324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9F//OQcCcTSCVUN93IinXT3LeiwclsyrHd76W2OsUHM=;
        b=cbV65Ngfv2wRlEQycfdgsdZ4HyL0QMsjiUgFkW3x6wmAA4RJNKRWCzbOWivIDV3PsC
         7b+sL8NR+96IIeE20jn88m12eoaaT5clg/qTv76iOKiW2TNEx0WjLvHkS7tFU14cNsAQ
         B0LPn3uFZVOm2LLgF5xsO1es5hzs+DTWEyhe3ufC0x3dlZzGvCFUSbEU8Nf9JEydJMJL
         mgkgXp7ydD7pec4+bV4VWpSLqAsIYhgFBAMNaTC1and1dW7vfAk7WLilJkUTb3rdF3mC
         5EJjUMqF5AdTatgsWuHsKenJjxu89sJW+zn4zQUwjemPdSVpx1Cho6LvB5I7aWyGqDQ0
         p1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808524; x=1759413324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F//OQcCcTSCVUN93IinXT3LeiwclsyrHd76W2OsUHM=;
        b=PejfnuZnIzUtp4JHkVuXG7pscJ+6MA3DAshZmjyKmYenRH1Cbeefv2zxXccyqAeyDi
         PgrarHVjfJiVwJGCPSAX81CZ58fFiLzKUkx/mhuWJTmZgGjzP8MbAQ7I4a+rFh1ugIqp
         GYeM/vw3uMlXo9QXWvthUSfq2E6Vy/0YoFnSDJC/aNS7XFkdKEnflX8Zw6iTpr0h9GxJ
         FI6D1HM9y56GqIT76VnEifenryakNkZ2hMtTVMiqJY9jATWoTeX0daC1hOUAvaDI6d69
         oMPtmMVk/HTKnvXGT3/MFdhdUinA56VjCTvMSNSOayiu4P3KNU0ViPjSyWUqR77qq5i2
         OVuA==
X-Forwarded-Encrypted: i=1; AJvYcCXswHBqgnAajJCVOXKkuEbmIk7pMhMz/0TDOBWTP9kh3vPlOVYnOwC7jjjWyxjA4bst1vqPjRdPmHbjBOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJ+q8/VtAAjFjWayedyrTcMIzCxs38+RPg/FqZSFNyEML19l7
	lRR09vNsgH49OccYvAF6bLnHsu+vAeOByILLY1ub5wtqMkPufva/9FBy
X-Gm-Gg: ASbGncvB4mWSN5CGEHRspwL+W4tJLSj8Cex9xrhLoRqMGMFw1+aAgRPXIAIpPRDzD0x
	PVu7M/pG9YLN98ZdQckzBQGIDIAm4cfUyfzY16jbedT5CHulTixoKgkO7P2DL7bYYrCaZs8kDU6
	RIOdCNIbKFdPaEgJc73YMJQxZiqiryWAFck/QrB62fdATJjMgHoqj+J8aU4aIXoZhYqXolOME9U
	s5c+RGYVTgWD8CgW6ooLsepK9lT9eL89kLdYkfkNStzQ99CfyvyhLTvR6NkulYqVK0VGiiVruZE
	KR/2mCW7v082mGezx7IKTCfGENm0I2Bq7HNSUcxV6cGcD0Pq2QL2F0SSdp1eRoluTWcvnW0DK/5
	NGuevSALrSgK2EzfnoLwseFdBPxHOL/SD4baXBKmTqntMnZ1WKNOLff7BscnG37C7D2FYSuG+xs
	77OjDCLVfGK5lOx2uIujZEKT4BFDRJ+G6LW3ovepDuprQlOq2i5PP/YFyUY4EQAlBMf092
X-Google-Smtp-Source: AGHT+IG8Gyrq/9aswoyGrByufUDOEDDpB4vAZLNl1cBk/1ws0VqwO4eeWj7YZE4dhPO66F/wFvg1uw==
X-Received: by 2002:a05:6214:1d28:b0:7d6:c615:ecd1 with SMTP id 6a1803df08f44-7fc4ec0e7dcmr46038496d6.61.1758808522761;
        Thu, 25 Sep 2025 06:55:22 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:59 -0400
Subject: [PATCH v2 11/19] rust: miscdevice: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-11-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1136;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=G1wsZhjB9YFMrkpz5gcBxDMgotSl9l62JYKqp+2kvv0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDPHa5h0Ln008NycRhnUYHSwita6ft61YpP6UIaouguWtU37E7gPYJQE7EoOJeFshI2ze3iWBrO
 I6yLKReNrlA0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_misc_device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..60ab10b02574 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -98,7 +98,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -133,7 +132,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {

-- 
2.51.0


