Return-Path: <linux-kernel+bounces-752716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85946B17A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8317A8FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5828934A;
	Thu, 31 Jul 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utqVJN6C"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507218D643
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005083; cv=none; b=nzMIvWK6izKrEnuMSUSSw/oaJN10hEGNDV5CHcVCgPnRQ+9A5GJz3uG4ZNSR4UWahUGK04Sj75wDIpkXxXOgB6593rPyUoG738iWpDvVPOIC9AtmSkYDZZAdaQ2sG4ybaPhqPJblN63OWcGTDBnJ068wZHQQEPxeBHJdZZt6V2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005083; c=relaxed/simple;
	bh=f6qUX6gGho971LALBNjFf8VqlKQhpBsP6YCT1TMXfg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIYzGV+lrWVMMDqnVJF6hqFHTOHHJNZzbbbW06eF15MKdISmGM+WZ5P67GMxI5hLTRZQJDIcx9QT6f/Tt6eT+z0GSzGQksgSd2xf8nqLBg4mZoa60/k+vYF2HPYbIFJrgqAKPqlZyLIFV2KJ1nllUCrYwB8LI63XiSU9REVA1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utqVJN6C; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b421b70f986so1326423a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754005081; x=1754609881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGJHRsg5iCjQoTSgwUklPXzEBYJzmQNlQF6qaBtA8NE=;
        b=utqVJN6CGmDyw/nRBnDsno2DQ1sossv5Vq675xHC2mo1uV53fwgWLsz2+ODVT1nW8P
         oVpDE0RSBQicxoMuyZDT68mIJVPlMrlVPhw0tXJK/Gz84qn5eCn5TfVRBWVF8Dc6SX3V
         yLz797DRNP+kioQMCmMC8GvLjD8ERAztlhu/mDKtue/g8CITjLPetJM37OcMu6r6XIaV
         V+x8S4Bd2519bU78Dpdr4//08EuMOimB1WAHmWPFcd1SdqKQjxoH+t0TLDpga4xclUq2
         6c6h5r+PtNFj4yBiucMA+1xx2B/urQtzTp/WpSCt3wN1/kfGjD1tzjZazSf0w63/nGYD
         ZjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005081; x=1754609881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGJHRsg5iCjQoTSgwUklPXzEBYJzmQNlQF6qaBtA8NE=;
        b=dE6QeFLraXQaVmAX7xgflUyoNh7E5PeqMo57y0J3OpYR8N7Zz3uv9gn0xdi7YJGCOF
         dy/KpausU9dHPEt5mS8TIVdFyFPcii+4+kqSAxR5zkx1hqN9yo7Pcs/Y96TqTg1q5bqQ
         rPHuUlzmFXMU2L3xC1LwICs7SsJlvbWsIm6zZ53m7x3yoA0shzxTDP6CTqv8IN4I9NGQ
         RENON+renYhvcCs4B0OVuT5qSvsEDtANoDLytswYiAO8/5mIm2nJyK3tG/vKMatEjx8F
         j+8VmvS6ta+7rjwadORqvyXtOFuvoZ2+AGlii3o0p4bDfKQe/pW1QudhiEfhrnf/ySHe
         zqdg==
X-Forwarded-Encrypted: i=1; AJvYcCW5GA9be4Ed/38l7ihwOcUY0bZfGCMita/Md+bWvEw6LCLgvb4jf4eUPC677w7bkT4mwDopUEDsMg6DoL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvctQB0UZJ8flctN6Yp5ixKmqM6cD6uxvTuq45X9LcQ0VQwQNE
	f6EgZBUAi29L1sk6LiKCXNip3llBIvWbqwhC9P+qkfFj6nUfDN54zCYUHTNj7NFrPR7CVVYVIRv
	5C5oX6cbIpy5/S2S8+WRxvJ2rT5Jh92aH9+LYNT2w
