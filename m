Return-Path: <linux-kernel+bounces-884370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE866C3008D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998061895D13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A70311C1E;
	Tue,  4 Nov 2025 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijSniAux"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477E29D27F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245548; cv=none; b=mbpKLkUbeAj7BXOxV0VR/sIpCOa2FaUkvj1+xz9bNG7PcDL5s2hCfUwRGHwc6Zbk20FYskXuprfkoZI9G3rg1Auv71qrVyx80Gj+fT2g34HZ5LFGZPITq0aLczGpBY/NrZ8u3n4AxmgPCAppjAOUckSXBRIUWzgdtUgfOurSUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245548; c=relaxed/simple;
	bh=t3IUp+ARaNaB8wz2LKnZxVPm5xytJ0pZwMX+fyMtQ0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OwQfJMz9FdxvgsAwiUfG/WwugEbU1XDQ1Xa6jV2PzJdX28zIQNzoQU8ELFr7TRCs+MnqjBcdMiqaKi3GudyOIKLK6qQ2bGghHjrrBqJZ/vjibXimUoNDRzQfODWRk6Kso4VuJr3dLxhCmGwoOPBSH5PTjOUCD8v+4EuFpS6Clt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijSniAux; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477171bbf51so28883365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245545; x=1762850345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WSx4j5h/K35W2b1U5cMePqydBqgF/bke1+7wCGvmmg=;
        b=ijSniAuxKDJPa4ZM2zvcejUKc5nMw6zIDhWVwoTLQ1FtbnQOnGWgEjslH96U4vHTVs
         LsSPJ/nbCiGpK9HU9U81zUq2js5wDH15U9GuVkUJdR+JR8G+YXrmEZNfUt6QZ1BE/rfK
         gb8MGr4tujpX/goxMK8KXOhRkT5Cw6aXgsljJLQrAGZ/Y7X0UIW4rrR9b0WxPIjzo7f/
         nVnwkaLRIiI8fW+3c+2ijNff93rdC7jNobF1bDfEZwPvSJ7h2kU840OgPjy8Wnf8TjkX
         /WA0+HuGN0Qw4B4ExtAIcLLJRiMH6dC46OL5OLibEEEokx7D9RVnc9ryHOcctA9dsmct
         YmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245545; x=1762850345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WSx4j5h/K35W2b1U5cMePqydBqgF/bke1+7wCGvmmg=;
        b=qfre7eJ6vLujrM8qMZCbNfoFy5ZoptWhD+bPS0qH1+gTvQBj3FOrH/Xh2SDJedcPwz
         mio/mrfx5nPwizuRg32/3g/OL2BIawwGAguawPDZSWfmyZ8iv+AiaDaWjxNFyO8j/J7M
         Nm0CM2p7utUqhdocfmJoVrGKi627VtQhx6PCQhQ8KBWK9tFgC6QlZWXBECqlcPbH0PMk
         FiwFuz/UsudE99cMSMbLjOmQa2Te8deyamuu/cOImw1yArnsCyjOxefub9AmbWX2HKza
         wXsEgB3N6T4/rXBfmIpAzPXHsDKIIvORRqQP5MVTbUhiahGEBuhvRnm3NnYpS7biKrV1
         EzZw==
X-Forwarded-Encrypted: i=1; AJvYcCXh5tAbgoztji66SeavyiBavctZGwkatGgeVRy+cAynUVjTZBWlBD976qu43cbshlVYiNoEVOkiE9h1PZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNw4hrjzqu42axmOwQtxqEbqubOgRfpeP8lgKtj+s63SKAYUC
	12fkN5ekyAx7NFgXYCgu1DtohgdaQ9nIRTnHlL0JtgRwZlcxPYArBjTMBxO0rdkC19Jxy7z9Huj
	Nc9EKCdqLZXS4Q5x58Q==
X-Google-Smtp-Source: AGHT+IEsoqg3j0WNIpG5vxJRX/Ibh5LrVrCjTx9dh/pWH7qA/STRnKJkdScMyqeumJblHqnk9Ea0X4NaSd6gQqo=
X-Received: from wmbb2.prod.google.com ([2002:a05:600c:5882:b0:46e:2eb4:38d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1553:b0:471:16e5:6d7a with SMTP id 5b1f17b1804b1-477307ba7d2mr133828385e9.13.1762245545262;
 Tue, 04 Nov 2025 00:39:05 -0800 (PST)
Date: Tue, 4 Nov 2025 08:39:04 +0000
In-Reply-To: <20251103190655.2326191-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103190655.2326191-1-dakr@kernel.org>
Message-ID: <aQm7qLybSn6bOlCy@google.com>
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and start_ptr_mut()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 08:06:49PM +0100, Danilo Krummrich wrote:
> Using start_ptr() and start_ptr_mut() has the advantage that we inherit
> the requirements the a mutable or immutable reference from those
> methods.
> 
> Hence, use them instead of self.cpu_addr.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

>          // and we've just checked that the range and index is within bounds.
>          // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>          // that `self.count` won't overflow early in the constructor.
> -        Ok(unsafe { self.cpu_addr.add(offset) })
> +        Ok(unsafe { self.start_ptr().cast_mut().add(offset) })

I guess this shows that the mutable/immutable requirements we inherit
aren't actually what we need?

Alice

