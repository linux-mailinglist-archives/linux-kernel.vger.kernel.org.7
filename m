Return-Path: <linux-kernel+bounces-770893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C11B28014
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442BEAE11D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228483002DC;
	Fri, 15 Aug 2025 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOyBYyV3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6B28E00;
	Fri, 15 Aug 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261437; cv=none; b=NUXeuG/rCz0atS2LKTvO6g60Y1OFXVY8r2as92xynOuUWDOs+TLG11hPycx2SyP5rgw1zteBZRWKHl7U4VPXdapzd9yz7ibdvWPcBpvNZDbLc/2BZ3vkMvrCXM7VVQEZAnOoAToKN7Xt4f1CDPfGFxa4EEhjchWYW6t3z+OLLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261437; c=relaxed/simple;
	bh=x+TXeZu/c7crNaU6bjOA+WBFpG0+Z2nzZboW9ou43Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqELZ3MBP+pQTxG/PRlA3dtHwgSOBkO/DkE6ujRY86ep3Ev0zp+zk00cmY8L7GdX2suVuYQO6/1u2noswxt/tuSwgZ3eDyFMMydcD3NzdEYXl9EuVV9ZKRo994A/t493fw2Ka3feaKwlJWOKp27M+5EJGtB400PxXQdqgg+xMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOyBYyV3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e614b83so1467751b3a.0;
        Fri, 15 Aug 2025 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755261435; x=1755866235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9W+fnxRKwsiMPh8XZgEaL8gtXChF0KhdZKmxea7Uvw=;
        b=ZOyBYyV3dXrKZYUquNkd2K6htZsNdD7LHQykxXD+vGZfs+2+OSwX6wjAPerubcQcf/
         K286tCycST7gtSZ2dsBfexTBAUtq+zfkaO2H/SqMEtrsZkh13Fa52iQgon1C3frfevKh
         HZkLK+xciXXqY5nmtDcNx7tknR/jVHPybsQsov+W66lxXjBwaLsv1WUj2SH6dJPw/YOu
         hutG3E7JiDXpJ9bTO/m6bnEwZ2y97BN7m59LX62IQhifVB8XF7WnlgzKGUM4ERNAdMPj
         92nMOznm3QLimiF2FMAEMiEXhkpcZ3TYnQZZUUD6zGmAmDErxK+1zoHh1cp4XbSArrBK
         Z67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755261435; x=1755866235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9W+fnxRKwsiMPh8XZgEaL8gtXChF0KhdZKmxea7Uvw=;
        b=FwOBHnSv2z1fKNft9dv420IDMAkOWqyBQy02wz2mLQRhKBhg078l+RBHTBoySFXkrc
         iSYeIvYpQpa6IxeJzZVlMAavatVKzpgiLWhOF/mCQUO6kKw+U+Iq+aCAuW+e4F5omAaj
         24ovIAyffTOeGFA1v3BD0QmLEevYd5/vNL/7fNbjPNaXSbzsEVR6PR4cYMKcgAs7+eR/
         UXxyZSnMmlBZ45hBN9anR16btOLw8xk0wHQyhVJwit7F9810SXYcQshGFrcGldg+Cz82
         0iLZzkdtahfsqzWCM7RJPp7c1Hce2s1B3gFb6CYX97JgDYI/WshrZlW4E7j3nLLsi3Na
         JLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yS7sCle6WXmc63R2/rPKleZuOqQYuQVuXa0F1pX3OuRTbD3hE9RugU1Nzqbrom/dFyzRdPAYTswKVGFcLaw=@vger.kernel.org, AJvYcCX1CdELS8/hqp/pv2a+6JzXEVKMpS1CKnjqMgBBZYuRT9mSbbIrUDS9Jqf7M1ToxSNt3HiSRuiFZybqNYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdM3eyd3o7Mglrq3+aAFx6C8i3/WhK3Rt+B8cZLnMtJFCwpdY
	U3WGZx0g35yPvxAzlokKXAstGcv04w3Xy/Ed3AKQNdMR21S6pNdAnjeU
X-Gm-Gg: ASbGnctfUaiCtECJ/IVsfOi2QLyLYL2v+HFEFqSG/7MJC3sAcGkMWF3tBJ8sWHqtQ4N
	Ck16Wf/6slnhhwaoKo7YB8OciZHYZJBYDWoTuIA5HLY4UJqhG8akm3Gm6q3LYXpZSwvuZ6Eq7P9
	lvopr8lDuX5xi9oZZ9d8gER+4cwuMl0TYr2RtICzb38pR23UcskPoixPPQkamtvm/HIzYmTqgjz
	RjAqZ85ptqxAZltPRfHVfIJzhGZyCptl2sAfTCE+vTjyi15xb72sGcevsvG4CUR24VAy14eW8rg
	hodaL4ZIJk602SuSUZgcTosvk19B1agbzOHRFUU6Ttf2EbbyNEYVoyeN+Wn2D49+nOrJfCHsTKV
	SNu6V0VLETMgyio/+kspIU5X8Fbzp/ai5wC4E
X-Google-Smtp-Source: AGHT+IEA0GkTTJ82kY9ggqEwGUcTFOq51FxV7ZwuTQOxC2M5K/4CxQawTsg90p6ITStzzYjYIZKHng==
X-Received: by 2002:a05:6a00:7094:b0:76b:ef44:1fa4 with SMTP id d2e1a72fcca58-76e447c29cemr2164608b3a.14.1755261435174;
        Fri, 15 Aug 2025 05:37:15 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c812sm1081370b3a.45.2025.08.15.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:37:14 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] rust: mm: update ARef and AlwaysRefCounted imports from sync::aref
Date: Fri, 15 Aug 2025 18:07:03 +0530
Message-Id: <20250815123703.1256338-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716091158.812860-1-shankari.ak0208@gmail.com>
References: <20250716091158.812860-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 16, 2025 at 02:41:58PM +0530, Shankari Anand wrote:
> Update call sites in the mm subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintenance.
> 
> The original moving patch is here:
> https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.ak0208@gmail.com/
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/mm.rs             | 3 ++-
>  rust/kernel/mm/mmput_async.rs | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 43f525c0d16c..4764d7b68f2a 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -13,7 +13,8 @@
>  
>  use crate::{
>      bindings,
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::{ops::Deref, ptr::NonNull};
>  
> diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
> index 9289e05f7a67..b8d2f051225c 100644
> --- a/rust/kernel/mm/mmput_async.rs
> +++ b/rust/kernel/mm/mmput_async.rs
> @@ -10,7 +10,7 @@
>  use crate::{
>      bindings,
>      mm::MmWithUser,
> -    types::{ARef, AlwaysRefCounted},
> +    sync::aref::{ARef, AlwaysRefCounted},
>  };
>  use core::{ops::Deref, ptr::NonNull};
>  
> -- 
> 2.34.1
> 

Hello, can this be picked for review?

The initial patch which moves ARef and AlwaysRefCounted to sync/aref.rs is upstream (commit 07dad44aa9a93) [1]

Thanks,
Shankari

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

