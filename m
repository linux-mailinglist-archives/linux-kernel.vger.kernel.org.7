Return-Path: <linux-kernel+bounces-884371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 521BBC30051
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645574FA2B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7777314D15;
	Tue,  4 Nov 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="no1UisIr"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6A314D04
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245570; cv=none; b=kh+vCURmoU3GnmrxGvZ4ttsrULayFZ0ZsqvqCpjpmjcq4msD62x1ekGVD2fWOC+T/47jXUtL68abXqh1NeCXwTURJdqCpMEPx3Thr0vg9ygTk1CA6xWr555hV8nnhXwfid47oMSuLcOPIcxjNfcmFFUSOba7od4CcJe14N7a3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245570; c=relaxed/simple;
	bh=h2sULprMiu4wN4KAUeGPmQvu2wQnnQR98dqeeRGDV44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r7k92/J07LErbwwYvPVj77hRtQWKOdwfJ7EHdCL7qdfF1AZqTGywpLibf7j4Xcj6Wx5JiM4x7yr5aPSnMTnTcr6slNEcpn8x3xD1YWSARosEORn1DPt28ljV9d6dc8sqL3KoQKnivaoBxtzKK70VrHxcg7ERVawJ4bSMdl025+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=no1UisIr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-639494bed86so8304711a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762245567; x=1762850367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXJXC5xQMOSakE6z31ZXBIwOFgfH9N+KP/Twx5AGmg8=;
        b=no1UisIrJsCM7qet0NJuKdKWova2m4Ls081wkarfe88DruZ9Pwz+a3hlgoH2qy4/e6
         moi984qQbD6EL1DN/YEJxZTUu8CWZr6hLfOqZ0AQlj6hanDC2RXDgl9kzp68OxZbGt19
         J2ByH2dYKW0pTU7lwFHJF7rPr4rR8iKqzr/Sy3iq1fsOKh6PQNOIJhUVBVLnhH06/egG
         FgSXgpIfZJ7cupeS13XjcLNB4shcB8bvxGtLtMJpw8VptsbDZBuTU5b1V6boMsSQJJsP
         DkSo43H4A4B8vEZiwJQ+1E4smYePfueBa1rRfv3DrQVPJcxIXNuyMbmgeH/vdomqSFxj
         AtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245567; x=1762850367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXJXC5xQMOSakE6z31ZXBIwOFgfH9N+KP/Twx5AGmg8=;
        b=xFlQXYuNYpkLMl91NhDi8uEckI6fr81Xvzp7qlPAfAU/ayUbSp6fX0TOkByty7dsyv
         Q0nEWqJGpQ/e7uXpwL2Lsdxf3PvpNBp1Pss8iIBpb0taobmhFnKp8WacNgnPyF5cAWdh
         3IvkDWGJ3RI8TqzKFWqYhH0ud2OI7YzFKDp0t3tbBlOcEPS3kmvj2wpayYeo8neUdD1G
         IJNDfl8Om/wd3aoR7Gk/Nid5Smu4mCzREdyqBx4rywrAaDBA0NuqtY0d0nKo3rFjJDax
         laR58s8K6muhj5qWoB1kf3OnrFsdFB6ya342immNLNqpDlM5PA433+AIoexPenPai628
         uiHw==
X-Forwarded-Encrypted: i=1; AJvYcCVj4xXTKyVQbwelpTpbvUlr5MoAaw1MRfQNagYEXRRgBJAa2Daf5Sz7S/8u5g2K0V3CMWlHVvoK5639Sgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UrWcjUpArDrXrgwEhnkg1sSJHLulvl5gh3+0xuIsemRdzESp
	Hp+jbbVukbtSPcM6zeoAR+dgCvkvlt58LvrX7SbPIAWXNSLOlZhb2eN1A5qgEv5djLa3Dhit+9i
	wQMSiAfrgkHNNOFHSuA==
X-Google-Smtp-Source: AGHT+IHkkLru3RbEHbg6oteE557RNvxiRGcW+0DLs9KKkh37U6J5Frmy/B6gSA4955Mr/WPDvyloEY0RzOh+CrQ=
X-Received: from ejclm4.prod.google.com ([2002:a17:907:18c4:b0:b72:41e4:7530])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:b859:b0:b70:b077:b948 with SMTP id a640c23a62f3a-b70b077bc3emr512890366b.35.1762245566871;
 Tue, 04 Nov 2025 00:39:26 -0800 (PST)
Date: Tue, 4 Nov 2025 08:39:25 +0000
In-Reply-To: <20251103190655.2326191-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103190655.2326191-1-dakr@kernel.org> <20251103190655.2326191-2-dakr@kernel.org>
Message-ID: <aQm7vReThpKDOO67@google.com>
Subject: Re: [PATCH 2/2] rust: dma: use NonNull<T> instead of *mut T
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 03, 2025 at 08:06:50PM +0100, Danilo Krummrich wrote:
> In struct CoherentAllocation, use NonNull<T> instead of a raw *mut T for
> the CPU address; the CPU address of a valid CoherentAllocation won't
> ever be NULL.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

