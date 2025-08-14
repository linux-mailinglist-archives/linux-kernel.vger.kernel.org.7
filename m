Return-Path: <linux-kernel+bounces-768951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8790B26842
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE3D9E08CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178F3009E1;
	Thu, 14 Aug 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cNU5MI1"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5E14A4CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179609; cv=none; b=qQFPdz4RTB0BbcioNRXLjiVLHTQAfsGMUIEZ5mQyl50mMH5pR9a6Jo7JTXKrlF5b4ASKaEi/0Pj4OQau4X3sjLQFkBITX0fqQeySyZdGlx2+iUzV23CbHytBUm1cbxdFrRKvbLrLvTmw485CQVAloOHBcaamZQ0XA0t5WYiAhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179609; c=relaxed/simple;
	bh=abS007O1u+hwW9gFpKL4+LBBc2SxxpNq5FxcSBGjtYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y97JBHWNufhW/b7mKt6Si4pRXXeOW8tzJSzuVdrv5/nILVbngnhh57XmP9Z05kWUbUQkyRQT8Whjmkz1I6K/8WwwZbgXoH4eBIxYw9E8DAVIFkwKa+4fePtxSwLJNVkQNaqk9VSLdMbFS6tu4j033b0Gq2lIlLWI8mn43TXQ9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cNU5MI1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so10657095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755179606; x=1755784406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeEzkQgYmIMtzyp7xMy2bVRBv2zDb/Ov8v16nUBQdMU=;
        b=1cNU5MI1R/+by5VJ8yndCz2SWtPODSg+ZaCDtCfs4yCSbqDbRopALotS4+xFRseq6X
         YDMwMmTBOSXSdmnIWB2WeROWbOjqiK9W5ynEJsx/YYwUIUg7utilNUDXzRUNP/vsu4uJ
         /zo1qbLVfl+5znd5BsVaHXrAYXGRwVCRe8p3QYFm/LYej24W7B1YpeaBVLq1ig58HLjF
         N3SzAXV00nJ1wYb2XJcvFqKuJPw+ZC/4i1AJHPgi0q9KqFaOtAZ1KkDAoYDsKkzMrdNJ
         GfU8uolHLA9s2HyNdj+F4XCPYxF3DrTXHrKODb81R1WyIrGqxHWA9efuiOUMRMfU/aZK
         lu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179606; x=1755784406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeEzkQgYmIMtzyp7xMy2bVRBv2zDb/Ov8v16nUBQdMU=;
        b=qdk6W3I2OswlCansvct6bAlu/PDcL48kD9hhzDwaPiWJ5d55rNJvc2xQGYfEvM3Xsa
         7vLVsa9PyFs7b2sDSpJ7pmwKOO9DGk9JQGr9Pl8qcq4zotCxTPE9I19PNwGVIKyPelA+
         hyMKUs5oPLYo3K3bNwx8O35CvD0JRbTNdb96Lmx2Mgms+/1j2akaeRlgNiD8qMEr+59U
         fCeBLoN5BGrY3Fj6UB0S1vepYjyUAX6Y8MMzUS6g9UmRhWtYJ/JTeP6B3wYP2HpOVzfY
         SVfkkgo0KlEflgA6wanDwh+u7Pn4+BsRq6JFJU98W1rOWIhHw0sCQjSVHMVDkdCOE5K3
         vvMg==
X-Forwarded-Encrypted: i=1; AJvYcCXvWzoacpWskqbxhkX+Zd7ywyS6UuF6C8rbtP9xW9RRr4Qm6Ys1XfxaqZGlmrgDq2KM5RBemHVL8R9RmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlgLyZxK0hyytCrIWj3LO0n320fcnOW2+t6et2/YvLMBmS40K
	EY6sj5MFBBF2vjlUWf/44emG0EnY3ZDxttLhmoQEHlt2TBceDtPz+kp8Zz4zjkqvthVb5JgxK1d
	dgDL+zlRrUmC2Gx4QmA==
X-Google-Smtp-Source: AGHT+IESfdeJeKr09jw5WbnVm2g2GYGGRoae20RO82NBmgfW5Xq4wFMtQ8ks4BUMu22uttfxn9AvnmK+x6a4z2c=
X-Received: from wmqa18.prod.google.com ([2002:a05:600c:3492:b0:459:dc99:51e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1907:b0:456:2139:456a with SMTP id 5b1f17b1804b1-45a1b7bf046mr24221705e9.15.1755179605642;
 Thu, 14 Aug 2025 06:53:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:53:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEnqnWgC/x3MQQqAIBBA0avErBvQrJCuEi2sJpuFFloiRHdPW
 r7F/w9ECkwRhuqBQIkjH75A1hUsu/GWkNdiaETTCS1btOedDLr7oozs0ZJD0wttZqVa6iSU8Ay 0cf6n4/S+H59RtYRkAAAA
X-Change-Id: 20250814-gpuva-mutex-in-gem-a608ab334e51
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=abS007O1u+hwW9gFpKL4+LBBc2SxxpNq5FxcSBGjtYw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonepM08eUWZmldgb0RLPzTFzkATvv5oCAc12Q/
 f71nkR2gpKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJ3qTAAKCRAEWL7uWMY5
 RnTAEACTN/BeQv66T5iOnfFiSziogfTb6vockzGSNafTl2E43jlEbAw5YvB1WPhAKmRJeF49A5X
 4v7d8lkN0XTbAWpyO0w3fP6Z1GKmPqcVMyGNXf6+/KnipfQ+lTpDgsqg/x4T9FKfUYt0y8MyJ/P
 bUCDQA/A1Luu00AgK5xn2Q19D5EVrMUfYjtKCF8ZuQ9t7Czzk7A+c9ngKeurnOeOXmHHejDXfka
 imnHWZLc3orir0I/UpeJWxAPbvocBj7zOY5VhuLQkST534a/9w0FcEzhQ15QGpoLo5VvVapclnb
 V7MCIXSyVPHkQhchZ4LsMlOth333nUy6WOrHwZ0AlUfsKDlldf0gM7Kn/oF98EYo8OX5RiUayGz
 osju1k6YX80i0+llYWrvOKBPwk2wYE8DBVKi3GGsNqrkmAA+2kWkCkvTCkSDp0q/NeKXpbUq49d
 eUqhGpYT/VYFfcFpM52D3FAcXPJ4PeeJinrN1vOLnyoHqd3Rtr7l6ak81fHf9MJ/Yn5/JFWDBG3
 BKN/fsRTCupANwL5AWQwIUO4m3ou9/Pp0PuwyXj0Wkk5rO3LYcWdZYTxwVTsKklD0xABeb9RmfF
 8kpRpBF2SvfItVhpng8d9n0EVInxqduT0KafbkArhdZOH8EvLvi0wBaQmgM3iH8eL1j6SJMQXQw zP6j5xbOkjx39vQ==
X-Mailer: b4 0.14.2
Message-ID: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
Subject: [PATCH 0/2] Add mutex to drm_gem_object.gpuva list
From: Alice Ryhl <aliceryhl@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

See the first patch for motivation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      drm_gem: add mutex to drm_gem_object.gpuva
      panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock

 drivers/gpu/drm/drm_gem.c             |  2 ++
 drivers/gpu/drm/panthor/panthor_gem.c |  4 +---
 drivers/gpu/drm/panthor/panthor_gem.h | 12 ------------
 drivers/gpu/drm/panthor/panthor_mmu.c | 16 ++++++++--------
 include/drm/drm_gem.h                 |  4 +++-
 5 files changed, 14 insertions(+), 24 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250814-gpuva-mutex-in-gem-a608ab334e51

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


