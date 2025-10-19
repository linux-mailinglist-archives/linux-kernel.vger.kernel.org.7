Return-Path: <linux-kernel+bounces-859639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC35BEE2D8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD50C3434AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D92DFA3E;
	Sun, 19 Oct 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx/SF+vO"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7B1C2324
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869074; cv=none; b=JgnG0C5E8QiF4o15B4+vhSf1qyFujM+9qW2RLgr3vjYNebC/+9PhRljNj3igSXqY+NV0k2xP14Y4TwXizIzhVo2Ruohs+VwQ3xo5CYhJk5+yLZuEJt3nx+Gx3kGWy5bd+11XAKWkcm238aYIV8IlBdDzrycfgeNKVFMamMhFkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869074; c=relaxed/simple;
	bh=NIBudYuoPuHUT5EhBUxqS3lYcOq1lQSbyJ+t7t88OZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqTWqb7Wqt23WDXTgw9vP+uD3352YZoSnw2efv+dP7ztehk7IbImEh/kS8V+7X+518+ZiGqKQa59tAquVxMWlZpTWwtYH2CnY0279ap1gRDQMemyQcx1vU9KJWMHvCkxdfhugxsa01oIkeHlan4gzXM4PTIJ5X2eEv9yptWeh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx/SF+vO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece1102998so2933555f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869071; x=1761473871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pujRAFNF+M5FPftuQoiuNZvJ6K+8t69UrOSME69oUQ=;
        b=Yx/SF+vO0pAwzzCNYtmTrUf3gHQzyY9sCHi+dVYDfcdmNYwlbUV7bNGuFbu2zwjXjv
         9FAUosYnI65FAjc2Zryyl5mjwhoQuviwDpFtHgJxePkuO7E+Sh46zXGfLMccaFoNobm2
         M6NtYtRvjkjT+XB5UneiXoBpZOOnIw7fIJCwFwegG+qIRlgj5YKfGow8RX0FY3QoucCK
         DGw1/uvke8GEDsLnS3cdDXMglwN5FEXjzoq/iwT9PDRyEU2jO770WdKJQ9A1RdV7CdWu
         t155bk6bKoZQ2c/EHdH6D+7Rwb1+XZ/2frTOitk7K3YDBoetHbfVcfyYK4VHOkb63Ji6
         kWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869071; x=1761473871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pujRAFNF+M5FPftuQoiuNZvJ6K+8t69UrOSME69oUQ=;
        b=I0fD7RvyIRMb7nSFPQBfsXfUTw6QKwNQufbbROOMX1W8C5KuOBLDjit2/KWTE9NLgG
         ZRlkTZYFVfsc4T8pBhAijsk/pb8aHkZ+DAnYSAoExpZuS8Vm6mRCQQSVDfm9bOKXkbsm
         kO1tWpeGhHp7UkwIHvB2MpEkRbdyEvyWiayam1jYWZG8Do3JikXL5jnt7Dr2Mx3DpIZZ
         wuD933nWGRQXpuFuUh4vMAdDid4prFx4vOBcp3SPiYfDCyp7m82kG2ZQKZ4JrO442FYN
         GIuCYZHuuD8YLN8+TcCjFln6aBr3rGfacfCTo4tDuz/Zsmdl96VLMzejMVn5iA4uWyb9
         HaRA==
X-Forwarded-Encrypted: i=1; AJvYcCWUOcgIxYzI5Ome/YnIj5yQN3x+mwXbz8zZmvysqrKYu66M1WzF+6qVpEZczNehTuiUdtXxfxdNMHXwYB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUY9gVVfsCTSoLXUj6xAObiArgvZW5QxKn41zmSyW/Q7Lwfug
	rMTEZfnwJb39wYTJdSWY7RQ4J/DDk2EaK9JNPgak3NyKRkjy8PqosQoM
X-Gm-Gg: ASbGncs+xoh2ANafmhY7lwEtbHZV0iRhVUwGkxTH0M1VngIxmLgGcuEWc08yxYYRQSB
	qZvTltwaFQDBdu6K2EdTjRM470tDqZhhOmr9+RGycC2gV3q9iqExUpwNG04+74IV7oJsh/3qoMj
	xJjQXOC5GlC4MbZtPMCmFid9WAv/nbFHfgjG/TS/+aelGOySBXwH9QbUKB6fIZ0IEeWT3NxvnZi
	+xfZFc5Oe6bUx4C6WZHAGkFnOjffcZoY46ComIlKzEeYP9ZDTpjJPcqKW8tsCo3Gb8/NeTyHOGJ
	zgzphC8mLi33nw6nB5Q/dUiTmbIEAZj1uzdt2hYqV4ICABGsI/LT4Ry+YfPtzdx13k13QtbuTUW
	33dWUkVCpAQSAYE8Ukqz7lJovQO5QQQYB0rZuZJ6ErMt/uiKHHpjlASoTUVULRrBLiCwiTcX4qj
	J3trDls4PSNpL83Mvl8QH895KiNExBuQR8V2mWbom1Mgh5Rd+LpVFp7EIfb7Vb2/k=
