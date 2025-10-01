Return-Path: <linux-kernel+bounces-839194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9ABB1056
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6763A7721
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8877258EE8;
	Wed,  1 Oct 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PWFHKz0b"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE35201017
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331830; cv=none; b=gA+g+5yU7X3wZ9xK5erKFF5gfgePC/V11FMCoIfc9NSSiQQSHScUmV8HI2pqzhREXjDMD1y587rZ9Dddq5Nkqdidy0xZOX+9LKGejFGHmIH6cMK2KP7YZWmIaH6ysk0ul7FBAPmeZ7R/nNNSn9wn5TnM56eOZ9rV6JC3/l1A6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331830; c=relaxed/simple;
	bh=xsKi9Pi+QT5fVL6eQFIu6l7eEF5T3oEwY+NILjBv18s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB1TI/MI/WOAl+i+q99dd4O9S6LEjDb90q4JfPligmeeM4oFREh+SwZOWXpQcpQj6xwmP8a+cMxdwqAuyvrabx2ZwiTNgAvTZkEul525FmmN6CkmXj3rGKkXHUm9KmYidAlCqNBgI9IBUGNdFPp7F6UP8b+gs6mTNU0dKeBVGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PWFHKz0b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso10141328a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759331826; x=1759936626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=PWFHKz0bFWJ113CCQSZzIRRYOuyGnxQfjub6XyTqKMSKk1pV7+acqFSdPdKWYWJAAF
         isXJFSxDNlN+YKYB+4TI+vAAex0NC6voRcABzALpwyIaAcP5UHmjCzaSL0Qm1Ae0Z0iV
         Md53d4un0OzpO2Con385FjvclTDffKFoqR2/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331826; x=1759936626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=BFi9wV4+MIGzzKRErqlqxLj6eAd7p0vbaLNs1qBS6XPOsciROiOvndIDRJVJief40y
         xdSQceKREPB9l3MbSHFcX5Qb29HjzwFgaNPXu2X+QzijOIjwiexaKNFEbQXyfouH4oTM
         xbKbAtL5FbNPQBckNhgHIqI0x0nxKbcXofZP6nzqlsfjQab0rmw+Ps80TwjcUqJbaFm4
         wSXYI6OGegpXM9gOBAa/SIMwXgz0J2JaWa0T4OtU2eM61LI7+hvf+MXd+vfvr1iOOOaS
         pqF9r0X4hFV3aCJlZdfUOkvrXUTPSHlHdqSX+VZ0mdZ+jq/TmbxoqWS7mtcCCP87wXd6
         FCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZhqMjkFgd90j772ylK0g5yMBDpg2xxFvDkHI0tHwn09w4OC3utwRmQCjDtNWyWyDQ0QjBTiZGtZocZpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwOu8qonk6VT4dlsO1VGrnhaX5H7OOBnheNtrW0ngZ+Mxohud
	GYCxzTQpgszNFbyldjp2N7l1bmrRBI4BQ27jdY1engXo2/4b+SABbQEeH+slDsLiuhuBoRF3Ug1
	56aeng/I=
X-Gm-Gg: ASbGnctlIeJqdG+Cx529MvcGMvgOKS8aCb1KaN6TD2hL3P20HxOEXb9uzMATibdjBbM
	LUNF3qrZlCKqgZuprqC7d8GQcA5rcqloDSZ6Fic6ypcvAI4+llHoTYKE/Q9ZMFmt7RGKZbNlllc
	FdJxKyN3DmM+CAZ7eJjh1oijkzUCUIpoKtOq3xjgSeIC26tf2gXTapLY4Fwda0tzGOO6KYMdyES
	ZhA5ggTyisyKXOvSbJRYIg2nEryB425q4/QANxpmcwrDJQsQZypA1ppl5ecp8xH6C6ICyzK0eRM
	N8mI5az+zt9sGYzyGEpsa9HTbsVA5HHVgYp8meFchlNvU8sFZpKnvZDfHO026xwhAh5vaE/FPnp
	mXuOl6U/3IZOTgRy7jFJ1X8d/4x90J0274GkS6r6CQEpketY2CafASVqkjXoeYcVZ5I/+t+za1k
	VOHJHnnqbK1PWfoo31vHz8
X-Google-Smtp-Source: AGHT+IHcFYS8fHrB2leSQW0ZdgG99o9txivtlhgx0hGJrFPM7kh3NqsWe5k6Zfp4lDPvMtyeZKROUA==
X-Received: by 2002:a05:6402:518c:b0:634:5722:cc3f with SMTP id 4fb4d7f45d1cf-63678c05aa7mr5101620a12.16.1759331826037;
        Wed, 01 Oct 2025 08:17:06 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3650969sm11817948a12.19.2025.10.01.08.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so1199915166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHeyYb6lQWFdB5bsnNlEA9D4KLHSBfpOoA8ozlD39d1h4ZfmnIPxh+AkQvJDoKRyUxZeN5oCbG04YugI0=@vger.kernel.org
X-Received: by 2002:a17:907:a08a:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b46e1951101mr469679966b.18.1759331824949; Wed, 01 Oct 2025
 08:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com> <aN0JVRynHxqKy4lw@krava>
In-Reply-To: <aN0JVRynHxqKy4lw@krava>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 08:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
X-Gm-Features: AS18NWCVZEu0EKX7iTlguIB8o3ke5c2XEXaIJTu7y5nDPGE83H1_P9z9kj4Br4A
Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, peterz@infradead.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 03:58, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> yes, either way will work fine, but perhaps the other way round to
> first optimize and then skip uprobe if needed is less confusing

Yes, thanks, that was how I felt looking at that resolution too.

> I ended up with changes below, should I send formal patches?

Please.

> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
>                 goto cleanup;
>  #endif
>
> -       alled = TRIGGER(1);
> +       called = TRIGGER(1);

Oops. That's me having fat-fingered things. Sorry.

I would have seen that silly mistake had I gotten the tests to build,
but as mentioned, there were multiple small issues that had unhelpful
error messages that I had given up.

              Linus

