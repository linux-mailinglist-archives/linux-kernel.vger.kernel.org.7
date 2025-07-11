Return-Path: <linux-kernel+bounces-728185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2EB02465
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FBB7A589B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18CB2EF9CC;
	Fri, 11 Jul 2025 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HSfxSvmE"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562A1D63E8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261504; cv=none; b=oIH+PK5JC9ao3rRMtDdKiofmixDzr5RiXoSiZcSQ9Dc6eKgwj5GEvXtzBHSQ50/Pb1lGuIrAmaxGCscShapt/pq2hsF9aLs42WFXeTwDWxaSFrTEGsVVD7gI4OIK14fzkyqdV5PaeeYSvID3xAzHtv7HXQuGhg3jrjIAWU0bs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261504; c=relaxed/simple;
	bh=i17k3LttSodPsplzghCSZRXhBNaUwArUo5/h6u1tcjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUCClIcwYBajQkJXlJ0+wbvhSfvF8gbHEC3t8WBlzrzD/AiZqoFlCKhRBPaV6KnKwB8LKspONsiEXlMHzxUKbusel14bw+KWpt2UzDERcO2pT/TUtmLS9tXiBS4MLAzK/fIRGRLq/ZFqoshazfgWOS8CTG7mgh+IBIx4RtrmiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HSfxSvmE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so491627266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752261499; x=1752866299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGIcMUli3ztNAnPUcFhR5bM9fuY+7pKG/dEA+I+ib0I=;
        b=HSfxSvmE7OkxedRh5A5RCX96Y7xM9JBJL1gkSfa+ocUpnI5KSq3KnGVTIexxCzNNmY
         XGu1vCzi403yBRGU4c091TCOzCHDGjuqsMqbeWoHRHBtnHmaN6EdY4zpjmFqkKrw+xUC
         vTCEzAfu3MDNcm/SgGL/xNZKTgUc7pKw+IvVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261499; x=1752866299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGIcMUli3ztNAnPUcFhR5bM9fuY+7pKG/dEA+I+ib0I=;
        b=ud672LmGKdD4ut+Petj8NuZm6FgV0Vvc/0931r6W/U3VvGVZz7UM7Ptn4aDLw2j/cT
         v+/URO4bF7Mog55UpEUHz4zkOJy0MQgAjXQ7A8dVg/loPLWtCoDFOQg5JwNdvuAOYYzi
         F9UeOFJFfNXenWaT9wznnOuYWn1ENxYvpGHejr4LM/OSVxBfJ7OJN7TaK9l49C0OkaPw
         dONtw67pkylKVzv/zH7tHnmtUSJiODv3eO+3Vkr7eyGyyoHJPDkLlqI2izxtY/d6rR71
         MegkKCe/bbpz9hlddoqBPNGBAscw08PnD9tn0+lmxSz3Dx1LzMn2QfzzhcsoPSWH5RO/
         E/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVP9enSQMb+yoQbsjX+qyVhwrycTKehD9xv1E44OiAX3xMXGDDEjBIgpojdpEBU0WgCrQ6Ft29BSEC6ULo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4Vi0iPfWMVEytjWU8gqCQPNGs64ipNOo5ALt+qS3PwhALnlh
	exXCyFt2DGkRuz3WL7o49API6MbSQ687zi6h9yXcTO3i3ZFXOutwn5Eoc+R1WWCvyVQlSalnTgl
	Rq4njw+pHBg==
