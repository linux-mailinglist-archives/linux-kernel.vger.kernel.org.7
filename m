Return-Path: <linux-kernel+bounces-896904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E4C5184B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D73A34FD392
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7430102B;
	Wed, 12 Nov 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XPkNhvG"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F942FFF81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940945; cv=none; b=VkmoKBXf5lTLZL6ZZ5IPUkf3lgPJgQAD7W7wtFyFpka4n1R1R4RoZu+Ml8m4Rrxv27z/yYn1po839jl0qpwwPI7oVkg9jys5tW7GFtCBdZ1v69kfj4cfGqIE/mwnXbVc8G12UEvmDajVeDfRZPJGtUTlwQ1xF23jxuyTh/xp+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940945; c=relaxed/simple;
	bh=QmvyXDXDVrsdfDM+yKnByFuQLV8gY2auM7CbdPaIBok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H79ww+VWWoeHvucNHY0BuRfQpWcG2GmyXTuo7eZF/YhR1ZSUY4oKVZHJJTign80xOA0M/A+nd97S20Y6PqE2Kod87gXkR8XnhHg27wCq/PAbpgRs+qozSwwn7gojdRG3X50adb4oqihMr9WYGlKEmAaoExpnakeArzaFoFNjg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XPkNhvG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d110fabso6738265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762940941; x=1763545741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Gv6xr0GGt0t3EpcKK4KiIfCoZCaOutnve9evDPKR/k=;
        b=4XPkNhvGOpG96My7uORsPKd6lDMEKmbAVliBbNzOXhdByoICFUvoIml8/a9ajP18fV
         UBwo7aluHz/8/VQaWXARcLFfvXXW/w1laGni3akMfc66j8ZzlLExyDbYut9nl09pozOq
         XM5GyZVuNPh3yMj9h6yP+ZWou/MaeZI11k2jYND4N/puNfsHhJx78yRDci8/HKnMO2NA
         hmsgH5afIDJPPrzwfbUCtBP0Hi5GWLRsyPNLy+KRKfnSmyj7CwtryBxqEbsw+sYg4nCv
         iK+n70BrPILFqxEgTvFbnaKBwPIq3g6BGTrnr098/CZTarFNCHrOJ+SGZhteTZh9qwGm
         SLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940941; x=1763545741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Gv6xr0GGt0t3EpcKK4KiIfCoZCaOutnve9evDPKR/k=;
        b=Nj+uA5YtWMwD0FcvwyJHYL30JcPI2f11Lw6i/5U8l+u/WbtTotoL4vvt3O8bECZ/1R
         VP65682kQ9Rgo60kgE5MJFaKFdYoFeth2dDO//OZ2wEipVBv15PVn83r049izl+2n12F
         E46+tbtiz2g5IjyV62+vSCDbH4IzpsEZNKuQtL4Ez9xlhwiXzDKDWNPBNqFQzeF4rZJ5
         yUT9OLlW9/1lQ3bQCZyjxwvNBHsccjvtg+9y5l4TfbU7t7GVuBYdewRBBg+T8mW52cx1
         r+JhWXVIrzdXzW+enMn0cZOiXx6+kAi6vSKtJXwLjW87Rqnn6KVcYRUsZIXX4noB4IJL
         HJNw==
X-Forwarded-Encrypted: i=1; AJvYcCVwC0WdWqOa2Fh1gEXRO+oRKrjhPnroiurJ0cpV/tq3Kg26ISNjtVhjLyICTFSYkv64kCRdoD5xojNB6ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0k5ytKi+b/DHFH/mBs/ed7tL2pZDLNXCPk8q4EcA7wzmRr38
	rKa6S06uh9D3lNXJpd+TlZyHEId/3GTFuWgWFVfPCL9TZrufrOl5Vz4KwDuJovKc1eX7hSb7Ml5
	oaieLELyGJ3O+ZV7yww==
