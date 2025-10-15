Return-Path: <linux-kernel+bounces-855166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFEBE0705
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE5584A20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B130F536;
	Wed, 15 Oct 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZuJ6Izq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED130EF70
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556646; cv=none; b=oF3SkXr6TnIhK8UoN90649hUhohRc3c8Y7hlxUI2bmrc8DT9PKScxFKbJmLEDtKlpvyF6BNA0ZEfSH90lgYfmrD0ZwOpGDPcjxksW5H33ESYB3/3g7j4LAw/Zm1IGAgpkvChyYgnpgn8Gyx2FjjdUfBEZO1L2qc7625aRNjIsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556646; c=relaxed/simple;
	bh=jzqQsin1H3Ss/7Kc6VHndGMJg2kFmuyjGGetq8PWm18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdngBKpSap0J/U1ayZ+ot6Ewft9R+0+bc9AdI+NVkHKRKGglcBfg3FMNwo/EysdTxeoKjbAMpOCeUccMZQzKWvK7444iZAkRW70MpzNI5fncCPCkOoBumRpYb5BmsjOWBNzxtY78BjitLAV6lgOYqm9NpBd91Il8wuk/Tv4eXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZuJ6Izq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso6696425e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760556643; x=1761161443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=CZuJ6Izqoafy+Z3c8IcwuWNDkEvISuUZMjmZWYfvEplp2xJvHbSCSV/XI3TahKzlnn
         2/VSUAuEuifQEPL1yVM0KfUh0k9C9iAWsB4lbp9C+CKgPZiVLIVAk7TfS923BP7qvcM4
         L9P24234xUEN1wYunFdup7vBislGABuirlydlrly/c6v8V/FPefcaD8jRSCERGEyL0i2
         wF/us8aq3okXfYjesPuwlnNAkTU2LsE/MoUvPx6vcCIDR72T6hK/7aIhHH1xyGo5omFI
         u3rWpT8RrLx6jM8VaLgKaersh9nkzIDtc82OCKLSc8wIVbTZsmlQPCLQQV73nu4LEniF
         BOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556643; x=1761161443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6/JJYv7dgEKiR8HpLccBjLYoTBaUxd3JMQEKy0kiqw=;
        b=IpUkTYWWytYrW+1HcYrzoI3jVkkhnoEBM91/leisEq4Mlp5ro2rkrnRI1VhQztzyIe
         qajnXPnMblZ/U0X33O/z5BJggSQx//7szvUskbmvEvg+JNteUmPoIYkfxKczCThKo8rs
         SjhJjskRVnATuKIZEIEZdnaQ2ytFKb89AdhKgEfAix9PbLzJ+Mh8m+t7xy/T9O3zMP07
         zSelrt56VSxslK/Ax9IFcMrKo1m/vXawLc8+/M7+BsOjKKEG/kkSANVSP/1bwxuWAbpZ
         R03to58F5ILbkwogSuu5wzbjsiqvtdyjIgkWmfbUQmDXrFL2Bz8SaSLQzDhkE7fUZsHD
         4WQg==
X-Forwarded-Encrypted: i=1; AJvYcCWABd8pZSH2nIG2CX13S+jxYyFaSZ/14tU2A9AsBFMRPUe5I+dJqiS7Tdm66CA+iP7LsB9KK8ZyC7mXwkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8jlFVKwQkrfNoXybUgwbc1Hu/8dMT9x+skPN5fZNLO40WwZP
	1zdbCVD1TiAF5xzPs3YssyT8E/PPIpW5GEKyDHvpOYVDMUaAGCAvCB19gxto7dV7QR299xL9peo
	gHzRQ9/jBk/Sh3yj3uQ==
X-Google-Smtp-Source: AGHT+IHUcYtq/jysGTUkDJKvl3MbWL3/M7dZBn/ijA0kzgEJ9Y8E6oSL5awGSBYgdY4Z4z9XH540xUv0k/TvBZo=
X-Received: from wmwn16.prod.google.com ([2002:a05:600d:4350:b0:46e:5611:ee71])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr221043115e9.31.1760556642790;
 Wed, 15 Oct 2025 12:30:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 19:30:41 +0000
In-Reply-To: <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-2-dc5e7aec870d@gmail.com>
Message-ID: <aO_2YXO7C6Jk3EW-@google.com>
Subject: Re: [PATCH v17 02/11] rust_binder: remove trailing comma
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

On Wed, Oct 15, 2025 at 03:24:32PM -0400, Tamir Duberstein wrote:
> This prepares for a later commit in which we introduce a custom
> formatting macro; that macro doesn't handle trailing commas so just
> remove this one.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

