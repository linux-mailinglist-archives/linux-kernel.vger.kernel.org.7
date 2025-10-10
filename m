Return-Path: <linux-kernel+bounces-848500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6DBBCDE13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB601886DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F22609D9;
	Fri, 10 Oct 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AOuRFJMH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EC261B8C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111494; cv=none; b=IlZHVVdSKhAbMs79J8RFaA1wPn70xXxe+eHnX6JnIgu71035Mar4DdlHxGG7pvsnmc/eMh2tRKHyiJQ96q1WRh2r5zZVaq4hxOKSNEjq6Wx8yS7vGnGscy4VxdbQ3t7CRH7a/Hm03m9EYhhAwYJWZYbfmHhTNHgrxTf0lf/b7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111494; c=relaxed/simple;
	bh=XDEDQFIBQ5A8m0eHH6XygH67a3FLRj7kfzfNZO/Y+ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luhAGutpJLXwDCg/peeaUiYK+PiwuqVdWUKVvN1xdNIQ/VKAMzfZmbLKXXx+vSRJB+GaJTt1o2782YfAJMxRieARm6GfYQrPttEp6xoFjYpWN3GncMP6CjWLxPyYO0q0jkI8gJYGZs81BRAeUwtHnOfwbtdr2VwzucVXJ+8QNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AOuRFJMH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3769362a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760111490; x=1760716290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMHZynW42pdW0SGBO2CIy8IPA/iqePnhTXX2tj/DjpU=;
        b=AOuRFJMHU6iWvOEDTDSTlrtkIUnbwcS6UimhicjdEJz+O6PQ2P4IbASJv0Sl33HqSa
         8m1T0xEoBYIqDBOIwmUcioll3DspmXtS5xo/ecQ236WNqSuqDL3Z3hTEKBTymZpvdDQy
         UZNolJLkHVoUl5n5tI9onDA+5VIv1uTiF8T50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111490; x=1760716290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMHZynW42pdW0SGBO2CIy8IPA/iqePnhTXX2tj/DjpU=;
        b=mvFksg+CCrfNOqQ9j1yxsGzHplPenvUMXUQHbWRgpieP45pebkdWhAdVfcpqsQyKKq
         X5upX8B1ECJLdesMOy3QifZQQpOoQWDvcbchCcImIK9rBPKPSTpe23KigcK1G/XrnuNF
         hWkQS2dFkUgg9sI7xnVctgzUR3kQY7/c5v1ee1K4oZnD1momu91fom2mPhKKmWnK5KPp
         8KMJQjMqLF+6Ys8QDhBEkNu92Jfoat8hrwIbfqiGF79uXdUef7k7UqQMBfMj2D4Jf0L3
         0xOr0HDxkcVMLKxRxkk3UEH24HUsQm4Fe7LTM0F2OdFXt2mJPFzCGR0pFNTCp97NX9iV
         lA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2QznV5RDpQbWtze0VGKOgMJFs1jTKBY1KejgHTvF2gq9/hJcfQ7tQWrA922r6ipygq33SJnQ9N3UbEAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXDy1uCLQZZQAxmAnkavYTHYtYgR1JmTVqgMB9JDsi7DRAxDi
	0pccY654sS950KQQIRnDGEEPQVnbO0OCghlztMbrNkuTWh5KFeub2GgFdXtKUCg7XHAx/cqkRnL
	BcPBKTv0=
X-Gm-Gg: ASbGncvNqelWEfWsVxpe2Yg7DUoO0ljq2j5DY5x6D7dPlHOVI6XO4eq1q32LpVx2VUZ
	qqxgqn4znW/C76Oq8dTsPcHdPE8cjmh1E+No64EYIaZNO/nbBF7wOt/bimJnURS8N4ILEwmWoIu
	7f1SapHQ9M2v89MYZGEvyxepbWLhu7v2x46GwUriYccdozIVZn+rMUGz5Nv+gwuYPO2OayupYLn
	I391KxnBd0SKjrASMAhbZlfsn7XQt347O1WugUN4mcMgs3elGbIPgat6fOfme83NwSVfkDJ/PXE
	2zqCBAv7KAeo0QW0/FGRFiHpKSBeBjXPMiJxeIpOGdNSpF3uwsAMdun8UBJ9605Y2fgf1YpxqPr
	/udWrQ6Bo7Ig8awWhFFtD7dtyGpG+Uqghz+PYveZAxtMavshRFGtWp3FhXC2QnSfuiIM2ChC8Wc
	ZtpX2+z1rHwun9S5Re5V71NlmoNg==
X-Google-Smtp-Source: AGHT+IHLaslcAYNJ0QNe/GQbHEJ/a3zY+FcQlfGyJG4XodmbG5absTHA7UQCrRjn/ynuXLoz8zwbHA==
X-Received: by 2002:a05:6402:358c:b0:639:e050:6794 with SMTP id 4fb4d7f45d1cf-639e0506bd2mr8588032a12.11.1760111490323;
        Fri, 10 Oct 2025 08:51:30 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e674sm2542916a12.2.2025.10.10.08.51.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:51:27 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3243861a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:51:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/4pue7DHO1pbE0+6XxWDsgOs7pzijM/2qMpBgB8W8bcqUrsjTxXbqawxf5ro5L3GQs8sd48soTfo9bX8=@vger.kernel.org
X-Received: by 2002:a05:6402:42c3:b0:639:e7f1:92ef with SMTP id
 4fb4d7f45d1cf-639e7f195dbmr9233647a12.19.1760111486075; Fri, 10 Oct 2025
 08:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOibAOKu_lEsSlC8@kernel.org>
In-Reply-To: <aOibAOKu_lEsSlC8@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Oct 2025 08:51:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>
X-Gm-Features: AS18NWDVmzykydf7s6nuNWo79bD8III-oyk_dOxNA4c_F8d-omvq9FosXPkL62U
Message-ID: <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 22:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2

So I've pulled this, but I'm still unhappy about the explanation.

You tried to explain a one-line single-character change in that pull
request, and even in that explanation you spent most effort on
dismissing other peoples concerns.

That one-liner would have been - and is - sufficiently explained by
"it performs badly and breaks some configurations". There's absolutely
no reason to then go on to describe how *you* don't care about those
configurations.

But lookie here:

 8 files changed, 137 insertions(+), 199 deletions(-)

that's the actual meat of the pull request, and it gets not a peep of
commentary.

I'd also like to point out that Microsoft spent *years* trying to do
the "we require certain typical TPM setups", and people complained
about their idiocy.

For all I know, they still push that crap.

I would certainly are *NOT* that stupid, and we are not going down that path.

So when it comes to TPM, the rule is not "typical cases work".

The rule is "if it causes problems, we acknowledge them and we avoid them".

Thus the whole "disable TCG_TPM2_HMAC" really doesn't merit this kind
of long explanation.

In contrast, the *other* changes are probably much more interesting than that.

             Linus

