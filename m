Return-Path: <linux-kernel+bounces-832578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A35B9FC75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925A14A51B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9322D94B7;
	Thu, 25 Sep 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfosiNOI"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146A2D7817
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808540; cv=none; b=KcCJe117mnrLgbJMTqZbHheNnPmxpdC3zw5LSLmjY2K9bOSLOqtA2K1VBVpGi9aaoUBUGlXbKr9eG7MzGknN2Q6z18W7JM7vePnDJY2ARucQejwHvrADfsOrGLbSUvPKFEuNnXvYG5bL2p6uMF1zTRXRYBiafMmRE4VTmmc1RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808540; c=relaxed/simple;
	bh=9ZmEu11QXJ8phGJATObrsBrPngKGUQeOptVynfUL8WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJ/3feZ2bqlg+EqLJ291K5pC9ag8yHuuyz/1KxfCsVh4DLLsYQ6BVkTJCpjzalWHUiCQq+VnB+YggCrXnLCFNPk0jgseq9GryK9g070BApf2HGeh0K19sjQWSlPgk+Deanr99cmW9YYTwae8maXXYbr5/CpsjuRnijJtQa2KwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfosiNOI; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78ed682e9d3so7151436d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808537; x=1759413337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mswzqg1rIlmw6HicVVCtXv0e5vufLTaFX3VKtK98wJ4=;
        b=OfosiNOI6HdmuS6bpjzcl5fODl9n35fCh7xdTjfT2ExCu+lpF1+YgVYf8Emnwzm+oe
         +aVYsc2liL0RJevBRu8j8atyTHlxwgscCJvnetkP8tqejNrdr2gVgiWVukDe28fZ/qX9
         ymyEZ9QZmXmEah5zJTTcF7n7DpNK3v59CsrU635x0fafsNef7B4/zMdU/wsnzaaNEsPP
         C7P49OuJpFFwOyuU/T6lY/eVYwY9TCEWc32ekvJKVLxqvwEVTaw9b1DWXZv8bJIErqA+
         JvbkXnwOQPZAWofUX0RdilxVZdsda2j7e112eYDahXdSIo8LEQtJjj1pdP981SVGPGmr
         iSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808537; x=1759413337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mswzqg1rIlmw6HicVVCtXv0e5vufLTaFX3VKtK98wJ4=;
        b=WK7uPEh+Al3fbSgWt2vk9GvSPsSI8YTFFwtdlGGtp/U7HweF54ztTl+it2xRJNne3J
         8Ol6GO+OD4z4REDiA2O9yEiPFhK1N0FVS0q6MbP1HVmcCPEa/wGG6G9WUNjNhjIzWLBu
         boVu+EezOCqSrKFEzgLua/SHmVLZfMFyRbtoKU97afoX9WXHoQmm+XOrckD36brqVFxE
         A/a2HeoGJDEOEQRdGAeuA8YSvvwa9RcwvyEJzthEGI3phccYuv2qQL0nIYoST2gncDMw
         DWvuECiW5sPvMRW8izSq7udMEopHK8COeTGuk1bNovJSnWbQGCJX6p0GOm5mhpgiBpu0
         wj+w==
X-Forwarded-Encrypted: i=1; AJvYcCVqFHi37vo+fiZKebTfYuXQ7csfLYsajgirjnjgfTuTKXG1sC4+MPTn1sCySk3hgVdUILfEs7qMi77dHCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIfE2c25v5yUjl5uNLrck0Hta5mZEeyoTxpypLSjoCynANVBI
	AbShb1yFeJ601v+VSp82dSTrxIhJyU5/wyRPBFNc+0SvAP53+4irf8xH
X-Gm-Gg: ASbGncvucxa7h110Myiucjmlt83xlNQMRjmu3WEj9V/kVesmffjWZuKvHjJakxef77Z
	PCcygmrJbyiryfPyD9GFvpVPLuv7KD+FNO8d8HwDsYyBgu/mfpejoUkbPggFmCa9k8z/TOJ9aQJ
	dp9KYWZKcZlBVgUMCGCiRR/GI5ejMKQn+aCB2hru67dGxo9h7BDVCGhcq+IeFG3Rq2/yQWiwaP7
	3fibMnqO7iN1nJOO6dXM244l0M8h0k8IdY1VnCLCwKbOHyNsUtj1i5cFRlg9DxcT3N5QdcewaNx
	YiDxSCMUIsOuXgdO4tacsJ08mw3DoJEX28eMbApHESMbmWaPD5CKIrbz2Esxzp7zOBBkhCbOmoN
	VWNkGvvvW2oP6Gk7/bNeiqI3UIxdVFvZerQXI69tpqsmyM4CClvAz0t80bbmuNbb6nyVoDJeiZM
	CKVAt9bFLRINIHn/HKxK2xCuQJmVV/Ky5UuiHVbt3LSNfqeCfRf/tUVFmpWCy7rOtwR/ZO
X-Google-Smtp-Source: AGHT+IG0JSBlGu1RB4uMilSaBh7PnIkXhnuatHF4cSQpYwaqP/zzSQ9G+tSnzQTTn3K53FoLTANywA==
X-Received: by 2002:a05:6214:4001:b0:70d:6de2:50c0 with SMTP id 6a1803df08f44-7fc43a4e9e0mr40876536d6.61.1758808535790;
        Thu, 25 Sep 2025 06:55:35 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:01 -0400
Subject: [PATCH v2 13/19] rust: pci: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-13-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1469;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=9ZmEu11QXJ8phGJATObrsBrPngKGUQeOptVynfUL8WM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLLvUlNLZLAaXK2MqYDhZdBweEQ8R3sKV9FI/C2n7BV5P0I7OA8y5a1a/1zJuYaQ3obw7TFfFmi
 JTjNJLSMGawU=
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
 samples/rust/rust_driver_pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..e0e9d9fda484 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -79,7 +79,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         let drvdata = KBox::pin_init(
             try_pin_init!(Self {
                 pdev: pdev.into(),
-                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
+                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci"),
                 index: *info,
             }),
             GFP_KERNEL,

-- 
2.51.0


