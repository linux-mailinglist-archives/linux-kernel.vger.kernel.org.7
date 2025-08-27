Return-Path: <linux-kernel+bounces-788396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE47B383CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978207A7A27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE83568F4;
	Wed, 27 Aug 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaN3rQo+"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2385352FED
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301930; cv=none; b=YkDkNBlNB+n/YbM00ImC9x5/cza8lXHuECeDYUukhxfFgTwxRq0vTe/5Y3bqT749McqwG598idkhlyFMBZSYP2ullpI7jMxo+X0Tq8RipjXXImQK6Lfhy2KfuH5+/KQnzhLt2L/QnLLk1ghhDt2JvjVhNJZfLqnECWiPTk/mh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301930; c=relaxed/simple;
	bh=T4Kk9hg7k6nwC121hIRmflX4axzXFxAKRAccn6Kat2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QMApNgPA2jbNl6icwxfogCIfV29PtjC3qOsqNb1+yTbvqLnu67SmibdXxOCmq5lSRcdB0MkKQW+dW99ZWZbtmZGqGz3vfgQIlOUo7fnQl5GI2sHcwOKs/iV4eoaraGyNxSF5PtON79MOnbfIEHCMBHncCf2bOXb0bFyVpF1o+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaN3rQo+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3c79f0a6050so1967659f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756301927; x=1756906727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReergRz91VYiD0psPGfUqTceP1iKvfFRvJIV10khnlI=;
        b=BaN3rQo+awLbHi6djetfwJ+VnnWzLLysehipFjdW+ADBNcoe3pWWHCEHfvxCkU7Btg
         8U5dRWaX2d0Dnry0agbQ0KnoUYYxeIzRupEOhCLe6kvCBulXDAwyw0d4eioHhQCXQpkk
         6oKsdZb8Rxkqe51WVLGVygir6e6tHFAueAhls2ZobCvkK6745tXygGRrn9ujujxEuwnL
         vbT+ksmR33hE9YnrBnQLhlLFwFqS/aULLnTmszPy/3lm/BqvaHbxlsnojQfV9sG+oW0F
         7dMJD653m7CSZn5JCnDGY+a4fT9njBkjSAQuE46RXKBSX/BwklvK5Ty7EYLQp9/szd9J
         ZUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301927; x=1756906727;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReergRz91VYiD0psPGfUqTceP1iKvfFRvJIV10khnlI=;
        b=of4TgtBx3MTTqqiiDobQ7zyP1WS4gKigClNxg+2i3OGwQ5i4zZb16vG5ZsvRVGxYFe
         wHLBsh98UyX5pPZ8LyzRXPaiY8vhzEIkcVyJPhCKlZoowml41rNyZhu/1d9RpfUxQ9A7
         onMt3kHDjzOrKVKhqtLF8+4lI2Aq88/FL3GOh3HiBO2XF3htjsjSr6QC4T7FnDY4F7zG
         b5QXcZ0EUyAQEkh1MgJsur7Q3Bnhs7qam7C2pRaQRU5O37inpYYf8LOZWnCvtKKojKCz
         g1n5qKNjESfBa0yG1t6x5tODJ9CdiB/WdP76L9F5JpFBZEFjP0fcNA/dBiAFFAxumXqN
         st9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMJL/NfWhHlgY7lWmTzBiMzx4qZo/5Q6R8fY4vowsK/mDaKD1tKYk772y1ZruF/GKyK5w3ALRke3oiGdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kSo5X2XrjXMgZvr2eP975Eydl3V6Y+y9ghQLzKX0LhauWFGe
	Dwr+zhAM0XBAzx6Yvhz2z5Pk5HXVo/gwKa9NFzxYC9lUQuwlRsZJwfX00oVIU4DJjZgr+l5ud0e
	vUHzXZCrFEkUTOgHOLw==
