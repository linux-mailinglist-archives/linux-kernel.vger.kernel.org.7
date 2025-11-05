Return-Path: <linux-kernel+bounces-887476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB13C38538
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01BF3B0DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABF2F5324;
	Wed,  5 Nov 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWQQ1J6x"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10422D9ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384629; cv=none; b=KOUa+k2AKZXqPAWjCz2d1MUwa7ZrtEt3vGLNZmJEuX7OS0gI+xGB+aSvfbI6wL44yt0Mii3X+25KE9ioJnQCIAOMJO4AqXakjtK3tkOP5lHcVkRWCDQgTHbTfUlBH6NTE4G6jtw/w9VDfXZfNomzkiUIetflqpsFf7Dd1qw4e1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384629; c=relaxed/simple;
	bh=WMvrekpPCbw2lO6Uf+oSI/IovWgn+h5aIgixbccy4To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNZhieTzyOJR11mA28COdDyV9vVGXfyMVl8ImambGqB50WqzlSsVRO33nhnIdNtENbkKP2wgeyJVTyhW7a8drP/X6cLVo+18EgRYSTrxb3suGn1fDFxv7bHlZBU1hS0oaljZRuI80wpC3euWWodAr01iLWheJr2Hx2Dj9iiOteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWQQ1J6x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo442816b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762384627; x=1762989427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ifl5YAD6qLo3j4ucIccvW3+275rOUebLENMn+Nd9X+8=;
        b=LWQQ1J6xbKmCwFassRT+pe4S+s30eeYv0U/YGlW6gIjEf/vGdat5wdbPk4JpgYW0Hv
         ZvwxaMg+dD0MB0X7NBtcfmSyiaOTgzH3+azMdQHUDq64cC0HinoqBVzEzRW4F0wOdN76
         uF3o5dH1leUENq/m4qsNgDGsj4t+IAXgRpU5srShvyWkiblNKDSlQ98WVdr4HiOuNiP+
         ZSS2oVR86Zt31ARecgPYWxbA+4zh3R/UlAO8DSN2iEw5kj85YpfN6OGUq/tEz9lzrpZg
         p5jfTHlBFDiCkJuHStr9+HVKz/JSVAuRHO1O54Mdi/lSU/8+UqhocYxUel2D1VV+mvxM
         qGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384627; x=1762989427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifl5YAD6qLo3j4ucIccvW3+275rOUebLENMn+Nd9X+8=;
        b=UxkHUJWsfImMwuseJTtedYT+YrrqyVAvPWUHEb+Jr5cxPA5OHbASiO+f2gSfT2Lyfb
         RlcGJBBY39npp1/5mOSPFe26xwvd9oNdBUVP9U3CuHwhTrXXv3q68t/77GC+PodDenwO
         U4ouP4ccJDGw+VgV5F4WKDPC6L0TTyMzmXijVUJ/A5R/BmczyKzpR9bJ/uINt/YMul2s
         PvXdvIQtFodjlpS43qN+k+Y1ktxHZkKjW5hYg6FtqUa1/CoMHezqDuKrlM7Sqsav+Klf
         leRq4UuHWMbR1CKLyGIGcG1W3Jzwbq2vmYfMtjQW0K1+7DEoSyCjVk4Rmwb7I/DquePy
         bGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUrcjrpKAnwTZLl4c1uAGrgl/5ul0cLP19SjOuHoE1ivn5KuF9V22UHbfEqyyzJjqpgSYOEh/3Yf33vfqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33gtCt6Bh89/IiRu+kLHnC2zD0kKeJAGgxZyxBRhOrpjB3Ktz
	JjfzbdGTlKb0hsWuUHGCPWzCUz7VbT/x8+njQVL0hJRbkAZXQpZPzfA=
X-Gm-Gg: ASbGncuCX/1TYgi4bT4D5MqWYmOp7s9JSWWF2cU0OiIg7zkBP+8EgkISER/mTxu0zyk
	ABCucJ9CmXlSN8MeTfQN0tI6Bn8JLm/SHI5/0wNPiksqd9fyjfqxp1VfrjgTS/bSObgacnbQEOt
	HvVYAnIsHRKU4Cj0kjk0kWSbMfQ3e4+OsHZPVbqp3ntZ+DIcEDa79e+fU1Mhn645MSsDwMDcbE3
	H0xoBK25ZGhl9kEsNT7P0zGpHT+TI0mJxSgUhADpqIv7wcizoDnXXIP0RQkMpLKsfQG4r8Oo3RR
	BIXJ1AtpWUY4LIB79ou4r82dsj9GJoZoiUTObO48VzB2MhFZzymOBjBjo9wXoip979MJo+7HePy
	bw8hlaAwHkScHmuicIdolpZmyP8hCIwbaKzMvC/JVdv7J+6WBVXawY7gh/ioufxsjiX1TdBP+ig
	S+OgVQLX/yfkCsVCESRCJY82vH18zqZwJOkQcuFE/vJ6tLnt4DZcb5SavSHfYkE8QtJLFxoQQcG
	JXHiusXTBh+FEJZYjVuZ38oRhvD0emfKNQ165lvXqGv3+7ZFqO5Ho3T
X-Google-Smtp-Source: AGHT+IEroDXv/s12OnxuxUiI5O9ZkRDWKJ27KuhHefG4WvDrZ9EhDglR9rBCbFC1jc+d0xM1TFbisw==
X-Received: by 2002:a05:6a20:94cb:b0:33e:561b:fb22 with SMTP id adf61e73a8af0-34f868ed090mr6455660637.50.1762384627202;
        Wed, 05 Nov 2025 15:17:07 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7c4115a9sm603995b3a.0.2025.11.05.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:17:06 -0800 (PST)
Date: Wed, 5 Nov 2025 15:17:06 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQva8v22RVQEgPi_@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
 <aQumHEL6GgxsPQEM@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQumHEL6GgxsPQEM@mini-arch>

On 11/05, Stanislav Fomichev wrote:
> On 11/05, Mina Almasry wrote:
> > On Wed, Nov 5, 2025 at 9:34 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > >
> > > On 11/04, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > >
> > > [..]
> > >
> > > > +Autorelease Control
> > > > +~~~~~~~~~~~~~~~~~~~
> > >
> > > Have you considered an option to have this flag on the dmabuf binding
> > > itself? This will let us keep everything in ynl and not add a new socket
> > > option. I think also semantically, this is a property of the binding
> > > and not the socket? (not sure what's gonna happen if we have
> > > autorelease=on and autorelease=off sockets receiving to the same
> > > dmabuf)
> > 
> > I think this thread (and maybe other comments on that patch) is the
> > context that missed your inbox:
> > 
> > https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.com/
> > 
> > Let us know if you disagree.
> 
> Thanks, I did miss that whole v5 because I was OOO, let me take a look!

Thank you for the context!

I think that the current approach is ok, we can go with that, but I
wonder whether we can simplify things a bit? What if we prohibit the
co-existence of autorelease=on and autorelease=off sockets on the
system? The first binding basically locks the kernel path into one way or
the other (presumably by using static-branch) and prohibits new bindings
that use a different mode. It will let us still keep the mode on the binding
and will help us not think about the co-existance (we can also still keep
things like one-dmabuf-per-socket restrictions in the new mode, etc).

I think for you, Mina, this should still work? You have a knob to go back
to the old mode if needed. At the same time, we keep the UAPI surface
smaller and keep the path more simple. Ideally, we can also deprecate
the old mode at some point (if you manage to successfully migrate of
course). WDYT?

