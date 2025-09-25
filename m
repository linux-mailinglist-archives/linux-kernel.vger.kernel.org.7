Return-Path: <linux-kernel+bounces-832567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC8B9FB72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF938275A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF251296BBE;
	Thu, 25 Sep 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdFJ5Y+M"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9028726C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808476; cv=none; b=qeZm4/dNrIsM7fJFVl0TOQpF06ZggaIWCcl44/yMIfD/T7JMRjXQwgKx4u5Ce+6Za5dW5m5m2WhM6X+cXuLE0Lznm+4XOEO+5v+CZr9bfJ134fTIrEVXHc/lWofkBrdPThlQkgVO6nI3p8dS/1x9xyrMwVRMMZeFVFTxsFAEORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808476; c=relaxed/simple;
	bh=hAcmGZ1oTJ4jVBQJEYJ6EMTc7nRfLDtEyG/sjigYIyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5t87B5M+/OavnnpIeR0npl34jWGiTdTekZ2TIS3xJZC+Rqb4qZM3Wnv6olgD+/aUliOBiBJSultVKzwiwU6jeMjSwfQL0rEdcZGDmbMDmu9H8k/cMQ0WwDSV35plUxDmMYk2YMvMKlobgpPZS92XOEHiEJXvklHDiyNWaFYu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdFJ5Y+M; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-795be3a3644so4498976d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808474; x=1759413274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xzf6OZF5c76vENMOs87EjkdVa89C5AWM8vex+/TLyw=;
        b=mdFJ5Y+Mr5cQmu2a8FMx7odFq4o5MU4BtNFZUkmdmuk5NsirvsjSA9+cuF1FCaZ/oJ
         7wiY8Pgx6585HzC/a7LApe9Ol775mowjqiHcnsl8BVXk5hr+s/Kw3bhzgaTJ/AP2mN0n
         7fmlXG5ejtVjGJTM0UCXTvNO9a+yn9hoNAv8KGozm6Lz2VOnWwqXfkU/5lj3C48p42jG
         J9ypONLwel9qPlk2MIK2ZXA3mt3yU35/JsHk5wqj2dD6Rnn6nDeJ3/LHViyX38P5LUBX
         tdXG2Lxox0kyA2sb9DwgI+ROdjMbTirj+beoub0FU6beRgwH8yBdgKfJJS58Rq2vLX/5
         +KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808474; x=1759413274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xzf6OZF5c76vENMOs87EjkdVa89C5AWM8vex+/TLyw=;
        b=gSzPZI2H6eMDi7zvoChCmtSoPBpMOahWrMH8SN8JigdOVWuNZSZVd12OM6Vu1+H5Zj
         ZoBc2N+qEX/CUdOjPTRVkXAGoXM1G71y3TrwCrVzVaT2ZBUHGHFPVD6fK3hXdJn8gUMw
         LRFu8RVCSKfPhA9jAy3ynl4/kptWbCFGjytswPJvVG/PBQZv+bF9WDjCukz/Bxlcc4Ae
         2xDusuatH1TAq6m8Mo3vYuMKJRL82WamE4mVcaf6SVdioo1nWFLl7QHydkkNQS9RxjMd
         mgx8bm/SA8eoOvtj6vmf5ufGzD4JM+6NYRb3E7zx7QSd6UFDirG7Dx6ewddNersHnjoM
         9Oig==
X-Forwarded-Encrypted: i=1; AJvYcCUhJSa5whFQPUoL5ymiPWzCodbfjKO+T0LJAEfeH6g7sXwGIeaz0BFuEAdjc0vS1Ff8lMHo5SGNvdNiuhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFnluL46uY85RSTSh0L23k9QGQC0LmyLxmnWueH94ZKYHfP71
	GLWXtISMTxpxqPQJC+zXqDpYKEAbNTQSNc8wq9Q/2nxX9Y6/51YSbUzQ
X-Gm-Gg: ASbGncuG74HAJjxSmbGYPdN1Kpt5bRXFi8/O+YVq7VGa9Zrg1N6OCPH3WzovUUjDpRg
	wYBd+paZqxpMErulcf1EMpD6hAQb9tm0jMMT3HUbdCiUurwV0UCNGbHBRbdhFZFLZlnmPD0sOXE
	mbOyQ7HGEwsxWs9LzxRy6QTPZ8eyTFZEPCZKo0ZmDMC5D43Mf9kpl+CtOW2JVW71S46cZtxfNBQ
	YztTwc3P3EwejkUS+yws5NqIj/TtKV3fvjLmWm4YrtbzwRYkiEHZSHNJxr8NljXYJwCOIBO259E
	/wISuo/7XrIbBmbLB1R/aG3hs/nXboqfiXUw9YNIe2Msk8cgXo33BDOTwkB5gSsHhI2MgPjBSFt
	EstaVt5ownAQUraXIr3dwb7pBqeiPAINJtqMI86DfmtioVlc0Diq/4fbHmhv6psN/Tc3wF2TXe3
	GNWKt2NjdectYG9wqrWechNsbXFJ8rlBhsM2anzXtL/UPDb8xpOlBBwkAM1pSWf0b8NhCy
X-Google-Smtp-Source: AGHT+IF/YXOPVFfPbsLgNMSmKy5gMrqFYiERb3qNmBjJICdsnhp8ZUohxvtzmsCi+i1Rv5C0gLGPJg==
X-Received: by 2002:ad4:5bc9:0:b0:76a:fcee:97aa with SMTP id 6a1803df08f44-7fc309ec826mr47810606d6.29.1758808473264;
        Thu, 25 Sep 2025 06:54:33 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:32 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:51 -0400
Subject: [PATCH v2 03/19] rust: auxiliary: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-3-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1276;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=hAcmGZ1oTJ4jVBQJEYJ6EMTc7nRfLDtEyG/sjigYIyU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEE+jmobZ+OS5gJ2DI0z3t4gywTvP6wS/uYHw9wdi8Q0VEYO/oiFsjlDMO0nWijf77etP3ctTic
 ZfcFfCn7DRwM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..7c916eb11b64 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,13 +5,13 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, bindings, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
-const AUXILIARY_NAME: &CStr = c_str!("auxiliary");
+const AUXILIARY_NAME: &CStr = c"auxiliary";
 
 struct AuxiliaryDriver;
 

-- 
2.51.0


