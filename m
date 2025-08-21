Return-Path: <linux-kernel+bounces-780827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DEB309D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB69F622859
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61E92D7809;
	Thu, 21 Aug 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm33ZgU8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333822CBD9;
	Thu, 21 Aug 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817841; cv=none; b=Osx29WEo5de2dDE5HArVMqM4TNta9utdsXRTnbpi9Vp6mhHIlrvz5nJqCTGSIfE2g6CSKg4Smsoowk/CTpCCxRQ5/0hX7SmuPCHx6x7n4lvMfBp4kafi6wCLl6lSrwxEw8zXuclU9lLOiJl43RHxny5tVPARbYMDMAERytAMHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817841; c=relaxed/simple;
	bh=T+twVHAZTPt6Lz2FfIrAVcjH0TfwKvyAJmMhvulNTZI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kX+LoOg/KpzEag6z2Llq99IKCOrzZJIEdDJYkoMaX5UM8F9Qhs5db8BqCc1u+TKmd/N4R2OAI6CXWSC0hE4tcsldIuKgj9jqucdQ8ypTK2Kn5uqP/IgNKlp8cHWsCbr3+Ra3++rdxIftc8GQ7bYb5/WhpjGvaAZrkPbRm5hcP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm33ZgU8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-245f3784edcso14833455ad.1;
        Thu, 21 Aug 2025 16:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755817839; x=1756422639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nsLXogIrl8xrd3K0Af1S+3Ycr+ymK1uf5MIM01cw/c=;
        b=Sm33ZgU8gOVd6YL/ujxVDZHezb7gJ5XoQU+JDcECe1G++Y/6nyfAZXyYTgEe0zkphI
         EG9dpCqs4tZbJmdRCVit/8+t+XoZf8OhaIK0jsFie0uiYV9M4vscqnlvEtzTDOUf2bdQ
         rhNaqQrQWRkt8SJX5jtUD0qldbf+op3xbmu76qdhwmzyb2y9s+wGUvgsbeVm33M+4CsY
         VWqV7ks6Vgy5LuhDFwhpvfcTM0i7lMnNbI231PnAh+F9dIwUgKTBsTwbkihD3NdIX29F
         JZCCNb+PW6U0W11mG+RgM52kSiRnIQgUeNpTPrKLjPPdKHMVZI/9hjynhG1lPF/seUXI
         AcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817839; x=1756422639;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3nsLXogIrl8xrd3K0Af1S+3Ycr+ymK1uf5MIM01cw/c=;
        b=sQx18CrJNgi0GdCDG7LbmxwaeqnOhYNdFgMYF3K28zSG1UalDULGJLR4qq0UGfKmof
         JJ0nHQbos9QV/Ngvtino8AVz/p3dKyKIYuzpLNEqSxXZlj2hRZ2tZtfS79XBNZ8ZN25z
         Zo7fJ/AMXZ1xXYijiuAFXldx4EbxcSZ1YBE9PuDqW5inCjr5dxc6HS7kPi2+9vp4wePy
         hIztjA1WpsavKjlAhPGi76NYCwK0cQptBI7IO+FkTcCFf/28cCGulW+ZRTk2+XDVZ0W5
         2D1o7LLzZELuZiRH9qSDHP4ksiC3Jrt+5vYr4JLRz9+nAvaeYRDPHOz3cHbGJIUwHJ/c
         KTzA==
X-Forwarded-Encrypted: i=1; AJvYcCV8KS4lBlgBCoN2ANyTneoRS7yfaZtWhHZ2FmGGndGRenc8XG4/U9+x3D3rcrbfTTWAN27C7Fj1gNHoDi1Hnz0=@vger.kernel.org, AJvYcCX6xqoxsQ2kIYo2Xw+imFRqqcQuQEIx9v3BDBhwhi2U5bOZbOLqhPJcuJloBxyZuW1z3a9GLuqfjTkdZso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfdi07yWQl6OuH/fFWFLrfx8gPB/eusX0UHmK8HtF7wLNFxdv
	0GD/mvEj7bsreFffUmjzD6JtYayjpKcctF5mv7+FrqZXRxfqvwePNMPe
X-Gm-Gg: ASbGncsMlQ1sIqL/fSSQT41/a0h6ca08k63FVMzRROyuu6H5qury9F7752HCE7HHF0u
	ASGSejmE0XybV6YdfOQfCg5tUhTBNGqZCzmcJiPBknNqZZ2tWijpTR2HmLmdDx/xgwpEkkPqSpk
	pkvPXz5rZYwzRNm1bdo6ujGmzzr2kYWB+ilS21NdDKZQL+pKHA4sfqcKuwq73AgeEUqfn5y7unp
	PdOupJ/KSXnJKXe6RZkoj2zNHUu9s1owegrsuLSg8lCn/haDSDiwhGQSGc1AwFf7+ANGFxuYLsS
	bs/m1JukC1AM/c/B5KOhp1OKMANvT5eJQkUfgu6fCxuxIke/Hs2e7C2ATVp2nS6sRvf4vIjf6Yv
	rjGP8rUNWyOyXLB12k2yvavLET/Lstd8I/KY9lCLas7NLNwSbI+sh2baC98GzcInNrPYqlBe9BO
	OqiqW3PD5NvG0=
X-Google-Smtp-Source: AGHT+IFAGx9GKx5UE5Qz8TKBOnSw+oarRozQQe6UFlnVDqopLmWMDq/InLWY1E88OwmeCC9qNsteXQ==
X-Received: by 2002:a17:902:d48b:b0:242:e38c:89db with SMTP id d9443c01a7336-2462ef1d442mr14182155ad.35.1755817838927;
        Thu, 21 Aug 2025 16:10:38 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ebf7dsm65559555ad.120.2025.08.21.16.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:10:38 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:10:23 +0900 (JST)
Message-Id: <20250822.081023.1458109299973034275.fujita.tomonori@gmail.com>
To: lyude@redhat.com
Cc: a.hindborg@kernel.org, boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 frederic@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] rust: time: Add Instant::from_ktime()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250821193259.964504-7-lyude@redhat.com>
References: <20250821193259.964504-1-lyude@redhat.com>
	<20250821193259.964504-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 15:32:46 -0400
Lyude Paul <lyude@redhat.com> wrote:

> For implementing Rust bindings which can return a point in time.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> ---
> V4:
> * Turn from_nanos() into an unsafe function in order to ensure that we
>   uphold the invariants of Instant
> V5:
> * Add debug_assert!() to from_nanos
> V8:
> * Change name of function from Instant::from_nanos() to
>   Instant::from_ktime()
> V9:
> * Fix outdated comments in from_ktime (nanos -> ktime)
> 
>  rust/kernel/time.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


Thanks!

