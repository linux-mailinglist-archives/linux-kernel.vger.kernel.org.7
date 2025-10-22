Return-Path: <linux-kernel+bounces-864319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480BBFA831
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072883BC303
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95B2F4A04;
	Wed, 22 Oct 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbKSnHJn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53452F3C27
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117748; cv=none; b=LXof2aKfaHoVPJc3i0VgrlOqv7WiuYpwZRrRndyHXAKFKYzMBXABs061nUVc8rbcBBG2iLPJj0cKcGUfitkoqpCjlB3LBw6EGIxC+zX6WHbsfBlXVOTM5CtHOEEa9Isx+VV+DL4QWgCzUuFjAoG5o49ArUqgqDD0nQv7lnq0gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117748; c=relaxed/simple;
	bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iq3E5MVCuDFwM+wun7i0Imfqn1XYhRQiy0uCLCLJYTHRwCigyIqyWYd2PPClZ8C/NclNQ9DrbIqRHKdfKl+RuzWXfpsOMJvz2uPhxG1dwcwl6ygGiJsWGiRQ7p/UmhKi3LcKOWWu8f5skURuG7wVfTwog+vqJEiT1BZxqy3VXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbKSnHJn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290c2b6a6c2so60422115ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761117746; x=1761722546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
        b=sbKSnHJnGdnh+SChtyk2b/0waFj4rbMcqOv4ob03KHBOzUErCS4Bn3r1oF0OZBIRWV
         IKzKO7IrmChUpAXw+N8CYcCIKP4X5DzySIglYxMovlWcuTkByG5AZj4pXSxM/cTk32JT
         v/UjqrlTFvvK3IyNGByKQR/UdTXv5UOO440oqI6fcXsU1dFpNzWMRSGcDklEsMwpNDRC
         OdxGa0mksyoxyAupeIgNxQe5/nReB+PpBpnNsJw/OJDoctvGvimAWTPMuwgj52Lg/Buy
         NMeh5cXxKMhFS1xcQa2g7mprNs+WpcRpA1xi9/J12lTiEsqExqboyTYGRsE3+UXmAD/+
         g7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117746; x=1761722546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwvetbWdKUMVFU6QjT4CxeRWEq57eDBbx7k02Vd8Xwg=;
        b=gNQPjZ/gTzNs3zeP6r8/SYCrZq9PNs1CNDKCLFjdwwzam9YLn+d1Hp9OngzBJMIg64
         7Lj1dt2a9241MEKIUCxbIKG6y/VHJ3BQQaDPGDeWfhulrQQnERVhoDpW/Ck5xoUQOSzp
         U/zhIdufbyFXAD8gOcF0Gpv2lDpbmOKqRG9latbSG+2C2wyan1AmBV+Rv258EKbfqtxa
         VcvJb1raloJWCwVYIUtFEL0nm1oC0rJ/8MBRSJsdy+cdTwmQY9Jz0xxpyBjzii5uHceG
         HwE62lgnfQrcuDppAz/wszZ9VTw6DZ4ue0YrJqeOeje8c6zEs9qODIm6+CJaZWakl91M
         xUYg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2WrBjpFq4oXneEa1OtVeipj3XYdpRj3ekAtPi0IydmrRJBvurgwIy/NuV8l6zmXjysfsFeDgzER1yL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARRbdFTiNXdjGekT/or7jRpTGJutg8WhdQW/T6HxnGG1uZ4ZT
	H2xt5FvxhwjDJ8Ib+jegLKXeHi3LlrgZTTFNLOviCfD+yMjS85JbzYBw7Xi5cZZ0FQuuLM3jZdo
	WBTDPUpEAF5PI/TNCBEdVpCy7v0Nz1MgNlhPJ9iQl
X-Gm-Gg: ASbGncsvRfHTUAe24T1yDHl3phXZ1wVR+gNyMklJWuB0T7hyToQm6pw8UEjA0hpf6Qh
	EHwvKb7Fdl88SsD7NiuFj3R3Wxp+dCBxF/iGcA+7RMHe/+0zT64Q1ft3T1UgFiK1tTIxUHMXpiG
	vOX3oOkr9L+cWYuSxmqqNtpj85g3/ngeiHWGW3idQqcAuq5Gbbh9ryeDvU6Qh119gT6uxpgPo19
	hrYEAlXnpiO4X5EWeGYVc7OqzjrnjsWBvUDweVzQ2YkeswQEix+HfC+E1ojYSLzC0VZNRVuXget
	f4Hv4X/X4pIQoZ+hlQ==
X-Google-Smtp-Source: AGHT+IHFIZ0C34j+sahAzN6WmAzcBj8zZCC8xVi4muVmwKBX9i9JtWfdmefM51LsQSvwB9xwcIwZOiFOi/DKJceh1yw=
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-290c9cc30b8mr247581035ad.21.1761117745989; Wed, 22 Oct 2025
 00:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021195906.20389-1-adelodunolaoluwa.ref@yahoo.com> <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 00:22:14 -0700
X-Gm-Features: AS18NWDYOZ-Ja2ju3PTAqCAsY0yiy5CA_MHH0MVY47CpxTMi1dFAZm_Pu3fijwA
Message-ID: <CAAVpQUCqiTUQM6gfFE_qps19vcsE12QsMifzqPc19M_2arWtsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: unix: remove outdated BSD behavior comment in unix_release_sock()
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:59=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Remove the long-standing comment in unix_release_sock() that described a
> behavioral difference between Linux and BSD regarding when ECONNRESET is
> sent to connected UNIX sockets upon closure.
>
> As confirmed by testing on macOS (similar to BSD behavior), ECONNRESET

I tested on FreeBSD and the behaviour was the same with macOS.

---8<---
$ qemu-system-x86_64 -drive file=3DFreeBSD-14.3-RELEASE-amd64.qcow2 \
-enable-kvm -cpu host -serial mon:stdio -nographic
...
root@freebsd:~ # uname -r
14.3-RELEASE
root@freebsd:~ # python a.py
test 1
b'hello'
b''
test 2
b''
b''
test 3
[Errno 54] Connection reset by peer
---8<---

> is only observed for SOCK_DGRAM sockets, not for SOCK_STREAM. Meanwhile,
> Linux already returns ECONNRESET in cases where a socket is closed with
> unread data or is not yet accept()ed. This means the previous comment no
> longer accurately describes current behavior and is misleading.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>

The comment is outdated anyway, so

Link: https://lore.kernel.org/netdev/20251018235325.897059-1-kuniyu@google.=
com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

