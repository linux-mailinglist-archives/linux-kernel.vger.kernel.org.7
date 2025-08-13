Return-Path: <linux-kernel+bounces-766247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D95B2444E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5691BC214F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B952F0692;
	Wed, 13 Aug 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Z/umrxF"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431D2EE601
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073650; cv=none; b=ged2vXlV5zcg6D9JZmg0uOjQ5a+OfLNKLIXOaVAHHHcELt9DZv99Pqq8HUg/sJp0aeF+htwiUdRWmYmgB4mSfP+vNmMXDPrRCba4HrrhMVXYrDOsvxLeqX7nkndVlqLrkYr9RTVc1ZgWtA4wHMrFu1be0BGZoZpO6dKZ9OG8TwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073650; c=relaxed/simple;
	bh=uy/Iw+XWGBLly+HHdmY98LIdt0CV7nmd76FKd60CxfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mmqGHyS/Mq68AkGE9norZAZhg9jePA+u8Cld1CPUhnagy2ohB1KUI2V7qyIy/Jf2HZTzxD3nFB+uaQsNfywexTcBlExSMSi0tpN6S3QGI9/tUX36Cp5kbXtl0ezu1nkzc1SWQr/nqKpNV9CqgQxOP3d9SbzlAgNIZ4B4MiPVBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Z/umrxF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459edc72b65so48941895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073647; x=1755678447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qimbAAoxT8ZeS1FOvJvAo6rG4Md7ODurdBa5LI6o3gA=;
        b=3Z/umrxFSe5KCQAvlx7lzjPGU5g62x++9gAGUjKNRojEQV58OUvH9vYWWRw7gNq70I
         lXggNVsCS0Kcrki/XMeXgAEPD9HoKumJjmAmV6KsAeLkA7YhH9dH/NDOqdJt21NKyJtR
         9JxcCXRi9r809fyO+sz6iSygN+splXrGgpQlTXKHG79W1nVbonFhlPMTIhpqqy8TC1DM
         JEalITedwxVlL1ZwyAjHNLSz4SGLLNIaULSSeQ6TZyfFP3XGzIBN1J793B+Y21hN7fbx
         5ta9AYRiclYk6oTHjPhHA6u0OU6LVyRhbuDUslusv77waU0+LEzJm9fyx4K5ueHqgGPm
         XHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073647; x=1755678447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qimbAAoxT8ZeS1FOvJvAo6rG4Md7ODurdBa5LI6o3gA=;
        b=dHd06vnuR9iA4LCyat6WOePUe8r45/kWboe9NrDMLR74fu+926Gq/fsV7qXxgHvt0o
         /1tAJ1lvrZrazYCTGkYRaiE7pB+Qls0Jql+MGCjnXyFZxloq/yKm2fvkXjDq/NgnUVHX
         3rJyhvX3rxMiJEdLSSdF8otenJnhqFrpF3FRZHYLCcb7fAUl8EQVTOn0+TEON86AdPQM
         AP/07mKJUmD79ejDTz+318wLMqKWt0GCMQ9WFu60tkU9ZOKyfN/3PYFdV3Ox2S/Ifd25
         tg4lh3GNzluG7vzC5yxlTjCUldYEpy5r10YwYFDDHUUg4faxCowml8WY0gWcnA7oBdsY
         OSAg==
X-Forwarded-Encrypted: i=1; AJvYcCW4N8QATUR7aZmTOeYDFxLEkYOANnCu1hXs9uxC5vt/TA/Ym+CzQZEeBNmZvWLHRnqZC7Hm+w2BGnL5HSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZw3mASmB09AyMU8ulSDU4ciAVgoQrMcWL4DPNllLHvVT8Ssz
	CxwGePjnFEq/cFv1APeS8VeIi9YlISZOWZ/MdjgUO3UU0ZYlhlR+gDofoYirTr+Wtwr7Ck4B+Ma
	663sB4Ua2qXsjg9lQtA==
