Return-Path: <linux-kernel+bounces-726080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0EB007EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE2518920C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E22EBBB8;
	Thu, 10 Jul 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h8kTF3bx"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD12EBB88
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162755; cv=none; b=cvLYMdz4OUpk5rv9f+6msRauw4SH0Cu7UmWbGMxioa6vNLDV3QK85a71DUUva9tWw1/1APHwCBh7PXn4tE1ebnH0R9WXWaD4Q4e2h1uY+9liFlbgImhBdZygJxveiErg9sQ4ZPMDSGI51HGnAwdGL/Nn9JZwmE4mjIhM3LM+7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162755; c=relaxed/simple;
	bh=Fq+vGXveryc48qb/dm5aqfzxb4eLCfFILKMVI9bcams=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hInwfbyBFIlAgJHeQVyb4iS7vzrIsK3IH7w2sLEDUQUl5uaCkobFCAOQ1PyiBPn/WpmWtTzAj/sd7JBhG7/jxgS2ArZ9huvIlFQ2C9vdcfID5+uEmIZuyVZg53tvA0fkY9WPl7C8eQMl8VaGrqdQkU6PMZK5uKlF968tIaClwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h8kTF3bx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso7547566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752162752; x=1752767552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCLKwFa0neCTBla2iQUvszaIW/YcUeww7BNmMA0A/10=;
        b=h8kTF3bxBfJSFGfDz72dfx2bNRdaDbfjUtyy24/w+kn9KUZVvBmlW8i/p3CnzvEy0L
         DJq05DUW4GAlTc3rUXYsm9NG50fS+vKRL/7jPRlOLipyQ25THyQbsMXOwlooYT5m9d18
         lAaT9+0m9ntMWEoJGxMoSYZGJKIlCkTRHJm5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162752; x=1752767552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCLKwFa0neCTBla2iQUvszaIW/YcUeww7BNmMA0A/10=;
        b=MvDf8v5/G4fsC50Lp8LaVqva8JpbYO9gmAx62WIGLWpfNHsT1D+l++k3AQi9BUHbYa
         rVolqyPt5gml+LqXDa9TNEavJHdwxWbGU0qq0CcvkT+81g2MI8xh1T5zAPK/Bzioh2RN
         JvelP3VfT/k4ICBxHxbwskVEWTsskkxQI9F8dU/vFV3ChN1O/89XQqwvUDYfiyozVq/g
         sf6tsXw+sbTJzKOPuyE+d0549ZyqhKq0zC9aWmjsLrylhItlXsEc+BTeFBKiAl1o2HAZ
         Q4CWoyFOFfLK43eUiTShbo2TSQAlMKESMVqzEhRfyk4fTt4IEfHuGpxHuBfzvHK3uSU1
         BwYA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoRxpJh62Vy8LZPY1/4oQNurc9K21eZ9dVUQarh+VHylMVB81pb+5MkX9zNyAy5vODjT5m61xgMFzCO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlbor45rpobtxVUwyw1fKtJKqihpnJoaA5Cl4k8fhWph6lBKFs
	9IYFTGkiz6x6nKgbOv5xzldlLPFSJFsWpbmDCI425W1U4deZlNXfrTRLnoG08nm3itCiaKs0L4C
	JCKzbkUU=
X-Gm-Gg: ASbGncvoUXZyvULRG+5BCahxtVC3nebUqFUCginYLUPw7ZiXQocy4eJXsm3a7/mU5Zq
	d3MDyXZuufiFcPQ1B95Rf7PUQZjmZrp5AFgm+HAzAGzKLGqOKCjf8MOmFWMcVyfkruiu3jXLBrM
	yUH2kyY6ICaNQ7ijXjR5mqg31bSYVebio6XMUQSeW9H6agCweyfqACAB5NM/nq6HLNaJDL+qhSk
	B+1lV9BZwkw71FMD0rDBDDUbQWykS9roZkJ2nsA56CAQQsdbsKg5T7jeSNmm6PCaGE9pjxjZa2s
	xzElWbvl5JUI1BfuBTH0hu95WwOkwg/8KEqpmjcJmH2cJ69o1Tmhv3dDqEt46xmIGm2rs2grPAh
	aU4Q4HJUUoH/qiTCBfnnlDXpYnyauXYeyifYq
X-Google-Smtp-Source: AGHT+IHoNDN8SIehih6Ikzym+PnNBhYD31OH8mQ2pC3NU4mycqxgfxgA3TmMkfbVAO43MrI43TTyUw==
X-Received: by 2002:a17:907:d22:b0:ae3:4f57:2110 with SMTP id a640c23a62f3a-ae6e70eddf3mr373286866b.54.1752162751539;
        Thu, 10 Jul 2025 08:52:31 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82deb30sm154432566b.146.2025.07.10.08.52.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:52:31 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so1680063a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:52:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFXWvKxtX2t5aEcwE5VClZEH1pF51Iip8+dMM+xhbUXbY5kLs4Y1lHPVIPFJgn11jKGL2ajdbJPVUEW5A=@vger.kernel.org
X-Received: by 2002:a50:9e0a:0:b0:605:878:3553 with SMTP id
 4fb4d7f45d1cf-611c8507641mr2264146a12.16.1752162750681; Thu, 10 Jul 2025
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
In-Reply-To: <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 08:52:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
X-Gm-Features: Ac12FXyZN9kxQm0HXniuJ3TdAUc1hQKzCbrnbibn7oPEnjnUTOgpa2jjfvxQ0Ho
Message-ID: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 19:49, Alejandro Colomar <alx@kernel.org> wrote:
>
> +#define SPRINTF_END(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA_ARGS__)
> +#define VSPRINTF_END(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)

So I like vsprintf_end() more as a name ("like more" not being "I love
it", but at least it makes me think it's a bit more self-explanatory).

But I don't love screaming macros. They historically scream because
they are unsafe, but they shouldn't be unsafe in the first place.

And I don't think those [V]SPRINTF_END() and ENDOF() macros are unsafe
- they use our ARRAY_SIZE() macro which does not evaluate the
argument, only the type, and is safe to use.

So honestly, this interface looks easy to use, but the screaming must stop.

And none of this has *anything* to do with "end" in this form anyway.

IOW, why isn't this just

  #define sprintf_array(a,...) snprintf(a, ARRAY_SIZE(a), __VA_ARGS__)

which is simpler and more direct, doesn't use the "end" version that
is pointless (it's _literally_ about the size of the array, so
'snprintf' is the right thing to use), doesn't scream, and has a
rather self-explanatory name.

Naming matters.

                Linus

