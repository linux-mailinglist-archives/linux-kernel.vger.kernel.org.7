Return-Path: <linux-kernel+bounces-884374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E8C3008A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C73B4F483B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9D318146;
	Tue,  4 Nov 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2JDe+wC"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54685316198
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245641; cv=none; b=h6AJx9U71PR3ZFKyEQV9C6VVki44iXBw7CCNmM4mX9mJhR1ISLeBMyfXcNmHNhMQYHOSd4oqvYtlOrW127G0pBU8Pi5k3eGiD7P/qAc8Sghf7e43kUG46klIPOdJxSHQ8PVTDCbgmeAMNip3+Xklag7Lm2LghK8db0kS1bYCufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245641; c=relaxed/simple;
	bh=nAPc+TnO1th3O1GSH7GZu4hL5DC4Eiun1Dex1Kln7u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScxIcroHX3x5Hg2dMZSoUOsWXRIJ4QsLhPoVNwjmHtcPEyZcLsgrCAbw1xEVlvBgr7zr4KwhMMhsqeGjE0WZuGPOBqeDu9NWp0vGmE7l1VpgHZcHN6EM3uLdDJPMGtwGTvHu3vvWSEr/iWTWlA7BvZPYs/S61oKFDte4SOLJcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2JDe+wC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471168953bdso42294145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245638; x=1762850438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtZrvT74xjLbmtOOFn7GqR44dgC2/dnDitaPuKQQAMI=;
        b=f2JDe+wCkeUza/Ffxe926OnTZfR4l3aN2nofzypBmPvwLSHzKMIx6z+a//pKPq31aW
         /L3/0lC60IlRRoY8qaPZv8md//gefnPP95rQS2i5N+H9lfauXMna55XZfLGPM5dyHYJq
         1zHb6iJEmNG+Ys5fhZ/rd+nzHD7n6PH+xfrOXBrzKVR0Gu7Aotjyh0Z8+FSfRzHzqacC
         iXtc4WPxjcRgD14o/6NioIY0Cv3X9yIin4bR1G9huPY79UUQhdAbqdvBNJdUvGjt2Qqq
         f1WpSIInAURSSkRuldmEB8/pcqE+FBHA3cFYsH0za2eS+5jBdmwhq5jx1KFLQ600CZWt
         JVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245638; x=1762850438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtZrvT74xjLbmtOOFn7GqR44dgC2/dnDitaPuKQQAMI=;
        b=c7IHb4UsJJJlVspq9ke8UcBEciczxRQV5DX4842vRMerCumYwW1UX8cmA0AKYpzrHJ
         QayoTYs5rVKrKQgXx4IF09VtRIQQqMmFxbs3rpXZ+vjvGE/vDOWJz05CMuuGT3dN15IT
         ntKrA6vt+4ZaePAoQVw1lsgj16YypqPRQirvF0r2uMgiBZj+mZ8HYJF9AhYZeZFxEAow
         9zjaZjZ+436fZ2w4Jzz6JVg752NctPvLBonYFzVroJNUm5RTpVybF0zfSAEqg2bfbi5J
         B5IEenlLZ2N+zYjYAC9ouOFQPk5FtwkuSwvqBw2lSdvE0FUZiyt07eXljfn3+o59zqsX
         kCSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+WUycJrh/KPC6v1Ydgvgw1rbBPvHM+5BiNz9V4LYA/4V+0HyGeWLltXA5GFgDmJjGIMySQQ2dnBFa9PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkagGF54DWssfP6MxmvbjqjH9xRIPTZn/jSQerPcGcf4fp3cK
	gWKBAdCeGhbUD0RHP/pf8ecRYn0u+CwZwHH5bOLj3pNsoOTOY0y+gMOcCVKlvHevexRQfPm8/Tq
	LxjU7A8zypK9Nu0DYwg==
X-Google-Smtp-Source: AGHT+IH7uxFg4fxwEB2oL2v1iRpwri8RqfVOUZGlKBwCB/nKMjy3SRSG5luxCaKkKVK2+FpZjZyZipAwKCX3T/o=
X-Received: from wmwo13.prod.google.com ([2002:a05:600d:438d:b0:477:ad4:a2c6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:282:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47754b897e3mr13537495e9.0.1762245637657;
 Tue, 04 Nov 2025 00:40:37 -0800 (PST)
Date: Tue, 4 Nov 2025 08:40:36 +0000
In-Reply-To: <20251103203053.2348783-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103203053.2348783-1-dakr@kernel.org> <20251103203053.2348783-2-dakr@kernel.org>
Message-ID: <aQm8BGphYfoqKZvk@google.com>
Subject: Re: [PATCH 2/2] rust: platform: get rid of redundant Result in IRQ methods
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 09:30:13PM +0100, Danilo Krummrich wrote:
> Currently request_irq_by_index() returns
> 
>         Result<impl PinInit<irq::Registration<T>, Error> + 'a>
> 
> which may carry an error in the Result or the initializer; the same is
> true for the other IRQ methods.
> 
> Use pin_init::pin_init_scope() to get rid of this redundancy.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