X-Gm-Gg: ASbGnctRkw/+Ho8xuL1Yn+AjA4GDLcBjD1XmT/nVYcWpi/0K8FDezx1JSgp0ucKaA7P
	PTFCVbPhZPqG/xXzo+3Zq1YYZ6hVnw+dq16SE7E8EL2ic1lFiWyg49cH/Uf51/hxYHzjhmZrmZZ
	As1lsxJ8AyHezNr7OSYRswjqvucPJ2EPRhw4LQT7qAkobDtH4PXoefFVPF3zWhxwByq53RCU+1a
	2bxqEqGhX92akZdRyRlBLHeUNIEd3VXdNZr4g==
X-Google-Smtp-Source: AGHT+IH3+rIwn54Da+ICd4tBOgXwOPHz3yPdEo3e4muMjMz3VkS8jC3tBS6JachPLqAkDX8B7TTY0RFSnjFHVKtvw6Q=
X-Received: by 2002:a17:90a:d404:b0:31e:3d06:739c with SMTP id
 98e67ed59e1d1-31f5de85bbbmr12557172a91.31.1754005080821; Thu, 31 Jul 2025
 16:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-no-abstract-v1-1-a4e6e23521a3@gmail.com>
In-Reply-To: <20250731-no-abstract-v1-1-a4e6e23521a3@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 31 Jul 2025 16:37:49 -0700
X-Gm-Features: Ac12FXw-uBDMi0rpYeSk4vgpVGnOIW87IPuefoui5ML0xX5hXHN7zoUervKq4fU
Message-ID: <CAAVpQUCLoYa8YbaPSMHJcFQarz9hMo6-BQ1OJiF+GwcF5bb6hQ@mail.gmail.com>
Subject: Re: [PATCH RFC net] af_unix: allow disabling connections to abstract sockets
To: demiobenour@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 4:03=E2=80=AFPM Demi Marie Obenour via B4 Relay
<devnull+demiobenour.gmail.com@kernel.org> wrote:
>
> From: Demi Marie Obenour <demiobenour@gmail.com>
>
> Abstract sockets have been a security risk in the past.  Since they
> aren't associated with filesystem paths, they bypass all filesystem
> access controls.  This means that they can allow file descriptors to be
> passed out of sandboxes that do not allow connecting to named sockets.

I just thought that what's you need is unshare(CLONE_NEWNET)

and started reading this...
https://labs.snyk.io/resources/nixos-deep-dive/

and stopped reading here.

---8<---
Nix builds offer a second, slightly less restrictive type of sandbox
for use in =E2=80=98Fixed output derivations=E2=80=99. These build types ar=
e expected
to retrieve files from the internet (for example, cloning a git repository
for later building); as such, they are not isolated in a network namespace
and are instead in the main network namespace ...
---8<---

The 2nd thought is you just need CLONE_NEWNET and proper
setup to connect two netns.


