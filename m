Return-Path: <linux-kernel+bounces-751042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BAB16485
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E46A167166
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456022DCC06;
	Wed, 30 Jul 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KeRRsbGa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37F347DD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892468; cv=none; b=OA5uBza6BruwVt3j3iw/p45C+6KzjhgL/IpSiPTmIQwBGyA62S38MQ/BVKT5VCI+dSX0bbF+eDXvpIJnjI2360ThCRjblJ4xA3GrB7iWTIq9uyJNMjMC5n+QAzLdkj5nWb5z1qno6qkX/q67t60hwK6Z4R3ghqKB1Guq1WP1AiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892468; c=relaxed/simple;
	bh=43uGzvt4ob7grTZb2tT0nh21mLKwphtCkU+Kw8genDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQTAQtlPixjBmPvo6YgG7Rm7Ga4TRGN83P9fehcGFIq88WiQmPy7SJIWDxQUbCNI9KJuI3VV9PYznd/R3uZntNrP/hjEeCGu4DtNE4qBXnqkl2qXfvF4RNSw1MMhIsgSoxfjAs3ty3kWbEnJ2FZLC6rfk4sRNaCAZbbNugpPmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KeRRsbGa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae360b6249fso1277591266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753892465; x=1754497265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NH/3GagQyynALf0TJNfWRtPo9NIRhr2hMw8M+oi+jAw=;
        b=KeRRsbGaSPUbsRcEcMLlmW0Hw41oCYe0wQCMDfyzQSgRdzsfj9GEoaaMV9FvMWq3u8
         SjJVnvr8R0A/uyH60KqXukTSlxc6Rxxi25DnnFvJt4yno3p46wyYWIsp/6Gb2/qu3TjI
         okzZmhJBJumKNoY0fB601c9RK1ATaET6+pnjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892465; x=1754497265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NH/3GagQyynALf0TJNfWRtPo9NIRhr2hMw8M+oi+jAw=;
        b=ih1oDJVHMTa/UZ6C0KF5kkyW/2ds6KpqozDmYrxypuas0aQKEKabAYBJgQT+GohpwW
         zh58sFTI9OXvfnvjaJMXoAekWNGTgBRcAD4MzFC4aMBFVZP7ABPds5bofZeIGUVVwQOY
         UkPmgJhjIb0Z9NoV+FcZzqnHX1aF51pTlU76u+wKkOPi9VW7shQT4rvgdECgH5e59rAu
         MJS8kPjO5XqWK8TGvBXBrgt/0XUz+IFtZ5ISR3/jTIdLqpzOImpq3XhfHyvq2sz4Hm8c
         jHz5MfNvZI3F+ty/InKDOeZnU6qBrtubFZOae9c5WCT7A26AfKhjEfbACTtkTEvYS8B0
         sSfA==
X-Forwarded-Encrypted: i=1; AJvYcCWytnO/Bit3XvK/YDMeb+CsSYL9btKc5XNNSJMIcATyLl7ojhCPIfVMIqPfKOgSTM76enTFJEcJjMxoSeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjxy2STwIkzFlQjz4h76274IhzNxbln9SxuFdQ9j8K2wz0UNeZ
	gAjUY+K6ZIIS9QmHGSprH/1BZyy4VhbndGIDWU/35U4KwAJFLANEgYtIXOcINxhNpOWyFD4bZrT
	vc26lHhs=
X-Gm-Gg: ASbGncvIOBWNbTKi3a9oQkWHLzf6faDCtnoWYiUz2gJbbAaCmn6DzpENKrsBwJSbGTz
	pXJzgh0mc12nWHrYdb3zVA7FWVhog6pM1D9Qf0MF3k68ewRWmUohKtMUeeQLGsiwe6Jz0STYGEI
	uaZ6XWgwKmnwlZ54qYANvxZ9ZsXSftBDri+t+aBl+htUtucXCJlpPQ0wuezES6xhGttkEwHO7Ez
	416mYR8O77JUQxG3tvT+DX9PaXKzjLZ4Q3nd4xVEdsdNB59TlTA/POMqFyyuolM9SUiFVyXHUl/
	fPwaN3zBK7dSTYcqMcCzXQmYeO6RWU6KOIE6PvNs0REdZ09vUsuoQmT0kTYcQTvmxo7cXk6bEJV
	ZvEHIZeQwBEVgid89sxQLN8DtP751UE927ORu2Rsw6C/AisG5zWPCMjMh/xk2kZI0l8jhq4g4
X-Google-Smtp-Source: AGHT+IHpZR9GNNEgCX5lBTxaIfnTEvGP2Ps1T+kRLnNpOwaLN448hTVP2ilRm7hTnTLBF/jp+xwjsg==
X-Received: by 2002:a17:907:3ea0:b0:ae0:dcd5:ea75 with SMTP id a640c23a62f3a-af8fd69b12fmr453297766b.5.1753892464084;
        Wed, 30 Jul 2025 09:21:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358e2f09sm764661966b.64.2025.07.30.09.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:21:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso1513497a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhvPnFIRLG2T9L5M1ryhtNvFmxujwzhsQhCakoXi2Cf1qRYi0du/pAsd5k9ibl7yHDiggFwCHJI7DK4sU=@vger.kernel.org
X-Received: by 2002:a05:6402:1d4e:b0:615:a3f9:7be2 with SMTP id
 4fb4d7f45d1cf-615a3f996c5mr542955a12.19.1753892462648; Wed, 30 Jul 2025
 09:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org>
In-Reply-To: <20250727013451.2436467-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 09:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>
X-Gm-Features: Ac12FXybTQ2GnQWYUYI6uVtMHGtsdyuV7m6LIaAejVL-Hc0-6S3c4N-n3CkDkzI
Message-ID: <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 18:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Networking changes for 6.17.

So while merging this, there was a trivial conflict with commit
9b0240b3ccc3 ("netns: use stable inode number for initial mount ns")
from the vfs side (acked by networking people).

And the conflict wasn't hard to resolve, but while looking at it, I
got very unhappy with that conflicting commit from the vfs tree.

Christian - when the "use stable inode number" code triggers, it
bypasses ns_alloc_inum() entirely. Fine - except that function *also*
does that

        WRITE_ONCE(ns->stashed, NULL);

so now ns->stashed isn't initialized any more.

Now, that shouldn't matter here because this only triggers for
'init_net' that is a global data structure and thus initialized to all
zeroes anyway, but it makes me very unhappy about that pattern that
ends up being about allocating the pid, but also almost incidentally
initializing that 'stashed' entry.

I ended up re-organizing the net_ns_net_init() code a bit (because it
now does that debugfs setup on success, so the old "return 0" didn't
work), and I think the merge is fine, but I think this "don't call
ns_alloc_inum()" pattern is wrong.

IOW, I don't think this is a bug, but I think it's not great.

               Linus

