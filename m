Return-Path: <linux-kernel+bounces-737428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30116B0AC71
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D829A3AB48B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760A225A24;
	Fri, 18 Jul 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LfDnWo99"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83D225795
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879881; cv=none; b=GSqhWBWSvLKuzrx+cKk0N9shCTaOGgCRLDE2jDSTPFOMmRcd3QQRy//LOXpjdXn0CCOHNfDdwSW9uVaMNKWTt2K+rHBffgjBqR6/V4tA7s8vo1KdTyQ+W0g0KzELzaP4jcfAyfJxLfYKKpOCnI8cyI6lfkMyDN36Nq0AywWqhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879881; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLts51PpuzxSZT0jMuotjh+z0+q2npQ82HfniRsZHTsbo0oNCpTLvQSzUkgQjnOADbUAEVG8eYhTV1JAL4hrkikPzXvm6lcsPLDQwktSUjAbEIVP/bkO33+CDQ/KgZO4O4G2RJT5bg4JGloGn6O3fdF6lkjPxv5bojGq7jGgd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LfDnWo99; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae360b6249fso415573466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879878; x=1753484678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=LfDnWo999TgMj39Vsc2Kl4l/C5lL0iAADIHwA+Xp2UGhEjbHv2+NAniwvvyKdfaQBY
         aJJtrBJoef7tXdAY2WQUFAlM41q6iZ/lSX5Gk5iW1mwLsVbqluU6YYVewU2A7s5hvlgk
         aUhWl07zb3Nu11/HhkDyUeRIAX+G6cn5kl+tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879878; x=1753484678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=HiuwOz/I7gHktWsKNCl/kmQB3dbWGYmgARr3thxfwBAJVL05k0Q1AGVhWoL3pLP3z3
         JXudJJJxrzMUUozAHYteGPCxdNKdmRh4WZ/wbZWrqof/53HvaP//9h8xwlk4QU63/E3s
         FZnwv8pqvnFzuSIZOHZF50tDlBvAPvVijj+vPR8oi1wV00kPWZIAUUseLlxZfFjSJClD
         MjeLcx2zZ2Hlgqcwv9mMR40EDDIlwcbIz7hv4onWfA0m3kDD9ZrRIsXH1y94KW4eB/JG
         2Rx7933YEW/JpwCZ+WjqPntzJCNCH25mRk1h+GLA60O1LmdYAlfoko+F7zxQJ1FA3QIO
         fAtw==
X-Forwarded-Encrypted: i=1; AJvYcCUB4RlRPk6xzZuFMvGTyPqkeye0V4Fm3YzCVQFDb59yYJ95vjyeT9oiNRN2iezh+8kpKy673AlpH9wVRRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ctm+QBSnuhIYnEOwCam+zB91BK3fnRnuiEGlXkZz4rFSie21
	a0sb4PCtG0KlI3Z0lRsRED11RP7ceWo/8o/1HMPO1HMvqG0dqnEOvQv4bwkv4WT0DZfnarxaJw5
	W/uG9JMeL1A==
X-Gm-Gg: ASbGncuJDI0xZe/7ilOTnp7dlEJq5FT7f3s1EIy6H/C6G4SDYbMBOCd5TL1PYxKR+Nc
	+jiGq9NGweAOtvz4DI81pbFA+qYcUHHGQozHDy0CDO1gMmww3GE9cznIo/xgclICwHR6ll/+7mk
	QcmfLrOCJKeNjwOBhttrV+R6FAPLsVdiuIGpZotVqiX/1BXyagn7MSsN/JO8pvRruphTtmCHtnA
	qB1SrQ342iyw8dE1XgrZxZ1y14/kYptk30NwEfTfuxz8z1dCTooTFyw4/aZ9j8+kKwD0N4IEqXO
	kOUDSn4XnIs4khhjiDHL/8Tj6HJqZJmweRyjM1AAi9W94Q4k7WoPEuqYgsF0h76TGbNHMXOTi6v
	59wimLU95KaqK+dy8LZVMgsgz+o9n9NQmpJ61y+birWj5jSqiqMInIa0isJfs9av7Ir87IvX3
X-Google-Smtp-Source: AGHT+IEQBu6uBkANSQrmyh13tSA9OiGiay4lQ5oMT+4ORrwd/TUq/nqmPu92CjDpjaBIIYzBODnyRQ==
X-Received: by 2002:a17:907:3c96:b0:ad8:85df:865b with SMTP id a640c23a62f3a-ae9c9ac1566mr1033095466b.33.1752879877740;
        Fri, 18 Jul 2025 16:04:37 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2fff7sm197879266b.97.2025.07.18.16.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 16:04:37 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso12614025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:04:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6KOqZyqCGSxmMUmYLc1uledBjvVuLEo4kcc4czVwNmZzx1aE9YoMRD7ZaiiI8pvRW8skWrtWIl5hkOCo=@vger.kernel.org
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus

