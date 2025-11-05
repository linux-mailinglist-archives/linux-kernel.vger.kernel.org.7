Return-Path: <linux-kernel+bounces-887071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E94C37306
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB72D4FC50E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303E33B6EA;
	Wed,  5 Nov 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J40xNsLy"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30878337BA6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364685; cv=none; b=pyoc1lqqjjWyqfkfqtrmgx+ftWqpMH/jZVVloLFhW4XnSHWIenF4qQsCrG2ov/pTc6auO3FyDdmh8S49Hx9/ZS+g3cR1obvFZVIaoeeesucnikaqIruONzjNjIVsKj3N/S4XnGqwpEcTeK3s4nbj5MCp+HldhMP9+L1aHCGCcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364685; c=relaxed/simple;
	bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZgIQwYAobLC1C8fuBQcwrSa49SsQvokibKPRj7ESD5I/FJAQxfZBZTexMnicR/cdXFof9n6MHSbthfbiyacfqIWAnXssOiFYCHfLnGRiaO0/PNtmXUQc76i5pgl5Jj4z46FfCgvci1TbdrU26L03FKKAVJDDKqT3RbUb3MA8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J40xNsLy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-58b027beea6so21e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762364681; x=1762969481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=J40xNsLy/P3FH9ngX86nNzMKjkxfEccbIIBTI/ybiGLyBW/jbl4CuEQp0x2CEK7Anh
         3uaBzM2wz+AgVij7CWDHh4YOyKQj02OPu4ge/KnsIJPWcnoTxMjei28fxOFOVrPxjWvd
         1tsO0kv+ctxdr6SunZ/lhvTbcURPGC788zVeRY4lQsSuYXHJ9iUN6opOL5ICAYUO/u0/
         1drGwyuHnmJ3a9TiajQU/83cLDH1sNIfLkvKbDD9p1RNkj+GzEetgot9O2J6sntLO1Qw
         FmC6b/idfm9ycZYIVoxDBi6DuCBOaSEYienFsiRgDFUNAS/7FgzWc/eO5VyazcBTXkFL
         5yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364681; x=1762969481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUkuOvaJBgzglKmoQ0+qkvFukOe5dDQ3E3jps5qH8yg=;
        b=khUaVJorhaF7lyssX3gPvvUaYg0RX1RZu32wsG/7dXiGdKtsq4jLg6p+XeeW69doTy
         lqAdDOgAGmjhI471Wbv9jXLr4/3wZnZx3gnuIVKDtcOM+I+cH6oUSwxdMJdgU6T9/Lx0
         z+zdIZox59i3FXH1vHUna91nJhno7Q0bPCvbu1uyqIzsUKeBTRevscxrEzaofxI1dRwo
         DoIje2It7C2aujXqy31rkWU4GGZb/gBENoyafmbyhfsVnFPV5FRef4hCj72tI3X2Z3R1
         DkJvLqkgfAR5cnJIfXWiCGrJXuOqEGctcG1G7pjEduUGg0eP1V8uopz73aXcKjf40qJn
         j2UA==
X-Forwarded-Encrypted: i=1; AJvYcCXY1aCTycMOnOEUKWTwNO8g2jnt6f/FmG62fvwu/DrgC1h2m/WiZEg01OqXJVAjUiZDmyP2KksGrTr7SAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzsMEqTR1ED8d3YSBuHNrjL8JWp+QSfNK0LwczYfLSZ1nnYlO
	HSIV/mLUJijSwxCvRiNIpzHGPuQPvLleYe8UFhrXS+fNQ/K7VoDy8JPAPvMDPweLaRdOb3mFZTj
	HECqGIj17fH6GwpLGFiogOLS4v4jgglE18jlmpo++
X-Gm-Gg: ASbGncvWTXhamaaAqclkmG4oxnOWICDLhiLT0XbPkEBxi3mt9KLvmq29K7pqJSe6fEw
	CWbNm+r+tkFTpcxEglJP10HbratYl2GoTLOtwHHmUPD9bszJTCRB6crBYLMSxkeyXL546zzMh2f
	L+EjowYvtYGHQUzcHRSH4Gfpmwi+SyrUfxXJc/1tzW0E9e+S3FC0BgzNw7VI5vtddZ5ABfCSSkW
	qSVvpeZluVEJEuPClsnh3h2spKDcCwzZkhQxfgLH4apVKCJI30eOyv7dY/iDECkry+jXIpjtqiQ
	9TdbLkaV0KXOeL8=
X-Google-Smtp-Source: AGHT+IH/OofWVZO6t+ABXcpC0vTR/s1RGUpbRd9qbTsriVnGknn3XRKBHSzmxdu2/OyTuJYhBxIZQv2+pBEj17RuTlQ=
X-Received: by 2002:a05:6512:5ce:b0:594:2644:95c6 with SMTP id
 2adb3069b0e04-5943fd37dd8mr299460e87.7.1762364680964; Wed, 05 Nov 2025
 09:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
In-Reply-To: <aQuKi535hyWMLBX4@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 09:44:28 -0800
X-Gm-Features: AWmQ_bmalEOFVEMViz4jCYnQSNwi-DTRPOf8GHyJIDjQOr0wbo_hnqMUoM5NhB8
Message-ID: <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document SO_DEVMEM_AUTORELEASE
 socket option
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:34=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 11/04, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
>
> [..]
>
> > +Autorelease Control
> > +~~~~~~~~~~~~~~~~~~~
>
> Have you considered an option to have this flag on the dmabuf binding
> itself? This will let us keep everything in ynl and not add a new socket
> option. I think also semantically, this is a property of the binding
> and not the socket? (not sure what's gonna happen if we have
> autorelease=3Don and autorelease=3Doff sockets receiving to the same
> dmabuf)

I think this thread (and maybe other comments on that patch) is the
context that missed your inbox:

https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.co=
m/

Let us know if you disagree.

--=20
Thanks,
Mina

