Return-Path: <linux-kernel+bounces-862470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC2BF5619
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E283B41A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894D328B68;
	Tue, 21 Oct 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZA6tcTt"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA232C0279
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037192; cv=none; b=T9hM0pJCFJMqOk2vucB8+zxc2MvbCE/UD9+fdm0nVX2gAcBjpsgeTT5gwILezw2L0AWiyvO3tLOZEqy0PWqMG8PsF6/Cjc0Gv4+jDqENOWEG7Un8Qfyw58aiVBIcNrHC5lpiR+331kvs/Al6HzEpUVeFSvWRg0zTYEUcGov3bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037192; c=relaxed/simple;
	bh=1QEUrYYVMgPUVpUr6hSgnMaTqKdSkGKC8eOI3537wng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYbjoZUM/ZSU4ljWitGUwQdYoRo1xrWQWCFDF0SH0lRhnko5/lBBWRSqtLlte4zqZead4LAZJzFEGoTv5byY4otrPFt+astezcGkj61aQN3wDShGDvurIvhFhhyhBODjZNH9g8l2N2Ue1l1I4mdBDnQDt931r7QaaGcormMn3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZA6tcTt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so7106961f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761037188; x=1761641988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBXILQ5+6y63oPSvnHmd6OoFeC7Db+e5bwqzatdyD90=;
        b=fZA6tcTttCMZczW7m7UEpp9nzGQmF9jU1GXHzznOBNqOi9wEIxa8CN3XUm1sbgyBMB
         twizW7YRH7hr0tvjvAvlv4jWoCZ1hSLMN7q8f21kBB7e5d2G+RXAD8x1RghT1CRPkW05
         zDR5pNZ9wriX8sLAyTcZix5NHQeGCqfQXrfKjLKf6giW/xP/QxZVIElDWQq3lLKjUso/
         Kd6DuZmsiqLL8ccoZjVJ27gYg94JIRw7WF79t5FWRFG8e3bmiKKPJhF1MtmWYVxzA5Y/
         JPiw7IDQWEzu89CivuwBpzdceoX2c50ZhfSvdpx/30J+zm1fdoS72V5ImW4nsvtZKMDX
         v4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037188; x=1761641988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBXILQ5+6y63oPSvnHmd6OoFeC7Db+e5bwqzatdyD90=;
        b=q+zCuBwq61iCj3qgK//S386eujHxjyEUys58JLYF7xbAslSSFaH+x9lutpsh+D6GC1
         Tc2gu2ou/9Kyouikp0sRvoCXm/93dTsjGjNXls5tACrMXIDa0q+b2/rAAOAqF2ZY6q6C
         Om9Y2hvOx34O5ZiAKYN0cEWScqn5BA5RynqSo4ZVKbrw5Rz4kCnF5uXgdT/zDvC6AKP1
         zih2tUqGgw4nGwQLNflHBZNZFXWEk8aOxXxAFJw+TJ6i9ubeTpRwWB1rZqdRk960uV/X
         MqJgyTENWGNn8eNGUsUtVnFNEoSgvjdWlE7Ou1P/qMiDjkjMiJF95Q30ZdB6f24b7AS/
         FxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqarFTIY/v0QRHfM2+nSecMpNNMYfGJFVpEPSuIJZ4DgHbU6IUMjbiljlsV74e8d0nLw7gqzXwb1Imbtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtzvf0PKDrnpXGMWD7G5n28vs6C9nJi6fdHEfn1fYHGIQ0YJiB
	aXKGHVN/gaN3szBiAhH7Q0B4egaH/bRCzop1T41XXWKYkYHIHKmtyJNI
X-Gm-Gg: ASbGnctfm2xVsDBvl4/1nMZZmBF3Foh7JhymfQQwcTZu4Z87m3awDEehPIykSCfcYge
	z51XSxnZL8qaCZviep6dm5hPuBfGJFENhmT5C3l90c7y78WutOZAv1cWkhborMA4kyro+EiOkxA
	fMEBpnuLGdPev1Oo0Pa5z0xvQev36bJcYaZOrQ8iaBzXaL3uSSrLR5QSgB/K5MNJCxiURLWvVPU
	2xDO4HJzaEtt3Jr+H0xfERboW/z+VgieSwehBCJooi82PL7sXRpsOe7HNBcPAIPNHuGesYwApBG
	7fFo1gCxxEdKb6OpdheWjUiZ589ovXv38eAB1zHvIUnbyyweNvb1epSi/rDwkSGH/5yd3UiCgzz
	OGdz50M94rBCIQjMUFLGRiqfj6wdasJ1anbr8r4hNIUKjknySZFMFWR6zwlwaOpSHN9wHthvUnR
	x/NfHj6pUWHXavfZgl5he0ACyGNaStHgAgZHRnKMDcZw==
X-Google-Smtp-Source: AGHT+IEUC4eOEYXnyWDtGa4T07dDft0etAi9lHUjpiTZ4nloIXO96U7Basle93bRRFQgv2MxpmdjiA==
X-Received: by 2002:a05:6000:1a8a:b0:428:3f7c:bd0c with SMTP id ffacd0b85a97d-4283f7cbf4cmr6807885f8f.31.1761037188360;
        Tue, 21 Oct 2025 01:59:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm19212667f8f.17.2025.10.21.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:59:47 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:59:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
