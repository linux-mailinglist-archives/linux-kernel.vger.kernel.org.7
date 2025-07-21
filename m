Return-Path: <linux-kernel+bounces-739183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E7B0C2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2137A7F89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750A29C340;
	Mon, 21 Jul 2025 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4bd4cv2"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1729B8C2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097338; cv=none; b=CxycPTJLfvEOS3hq4PUa+h6aeNm6shleAKPKwdis9nyR9LQYI43xFWiKqWa9efjUzShnbtGDPUoXC437ec8P95aT9VPcHvch+v10Ar8tMKN7FuP6gCfvCPHMleC3pduXIuP42fS0tRHjABzMjqf/to/QO734zj1ilVZqJ2xhMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097338; c=relaxed/simple;
	bh=NWPyE/oXXwV7jbclRZg1Z5pKRCbwyvtDaAna5RhNTZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8zdRiEdsmzNKOv3RIcfI2RIo0jmvp0/5j8WJsBe3HQm80kshnHp7lpLGkKK6mIbONNjaXvcvMvKTBvgTTB4xY4x2zsnuqjVb6IQlU7a8FgRkB/2aCAVguSmVXLESRi5eyjiiAqgsa4K6fw8T5qLXjil3F5VAiiQhENW0Uvegnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4bd4cv2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3482127f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753097335; x=1753702135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLDWY+AZ8TsQpkCn6ZpTAvHwd+IywydqS2wN/CqvQc0=;
        b=T4bd4cv2mNj30D1EkL0NobD+x+++oWN1mCOv7sUmYWvgzZlIl8gBcFZUNAd+9mFGLW
         h9ZBqpDJuGPd9y9nya12DQZvc87rzy3wwgBhu68efuij8C6+4qVECR1f/QY/0jhdCQbg
         Xfwhp6AhYVCb6AvyxSGHxxymnnQ3SQOuY5OH7tUD+IQ2llfDS9TxBipP3yz7LYbgBUpa
         EotUdjenHkUK+trVnHrwn1+4OmJPV1KJysD91Eu/w1M42CRQq3Oy11NGByDdmQrqg1FR
         +zK9yokq5RDEsdkfYF3+3YbRLIUEyeOXwJqlCx+TuhuEXmsE+APzyJ3nxtgAxYtDrLDc
         9a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097335; x=1753702135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLDWY+AZ8TsQpkCn6ZpTAvHwd+IywydqS2wN/CqvQc0=;
        b=YUaZfr+Psl2mfel41Vu4QxQSyykPF01nq9RO3i8GZ3+wDkU7bprYEkKeyNUSa6rBBP
         QMQkpask61g6VUinLABtoxmXytRUJNCBFJJdkHtGxAtjOoSPCw8gy1On5FvID6bt5NdT
         Bti8qYOhfeAkMlzVoYRrB9JIcyr6Y7sQSJvg3osQhcdr6dejf8lKkzO63wIfH0EXIl6d
         4ngojr8vWY9YpRupq/gXpwrYjak879C76NFoyA7ibeaQ1+gR3N2iIMTzpXax0HgxUred
         AxmYiPHiO90bo8wp2XqtGYvzcF7AkqnLBnCK/lcI235MU3SaCkbjrm8O7RDfQhS8F0HT
         /uUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSV3LtLJb2w9XpxnBVIyn3wCDnONEu1QRuT6uQPJM669NxBcVmLSNvcle2V42q3bSp2AK9700d74UI9Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqw0aStd4pV2cDhn4o4gZZ2BVt8+mUBs1YKitTr2zBiAwVKlDG
	E7oLwPQ1GbdM2opaTgh68hdxBxzg2rugm5Ty9PBt0vWcSYi1nhaeh6zFsT+F0Eq4hvfE1Xr2hiT
	e50CFAzi4pA0dEmwC0Q==
X-Google-Smtp-Source: AGHT+IFajS90MhfIY2BBT+gKlJwX+dM/eN8Fmozuq1by1tOiYPEzAnvjApRieaWzEaiqLeiQxI4Nz1plEKfqeso=
X-Received: from wmbz14.prod.google.com ([2002:a05:600c:c08e:b0:456:1075:9202])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e19d:0:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b60e4d2a3bmr12301878f8f.18.1753097335224;
 Mon, 21 Jul 2025 04:28:55 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:28:54 +0000
In-Reply-To: <20250629024310.97937-3-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250629024310.97937-1-contact@antoniohickey.com> <20250629024310.97937-3-contact@antoniohickey.com>
Message-ID: <aH4kdk5wzAw6PQdr@google.com>
Subject: Re: [PATCH v4 2/2] rust: uaccess: refactor to use `overflow_assert!`
From: Alice Ryhl <aliceryhl@google.com>
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Cote <danielstonecote@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Jun 29, 2025 at 02:43:47AM +0000, Antonio Hickey wrote:
> Using the `overflow_assert!` macro here adds documentation to
> the intent of the assertion, and avoids local `#ifdefs`s by
> encapsulating the conditional behavior to the macro itself.
> 
> Co-developed-by: Daniel Cote <danielstonecote@gmail.com>
> Signed-off-by: Daniel Cote <danielstonecote@gmail.com>
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1159
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


