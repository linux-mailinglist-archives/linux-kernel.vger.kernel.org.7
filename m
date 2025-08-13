Return-Path: <linux-kernel+bounces-766126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EC5B24288
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39981BC251C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297A2D3ED5;
	Wed, 13 Aug 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwaA4KKN"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C292D46DA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069727; cv=none; b=aaZdKpZQPMb6Qhg1xEpG32slZVsUzw6tyed/5wVWRfgFR7uyKlhiGCVcjR4zT9uNGWQ/WrfWy44Zk1Oa20dxyDnZHb7J0iksNw2yA8zn6JwR+nOPxj0ndS9fPF/Lrp20/jcAl5FapjAwGQZxFnrMC9qcZaFfo3d6RDP/IaiySxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069727; c=relaxed/simple;
	bh=ybxFcL5mUeE5p9xeDCdLZnS2Cp38P/ieTu+RyNkH4Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J90K5oZmpjPx4mhLc79ulPdp2PSuOR3EFkBIz6mn2qY6MWOpvLiTfv8T0vPvVALoAPMIBUmtSmSVEDsh3zUx1a5avVLiq89OmRUd1uVeKXXv/FOnOFLzva2XFa2wfU00BbJU3CRfE4zEoMtcDVEs9cu0raRvwLkOu390YuSpTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwaA4KKN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b78329f007so3683935f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069724; x=1755674524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uao4Kl6OxxR7h74naKcsZhVNyrqxD8MN/aOQwmPq0RQ=;
        b=TwaA4KKN7C3tDj7YXanG6ZbDkDQGXAoNK7PpG8RqHNq/IOM2E0Rt5c5/zLZy3Wli6L
         TOZeq5l1WjuDhgxelEGaKNr7Mpl9cZkDNziE+p8oGPj9N21h4Gbg2DrhIvdZ5f/ybA0U
         f8FwY/0UslpaBkW7iaGcUcx3W3WXd24GVlr5XWacaRkw3g+ZnlcodFuNZOhewZqAZnAo
         lKkejD+ERav2O4U3bIDDMlklI2pZT/9OWg/QEkHGq0JYKgNXKyLlwYG5y7BIzfqzAZGX
         9zm/gT04ucpO0zhA9oZDepUF5tG1trNvmFeDGhPJjROL2OWSdq0C8AIataFwS0UjamBx
         K5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069724; x=1755674524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uao4Kl6OxxR7h74naKcsZhVNyrqxD8MN/aOQwmPq0RQ=;
        b=o2uOzzR2THuSXXN7CajfYaOV85heMzko9DUmYpvPRjBL+mySthb7X0qnCmvixCcWPC
         REwCxac5X9eV8jLsU7X2iKriwXlUUAisnRpay82iYczZqy54zTHuUp9rDSCpgwXLkUs3
         OZdwQcswkBFsT2IcCjIhEVIuF95k7Snhkc0aHnvGdxNVJMDfA/St0yUcOW/INd5h1gUf
         iHAhds/PDUNt9Pp/ExJBvgjW1D8xLywEAZNaCygRuZF1rQ05CS46sVQFxr8jxrwWjaNy
         9CbdbnN9kOPJv1w2Jwsivr541s4xYCAVbV6pkhzhtTLsytvWJv9FzCaEJI49nAYSa3ng
         TQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/krV/dfHWsUnvKAl6uu9qsaN1nGsxHgWiUwqp7uSYcfOgHhv4FflSpdfIbKlYV6euHGAtDL7KpniK6Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwMCZTzUPoIOfEEvOl6wsmLMR1lPB76tWtesf8afDw+dgJm5D
	1HgxHDhTOC/zgm1+rsJTuRrxzTcwhj3cDQBA78m6kAO6A+XnPl6ZsKyrlL99BrDFyIyjUn82+99
	NK075f4zodE6gu2b/YA==
X-Google-Smtp-Source: AGHT+IFH2HZb+q/UNBvWdYL64GIEdCoc0p7FEqREP01trPF16T2/9yPdiTg3O/WuCMtfdFXdKFmq/EErimNXUf4=
X-Received: from wmbjg12.prod.google.com ([2002:a05:600c:a00c:b0:458:bed1:8923])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1449:b0:3b8:d69b:93b with SMTP id ffacd0b85a97d-3b917f419f9mr1388472f8f.52.1755069724343;
 Wed, 13 Aug 2025 00:22:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:22:02 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-6-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-6-ed801dd3ba5c@kernel.org>
Message-ID: <aJw9Gsy35koXZjFo@google.com>
Subject: Re: [PATCH v4 06/15] rust: block: use `NullTerminatedFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:24AM +0200, Andreas Hindborg wrote:
> Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
> the name buffer. This new formatter automatically adds a trailing null
> marker after the written characters, so we don't need to append that at the
> call site any longer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

