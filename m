Return-Path: <linux-kernel+bounces-788118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0E5B37FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41E12067C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8834DCC9;
	Wed, 27 Aug 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX/WSJZ0"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FE34AAFC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290549; cv=none; b=DGdzAI3NFcMOiZgjoTzhEe4ITwZ+Bl7wQ0oqkJ2c4Rvcq+iMFMZTJMLq+JVlLIftH+ngkK3Ij112VysZUWsXGp5jWMjqh36E9lJgKP6LZ8DRFJkWF2Nzx3pUdxHhf4e1K6MGntQGExfIuGBM6rpZeWnpOSpElpdEsLWvKtQMaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290549; c=relaxed/simple;
	bh=DbugaNq7mw+QeA4tq4x7xb5bzz98n6JA5YpKeCYeWas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VDZFTvUYL2j3pigbVG07pd30lYrmYwt9CBTHYMK0KuNZlbVENzLpzCSpvyQ3P9FCkYYgye8XJOZj3HNFXtcCBOh1xq07fIDieiTTX7AMcbu3FXT+zQ+6EM1hNZuVukVBguWdb5TB8sAo/KqHif9v67+6zM3o0tKKx2l/XBJrdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX/WSJZ0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c380aa1ac0so2570406f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756290546; x=1756895346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdTMbmCHnU1+nnbvSuLC2PYO7bL7HvLUcM04LVQPTsw=;
        b=aX/WSJZ0HjSmBRQmwgx9DGkl27MPgUqvbcwCBX6xZiRL2RPe1CWiwJPw+tRSmXFPx5
         XR2IEb/p4QJsq0gpw0KO/ZYgaAOGZfd3Ke7RNrzzgM6D3mlp9LGfDO7Jv47iTzJxocgj
         vMsdcJynV+B5ECAnoXlUK+LNTW9NUWLPtCAxaTJ8M9Y2QoGaFXKZN7b9uUG/AxImL4Bx
         ry/AmXaAC9rRjLYKhvWOe6ZfpbMl01daqtYFnfOTvc89SU05ysy9MVTWrEtlBAWEjrEs
         YVpT9Q8guWYUkp0jH6obyYT7boGMYkh0A37/tncPkX1/YwV79n/NO+Zopya6WwZr7r6y
         JHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290546; x=1756895346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdTMbmCHnU1+nnbvSuLC2PYO7bL7HvLUcM04LVQPTsw=;
        b=hkl1adTzIgKYGhtV47VTdhMcVM3buK0mGkV9gdValXlfeF+NajX/4bWEPjEMabv5br
         b22tMxd87TVnsWUrzRhmUo1PLf6jDPOX1S525vDsfpA5D91J36Lh2aed00VG5NHWYcom
         IPDv3K+o7cVeEdxCKoDqGUHt0v9vAqRQiBnlCN8L1juYaGEzE4fWK7/Wpo2YfOzQh2tk
         2OxzCyPH229gK1kHDt+BSJRe5fFpz5TfoV67W6ZHP/VDP/2CPNx9DdGGvUKaFKxda9lT
         9VdvCA/3WxsjjzMmesQkga6BqAiI4N2hd04pyygIt4xb50yhsqGy3GPFOpeBnjd0lDjp
         DG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEDK6FUIutvluuZ9awtR1TzjUKUfQg56795sZ7um5DcvhQ/FSWYH2REC2MzevybFvANSpvaEPyWNL7KjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfiWgxxj+ZPw7yziTyGVPQEvjQB6akIoLmi5kSuXtPRQSv1qv
	LJXl4phab2/qVnMYaycCXCerngfuhiNiy5ZGf/cA1+czqI76JY4r6Apglxjy+CW4IK0U+chzlDq
	ivpRNWK+PXYEZHxkuvw==
X-Google-Smtp-Source: AGHT+IE+i5as7l2IL1Ep9tnUjG3XXXVjqFk5D+5CFrrUQG9lsMRMMWvvPUy3uavWhqYg4E3oRO42xiiKsr9T3yw=
X-Received: from wrbbs25.prod.google.com ([2002:a05:6000:719:b0:3cc:ca6b:efcc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1acf:b0:3c8:c89d:6b5b with SMTP id ffacd0b85a97d-3c8c89d6f7dmr8728213f8f.48.1756290546251;
 Wed, 27 Aug 2025 03:29:06 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:29:05 +0000
In-Reply-To: <20250820203704.731588-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820203704.731588-1-lyude@redhat.com> <20250820203704.731588-2-lyude@redhat.com>
Message-ID: <aK7d8SN1wckZDZ6v@google.com>
Subject: Re: [PATCH v3 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 20, 2025 at 04:26:43PM -0400, Lyude Paul wrote:
> In order to copy the behavior rust currently follows for basic arithmetic
> operations and panic if the result of an addition or subtraction results in
> a value that would violate the invariants of Instant, but only if the
> kernel has overflow checking for rust enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

