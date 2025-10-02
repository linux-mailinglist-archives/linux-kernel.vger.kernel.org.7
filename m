Return-Path: <linux-kernel+bounces-840068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C4EBB3740
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72903B0661
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EEB303A10;
	Thu,  2 Oct 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aY0CG/87"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827F3019A3
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397143; cv=none; b=WGHcXa+RXLQCeiR5drjlkVlp4Kp8MRr6rNc7YQpGVcxcUUCn3bxi3G1V/6e7JJnKypoxHYhY5lsWRJXtbAB/LxU0lgid3fCcRORNca4n+eUJGr5EPpVCDVifq6+H2oux6T9qa2sLLiumNkw5GhYBYwVk67XOnid9b4xhFf2ivcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397143; c=relaxed/simple;
	bh=Y/sByYoKKU8P6VEhlGTI2CFrOrUl7lTYvCLhcfpmKbU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jm8eX3JCaUXuKoNQaboznk7sd0oxVTClSq6/gG8fmw1Tuyk4BXYPsHtQC1++SvxZBFEjZCpAa+Dn/o0MNzGRZgO4SlO6KHEtmgJOPW3R1Rm6zbC7kgnPQUNnYAUVThTSQ1H42WMXwmI4G2g3MBOSQpSQ/8F4v4CI50jkRnkHuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aY0CG/87; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-634c01ca90fso1004329a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759397140; x=1760001940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+PlKBjPp5FZQsrsuboWKkHJmwPHYSdKJmwQAuUGMsyo=;
        b=aY0CG/87xB8DzxIDpx6e9BVeQ9Xv+Jm15LXtHyIbELbK2wE1dZhkmx5c8SGxpZeLex
         P1MIBrGqatUWqQ5w06c5UepdTQGQ/lxQwDm2X0IYw2em2tmYUOEIn9qjYjYvNQz9hX32
         LEiq+IuH2LUhD0Fld2NVuWuk1nWhccsWZviEI12L6Fk7dpwvuiuWJI67LQ7aukSTOX90
         tmj2K58Qfxjc5XJQGQFQDNxTOpGgWxjzg958l0GLsM/2U6O6Iq4SU1nXF5G7V6if2JfJ
         1lrz2tXAtvuN5kKRi/jfUffaEkk9NWgEfeNguTxZA6p8s+xbtYTNfusGDODdHd+3MHTR
         FQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397140; x=1760001940;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PlKBjPp5FZQsrsuboWKkHJmwPHYSdKJmwQAuUGMsyo=;
        b=KFXpVi1KKp+zKMlceiijuRtujNWW3SnEr3M5Bw15O/PK1rdc2pPVV7x2EK7DeNXGB1
         0Zx8ny1kiT+ylNsfn6kCWrQ5qVe6zXwLsfBil7qxJn2GM05tKZdz6mOYZ9+L37z/u3Ua
         eciOlfHxdgxdO/ZTKfSiQ+5u1cBhpgPIPCgRV2JAIlCpUY3DcWfg12DyVWZ1GHszrWns
         fIU1hK0idQxSMD1EoOOHvsWAIEO09enCsKDu1PS3G8Oua+2rraE7rWk5UPtmeMTb6Wgg
         6V3O8f8SifLx/d8rsN0q1XYjwa47E21aN+Upc3QbtY1R7GszG0pT+0Wlz9CjTTgA3nZl
         cTdA==
X-Forwarded-Encrypted: i=1; AJvYcCWXPeKXBnzyQyNLsLD0pLMbNGRVNJgPu0DAbp7fD1utkUlGzl+m9jAwirHUkmhlmliz6Xedo/fH+MhYq4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0b2jdoSVWB3jNDJB6TrhWBtkEAaJ/PFHy2vTLaoGNeX5/F6D
	UoVI8b5VHlWXpbuf5gv7XoAruCoeEHM+SvyaTzWhA9oc54Vc7pkjVPngl2lJxmHzFb1SUIFexY9
	Z4c8K6GWfVEymFQ4jLA==
