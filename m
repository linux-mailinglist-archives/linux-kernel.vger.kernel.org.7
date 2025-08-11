Return-Path: <linux-kernel+bounces-762571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE4B2088B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7317EA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0902D3A63;
	Mon, 11 Aug 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdyMxZF7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04462D3233
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914492; cv=none; b=klhiHPcIweSOH3NNL6YEL3QbwKJ3CUBjLId5UvOVUBGeR/kj/jhMDFTZJ87lx2oj/FfFPfWQkd4IZCYoyifykBsYQ97aWeoi/RUD2nhHAE155hLJzVDh8okC5LkdQOvaIDagJSLA0J0BRY019x30kNPvqGY5HCcGwC+ba1OMlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914492; c=relaxed/simple;
	bh=qqCr/4gDVS3NsvAL73WpOmWJdMo7mPjB6jMNNSC4EvA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=plDCV7oMG34bQkjoq17pzxFIoXCqRk2K/dL8FHMZLfHylJ2My3VZItkVt+JIOJdMXExQmNxGX3O90qeGr5tccgS1/3o64m0jwxevfVHIIISUx//e1W3qxFOYp/6eD8PDZD/8/vx47632J+vY1HJFPm1WBMtYZA5vLYBcIPsvP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdyMxZF7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459e4b85895so25377545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754914489; x=1755519289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zIr2K+//WU5goaIhZNaZHgeubyRmDPFT00OzR6uRZtg=;
        b=RdyMxZF7a3RakLdMneEtPHddo2usSyjBHsP53UVrnzBnTcKuLfnxMcrXvpu6P4o+j8
         M6ku+DZZigc1N7tQPuMB/pGnYr/u6RiWUHqZn0WNiaC65LxS2e0lad69Kqeb3q6X7Tab
         AsUbC2DG8Zcrhog39n+kTfe20tayOEZlW2X3SDSBPvIoGvpUvJQFK2vHIY34aSEgJgo1
         DuxyODI/R/i9ev2RML+GOhBoqm43TQDidXOM/+ACFNUJQGY8tM5xeFLPnar+Tz+XBiMV
         u+stUVTJi6aMrPr2BzG82qxJ+CEUqMj83f02u10KfRBH/9gQE3QXDrBXGgTkK9J5NZCe
         +OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914489; x=1755519289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIr2K+//WU5goaIhZNaZHgeubyRmDPFT00OzR6uRZtg=;
        b=W5IdsCteIll9v1V69T9mFCNP+k+QSy2luBZadbPY8IAzIUgvdLp0VrobNCkzIHD2Ya
         yCPBqcGt9liBiTo5AtpCqYYJ+IbjgH1sFh8CIWbvzzQcZYlq9MhB+c0L1QklRFjD5g+S
         LGEZK31GWckAVPcGYGvy65VDgrHdvqZUBbONakSR7fHK1bYjGvAkim6qskY6/8NyQdqo
         U79w9e0VJ96YdBpAsFNgIi4ThnXej+ykVQol3yvnOB7DixLoKg+LsuhDKTviPyGHjnob
         SnYxn+9mCIrKmnGXy14hCmxLPznLGw4ggafmrcj7PAnBFIDMOIZh/kMyvKYODXSiZjNu
         5K2g==
X-Forwarded-Encrypted: i=1; AJvYcCUYp36TyskZidSsUFyAUqspZw6pYNWW+PTOstUoSNSgCli7ze3XUQc6xO3ke3tjuhCeeajnK3vj4XVs1CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIfjAT8LEwzPhKwPzIOoSQ7ekguxbTxM7CjMA9YwvChHb8zfd
	9x7AyF8T9QD5ljX+pAbZwfVA3Z9lAsTMDRD+ZRGdKK0IdLnQ+rse4wr1K8vzu2dlrrFsgKjOLLC
	w7+mY54lQ+1kUeduoKQ==
