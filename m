Return-Path: <linux-kernel+bounces-761164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17074B1F52A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AB317DD82
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43072BD5AB;
	Sat,  9 Aug 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ut3p+IOu"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D22367BA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752753; cv=none; b=ih8cc5Ng0ldKEcEWnoJkXmv1o0LRYqbY00DkT1yZnHSCeMomYyFV7+xUWzSwlAo7v4tHrBKLL8NDd6GXqIPKlpghDrJOkju/ecUqGP5ywVdYwWxpNBLw3wQP5cr1M5AfgC3FKMRNNclRiut9zeLgkV9c1JMsSy4w/HVXqIw4P1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752753; c=relaxed/simple;
	bh=jWrFp0VACy/jwUGdIKEGBtzaZtLOLb7m7M+U6jIER88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRkN8NqdxEDGJSb21AwUJTDgZD4Erxbtxi7VkG6TMeZ6bHy7Ab092Ka4apCNfcAfzdSHeAyGM8CcDoArC0/sVPHr+pxK6NLHTUxbzT7hUReiJgVsYIfK8z/gBLGRLvBA6ArrVFlRiy3KdbMEaXP2D647xY29DHPrwGz17XKwOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ut3p+IOu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so4831343a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754752749; x=1755357549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ13LHBQOzt+n2A3OJyCYhNSYL6AioGfdBRApCEKEJc=;
        b=Ut3p+IOurdANvj9uFBAebUOlJJh0W8UqLbbMsE7kjDaXFnxepn/3MbcWpqMC/g7Nxg
         frZnz68kHwaaoJhMA8v4P8QZCyCK33L5RbCIlRPDTK0831RtUFvQLqJUwfAbVDtoVGJm
         +P9niu/TIi8vdciYHPACc0J5Q2yHBC1mIXGRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752749; x=1755357549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ13LHBQOzt+n2A3OJyCYhNSYL6AioGfdBRApCEKEJc=;
        b=ErtVLpUpL+hmPbDNf97i9IW7GZpCM+nHSqgB7ufwPDAmlbxB2bl0Ruw9OX5nbiuZiU
         xZdCx4eP9QUJCblLpzXhKKpGEgakzVP3MeU5a7KrReCf4IgtmI76ZmKRoBdQweSyQcnx
         Ts+GP9VRN0tlldlrCKvSe/WmUa4ogA3kLJztwZI1BqNYtrbcEntbtLXPOgV3b5PM9O2k
         s7W5TO2d47Yk0A0zdKZZIBI0LIty4D+/ScRCJE9jagpG11JFQ2/+dSyZKYmsO+CJG6tM
         pH+rd0ArYWbkyCEUgvdC+zFUfyaRUaeBqMaLKcj9j8rFbTWPcjGBuHo6BqqNheYi1diy
         ulMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzMzVryMeNofPbtC4A/GOQoBL4I/YIedJ6noaVnYtgd3/WM5ZiWYfHrIfLQGqH6YPiGEdKyJ+znNRGjyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eWdkWanFGhhTyLzB9GdLLZF4gd0f+7w0xlCxoMLBu3VDe3y8
	/7XhR4Zr0nzjUHDphpH4MVqDFY0jOAA8Mnj3+RAzGisRxOYG9I0IE2LKW2iIfBNddIE561mXmkc
	vo37iwmySjQ==
X-Gm-Gg: ASbGnct2HyA0QfYjIeaDdk3OPQ0zPNr9/jiYQxbMPeM+WcRlWdaEa+uapFbh7Awjr1y
	W7+L4BO4a+lNisxs9EqlNdAMTWa4z8p8oFPVcue5PzFkG5Ra+C3jOGT4swU+5M9jP29xD91stDy
	gdktAKwMYT/p+Tr1tSPRq94BMdaPiNID1spDRsnz1GLp62z+mxtINM/x6EXVb1tQxAK0eMj2WIJ
	/2In1w4sMKHO43dQ6DydSy/DAhhu3mswkuaMCFH2KMVAAsxpnAPR4nRhPQ9wt92/MsOs+QuB2L/
	PJEgxJWBadIzmT09Yp8I0Ez0wA/edmhZftJSL0QEQdDvt4VbnyJVb5+PwaOb++gXcpWSDGMgXIc
	zXsG90HnrHQ+AlDZ3ohquvbsdrlcKCoT+Fhti57mNnPzkrEOumTlsuE/XnAEKeWoka3if5TLg
X-Google-Smtp-Source: AGHT+IELdUalm+NcKU7cWblHgWta+uHGDoLWDyZgxqOst/FvvEb88HL2uqRYzhQpe79F+fd4nSD3EA==
X-Received: by 2002:a05:6402:2114:b0:617:5c48:7fb5 with SMTP id 4fb4d7f45d1cf-617e2c4c75fmr5803178a12.17.1754752748814;
        Sat, 09 Aug 2025 08:19:08 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6176052d163sm9275221a12.48.2025.08.09.08.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 08:19:08 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-617d43a5fd3so3620860a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq2VqKN3+QgWxNdbX94WtKE5SMRNiNJHU7e8Wi56wgsxmjSAJa5nH9XgiXa1e3hsHXuXZfMgDclAhSksA=@vger.kernel.org
X-Received: by 2002:a05:6402:1804:b0:617:c692:ff7b with SMTP id
 4fb4d7f45d1cf-617e2b93381mr3865979a12.9.1754752746814; Sat, 09 Aug 2025
 08:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJdf0rAZ5x5klUhX@kroah.com> <2025080937-hardly-facial-cde0@gregkh>
In-Reply-To: <2025080937-hardly-facial-cde0@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Aug 2025 18:18:50 +0300
X-Gmail-Original-Message-ID: <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>
X-Gm-Features: Ac12FXzWqvgaaDvUXb7tbXt6pIGbNKB-lyRrYbBxBlDw3FaPalqV4PinmFQHYow
Message-ID: <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> And, as proof I shouldn't send pull requests a few mere hours after
> getting home from a week long vacation, I got the version number wrong
> here, it's 6.17-rc1, but the tag and the text all are correct, this
> affects your tree now.

It's not like I even look at the tag name, so I wouldn't have noticed
if you hadn't mentioned it.

My workflow checks the tag signing for validity, not some kind of
name. Some people just use random dates in the tag names, so the
numbers tend to be meaningless anyway.

So no worries. If the *contents* of the tag have issues, holler.

Or when sending pull requests for the *next* merge window early, then
the subject and tag names might matter, because they might be what
distinguishes a "this is a fix for this release" from "this is what I
want you to pull next week for the merge window".

But even for that case I say "might matter", because most of the time
I go by the contents of the pull request anyway (fixes pulls for the
last week of a release tend to look *completely* different from the
merge window pulls).

            Linus