Message-ID: <20251021095946.3c4071fd@pumpkin>
In-Reply-To: <aPaZGKyY_5ybTwda@kevinlocke.name>
References: <20251016214707.5c3d373b@pumpkin>
	<a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
	<20251017151256.111f2669@pumpkin>
	<aPLC_HdznsRcJbjk@kevinlocke.name>
	<20251019111748.3d5ac8d9@pumpkin>
	<aPaZGKyY_5ybTwda@kevinlocke.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 14:18:32 -0600
Kevin Locke <kevin@kevinlocke.name> wrote:

> On Sun, 2025-10-19 at 11:17 +0100, David Laight wrote:
> > On Fri, 17 Oct 2025 16:28:12 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:  
> >> On Fri, 2025-10-17 at 15:12 +0100, David Laight wrote:  
> >>> On Thu, 16 Oct 2025 17:47:09 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:    
> >>>> Remove the "x" suffixes which unnecessarily complicate the code.    
> >>> 
> >>> The problems arise when $1 is (say) "-x", a simple LR parser will treat
> >>> [ -x = -x ] as a check for the file "=" being executable and then give
> >>> a syntax error for the second -x.
> >>> I can't imagine why shellcheck should warn about a leading x (or any other
> >>> character) provided field splitting is disabled (eg by "").
> >>> The leading x has definitely been needed in the past.    
> >> 
> >> Yep, it definitely has been.  The rationale on the wiki is that it's
> >> not necessary for modern shells (and presumably that it unnecessarily
> >> complicates the code): https://www.shellcheck.net/wiki/SC2268
> >> However, it notes Zsh had issues as recently as 2015, which is not as
> >> old as I would have expected.  
> > 
> > It doesn't really make much difference to the shell.
> > I really doubt you'll notice any difference in the time it takes to run.  
> 
> I agree.  However, I'm more concerned about readability and
> understandability for developers less familiar with the quirks of old
> shells.
> 
> >>> POSIX does require the three argument 'test' look for the middle argument
> >>> being an operator - but there might be historic shells that don't so that.
> >>> OTOH you are probably looking for code from the early 1980s!
> >>> But the POSIX spec (last time I read it) does point out the problems
> >>> with arbitrary strings being treated as operators causing complex expressions
> >>> be mis-parsed - which a leading x fixes.    
> >> 
> >> Good point.  I just reread it and can confirm that the current version
> >> still notes issues mitigated by the X prefix with "historical shells"
> >> and with greater than 4 argument cases:
> >> https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html  
> > 
> > The fact that the 'greater than 4 argument case' can still require
> > a prefix character might be considered enough to make adding one all the
> > time 'good practise' even though it (probably) isn't actually needed.  
> 
> That seems reasonable to me, although I'd prefer omitting x and
> prohibiting >3 argument cases, which appears to be the route
> shellcheck takes with SC2268 + SC2166.

Ugg.
I know the parser is 'problematic' but you need -o (and -a) to get
moderately efficient expression evaluation.
If shellcheck objects to those I'd guess it also objects to ( and ).

You really don't want to use [ ... ] && [ ... ] because it goes right
out to the command pipeline parser.
Not to mention the lack of grouping for a || b && c


> > While I wouldn't error not having a prefix, generating an error when
> > there is one seems wrong.
> > What does shellcheck do with [ "$a" = "$b" -o "$c" = "$d" ] ?  
> 
> It only produces SC2166 (discouraging -o).  However, for 
> [ "x$a" = "x$b" -o "x$c" = "x$d" ] it also produces SC2268.
> 
> > Or even [ "$a" "$b" "$c" "$d" "$e" "$f "$g" ] ??  
> 
> This, and [ "$a" "$b" "$c" ] and [ "$a" "$b" ] produce parser error
> SC1073.  Unfortunately, this appears to be a long-standing shellcheck
> issue:  https://github.com/koalaman/shellcheck/issues/1645
> 
> >> I find && and || more readable, but I'm open to changing it if you
> >> feel strongly.  
> > 
> > They get parsed entirely differently and are likely to be measurably slower.
> > Just FYI I tend not to use 'if' statements at all, just (eg):
> > 	[ a = b ] && echo a == b
> >   
> >> Do I understand correctly that you are in favor of using the x prefix?
> >> I have a slight preference for leaving it off, but I'm open to adding
> >> it if you (or others) feel strongly.  
> > 
> > I wouldn't take them out and consider shellcheck wrong, but the suffix
> > were just stupid.  
> 
> Are you opposed to the patch I posted removing the suffixes?  I had
> tagged you as Suggested-by due to misreading your first post.  If the
> change is not something you'd suggest, I can repost without it.

The suffixes are just wrong.
If the shell treats the first parameter to [ as an operator and $1 is "-"
it processes [ -x = ... and looks for a file "=".
Without the suffix the same happens when $1 is "-x".

A conformant shell won't do this for a 3-argument [.
But I also suspect that any conformant shell supports -o and -a.
The 7-argument [ definitely needs the prefix to protect against unexpected
operators.

So I still think shellcheck is just wrong here.
It ought to be checking FOR a prefix when there are 4 or more arguments.
It is one of those idioms you have to get used to.

But at the end of the day it is probably your call.

	David

> 
> Thanks,
> Kevin