X-Google-Smtp-Source: AGHT+IGDR/KKmo+S77dpLzFH/5ksImWOImV2ATqsae8Vpzppb4G/We+eedfsA/IVYVa1fkU/sTJDsVbNv2iumkE=
X-Received: from wmbdt7.prod.google.com ([2002:a05:600c:6307:b0:459:df20:248e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420d:b0:3c8:e9d3:c380 with SMTP id ffacd0b85a97d-3c8e9d3d035mr9768151f8f.0.1756301926661;
 Wed, 27 Aug 2025 06:38:46 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:38:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFwKr2gC/33NSw6CMBCA4auQrh3TBy9deQ/jorRDaSKUtNBgC
 He3sNLEuPwnM9+sJKC3GMg1W4nHaIN1Qwpxyojq5GAQrE5NOOUFrVkOZpyjhH6ecAE7gMEeZEl
 r2QiRY8FIOhw9tnY50PsjdWfD5Pzr+BHZPv3LRQYUMG2opsVSV9XNOGeeeFauJ7sX+YfB+U+DJ 0PlTDKqmRbN5cvYtu0No2drIfkAAAA=
X-Change-Id: 20250814-gpuva-mutex-in-gem-a608ab334e51
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=T4Kk9hg7k6nwC121hIRmflX4axzXFxAKRAccn6Kat2w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBorwpfI6fZ1Q+VznBKbZhsynvbCV9QJCFz4ab1e
 we4fTxdqyGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaK8KXwAKCRAEWL7uWMY5
 RqI0D/9lXu1uJWu6+0Enpnp9JmQ1MzDX/FOFXYDJEa+jdrDhWIQj5H91zbkjIrhcpmO2eKoIgjR
 OUxOX0st5kQXKD21DCKJXUWh0lyn7DT/6yiWRC1xjLro7xiUd2RXDWu6TlbIoVIkYAfXMhaNyOf
 E3T3u3WbsW14M++h1pEl0IGOvPm7/24F4KwUlgEMUUbl6EdJLKQzf0vQenjwVSw8sTVuJ5SjupH
 R5YnOoZWC+rUTDAiqdeQ4534INCopUh8Sg7BdugkVGuITub4UncURL1R60cIsjWckoYou9L7L2j
 rTZw3BzldQ2crlaOEeiXmugYudWxsMez+JVEK/SUS1TFPP2sZuVjLLHSnkhU0g4KagwleTClrNY
 pM0zeqkb6lZcPkOKAvehAMtZc+YFqNn8nDC/qzpoW5TP2Pd3XY9K/ub1B2gbgMMQHSmGhMbJTqs
 p9L+swwuntKUVc9o7zn4ds+cSl1h7bqzxaAK9suEIaJDkHJOxvPErLK3+f20EjjRC79yJ//U18F
 yYiLzydHoE1YSR4gWVmvxxC8P/fUv2U69VZ+5ckSxwDzvSj1T4mQILaNgXWzbEAOKBaLNOkIGVY
 6X7k5/lxwVBofFI7HEpsyVaydIR+UOhRLlILIR5rKrF8e0XKK30dEW8ZshYMW4rRUoswZr5q4Lm moY/XiZMetGkcoA==
X-Mailer: b4 0.14.2
Message-ID: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
Subject: [PATCH v3 0/3] Add mutex to drm_gem_object.gpuva list
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
Changes in v3:
- Documentation improvements in patch 1 and 3. 
- No code changes.
- Link to v2: https://lore.kernel.org/r/20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com

Changes in v2:
- Move the mutex_destroy() call to drm_gem_private_object_fini()
- Add a third patch to get rid of the lockdep map.
- Link to v1: https://lore.kernel.org/r/20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com

---
Alice Ryhl (3):
      drm_gem: add mutex to drm_gem_object.gpuva
      panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock
      gpuvm: remove gem.gpuva.lock_dep_map

 drivers/gpu/drm/drm_gem.c             |  2 ++
 drivers/gpu/drm/drm_gpuvm.c           | 30 ++++++++++-----------
 drivers/gpu/drm/panthor/panthor_gem.c |  3 ---
 drivers/gpu/drm/panthor/panthor_gem.h | 12 ---------
 drivers/gpu/drm/panthor/panthor_mmu.c | 21 ++++++++-------
 include/drm/drm_gem.h                 | 51 ++++++++++++++++++-----------------
 include/drm/drm_gpuvm.h               | 30 ++++++++++++++++++---
 7 files changed, 80 insertions(+), 69 deletions(-)
---
base-commit: 3f13bcc886fc034113cb75cb32b8d9db1216b846
change-id: 20250814-gpuva-mutex-in-gem-a608ab334e51

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


