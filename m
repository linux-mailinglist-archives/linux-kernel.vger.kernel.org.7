Return-Path: <linux-kernel+bounces-884888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E351C316D6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C9A189A6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386332C318;
	Tue,  4 Nov 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYCnTfs6"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DE2F658D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265242; cv=none; b=pccZTBbPeckozWqaCVYZbyVmnM9eGAQkbYfwzk8R/CIK1fRlHn5gbCRlQRImUrG3FCRRBykztnEVAgfIYgJf9Dnfd0zsp7qSL6NAMWKmgBGqgVYEnzYhAUykY3uRTjHK6cH5EkGz/eScTGQ3RgaZIxF+nbvbO7luPmXDKCP4hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265242; c=relaxed/simple;
	bh=V/6GRoS3/EkiJu/PAUYjegilbyM/Kg4vWk+H06+F/xs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E0LPqhvCM+SMiSoQ7bmO6HIb+cfzyN1PG0stRu4T2Df/ZdM1YbTOZKmOP/6vi/gR0XWK0S4asj1mRoOmJsxU3vZ8Camvj5+D/v9ToQIyglPbQdi5yZHa1tmH9S7bPKCCCIZsuu/TTzp0+HyMscEeawqjUcXt2Qe0kK5h98HIZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYCnTfs6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso22045555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762265239; x=1762870039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0XlFlPd3bHG9no4QyoaPyikiLZTerIShtsBKRlB69U=;
        b=YYCnTfs68Gkh0hCBvgjC2OdJOcbsVth/iTjjq/bEdxKV7ET4UB+fQc0NV6OlX89XB1
         YOPAGZK2F6ML0v7Bn+6AEkk1fXkS9Lk0452v17pqaNcpxq6l1G6HdhkJwn4zr67MXJpA
         TH3QWwcCN4B1wiavNcQagza6myl93BlTXjK9E1lqWnl9fzmL/IUHVlBSE4L1grRbSfow
         hk5C/g8BIrgiaLDsq0DSG5W8eYsBt/oq2k2fCjYxqRKRRsQ5vJht2tDfT077Jw7hGLfA
         9eK7eq8Yk2VJpnuXKG3jAZqjNO9s4DHYcD005favFMUZc0OA5uSBDhN/t/Z8OTIuWXuH
         oxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265239; x=1762870039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0XlFlPd3bHG9no4QyoaPyikiLZTerIShtsBKRlB69U=;
        b=i8ZUnL0L3RWY0M5MLqiAYNd4yNWwk2asrOl4g+7MfBXtc4NO6amdFxxh5P8tX+C9Lw
         qOmNQMQ5CfUE0v3FG7xkqyFPxeI4mQGaIB4EevTKKIevPu9u2Xoo/CHE+jCD+3NHcEmx
         YyRmOLeZRxm4yTr+VDmD0F/Cw6ZV1dgHKAppu0cvQMDQerEEYjGakJO4XXGxx2+IX4ZF
         VZ27aDN/HlW/MNOBb7p0MbqGU9zUDpG447DHvwi2+eM8Vt0Ti3Mbr2plodjMADexoHIw
         066zSBMilhTbwlW1dwFyJfP+quw3UtfrEuE1XWK7g5iDAzKEg9F2ZtNQrhrptyHdufFm
         BvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrUk88Y4yP/mB4+X4pZZ+prhQNeqFHQE+8AELbmba8+1M0+Cs5KVdth5w75IYOeLqEyhwI+q/dY6Xem9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15hhhGmu04lahBhVB2GQxUNKTVPPYWFW1rls6YwK30lZ7Z8UJ
	MDXQjCMtk50hkpxuDHZhJgijLAelzeF/CGBANtawE/R3PAwnykgc06x/AMb0KOfaGXqSGO081GY
	Znkuky2KHM5HNvd+Gcg==
X-Google-Smtp-Source: AGHT+IF7Z9G2NoQdKa0kcEf+rRGi/koVH8onnac1d5yNHUsIXHgjT/z8ZkDySTLnWzF5coxstmOe5U6bx2HqTeA=
X-Received: from wmkz14.prod.google.com ([2002:a7b:c7ce:0:b0:477:4a46:9980])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e05:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-477308a8f1amr178307165e9.34.1762265239304;
 Tue, 04 Nov 2025 06:07:19 -0800 (PST)
Date: Tue, 4 Nov 2025 14:07:18 +0000
In-Reply-To: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
Message-ID: <aQoIliAbrn0Re7E3@google.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
From: Alice Ryhl <aliceryhl@google.com>
To: chenmiao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
> The initial implementation of arch_static_branch was achieved by accessing
> the offset from the original type. However, this approach extended the
> path and introduced redundant calculations when dealing with types like
> `static_key_true/false`, as shown below:
> 
> ```
> static_brach_unlikely(tp, tracepoint, key)
>   => tracepoint->key->key
>   => &tracepoint->key(static_key_false) == &tracepoint->key.key(static_key)
>   => off: tracepoint->key - tracepoint
> ```
> 
> In practice, the implementation of `arch_static_branch` overlooked many
> detailed descriptions. To improve clarity, additional comments have been
> added to the original logic. The approach has been modified to directly
> locate the corresponding `static_key` instead of using offsets, thereby
> reducing  computational overhead.
> 
> If finding the offset from the primitive type is necessary for this
> implementation, I will abandon this change.
> 
> Additionally, support for the `static_branch_enable/disable` APIs has been
> introduced.
> 
> Signed-off-by: chenmiao <chenmiao@openatom.club>

> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident) => {{
>          let _key: *const $keytyp = ::core::ptr::addr_of!($key);
> -        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
> +        let _key: *const $basety = ::core::ptr::addr_of!((*_key).$field);
>          let _key: *const $crate::bindings::static_key = _key.cast();
>  
>          #[cfg(not(CONFIG_JUMP_LABEL))]
> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
>          }
>  
>          #[cfg(CONFIG_JUMP_LABEL)]
> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
> +        {
> +            $crate::jump_label::arch_static_branch! { _key, $branch }
> +        }

So ... this is changing from $key to _key. That's replacing the global
variable with a local variable holding a pointer to the global variable.
However, the arch_static_branch! macro uses the `sym` operand which
requires you to pass it the global directly.

Did you try this code? I don't believe it will work.

Alice

