Return-Path: <linux-kernel+bounces-875915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A281C1A1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41A6403AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216E33859A;
	Wed, 29 Oct 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u35cEB6K"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE13376A3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738674; cv=none; b=Xjhs444VqGWwinbuvne6x56IMMkV32Ma5k+7Z8kGzm9KaOoeWviO2Yo+GVWjXyVBWJpf2bVNy3zY2a9MPFmasR6NfwOtXqlfKOcpXYhX4nWkJNMBk9Xy1l0tdKYGa6YCAYjylfXfUZwiXZRhYTnQBEOArEagP/AjkzkJ72NJEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738674; c=relaxed/simple;
	bh=B8ftc5m+Zx4NqRnN3ISF7R2X5LgtjQfowgPyiLC8Mv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S/xzjQsUcYUcDwFPulbepeVbSKpzRCBtDZni8Xyp6BSGDoWhGpZmZt3i+iTJZBE7fFsmEOoG3bqW84kxnTy2X3DZPxcpn/9y97ZJRF9ZpqSQFGENnZE1gL5KBEiEyjHv9igo9YIXvpIoZeJ4zZuBkFEWpaRnBrvjkS+1+QEFgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u35cEB6K; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475de1afec6so2343725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761738670; x=1762343470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zJBte9qL2F5esy8PjX1qFQqZ0U8KWh6KuSrYtDXvXAk=;
        b=u35cEB6KH1ByQYznvOmFuFM1wWxG4RkDHI69ARWelb5r5GSzUHc935pSQWmz0X/nc2
         rqrwByGt1R6Avth0jooVk2znrewC2qNQbP+vePEsVJeRGNmMf984sEnZklj/5ujtXMZv
         pf5zFBb7YLuepMUNFDEXPhkFecUJggzjBO0djcKkvYEFOGQTuA0KBzPj3RYqYGObKfjj
         Om60cNTaplUcYRKkrNqa0GtZUlMZQ/fCu2lvg56arSFEu1Whr7pkStNLm4ayktQUt9T3
         YIzpiOtRa0OgGOP0G56a60TJIHm4hTRgMT3jP3to/Kb6bPVNWu5uvG1OtfY+L6b+UzEy
         fHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761738670; x=1762343470;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJBte9qL2F5esy8PjX1qFQqZ0U8KWh6KuSrYtDXvXAk=;
        b=hTjdpPE+lutE7l8GjVcemOh+PqGdzAc9vbXE8o7/6hOiZioDPCCIHgealbdrOF2XbN
         dHO6dA96Mb2t33MLvE3Iy4wQpSS7FDCb368fUZbk484IA+gu+CeiUNsGuPtHlS2r+y6m
         9HP+IF1Qpy4Li+VXVhrSAA+peQeuMiJoeTyJQTBn+UzlRsRhojYCwR+55w1RCndkMrun
         7pO14xIGQ2/ev/+L+8uQwxrXppCT8AyxXB20bbKgqmCY5WfRsP5X/ksjZ91/Dp6d7lOZ
         nCETnv7dOkDpEXpu9FOFsdjXxrPoa7elP1a+mEXKoHSCYmk5VVxJ1CcobihkSOZJkIgU
         ivPw==
X-Forwarded-Encrypted: i=1; AJvYcCUeprTGEWDr/Late7CfB5abLp0BXZY3Nkqlveho+0rI2iabqGs58v83by80P9FWrASECLI4Am3LzVBuGu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIFrnSDvSa8NCUNO85NgEmqrKxJ2RsLbA3XdK2nLAUhfraLNa
	WMydGxuvEeQxL6Cy7NGgLhdy90kkQ7lmcDtt7GDU4VWQRq3jx14mNJcgiYxL7GQ9T9TBSaURtsd
	MWH0QCgePcy6yCqQEQQ==
X-Google-Smtp-Source: AGHT+IEzf5DD/ZRDP11ls1+sFcSAz2cd265PwvZLISiIYrx/8qfvp7AvDnt2fHl6SuXE/oHiYPwAdnca/cPmAbM=
X-Received: from wmdv22.prod.google.com ([2002:a05:600c:12d6:b0:477:d88:1a31])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e4c:b0:46f:a8fd:c0dc with SMTP id 5b1f17b1804b1-4771e5db04emr26052395e9.3.1761738669830;
 Wed, 29 Oct 2025 04:51:09 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:50:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKH/AWkC/x3MQQqDMBBG4avIrDuQTFGpV5EumvjHzibKpBVBv
 LvB5Vt876ACUxQamoMMmxZdcg3/aCh+P3kG61SbxEnrnbw4aJ5gHGIyIPwTL+uvGn620ndO+gj vqerVkHS/z+P7PC9hgd1JaQAAAA==
