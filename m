Return-Path: <linux-kernel+bounces-884900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72369C31782
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60603465CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56A32D0EA;
	Tue,  4 Nov 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXMOX5l0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3600032C942
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265539; cv=none; b=sYav8vCLeVJtXB+ABCXcylRqWwLcB8jsM1e8bVDl0rp8LB4wdosXtYn00mGvWgXfN+StvHQ/EL8iZUYzIKe9Pto1JNpQ16nmxeis9qQEfkUVCFnEyuB89qa7VYSX28iBmApNhvf3LPfg9GyGZmLduVUXSRnEYkPX4x5VCPZlP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265539; c=relaxed/simple;
	bh=LYroiBGaiqJFoYRjuCQFvHWZlCK3HdSaFOb38tGzgTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uLmBrG1Mw8USXa0Y54J8/n7xy+g0a9sdv097T88JZG/lgZ9z2bel3Vi1aPm94PxChhwi8LZOw+KJU0IMlkccCECifUoSmMGopeDAZkLADJYSfglyITkrMsDaSf5+YPRvMFIBlrVzdYD5qYoI4YMH2WUpozVaZ2CkEsp2rcL84DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXMOX5l0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso48585985e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762265536; x=1762870336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEcbNaHwwUu98mMFzjQHBl3Ur9imCbSK1SRamisoVo0=;
        b=YXMOX5l0MCa98HOuCNOLye8nzmjYKfBO3kDRL6JBOuxbcgBo7g4yru2YpyqVDMtqRl
         EE3hHfFKUTIAvo0tkLz8g98Mpfv/FhQNDkJjXSEwItYkmd5UDIwC6zSp/cW5T0oZyjzf
         ShvlfIgujf21CNtUC8npNQ3GGBFyQWOKdxo4IQRZzS6+NbIO0wKpYVUtAt69ndCxAxHP
         O/IKsWHTw4fUcppJ6+VhVXwXUTkO4cY0dWpVbgkjwqQUWy1VDgdR1v8IcYojDbASzOMl
         RNCri5PPoGAh23ryrD7HQP+DJV4aH/eMDCJ/b+jqBgR44EtMkJxqkM5AneyvrnIAhiPE
         xfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265536; x=1762870336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEcbNaHwwUu98mMFzjQHBl3Ur9imCbSK1SRamisoVo0=;
        b=nI5eDA8sp5P3Y5GTKP9hckwoUqoW5tKACE5s0VBwX97/sGUx+VejxNRRVnI5lUQ0IX
         ifFHrttSCujTFFHA+DJadm+KWdJ12dQTtnmi/hUFh/lTDh5VIjC1TM5K/HqlB42QxNDD
         hfykb6kkWQTFaWGFrxMxCzThlDb8JhnWNJ3S2+6tA+hbfYgPkpX8HmSp3nYEy90W7pR3
         KZE5u+mfIY4jS8As2543iz9sGouUc4TAGa+eHkNb7+W5lbM1COrcN1SxvcrW30/Ubjev
         4d/N4n5geFPk8s945cUEtmdBFp2+tWx5Hm+IX1BZWiatWzWDqm0pcDAHBRESRHxrrM6k
         aSPA==
X-Forwarded-Encrypted: i=1; AJvYcCVj7YNCUjFDjpIVWur1FbAgMgDM1m1nRgdv2t8NrDF7QEHdJsnLwisjrl3eQI0ymgX4w1uAUiTNN0PI4K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwVnW5GyuSC8VCrSFXA3x8mbvNoeAfeebmd1pmMliLsRw4NvG
	CTW5lN2sIgjcV1IQ7cTeHWww4mXQLTDd4PMma5mZl0D97keiA+oLaJ8L+xXmv7xae7dUHOQ6kMt
	5/GnKFibkH7i8uJf7ZQ==
X-Google-Smtp-Source: AGHT+IGmpX17CaUkQY1Gxu1oZZH6fZFyNIPKiUmNUKaWbFGeyvKLHWQP3KgMrQGejtswKORq1dCUqZB740zTpoM=
X-Received: from wmnv20.prod.google.com ([2002:a05:600c:4454:b0:477:54f2:85b7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:538e:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-477308a1198mr141637275e9.23.1762265536653;
 Tue, 04 Nov 2025 06:12:16 -0800 (PST)
Date: Tue, 4 Nov 2025 14:12:15 +0000
In-Reply-To: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
Message-ID: <aQoJv3k8sJvbWaF9@google.com>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family of methods
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Nov 01, 2025 at 10:41:21PM +0900, Alexandre Courbot wrote:
> The `from_bytes*` family of functions expect a slice of the exact same
> size as the requested type. This can be sometimes cumbersome for callers
> that deal with dynamic stream of data that needs to be manually cut
> before each invocation of `from_bytes`.
> 
> To simplify such callers, introduce a new `from_bytes*_prefix` family of
> methods, which split the input slice at the index required for the
> equivalent `from_bytes` method to succeed, and return its result
> alongside with the remainder of the slice.
> 
> This design is inspired by zerocopy's `try_*_from_prefix` family of
> methods.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

