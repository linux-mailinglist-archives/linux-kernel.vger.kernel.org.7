Return-Path: <linux-kernel+bounces-894027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F8BC491D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B1A3AC203
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046D337681;
	Mon, 10 Nov 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KavP0Z9X"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532C336EFD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803690; cv=none; b=PLnoiLXXBFR2mThYAxuCuI7knqn5oZ5k9MLV8J9GUzl/UHhrlCrthm/6JuaiBOyz8yZQDlgU8oWHkMEyoX9i2/eZcvSPpEPCSzxityYCN21oMYTuBqa9V6dy5YJtsJd5nMDl7xbTtagnXDzpbqmM1JiNNqFP30GQxzKUo7fUSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803690; c=relaxed/simple;
	bh=PxpwsZjpe3I2aDg2u+M53UXL2FPgJLtktslzgZjb2us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvZ2xIfmLtdTpPFhxPGDkrdZlQfWd15WDfZoudZCWd9e6nitaTqT31cYAk3SLG/GPyeTKKr4MnVeCiYj89T9hXVO/hFo35v7SWKapo5/M5XmLWv0//HwHTC+WPGfB83dqF3AKS5UOeUGf526X/7AzbypejRpZQvlUdyMLj6O+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KavP0Z9X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso6317853a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762803685; x=1763408485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99/bEi2ImdlU2nnSwwuvCx8UfBwiGJABIRJHpSWJmF8=;
        b=KavP0Z9XMb/QCbC/684egH2tba9NRgtJQ+IkAtTT5Va3atNO6bCuw/MTvzO/gV+VXe
         CFOD7nx9zHwwXgtZvPt8hMukNkGE6TCUafK+lBHeJ+uRb4bz46yF1THA1h1biFdHHOVS
         G2SXh3L2A3NjALYWlKz7ZU/++sNH5Xv0zIXWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803685; x=1763408485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99/bEi2ImdlU2nnSwwuvCx8UfBwiGJABIRJHpSWJmF8=;
        b=FmpZKvOliRvAVZvYWOHG/eUoZglrf5/UuKEhqzpMr4tHePRK7uS+jzvhL2wyVevpOa
         OidycamKDOaoiPTK3jeFV87vTvirZnvGnURLPelAhJOGKPEhS+rB4uu2u1NUAtinFx+K
         0/RSH334AxAgbnLDSA49w2lucpvm5B9LD+NtT0K0OTB7UhzpZOM5mMMscZzZhrJVsUoP
         tQsP4zgZiDaw1V0MKMDR3L2Yv1sQOhq+rDDvUxU/JhoRusJxf3brUp5g9w1pN7sfNZyl
         HNXNUFumtQmvDGLCy8/hCX9BMRR++EU1CK32ACVyPcfOca5rSFrIV82P+qAJIdFNp4Ew
         ZZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeSy0a3OzPnFmj6yMi8650Hx6DLul8p8icsoiRxZgUZj6vWp0AbSYNWQgHmrYeaQsJ0eJEs+c/1yp/2ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFJu24LhmY0gg/3D1AoYjSja2dazFmOhKCa54+3IRKCPGyKhI
	5Ww8hQCJo50iJh75vvhMLHfH7xmbzl2ihM5K9YmZ37ZFagieM2Npl4ZW1SrLC64o7ivzxr1nRI1
	K9zgCr9A=
X-Gm-Gg: ASbGncs4L3nXJtuIt2I3IQQ2ycMlCngjcbjDL/UvNHMv455A/QYqw0omxvACbwJYpG1
	ZiW+04azu+SGPfqyLXMkuLNL7E2jZ3mGvMddSStyD9H4XstW8ACtHKcKoGpyLqKDfCBCuP+ZZV/
	BS++1tyZFrZD7tyXBN+tkh+rOZTaGhhTIq3gXFPbVdkrTvMzIxhIwO16hGIPaVeyTHWqfv/MxSz
	/1VeECKe0YWEokA1GllqesiMtMzDIgjZa2E3leqwwKRnkA2hXgcwClIRVB2i6UzviqTG5N5rSUc
	nKTNuzLyDZ0CiN5Xr+NxcUSBZKUgF9vaRkYMrv4y60kcu84WIrHmizwQVI8nr4kQLVq7bVrdVw+
	OkMwzFcaKDIKDxYlNzy7tARuop8yJy7oswV2qSiUez8mjnxGGNhOetZu05TuzihwyY/oyemAX7H
	oeLRcS7nfs6eVD/tDCtDOib69vE9gN4qVJf0ug/1RQ/dvhK9fE9VnaZgVL/9RD
X-Google-Smtp-Source: AGHT+IGJi+BKFB3Yawj2FZXNrwKW2MOsbuFbHmgUGg31y5jm44/Wq59Pdygy3Fy60GQcDhOKh01bpg==
X-Received: by 2002:a05:6402:270e:b0:641:8f8d:e640 with SMTP id 4fb4d7f45d1cf-6418f8e3f68mr3699260a12.23.1762803685424;
        Mon, 10 Nov 2025 11:41:25 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578d4sm12038504a12.18.2025.11.10.11.41.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:41:24 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1738083a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:41:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+qkHI3egfNlderw9qENM3CUNOkSiSMn5/3onNnxGH/e7M705nceGlqa19McTziB0Och7UToN8PqREOHI=@vger.kernel.org
X-Received: by 2002:a17:906:1355:b0:b72:eb03:9322 with SMTP id
 a640c23a62f3a-b72eb0393acmr666007766b.15.1762803376534; Mon, 10 Nov 2025
 11:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz> <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com> <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
 <aRIxYkjX7EzalSoI@kernel.org> <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
 <A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
In-Reply-To: <A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 11:36:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
X-Gm-Features: AWmQ_bmIQjBbP-mWv2JFFWotDHPz9N5F1IH58uHH12wUDflk5iKlAp9e5SKychk
Message-ID: <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mike Rapoport <rppt@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Christian Brauner <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 11:18, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Copyright reasons, mainly.

I really don't see the argument.

The copyright issues are all true for all other code too. In fact, the
copyright issues are a thing whether tools were involved or not.

Copyright is *always* a thing.

We have a fair chunk of actual generated "new" code, whether it is the
millions of lines of register descriptions from hardware companies, or
it's the millions of lines of unicode data.

(Ok, the unicode data is just a few thousand lines, I exaggerate. But
we really do have several million lines AMD GPU headers that must have
been generated from hw descriptors, and there we didn't even ask for
the tool or the source, just for the usual copyright sign-off).

I really don't see what makes AI generated content so special.

Yes, I think you need to specify what the tool was and what the
conditions were for the change, but again - none of that is actually
new in ANY way.

This all feels like the usual AI hype-fest. Because THAT is the thing
that is truly special about AI. The hype, and the billions and
billions of dollars.

I claim that copyright is no different just because it was artificial.

What's the copyright difference between artificial intelligence and
good oldfashioned wetware that isn't documented by "I used this tool
and these sources".

It's just another tool, guys. It's one that makes some people a lot of
money, and yes, it will change society. But it's still just a tool.

                Linus

