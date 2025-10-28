Return-Path: <linux-kernel+bounces-873455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E9C13F80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5616C4E3C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294F2D94AF;
	Tue, 28 Oct 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K65tqmKV"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62962264D3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645408; cv=none; b=IG6AeBSdliRIUDzpZeCB3l1JnwgEVH3R1LR0EPuWWBBncRPAsKQslkvLvZDs++hO6qT3AaUHaypfCZx8I6QqTr1pz3jNSx0JJRTg/oQpWeHPim6b3JLE0VOa9DYcz49xTffjfmQoUG7z2g7fRB0EOdEbAUHr+7HswFW2+WIraGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645408; c=relaxed/simple;
	bh=hX3arM2xiiK4Q34ajAmL+1FBdzbIGGsIsV4SUogzEq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6B+wxBUenehhxHJehr7EI1g36qkXAyQ17tI23+ehitzEsvhqLIk+BRtc46Gdlw8dbNXBYjvn5Yhno/fPSsHKn6zDuqxfu6cuySdlLiMDogOSt8w1jHGhZQ+X+0gec0oe6qo38J5cnnfkpLrpJoUPj2FYWTEs4OqfBmXKiWRADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K65tqmKV; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4270a273b6eso4205975f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761645405; x=1762250205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw+QQNhXDjAHwQlCRIGKYXkkl+Ihpl9g0b/qnFHKe40=;
        b=K65tqmKVS2/UTaw3AeZdd+g9Ceq6MrgkaERa009zODN08Zaf/6bvYG7HdNBRbffgOu
         vUowZqJWqmJ9ihq58r+9FTe9U5+GQB+piJZdpoDXMBQPeFCMcUMWmbgutTs+8aMBkB/q
         F0GJ8gOvPuVQyENYsZJIrxkyi8WIl3f/9zb0qCugAKDjnNpycsjXSfCnChRV0wYnPUgI
         XxG4LIgQKrddVZm5ZOXGFMUreQAzpO32VS8RBp2Ba69vfRzVPXvd9DKStrsJZ8wvW6UP
         e/6sPOF1oSVslOBYqKqzwHF878vw8zbPbfsE3EDk5uW/JXmv41zQl1K/gsMvRlA3uB1C
         zM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645405; x=1762250205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw+QQNhXDjAHwQlCRIGKYXkkl+Ihpl9g0b/qnFHKe40=;
        b=dbsN6Udpam0u2WCJ5xvM08yrXSMTmQ8G/S87ZBRAOTthIdQs6xl4Ux+yCMzDsUZNeL
         uCr/2GORpfiL5lQpWL6oK9EUvumn+C7ROqMfhPfo1H2+oNR6kAWq7EknKFUCaFGR9iTN
         +pKNDhsuZmANJkMwHOMPl6xzcVjSpSBK2QL1Yyb2f2lVrfHc9mTdQHhesVUqDhunPd4L
         2oSiI4LEfXR9HcWVP5ndhURsABFd02HDQocXg62a7E/td6Jb6iD0pTPooANQEUfTASdb
         jDtVG6akByo9zhPnVSw1zAC9Owqe/OJLWN/b6TTo/iz2zf73rKtFS2uU1hFJ/EL/tpkF
         Um9w==
X-Forwarded-Encrypted: i=1; AJvYcCWax0HIaQaZ3+hmhRwLlf/1WOsmT7BxYVamOp2pA2AFIUZqJdGz2VA+RcvI+pTgMYs6Jl/pnkqlpSuTDvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJ6U7WL7a9y/5P7r8olv4tFtfSqVdbZAdsaAVs8jUqY8QIk0f
	BFaz8uD9Yj3DebDz8UOYeCKL5U6EFPXlSyh1CF9n28KDcr5v+3k3uN5dT23ZIDnNtqzSjwo3slC
	awPQmbyFJiRpxb6dYvw==
X-Google-Smtp-Source: AGHT+IGKSheu/Xc5yKyOddxTaI38qkdiTdyZI2k46808hMqrj+mZdBsGHh2ZbiuVOKReAHQyOIZMyqCAx+5qwRQ=
X-Received: from wmsm26.prod.google.com ([2002:a05:600c:3b1a:b0:46e:3422:1fcc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:620a:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-47717e54b01mr17567085e9.24.1761645405225;
 Tue, 28 Oct 2025 02:56:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:56:44 +0000
In-Reply-To: <20251026125458.2772103-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026125458.2772103-1-fujita.tomonori@gmail.com> <20251026125458.2772103-3-fujita.tomonori@gmail.com>
Message-ID: <aQCTXFcSyCxJ8KqD@google.com>
Subject: Re: [PATCH v3 2/2] rust: Add read_poll_timeout_atomic function
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, dakr@kernel.org, 
	daniel.almeida@collabora.com, ojeda@kernel.org, anna-maria@linutronix.de, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org, 
	gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org, 
	lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 26, 2025 at 09:54:58PM +0900, FUJITA Tomonori wrote:
> Add read_poll_timeout_atomic function which polls periodically until a
> condition is met, an error occurs, or the attempt limit is reached.
> 
> The C's read_poll_timeout_atomic() is used for the similar purpose.
> In atomic context the timekeeping infrastructure is unavailable, so
> reliable time-based timeouts cannot be implemented. So instead, the
> helper accepts a maximum number of attempts and busy-waits (udelay +
> cpu_relax) between tries.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