X-Google-Smtp-Source: AGHT+IFiGvtpNZSrwRO1oSUnyWe726xnw67IN+IMEOYdKIx5jbLC4BCDdiTrVhfoJOfm48YNxn4U5EvL1e5e8Og=
X-Received: from edvh25.prod.google.com ([2002:aa7:de19:0:b0:634:a35b:1d11])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3550:b0:636:23c2:e62a with SMTP id 4fb4d7f45d1cf-63678bbadb7mr7786985a12.8.1759397139975;
 Thu, 02 Oct 2025 02:25:39 -0700 (PDT)
Date: Thu, 02 Oct 2025 09:25:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAhF3mgC/x2MQQqAIBAAvxJ7TlAppL4SHdLdai8qK0Qg/j3pO
 AwzFQoJU4F1qCD0cOEUO5hxgHAf8SLF2BmstrPR2irPEUlUkty1QuPD5AMuzjnoTRY6+f1/297 aB5h7vwNfAAAA
X-Change-Id: 20251002-binder-orphan-d1bc4bcd9777
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y/sByYoKKU8P6VEhlGTI2CFrOrUl7lTYvCLhcfpmKbU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo3kUOSfHZdu3RAzK3I4whCF46XkLRZdNE1E4zZ
 QPtpUVdan+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaN5FDgAKCRAEWL7uWMY5
 RlBREACqkYCmD4YESGpf5vez0GLEW1YzAzFEkMkxKRtdI6u5RCnsJTrbbV8qe30vPjl7OdOVuzA
 Kie4gt4LRHFL1uDdgmMF2BvKzt2SFnh2lV/StYzIz4Wmv2GkJcwmlaTegzPyO8GW5ZE76MePx79
 2E8SDD6c7zXo1JycdoCcY+IkiB7bq9/fi2GAbM+e7esMKEjC8IYIWlw3jxihpRQ6xQtnXtdRL3g
 sxSs9TbGF4WGQKbG6JBLwuzp/cRnmcMSlDP0JwwxVj4Y/XL3iMZCkZEdBgsWvlfI1qnUjBznuZS
 ATUTQVoeL4dzztcpJjUF0EEvsfNG3/wKSPM3X8xHORwTm77y8/Bn13x3uQLRtZXwBpgws0LiMJt
 rTODhfGire8OF1tJk5++2ooPTGv6xN5008gwju1BLQCktH5tJJhBwqCzZje4LbRWrk/1si7ioUo
 tWp9x3u2rBugnnLkk3NURHQKMN6fE80uTuH7ztXXZ96pyxznZ0UbZN9zYnEotEIsqVLEj/t/mH4
 fVecemOuVFz2i7HXY4EHlhoUvrE/S8IDr2sRebwUC0iYnrg+QbRgIW5k93VhSSoYkFJcKP2PNb5
 iDZ2+f1xzCjMxcLzT0gqOuurge0nzZekW5xynTFOjNSSqWTNaiu6ABsrS/Wbc0KybmOK6IkKdnQ YOSmA3QFf23oYWg==
X-Mailer: b4 0.14.2
Message-ID: <20251002-binder-orphan-v1-1-cdc4cffff992@google.com>
Subject: [PATCH] rust_binder: remove warning about orphan mappings
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This condition occurs if a thread dies while processing a transaction.
We should not print anything in this scenario.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..d8c3c1ae740e0eb3bcc8aa5e7faf4291f1cb69c9 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1346,10 +1346,6 @@ fn deferred_release(self: Arc<Self>) {
                 .alloc
                 .take_for_each(|offset, size, debug_id, odata| {
                     let ptr = offset + address;
-                    pr_warn!(
-                        "{}: removing orphan mapping {offset}:{size}\n",
-                        self.pid_in_current_ns()
-                    );
                     let mut alloc =
                         Allocation::new(self.clone(), debug_id, offset, size, ptr, false);
                     if let Some(data) = odata {

---
base-commit: eafedbc7c050c44744fbdf80bdf3315e860b7513
change-id: 20251002-binder-orphan-d1bc4bcd9777

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


