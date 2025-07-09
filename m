Return-Path: <linux-kernel+bounces-724622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24596AFF4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECF73AB100
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406A246BA1;
	Wed,  9 Jul 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNE2vqY1"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB5229B18;
	Wed,  9 Jul 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101388; cv=none; b=ezIbYy8aD695toxbO+BFq8YzGo3Cwvhk7DvTkOb5PwdpfCVlzkLGnZ2/wHSpGM1AJslYZhdKoq+oo30CzkyAdNf5SG8w+yroJE9XgyUbktKTgus001XNra6g20UKvm4ZoJhaNF3vUXyKEy7OxHT3z1+G9pFxsnItl9sbMWt4zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101388; c=relaxed/simple;
	bh=ATy8JEXnyswf/aDrAW5bwnanptnddshi+MTE+uEsKGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GB7qusAVSLrWWh82ShYauj5Zat6NcTCs9jpzjHj8ry+wQAuitjNQN9GwZn+qE3xC2Zy8RdydL0sKDGgNkTRZzI0KgMmsqAjBNQ7cTHYoiTd2yNAvHFLC02UgME5dr95WHFikqoctEx4WPFBI+CQHlKkimrWxfrQQfPV8VD8qz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNE2vqY1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3f1bd7121so41401785a.3;
        Wed, 09 Jul 2025 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101384; x=1752706184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUZbEndeYISoLEHqNCHvlPZoI7WUvlxd+2hFgjozkso=;
        b=XNE2vqY1BKuUAW0t9PQm2/25iCsKg7GyJuQMAiALg+LJv8jyXjoiCS1LCy/EsaHUgT
         bSuxYcSaPgbOceii85z+N7RYZVi79FmxMyPYsqF2cElGUAxtRGz1fMbr3OcOxETuvUQC
         MY1mS3/lkgMckxgz4rkQX/1vYplkUoM2SU1eEI1z0wuTKJorycwq6iEDvWVjz9bg64mQ
         EUtMvoPy4l9RYpPS9lecgW/mj6hUH7pD9B9O+LBNm9/t6yWj1GiC1SiVD1PySnfHv3S9
         xV1grubrQ/2X3el188bpxorO07KJRtIKsqXTeTZ9VkB776Bw+YymT/gX9W6Z9fm5QoGF
         FERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101384; x=1752706184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUZbEndeYISoLEHqNCHvlPZoI7WUvlxd+2hFgjozkso=;
        b=kvHCgLh7wePUp9c2sL17w3/Oxo9j1buKrSEInMUWQHCOYM06KlZAo4d6jhJoPrBCNq
         eQTLrXXXOLRIFUg0gAyJR2USRyS2aKnjzdbUmVVMLLDDn742eW9h//gG/ZDAWXR0OoLa
         /rI53RPN2ScmqUsEotEVP1u97LWXn/YCzun1M/hY4EXQo20Jl62MBWN1LanRDI5JNav/
         5br6pf0llcqweXSPbyPcCn5yeZ3WGdZg8HQazY5ITyOdxdkAHLv4NsauiRJwFWkKvfwo
         YWQAYL0zx0Yz6fJ+zOcFCA11R5BIhXyU68tQqSyNTXFFwgwbHTcUtLH0EdvPSyqq/n5R
         tgDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUr2efVN+Z0zv4nV3xcW+NTtuaLrPA/dmWrwYCK5PVzU/CxtlfPGDpZgPepWsF9jlBGwWsw9Lvryic8Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5aPvPBw689CryBFiaIWM3agAFioQGLjXr5wquGBK0EuwZhIA
	Cl7DlSOBEV5NRZWpWb+dL4bHVKZbnJcg1IO9DYFI/KjzeWgir5lEUOEv
X-Gm-Gg: ASbGncvRRoWvPanlWJjT8KJKYGQFcIId/95Uy682MtKxXPkP2PozkYCdQMeuHH0Oqzh
	wl6WdaSqPaje/2WuADWnUlAESaU3NN5oGguoKTB1sxU8PVS61hOfBx/PvyYSTmrTf2oDZmF7kh/
	rInq9BI4H8VWhminIftYMLQrimgubS4ZIji5v2iAwOcP7BKdlYl6aPZ9GBpgJQ+U4ej4KVcrb+o
	t+aXyf4NnRAI2NEZ+CtGCRehgdxArEZwyhWMmgoBdvEvdvJZwOJnWsi70dlrBN9M5o+Hgb96Q8O
	XTl8vy751tEAx68wcJn5T6GIhc6Jj8U61LKrYZWHnuvqQKbKT0hvGIbGYVaBcWTw5Yix
X-Google-Smtp-Source: AGHT+IEpZ2O7vHtHKtjhT5gt0BYxTQkRRV4qDet17w1YQfxWHTCrMRXTs3Ao6mQ55CoB1Fm0LuoMCg==
X-Received: by 2002:a05:620a:1728:b0:7d4:1f5a:b24c with SMTP id af79cd13be357-7dcca6f0393mr78049285a.22.1752101384089;
        Wed, 09 Jul 2025 15:49:44 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:5085:1d69:8814:72d4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70498090248sm1025986d6.90.2025.07.09.15.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:49:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 18:49:35 -0400
Subject: [PATCH v2 2/2] rust: init: remove old workaround
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-init-remove-old-workaround-v2-2-a3b1be8fd490@gmail.com>
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752101380; l=1070;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ATy8JEXnyswf/aDrAW5bwnanptnddshi+MTE+uEsKGI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP3ssS88jSbSCYWkPXUNUoiGsdxDrF6CaSRQUvNySM0Kjl8P+QlLPVrQwPGbDKrhvnem/NAKzHG
 xioCNRj8CqgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

`Error::from_errno` is `pub` since commit 5ed147473458 ("rust: error:
make conversion functions public"), thus remove this workaround which is
no longer needed.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/init.rs | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index f8402c818d30..9b3f3e29cc6a 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -79,14 +79,6 @@
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0 }
 //! # }
-//! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus provide a workaround.
-//! # trait FromErrno {
-//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
-//! #         // Dummy error that can be constructed outside the `kernel` crate.
-//! #         Error::from(core::fmt::Error)
-//! #     }
-//! # }
-//! # impl FromErrno for Error {}
 //! /// # Invariants
 //! ///
 //! /// `foo` is always initialized

-- 
2.50.0