X-Google-Smtp-Source: AGHT+IHDWHxR+eS5W2I+moYmguRID8F3W2lMveOL7qKksf7E5SF+DVjocrInHwcfFTvpD/FPS2znDg==
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr66402495e9.11.1760869070857;
        Sun, 19 Oct 2025 03:17:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711c487dfesm152925745e9.17.2025.10.19.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 03:17:50 -0700 (PDT)
Date: Sun, 19 Oct 2025 11:17:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
Message-ID: <20251019111748.3d5ac8d9@pumpkin>
In-Reply-To: <aPLC_HdznsRcJbjk@kevinlocke.name>
References: <20251016214707.5c3d373b@pumpkin>
	<a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
	<20251017151256.111f2669@pumpkin>
	<aPLC_HdznsRcJbjk@kevinlocke.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 16:28:12 -0600
Kevin Locke <kevin@kevinlocke.name> wrote:

> On Fri, 2025-10-17 at 15:12 +0100, David Laight wrote:
> > On Thu, 16 Oct 2025 17:47:09 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:  
> >> Remove the "x" suffixes which unnecessarily complicate the code.  
> > 
> > The problems arise when $1 is (say) "-x", a simple LR parser will treat
> > [ -x = -x ] as a check for the file "=" being executable and then give
> > a syntax error for the second -x.
> > I can't imagine why shellcheck should warn about a leading x (or any other
> > character) provided field splitting is disabled (eg by "").
> > The leading x has definitely been needed in the past.  
> 
> Yep, it definitely has been.  The rationale on the wiki is that it's
> not necessary for modern shells (and presumably that it unnecessarily
> complicates the code): https://www.shellcheck.net/wiki/SC2268
> However, it notes Zsh had issues as recently as 2015, which is not as
> old as I would have expected.

It doesn't really make much difference to the shell.
I really doubt you'll notice any difference in the time it takes to run.

> 
> > POSIX does require the three argument 'test' look for the middle argument
> > being an operator - but there might be historic shells that don't so that.
> > OTOH you are probably looking for code from the early 1980s!
> > But the POSIX spec (last time I read it) does point out the problems
> > with arbitrary strings being treated as operators causing complex expressions
> > be mis-parsed - which a leading x fixes.  
> 
> Good point.  I just reread it and can confirm that the current version
> still notes issues mitigated by the X prefix with "historical shells"
> and with greater than 4 argument cases:
> https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html

The fact that the 'greater than 4 argument case' can still require
a prefix character might be considered enough to make adding one all the
time 'good practise' even though it (probably) isn't actually needed.

While I wouldn't error not having a prefix, generating an error when
there is one seems wrong.

What does shellcheck do with [ "$a" = "$b" -o "$c" = "$d" ] ?
Or even [ "$a" "$b" "$c" "$d" "$e" "$f "$g" ] ??

> 
> >> I think they are safe to
> >> remove to clean up the code a bit.  Here's a patch to do just that,
> >> which can be applied on top of my previous patch.
> >> 
> >> Since -o is an XSI extension to POSIX, I've stuck with ||, but I think
> >> you are right that x would not be required in that case either.  
> > 
> > I'm not sure there are any common shells that don't support -o and -a.
> > They get used quite a lot.
> > I'm pretty sure they were supported by the pre-POSIX System-V shells
> > (or the /bin/[ program they ran).  
> 
> You are probably right.  I still remember when Debian policy allowed
> them and posh added support in 2007/2008:
> https://lists.debian.org/debian-devel/2006/11/msg00710.html
> (I was corrected by Clint Adams about -a and -o being XSI extensions
> some years before then when I noted posh lacked support, which is
> probably why I still remember it.)
> 
> I find && and || more readable, but I'm open to changing it if you
> feel strongly.

They get parsed entirely differently and are likely to be measurably slower.
Just FYI I tend not to use 'if' statements at all, just (eg):
	[ a = b ] && echo a == b

> Do I understand correctly that you are in favor of using the x prefix?
> I have a slight preference for leaving it off, but I'm open to adding
> it if you (or others) feel strongly.

I wouldn't take them out and consider shellcheck wrong, but the suffix
were just stupid.

	David

> Thanks for the interesting discussion,
> Kevin


