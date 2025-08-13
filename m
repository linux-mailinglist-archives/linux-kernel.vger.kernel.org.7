Return-Path: <linux-kernel+bounces-767411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E27B253EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FE25A56F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737332F9999;
	Wed, 13 Aug 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH+QN3as"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0062F998A;
	Wed, 13 Aug 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113193; cv=none; b=bgRmePeE+i6pQpgrJfp1AoqAqJYg1QcNkgyUzvij1200N3YZ/tLWc7g693ykhXVlIoWN3xq/SBeiI4WBkV5+TTHTYyu/jN/PBKZ4vcTtG8zyRWSxN0ssNEG7yT5RpPVpRK/KGYXXu3a+OEtbZw803vqf6GXHdU5jtUGUlNL/G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113193; c=relaxed/simple;
	bh=RFBBQlHRnkNYzzKSJ6hIcRMJ4NrYVoHlFmTcHfe4flg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6946x3Ga9bYEbaESqy/KW68cSAegxnm0v1knwOhufRgOgHEh8RQCYHF0Dsum0XCn1tu6Jq/PzBUc0ExW7BbcpCzsuOVxoFbrZJZ2jzZ1M4SK7qoXm5cnrBT+aqIYBEM0zfTQSEUItvBhriAgCANp5ch23MJDD4uCHC6jUxz7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH+QN3as; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4717563599so75430a12.3;
        Wed, 13 Aug 2025 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755113191; x=1755717991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poj7FxUdJ2JTjxAX+M2fvgvulHtue+zz+NWRBAXK06E=;
        b=KH+QN3asGxw4fv/CgTmri+z/bi+DUM624yH9ctpk/WV40NmAYjfLmq2ew9FIKUqG9D
         4YPqi+272ucVtZam3IHrbcvuli+bsZuUbJjv36xFOYYfGS5Jt4htDU4cmMCBFxfW7CQb
         cgieuAjYaNaD9UnQCe84G/0uoSjuCfJ4LLkyiVYx9lh1UqMNzDxeSvZ75rglDMH0a1KE
         UJR0gdk7I8a0eWze73wnaXBuelSm7EzWMNGZpIPoh5xGmREolg0vBBioyHmka3QZDhCb
         zYKYN2YzGDIxeX7SrPXLo9jAkAEtlJRPgbRJ7t3Tm0xXDrDXv4aWyFeItsRaRLGK2Q4S
         loxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755113191; x=1755717991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poj7FxUdJ2JTjxAX+M2fvgvulHtue+zz+NWRBAXK06E=;
        b=BriQOP1HPd1+xDRJRX5j85HKMa3WvmsgITKxn6foRZdPaWbd0wjmZj/H+wIngf6VzY
         Cuf+E89v5Jw/jTcPzqTIlPcUDgNyl00FjyfvOD38Uijj6yhMzPpy5KKzNuUvlfydhT80
         NCptzTRiFN+wiksXnhwtt1QnA1h72bY2HvBiIg7OTxov84/WhC1E2jm+Gtz+x5xXvVVF
         IB9Gs06qkLUY4KCKDCSJFrxUZaq9e87zYrx1nbqZnBmsyxvF+hkAcd3W4gxGPyLTAkVu
         UM5vaFuXVVKoTQ22XWDqDu6WQX7sv9XppoXOHN9LVzUjeg091DF9ALrRQ+4+oEJwYVQe
         adTw==
X-Forwarded-Encrypted: i=1; AJvYcCWnPhL89oQmm93XKw6oKqaRSGTz994wI59q6Pf+eg7UxLd5mB1q9l48H8ur9bPezLqcJnG+k8E80ZWscPA=@vger.kernel.org, AJvYcCX+EZdlO54pyLkyL7YHpZ1IhCkxsFsouo/Ciu8+VIe/TUW/3oCjl50oyLNhJgYoaDbOV2U6ZlXYwkaS5Vv4iSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6lTjYkjOQHFCsc49Bx2RkwU3wsdiD/uA/0K217lpGldd3r+b
	auhKUGVh7TRd35PSPsYbTWuXXIEhs9UhLrbmxUTr5nEbIiu5RagqT9JP
X-Gm-Gg: ASbGnctrY/PQy/9sFNLY/lJt4l68RNjRbxTAvnKd+KgPtIHU1xZexEgoFJp+BhMNJ/9
	1QPfRIsFV6KZXUt5NBfq1D2TvebBIrI/ovgGxZKExvqxknfAb33YY8nkCgQA7KorWqtbdH8RG01
	i767D5f3hTGYJJoJEgwSj/JYbWNeZlOXfr4LMDnUB3ZbkXGD7inqZW64s+MMoTHW2MObm4r9RJe
	xhNWo3drGcTEgIMnm2WVjO/EfweIJ1Lgvg+hIU31pVclcqBv8AMuYvcl6iJod9H4bT7Kz0X4hXV
	8zefMaKlBbbsLPYVhV8/SpN84+YOfE7SpT/KZJKZURr2Xi/4zdATEenaH5ivpRGiiEZujGax93X
	iIckcmx3GlIvjYmQfXclpFRT4+EPvuFiCRO22
X-Google-Smtp-Source: AGHT+IEGj1Q2xRz6Xt2WVuCgpqbRCBJdrpMzyjN515raj6kZrfnWdWTXSklBiROvb9eYbWPZiQXXng==
X-Received: by 2002:a17:902:e743:b0:242:fbc6:6a83 with SMTP id d9443c01a7336-244582ca727mr4225945ad.0.1755113190679;
        Wed, 13 Aug 2025 12:26:30 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2422ba1e09csm306391195ad.16.2025.08.13.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 12:26:30 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 4/7] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 14 Aug 2025 00:56:21 +0530
Message-Id: <20250813192621.25255-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716091827.816971-1-shankari.ak0208@gmail.com>
References: <20250716091827.816971-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 16, 2025 at 02:48:27PM +0530, Shankari Anand wrote:
> Update call sites in the fs subsystem to import `ARef` and
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
>  rust/kernel/fs/file.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 35fd5db35c46..18cf579d3312 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -11,7 +11,8 @@
>      bindings,
>      cred::Credential,
>      error::{code::*, Error, Result},
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::{NotThreadSafe, Opaque},
>  };
>  use core::ptr;
>  
> -- 
> 2.34.1
> 

Hello, can this be picked for review?

The initial patch which moves ARef and AlwaysRefCounted to sync/aref.rs is upstream (commit 07dad44aa9a93) [1]

Thanks,
Shankari

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

