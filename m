Return-Path: <linux-kernel+bounces-884373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D89C30006
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 032DD34C072
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C63164A0;
	Tue,  4 Nov 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skcmRH0a"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA6316189
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245616; cv=none; b=FSsfVszy/zq8r4qA9wlmWq9TAw3BnsOt6fjda5gvGrRAQKsP7xmh77NMuxeDXgODf1TuE+jxDWS6LRH2LBXZ42E/9WtZWhVbtXCHTY5zDO/65BxbKjRlHdhCGFfTS8g4XXIpC/wapOgWBVmvqVBZ6VAYAKfqjv8Yy9P/XZq1VLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245616; c=relaxed/simple;
	bh=861Choy3GbkM2iT6DyDZedv9XDJesWVVc4e/eJiX4zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UKwcGNXqwl2SzytzsKtCVHgXKBZUOEcm1ChwW/+fu6R/sg3Qrf+AUNauhYwHvYrfDd7N2PdUxoD4gtiBN0Le2rBqSSp9UAGlxVNWwBk2B8M4im8zzPkYkG42889sizkH1MbCKp6GcnWaDLuYp6lHKeHcZOIMJ8vw4I22kgwdKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skcmRH0a; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640b6ad1a3eso1899613a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245613; x=1762850413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZ+6WBy0DpH/2X1JFXWHRC2GMTvQN+STo8LsdNvJ0=;
        b=skcmRH0aOLQ1hLBbunxWeRC9fLyO0lK6ev8k3Uu03Vt1rbShUXQ8zHMKcCmhFphxP6
         49w/NJ0QrZWplafLABqV03O+uZWvjXF/swrS6TdakfxDjLaLN7thhv4Wwmux25SccEoR
         qNJkH/qzpu8wWGlF1QHqUH2yQs/BSmeWL++bTNXxf9abflQjmmMaN1aNmteMQUZhG8ZS
         0NqhulUNLNV3X21WEIeEkS1uJcQWTTGYRnSRlb+5PBs3S7bY6Vd/t1g4s4cAt23tMmHI
         5fgmPRTfmlUrbLI4QEyZ4fwpMVnerVk/eyliAiGJcghzcmO7BVEaJO/deKmvxbXLv6IZ
         Wd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245613; x=1762850413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZ+6WBy0DpH/2X1JFXWHRC2GMTvQN+STo8LsdNvJ0=;
        b=Q7hhDptv42xHoPrWXT43xOFJPy6eK9dwSbrQ3DKErlXpovjJsBUibPbOlQRqdiM6du
         uoCQuud+PIBGm/xH6y2eJHfhoOrsePC19r4zc3YUqYZnUtTDFbpGS0+wjEv0MMINqbNv
         rKmCE7UezqVWxZhlC0CIT7pLIxvroBJuNUTgImSW6xh1F/926zFzMAwR2iEf+9sEWoSg
         OwKwLYeJt2mX8XcugJE9GbV8k27IsCxsD0xx/1+jda+QX/ZA0HZXxx7I5nLVqYF+ny8D
         x55BMjhV6gWc1yGQucNTZsPmgwdozTanGOKlb5RS4L6Wja3aefaQp8DdD2uIfbq/XrhK
         2Qag==
X-Forwarded-Encrypted: i=1; AJvYcCV+fXn1r7S3EiWQmRHypfut7mVza2OiGAgdgdombfbi5JFC/6XTaN5i+5tljQg4FGib/HYFSRB9BhUxbKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPvXwslt4KY0NARjt2RNzoVSU8HTAraTr7RTcxPaoSamdakpM
	vzO92uXDTnh2ohMnu9kLbm7uW1rQROp9fADLrib1MV7ae2gq04Ch9h+L8g+O1e27GleP1tFvBwP
	37cawbF8dTnWFjD+C4w==
X-Google-Smtp-Source: AGHT+IEI2OOsck3lPELYTHDmiUDPX23aQ0zOxe2XMSiUyFnIXk35xi7d9IgnDvvQ2t8WeW+/QGu3reFub1xwlLE=
X-Received: from eddp22.prod.google.com ([2002:a05:6402:46d6:b0:63c:592c:cf21])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4310:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-640b7f139abmr7115706a12.23.1762245613116;
 Tue, 04 Nov 2025 00:40:13 -0800 (PST)
Date: Tue, 4 Nov 2025 08:40:12 +0000
In-Reply-To: <20251103203053.2348783-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103203053.2348783-1-dakr@kernel.org>
Message-ID: <aQm77Iv8_odvASCV@google.com>
Subject: Re: [PATCH 1/2] rust: pci: get rid of redundant Result in IRQ methods
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 09:30:12PM +0100, Danilo Krummrich wrote:
> Currently request_irq() returns
> 
> 	Result<impl PinInit<irq::Registration<T>, Error> + 'a>
> 
> which may carry an error in the Result or the initializer; the same is
> true for request_threaded_irq().
> 
> Use pin_init::pin_init_scope() to get rid of this redundancy.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