X-Google-Smtp-Source: AGHT+IFku+9NashTyu6q4xo3uHwb34BMI4PZZmGXsRUoiGjYrVfm/03l1m/DEaQAjd7uGW9sPZtUHjkL89RtUgU=
X-Received: from wmbdv14.prod.google.com ([2002:a05:600c:620e:b0:458:ba61:fc2e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3542:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-459f4f1267dmr88011875e9.21.1754914489058;
 Mon, 11 Aug 2025 05:14:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:14:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALDemWgC/4XNSw6CMBCA4auQrq3pw2J15T2Mi2kZoAEpabWRE
 O5uYaUL427+SeabmUQMDiM5FzMJmFx0fsghdwWxLQwNUlflJoIJxY5C0t7bjtoeYqQdTnlCGJ4
 jBWmgVtJwIYHk4zFg7V4bfL3lbl18+DBtfxJft3/JxCmjWtWgWGm0hcOl8b7pcW/9naxmEp+O/ umI7EDFhNHMlifkX86yLG+q2KDfBQEAAA==
X-Change-Id: 20250723-lock-class-key-cleanup-a3baf53b123a
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qqCr/4gDVS3NsvAL73WpOmWJdMo7mPjB6jMNNSC4EvA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomd6zzPPCqnG1mZcdD9+jHvxV0unNd/zRf05dt
 SWnJ9EtVUeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJneswAKCRAEWL7uWMY5
 RozMD/4s9oPArNknhAHMW8L0duBDsbQAuCnJjiPXL/R8xJM9AbNKaXSNo318Supmc82cOAvOzc6
 jRMZ3AE44v6iqXLyTkT4hoDcmIHLWGntn8kZHW8ZY+a9Mc4/IpS9l2coIPAlDngB0US0zuWogtY
 CmxXI4LmRpnoim6bro1cD0QyKaapO4pGCknszOwO6pob1A96a3CwrNCrIGF0ya11Pwwq2Ny2cxk
 z+MdgLmr/0/ACY6zUIJr1Ug4EkG0WZtSGifuJrdx1/NBjqubgsP2vpsF7EwIXosr3pFBhpewDKB
 ln3UlXXeyLDGjb9eP++imntQ7/j8E9PHpUFrEk3QMzFttcaXBsYQ1/jsGicsqbWStC7C2QEHv8K
 KLBGbaeG9IvVy22zLxFrwzxQaHNLuDxgFqiCYeoI9QsptZOP9YNTQX+ZDnYkq7YsyoaX6jb1rOt
 NQ+rEXMdZDAfSz3pung4bqfdndCSSx62rsx2GQPwgN0CDF22E1i1tInG6DRWHpazu2pWIjh+IVG
 3GXBsMEcRltT5I8pwnFADAU8b2/cbINOwYXJqawPTIeCQEYPKtGaTHPRdcJmZbZvbMhnyfeitDI
 vPzvZAgIgzMWsgf4HfJv8i29SvRNr1+CcWjwNGNXqJqCwSqmuYHu4wWG5Q3c17PW8CkAUX9j4w0 Ql05UxpO7DEFo/A==
X-Mailer: b4 0.14.2
Message-ID: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
Subject: [PATCH v3 0/2] Clean up Rust LockClassKey
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This series applies the suggestion from Benno [1] and various other
improvements I found when looking over the LockClassKey implementation.

Based on rust-next.

[1]: https://lore.kernel.org/all/DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Fix duplicated "require" in commit message.
- Mention pinning in macro safety comment.
- Rebase on v6.17-rc1.
- Link to v2: https://lore.kernel.org/r/20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com

Changes in v2:
- Change safety comment to require a static object. Adjust commit
  message accordingly.
- Add Reviewed-by.
- Link to v1: https://lore.kernel.org/r/20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com

---
Alice Ryhl (2):
      rust: sync: refactor static_lock_class!() macro
      rust: sync: clean up LockClassKey and its docs

 rust/kernel/sync.rs | 78 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 20 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250723-lock-class-key-cleanup-a3baf53b123a

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


