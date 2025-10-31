Return-Path: <linux-kernel+bounces-880973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540ADC27165
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A276A1B22FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58146329E4B;
	Fri, 31 Oct 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X7pqFnRs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C900303A06
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947938; cv=none; b=du4qgXKnc+TJFnkqlUD6cW3kGGpZweisZnt8xUURjSEIWyzfuD1cRUoLa+DDmEhMPrWlClxesBBU1X3ZziryMh638HJtAHh6905LnFdt4kOTyRSTq65wdB33HyTcilXlYGHGs+6gsOhL51rJvoKCujwLdw5jonTUpLkn26RPTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947938; c=relaxed/simple;
	bh=MrIr9m7facwOchOgvWXnS1arJ0wDMQyd5DXZCVN7ie0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DAgxZ55QxkkZqXyw4kzLYTLj3hLEQ+28MipMnS55HTEoQn1B/D1x96QtY7i5NOGZGD2iTBNGVqppP0BjAfFTjunjUdwZjqWlx1/j+A5mdk9N6ZiOR21sytOLIsIylJowiiHIMguoyIsCSthRoJz7rqNIDxnIa65HbQkQn+JNATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X7pqFnRs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso583103766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761947934; x=1762552734; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xE6WipI2wT7zx49o6znOjJfBT3HaeWb9dkgAF7wb63Y=;
        b=X7pqFnRsseaHCAT2juQrgHbwicBRqAyxT7l/hq6qqwW+amnmvqTO5qonn3eDsqJmDM
         czBYt260YpcA3txh8IxI9fXqhvGesXAo+RYwOlo9Wt0sSup9lIgM71hMjJ11ORk0k3h9
         Erg3fPU221dx/drV0tGscal6w4jbWzCm1eMPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947934; x=1762552734;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE6WipI2wT7zx49o6znOjJfBT3HaeWb9dkgAF7wb63Y=;
        b=PFKe6aYycfdJkWrPfQvywBlhItMwJyMVhoeRbo1mLmPe3yUYNCS/pqv+nplNO/7LOk
         zeqcLJP0dkHmzsRRjMXE+WDK9cXlUOEACl35hiFLTn8+p8XVuA15WSdlEAv6s8nOI3bM
         D4rtxw+aDohBPCZOaJCWISPPc6nnhfinxwuk2F6TUsdnsP+FsfoMZtl+VItYXL/uJm+3
         B+V2yrn0QTc4JlDtkqO0DV/O0K8x60XDgFXuLoKKQ+Zm0DIsJTvQhV4qOXxDoab7QaJy
         3URmsXJLH0GOrh7yXqS7sJD8CnHfSxeQQC1OIvILiUuG9wxqGNUqimTtK5S0dhJBy2SY
         w7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUer2JsZTO7Iy58X+bx5EDIRLDJ50pffXYI/2O310ocdTml4+LerF360aO3xiRJv9sprxlUeReNTEXjjG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgsVNNfAVcssmehKx5dFjkrY8z7cFsV5Ve2CX/PK1SXvcdkisc
	f28yPGyquBZmajh/j4/gADp8r8usur5UX8JCi97EUjPVf7YmTiN/vHED86PHE6kq7xilw19gZVn
	v793QtgQ=
X-Gm-Gg: ASbGnctM8ijANwhlW6vE6nOMIJlU704bzQXXG1j+1Z7/b+8LX7y+vNaHJZSaeGkcxjz
	+v47hBLt0In9h6/AV8XrKNsfIHqF2FlnBI725BK7l0+2UTYxyK63A2pWT1RGy07n/TpZ5QWfvZM
	AjWUPB919cJ+GKWK7tqLQWUMp3gRSmUEb0J9Kyr3Yg8qQGcLncPsO214j9AKG0cucO5JlX6/ym7
	149Cyfq1r1NxwaeBgx57b41Wq2OhZzPPXgOR9F5J5ygXsVDhOWLCtdgT6NSvbkTLK5VsE2XQ7RB
	wprP/x0UMTWVT6z0+4CWAUXqioi/SG6xarnDcxwZG2TChRqkagAlKccb9Ge5qUy3I98ByRi0NHy
	BdRtUDRSkjkZWz9ABbNcUQ2iyM5K7xosgxH3u1weGH6WKrJClWto+GLXtmPpryH61ua2Cnt+/T3
	5OnhHZaHYtV/fhAQh86hr3wRw5TBUXsZ97Ne8hyMWlc3eKlzC5uGsDDE00TYXynw4Xof9aKJA=
X-Google-Smtp-Source: AGHT+IFgsCk3gVwLSqIULtDHkc8FlDPkjkZLoBwaiJDd/ZgUNnyRdVNC4hg3MdWrYWZ0M2Pghislfg==
X-Received: by 2002:a17:907:3f83:b0:b6f:9db1:f831 with SMTP id a640c23a62f3a-b707018c392mr588830466b.23.1761947934139;
        Fri, 31 Oct 2025 14:58:54 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cc4116sm273906366b.58.2025.10.31.14.58.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 14:58:53 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso4764381a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHnUcfKP0cujYwDtIiKarWBflPCfAprFjRlVjCbegX6wkIVsesoiwxjBxArBIYd+dkCKI01/VnMbQRwU8=@vger.kernel.org
X-Received: by 2002:a05:6402:1e88:b0:63b:f519:9120 with SMTP id
 4fb4d7f45d1cf-64077024c5cmr3754034a12.31.1761947933255; Fri, 31 Oct 2025
 14:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
In-Reply-To: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 14:58:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfWAWx1a-yah=bKmoXOHTd8-c-Eof59UDL-06y7HYJhw@mail.gmail.com>
X-Gm-Features: AWmQ_bkeSiG8JqK7TRwYqdO1Xz99HmCSHnOeaGkt4Jid8d46UFS-6QvLLvxuBDA
Message-ID: <CAHk-=wgfWAWx1a-yah=bKmoXOHTd8-c-Eof59UDL-06y7HYJhw@mail.gmail.com>
Subject: Re: [PULL] drm-fixes for 6.18-rc4
To: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 14:41, Simona Vetter <simona.vetter@ffwll.ch> wrote:
>
> And yes, the tag is a bit wrong, I was asleep (or well more correctly,
> processing some 6.19 -next PRs while this one one was simmering and gotten
> confused).

I was all confused about this comment because I had already edited out
the "for 6.19-rc4" part of the message on auto-pilot when I was going
through the email and was looking for the error and wondering "what is
Simona talking about?"

I had to go back and look at the original tag contents to go "Oh, _that_".

Which shows that I really only start paying attention to version
information during the later part of the release cycle, when pull
requests might be for the next merge window.

During rc3 I just assume it's fixes for the current release and would
only react if the diffstat or the explanations said something else...

                   Linus

