Return-Path: <linux-kernel+bounces-752479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A8B17609
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CA18C39CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367E28F935;
	Thu, 31 Jul 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AjWj6DuU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EF1925BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985748; cv=none; b=TMJzAYGvvTRbJM/SxPu3CGK85JQtlIBYtHHkLxn0Re3Xzc2XQrGci4lokLKpLgGZhgRMhhyzTy3iRh5UzCL95M7OeJEJRGINKz412FE7c0LwRZT4b8QT+9FRwnGrPthkFPm07jPZ12LoKTYi8JqCsFv6hHJ78fBHcvmxVDPnE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985748; c=relaxed/simple;
	bh=RCj9kXQC4IhWtvndRd38e613bmkzv+xVOrNE+F/EeOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyLhvix+UyBJiW/4/IjcKnnBODAbQPyXQBStysILEuSw8QHTzE4kV+jA5RRmz38sBaAHBQxIEUNXp2lDT8VmUvTYE7xm+2lKthKGPpZLyH/IWrncmEXt19nObkwwaqlKZMCV9OKhJIz0QO/BBsrAKAkUjDBC68mj8vY0fi5euJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AjWj6DuU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so249753766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753985744; x=1754590544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4A4McOc7Yjfkn3jJT361607pPpeEy5Y04HOcqe8Ja8M=;
        b=AjWj6DuUdpmPTPeaQy+bWJ9qTWXaCUahYT/ZewXekDiZkhCaoxajPLMffZkKah9wYB
         tnZt3uRcznO2RbdOR43Gofd+JogwDW0QXHR8TXZhv4oqz/4EKy9DNedmzOApOjXulska
         BFZjde2Zy46ZGlfU4Sjbfm+RkpaAJjnPfq7cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985744; x=1754590544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4A4McOc7Yjfkn3jJT361607pPpeEy5Y04HOcqe8Ja8M=;
        b=bGfjujLLKJB0czTXMuVCx1dLQmBm95m4wEATg3Lpcb6spRw6lgOWw1hwCehB4zLYDz
         JBoZsOPQIxhYg7KIFPrlgQ1KenkwCMLe9/xj/fhO8KmZ9r5Hub0GM/z/PEUcF99Vgxpy
         hrnkPvIZtFlFhYc6w3AbjPtB+ydoejKgLE5aSN7HjlGtUteFaNotGzA35HFiQ4j/OSS9
         LCuk0bBzTW5bkyAUvdJvWXg+Uc0w9brogI4tfq24CKak2gWBccZdkvoXU66r0wXq4Ief
         qpJa6AZO2SuLFwL+y0w2Y9HAQq0CdwniCyrbGU2YCMyIpBVNTBOX+N6vDBMgBGeDY4Gw
         h78w==
X-Forwarded-Encrypted: i=1; AJvYcCWIvi69zFBqQrWky6hhM+jqvOtER2M2bWfnDz6mlVnqbfBiLBtrVxItZ4rIfjGJwwcG1sFMJEGXxQDifFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRJ85CDlYF1NlJ6uyuSbk+KKfLKOV0ek8YBpi6psGBE6eQaKu
	ezMc6DT6taeuD1m3FL7fy9PQmBl9M9DcvcuoYg5me/qLUDwm1PKKWEGH0kbwGkP6VCe5lK1GyRs
	oxbhrE6E=
X-Gm-Gg: ASbGncsMWLpFXXtxiDKZtK0FsKFRLl9eG9yZCSiKdq0XGxDA34AHnVFD/Nnz4NtGKgZ
	VfidhzHWRVTXEb3IX2nl1ByQIjZDMZK4SWgqfD5iXYZkK7nRq5u/4Y9whRhiQZrmQM2sAq+frz/
	mWUDBcHTOrDlnow/N+0tgy30gwlXBS57h5P7A5maqUjdR+MFlW7AeghXMPyyb/m0q0Nb7kMpQYX
	LE/Y+SfYlelwEjHZvIaNCI3vgRTOE0HE8JfiMFcm87QU+hTsXcUe/LLf9n/JYFiTThPJQx5XAfR
	cJ49AQXXsjVtf7vjp4AUtG8mszlpB3BFDgEQEqw6UmJzPtw9tsRRJrK6T8AnFORWplKYiGnqRPu
	V/9zvBONejPUSmXwLq4e2WnGdF6Jmq/bXhDMDR2mYxJYfPKkf6i8zxSnoCv7P7KXHYGm1Vmun
X-Google-Smtp-Source: AGHT+IHR2Mm4BDDQWWKtwPCifgv1Hu6UQ31v/7ueCQgXzsmwWM+iqJPy7QTSbOBYe1sgL5weax8i+g==
X-Received: by 2002:a17:907:1b25:b0:ae3:ee3a:56ee with SMTP id a640c23a62f3a-af91bbee6f3mr370988266b.3.1753985744422;
        Thu, 31 Jul 2025 11:15:44 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076620sm147581166b.10.2025.07.31.11.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:15:43 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so2711039a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:15:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk46YIQNMr4TwXJDnMoM8Iu/sLIwru6cm8uZndyv62W0mKIY2oAwb+jCop2No16hgUGCoCvsOef8gJnyM=@vger.kernel.org
X-Received: by 2002:a05:6402:5d88:b0:615:1ffe:7e13 with SMTP id
 4fb4d7f45d1cf-615aea0c1ccmr2078927a12.16.1753985743135; Thu, 31 Jul 2025
 11:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIomWdeNOQwaKPu1@alpha.franken.de>
In-Reply-To: <aIomWdeNOQwaKPu1@alpha.franken.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 Jul 2025 11:15:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+kN-LsKbi_ZA1_+LTA4ts=0C+5Xn5SrLBAoE_BKKy-w@mail.gmail.com>
X-Gm-Features: Ac12FXyk30C4KbT-WTBlFqKvTkl0PXJuo-r5p6aknRzi38U7KD1MQ9xkTaCkqgA
Message-ID: <CAHk-=wh+kN-LsKbi_ZA1_+LTA4ts=0C+5Xn5SrLBAoE_BKKy-w@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes for v6.17
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 07:04, Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> DT updates for ralink, mobileye and ralink

Quoting Blazing Saddles:
  "You said ralink twice"
  "I like ralink"

But judging from the diffstat I suspect you meant qualcomm the second time.

           Linus

