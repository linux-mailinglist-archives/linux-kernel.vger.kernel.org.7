Return-Path: <linux-kernel+bounces-727128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1944BB01562
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EDD1C452EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CB20298C;
	Fri, 11 Jul 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTM1bxph"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15D1F8690
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221086; cv=none; b=naZXov2ExiIrvlAWCna89uJ/iXivn+jrk4GyEFJ85gRNPwM/Lp+ZajpI04srha21iIv0yrsKNUtlQDE2xofA6qh7tRVWyWogDnjkMVGjFIgNsoRS3UhlsKFTH/mDxCJSHNRggedADmliqKMq9xK+F2snzTKPNjuKnCy5P86nX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221086; c=relaxed/simple;
	bh=pkRDOWebUNM4JiyGTyFlT0hsoPMAV1wZl01/hxrceCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QjwUAF7F8wy/FOraIAnHJNkf+kN0tFm1SyNx6VXbosjDUT+v20y+JZYvDJibyKU+OQoULg+CSEJOKrOe1WIE5xWObt73xq4n/SoQlLltAXDqoQQzFhUYj34CbyEVnlR5QmdxPebxgKTXWsEvZDd25uevnbL7DwjyI4QsMnC3J94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTM1bxph; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d30992bcso13795365e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752221083; x=1752825883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3M2iap2RfddA/05gTNnW43uL4IxbrFPZmKO6UgPVVnU=;
        b=MTM1bxphIVLOhWSm+M1FfqfVIZVuprb0T5RImwHnk6zsTl1xJz1DNIlLBl9z2bV5r5
         z3Ujiji8EfM6VkI/kyEy1BwtjIRGFANs/7oa0D6PhY+6DT9lqoXvTdKRV2cfgXMRrE9F
         7PBSdBklrQTN6G+Hiz90qhN2ay0rLqj2qlxmyuseDPlv1qdztYkPibyzYtvpFwVXBKS7
         bZ3Yd1lQTKvJpmWqrlJK86KExVvyKeIcLIE9n7tmdDga2VZ1/XUlwwRbCHAO7pA4Um1h
         tkTfGCpwV6CD7naGRPRNUQizDHOW7b6tzBZcb03M/4pV9NAB3PVx8Y68xUW/E3c7If0w
         Qmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752221083; x=1752825883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M2iap2RfddA/05gTNnW43uL4IxbrFPZmKO6UgPVVnU=;
        b=jRMGC4TV1wzRtw/HzUeEQcVPik+vxcbaGynUexYsDjnCsHAdmCt3vgrTu3NJuqhUw+
         dJgcp9s9dda+ggmPrJmD+cTIjStIqMgs1PKwnqRuHYtTL3RSMf5ASPcPe0GKh/1DodMu
         JxlJXQWRjt0y8btn2q2rZs0taaxQHLUSfaGbX3dTwQ57gEEvFqNF/8u1PmAbbAsM51NH
         gYt+snmjIJwNUU9wSoxcAw5kDJYFFq4Eook4p8F3lnYRfCMsCZiviqoMeVmhLCaNFl6Q
         Clwnk5cDBiZ1ZZwQ0LMvwaKFl584IuXY8/GPNA146ArcaT/lvuAr7zehnhXfJm+dwJ74
         zORw==
X-Forwarded-Encrypted: i=1; AJvYcCXUmWCgIsiaDKPNmfIQ/QHs3m+znGCEl3+9keXFkArYsPAH4O6sOpLYpKhMb76Y2zpmcn6HV4nr4JrtT94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMC+EmQj/Jal4TmLI1c8Xgsp7xo6Lw/J/5lX4GUUGqNB0bjAb
	uTfEChmI9eIwW+Ab9PxSp/HS9azP8zxIChVuq+pjIKrbXYiqB3VBwU5RrDc+pnkMxoIxCpF+9sy
	pWGvudJArsL15Pg8hJw==