X-Google-Smtp-Source: AGHT+IEbzHDEA9Xcjx7US9S+uclopgBEUuk+xo320UgBoIkE1EjePMRTfYAL8dOp/IU2GQ1AlO0j45cZL4SGzGY=
X-Received: from wmbid6.prod.google.com ([2002:a05:600c:a186:b0:459:d4b5:52cc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314c:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45a17258921mr9201445e9.2.1755073647042;
 Wed, 13 Aug 2025 01:27:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:27:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGRMnGgC/22QwU7DMAyGX6XKmUyxE9pmJ94DcQie21liy0hKB
 Jr27njbgSI4/vb/fZJ9NpWLcDXb7mwKN6mSjxrCQ2don44zW9lpNujw0XkAK7lZWbhYimNInNy
 wg9Fo/VR4ks+b6vlF817qksvXzdzgOv1H0sA6O/UUwQdOI4anOef5jTeUD+ZqafhDDi6sSFSS+
 5jSQDAFx39IvyIRV6RX0vNEkZBwjP4XebmfUvj9Q5+x3O8xr6my1f1Blm3X+g0MthBo+/INDUs Dy0IBAAA=
X-Change-Id: 20250311-iov-iter-c984aea07d18
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uy/Iw+XWGBLly+HHdmY98LIdt0CV7nmd76FKd60CxfE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonExosgq1Bx5w2KM6Im73vtXLq9cx1HbCg836D
 kZoz+wmbYGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxMaAAKCRAEWL7uWMY5
 RsJ+EACFwgEUSo7zu+JZfLI+CAkYpUdKzxSPHR1QUJHdnSkPle62fo0C/kj2ggV18BkgA38qu6Z
 2o5++A8S5+S8G1HZ3Gu5TGy8m3YvP+etNDrQyuwzB93/aJqIAt9oX4YxJrYqfxbl7M3OiG6NP1V
 /pDHnTYMhIuJt/d0ZtPl+1bzpG+ll7VMxaOHVPjrGvCqZFv2f0Gryd9gdbBanIQGiiXm4/xQsGA
 ZfuF3p38F0ryWxpIlZ9/ug5JHYGMGdC2YTq1kxAnmWWQu18mX3OKUoijZf6TeIbi/pje8gupSga
 2XOMkR96z19NMl78SrxLFJ9sV3F+v3RSbCm4tzUBRBu2JUoLOQ3kbkUMeqQTX1QxeQRu64cQSI3
 067UlNFdsy5uIThqazzWTbYCA9ZGXgZI+FmTTUMm3BdMoudEL9PqpfmL+uM7+mca2iRa2jESvK8
 aW6Y26B9HykbZdhcrXqnPI5b44CufI9VQyNyOqNb4aoL3Dpa1d2mhNomsR77YMS33YRtOftupsE
 cRvTKYWh5S1BlemlpY+gCcSl22nEXrIAkISTytNuRTJNtji/1/DsqNEpEegGLsaIrGfkcrp2OqZ
 cwEerUHF1E3BefXA35+kohTJtIrZX2lgpK1n8ZdYgiuCnUGNFIxlq7U1Cm6UIwXdUP51eiN+83U srEuJ05ggh7QjoQ==
X-Mailer: b4 0.14.2
Message-ID: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
Subject: [PATCH v4 0/4] Rust support for `struct iov_iter`
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

This series adds support for the `struct iov_iter` type. This type
represents an IO buffer for reading or writing, and can be configured
for either direction of communication.

In Rust, we define separate types for reading and writing. This will
ensure that you cannot mix them up and e.g. call copy_from_iter in a
read_iter syscall.

To use the new abstractions, miscdevices are given new methods read_iter
and write_iter that can be used to implement the read/write syscalls on
a miscdevice. The miscdevice sample is updated to provide read/write
operations.

Intended for Greg's miscdevice tree.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Rebase on v6.17-rc1. No longer any dependencies.
- Adjust wording of `revert` safety comment.
- Adjust "deinitialize" wording to "write uninitialized".
- Adjust several comments' wording in `rust/kernel/fs/kiocb.rs`.
- Link to v3: https://lore.kernel.org/r/20250722-iov-iter-v3-0-3efc9c2c2893@google.com

Changes in v3:
- Rebase on rust-next.
- Use ptr::from_mut to silence warning.
- Move Kiocb to rust::fs.
- Rename Kiocb::device() to Kiocb::file() as it's no longer miscdevice
  specific.
- Significant rewording of docs and safety comments, especially patch 1
  and 2.
- Link to v2: https://lore.kernel.org/r/20250704-iov-iter-v2-0-e69aa7c1f40e@google.com

Changes in v2:
- Remove Send/Sync/Copy impls.
- Reword docs significantly.
- Rename Kiocb::private_data() to Kiocb::device().
- Rebase on v6.16-rc2.
- Link to v1: https://lore.kernel.org/r/20250311-iov-iter-v1-0-f6c9134ea824@google.com

---
Alice Ryhl (3):
      rust: iov: add iov_iter abstractions for ITER_SOURCE
      rust: iov: add iov_iter abstractions for ITER_DEST
      rust: miscdevice: Provide additional abstractions for iov_iter and kiocb structures

Lee Jones (1):
      samples: rust_misc_device: Expand the sample to support read()ing from userspace

 rust/kernel/fs.rs                |   3 +
 rust/kernel/fs/kiocb.rs          |  68 +++++++++
 rust/kernel/iov.rs               | 311 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   1 +
 rust/kernel/miscdevice.rs        |  63 +++++++-
 samples/rust/rust_misc_device.rs |  36 ++++-
 6 files changed, 479 insertions(+), 3 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250311-iov-iter-c984aea07d18

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


