Return-Path: <linux-kernel+bounces-832572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85655B9FBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3DC1C23AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D732C08CB;
	Thu, 25 Sep 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+cODE8g"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8A2C08BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808503; cv=none; b=JsfhrEhb8J5ExkZCu4+Get7wKQs4q/GXGIs57aVVjFGRNxHDhL4cQw/WUmaWOq78kgHD57qdo2otVAF8nTU93frtqknW6u5Jtdzyq7/xXVi38vbsWYHekjIu2+NNvMe8T3JaziWAipq6KNlxCfT6vv1nl7N4pJn/iUGs37l77jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808503; c=relaxed/simple;
	bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ev08lAAQ+dYyyTiaosHzNJlYgtUB+iWZ3DbKFwnFHPjcxgWfjkmth2P6w89kGA/Wmbk2qR15JllvpSCygXttjBS0KYyNsD/iZsxSRhsqtzPEs/pLPQJXtsgrKzTne7hoYNE1IYQrUrhbxXbPH61KAnlMoB2iHTh2bAT0jpyfEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+cODE8g; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-791875a9071so8417556d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808499; x=1759413299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=X+cODE8gpcyrA5FeL130iIoEK2/eyLm4jvpb2LplgGzizzyT5BcZY7Q/Mpmz1VoVAO
         SJDNVPXmqsZMqD+NQb6+JkQUviwFh1qkH7cIOFoc/xah7Yo19jSz0GZP9qoOZsyu1Uiw
         8I3n2Fdtzr+mEzFrqoXozNdzbpq0vZbBU8/dt3PWHB32wXAIVjoyNwZHTbWwu/btTQ6d
         GCWZSbQZUYgU0yFAydilmIm+tQaeSkBeoHNKiDCoNsFFKu/o0odqaC3VHhrMoapxRWAX
         H/90suxrOSxo151ZsRHOCms0ShPgsFRpVkfnIdH8MaE18pah7e+z3YhErUKAHvL0tQwe
         lT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808499; x=1759413299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVSYVBz+/C/3yUXq0+Xlzki5tMQiQIQTN1ASo1OgvYI=;
        b=J8s4r9kgKn4E3h33lrViWREQbq+VUxqq8n8WE8Al/MATDCkyD4cZ2a0+nRplyv5NCL
         WJW789gqohY7MZk+wtLdCV6wNasTGTHwTAaUHSY8CvN7a0OcXzusLWVEkscM6hLipsQz
         VOYkFmaEWwz465GzXnrQSNoA1dbeYKo2SoymH67fBSdI8g74ZlUnc3O5Np88FkeEoC0l
         utuBpuWsMXMHQzU+t64/HW1mWE4ufwTkULddk1yLuGlZdWtp/v7qwJ6gueKIlaV07bti
         K2PnAQRwCD3xlCnz0L7e2oH1NcXfcv7r1y6Q+UZCD9uku2SkSTlpVUG60iia5dgULeZ2
         sv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHVEerZAZK0xWLOoG22tOy9XwDJ+N3z3YDfZIZWnn/OUeMdIloI9SruSIPmtGKurMnEGj+251U2gAQW7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB03Y9JlqqDDemoor/a8uylOxhqwF59YfUDvF3mXtiWlq70+0i
	Bl27aJrF0shnh71htdO9CTPES7FY+CtB3ThxpTvCU1e+clI1RwJeviKZ
X-Gm-Gg: ASbGncuTvn2ZAlDENuqTrTnnsGCOAROrhnrxTveufWgt0PQRrV/wOl+bJYNesGiVuPf
	VOiIEkl3LtLpQjekT2r4mKHonm+bKxZUR6j8QExuF+du8QK/n24M3Cnai5OR1NRV2GpyloYGod2
	sFGSRIkI5GPkCDXy5K/MGsho/7iI9Fr5VzA5657qBYrIrRsq6mnBU/cHdCDJZSyl4Xy3UR27Qrg
	XIu1LODt1Cbeo/AKTsM6bV20BqbydKMKxLVtwO5s5k2/9ExADdOmtNc7xR3/cI4SJj858r/ji97
	bt4IKSbhk8T8XGcr1iK5VgGacFkZLV/jCo4fBy9qNoV9itLzdwSzGA/YVMXhQXWx8eIiDUcYEF4
	+oNsxlkU4BzXfduNFlfeunmo8hc0wX8ewtPPXKG7Z5mEF1W8GynDd656lTWm4VbbiO3E7nbxAfJ
	E+VT/Kb5T4S8gFizICWhOgdQqnvd3hLhNsXLxplT5hxRO3LtYKXzHsA07Ts9bicrFfM4LH
X-Google-Smtp-Source: AGHT+IEssEmLNZcem/aKdLWetF1Fs16YPcmtFsn6hozzBuZs4Wn/CLmfl+Df8wHKJRPpg5SfyGzrZA==
X-Received: by 2002:ad4:5deb:0:b0:78e:c5c7:1209 with SMTP id 6a1803df08f44-7fc3e015bc2mr57974806d6.56.1758808499295;
        Thu, 25 Sep 2025 06:54:59 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:54:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:55 -0400
Subject: [PATCH v2 07/19] rust: device: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-7-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=2297;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tEhBaBJnhQFO++GmUh6w8m63Mr6JSvoXu3wOHmq14e0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFEkzUjb+lD/w38vqtw9O/htNaxJTX/sabnw4QloRojDdlHFE7uz1iz3IfwN44ls/ZjS7SJYOQu
 /SzXo2WM/nAo=
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
 rust/kernel/device.rs          | 4 +---
 rust/kernel/device/property.rs | 6 +++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index f3718da11871..242286162c8b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,8 +10,6 @@
 };
 use core::{marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 use crate::str::CStrExt as _;
 
 pub mod property;
@@ -378,7 +376,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 3a332a8c53a9..3eb3f36d66d0 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -178,11 +178,11 @@ pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Result<usize>
     /// # Examples
     ///
     /// ```
-    /// # use kernel::{c_str, device::{Device, property::FwNode}, str::CString};
+    /// # use kernel::{device::{Device, property::FwNode}, str::CString};
     /// fn examples(dev: &Device) -> Result {
     ///     let fwnode = dev.fwnode().ok_or(ENOENT)?;
-    ///     let b: u32 = fwnode.property_read(c_str!("some-number")).required_by(dev)?;
-    ///     if let Some(s) = fwnode.property_read::<CString>(c_str!("some-str")).optional() {
+    ///     let b: u32 = fwnode.property_read(c"some-number").required_by(dev)?;
+    ///     if let Some(s) = fwnode.property_read::<CString>(c"some-str").optional() {
     ///         // ...
     ///     }
     ///     Ok(())

-- 
2.51.0


