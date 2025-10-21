Return-Path: <linux-kernel+bounces-863303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D933CBF7828
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90F1403761
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85129339B5C;
	Tue, 21 Oct 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euiQK8r0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7D1DE8A4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061841; cv=none; b=CQFEk0ZsVBx7NvK/p3VR0WjVpVHW9dmXy7QA2TDvS+g/LSKwbyvqZ3hpclu5YIbFViqIVLsO4yCu8BQxcZz5fXGt6Tm9Mdc9rVzfPjWGu4b/2wNRTpAJZAZtPH0vORlkMSbH9MrNcAb9syFfz0yIrNRspwg20BBSehNPC8ik8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061841; c=relaxed/simple;
	bh=w/7b/vcrnwDmzcCJFmEGmVXMR8uWlmKwT0l7hIVnP3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJp3+GB+AJnqE07W8rkUysF3AWS7vDWGeCBenvapqXG/AFZxgSyoZSS0VvPit6EGYGMnFJ450a3KOptA9BhYbCKsFarZ2eKNHeuvgy7KVmVUYfEzmuqmZbH+uh4dun7APORbo32Q3TEY7br8sQSBHH21gU4EWU52rRgE679UZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euiQK8r0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so7312162a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761061838; x=1761666638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSX4wv/8cP4pcdwROoiiFUZrKHWnfYkhVs1Qya+vg78=;
        b=euiQK8r0b0SXwtUX8uLQPtctlbovEFbHGeSzCpBtjO4D9MbwRCw+msic9v+JMQttAw
         VsVMu1DWnd6JDwUlME/RiRXoHdLu4+2cWLlB7SK3bg66XDXDsB3hXye9ONX7vh1FN9LO
         4Lx98npo9N5UBPYV9ERaiV6cxl1Knjg9pJ5VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061838; x=1761666638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSX4wv/8cP4pcdwROoiiFUZrKHWnfYkhVs1Qya+vg78=;
        b=L10FQ3aSpnIlYhNn+0VRJZxChRrFnCTXYzCd8HOOO6P9Ppk823jx47Zj/XW/XMusO3
         2o9A7nyAFaKWxyqvyb8A2UnBtxcJfdyWCdwRENDlZVsqT7Nadm7Zidof4S/UjXTnoMfC
         FZJH8gMBYXROGLuaFOC6Ktp2mfyA/kap7B6fulFuIm6Y81yf9o63UpqnOkr/kvHdk1i5
         uQFJAFnLNh1ldAWBqJCACw/k17kYTeze5lnYu6MhCv7BjIm9XSJiK5MDVlpe1bvTWDFg
         CHO64ovIZpBJFWLTz+F30LrpgzKFcUgi5TFntTGBdR9hr3XAetmoN+LoFppm9QqyuZLv
         FCcg==
X-Forwarded-Encrypted: i=1; AJvYcCU3meGwJ10sS3DBPw0LBJtEerN0iL7yvIXQjTDD8KxjWaNiN5wBA6Skxo5DjIjOfxpLT2qPUXOodyWti4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHQgAl4HbkWIJ9lLbAQnJaudmaFoFO0G4ycNNNpbctvdcMn6r
	TM5fn6LppST2iZYa9sUgDo6Bx0OYhsoTTyCCzEYuTyKcbPoF7g3Invv6RNf21QkE2+wxiJZTpkd
	tQjRnTDk/1w==
X-Gm-Gg: ASbGncvvlr4//A3SaM0AATW65oAPcTvyxd3SlEe6EElB6b4+j7bpfn6NgE7S8Uo9NwS
	udASR0O65il8wmt4awRl+iBXZ8ZOcy8TEZq5YILRT2T/TxirQuHmtMCKGFyi2PFRDvcFImycHah
	vrHYTczhlqupOG9HOTz3Pnvvsv9ZCvDCFThwE1NX632oiq3uP+0YyWxETTUf4OoMFYAtWq0WINQ
	tX7Dk6QOX0AZ3etXAuIeavJsNrqHVuUdIjdmkp/5BeiCKubiefFzU31AW6mJBKSRbpfgXLgmMDb
	yMAktcAgIPUKZi7WGi6LNnD4fXqEUkmuG60D/HeZxRAZR+2ZQwTevJxecH+s7oE+c2oWr2s0bX3
	wpnWlktg0EPMb9HqhT8lKr/RnJ2K+oE8Y6P68krMv3xq4jLyfU2J7NSd0+5tcFc+TH1DO5zWWwB
	InyhFAs1kVeCWP3x8EYSToiltKmt/v6jw34RGygibkrSJ/GDPl8BxMpvTbeQlG
X-Google-Smtp-Source: AGHT+IG8H2QCCgeXtJDEaIt76WNjqo8I7C+VF97khXhhwxu9sluk4EDERxHkHOs7eWBwuQHziDhREw==
X-Received: by 2002:a05:6402:1e8f:b0:636:9129:882f with SMTP id 4fb4d7f45d1cf-63c1f6e1e4dmr16415887a12.30.1761061837874;
        Tue, 21 Oct 2025 08:50:37 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48acf60dsm9599379a12.18.2025.10.21.08.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:50:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso10434317a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnM5I30IdNOI4CHDbPW+acTRk7L5Mi4t5p3PIlLSjZORlZEdegeKA5oMKOSJds4WpqIaeFbpnsQEOlprs=@vger.kernel.org
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id
 4fb4d7f45d1cf-63c4d429b92mr11883163a12.31.1761061836721; Tue, 21 Oct 2025
 08:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
In-Reply-To: <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:50:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wigaATtHqwU+KHRzf-t2jGmD=zT3tGnJVD+4MAk86tpNg@mail.gmail.com>
X-Gm-Features: AS18NWBOp9VJpCXyIKnJNta0lggyjzqPvsPMHPbiYL935bxgvLcEoC8FIS9Zxss
Message-ID: <CAHk-=wigaATtHqwU+KHRzf-t2jGmD=zT3tGnJVD+4MAk86tpNg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 01:33, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> On Sun, Oct 19, 2025 at 09:53:28PM -0700, Andrew Morton wrote:
> >
> > A use case for alloca() or equiv.  That would improve the average-case
> > stack depth but not the worst-case.
>
> __kstack_alloca()/__builtin_alloca() would work and it bypassed
> -Wframe-larger-than warning.
>
> But I don't see any real users.

Yes, and we've walked away from alloca() (and on-stack VLAs, which are
really exactly the same thing as far as a compiler is concerned),
because it makes static analysis much *MUCH* harder.

Let's not ever re-introduce dynamic stack use in the kernel.

                Linus

