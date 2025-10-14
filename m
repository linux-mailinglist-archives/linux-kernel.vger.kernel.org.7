Return-Path: <linux-kernel+bounces-852327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C122BD8B22
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CBA3AA616
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4392F5322;
	Tue, 14 Oct 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTLg9y4E"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7B2F5479
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436733; cv=none; b=bAr8lzzGnyio2wyuxvp0Kl1HFgb7NEcnjdiNIp07NHC6/ylY9Ib3bjtgcGgTgo7ACpDBVDLUd2kCDuHcwHAjLLyo/vh3754Hu1IfUjNjm7rPRc9k1aYyMNsDINRw08W0m13fhUCTCe4spNJW1TID6LiDbNArOHQzbEV1OPJuHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436733; c=relaxed/simple;
	bh=tDZJGyjyFwsEnGU/+BhSU4pXv/ZOaODbT4E16jUaFWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD6CNtBfSv9sYtmnCz+cia0yZRNSaf5mFRohWRaynCqnU7QAcdtAWUthWNK/N9d34afNlF7kZM/IYc2NJS6yDYSqrffqnjUW1fKGfyczvR//pOuzOgzFtzl7C1NXJG7zqSm4vLpFq1tlWFEe+zNACf14DxHlpV6nVPc7GgRXeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTLg9y4E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so36969025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760436729; x=1761041529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmcOUYE96CwkIuciWDdS0GQ43f2j/gyLBNOKfTnV8UA=;
        b=LTLg9y4EVZoqTgyp1AaPC9AqwrucU1M63waRZYt3HGKu2WtfChtCRhtH4uemKEypHI
         HnNynq4uI3hRdXxdJDFhYvotEZ1hNkN6AsmNLmZeb8YpXAsYs3k+D+mixG88kB/BK+UB
         IwzV7JqTS3vmSOJc6cYrnopyF9093sj6rG7FXryweAEJ88ua1PprSEFnFLDolL5cBv0e
         r0Oq8Rw8kGU6yB8oLavQ6pD+zcqlkNZJyrlOlTbrwlQOkurDD8fkSyjJa/ncXLWpvVnL
         l1qGVN5TAV+z5RA/MUAegQUG8f20DEgs86NZrDZzjyUb0fFT6bvIS3A9hdELUWpTnjvn
         1lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436729; x=1761041529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmcOUYE96CwkIuciWDdS0GQ43f2j/gyLBNOKfTnV8UA=;
        b=jHVOmpeq3GKtzQC/mBGS8C8Yk7e79OQHsD0lcNAwZNjNCQLFKJ2O9NhF5uqnwim4pm
         j7RZduGOI/exPrG5l/onSux/URTxB/gaGZ+NgTp7SwpmckC9C3VuhkXxW5j/Uns2/r15
         q2OIcmdd7jEe9jc6gfv0idzrI5gt22z4AttvXd1NhBKFf/yxnIOezoAI1jTXLbF+N38F
         o+kkEayYK4nD7wMDd1KVVCCOq7kuH2F4BtG6hxVElQ67MSFjH1+gh5MY7axtTncddRib
         F15QsGXWwyZARuPwGeXzjtNeP1tem5JOlZ9x4qDPHTPDYuEEMbfd7jQrnnX/cL1JZ5k9
         /f1w==
X-Forwarded-Encrypted: i=1; AJvYcCVodg2c0f39lUz0fHJCw6orcu7xALj/IXJfNT0EPNyA1bUJCg+/gGcGP41GPoPiDi7FiyqZwyi2olYQKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1MLOMHrwj4Pqvxib60pUnrhmnrlxSnh0JX/WMdQMvlJ2MdnR
	9OLCNIo5cV2XLEGH077gPaq6KUJT+jr/vYPRik215KP8pG706LwpI50k
X-Gm-Gg: ASbGncuERAQpIerA3xVOFUGXkvIvfp8l32WkK2LmL9F0NvSw6zJvHMpphPoVqrNJiDB
	EaJQGn6yGbMZoXEwjxEUoRPGRvCo1EZWcrHPZOzXxEyXW7myG5db/p16p1mqChIsS8s7HpnQdkf
	c8NIPcILJuJ3ZAekotIA7mJiCwWPOg7TtFWgIeoCxIPI5XmAe0pKRJ6mYRQBf1qR5kSmP4j5Y5g
	AVHIMvfHTSLscn5ms5/M8suHBjrHczwW4W0ySa8fh7cJliUe5CVo7T4zbTri1mTmKZv/bjwyq5W
	KEOYfJnxTAJZbYSa6NhJRp4Aj/3JsOdIQ64AWcXRV8BpWn3l0sHMV01qZIH38HmmH5o5JosDbbw
	6YDTQGgchnaSrkR6qrNnKVyOfJ4T5dpXhzNiECJnq1xqdOYHyTKds2yP9n9At59dfOCKUl/46SN
	sHAvKH8Xg=
X-Google-Smtp-Source: AGHT+IF6ne/xuQ/Yzz4Zzb7wpstPRXQSA86ePFiRmshMRn4gI9s18XitfechdzacRqFT+6sY8lXeJg==
X-Received: by 2002:a05:600c:3b1f:b0:46e:4340:adf7 with SMTP id 5b1f17b1804b1-46fa9a8b3c0mr176129525e9.8.1760436729180;
        Tue, 14 Oct 2025 03:12:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b30sm230224825e9.6.2025.10.14.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:12:08 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:11:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, Kent Overstreet
 <kent.overstreet@linux.dev>, amaindex@outlook.com,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com,
 joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com,
 mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, Finn Thain
 <fthain@linux-m68k.org>, senozhatsky@chromium.org, tfiga@chromium.org,
 will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-ID: <20251014111125.731ab016@pumpkin>
In-Reply-To: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	<CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
	<inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
	<20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
	<b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
	<56784853-b653-4587-b850-b03359306366@linux.dev>
	<693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
	<23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
	<2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
	<ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
	<3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
	<ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
	<3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev>
	<20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
	<CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 09:11:06 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andrew,
> 
> On Thu, 9 Oct 2025 at 06:04, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 9 Oct 2025 10:01:18 +0800 Lance Yang <lance.yang@linux.dev> wrote:  
> > > I think we fundamentally disagree on whether this fix for known
> > > false-positive warnings is needed for -stable.  
> >
> > Having the kernel send scary warnings to our users is really bad
> > behavior.  And if we don't fix it, people will keep reporting it.  
> 
> As the issue is present in v6.16 and v6.17, I think that warrants -stable.
> 
> > And removing a WARN_ON is a perfectly good way of fixing it.  The
> > kernel has 19,000 WARNs, probably seven of which are useful :(  
> 
> Right. And there is panic_on_warn...

Which, like panic_on_oops, panics before syslogd has a chance to write
the error message to /var/log/kernel.
Both are set in some environments.

Tracking down those crashes is a right PITA.

	David

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


