Return-Path: <linux-kernel+bounces-895608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5AC4E794
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA80B189C586
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E6312819;
	Tue, 11 Nov 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR/qB5YW"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E482F8BFC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871028; cv=none; b=VZvR64p0OS0PfqbbhUPMdABxFF1X/WBKFBKrHBhwDLj134k2RhfqFu09OKDxh3GlCcnbnOwYXBDeR3hPa0dJRhGrGnEcRk4Ve+ZhsN2YdlaJigi2LGv3Z6JbPWa2NclDOx1oJ+2ZlI1zYLOcLi43mUdlkK3zmOq/4lbc2f8+nWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871028; c=relaxed/simple;
	bh=KAyxsyVI7rxJC2+bw+Vkk3KiDJtx/3PPEIACBwdvs08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUOTaaDtKM0EjJk89r/bycM+qHSohB4b37qrNgIFoLuCqQxvsMuVxAit3FElW428tuTOIzKNyYK2/IKmBRSvc8HV2J1s+JIx0mYzbSO2sjzHpi3z+hCUBC6HAbFsB2N2Cb5XggyNnF9uSIvXXrK4Mx/n//3JdndB5xIFE4+Gm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IR/qB5YW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4774836c376so22727425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762871025; x=1763475825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=znJZRiHsP/Uc78N1GNR0aqP0S6GuH1W4uou2Y4GH7sg=;
        b=IR/qB5YWfWFZj2yzX+PKlQ50KjHfHWfZW62nidZJ/FzNWU8G0Zu3dqe3Duz1O4tIjt
         tSFQYsFx9vsiX1GuychT7mjkQnbPhzjv62K6y/vGHr0cIVngv/Lb9UrT/bWGhL4ACm5D
         FJiN4HIKe16QXPZVT6BY6EQJxL35DZCiKKC1XRJC05gyiVESTNh+Y68b2L/nwCm34aFm
         wkb8zCU9YMiqMxsHgGvx9LywhhHZ7Tm/R3ORqCpRrBmyfXMQY5IUbiDIRGitc5zZWvof
         GXpgOYIMbOO6pBWI9TGslFH9WH7lYit37EHC0naQ91eTO6qWeQ/65lm1y4DMqdVLg3re
         mWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871025; x=1763475825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znJZRiHsP/Uc78N1GNR0aqP0S6GuH1W4uou2Y4GH7sg=;
        b=L9TcnW01RAu09jeQyyUuvLpmmwRVu4R2Xuigt98Zd/qSiB7hCUaEMjE0Q3kCmdq6Na
         wsr8StpTKPP1NhMPi/MaZQnshVmigNjCeTJ+BjG81nIsHovnLGi6Uz9qpfcsddxY+8MA
         nMTm90se1CQRnk4ooDuxqOmGyNymNXEMsvt/OdAfsXzRzYmevK88s5P11ON9hy932xRW
         K/hdI83fDYTSM/DSPfGICnnOmQN8X6DcX83wGbkjf6l52uD1eHaqluPGubaORGSyhNkL
         TKT2U2+eMsM00u8L6fT2ZTpJg1jR2H6yaPV70n8BJsWNxJFzcfJI7t7HE90jCb4vaB0Q
         i40g==
X-Forwarded-Encrypted: i=1; AJvYcCX+mFIi36D74MG2I45qP3rGhpsl/yc5KVq9MJ/FL/iSD7zsdMRXY9XLpMWIETe615eZz4MhstGP1/vVo4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf17TAsFbaG+ubTRLHq8vmdtWjWeENq0AYFskn5lAmWYg6jX6
	LiYZHbZmqEpERHq79a1++BxLsTFwLF2t2frd8fF9webd1b/SxQs0R20hdzNoX8PMI+2EB+QXN/Y
	iu3j+ebs8A3JGZZDpbw==
X-Google-Smtp-Source: AGHT+IE2YmYheg20DfmC1cGFkXFjFdLpncEwyzBzXL0yvogGpbwF2wMENRkrYHUukkMid2IGCnveYW66GtA9q1s=
X-Received: from wmbg20.prod.google.com ([2002:a05:600c:a414:b0:45b:6337:ab6b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e93:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-47773239bf6mr104388655e9.9.1762871025621;
 Tue, 11 Nov 2025 06:23:45 -0800 (PST)
Date: Tue, 11 Nov 2025 14:23:33 +0000
In-Reply-To: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KAyxsyVI7rxJC2+bw+Vkk3KiDJtx/3PPEIACBwdvs08=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpE0btsQOvyXOMphFoNMnE1zWIjHLFNk4HQtKLB
 xWbRNwxiiSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRNG7QAKCRAEWL7uWMY5
 RuLJEACYEPvUcRF3T1OInJJZySTefUw1TIPsMSCcg7akYeqo4O1alQT8lffTaD/aOXucqHpWvpy
 M5kPdgcis/U2vsM7ea05d84aqkGfkZySok89V+SdzaX7lSx4g0ZSk4/QX6SquE3zDRYwwgfA1Mm
 MyegWBJmCen/spY6nsvLClGIhrdZlgfb9r4w9ZTTSLviJBG7o4eOuJTQpZ2H/xeKTmDQZNIQCml
 /k3bMWdR9fElvjhzwCKu3OlGfKq06gQWq6cs9ZacadPt0DOhCdRlInTfoqLc0z1Sb17mzbNHcq+
 28JihF0xoVpMLeaybvzXTJ8Y3V+shKRR96hCFnM6HZ2KXe7BCbByFqQU3K5q+8yL0Tvq8AjAR23
 0n5MC6pKM2eZKoJfJKePK0UiKxQVmiUInEwSjFB6g1sfMmy27tgwAPVemMrVsVL57h3k+EQO6Zz
 qUy5cOX+etGKnOhcUhE9Vi9X8WETcVX8xMlcH5ds8uFOmg+6xCADH1vUEbxlgjEi1UcEbkC9vTu
 Xo+gInJlMrBlaBUWDBE2VyDhnK3/QwHv08UF+QXZAdjEwmNGQbQ8Egw78MDIY++x61P5qH9CPNx
 5MP7qMLiGGqiT/ItQvE3k63P8MRf40qUEiU2yBkM588vzcvbCe5O9UqSP3pTY16bAa1t9HiapbF LX9LgkuB4/OcXIA==
X-Mailer: b4 0.14.2
Message-ID: <20251111-binder-fix-list-remove-v1-2-8ed14a0da63d@google.com>
Subject: [PATCH 2/3] rust_binder: avoid mem::take on delivered_deaths
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

Similar to the previous commit, List::remove is used on
delivered_deaths, so do not use mem::take on it as that may result in
violations of the List::remove safety requirements.

I don't think this particular case can be triggered because it requires
fd close to run in parallel with an ioctl on the same fd. But let's not
tempt fate.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..022f554bb049280126fdaf636dc7a41dd02c535e 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1335,8 +1335,12 @@ fn deferred_release(self: Arc<Self>) {
             work.into_arc().cancel();
         }
 
-        let delivered_deaths = take(&mut self.inner.lock().delivered_deaths);
-        drop(delivered_deaths);
+        // Clear delivered_deaths list.
+        //
+        // Scope ensures that MutexGuard is dropped while executing the body.
+        while let Some(delivered_death) = { self.inner.lock().delivered_deaths.pop_front() } {
+            drop(delivered_death);
+        }
 
         // Free any resources kept alive by allocated buffers.
         let omapping = self.inner.lock().mapping.take();

-- 
2.51.2.1041.gc1ab5b90ca-goog


