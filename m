Return-Path: <linux-kernel+bounces-888443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A831C3AD21
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C88B634D3EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A1E322A24;
	Thu,  6 Nov 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WU13PWU9"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744732721B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430956; cv=none; b=GHiKun3XprLonIbCZvzVzSspvRHfwkQHKzwQqaIG/vjNUJpsgeIfkHFNnsqkNpqrCuezwEf4tRBi8IOIlafIgwTgOp2CGSmrG76dVNzc7w8MbnoYBzlQh1HaSKHYM7DEAQU2W+JjTEJxYpoLD9yi5KGVSMfCczoa09UsX6BFJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430956; c=relaxed/simple;
	bh=PaKvBJJUvzklLSh/etTvpynoQWRBtbVS57WsNqJijtk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewmPFIxr+PyxVpt99NynaLfNkTqK4uaPVfwXOIjPddiZC1yLKKBQs7FKUZW7XkAgyd0vpbQ6u6EMpdS9YpSlvY0gIQaRcow7CRE2bL5eAaZ8J8RFjZlmOy5M/0uctJ+pzbPTyhpJ2+q5DZpndDXVn0xQ2Rzxz/80HeaA246JfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WU13PWU9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477632c240bso5854895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762430953; x=1763035753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYjh895sOQ0wZHG0qaTEVmBEXBySMzEq2h+tanPVig8=;
        b=WU13PWU9+bX5YixW9URgjETjLAmL+Reju/qqOykXq1OVj8ZM94Bmfi4e0ryE0kSOqp
         OP72mdvAzetjfmbTfC7ysj0ntAiZwxd6CB9NzbhBdQ98sAl0DyXBxv6fHlTraoBY/Umy
         N7fnX4zLmkGYyGD15FdXbQbh667qEyhmE72bmRNn9p7unjuJlf2h+/T+TMXx0GZGC6dX
         zlIyJfPrL+7ARnekPb5lZi+x3Cpu2wuxmCyYHLRmABogOvupx63/CLK+qXGwwL4Y24Cj
         wnr9gfbzSGqFv/dsnakMAI4l4bXrynpaLL4DqAlAV6aZPtnUfzlyEIGNZmm1zuXDXq1H
         ajtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430953; x=1763035753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYjh895sOQ0wZHG0qaTEVmBEXBySMzEq2h+tanPVig8=;
        b=A9UBvejQRds5lT+BSCDym7OQ4Qcem6rDhKz3eMOZuyAXm8svF9pUCTHe8JnHBe8oS/
         P398PJUmTBhNyaebJhZAtKznPQ06qUNyZX84N02Lf7jiuSTjW7yiG6HOILSJAPImhzQi
         NDW4gKj52XXtBBb6P515x6gfMiLWNimHZ0R5u+lbiQ4NTjRqP0KhkIg/uWU+TPRyUYZr
         6fJO98yj+9nRfHcWVh2/wjfH5yCtSC6qi9ApAjvNvG6KmFsZY3hMLblnNenkrO9uy+22
         qnabGoo8KGFlOQGI4dipCklE298CVgjKVMEYoCYWRJbIx+1nAd3sualDWXZHhc8XzJuC
         EvPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTCx87AqE8XzB2crzE4Sz69XrVpJJcLthc2MjQCfx/oNaKwl9OBCLvdFACxt5126ZJIvD95mS/TOpA9Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2g3DtKjA8/4rzANW0ainySvFUEXL6R4AIuEc2WB0EcEFyYIIo
	fiX5tUPDgGq4bBxOV1yRYgTgUG/tAstUQCufxG+0mztRJyI+/DoJbxftKZG5t3y+FDb0NClA+Sc
	3cqB4/BWM31utGwwOug==
X-Google-Smtp-Source: AGHT+IEamd18jj6uRBeSGyhGRNOi+lGXB8EXUCxbM6LPE4tOPIsbRl/P31hFj+mBgZAIWzQuRIUw83Q26LtQc4A=
X-Received: from wmlc13.prod.google.com ([2002:a7b:c84d:0:b0:477:1449:b093])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5297:b0:477:c71:1fc7 with SMTP id 5b1f17b1804b1-4775cdf61f3mr47082935e9.26.1762430952736;
 Thu, 06 Nov 2025 04:09:12 -0800 (PST)
Date: Thu, 06 Nov 2025 12:08:59 +0000
In-Reply-To: <20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=PaKvBJJUvzklLSh/etTvpynoQWRBtbVS57WsNqJijtk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpDI/mrOuyf/GH4VdeFehUKdKnNsLOKRAV1z6g2
 lB5wL6TxCyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQyP5gAKCRAEWL7uWMY5
 RqGID/0Y4Yjkqdz8dNxoJ4kFNhRTiO2nNUx/ssl6f+4yNpiKEg40UnTc62uOKvoVNEBWvAUadY+
 dzmY9aDGkx92EEK7Rqy36jV1NAu4DO0a9NQ8bQVajyOH/QNwve08IO/zk974tTbbpa33qv+YKnh
 eDLSNXluSWpmK5/52cX52nzofvsGcDRiSwkVzjOF3f3Manl6ohinavzA6ZorX0j70kS0CRmu9NW
 tXGihJ8OR7w2dlTVUHiPJuD5c9AA6yE0Y0BX0/mc64iFs9Uz4e1f5iZJuk76pnSutZMkM1IRTuL
 IgrjdSCGhVbsjDYUI9cI/R9lyk+Ac7vNlwa2nDUW/r2fHRuYsdKwZr1llXytqBPJQmEwpQIJMxi
 BLQLntndt/DQK9ThK6Omomds5C7wncUmhEl+c0B6Qnv61bXai8pFIB1sSjqO7xaPciFF6GshJA3
 e2pxomSwIqsf6R2kwLSQol2np8cdPkj7h2O6yhi1OmYsXdrt5u+eXK9KRUteprOgjouKr6EhX74
 gNWAaZsuW/b3RhhB6JI1XEtM4ayW0MJ8+02DhM3QWqDq38nzCngA9rNkOtGh6Shbp+lK5M/PqF+
 c1I4sur2LuKtM7NzHuacGagAo1xvxX6Nra1UzkwqjssjPeH8b9XMnEccGijVERTLBl6SwtKOPnd Xn0o4TrwvxHLyzg==
X-Mailer: b4 0.14.2
Message-ID: <20251106-resource-phys-typedefs-v1-1-0c0edc7301ce@google.com>
Subject: [PATCH 1/4] rust: io: define ResourceSize as resource_size_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

These typedefs are always equivalent so this should not change anything,
but the code makes a lot more sense like this.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/io/resource.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index bea3ee0ed87b51816e2afb5a8a36fedee60d0e06..11b6bb9678b4e36603cc26fa2d6552c0a7e8276c 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -16,7 +16,7 @@
 ///
 /// This is a type alias to either `u32` or `u64` depending on the config option
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type ResourceSize = bindings::phys_addr_t;
+pub type ResourceSize = bindings::resource_size_t;
 
 /// A region allocated from a parent [`Resource`].
 ///

-- 
2.51.2.1026.g39e6a42477-goog