X-Google-Smtp-Source: AGHT+IH2dS2PfgK5jUWA9Ng2M4W2Yq6xdnOBF1mJ4GATChiOA37Dbco0oRuZd8Strxz0EtvePc8l6EG3deFkh48=
X-Received: from wmsm13.prod.google.com ([2002:a05:600c:3b0d:b0:475:de6a:c2eb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr22179505e9.8.1762940941091;
 Wed, 12 Nov 2025 01:49:01 -0800 (PST)
Date: Wed, 12 Nov 2025 09:48:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO9XFGkC/4WNQQ6CMBBFr0Jm7ZhOCRBceQ/DQtsBmihtOkhsS
 O9u5QIu30v++zsIR8cCl2qHyJsT55cC+lSBme/LxOhsYdBKN0Sqxcji39EwhjkJrimw5VGwtY+
 663VnqemhjEPk0X2O8G0oPDtZfUzHz0Y/+ze5ESpURrE1Xa3I8HXyfnry2fgXDDnnLxY5KjK9A AAA
X-Change-Id: 20251106-resource-phys-typedefs-6db37927d159
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QmvyXDXDVrsdfDM+yKnByFuQLV8gY2auM7CbdPaIBok=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFFgHx3cwOybF0VqfBGf60UP+BMu97heCo8Oad
 L+QNsSjXvGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRRYBwAKCRAEWL7uWMY5
 RlFcD/9zmqypMTbBEK4TFlukuZM28Zj2oKT+e+aZvfgWd0Inzg+K7c9n+IHif0zR+qlN2t4X2o0
 aHfY7UxibEFHdEvKFsgMtbhtwQ/z+JK0kttJ72s2n+PDcO9lzihrGeBAD85TE82P/kaeDopUtkh
 omNICZrSODCry5Mv/7iLPl4VjVoqLkelYvSy0OlisW/fDXqN0rS/8R951e/g8uzWb+AYbMmJjgc
 1/ygIl/IA4c3AJW41oOTWM27yHz5y2x2ztGwB+RqmLBpT99ga8mU/njL1uGCm4FQr0OQAkcZ3rI
 XRhy+yY8ylTMusX9ocpcFqBewH0KwchGINQiCHlBW1TpKZjWMOM/3G+c6JV3S5Nf+JhIOh3KXZO
 8YPrjhZb4j3nnjW2RSaLgQDozX2xgpXV+AQruHkd6DZrLMRbAomPLlBSus8qxigtzZfGXcuQjOd
 a9Rut9qAv2L+a89KrCuQdvv3sn1F8HSVWkqShw+EstS7r7c1nByQq4xzWNfHpG80PekfLNfauzd
 IWJTMK7h3aelFpZ0k/Ela+2vgsmDe8snkwwThtVXAskqkCBRIEeFkRQ2hzxlBOXkqr5MNioaEET
 xvZpwYS8XLVlW0UULAxbX1kwwMdTP0wpenV3UdsZfFX0EAJ8Vty7Mvd+UM+lZY7peXdZtl5q5+j NdJXJz77uqOh3IA==
X-Mailer: b4 0.14.2
Message-ID: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
Subject: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This changes ResourceSize to use the resource_size_t typedef (currently
ResourceSize is defined as phys_addr_t), and moves ResourceSize to
kernel::io and defines PhysAddr next to it. Any usage of ResourceSize or
bindings::phys_addr_t that references a physical address is updated to
use the new PhysAddr typedef.

I included some cc stable annotations because I think it is useful to
backport this to v6.18. This is to make backporting drivers to the 6.18
LTS easier as we will not have to worry about changing imports when
backporting.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Fix build error in last patch.
- Add cc stable.
- Link to v1: https://lore.kernel.org/r/20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com

---
Alice Ryhl (4):
      rust: io: define ResourceSize as resource_size_t
      rust: io: move ResourceSize to top-level io module
      rust: scatterlist: import ResourceSize from kernel::io
      rust: io: add typedef for phys_addr_t

 rust/kernel/devres.rs      | 18 +++++++++++++++---
 rust/kernel/io.rs          | 26 +++++++++++++++++++++++---
 rust/kernel/io/resource.rs | 13 ++++++-------
 rust/kernel/scatterlist.rs |  2 +-
 4 files changed, 45 insertions(+), 14 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251106-resource-phys-typedefs-6db37927d159

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


