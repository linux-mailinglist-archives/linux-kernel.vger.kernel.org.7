Return-Path: <linux-kernel+bounces-893195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA4C46C50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71C41885E82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DF30FC3D;
	Mon, 10 Nov 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oda6rXeX"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0630DD01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779976; cv=none; b=ZXL6fSR/YTuyBipV/2i9ovEyfWj7kZRCTzeLks7YVjoYrUMcpC84Ikh604k8q+ne0DvNUIq2x3VA5Ctknb6r73tS/ZdtXtHFu57BIOqEv9GCZ+Y6YiNlznaIWn/ThPn+u568A1FslNWIPkDbUiUqlk+dYD9IjOC0YSq5qpDpz20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779976; c=relaxed/simple;
	bh=tZRDyWYdKxPLRzY59T1u293s6EPRM48hRBGPoRiv7Q4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m9aUTgVhav+ngc70sCzsLeEAdlyxA1l9G9S09fMrb7evzREt9B8zRqmquZpk9HTmryb1H3LTIFDAhnfbxN6/d808xwsPmvkP6A3tTT5Vj9lQbGLg5+F8Psoy6w7IXJaVAPWUzyL+pl1cKuOsJIs9CnpanfK2nWXdVEoIlvOYkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oda6rXeX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429cce847c4so1246396f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779973; x=1763384773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pzTvyKDs8JGpPKd4Xv0v3M9MRrwpEZGrtj//j8VX/HY=;
        b=Oda6rXeXgme1ZP8hCZpVo+yx91Wrnx/jvytIt6nzLd3Sx8rFwIoYMykklF36gbOWmX
         Gdm/ejkdZXAoeB8CqHwYRmYSe8WFtmjqiQhI7YSjqNPnVX4MGLlQLFdZqa26/vjjlqNB
         XsTnAVS/xfrNQExFjdOsJwnqwsyd0F/zv+DFp9vv+iYJte0JPKGihK3LMmS5xwFFOW8z
         2ep0ZPR6orw07s/m9fdd0h9okQI7P8R+YitGPfvh3TFPfxryR+RqxHL428nzjdH09AuE
         G/bl+fiR4zWhTKGF7aKNaNg8zwbaaQOfqwqaxtwwpcFpSpgnlGisklGeT69E+/0te0ue
         N4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779973; x=1763384773;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzTvyKDs8JGpPKd4Xv0v3M9MRrwpEZGrtj//j8VX/HY=;
        b=m9hgn5vMObO6rnBqfSnhApgrKsLIPTeuBOS/64TaoG91i7PePp/xteRM00lIbGd42Q
         yOOTQlSgNJ33x+YvUxjFYR5kgp9MiLF0UqWoK0u7pdhbZYT9HtNqKOb3ietK/hhzQttk
         t3Yrr4g05gq+fujdJFKPoMu2SnoXqhEnNptPIpVF5opQ71mhr1Pfwe3jhM/Y8nfhx4r2
         U0j9KEpNblEBZt/3lzZxJTWa2SIXH5ATBgG9mOaMBlc9kDG5XP1LYc/rawObZD9B8EBB
         bYEQIkROrmujG91fdpgv/eaQ3uSX3PfJiTS7mcoGZuuu/d3oTaPcoMqt4yG08hgzrkUf
         9ijQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Do738XHYQPIklYQXm57o/PxyXY4EC4YCgJU7Ih4g1wmsnpzvq7QVuDmL8LtApCNhCF2K5uorVH3fpiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7Ifn7XhVa1aDHlpeFdXt5IQypFRcAAJnX0fMVt0YqV1FeUun
	b6vixYGDeY0ObL0z1gawCJJ/YkxxP0MvNs2974mvssMA4vP6A6cxG1/0eyw2j3FEEEem/ij3uvn
	DbhDc2FOQNhQFezM6VA==
