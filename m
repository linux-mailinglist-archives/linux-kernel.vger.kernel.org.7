Return-Path: <linux-kernel+bounces-855169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE4BE071D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F891A234C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1F30FC3D;
	Wed, 15 Oct 2025 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGZH6309"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526430F936
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556722; cv=none; b=fCYggRhtwa71e//OthlNC37IfITPX1oSP2PzwGICp1aWo1Q9mSQ8nnLrdvEl2NH7KVkYqEn7Q6/OXU+pRuig9KoAmPH9QXqUikO6p5QkMf0EAtdSL8OVjQh2HmZU4N1WDNG8Qvr3Nwcs3bu2p6gC8HyCBNVQh8DOa5HStRIMqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556722; c=relaxed/simple;
	bh=vFQ57qEPFFK4a1P47Xt/5YF6jxl+QY81g9//5V0r9E0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jpIUO6pkLLxD5FdeWU5TSHwYtdrFCg3KmMOauh4SdG5pezoJMUgtg1q8lm9li8t5WdztAHPy6xWoBz7KBroVgtx8FVfP6ss3YMD3resIqPfjSvqyDOeX4w9mABhbYSlEkziDL6qE6c/s6iW8wBmwBkJQPTTVxaWvmGiCjJvc9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGZH6309; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e509374dcso30896675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556718; x=1761161518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gjm1LijoOvaR4UmxrMCJ1ivWAHmFdej62IpC3mzcB4=;
        b=BGZH6309bU6Mbs+3J4LnwjlKP1TsCRa6yES/tI0VhKD0BHpaB3l9FbZn/UiCGA6H0t
         yMSuoidfrDnDN03lgz3vU6xT41uflImWK255l4gKelA07Z81mnhd4wQ+ZyiyXwtJ7gvm
         K3CDcCMmL9Tb415htIo0hUQAfWC1u+bFWq5gvcAjMylvCPyIYKJoMuYJTq+gIWc1oEqM
         sjg1Z0NuJEH7E88Dagc06vJhQJ7QpPtiNJjX1UCfwV774xHHQBCFOJIARrw4s/RYMrTc
         aYh8x0Oh4eZuINjdmnyD+/PRkjVu004xGouOsPRGvh3VI68Rt6uo/QIK9y8emDK8CUky
         mB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556718; x=1761161518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gjm1LijoOvaR4UmxrMCJ1ivWAHmFdej62IpC3mzcB4=;
        b=SK93UFgl1hgWGjGKyBgnW2lV4WUi8dDJh82LILJs5qH5wJiKChjSUDWa2xqrtgm2nV
         jVchSZPPm1KdR/elXpL+ry7Ur0bY5e+t0g09fynwp2NggKWUFYuzjgmfDJpKuDeTJXIU
         xmoTJFvpUO/6xoc9eNGAAx1Pk4ECsHqNT9RtYnjvC2UD9Ys3HzaNH+mOlgOdrUvTlHWJ
         yJ4uz9BFiNURNYNhDuEFByjyiuvaHWZK5o+2NcU+W/giICfvp9Nw5Pkqk9SjIya1woaS
         saND00P3oz/lmEBgmkPUQKZ7f3fXobBbRuCAPsJ0jCOc57DbjBbDpTrg3DoSCT4WoaXH
         E2uA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcN3s4y9whjJzrbwisEtDmRVYtdKZvuLs7hjMmPoFjWWdKcp40Hv9W3zADpAsGx2cSPvYI5YdcRD4m6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQ+f1mjO/kIdBrkoVGiurTGCW3btZQlGpEMEuWeh12sEmb4w1
	kUJgo8xR9whH9F+eqqi7OBFfnuAwNd0rUMp3l4gIP4GXrsNiUgLBjxPwYWxCldyaO8jdK+3LADu
	LY5Hoa4YeSnsDkpflAQ==
X-Google-Smtp-Source: AGHT+IEL/VHOLFHuIoVUiV/D6Bqe6tW62TJ5aBz6rcqOw3p0/Xw8HWgUhNCxtEkFwsrO9XapAOq1uGfyLXGMMfk=
X-Received: from wmbd3.prod.google.com ([2002:a05:600c:58c3:b0:46f:aa50:d6ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138a:b0:46d:7fa2:7579 with SMTP id 5b1f17b1804b1-46fa9a96521mr194128565e9.9.1760556718448;
 Wed, 15 Oct 2025 12:31:58 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:31:57 +0000
In-Reply-To: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
Message-ID: <aO_2rb29XrSn0qo3@google.com>
Subject: Re: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:36PM -0400, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit 9def0d0a2a1c ("rust: alloc: add
> Vec::push_within_capacity").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


