Return-Path: <linux-kernel+bounces-751574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B006B16B07
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F167620722
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1B1B423D;
	Thu, 31 Jul 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NWf01cAU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63842A921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934590; cv=none; b=mrELlB2lPxVpc9t2MjKej9iSxQ622RidBtDE4Am+qr3oTaN8rp7LrX70m4N9cp2CzK8ihBsSBuI7H0241gJ8KmpoBzs9itIhy64m4q5dR6V7rwec9ABUIX02+VhzsqgnWq05qGvJSWaS56l8wjAz1sglWP/HKTOMxd3VTOf/RNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934590; c=relaxed/simple;
	bh=M/EE5uU5Op+ft0jRHmSbNSQvLl0Fd0KNGVlRPVC0Sys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmvj7doi3uNSJqm5NsQvBQt+ycRCoY0yGhTptd5ng8PkDg/Ps+c+3amlBCh42LEgQ6Rs76C06rqsFjhRWVh83wqxJd447LA5EwMPMNTFf5zh7fbuOBmpj2j5hTWPD85YLC4/JfMIrlhl+Pam6EpuU0THAAeyCeQ0cac2R8EXUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NWf01cAU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af0dc229478so75257566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753934586; x=1754539386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPKXqdiNRfz9wDSlkjOv4OtDzi/lKSKsZRfJnPqPQXA=;
        b=NWf01cAUMB9HY9/sO9/cEN1A6ZGp28/EiS8rKPK9J83gz/SuK7sw5Zv3WqX4+s3uaB
         FayN2CbKW1O2LyeyurdFvzzn6gBQfPcg1d8stJQfQVdopIZeJ6Pux9WKh84NtbWbNUu5
         d9kqHBuS3GxxY6QSuPT3bxMZRtnNQzq9PQMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753934586; x=1754539386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPKXqdiNRfz9wDSlkjOv4OtDzi/lKSKsZRfJnPqPQXA=;
        b=joh8r7l7S22Wds+mewFgYkdKmwgsd/eDI6tiS1dleCzO3xkYfuGKDxyXdcWBdjOHhD
         5webuQCmxAJTVCAcr1cmYzuPZs8zTxO05VzX7TTVBXfKX52CcshJwBIOwaB57CnjLQqx
         5eqowghKy8usyJEDf3HW3D0sQQdA/edosi7VCO/eYyBjayVFvanYDrxbzumjDskjXA/m
         7v2zEvtObFbUPIjveZtrpRghsp/3ORUykVBK7EyCyuE6fH2KIjWstI6JoXpqAMRDRfS8
         XgXZeVVx+fe3zzyT8gR+L2b2q9iWZ7pF/amjDFnizwLs/5jMNlv6xZt8GaPTcNJE28bb
         EAIw==
X-Forwarded-Encrypted: i=1; AJvYcCWHVwGqFn6QF5UZztbbIHaLPBxgw3YOv0K6eQDAJIh/OWrVBKRCYhTtE+qVchxZom13krhizsneMEV6Uvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvU2ghFn51muDwTuwg9TbpJckx68yPPHvaNpAqO6iXTV7qdmj
	VslJtBsrlnB+1BWazwShij119rVSXSOmInL22+w/7GmBzglPvc59prRI+ai7bqLpjdlRcHOzZ5s
	NQEcoNeI=
X-Gm-Gg: ASbGnctK/Z/X34Ya4aiqpLT2NohJ2ZOgsD9O10tsyfl5QoyjjriQdHHm3wJXXqBQCnd
	y9G1+2IFkd/5v8WbZDlwPrgiKPc2UfoiGhN+NaPBJusPSBWFId8hC6PvVVW4ab6j8dUb5yQDI0w
	k2iEg8uZn0k56+jzxhUV5+dHgDMJco5+uVvzdOaWVwOf7vHcUlItawfKeJA5FPtLebzi4t9H2VU
	pubzJgtNcFNBVt7JtAI4Kk1xLceCAiMrTi9lIgu2nhW+39Q87NlmCwYCnjDqkHOv4eZZZdpXYsJ
	YSnI8PZqSlpIDYqtHRF159RsJVnna93tzD+bDrz8mLiNNPFadh6hh/U2YmW4XAJL8rb4i3w0N/a
	4pY4ABcMRhN/YpkChIlzDfKri1SiQ/8Vi/e6dHK60jHHpUbdWkTl42l3M4JLrT+hFR9VwUlUf
X-Google-Smtp-Source: AGHT+IGn8naHnYGO64eXYf1bVlmewl/S5ZgH+alW5XbHbL9KowRO5nopMHi9xcbmQK2dhgIp1S5ylQ==
X-Received: by 2002:a17:907:2dab:b0:ae3:c780:b883 with SMTP id a640c23a62f3a-af8fda4d92fmr738316166b.54.1753934586531;
        Wed, 30 Jul 2025 21:03:06 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766absm42724966b.14.2025.07.30.21.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:03:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so445143a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6vq3XMGRaU42isE1dmaLIg7GbLgXwDyRH9XdjOjNcIcGXT8RInR8OyQscftznmhdH0yVCQb59HGXmaNQ=@vger.kernel.org
X-Received: by 2002:a05:6402:358c:b0:615:adc4:1e66 with SMTP id
 4fb4d7f45d1cf-615adc425aamr743956a12.25.1753934585514; Wed, 30 Jul 2025
 21:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com> <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
In-Reply-To: <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 21:02:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
X-Gm-Features: Ac12FXwzEYQPZO5k4XVAeWdA0YWy0Y0i-TF-7I5eTKnrgbe7iqaulBg1IFiRC2I
Message-ID: <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm very unhappy with the end result, because it just results in a
> black screen at boot for me. No signal.

It's not something in the merge, and it's not something in my tree - I
see the same plain "just a black screen" if I try that commit
711fa2667d8b that is the top of your tree that I pulled.

I've started bisecting to at least narrow it down a bit.

              Linus