X-Change-Id: 20251029-binder-bcfreebuf-option-35276027ce11
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B8ftc5m+Zx4NqRnN3ISF7R2X5LgtjQfowgPyiLC8Mv4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAf+j/0TpHWgX3C0dn1iRCIlDpudV75Wgg54qQ
 A7LO685EO+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQH/owAKCRAEWL7uWMY5
 RpSeD/4i9RElIid/eJ+RJvAgLnEgcdvR/dRGlPZLzTbgS3GKXRW5FPl8MDpliRncatVYADLLnAT
 qUc7fjegkgAl6hWBK4iTHve4ErgA+PVcURZbccW7a1Y3+EPGik1keGcRAB4cMuYqrP3wfZdE3M+
 0Sp4gyaD8zVa2oSqSeNknec7qX5Z/9RhlVCs8U1h8GhA2PLRC6nKr5HXwfKrPxFWXTn7KWZo9Tu
 6+3rn4O0T7qb6acCrxdD2P0kFInGYIHMISV2HFYOQdj8bWiTX4jNciTxZdInCwwqt925I4KUol9
 xtsUPku+Ss84vgZu5j+HcEkmfaqwvvuMIa+yYclFByrpF7gD4f+ZYIKmyDOTvGJJe7iTrZAfqcv
 v7kQRL0za3UH0Rczkwt6Z3soaVeTC9HnuARaZgJbBnyn+mZO/UxAsh+L/sEah1SPFV5LgoTnZbg
 c7/2ET3eK9+1Llof/mIQBEHu2KJ0/xJSRd6AWrM+s0ynXsZx22iKJWHg1xRDfMPLIQqE2X6vfQd
 0w4dCq2tLP+v76HIuenbN8xay1TrozIZiDShI55X0lSKypc24qXop/zcapcpsC/Ai69fOP3peYj
 WDGsPrIZfHsBdGuqCLb9BH1gAt+6/0hCX2a6x8sMT4F3zQMtMdJX+PzlTd9tZS1jFGnbjWSlS9x K59UrCoZSzaW7mA==
X-Mailer: b4 0.14.2
Message-ID: <20251029-binder-bcfreebuf-option-v1-1-4d282be0439f@google.com>
Subject: [PATCH] rust_binder: move BC_FREE_BUFFER drop inside if statement
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When looking at flamegraphs, there is a pretty large entry for the
function call drop_in_place::<Option<Allocation>> which in turn calls
drop_in_place::<Allocation>. Combined with the looper_need_return
condition, this means that the generated code looks like this:

	if let Some(buffer) = buffer {
	    if buffer.looper_need_return_on_free() {
	        self.inner.lock().looper_need_return = true;
	    }
	}
	drop_in_place::<Option<Allocation>>() { // not inlined
	    if let Some(buffer) = buffer {
	    	drop_in_place::<Allocation>(buffer);
	    }
	}

This kind of situation where you check X and then check X again is
normally optimized into a single condition, but in this case due to the
non-inlined function call to drop_in_place::<Option<Allocation>>, that
optimization does not happen.

Furthermore, the drop_in_place::<Allocation> call is only two-thirds of
the drop_in_place::<Option<Allocation>> call in the flamegraph. This
indicates that this double condition is not performing well. Also, last
time I looked at Binder perf, I remember finding that the destructor of
Allocation was involved with many branch mispredictions.

Thus, change this code to look like this:

	if let Some(buffer) = buffer {
	    if buffer.looper_need_return_on_free() {
	        self.inner.lock().looper_need_return = true;
	    }
	    drop_in_place::<Allocation>(buffer);
	}

by dropping the Allocation directly. Flamegraphs confirm that the
drop_in_place::<Option<Allocation>> call disappears from this change.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 7e34ccd394f8049bab88562ffb4601739aea670a..1a8e6fdc0dc42369ee078e720aa02b2554fb7332 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1323,12 +1323,12 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
                 }
                 BC_FREE_BUFFER => {
                     let buffer = self.process.buffer_get(reader.read()?);
-                    if let Some(buffer) = &buffer {
+                    if let Some(buffer) = buffer {
                         if buffer.looper_need_return_on_free() {
                             self.inner.lock().looper_need_return = true;
                         }
+                        drop(buffer);
                     }
-                    drop(buffer);
                 }
                 BC_INCREFS => {
                     self.process

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251029-binder-bcfreebuf-option-35276027ce11

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


