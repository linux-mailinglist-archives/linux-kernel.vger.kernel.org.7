Return-Path: <linux-kernel+bounces-755773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3EB1AB9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D845E189AAA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3B2264B8;
	Mon,  4 Aug 2025 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TB/rAXQJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAD231A30
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754351733; cv=none; b=k+6Mf+0CMS5CWkdX9cFpbCJ4Im0w9I+8XeJYTGcVos2eIdpJXolzRC0eOhD1HrngFCfLwQKca2GM+Le/i7HYqoNFPW7kZUMS71L/yhSWSJoTi908aHcJlkdfPHW9tuRJRp0O+qW2QlVSzxv7e5a8FYxQ403jZkS8VcTIGUMb08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754351733; c=relaxed/simple;
	bh=LJa4/RLFYqhpHz6skUkYByaddwTg6kkzYxMQ4jNpMpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P79/XWZRBk5mC9YWcgYfqc6dkBKkfzVcep90g5HkmATOWA2L9vwGAUIHcyZBE9j05UHoABmaakzqXjgGswscW962MapLWHx3sJllw10nhiXWcWnf/Z6p/hWvMZu+M8S4KdaaXYlzZhg9X7MV6zfCvororohQYfts42clrr7Qx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TB/rAXQJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso8620691a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754351728; x=1754956528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkOJrgR6AtCFvZcGKn8m61aTsvNmBN6yQcZ7tCaSTKE=;
        b=TB/rAXQJy59qkEgkuUpNiIpUnUBwY/1GOb0+UC5iLH60AXFrhcxjtpvbCvVeYVOxdC
         qs3+/EEXw5Ug4R6Ly4JwgjObS4+wZ4IIMbWsaNwHl3reGH2Zqzf/A8FNDU1IB1B1SwwH
         pm0qaSHmgsZ4ibG915SKUXXzdIhtIPXB+kFUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754351728; x=1754956528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkOJrgR6AtCFvZcGKn8m61aTsvNmBN6yQcZ7tCaSTKE=;
        b=HooC7ah2veoR4yMpY2qwl5VVNf3wMP7ul8DqRGDZ4Nm/OHlla7gqwrmmG48IDjGbX0
         RCz5h7XVo0QdMhwfcj+7KUCj6PLuCmWYTerl1eBIFPcm57DwM7g39+U/ql0TwcygMtlL
         EKPGg+uKJtt9oFsLuBo5VWleUoD7ITqmU5sW+/WEiTHN7bS6fV93pfNakXC7egZxNP1U
         dVT4QOmHScAl3h/JSuwtxW7wao0IIgHl5lwjQiNfSkNfnaX7LXvVN+9Eh//vF9uot004
         Z2mxafJnFi0u/+OqEIxkabq8BkDNK1mJeaA89bsO24lW0ivE+A6OOplzf/C6hf1tdYQH
         N0LA==
X-Forwarded-Encrypted: i=1; AJvYcCWINYlC9TwAySujHsMisTGwPiHJqMX5/yqjS7tNtof/ez9jOH27vSCr0ZqQ8/8HP4dTKOwfEtyu28qSqjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12st37uai27X6x2VFW3v176tSL/gcc6KxZVKYWCBFote85eVq
	hnqjDLZyuJoX5YmEuTBPkvqh+/rgWd/FEUj7XJySrIw+/2MUWsw3FgiiHtfUU76RP1tZBJAcMG1
	S1rrVsRE=
X-Gm-Gg: ASbGncssMGDROK6JC6kxQAkEl2gUMSIMGZxbM6hP8wlZayv0n6lrxwNxvByBnjZ1Ce/
	7bGE+y6jKeRBIEjj476yF8zlNsrE3Aa2t73RZrMxmLfrFthxppBHJnUJakfBITG7k9ARearPzZL
	t69D/lFrXcF5Bxu7X4AxfKS6MWHv8fTEAvtHVbv7pm3qr9KShmwNaHrzKZnS2tKOyEdOXmMchft
	suq2OJ0Pq6RS/r1a1SMJyGBEdJ8Kf9/dsl4ijV1ckDJdmCKfaYkIjl3WE0VWV/peLVRKXYx076p
	GU/fU2dguizmtkxIUX3WbLbCA+wU+A16nP3zu+5N8OELKoO0sWEnLGpSZJUbhVn7C596cV1C2CD
	uQIV1lvhNXjFkNKeJl2MChCfaP5JDCClxX0eNGHRHRb0GIPrJrsyx0vnEoV+CxqYDh045ehCV
X-Google-Smtp-Source: AGHT+IHQO80hdYu2swmVXw5Ld+VKU6GLNe6TVF6nhVMfQMixRVgoa9XIxmGXlSQrPLgtQyA/2kYpgg==
X-Received: by 2002:a05:6402:2808:b0:615:e8f0:7035 with SMTP id 4fb4d7f45d1cf-615e8f08924mr10385004a12.30.1754351728087;
        Mon, 04 Aug 2025 16:55:28 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm7310511a12.62.2025.08.04.16.55.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 16:55:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so6672419a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:55:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEF3cljXsfYoSl10dy1kb8zLjBdAClLs/N25CItrsBacBnY6/GQy1UwLW8Ml/nOXJdhA0fNG1+9Jvrfn0=@vger.kernel.org
X-Received: by 2002:a17:906:478c:b0:ae9:876a:4f14 with SMTP id
 a640c23a62f3a-af94024cab6mr1073910366b.59.1754351726564; Mon, 04 Aug 2025
 16:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
In-Reply-To: <20250804162201.66d196ad.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Aug 2025 16:55:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
X-Gm-Features: Ac12FXzNsiXa1g4lLLdotjXwBYpgPqvnDpdKKoggRbJ3KlfhT-2HsnqsEpBMoL8
Message-ID: <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:22, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> Li Zhe (6):
>       mm: introduce num_pages_contiguous()

WHY?

There is exactly *ONE* user, why the heck do we introduce this
completely pointless "helper" function, and put it in a core header
file like it was worth it?

And it's not like that code is some kind of work of art that we want
to expose everybody to *anyway*. It's written in a particularly stupid
way that means that it's *way* more expensive than it needs to be.

And then it's made "inline" despite the code generation being
horrible, which makes it all entirely pointless.

Yes, I'm grumpy. This pull request came in late, I'm already
traveling, and then I look at it and it just makes me *angry* at how
bad that code is, and how annoying it is.

My builds are already slower than usual because they happen on my
laptop while traveling, I do *not* need to see this kind of absolutely
disgusting code that does stupid things that make the build even
slower.

So I refuse to pull this kind of crap.

If you insist on making my build slower and exposing these kinds of
helper functions, they had better be *good* helper functions.

Hint: absolutely nobody cares about "the pages crossed a sparsemem
border. If your driver cares about the number of contiguous pages, it
might as well say "yeah, they are contiguous, but they are in
different sparsemem chunks, so we'll break here too".

And at that point all you care about is 'struct page' being
contiguous, instead of doing that disgusting 'nth_page'.

And then - since there is only *one* single user - you don't put it in
the most central header file that EVERYBODY ELSE cares about.

And you absolutely don't do it if it generates garbage code for no good reason!

            Linus

