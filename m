Return-Path: <linux-kernel+bounces-764209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D572FB21FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3703A597B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE32DEA62;
	Tue, 12 Aug 2025 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxmzYe5r"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4C236453;
	Tue, 12 Aug 2025 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985119; cv=none; b=FZ77sgRR9mklxwtufzHDhKYeBXVPfNAob8TYTBZEtAQyY7oRYAPJCJfqqR0pDddZf6yFtMZPyUqHnXBh0QRUArKr2BRm5qZ/6WfO5eRXvgPBXj/+apHkzFoTmKoHNh7/bOQ4UmIO5o+fCjPeTu+zngJGEmpf6jycY9wTdwZGZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985119; c=relaxed/simple;
	bh=phZpDc7ju1QlkGTNxkBGt03Xb2i2DqS7FO4J6ysqfKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EIdp8vZ6v3/jsp7j0OoKheQp9FFo1pWGa9Cqglko+icUeqIXOzkSbnKqYiapNYhx2nh9n8SuwHiRMjVVe1x0/Bqy7jII4QEBpCndBr9Jc0vKJX4qDuXZZgCSCi/Ko/oDLaUbEzQu/Ea3d4/2iBmzsczBRR4cjGS8SbeJ0y14mLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxmzYe5r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bde897110so4217956b3a.3;
        Tue, 12 Aug 2025 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985117; x=1755589917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssd3QI2K8lLXmGmj22IiEBaqBpIpquF1/7Gw/e0THnw=;
        b=dxmzYe5rcbG9TjjcYlL3ns+xN/BxiGfIMExTcBjPlMzzmSJoHedSu6gyCZT2J/RpNT
         Eoek4qNhdu5/Vl/FSZwTHHt4kdJTCyJwuYHEnez6y8/E8FGJd/dQjibIQTbtiY7zvfIq
         IF0aSHZ/Q1RgroKL4qm9piNwcYZpXT2FukkLkXChZym8TzEtfrzbLwlXvGMQ9Es5feAT
         Ux4QyUPCfrRu+hrgamVw1QDnAQ4yxxvJ9kur4VOimvU/jAlMxs49fh7v3henMqmmMK7E
         edZK9rauoqidqHNqP98GSW8btTGpj3ATOWKn+FsSK4ICFqNJSjoUb4jocy5DurN2CHK3
         MacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985117; x=1755589917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssd3QI2K8lLXmGmj22IiEBaqBpIpquF1/7Gw/e0THnw=;
        b=euYvo77+L+g1sCF0bneVpyfNqIn8gISLkI9FV5ZwAT/xpluWBYoSgly6utl8RTr0oi
         SOoY4+kglh2eoE3t3bQopX2rgn5pFgJ8/Gq5EU8Exoz4+/xTJOX4H2T7Hzf/ztoYwja/
         E1Y8+M1GRvhBQuqPm2aENAP9O4tWyVN7IuAUX6yEKOs/ni53+3WGMx/Sy9O9ZVjatLi7
         1k8KIKvakh32Jc1Na79q6Uxt1FJscXDUrspsoYS7CCcm4C1aiCG+o1DxcDqKxvF7gADg
         TDpa+C2puUxKWp608jlaUUoKoVVWb1u6gSt3Za243vQvjXuKfFH+A9h79+l8TQNv53Xj
         Rbsw==
X-Forwarded-Encrypted: i=1; AJvYcCWST3uhICwguREfJ+K2I5PzPmO/AsJ0vzwmahIRHszYRTnTAbkOTGdHBRLDYNLQH95TzQQi8sRUhgG6aPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWmTFvN6MMD8zS7Byf+Vnr9oqXR7y7rekw4/wHbKBXfP9Vf7h
	KMxDhW4pCMKtroueip+cHDHHznjZ4akIxLt99FoCBwtUIN6dbUPVRCln
X-Gm-Gg: ASbGncttlk0SDIgWJ2Dp3spWUdj34uWw09vx8GA0GBMRkaozY3xE7Ki9Oyl4xD0crTc
	SSzctO4tmv35uNB18BddmOSuMtx3C8gkk1kRdGt397L49DFhtXPVZZG75/q1ybi4oFBx6WO/AFR
	CNrLz3VTbf+tnV6/GhCMPdt21RgkPIzfTEsSX67U+PHdNUshhM7rit+bue8bsboy2wsmr2moO7B
	VkpuAoHBSK2XpVxFIE0s0CmxY+rU5l8EeVBaoLSas3kDV76l9JNnOOOTKJVc07pz7SOwnmsAG3o
	wToVpQ3gnOwOn5iL0QOOsvr864wqCbIpUgkj0QtHz3uCAQ9HXX2Pb194bRf6TWisiwKygLEW9r+
	1UXhkP3IBKhTVlBRSGGdfjQ==
X-Google-Smtp-Source: AGHT+IFQNsZYu1he+9Z29jrZ1MgWPZ6yenuPry5EF1sVuEF343v5GMjbxzchN5Wt7yRwvz+nPm7o6A==
X-Received: by 2002:a05:6a00:23d2:b0:76b:c557:b945 with SMTP id d2e1a72fcca58-76c461f7dfcmr22903859b3a.24.1754985117294;
        Tue, 12 Aug 2025 00:51:57 -0700 (PDT)
Received: from pop-os.. ([115.245.251.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c613cb7adsm7781491b3a.38.2025.08.12.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:51:56 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
Date: Tue, 12 Aug 2025 13:21:10 +0530
Message-Id: <20250812075109.4099-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update auxiliary FFI callback signatures to reference the `c_` types
provided by the kernel prelude, rather than accessing them via
`kernel::ffi::`.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 rust/kernel/auxiliary.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..030e31333689 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -56,7 +56,7 @@ impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
         // `struct auxiliary_device`.
         //
-- 
2.34.1


