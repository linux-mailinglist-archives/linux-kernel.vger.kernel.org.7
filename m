Return-Path: <linux-kernel+bounces-728264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3274AB02598
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D707B0A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73371F03C9;
	Fri, 11 Jul 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XjtI82QI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E61DE2CC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264492; cv=none; b=URnfXcoL21mAMSJHFV5WaSwSpPOSDQrza52IlPP3C8+BAe7P9dM9jOW8Xv4ApO2EyRRVSjerA2zCgK9j6C7JNveQ+cLkO3OH2BqYOsj9C/tNgTbfhUtFJ50GJsDqSm1S36Yv/VfXyN8tADJjfvPl4uPbZ4uMjaItXvLU5jOGK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264492; c=relaxed/simple;
	bh=s/f/z31jtKFrsm8Df9/DtKEOKiK/hSRygdBu/ovSdkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUTRSdRYKbEFFpYvzFwOP+77rl2bTkbczkI8AoQ2fgNe2oMZpnkcrVASGmA9+9MHXaJoKeNjuRmTlxhZWDfSa/uxffnTv7RQ9qnkIMF84xvUPo5YOz8Uuyu37DFT3yxMtIfMNnET1dZtoZVy7G6Vkx1Z211AXSyyYjva4N2brDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XjtI82QI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0dad3a179so408156966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752264488; x=1752869288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3PEIy8sr1TZluoxMMwYFZHAXfdHvp21bOGwTcdKyt5g=;
        b=XjtI82QIGJIhLNDk3Ox7o9LvjVezmZy01p6rGsgyVfm6hHFwIuC4+E9JVrOMdAISk0
         bACdrbmDD0pSoxgBLwEr/1WzpmRLmmQxEQSTVf6jxXeyZi906lc3GZua5ZQcb746P1bF
         keuEa5OAU0pCJ8exqMJPdJW/Gl10FU4oX1U9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264488; x=1752869288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PEIy8sr1TZluoxMMwYFZHAXfdHvp21bOGwTcdKyt5g=;
        b=gTUa8zym5orEvRF5pk+fakYHS1uA3HIT5wG8PPl/awiePVIM+yS5qdoIgVvgwRtCRQ
         eL3Zj8ozZUEOKeOVNnj4DiGZW4laGl342vjnaOX67tHeZq5gDwbqJ9b9rIBLVdpBqQtc
         cY8uwtWDgcFcbWP7RIThk9WEqKWOKyYEvSbnhDVstmROlJNsd8NqT/ix/J8RGMDjzhKZ
         bMLWgtushNTHJJaOdFYuWCYoer+cWuw6d602oIOPYpELAkYHn8yLIoI094ud31MML+LZ
         ypiVAKAf0MKfc847wNpV69jNSWbvgaivykYpyswTFQGMF63C/gnCtMq+sbZ1SWAqP/Y7
         EB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvTxc2LNiFSRIvJjEibu/s/Za+e68+PxBrGg5KQzCeGvakN569Jp+nhBrj84WWhnng1WEbYkXARHFL0RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjLiLC68Mfns2I3k9l+hcx6cQPDz0Q29wf1R2uQp3xPTOIBFd
	8ek02oVYCFx+n/2opxau/V42w8e+a9cqTaP8ezlSgmljpPWC0d5bRIEK65dJvr63vxlbzRTuG/k
	PwDtHB2leRQ==
X-Gm-Gg: ASbGncsNPyApYtguaJVmDc+B/Okt0EahCZIg52w8vJqpNqTHtoGPJB31ojrQz1tsyEL
	UiCeDGw56Af6Y90z+m64yw1X9A27n6EagZdZ5pJ/i/k0DgXd1vD7UN+z5Jc959KPVaYPMNcQryW
	JESDDdN49r8QS1enxGkyTpMZCaBZzpDeNioe5ED2qePcCufNBvKD5uSpzx40an5uVKQClBbEHfq
	Qq14WCHohl2Ah2tQfv+aP+sSKGGlGGC5nDsz6594IZHOVRH1n4kHsYsqc5IfKloo3BXedSHCciq
	CetochobSSKEZNUdZZ9bobPwo1HHOvS5S78tzrdKAIvmgSP7BYLy3ItcTQui5+mUOYYnOJ60jWL
	OsaLmXMbC8A3FEv8YeiGfx/wfGHuOGMrsJ9BNwPG7pZ7gsxnuvafwh0cFJbnExfT+a07DyrHC0t
	toLV/93gY=
X-Google-Smtp-Source: AGHT+IHFRC394/4/uJwAQSfGIsAv4SBwsaRInigGKPRqWnRP1iKxJFVPxNH2KMRzEd4xx5USe/j2Qw==
X-Received: by 2002:a17:907:6d0f:b0:ade:1863:6ff2 with SMTP id a640c23a62f3a-ae6fc0eb3d0mr483442966b.52.1752264488278;
        Fri, 11 Jul 2025 13:08:08 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82964f5sm353246566b.143.2025.07.11.13.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:08:07 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso4868419a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVWBUbYRW23IEcuTzG2C2+gfOLuRHJ1e9WqvWluN8XA831MYG7sMXzLzpmyuYxp/ZkVz9h190AkEiwnk8=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:60c:4521:aa54 with SMTP id
 4fb4d7f45d1cf-611e8490749mr4202220a12.17.1752264486410; Fri, 11 Jul 2025
 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com> <20250711125349.0ccc4ac0@kernel.org>
In-Reply-To: <20250711125349.0ccc4ac0@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 13:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
X-Gm-Features: Ac12FXzjp4AGZ7WX6h51mZw8s-h9Pt8Rdamdc2UExJ4zq0chj2Qhdb4f4rcsT30
Message-ID: <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 12:53, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Let me keep digging but other than the netlink stuff the rest doesn't
> stand out..

Oh well. I think I'll just have to go back to bisecting this thing.
I've tried to do that several times, and it has failed due to being
too flaky, but I think I've learnt the signs to look out for better
too.

For example, the first few times I was just looking for "not able to
log in", because I hadn't caught on to the fact that sometimes the
failures simply didn't hit something very important.

This clearly is timing-sensitive, and it's presumably hardware-dependent too.

And it could easily be that some bootup process gets stuck on
something entirely unrelated. Some random driver change - sound, pin
control, whatever - might then just end up having odd interactions.

I don't see any issues on my laptop. And considering how random the
behavior problems are, it could have been going on for a while without
me ever realizing it (plus I was running a distro kernel for at least
a few days without even noticing that I wasn't running my own build
any more).

I was hoping it was some known problem, because I'm not sure how
successful a bisect will be.

I guess I had nothing better to do this weekend anyway....

                  Linus

