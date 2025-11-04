Return-Path: <linux-kernel+bounces-885414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1FC32D49
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF0A189E843
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A682D8780;
	Tue,  4 Nov 2025 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr1exZBK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635223183F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285086; cv=none; b=azm2nWt7gaBYWVLDA96uXQt1e2qQinJOlNO4ux8MoUuds9MflEUaD5WH3rnHz12SPRV1aR/gn8CDlvU/lLLdbImIU7KwBzXS/NjO/kQf0YzpeblKgEhSGwLJo1fOd0T1IH7PKwRkX1j2a5Zt9OH8DungOpUcSGpt22Ugni5E6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285086; c=relaxed/simple;
	bh=KKopLnaqdxOYzm8ka0T3yfGwqG+GHslnNlKG5VAXTEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv79VpkXkuSGBZqUhmwOyLl+5OPRE+NgvvvDclzIe/YTwrSTxl/dgpHWJLxdIzUOBa242A0gku5VMial54kHIavdcxpqwv3ni6ayGMWcY9JkIVEttisGfzpIs8/7eXyjo995LeQjZS5Lz1mt3zGTEyWiE3amwRuXRkcnHXycXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr1exZBK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710665e7deso28027785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762285083; x=1762889883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Xypec85439AsoYQYRLT5jRDZoV8gj7wZ5fnhiAzlQA=;
        b=Hr1exZBKTHwPAmlhZou48F10JpavVJriQNsNIhyTxzHDHl995u9AGcGCJNTOtwHzt+
         OQAvhTLT8uSRnK+wq9WAmynx44XFyw6oJrAjwmrVK2Nle/CZLcWgnFlgOFb1V4MW0sG6
         hvk30CCnXv8kXANSAjN+tqY8DK+TEm4mDnoXTnLGgJinZg7lxJZN0bfvQY6nnbndHYpP
         1YaxfV5yEOH8mfhcb+uz/QZacd+BtqgPZzoX6K++4etayUFgspZBU8wVtSwO39Oj+JbA
         O2UWSBmmhli7cIvUtQibAaDV4OT4nauuWPQiRf2FRHgPOIotlIbS+9zHqQ94Fay4Ohwl
         Sf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285083; x=1762889883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Xypec85439AsoYQYRLT5jRDZoV8gj7wZ5fnhiAzlQA=;
        b=J9PjvMAdiXAQJifQUSuLjNnIeeG+KieXs3/ENg78FHaq2KtHvVTsz6fEmcq/dHLtLr
         yCRRNkgXEh8aQCQdyV6Uo7/xUoRVQcebU1mEhD1KnbsJSKxeLWe5mNAJ3I1zxTlLjqwf
         99jgaE0AINRDZObWRHDC3h35JuprE1l0K6YyU44HIVC9uQfxdyBeCDkXCVFqfZwT6yw8
         HUp1ITTzN/ySr8VCYDEIaV2CfIbRSq1UPPagCjyWD3gik8gJ7sf/cOU3cOGMHkIa7YHk
         qzYxdVhyy5VMZntJJ/ycEqN9yACTL/wASzaGrkAJV+VSmg7u1i3CBraQSMo8XDaLVamC
         wsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOG72NyKdUV1HveSNhXGCzhvxgWK/wXrQ5rgb+C6mN3NY+jkHz86MfAn9EaNwxfuDphSxUfhsYZg10u/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JrjlBtQEcdNro1SD4gurV8/K59+lvrpBI5OZEJre01ARUoSq
	FgOuu/TcUlLU1A9NCGpSb+F+6vXnuP2avFsuABwxDAxaPgnI6uLRazIq
X-Gm-Gg: ASbGnctGI3iezksAeWTIvyiIkGxglbgdvlKyIdSjr+w/om93PDp8R22KYlrw2iYTkG0
	yO1LVAx1zPVUm7DKyRNcqnXq7oHQdAj9q32CmpMLdnl/FxswqRMiXW009jZbIWMJsdlyrnqMRYW
	6SCvHq5ek3WrvzjdewqD6ZyOnDJyYd4ZZQN2il4MAd6scgWNmgTEigg2YmhDh5WYeMALUHWZCF8
	sU34wlrQvoOtYcoOLANLe+AuMBWSu1uCB85vy/s5YK+krljiRlah43sfG1vEucWG2y9K38ZxZkh
	JT2tcpptR/M4boAtKhI8z0H96XgPSF1US1QgMJgguok0ub23mrtJvRKrE+UxpJWagw5+I7JguU0
	uZ+ksdR/KfEmJuTAad/REYnGKdsDePaIQczz0D13Oho6SjB59l6PyxIrZbaqKKJ8+gd3NPAgx3k
	YNWrMjeAPaP1HBJT4rJw==
X-Google-Smtp-Source: AGHT+IEg6aUY+0P7kqhINTv2xiPrN6T4RUVpHv5FGmHlhfMEaLbEGCK4acGBL7ICAZFqqzMOEyKd6w==
X-Received: by 2002:a05:600c:8216:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-4775ce20dcemr6765225e9.34.1762285082750;
        Tue, 04 Nov 2025 11:38:02 -0800 (PST)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce3ef38sm5549195e9.17.2025.11.04.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:38:02 -0800 (PST)
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Subject: [PATCH v3 2/4] nova-core: Fix capitalization of some comments
Date: Tue,  4 Nov 2025 20:37:49 +0100
Message-ID: <20251104193756.57726-2-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
References: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some comments that already existed didn't start with a capital
letter, this patch fixes that.

Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
---
 drivers/gpu/nova-core/firmware/fwsec.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 4f268fe09573..7d5203268313 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -35,7 +35,7 @@ struct FalconAppifHdrV1 {
     entry_size: u8,
     entry_count: u8,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifHdrV1 {}
 
 #[repr(C, packed)]
@@ -44,7 +44,7 @@ struct FalconAppifV1 {
     id: u32,
     dmem_base: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifV1 {}
 
 #[derive(Debug)]
@@ -68,7 +68,7 @@ struct FalconAppifDmemmapperV3 {
     ucode_cmd_mask1: u32,
     multi_tgt_tbl: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FalconAppifDmemmapperV3 {}
 // SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
 unsafe impl AsBytes for FalconAppifDmemmapperV3 {}
@@ -82,7 +82,7 @@ struct ReadVbios {
     size: u32,
     flags: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for ReadVbios {}
 // SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
 unsafe impl AsBytes for ReadVbios {}
@@ -96,7 +96,7 @@ struct FrtsRegion {
     size: u32,
     ftype: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FrtsRegion {}
 // SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
 unsafe impl AsBytes for FrtsRegion {}
@@ -108,7 +108,7 @@ struct FrtsCmd {
     read_vbios: ReadVbios,
     frts_region: FrtsRegion,
 }
-// SAFETY: any byte sequence is valid for this struct.
+// SAFETY: Any byte sequence is valid for this struct.
 unsafe impl FromBytes for FrtsCmd {}
 // SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
 unsafe impl AsBytes for FrtsCmd {}
-- 
2.51.2