> On systems using the Nix daemon, this allowed privilege escalation to
> root, and fixing the bug required Nix to use a complete user-mode
> network stack.  Furthermore, anyone can bind to any abstract socket
> path, so anyone connecting to an abstract socket has no idea who they
> are connecting to.
>
> This allows disabling the security hole by preventing all connections to
> abstract sockets.  For compatibility, it is still possible to bind to
> abstract socket paths, but such sockets will never receive any
> connections or datagrams.
>
> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> ---
>  net/unix/Kconfig   | 12 ++++++++++++
>  net/unix/af_unix.c | 18 +++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/net/unix/Kconfig b/net/unix/Kconfig
> index 6f1783c1659b81c3c3c89cb7634a9ce780144f26..c34f222f21b097ce4a735ce02=
d8ce11fc71bde19 100644
> --- a/net/unix/Kconfig
> +++ b/net/unix/Kconfig
> @@ -16,6 +16,18 @@ config UNIX
>
>           Say Y unless you know what you are doing.
>
> +config UNIX_ABSTRACT
> +       bool "UNIX: abstract sockets"
> +       depends on UNIX
> +       default y
> +       help
> +         Support for "abstract" sockets (those not bound to a path).
> +         These have been used in the past, but they can also represent
> +         a security risk because anyone can bind to any abstract
> +         socket.  If you disable this option, programs can still bind
> +         to abstract sockets, but any attempt to connect to one fails
> +         with -ECONNREFUSED.
> +
>  config AF_UNIX_OOB
>         bool "UNIX: out-of-bound messages"
>         depends on UNIX
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 52b155123985a18632fc12dc986150e38f2fee70..81d55849dac58e4e68c28ed03=
a9bc978777cfe4f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -332,7 +332,8 @@ static inline void unix_release_addr(struct unix_addr=
ess *addr)
>   *             - if started by zero, it is abstract name.
>   */
>
> -static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len)
> +static int unix_validate_addr(struct sockaddr_un *sunaddr, int addr_len,
> +                             bool bind)
>  {
>         if (addr_len <=3D offsetof(struct sockaddr_un, sun_path) ||
>             addr_len > sizeof(*sunaddr))
> @@ -341,6 +342,9 @@ static int unix_validate_addr(struct sockaddr_un *sun=
addr, int addr_len)
>         if (sunaddr->sun_family !=3D AF_UNIX)
>                 return -EINVAL;
>
> +       if (!bind && !IS_ENABLED(CONFIG_UNIX_ABSTRACT) && !sunaddr->sun_p=
ath[0])
> +               return -ECONNREFUSED; /* pretend nobody is listening */
> +
>         return 0;
>  }
>
> @@ -1253,6 +1257,8 @@ static struct sock *unix_find_other(struct net *net=
,
>
>         if (sunaddr->sun_path[0])
>                 sk =3D unix_find_bsd(sunaddr, addr_len, type, flags);
> +       else if (!IS_ENABLED(CONFIG_UNIX_ABSTRACT))
> +               sk =3D ERR_PTR(-EPERM);
>         else
>                 sk =3D unix_find_abstract(net, sunaddr, addr_len, type);
>
> @@ -1444,7 +1450,7 @@ static int unix_bind(struct socket *sock, struct so=
ckaddr *uaddr, int addr_len)
>             sunaddr->sun_family =3D=3D AF_UNIX)
>                 return unix_autobind(sk);
>
> -       err =3D unix_validate_addr(sunaddr, addr_len);
> +       err =3D unix_validate_addr(sunaddr, addr_len, true);
>         if (err)
>                 return err;
>
> @@ -1493,7 +1499,7 @@ static int unix_dgram_connect(struct socket *sock, =
struct sockaddr *addr,
>                 goto out;
>
>         if (addr->sa_family !=3D AF_UNSPEC) {
> -               err =3D unix_validate_addr(sunaddr, alen);
> +               err =3D unix_validate_addr(sunaddr, alen, false);
>                 if (err)
>                         goto out;
>
> @@ -1612,7 +1618,7 @@ static int unix_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
>         long timeo;
>         int err;
>
> -       err =3D unix_validate_addr(sunaddr, addr_len);
> +       err =3D unix_validate_addr(sunaddr, addr_len, false);
>         if (err)
>                 goto out;
>
> @@ -2048,7 +2054,9 @@ static int unix_dgram_sendmsg(struct socket *sock, =
struct msghdr *msg,
>         }
>
>         if (msg->msg_namelen) {
> -               err =3D unix_validate_addr(msg->msg_name, msg->msg_namele=
n);
> +               err =3D unix_validate_addr(msg->msg_name,
> +                                        msg->msg_namelen,
> +                                        false);
>                 if (err)
>                         goto out;
>
>
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250731-no-abstract-6672e8ad03e1
>
> Best regards,
> --
> Demi Marie Obenour <demiobenour@gmail.com>
>
>