X-Google-Smtp-Source: AGHT+IFlSXEzAMov8oFdISNNULpSYKLnI6k/Wg/M0Dmh3F1GHL/zhYS6s31XC9cw+cBAGqFATVlq5a1YqgWWoCQ=
X-Received: from wmbel6.prod.google.com ([2002:a05:600c:3e06:b0:451:edc8:7816])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1547:b0:453:5c30:a1d0 with SMTP id 5b1f17b1804b1-454f4257f2fmr14179655e9.21.1752221083194;
 Fri, 11 Jul 2025 01:04:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:04:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJTFcGgC/3WMQQ7CIBBFr9LM2jFAQ0hdeQ/TBYWBkmgxYIim4
 e6O3bt8L/+/HSqVRBUuww6FWqopbwzqNIBb7RYJk2cGJZQWRkzoeeQIbcVCAUct/KJHabyXwJ8 ny/Q+ereZeU31lcvnyDf5s/9KTaJEWoIRegrBTu4ac453Orv8gLn3/gXhNWXJqwAAAA==
X-Change-Id: 20250709-device-as-ref-350db5317dd1
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pkRDOWebUNM4JiyGTyFlT0hsoPMAV1wZl01/hxrceCs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBocMWZf5DwFAkNMr1bNJ+/LMsbDNp8asHUALJEC
 96m97gaYBuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHDFmQAKCRAEWL7uWMY5
 Rg1iEACj7tHOtxXbhYlloF3PdDFqYVx0uxVObHLIawoVwlm0qOu7jgYFt5twhGd67vpOLuPR1Nv
 d90grP/NrXGdRDadA1J56Y8XLaX13MqGkcQGrZAUN0VCuMCLx/qEjccQ5B8JSD+lOwVV26gsFub
 C5prv8LaELZ422a8iXkKb+VTpTtUa4arPcbmFsa5bvvPzOqGwYwLI8KDVlZU0NW8bczQz2JXPx3
 OUNMqZ3HjTWxll55DZBdWG5cHliBdZG0J+Ox4P6m509s/46m/M37U1O0SpJlI/PEaJoLlPH9e4B
 wuaqGfR5uEgwf5o1oPXvVU0gILQpodJfnxg9XJtTEaT/cOlbeEbhyU+kiuMcankJfb9ACf/s+vC
 R2iRQM6iyzTMO4rGmYY+IUZ2sR7Ob7vUfO9laUr8QgAZBCCwhll6IOk0bWyyQHLGjIcUu/Wqk/T
 lF35wHgXYJ+VrlUQryynKkAfTdgejexjBADJ0KoL+cjOr5vCLpHValhlXEr6XX5pCnFABK/WJ8C
 YLDzqGUbUtF75+hrJbOKDPsvpc4FSRyISEC1JgwYOoxi76WNJSaTa0Ks/n+xVaptZZ0xlFQMSxR
 YUQ2jeFDP2hMS+S4YpDhCmRrNP3t9w/6gd4ELfkIIbaEL+JD1o9vOCNbdWxB+NznrCp+CMIuGts W7AxjNqzkAB+zmg==
X-Mailer: b4 0.14.2
Message-ID: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
Subject: [PATCH v2 0/2] Rename Device::as_ref() to from_raw()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The prefix as_* should not be used for a constructor. Constructors
usually use the prefix from_* instead.

Some prior art in the stdlib: Box::from_raw, CString::from_raw,
Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.

There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.

For more, see: https://lore.kernel.org/r/aCd8D5IA0RXZvtcv@pollux

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Split into two patches.
- Use a different lore link.
- Link to v1: https://lore.kernel.org/r/20250709-device-as-ref-v1-1-ebf7059ffa9c@google.com

---
Alice Ryhl (2):
      device: rust: rename Device::as_ref() to Device::from_raw()
      drm: rust: rename as_ref() to from_raw() for drm constructors

 rust/kernel/auxiliary.rs   |  2 +-
 rust/kernel/cpu.rs         |  2 +-
 rust/kernel/device.rs      |  6 +++---
 rust/kernel/drm/device.rs  |  4 ++--
 rust/kernel/drm/file.rs    |  8 ++++----
 rust/kernel/drm/gem/mod.rs | 16 ++++++++--------
 rust/kernel/drm/ioctl.rs   |  4 ++--
 rust/kernel/faux.rs        |  2 +-
 rust/kernel/miscdevice.rs  |  2 +-
 rust/kernel/net/phy.rs     |  2 +-
 rust/kernel/pci.rs         |  2 +-
 rust/kernel/platform.rs    |  2 +-
 12 files changed, 26 insertions(+), 26 deletions(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250709-device-as-ref-350db5317dd1

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


