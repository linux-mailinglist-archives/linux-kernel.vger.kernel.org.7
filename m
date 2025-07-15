Return-Path: <linux-kernel+bounces-731440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CA1B0543D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B504A2EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F504274659;
	Tue, 15 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIzDG21g"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DF26D4E9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567165; cv=none; b=O5L4Flyl1TQHdiPBCtQ6xc/ROH1Xb8mgck/HSrS1bt2aTcpOHP903AtV67AWjLNGj/uerFXyxnh4kBWippN2pNJmbXR/6rv7lAor8QxxU9r0v42ltNyS3LnlmoMr6eLIhgpqIPtH4hKAn76m71hiNl+4aHWQpAhSojRTnjuq1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567165; c=relaxed/simple;
	bh=Ky4Avv0QnrWzPEmQKUX5pAFkfgAzrZy6gHmih3m8Kqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=La6aF+tfHtDb6VamZ+WfophhSeSs9wl3EcrLnD60AiAtNOSIE0fBhA6v7hL5p9ykZZdhiqvV3RsZwPev+0cucndD3K9YHNwlUIlqixHgOqhf++qN3miEEzXwp0Qen134TOnXO+x3zf0FxzduKeYg0N8m8y0sjj7T/FkC1IIkgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIzDG21g; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-455eda09c57so25920585e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752567162; x=1753171962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/h14E8vRIbubQT7Jkof5NhlHyroE40msmuI9PnRR/fc=;
        b=HIzDG21gG2UpBDxswcfGimN6XbLffJML0H2MBIjOg4M/b93QQp090Bo/UoVDdMlNvM
         SRJm+CR7w9vWKIhpyNMreG/Y8jOpn/kMLayjTppoFggCgYCHrssq8y7g1XS+fUcPWDu7
         Pt1597f5tmMruVMSPmDD5JdReNu4Eu7HBCl7wW8Qb5FgZEoAQx7Pn1CiUmkt30xrLSj+
         U35qfawUW96prUQ0gPSyVFIhwzLxcYcfxTZ3fzBgZrwU1i0WAp9o9GxdZkwNHjpqLjiJ
         DggbcT37kwxoTKZhGdq9QOsGxWnaNj3673/Hh1Kn/r6kVFdST0Vic9CF+s+mWlsRA6Ma
         aVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567162; x=1753171962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/h14E8vRIbubQT7Jkof5NhlHyroE40msmuI9PnRR/fc=;
        b=AG+vUWUnStseZMJfa9Mpjp1/lbxnddWT6CjIjnAZaAdDv5zC+S6T28IwMqZpS5Us7g
         Aduf0MT79DxW2qQcrqwdrR8ihzDqoaxkhejMpoO2gQqLtSlNsvC0F2hx/3RQJSYCBla4
         iY+1u67MItyHSnZ51F9sm0TmzE82sn/rECHVayPPTTpazSUYTKlU5xbBlWf3usry9cTX
         JZPSMcJncgwJQ/hNsrYccnY95ZUyVOlE9Hp1jOqZe9CGzJWBBi6ZTjkbsRC22LdKzgy1
         jzC0jen3pwNRaMtinkrikAl1vN5+etzAQjV2gkdCCb0oDrssv0agNqOty31AdBP8QtVH
         3i8g==
X-Forwarded-Encrypted: i=1; AJvYcCWNdrTmfCrUzgJC0XDr9ap1WxiQlyKCvgTAZrryKhEfnpO/ErAIvml1jFL/5/MUFOKtOUgNhi76EXTKCEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnVsENyKjcIWahWFMnk7RwwQ+GC1wfZuNVfsO4vOW3f4vc7Nw
	YcYUXANOQgVk3SBBz/5v1AUhjJwZ/sJL/2IWb/StBphaap3VfPfy4JgNiVoCQwM/Fgymofl1JcL
	zAG0zlStXUl31FeXDyA==
X-Google-Smtp-Source: AGHT+IF5afMDfNleNN0oQTuKDP0mH+C5i7ePz0OsDjlhLql04CRpkA94+03Bwy7p3WyMeG49jSaSPmuZgQSU3II=
X-Received: from wmbhe12.prod.google.com ([2002:a05:600c:540c:b0:456:245b:44bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8909:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-455bd87a4c6mr114642955e9.2.1752567162502;
 Tue, 15 Jul 2025 01:12:42 -0700 (PDT)
Date: Tue, 15 Jul 2025 08:12:40 +0000
In-Reply-To: <20250711-topics-tyr-platform_iomem-v13-2-06328b514db3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com>
 <20250711-topics-tyr-platform_iomem-v13-2-06328b514db3@collabora.com>
Message-ID: <aHYNeEjQXz3CxfEM@google.com>
Subject: Re: [PATCH v13 2/3] rust: io: mem: add a generic iomem abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 07:32:28PM -0300, Daniel Almeida wrote:
> Add a generic iomem abstraction to safely read and write ioremapped
> regions. This abstraction requires a previously acquired IoRequest
> instance. This makes it so that both the resource and the device match,
> or, in other words, that the resource is indeed a valid resource for a
> given bound device.
> 
> A subsequent patch will add the ability to retrieve IoRequest instances
> from platform devices.
> 
> The reads and writes are done through IoRaw, and are thus checked either
> at compile-time, if the size of the region is known at that point, or at
> runtime otherwise.
> 
> Non-exclusive access to the underlying memory region is made possible to
> cater to cases where overlapped regions are unavoidable.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +impl<const SIZE: usize> IoMem<SIZE> {
> +    fn ioremap(resource: &Resource) -> Result<Self> {
> +        let size = resource.size();
> +        if size == 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        let res_start = resource.start();
> +
> +        let addr = if resource
> +            .flags()
> +            .contains(io::resource::Flags::IORESOURCE_MEM_NONPOSTED)
> +        {
> +            // SAFETY:
> +            // - `res_start` and `size` are read from a presumably valid `struct resource`.
> +            // - `size` is known not to be zero at this point.
> +            unsafe { bindings::ioremap_np(res_start, size.try_into()?) }
> +        } else {
> +            // SAFETY:
> +            // - `res_start` and `size` are read from a presumably valid `struct resource`.
> +            // - `size` is known not to be zero at this point.
> +            unsafe { bindings::ioremap(res_start, size.try_into()?) }

I thought a bit more about this, and I think it's fine for these sizes to
be converted with try_into()?.

> +        };
> +
> +        if addr.is_null() {
> +            return Err(ENOMEM);
> +        }
> +
> +        let io = IoRaw::new(addr as usize, size.try_into()?)?;

Though may we could avoid converting it twice?

Alice