X-Google-Smtp-Source: AGHT+IGfGJaHdlyg6c9qJZL7P9A5QxGDbVm1Oa6UXqGuPmuwKp/Tm6pTtowv1rDLJUkoId/jWHgo1qXPjLsxEVg=
X-Received: from wrmn2.prod.google.com ([2002:adf:e782:0:b0:42b:36e8:75aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c8:0:b0:42b:3806:2ba6 with SMTP id ffacd0b85a97d-42b38062e61mr3706733f8f.25.1762779972816;
 Mon, 10 Nov 2025 05:06:12 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADHjEWkC/2XMQQ6DIBCF4as0rEsDg4J21Xs0XQiMSlLFoCFtj
 Hcvmi6sXU3eJN8/kxGDw5FcTzMJGN3ofJ9Gdj4R01Z9g9TZtAkwyDljimrXWwzpTF010LyqmC2
 lrDWvSTJDwNq9tt79kXbrxsmH95aPfP1+S8AOpcgpo4UqNZrSWGv4rfG+eeLF+I6sqQh7zo8cE keZg+UKjAT9x8WeF0cuEhdQANhMC2Dqhy/L8gHaCQfSKQEAAA==
X-Change-Id: 20251007-binder-bitmap-5aa0d966fb1f
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tZRDyWYdKxPLRzY59T1u293s6EPRM48hRBGPoRiv7Q4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpEeM+C+nueeClFMSvnBkuwbFbPdXtoQ6NouYL5
 IgCe5/9DUyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRHjPgAKCRAEWL7uWMY5
 RjmsD/9t7OdWd+BXGvQtvYrXLv8VJoD+LQaZQ98D92pSKFoR49HmqXrttTx5Zm8X+xwHBuw+9HH
 5gF8kRBxD1gV6cqYTM9NQdQskc+SR4UcNTUbjvB7569DqD7XAGqb8vOccW22ayZShFOsiuNs0+U
 hNCXhjIBg39poU+Y11uzMj4+2g9aIj9ytOec6zOJKR90eNhr3tM0sqJ2G87LkqV3sLG5DXeaymj
 d6+wH3Jwq7kRbOakpdzXrf3wlXHXS54/RDX/hYnyvVUDsZ209BFW01qDrD1xWaFxVMi7iEfjnLI
 ZtR2kWNMMjpk2Hu52xP00YHgFVrvmiGTsoGi+y2NDQF5NXGMFsOMAKSNpEaEL8cQPz3F++bqIRF
 +LIX6BIFbYjrtTH0x5CBy/Xoe85t93FIwqRzGPbKKEtNAAfsBz1nY1XUGBblRcGLjHDUR6oTIdd
 zrdXdefuZGFmgWWwTKuNl/LzuOClRJl1t4MIN0YuDPOaJspGLSEYgTd4wJ59voU0hoyYYfkbEVG
 O6YpxTJJuCS2RzfJylae1p/Bt81qcyIRsVX45ha2b8LE9MndY85KWJ3zOGGTcb8gGGGBkScQYDB
 NT/zHHwGp4tfCScwoXrCZ7sSnza2Vtk6+LUL7vva04H1JmrGM2gf6dri8eJoJWLoMyTCKLcdb5G tEMKpYgQ0WnX3lw==
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 0/6] Use Rust Bitmap from Rust Binder driver
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

See commit message for rust binder commit for details.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Keep existing IdPool constructor (renamed to with_capacity).
- Undo docs changes that were due to the removal of the existing IdPool
  constructor.
- List id < pool.map.len() as invariant for UnusedId and mention it in
  as_u32() comment.
- Fix [`acquire`] docs links.
- Link to v3: https://lore.kernel.org/r/20251028-binder-bitmap-v3-0-32822d4b3207@google.com

Changes in v3:
- Also update documentation to fix compile errors.
- Use new_inline() instead of new_small().
- Reword commit message of "rust: id_pool: do not supply starting capacity"
- Change UnusedId::acquire() to return usize.
- Link to v2: https://lore.kernel.org/r/20251021-binder-bitmap-v2-0-e652d172c62b@google.com

Changes in v2:
- Use id_pool.
- Link to v1: https://lore.kernel.org/r/20251020-binder-bitmap-v1-0-879bec9cddc1@google.com

---
Alice Ryhl (6):
      rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
      rust: bitmap: add BitmapVec::new_inline()
      rust: bitmap: rename IdPool::new to with_capacity
      rust: id_pool: do not supply starting capacity
      rust: id_pool: do not immediately acquire new ids
      rust_binder: use bitmap for allocation of handles

 drivers/android/binder/process.rs |  63 ++++++++++++++++------
 rust/kernel/bitmap.rs             |  26 ++++++++--
 rust/kernel/id_pool.rs            | 106 ++++++++++++++++++++++++++++++--------
 3 files changed, 152 insertions(+), 43 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251007-binder-bitmap-5aa0d966fb1f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


