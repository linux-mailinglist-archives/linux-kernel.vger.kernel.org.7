Return-Path: <linux-kernel+bounces-737386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6903B0ABC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F383B3F33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DC22126B;
	Fri, 18 Jul 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J04nZRR6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983321C9F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875807; cv=none; b=Z7wvtOdi7tCNmssuqvcSR9HsQqf7D/4Z/g8c4pm6lxsl34sDeScrYWxT4re0sXJxUKokOgIn9FmLOqhU2h/IO8r6XQfk20KCD6o/DN4obBbovuY6iRgF6QZYqTLsHrAIbiyiJMmyZGjU3XzWbsgGHpTVH9kQfkKwJj0sWlEjO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875807; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6vk4pTESFpNIsoVH/VuWd1rr2lsOqQgGA5Iw4bSDYWPoOkrM+31hmQqjPlqPHEFDRjaFdUYuZX/lrmbHEMLp93WhmqgzBfI1oreNQbC1U9vuzqKDHhex58ADmgE/U2NPwO0mFTxBGR5HKFbqcqmSVr4HnbJdFPrHH2vGY9yJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J04nZRR6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae9be1697easo638629666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875804; x=1753480604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=J04nZRR69wqg9Q4dDnD4hea1l2D3FUXaNN/NCrQCP5jA3K4cQe/eQI9Jpa+pg0VEwn
         HrEskmwLn/VZgy7FpaThvJz7szi3+yJrvsmzYjVh3ZSihJNP6rlXYtXTI92g31FUsO2M
         8ce9TvNdJUl+rAUxbzmPLUOEe2d3ksCT3otI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875804; x=1753480604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=moHzN7AgIWwkWYoM4h5B/HEh7pnHgtc5nFQXgm2acjGHT0Qz5bOGzW91ewBXQvfMMC
         IDU/Ws8CTyKHqEC7RFceY5ImB5T8KhpJ0MWDi5lwL4Dnqnzlr+vlCaU0K6PqIp1TCQSJ
         v/xEf/gh09JOD/Rl2UjdahcIdf3KVNc8dlIH0urNHcA6QErjreZYUreqEngt7Um9+rEz
         wM+hgnvMkLDQx/SRBFXxBZNU0eE5nUchX6rZBSKawU24w1rhbtrADTV58QtXjCs7QoQM
         ajVswgzfG/ypyZJxg0zMKuV6pJsTJ6d8I9u7ifl8SbhbaLRoXmGOi8LkzNcm487+16q0
         iGHA==
X-Forwarded-Encrypted: i=1; AJvYcCU81KFo48mqj5gWuk1upAm+T0L1lJui5F9Px2Idqrb9WnyqOwlM06vrYQ2v/zKCCZrOmwF8/2+SmtHF84c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mB7PnvR4peZUSPJAtZQNO6ZyNC5PbsviCP9Fijq0Q7OIppAL
	8W9qUGrlpZ1N6G6cFlflV+kvjGu0VvqoqmEffB31Ex6PysUbtcv3hSxYpE2hl74RoHSADTuHZWK
	lGX52+B0=
X-Gm-Gg: ASbGncuJLJOZECT6z9B2XisaMbFkcs3cjut20w9TzuLTOPiSHsNO2KLf8U1iNS1jmZk
	jVymx+qmaE0LgKFPySnpejoKwhP/r3a6j2qLgLjIKOy95O6j5prDeUvpdRyMeJwYsLH4lJvkQjq
	Y/Vk/duVLXV1/rK3ohY57cRdlXFBnLjWHEQq3b/6Ykadm8DIxWFohbOlBmtuisx1AOgiugSdZuY
	CzbGimUXBFJmz+PMl1yFmWm75BqZoNie/f6bSkwdqXDA2050e70Wiu6tA8vkqov97WQ4E7mafNq
	tggl3Qdk6v6hwFzKyPFcc2kvIDUQbd9gfLMLOMAiVR7TkOdDHfaNZz7pXXL/HL5s3IK2m/BJ2vy
	NQl57XH3U8n5ml5wYyWUi3CfA6+HdinfAyl8NasgEWJqkGng8UgpNPsv8tvQ1fLojOGV6ZZhA
X-Google-Smtp-Source: AGHT+IGJeHz0qVjGcFQpTBQQ/6xQ8gAtdWTnYEfuU9izBaWyYDIEimWcd7EvKkY55TvGeh55OYnqsw==
X-Received: by 2002:a17:907:3f8c:b0:ae3:a4a6:a32e with SMTP id a640c23a62f3a-aec6609071fmr448989766b.29.1752875803565;
        Fri, 18 Jul 2025 14:56:43 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2ee01sm190085566b.81.2025.07.18.14.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:56:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso442958766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRNgmt2mFL4rfkH41KXtCsRt/OOlRLIq3BmN8V6+nHH0IYaB+b1S7W8vcsIPSMkHUf/gER4m/2IaxB4k0=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus

