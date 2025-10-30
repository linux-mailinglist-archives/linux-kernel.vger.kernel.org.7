Return-Path: <linux-kernel+bounces-878590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D5C2111D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5081A679ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF63678A5;
	Thu, 30 Oct 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8GiGi7a"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B53678A7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839384; cv=none; b=pJE7JsOJoy1OfQdVA7BCUnpsZwg7bSTbxlMX/TUoARI9cKsMUGOWrRi7GfIXsQLbsZTRyo1AyZOFW8rEGQlbm6hJlbsuUr+zobI6FmQBGy8+SBtioNjQ9sw5SG2zG2k67Y5R61HsH4Ae6TxgZ4aIvhgYMkFGXqWR5GsfcYw7AZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839384; c=relaxed/simple;
	bh=qGJQXIzENVKhzZXFqgus/jpi9cePk9wkQ5UhmV1zcwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oi2n+RHt5e/aGoyidBJu4vsqWvJXDaGRVuuX6x7swBtQYbSxetDiJtW4Y/vWQsJqvgQgOv/i2wI5xjyGUcdRWyeuJKEpuGWF3eUUL+OCo62ryKfOLcJVZnCcIsf3piTT96nuBDkbBPdFIPPVE97k40F5NzeuVuHXPZ2jAuBNG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8GiGi7a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4770c37331fso7550165e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761839381; x=1762444181; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZFzmAs0SnwZHTyxiCQhAISrQWOnEHGBMPb9o7XdacY=;
        b=h8GiGi7ayUhzt7wVgE/LBAp8dylPUZCZaWNGMBNIdHmCnJr6FHh3AAMs8z+ULMqWxT
         eHlfz0jhKE0wybUi3ghRRaIuD/actUDHfjcEKELJEMw9XzvfUvpRV+KzQvBSvqFN8qML
         X0cPuZw4v65Yz3CDNhFVS4+glMEcWG3x435SzuCht9vkaeUZF0iVeiiLP3tAmVWMhRWZ
         jh4bHRZFu8mPdb6Dsfz2/XNzwZW4WNn6zrMb/nUQ+m9Sextay517Z4wOxdiMoYw/ysdA
         IwrozR0iLeEbqXksF4JLo2CqPBqrcTJDnJiz38YkEjnGrXwpMoV6q8ZyhsTtlSDEl3zf
         SczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839381; x=1762444181;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZFzmAs0SnwZHTyxiCQhAISrQWOnEHGBMPb9o7XdacY=;
        b=OnI/hjzQd/5K2BiwFNJvBdrDeXhhyuAez8aRDlZqC9V9FJUJ/v5iXEMoB1gHd5v95i
         vNt5a2q8JlJM8ls1xL0mYf1HVffaRcbbD44I+VAMZ9O6yT1hClQhTGTaNIddEghfJUsr
         rjBNURCv70CC7gRRooFrrTM7BO8ZnBuMfL4ezhTAg4L0ncCF6JucHdnphEzxN5UQVgSd
         sWKL7LP2X8rGhH8eBkD0AesaVCtkNxXOLq5PVi0Iem1aB7DJX0odY+Vjp8Qf5JNULBYl
         acL7Vgum0JQ900qgKAArt3y4M2/E6MQ8iyqWVEZU1fy8jPCM0AexhLE+BneWe8FL/9a/
         P8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpOlTSt+w2atfCtn3c8NAh9PoR7gaVXXJnu19cHWx0Z3jZSCEJpgLQEpvFlmSDuenGDPzFDB3is8PUijk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Zxe3TdC1RRkK0efIW2AT2n6mTiNsJBNB7gL/bAROpchp0pp5
	5IySvAYqlMhyEzAB7LXDwxdSW8qxdb+4XnHasWL8/D1fT31kS9MEEkVrE3ljmu25vWWJNXJNnxB
	aFraNfBftd7yvDQ==
X-Google-Smtp-Source: AGHT+IGBA2lpZUSLCjfeKNqH37XEkgRmaFO7ZPXyGAUePy8kb9MXP5eNENudc2tbx+F3YPjQ8UIPJq3fcamnSg==
X-Received: from wmbgx15.prod.google.com ([2002:a05:600c:858f:b0:477:e0a:f99e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id 5b1f17b1804b1-4773089b541mr1846735e9.27.1761839381266;
 Thu, 30 Oct 2025 08:49:41 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:49:40 +0000
In-Reply-To: <20251030-b4-prctl-docs-2-v1-1-396645cb8d61@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030-b4-prctl-docs-2-v1-1-396645cb8d61@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDVRXPUAWTK6.2658AGIB03073@google.com>
Subject: Re: [PATCH] Documentation/x86: Fix PR_SET_SPECULATION_CTRL error codes
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>, 
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<aesa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 30, 2025 at 1:59 PM UTC, Brendan Jackman wrote:
> -ENXIO   Control of the selected speculation misfeature is not possible.
> -        See PR_GET_SPECULATION_CTRL.
> +ENXIO   For PR_SPEC_STORE_BYPASS: control of the selected speculation misfeature
> +        is not possible via prctl, because of the system's boot configuration.
> +
> +EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller tried to
> +        enable it again.
> +
> +EPERM   For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH: control of the
Ugh,           ^^^^^^^^^^^^^^^^^^^^ that should be PR_SPEC_L1D_FLUSH

I will wait a day or two before v2 in case anyone else spots other
mistakes or has other comments.

