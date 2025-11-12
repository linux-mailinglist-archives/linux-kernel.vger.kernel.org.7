Return-Path: <linux-kernel+bounces-897243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1325C52579
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8369188E573
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689A306482;
	Wed, 12 Nov 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEnfpW0V"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E732C95D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952126; cv=none; b=npbR4Ymfo6Vp1Mw8OyhkOrg20RucZHHASjoDchy5AvXvDh73Lq7HwONjLWwOIUUEIeNGHTh7wib0Wf39mUfwGOhjcVDouo6iCWswnVp7g0fCebMLDSIRDU1EefFyfCcVncjJ79OIxHme3feLbixsEnL48W0BtHdCqmLCMIc2H40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952126; c=relaxed/simple;
	bh=BcFq00OssKkzSwCl00nvO477fZa7fF9ZX+fCk9k/p84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unb0SN1qfZbt1RM1liAUwNPIVi0rxaVGS6y7OS5VN5c2EdVoGeVQGa8FMlScHRoRRGnXXuJHvhSr9gQO3SlqyNvo0i+jtzvSKIPe7WPBE3mPhXhqfVyqpP0f829ouXjhmMHifVxh4qvR4d3EWf/j07I4kyf8P+0awamvib/bPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEnfpW0V; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4777b59119dso6866185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762952123; x=1763556923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj+EtZLPIR5LWGpVopW/lewxMd1J8lyNQVeLz8/n/RM=;
        b=TEnfpW0V7Tzj8plcvhV4cyNYT+L90mYo873AjML3xRTN9E6jgA+2VvrusayAmGJkTG
         5NbJSGKVSXeIrvxo5UbSnBxBuk4rJZFoCPdziNSBomhXvA79J72BnWDt2MzYEyj+Uhcq
         WrfZOTVfBwOvOj+EdFa9uVoqDp9KAR8YSTvm61l+QWvH64narKeZ6se4JLY+5R0sXVVy
         uxJGi8QDIed3MWC/Uielz6aNiEpSZV2BvbZUfrHjTF+1uxfRq84bgxrhFuTUW4CmXzoJ
         mNK5JhUjHTk3aqQfbAHbE4o/rIaS8jZHq6Our+9WDeT6ooXVxXTW56Gfalvv9B6G3mg4
         YJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952123; x=1763556923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj+EtZLPIR5LWGpVopW/lewxMd1J8lyNQVeLz8/n/RM=;
        b=o2+BV8akcFWfXH7QEgs7wHFRK/6anla77bq6Mi1dhlm5RcKwUN4YU4M492wf4cDUVF
         SAfhyPQUMSFttpsynvcvOR95z8cubJD1yUFqHOiurMSaxBFFtgwhOcQgCNeqePg+PoKH
         V5XHgeA5KRmb5A35gz7bSC2aTPBJCI14DT8RfcRwXw6c2t4d5BZf24cSwW6yoTmHFzMF
         0r0jP+aOvf4Gyxl4I2Low+F6VkkURuZuxo2qKPkRKXowgZ5+B2s7CS9q+jFufLwqEZzZ
         gzkMLDqIsHRvOvSG7R6E6P8KyOlQAXDrndcs2XqNeOOLli89KqiLW6JVYJKKhm+UZaSN
         VRiA==
X-Forwarded-Encrypted: i=1; AJvYcCVpSIxD0UXz6kE6JqPEvd+uMNW6pODhb4Yi53V4+jkd9NPQ6dHtw8qbiss85yFRn1LFM9pLt58MhBPjxLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSQv8AsTbqHB5Q3iMSMsItSBQRO2adrbyAzIMIAywRxMMeeKt
	v7KVvBbQBm/qJNuzfq++2MwtGvaF9hHA4dFos82yzGJ1kIs70ATNw4xDb4MTbIHUvL1YRIvC7kX
	m2X1U9CLMqZUt7Xybww==
X-Google-Smtp-Source: AGHT+IHVDVGyl0BDosGU/0tn/jTzVg4KaJQqt5oPgiqlVAOf23dQtEUbhxTfxX/esrh2Br2eeteSfLKiW/Ew1YA=
X-Received: from wmbdx18.prod.google.com ([2002:a05:600c:63d2:b0:477:632b:1238])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c26:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-477870c52bamr32419995e9.19.1762952122738;
 Wed, 12 Nov 2025 04:55:22 -0800 (PST)
Date: Wed, 12 Nov 2025 12:55:21 +0000
In-Reply-To: <20251112-binder-bitmap-v5-3-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com> <20251112-binder-bitmap-v5-3-8b9d7c7eca82@google.com>
Message-ID: <aRSDuUquGfg-BFxl@google.com>
Subject: Re: [PATCH v5 3/6] rust: bitmap: rename IdPool::new() to with_capacity()
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 12, 2025 at 12:47:21PM +0000, Alice Ryhl wrote:
> We want to change ::new() to take no parameters and produce a pool that
> is as large as possible while also being inline because that is the
> constructor that Rust Binder actually needs.
> 
> However, to avoid complications in examples, we still need the current
> constructor. So rename it to with_capacity(), which is the idiomatic
> Rust name for this kind constructor.
> 
> Reviewed-by: Burak Emir <bqe@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

> -        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
> +        let num_ids = usize::max(num_ids, BITS_PER_LONG);

Ah ... I messed up the rebase here.

Alice

