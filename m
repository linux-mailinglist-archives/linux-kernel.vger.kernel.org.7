Return-Path: <linux-kernel+bounces-770438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F22CB27AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C34E1C80ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC582C0F97;
	Fri, 15 Aug 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+ipDgxR"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080617A2FC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245636; cv=none; b=G81IPljsY8CfW4WLjs0LYmYI++YQ8gmDJHMK8zGNF6uoN9vec/ddLfblALIpIyjtpL+HpqIUlYogXiL3M66EH+wOZEmLI6xhNsilLnU9CNVaMIlP0KN/Ti6EdL8PCdLazbzpM7tSenNDBYC1dk4zphwXVjIkYEMdYro+MbzHamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245636; c=relaxed/simple;
	bh=hsWxra9q3X13ElQHCFuvspSvuybQPgvseoguKxJRnfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uat5af/bi7KaLk7MM2Rf8jQ4hE30Awze+mcsXQVsYCm+NbW4J2P+RF/yeSV552nhr/+KsCYgV11MqOGs6ftwI9UJFYDhTWPfWwdWuqQKUgfkP06y5XHDt1oGvWyXjyvz676YiAUyTArxu1/eiZaBBPDDOJS65BsR8ffrfN+kPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+ipDgxR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso1094651f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245633; x=1755850433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1f7kL6gjN2F1fV8ToMQJ5E9ndI3HLl8+wtRhuObA6Hg=;
        b=h+ipDgxRlZFOuC5crkpbLUCBs4kCdB2Zk93699NsY7Gw7hnouJy8mhjo1pOCqrCX2p
         Vfbz47YHDNTrve/nEel4bGlMxnnwucJrlGFbewY1JhnKLdi5ImEzxw6SfENPWwEoN7Mj
         UNAvW2WP7uCtO8vgoplINBhqGxDFryd0+1kCAsYMioK8fz5+duVnmKYYewPmdsPSsvWx
         bFyNHnKI1EnbCJr6OxMmHIT+7F28vdfXQsUdU43CNwTKpLR91PN9MUxPSnXQkrhEkO9l
         HCdbki/3gHfxolyvFJhHSJFvHINF9S/hpQTp65SLFhRZMirJ9EUSoY3VdjLOSnDVBZkA
         mbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245633; x=1755850433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f7kL6gjN2F1fV8ToMQJ5E9ndI3HLl8+wtRhuObA6Hg=;
        b=FBQy2Mba27oY2jJzqpYcJVo9YPri9500s9Qa17KH4Xzsv2FhvnqAr1pO/+g9/3ARm4
         NdeG6bL34UYoFSlCeq6JU8UcOy+kUdazmIEggRLy5R0hqumE+fV2vOLtzHhD1CrSze8r
         s+980GQkKaBL7QO+rFjC0W0HTznVV5nWJmG+xOrJp9ZDK95qzaRRefdmskZjWpmPbxGf
         CE6hV5cv4bPebETvVUanZHaG+vuN8fraWFkPfcq1kOqCxZLgt5mBiAEnAGRk7d54yx/P
         gFIrp4vt+I7wUWp5FoSSEFGP+CoNHeQkoXnrG1BnB5h0Ae1R17S3atG+X3LhKJslxTJp
         z8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWG213pxZ44YiVkxPYUmS9kqDs9Fv4Q1c4EIM/bCnTrO0rCfiaI+TB2jGbjYL6tg8/oFMKUt2/VEFCFc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNuG1Kq+8YrTUInbBxmKvUkBlgtZphQ8QEz1y/SvhQ3ZSsVGV
	Qclm0j+QCENFp7fEbErK/DLom6XV7xgbSZOm4l8HEL3uApDgl0MjL7WIz+Oh1D2bWzQEx4MNbgZ
	O915RIXCkGnf9jlDInw==
X-Google-Smtp-Source: AGHT+IFYd17OhDNmiLfiosyGDGjCTy9zqn/5SXr3YlG4Wt+k4EHu0NIK+WLSW+zValRgSH9t7RLNNnppVYd95ao=
X-Received: from wmbay33.prod.google.com ([2002:a05:600c:1e21:b0:458:bea8:57ef])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3596:b0:458:add2:d4b4 with SMTP id 5b1f17b1804b1-45a21803ebdmr11738045e9.12.1755245633160;
 Fri, 15 Aug 2025 01:13:53 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:13:52 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
Message-ID: <aJ7sQF6ObVlwX3U0@google.com>
Subject: Re: [PATCH v5 07/18] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:42AM +0200, Andreas Hindborg wrote:
> Re-export `configfs_attrs` from `configfs` module, so that users can import
> the macro from the `configfs` module rather than the root of the `kernel`
> crate.
> 
> Also update users to import from the new path.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/configfs.rs       | 2 ++
>  samples/rust/rust_configfs.rs | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> index 2736b798cdc6..0ca35ca8acb8 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -121,6 +121,8 @@
>  use core::cell::UnsafeCell;
>  use core::marker::PhantomData;
>  
> +pub use crate::configfs_attrs;

In other re-exports of macros, we've placed it immediately after the
macro_rules! declaration.

Alice

