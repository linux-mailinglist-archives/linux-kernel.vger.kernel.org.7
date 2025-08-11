Return-Path: <linux-kernel+bounces-762303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D771B204B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D6B16AA38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CB1E3775;
	Mon, 11 Aug 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7/pZTKS"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D1335C7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906215; cv=none; b=irggMV/eSWSRUqLIEfjFzj/7mNZovKuhdR5GsFonYd13PWJuahpEB5SOs8yxwK9VmmI1vI+Upwak9o8JrYLjwhtMg7KxtDoTVH0X6cSmytF2UNWp8zxzD71zxwhG0lWczVO3sg8qXNSJLLKUCqLzDAbxty6t9E728w8Se5IoxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906215; c=relaxed/simple;
	bh=oFgFdsAMTf/qCY/7xWsxSAnmK9+zLrC/nC52m7Do2DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjWNO9Z77nS0R5R5iUOUT/aiOEK5z1WJOb4ZzdG9qALDrQT21Kzuq3x2aALbJpIHdS5PRpNQ4xkMnM4PmyszQvPvTTn6EosS3VnkIHHniCuAz30bqmS6MH7hJzirsFslHLnNGQo62BPS47CftyBPo7jv+0nJlYOy64Bn5qNzunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7/pZTKS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-458f710f364so27892905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754906212; x=1755511012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl1+NNQeO4OdoNvXCOAgTlcv+G1b3QMdpUJ6J7g2VAM=;
        b=s7/pZTKSI86bRFWrZ4CJ5x+6k74/Tn0ZXx40d1b/1jxwd0/N2NYYpEtFn2lKqC21UY
         XgELQDan8uilNyPX+o9DAOKFyWymD+BJw+otemNcXKTWMmbLjjSxedC39eCCt9ePO5T/
         DD03Qbam+nmQAQYLRcrx0K531ZvMswgTW5UQW09x2YTioEA0fRz0iACNeaMD4RaCE6mr
         moy/oKeSlL2qvvptUg6/+jBw3dWQZpm7rbSutY3fJ6qyRGJ4SN6BJDuVF2HTHzH4i6sq
         4a8vwhzmk6eGYmuomBDcoiWxiuQ4OniiepTQiH7HXKpA2hFil8O66rzaCUuBFWX7gtgg
         pZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906212; x=1755511012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl1+NNQeO4OdoNvXCOAgTlcv+G1b3QMdpUJ6J7g2VAM=;
        b=Hxgsw96UoXFl1OGLNlQqfDuDqZr7tyY9djNhBJwAWJPykEs2oLSGWDNi8ORdPJgY3D
         DskbuySLt5272iCf0pcMu7lfmKzRcddL1hYDF9AYKaCxKNnLIA3QL5yxK3o/oYhz+T+l
         TZVkUhb54lZrYtJcGAOPEF3i1Hmv7MKppC3kEFv9/NCATAPiB/Hjnnb7UBnKlAuUGhu7
         HYF1gHllXjGM6ZAVDoh15cHbuiwgVjGO763DM/3MxbdO/Gshl0+exaw04nG6/fh4ZswK
         tXHiTVDC/0gLrYd/gNHOxsmUFyq8lYDy41MYJh3cOYJqRzpx5P573pPh0HwXYDs+pV02
         mrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGtOjYMcNn7R2OEH2ipnVPE9KmEm/oYDHnjADPkMGRwKbi2zM4PCOZy1CL2XIt+9+e3JrBCG5k8sW5QpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydF6ibHpHwpCczEvj2TQnHkn1zemh6v0Pa8Ntc9MBMSCaaq60o
	bNiQ6AawuAf9TvU97kp5HJVbqPiP/+CCVEylXbDwc2TBCCY4r91SEZGX4qDXVpg7v/Iu+LoV4ZG
	BvvmdSh9WgmHGuK7p/w==
X-Google-Smtp-Source: AGHT+IHRBVCM/fJteETaWAs/3isleNIYRq7dqVvVCDKq4GdPu37Nrdb9yhp68WF7Uhd2xtOfaLaHAqeHeno8MUo=
X-Received: from wrbee12.prod.google.com ([2002:a05:6000:210c:b0:3b3:a665:e00e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2083:b0:3b7:9a01:e52f with SMTP id ffacd0b85a97d-3b900b786f1mr8987086f8f.44.1754906211937;
 Mon, 11 Aug 2025 02:56:51 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:56:51 +0000
In-Reply-To: <20250811012000.444173-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811012000.444173-1-ritvikfoss@gmail.com>
Message-ID: <aJm-Y6oMiWGB5yCQ@google.com>
Subject: Re: [PATCH] rust: kernel: cpu: mark `CpuId::current()` inline
From: Alice Ryhl <aliceryhl@google.com>
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 11, 2025 at 06:49:58AM +0530, Ritvik Gupta wrote:
> When building the kernel using llvm-20.1.7-rust-1.89.0-x86_64,
> this symbol is generated:
> 
> $ llvm-nm --demangle vmlinux | grep CpuId
> ffffffff84c77450 T <kernel::cpu::CpuId>::current
> 
> However, this Rust symbol is a trivial wrapper around
> `raw_smp_processor_id` function. It doesn't make sense
> to go through a trivial wrapper for such functions,
> so mark it inline.
> 
> After applying this patch, the above command will produce no output.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

