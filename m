Return-Path: <linux-kernel+bounces-874524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88FC1682E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47C5505ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78B34EEE6;
	Tue, 28 Oct 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnBPq+XD"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1789345727
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676432; cv=none; b=SQtzjE5SFDh2QAzHbrWPv3FEc+Zd04mNqsgFl68xZXDcDbvJZgimMGhclnTW23vPqqv99vKRy670QL4oGPUIdjsXNaTgjBQKjHoDfhUouOzYKCdZpl9naSxZG6dZb9kSUSqKbF60PWvBysCzCwbHQZ+hwfhFCPg64Sc7NbZMc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676432; c=relaxed/simple;
	bh=N8rKAtjbv6LE141WmroC0g0cbpM5XEtFR0xQakQ9+3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLcupXzX37kNjrr6tlTltzjhSkDaI5yCJ0cnHp3dq2xqP2W7IDcoQOhHsY8tET5WOOG9sUHH4k/NlNWKykKspxhYoW0xi3jrKG50QV1lYEMPjl7xtZnEi5ZR6YWI4LxhtkxDdUBhNA8xchvEFCh7jOYdG5L8DB9JVKG34TjH99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnBPq+XD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-785bf425f96so2835657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676429; x=1762281229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1XSltVjAzAnQ4Amthq/umVOWdJNZ6/4qr8PfcWtQ5I=;
        b=GnBPq+XDDp7PPoNxsucDdmcNDWW9GmoIkdMlbEE10ZuIMpilTsifEwJl8g3bxteoaG
         Og0h4XbAirQVaeRGc9VV8us2v/qaqKj0dcxo2d5SkTFnT02zynL+zq/ZKBN82sClhOJu
         3/tQWjXFCgBa24YkVcINfhoe1rnz62CvBO5LYa4NNKE5MzPEv2uWx7HgzoyD2SWbyOrx
         jXm7IgJnh2gk9s7TPH75g6gE3y0pnTn0xN2RTqIxOka9UnB42jwJe9/WW3Zfw1SOoNo3
         gfmPhr10hmz9CAvZMi8dcYPHgD71D0K+9/vpFe6W+hOduwYjbwIU0ITOZXPeDF05E6ZJ
         xWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676429; x=1762281229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1XSltVjAzAnQ4Amthq/umVOWdJNZ6/4qr8PfcWtQ5I=;
        b=kx6VOhUiUCuofFycsb69fAZs6WQ+WGU5Gl0ped5b0kUrnjugc2Hb0r29L1b99LzgT6
         kQLS13YY8G+piYVm8zPZSSl9H/S/fioiP4QY1tNkdPbNUY4rvhrgVnCaS+yY5LZ+Eeel
         +bCd1Ts1Q9VpKisFnC8sH30Glysf+r1y1fSRkQNmg5iXTV0dmD1a6nnyyxj1QQvlyYFt
         giWFdt2UcvFdBs/jH/wZRW7HMU01YGro/xKfLgehU690SU1cp1/HKtxplfEd5gGPjWAW
         pT23jKuHmyPZiwqW5zc9R/Sl2hvQrCIMTt5KdGcsDZj4muZ13+W8C3khnRthAOLiWHkz
         SAsA==
X-Forwarded-Encrypted: i=1; AJvYcCWNaZjCv0uOO7c+3Evi515An8G5fDQbZQchLUu7BzHAa/1nNtqVw5jUqSvkMoheHEfgxbAlo+3eDw/8ZhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTNEmcNZZugAqJYocj4NX/bkoqbDRvlPk8hq0C/zphNEB9FHi
	eCwr/tlJmAR+93FRZv+AX/zVH8xaFybKnwciU1SQaGFDFp5u2wGVjZUe
X-Gm-Gg: ASbGncuTUw29MdGhnTlNmy0BliZAAGJt9QV3EPj14sawXxJBQy4GkUd462OsRd2aVrH
	S98strWE6L2ubRxMUUKB6CBxAaLnj0CRjA65hlQLm9I10GHoL6euqmSR+IYPmUuzq1okjXeADtW
	pFJjlrsULWMWhbkzQkAOlVOYUSVmcPBHvpRHE/d/2P8/Xd2WOXS0v/DU9UrujtkG1w/63lh+JDt
	TGJdR+teg609G78ND7elqy6Ki9BnT+HnxnOQsaKZRA1t7GJttPXYY6feVZiuXPH+VkMuAjUUOpP
	j+Dl0qZFRZB7appAufEvOMOJCMxhOKzQlnCoGTmKK1M8LY6VzpZg54QvhJ83aGRQuqcuscgvRup
	uxLE8ZYua5fsRMmu63Nb1oNEDOWMeRW8t67X74VQxhHEbAnpAHghiXUk0Ehfz5flpdwJJIgdkuk
	0kSmseSGjM3TGWBHVwnFP2EcbFshsihuAfbK4j
X-Google-Smtp-Source: AGHT+IEttZ9BDz7ytrfWJAq7n0ugR4HwbpMEa8x1zfMG1He+winHmzAjdRiu+KVVA5WIcmY+KLnWfg==
X-Received: by 2002:a05:690e:124a:b0:63e:25e7:8098 with SMTP id 956f58d0204a3-63f77331a80mr208720d50.29.1761676428601;
        Tue, 28 Oct 2025 11:33:48 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4545a3sm3428991d50.22.2025.10.28.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:33:48 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:33:46 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 2/4] net: devmem: refactor
 sock_devmem_dontneed for autorelease split
Message-ID: <aQEMiuOlUutoi1iw@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-2-47cb85f5259e@meta.com>
 <CAHS8izNB6s97X8srfZQ1upUNOOx0vwj4Aa9gMUZvneoyefqdrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNB6s97X8srfZQ1upUNOOx0vwj4Aa9gMUZvneoyefqdrw@mail.gmail.com>

On Mon, Oct 27, 2025 at 05:36:35PM -0700, Mina Almasry wrote:
> On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Refactor sock_devmem_dontneed() in preparation for supporting both
> > autorelease and manual token release modes.
> >
> > Split the function into two parts:
> > - sock_devmem_dontneed(): handles input validation, token allocation,
> >   and copying from userspace
> > - sock_devmem_dontneed_autorelease(): performs the actual token release
> >   via xarray lookup and page pool put
> >
> > This separation allows a future commit to add a parallel
> > sock_devmem_dontneed_manual_release() function that uses a different
> > token tracking mechanism (per-niov reference counting) without
> > duplicating the input validation logic.
> >
> > The refactoring is purely mechanical with no functional change. Only
> > intended to minimize the noise in subsequent patches.
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 32 insertions(+), 20 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index a99132cc0965..e7b378753763 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> >  #define MAX_DONTNEED_FRAGS 1024
> >
> >  static noinline_for_stack int
> > -sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > +sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
> 
> Kind of a misnomer. This helper doesn't seem to autorelease, but
> really release the provided tokens, I guess. I would have
> sock_devmem_dontneed_tokens, but naming is hard :D
> 
> Either way, looks correct code move,
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Should we come up with a new name for "autorelease"? I was hoping to
find a name that could be consistent from the uAPI down into the token
handling code. Maybe "reap" is more clear than "release", since the real
difference is whether or not the kernel will reap leaked references on
close?

Maybe NETDEV_A_DMABUF_REAP_ON_CLOSE on the netlink side, and
sock_devmem_dontneed_tokens() and sock_devmem_dontneed_no_reap() here?

Best,
Bobby

