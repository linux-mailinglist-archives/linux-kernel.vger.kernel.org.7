Return-Path: <linux-kernel+bounces-762183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D549B20311
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5EA7A3173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E24414;
	Mon, 11 Aug 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sehjWJ7d"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60F2BB1D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903949; cv=none; b=VEbeWlwf+8K4pLjo5++hjwNQFFJZ1CGOVYi4g7DCHFDwMyKfEViabzVGywi00aDHa7ZHVbWZKviWfbI0Uos6n39agJWAjy72kwjWhGYvTOp0IAjKbwvi8mkqOJO184yp8NeDO9yvdfEHIcdlwURQmrw/zPk8S/uSxY3kmI4/zXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903949; c=relaxed/simple;
	bh=nuRMRugXR4lnu9XV/vJZknQh7XkLZ7RgDbwK9GxUeP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bakO/3BDNtM+/FmiE2m7yBsP4hBe94OFgW0JhJRnvP5tMdk0xY/bAZ4nY77kz/O/dv5/UQXwPSlzuu8OBSwXURBlA9HsE/g1q/WTXUVzoMrHHj1A5ilrdwe99S/Xv1HdoGKyxKEdoolo4cXhLr75IqEYDqYSYY4Dz0299o8PQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sehjWJ7d; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459f53d29d2so15787005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754903946; x=1755508746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Kol7Ja1D7vtEkDoq2cssqguuGYYATqFKYbReC67Fw=;
        b=sehjWJ7d5QUfQiKpWx+CAL6wk6mjJbN/8HQ5TiFfrWAduNY8GJdAmda0tiYbgT4nxo
         +M+imsu03TwCIKtgRKvLEwagobmAl8ZyzS+egyIZJ1fjo4Ef9GP02BR0SdkvNPhxguLt
         wyExj4WBLpfK14kqeL+7OzPek8D6hKlt6n1irz3UcIVrrNOSaqdqJSxSg5pLHzd7acI7
         0zLDG72qq8/CsG8ragbnEa+9/PLp0jmvFfmyKsdegXpqoqcLsBxr1aqZMkjnt0IWb5CM
         eTicP+D+cmEMlLo5I02hLWHxEGrBFE6a2JfOo2EczM5WQX3npjj7rRus5+Zbmdvsksb0
         kq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903946; x=1755508746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Kol7Ja1D7vtEkDoq2cssqguuGYYATqFKYbReC67Fw=;
        b=iw0hcBIxCMFJ5U3cxRzf8s34adXFL1J1CMR+St7fT8ETrKMJgQtxZhG8wmS9w7ST/F
         pYB7qxTddU8+rHu9GGVfOxxwAvhTPer7xCCBanzSsLheae0Sdd7FxH85wZ+4Klt9bbrq
         +7HNYoKm+2SWSR3y2IZ0qQgtDpieCJ32Hmo5VA5DwgPKrYfKTo+vGf7dgc0G6pT3qp0z
         pEaA3n9yWPgokl/i9KJH6HOx3yG0jYbTEUrW0RCI+xGOk+0Torg4iQWqYCivunWwTokz
         x99lpqas9YT9MJJ5QkGOGRZ3bpulhAflSOqEAJRwi3Sxd79EMlZVTcfRTOs7FMdU4Qg9
         0fgw==
X-Forwarded-Encrypted: i=1; AJvYcCUfKm8F0QSs4KAqmsdxNf6RC08UTS377magEXOfkkrArnkUU0+FJiyFT1d+QWxmyPU5EittasgFJq+HiRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPF0r5dWEEcaisW5LWvJt8UbtKagnF9yjEg2hrsU7EU4tueHjY
	nwx8I6eQD+/UdxIBA9RWNuWgEvTC/qBqKqbHyV8EuYDcYkonlXJ2Fp5mhTwa3dVpCrX5wBv6A+X
	w1kaK37azauL1EgKoXA==
X-Google-Smtp-Source: AGHT+IHHOZJPfypw7CKlkWXBejdNHY8129ucWhHjmuSizxfAXx9R+2Px01HW4RJjv0kjWM7A6pFRVoT5hERdOmo=
X-Received: from wmbes9.prod.google.com ([2002:a05:600c:8109:b0:458:be13:ea6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45c7:b0:458:c002:6888 with SMTP id 5b1f17b1804b1-459f4fc0ee2mr85079135e9.32.1754903946262;
 Mon, 11 Aug 2025 02:19:06 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:19:05 +0000
In-Reply-To: <20250808192005.209188-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808192005.209188-1-ritvikfoss@gmail.com>
Message-ID: <aJm1iWpM_mR7mkMh@google.com>
Subject: Re: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!` macro
From: Alice Ryhl <aliceryhl@google.com>
To: Ritvik Gupta <ritvikfoss@gmail.com>, Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Aug 09, 2025 at 12:47:49AM +0530, Ritvik Gupta wrote:
> Introduce a new `safety` module containing `unsafe_precondition_assert!`
> macro. It is a wrapper around `debug_assert!`, intended for validating
> pre-conditions of unsafe function.
> 
> When `CONFIG_RUST_DEBUG_ASSERTIONS` flag is enabled, this macro performs
> runtime checks to ensure that the preconditions for unsafe function hold.
> Otherwise, the macro is a no-op.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1162
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60unsafe_precondition_assert.60.20macro/with/528457452
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>

> +    ($cond:expr, $($arg:tt)+) => {
> +        $crate::unsafe_precondition_assert!(@inner $cond, ::core::format_args!($($arg)+))

Tamir, taking your fmt series into account, what's the correct
replacement for ::core::format_args! here?

Alice

