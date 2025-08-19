Return-Path: <linux-kernel+bounces-775721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C45B2C402
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AF5188ABB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220163101BB;
	Tue, 19 Aug 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zesjhzVD"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6123043A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607316; cv=none; b=BnFzMFIQ6dD60BjX2Y7+Rkp9XOxBCL0xzdaUIx88gnq/CA1oK/RluNnDCCTGMpj0OK9ZxXf5AbDyjByqz04q7OlXm/WzHPGNk14MeRwCdlniawpLtMll+6Wej0JevH7aOjaaZyqjoYYMU5d9rgKHl2BB10lvFnLWzB/SDUsDUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607316; c=relaxed/simple;
	bh=2oNXOoxywYfVBFFbPZ7hZAbK09R5OqnjTJGfv1ceELQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qal5rrp8zUtWSthQ5lzTaxZt1hKMXGKPHaqkhj2oN1MU5Ify4WYnj9cpi/tpV+svcNt04o732+zJ9tjWk10f2cv1DtQLpHFVsBc+FSjkY+rqfMZ6M6MhMe+TmFbMe/8xVA3kr0vf4lV+SrI0dY9IWUMkrdEUDGF5OyE7jZ62ySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zesjhzVD; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9e4166a7bso2641196f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755607313; x=1756212113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZPu71v4iJrj40UYhCf2EubxUaw6sgyARKI4hkp1H/4=;
        b=zesjhzVDWBfqUr6mtGxBhk2nDVrSj3y/LqNH5RHdUiuqLyUvCKA0PMn7muc+v4K+/0
         rV69pTnM7S5jWJPcBGQSk/I/kGgR0WYlulhCZ/Fo8kMem+Fv16wyVB428XHJBwbzwpR7
         Uo3a3mqU2PiNJ/BuN41m6QT/xatJ8aDr8OL8553m5L8NiBOVT+fQrOsc6CQaf55RjKG2
         938p2eRN9Ay4u7AbpH6ce2RUHjojXrPVxD38arADQWPC//WGGbqqdopASNvvj1ZG4mDA
         GS1FsV5btfjI6ba9YZOuNZyKlqKT+GZGBUg/WbdmF06wyNcYmPgWGzhK5v0Oc8+XZxBM
         7Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607313; x=1756212113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZPu71v4iJrj40UYhCf2EubxUaw6sgyARKI4hkp1H/4=;
        b=uC1bwKO3KRTLc4F527wz7avpHYoY75v7jcOSi3ISpTJhGeUoMAwDHoMz48BwLnKeZ1
         it5FbojGbMYW0w/JZ2iOXNembL8jXPt3olVpYAxaALa8MUqJWrDnRAab4N3hwzqXDDTF
         TlahF/H93yaFn5B4oELUP3pRnwyLRXLBxE8oxTN3mjXG+pZPqNgE30TFQLI7UMlX054O
         F6ILMvUl3uaaHT1xAfwAefF6sY/L9PeTy9OAYO8jgSrjXmyF9Kz5qqYB0xOmOdWr8ihp
         h8TT2u1v7LV4S1pJY/M2SlPBcAabwdcx2YVe5bC/c27iKksWVeFpNjZXjhUlIVMfzViq
         9GSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKrc+TIkqIp2i6d6VlooG2Ry7xss/3psaRW1gXdX3EIUggY5eRW2Wg3AllclFLcXEeudErgu8fyXTR4BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVX7e8XX6IVIhLl9Fj2DOcVmGlE1tj0y4k83al3qmPxu676LF
	l/MJYwo3/MCjEqCOxOpspHXMYOJasT4DA68e6X8mN7l72ZWd2y+xHHj/VC8e8Uhgr1ulMDswBhV
	Fz91RuHmfMaDO4FMTEg==
X-Google-Smtp-Source: AGHT+IG4HvCG6xMAP0kc+KeWFDcdVkf0VrlLc9RsRO55bsIjMgWKuo8r9NDS3JOpE0Jihm8a/GII747UxtSnXhc=
X-Received: from wrbee4.prod.google.com ([2002:a05:6000:2104:b0:3b8:e8d5:b8d4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2d08:b0:3b9:14f2:7eed with SMTP id ffacd0b85a97d-3c0ecc315fbmr1499787f8f.56.1755607313087;
 Tue, 19 Aug 2025 05:41:53 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:41:52 +0000
In-Reply-To: <20250819-maple-tree-v2-1-229b48657bab@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com> <20250819-maple-tree-v2-1-229b48657bab@google.com>
Message-ID: <aKRxEEy5ln8qcGGI@google.com>
Subject: Re: [PATCH v2 1/5] maple_tree: remove lockdep_map_p typedef
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 19, 2025 at 10:34:42AM +0000, Alice Ryhl wrote:
> Having the ma_external_lock field exist when CONFIG_LOCKDEP=n isn't used
> anywhere, so just get rid of it. This also avoids generating a typedef
> called lockdep_map_p that could overlap with typedefs in other header
> files.
> 
> With this change, bindgen will generate better definitions for this
> union, which makes it nicer to use from Rust. This avoids a cast in the
> Rust abstractions for the maple tree, ensuring that Rust's type checker
> will notice at build-time if ma_lock is changed from spinlock_t to
> something else.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Ah ... this didn't work. There's still a configuration where I get the
error:

ERROR:root:error[E0308]: mismatched types
   --> ../rust/kernel/maple_tree.rs:256:18
    |
254 |     fn ma_lock(&self) -> *mut bindings::spinlock_t {
    |                          ------------------------- expected `*mut bindings::spinlock` because of return type
255 |         // SAFETY: This pointer offset operation stays in-bounds.
256 |         unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock }
    |                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected `*mut spinlock`, found `*mut __BindgenUnionField<spinlock>`
    |                                                                               
    = note: expected raw pointer `*mut bindings::spinlock`
               found raw pointer `*mut bindings::__BindgenUnionField<bindings::spinlock>`

Alice

