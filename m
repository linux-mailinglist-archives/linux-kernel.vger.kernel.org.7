Return-Path: <linux-kernel+bounces-871422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E25C0D350
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09E04F6C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44D2FB97F;
	Mon, 27 Oct 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q571Cl0m"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0C2FB962
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565209; cv=none; b=lckoy/0hobbhmLvNKaiDp6zJAUqd9OPyTMoSCb1/1o5j7Un2SapTjZh7eJPsSUDVzQGAZHCC7+O5C0arrFitJ1Grnu8DR5BvS/mnw6FQuVyAyjpdj5ZKCf7jrAeqQ4Bjj0m+kW0c5mGThGjh1q/R22/PrtuZrH0sem0hHwXMfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565209; c=relaxed/simple;
	bh=YPkjhgQsjThuXqWFy5i7w/67sJGvH2uEY660YU1WNxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IO3GvKGLocWpgt0b0eXfMEYnCw2cg0RYZaeVNkIK1wA/kxeFExvP9Lik0n0gy+sCadbGW+ejuvptfsTRDTSf5ySvcA5NUo5w+UMMBCta8wfiqMkMVfx8ltycwB9jDLQ68ojWeefUMVzd2jMTwYqcRms4UdxszU+IzDcECVtU82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q571Cl0m; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4298da9effcso2350479f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761565204; x=1762170004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZuQqjG5s0Z3qRbuNWRLn1hkXv/QvTCnASzex4N9z3I=;
        b=q571Cl0mGWvUbH7vx9n/Zi2KM7QxD/MD8iWPRGIwd09RzGsUi0tZms20tKQz8nb67z
         WcvJTFDU92CFh8NyY961bbNgfZ5XrZQEIJhgtQ68hx+qBzunz27KHSOAFu1uDziTwviA
         B8XQ0B+3wSiwIRuFJneEi+U4ipT5kL7PCEBnKGu4EC8Du53QCaeg72W5pl3e7V0Cild4
         sAPqFXd5QrkDMSqaDw6FulqEJQvJJk8yshO4BtWyllLrZ1WdoY4tFnByi3LRPGoqSrtm
         Icz1pKBjmjJ2Ik2quno5rCkadZTl/WwZcXcI3PFqMyBQkKnMIsV87x+E3+BAsbPbuT3L
         mvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565204; x=1762170004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZuQqjG5s0Z3qRbuNWRLn1hkXv/QvTCnASzex4N9z3I=;
        b=msJPilG0S42K66de/poPWHFoa2JNooNXjzyqmRhl3+8frNvd7N4sRfx+IQ7rjDS0Am
         5hvKQpIn5Y2eBt/l+8sNE5EG9BMDL/A6Fmsai30uc1rY6KJxFTACrzzkzSKIhkj+dGjd
         Qy4YuyUXfhDm2Brx43JFNFdgOv1kjZNhf8IFy2kFbniiv9EwknI6q2mhE1nD0YV3uWUG
         Bx9T41B2HjJBh3aJQg/b9hdVVqOiIqjivJs9X39f8xeOnsBbhjhbDO9nPvjeXnhnSOAh
         UHQtqvceBZsiibyqju4+k+D8ilSMDNkuh2blLYa+RM6gasrIy3bTFBJD9bqCbRzuPFih
         m8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd9G96RE3yuixQznUmGeGPUmappJMJBx9knC6LFRkql+T9XV23iLiiu6t/W3pmnFYwafO8gDKadVWXT00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhttHJY9mHW0QvgoZm69R2qblSJNXAIgDJvkGOubBogfVW8MP
	WumgENx36cAvrJU3iREmOq8WhhpXA1T4Wv6wfF38UVmqr+scH6AEvhA9WOkw1BrIzMmyTJFNkVs
	LClTWakgg/eQlw9uEVw==
X-Google-Smtp-Source: AGHT+IGZdmrHho2PxrtxXDy5EiEwqQfUR912bjl7014HpGUrQSLwMPAox39C/G4Co7FFMPTtNtFH43/PZuOv7ZE=
X-Received: from wmwg18.prod.google.com ([2002:a05:600d:8252:b0:46e:1e57:dbd6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:800f:b0:471:672:3486 with SMTP id 5b1f17b1804b1-475d2e7e9c3mr78418125e9.15.1761565204212;
 Mon, 27 Oct 2025 04:40:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:40:03 +0000
In-Reply-To: <20251024161525.1732874-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024161525.1732874-1-cmllamas@google.com>
Message-ID: <aP9aE9kZsSawyA19@google.com>
Subject: Re: [PATCH] binder: mark binder_alloc_exhaustive_test as slow
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Tiffany Yang <ynaffit@google.com>, Kees Cook <kees@kernel.org>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Oct 24, 2025 at 04:15:02PM +0000, Carlos Llamas wrote:
> The binder_alloc_exhaustive_test kunit test takes over 30s to complete
> and the kunit framework reports:
> 
>   # binder_alloc_exhaustive_test: Test should be marked slow (runtime: 33.842881934s)
> 
> Mark the test as suggested to silence the warning.
> 
> Cc: Tiffany Yang <ynaffit@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