X-Gm-Gg: ASbGncuMgyiZiZUNxbqmiVBO4c3r48UlCgDX361Ut2CVSwyRDOhkCvP8OY5JC6czEQp
	3oYTYBGyvagaMCFSzOvlwTsJ1Sa1sTNch9nQTew1EsObYA+1ZKD5tfyLR73tNSJHcG2zHtPFUoC
	kCMRUxFzYhbfFAk6uQ3li+U6n3UdTvJ2EgCvDupkQxiGu/SuXv4kzOffvUJknd8rvgnsywOxGk6
	VicQNeaGdRg0x7kqil/onfyU+9Ngl0zu6JjqJokmAgXoKCApM8EMzNqVTkFTDFQjQKbyu2Pg305
	bqlYjMN/MG167OqySq5Zy2z9bdJzxND8bt57kKHTob0IbROuLw/5TSA4hK7jnH4nP6R18Y3QbOB
	QWSuD5IoTnWMUimjgC8HlAYFKs6kFuvFo9c4jAB9cbsrcs7TM+9gB6JGY6xXC92LwrnHqTigc
X-Google-Smtp-Source: AGHT+IHoph10SuR7wzZ99Y0+vmv+LBir4pJxAUR6MH9uQmFdZ7MMYR7gqrRSubTDsTfbsxUBwj+/9g==
X-Received: by 2002:a17:907:9612:b0:ae3:d200:6dea with SMTP id a640c23a62f3a-ae6fbfa5a24mr447549666b.33.1752261499282;
        Fri, 11 Jul 2025 12:18:19 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4860sm335623666b.47.2025.07.11.12.18.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:18:18 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-611f74c1837so1513537a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:18:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQI6viI3mLgaEsqUJvXIi4EIGDR2Ev/t+TCk+L7athFU3uXs9DiawtXy5mkLybjhYZtmKjiibtbn9gegE=@vger.kernel.org
X-Received: by 2002:a05:6402:11c7:b0:60b:fb2c:b789 with SMTP id
 4fb4d7f45d1cf-611e84907ddmr3562736a12.21.1752261497669; Fri, 11 Jul 2025
 12:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org> <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
In-Reply-To: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 12:18:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
X-Gm-Features: Ac12FXyQ_YSMvJEi4nfPYDndHOPluuiAs0LoNS1cD3a_Bb9k_MZNqvkWl-g86Aw
Message-ID: <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 11:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will do more testing.

Bah. What I thought was a "reliable hang" isn't actually that at all.
It ends up still being very random indeed.

That said, I do think it's related to this netlink issue, because the
symptoms end up being random delays.

I've seen it at boot before even logging in (I saw that twice in a row
after the latest networking pull, which is why I thought it was
reliable).

But the much more common situation is that some random gnome app ends
up hanging and then timing out.

Sometimes it's gnome-shell itself, so when I log in nothing happens,
and then after a 30s timeout gnome-shell times out and I get back the
login window.

That was what I *thought* was the common failure case, but it turns
out that I've now several times seen just random other applications
having that issue. This boot, for example, things "worked", except
starting gnome-terminal took a long time, and then I get a random
crash report for gsd-screensaver-proxy.

The backtrace for that was

  g_bus_get_sync ->
    initable_init ->
      g_data_input_stream_read_line ->
        g_buffered_input_stream_fill ->
          g_buffered_input_stream_real_fill ->
            g_input_stream_read ->
              g_socket_receive_with_timeout ->
                g_socket_condition_timed_wait ->
                  poll ->
                    __syscall_cancel

and I suspect these are all symptoms of the same thing.

My *guess* is that all of these things use a netlink socket, and
presumably it's the *other* end of the socket has filled up its
receive queue and is dropping packets as a result, and never
answering, so then - entirely randomly - depending on how overworked
things got, and which requests got dropped, some poor gnome process
never gets a reply and times out and the thing fails.

And sometimes the things that fail are not very critical (like some
gsd-screensaver-proxy) and I can log in happily. And sometimes they
are rather more critical and nothing works.

Anyway, because it's so damn random, it's neither bisectable nor easy
to know when something is "fixed".

I spent several hours yesterday chasing all the wrong things (because
I thought it was in drm), and often thought "Oh, that fixed it". Only
to then realize that nope, the problem still happens.

I will test the reverts. Several times.

             Linus

