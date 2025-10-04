Return-Path: <linux-kernel+bounces-842011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEA0BB8C53
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629E44E7C72
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE126E173;
	Sat,  4 Oct 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0+GOVzS"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BD186284
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572494; cv=none; b=D31qrvhyb4XDeO+7oErV10dKgpVTEkQAKnEZ21SnxoDxYCGb4iJlenaU82LptM6g6j4UvAp8iFTMANF+0goYFZBatCcE9qXc/lCddqZ5vWRBTBU+NaV/6AhbT8fs7vNwo/x12Du0j18Srk5U/Lx+W4Ui6VIVgmd1+/Pq+VV91RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572494; c=relaxed/simple;
	bh=rxYAtyid3LYmOuRl8wpk1tM7TAKIizNZVXtfQcpHRYQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DV/t5Y6I5vUUOzkLV5+rqAB2g7wAa7U7WK2d3ropdt7bu6ripXfHPyFutyu1nHIVlyqNELasV5tZbxbE8+RVuH4MBKy8ci2rd6SIZA8Jopc1fw0FMbkg+P+pVbIikcOg+LaC/kB8xiGulIayRT5v08NLQHaRWb80VcKhgYYzTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0+GOVzS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so16442625e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759572488; x=1760177288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WVIuvVBnzwKoCzO6yMXyafp9Rc9VJ6OOswjgWIjSnTc=;
        b=a0+GOVzSSNtewBME3QXxG+uZSZrcbaxV2iDJ12EowpS4cOjs1/omDLh/syaM8NWmAe
         v87Xqs+2X0U5hfaBJkIl+0ioUKcKPzwZL/UKXu7V/HrczeyFXsSIxk/Fqk0uinBa9xsK
         Ep8Ww2IHqexMLF5ZyiLgTeX5JsJn1dDaBD58N56v6EIDX7J9xSMWXQNDiPBeEwfWksDg
         u16E09GY//2mYnpuJYCnf/3AfJkDsPOIO3nk991hExNd/M7nG0ck14EnBtC6bhVlKyPV
         3JulD4nJ+fp2M9azQ0fUXig7RIl9cZQl7yaYv1CgfxTpsArckZYusNPYvxm6P8iPJYRv
         TVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759572488; x=1760177288;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVIuvVBnzwKoCzO6yMXyafp9Rc9VJ6OOswjgWIjSnTc=;
        b=acV97i9KTnR4cxJOPoJ0jr53FLT9EEBGqDestb4l6njfBgzUNDVOtRAITVvHAnfXGI
         APyxmkxj1v3YQBLHRtEQ4eORqQXAEna6RPxZcF0YadRJrLWknyFQUyMAFc/5I19KUo/C
         yAyUGfVZ0VEADuNhS0D11f3pOzwtcX9IPelD9Ft+ppWLX3/zkAbKVu0ig7LoDAWaiWsf
         F1JFbocG2Qg3h3D+/lrpdCeo2X9g5JHXngaMLVNdaX3Nm6qm0+iFlXnBl797tPshg+sg
         nxnZru8+h2nf8bN2/yxxgeMrIYmmmd9WLyXfDLZqnC/rya+WkRsB3PXuTR1b0sKjWWSR
         Ebgg==
X-Forwarded-Encrypted: i=1; AJvYcCUjSx7zBVxzC+CYnoi4gCkw3aPnvDr5u/JHPFPMmodf80qxGRoEchf2WUlvOs8i5q9WbE/CSFOYUjzAB0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBLBf5hUu5aAQEUfpgfEyg6qg6opM6Yhp/vZ4Lk3YRAiY/E3b
	W201Om9rXNdYHct1u/ww4P+M6LkTF20SZF1Nka1rCrPjSjzIkzHMlRjU8zHTHlELtD5hWSyndkh
	I5YxLxHdLW+YSC+BCEA==
X-Google-Smtp-Source: AGHT+IEcB48GqwbX4Yyi2l+MC2gYcLLuDnsEZsDjgz/TdiIQIi6gPeCZjrFd92e9KCaZ+pGhUA8Tzj7qdCbI4mc=
X-Received: from wmbc10.prod.google.com ([2002:a7b:c00a:0:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:41d2:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-46e68bb076bmr41864985e9.7.1759572488510;
 Sat, 04 Oct 2025 03:08:08 -0700 (PDT)
Date: Sat, 04 Oct 2025 10:07:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPzx4GgC/x3MQQqAIBBG4avErBPMirCrRIvS35qNxQgRSXdPW
 n6L9zIlCCPRWGUSXJz4iAVNXZHbl7hBsS8mo03faG3UytFDVBDggQrWwrTedcMaqDSnIPD9/6b 5fT8QEhJwXwAAAA==
X-Change-Id: 20251002-binder-freeze-f99e23dc47bf
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=534; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rxYAtyid3LYmOuRl8wpk1tM7TAKIizNZVXtfQcpHRYQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo4PIBT67b7BxScAKiQhafihtYQUUED5EVCH7EP
 PiggT5hJpuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaODyAQAKCRAEWL7uWMY5
 Rs+CD/9nmkSRWMoREYRSHmP5AmsU8YfHiV2zBzDHqMTuHpudo8MX/Nxv8xm0AfEw/ORGAWFV4kf
 qey2abwbhL3nwGpSFGLLLuatnJrTVfKDooWfDRJ65bsIYAZRhOw73+3iU0gM/QSLjJmCqWVdE8V
 eW2388xDvJSeuLBmgoronzSRk5vDzPN4hhd8q/Y7O4D0fSqUAwQ7bBDQ8IIifwVzUKMtwlH8jAT
 jWJETy0s088hiFJ5Eu2YXbCCQk9YOvyxuHQxxvTjismAZhFGfTyogH/pGf1SPwuPnQbdu7gaskT
 m3n7wYtIeNjGqnH4pRuKlmmk8ixYLj31+YW3LPKeAQqTuT1czAeNVn3h+VxC8f0xxjeeTiCJHMx
 rO9pSUBya1/L0Hof5wSpgGnLZFDfR0jtSZpxe4aYdMkNejNDjp0anbPevKrljGv+ZLAtPELfF8u
 wU38bW0EELeAKQbT6EYdU2ih20jlE4Do/zKgj1ZKixomHfKH9rg8YkvzPX7F7K9CUn1dgb4LwsI
 +lL0cjNFpSKHJgVBmurC1n1oqRKTHjqnkfq8RNmamU2T7FjGaaRuGTMWW/hTiTGwVm51I/Iqebm
 Fm+QZEAdFjYjtNC5ghXAKP3iARRNG2ezSlWqLQKu+ryjzo781dM7VZW38V9183wTKGdiL4DOed7 fVT0HqVXGUYCU5g==
X-Mailer: b4 0.14.2
Message-ID: <20251004-binder-freeze-v1-0-fb9fcdcf2b73@google.com>
Subject: [PATCH 0/2] Fix two issues with freeze listeners
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

See each commit message for details.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust_binder: freeze_notif_done should resend if wrong state
      rust_binder: don't delete FreezeListener if there are pending duplicates

 drivers/android/binder/freeze.rs | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)
---
base-commit: eafedbc7c050c44744fbdf80bdf3315e860b7513
change-id: 20251002-binder-freeze-f99e23dc47bf

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


