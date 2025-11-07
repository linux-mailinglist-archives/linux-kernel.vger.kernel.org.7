Return-Path: <linux-kernel+bounces-890903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F6C4157F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7186E3AFA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8E33B6EC;
	Fri,  7 Nov 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZHCfa2k"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A425783C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541581; cv=none; b=MhrrjHja1hNf6iUn6U6pDfT72nLiLarPcN9IvRAVURIX0/gozoZGuKgmeL3fIdL4p6K5eSyfHz/TXhtILYvFlzE34CiU3EbFYvhn2zA9N5JHIp7Wf1q7osHpsLVtGc/FKw9FfMyzK9dVJ82PTy/aL/mhFXQGRKuoKGFuq4adfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541581; c=relaxed/simple;
	bh=vxXA3LK9/AfbF+SDVghSO7WvhVaphHP2+bqSpYUMEVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3Z9KX7t8pAuR9T5AU446ZdbBTYBEPaZX/L8L6V5e5DB+oXQW58Nx5yxgkQR+4SYc2w8216Qpc3itIx6M5o2QYkoZ8vdEArDS8WUvlomnut2/qWvgakFC9E1dmH5ooHwpPJfxwAdt60Dq/e59QspNYeD9O2ou03tsCQDqUUe85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZHCfa2k; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso1116900e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541578; x=1763146378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hon46fvN5MaciwaNZYrtLZsDUBr0nJ8uArIkh0dKSPk=;
        b=fZHCfa2kYM+CIih2gJ8RUZOCneO42yDIB+w7AtVHVDohgWFVtCM6R7Q4SGlf9tzaWY
         cC4BBekNUuJvqwnsfYSG269RTdu1LH8apynh5lhrroM2Rd5yBUl+ntwNp0M92U0FVMVw
         SmstcivpJRyb5UNAPGp8tCRhiA7HvIYY3y++G1tA8Ys0M088TtO7xpwOTAQ7hBqP85gi
         /UiIOZrMsT7KGzzt763fSsYCQCz6Nd3KBVfnZ45jNPH1/9JIA3Nravh9TKEenf6SQb0h
         7iGHUOFq5zoPpY0r0v5T2ojOmEgKTjBJxDj9uYHEDgsolGQepdtJdc5X36+N1qIpK1Gc
         Idyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541578; x=1763146378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hon46fvN5MaciwaNZYrtLZsDUBr0nJ8uArIkh0dKSPk=;
        b=xEnblMx5rEXiKrqAX0CUbAWdP42cS1/Rn8FUNIrpPteuJAr5Ix+pJ6WK5D9i+0Ufjc
         24qXLzQcrmnO5rYHeNwrv7zc9DkhYhKoio1nYtx5aKprq6CaS0Y9dzFd8jDe7sZo401R
         WaXHrJ147t2Vt1jRGh3wbXW+Fgd6VSG38r0wZSFmB4Gwto4QJoTeYcaKC2DHfQOQu+0p
         gFm5FrJyJ1t9varO5Tk83siTXXTtIlkuEv5GCAW2kxHSSObv0QFQg0CS95s7g5lMxtzt
         iFTccLCMCM8tzcgfoAO4dcD1cXBZCZUTUU04lsrwADBBb6xnH581RE18O1GB08FUhKjO
         Z26g==
X-Forwarded-Encrypted: i=1; AJvYcCWIm7/il2wZL4B7y+LYUz86iYMjRYVjA9ujqps8Ns//eB73yxblSxFYYX1gnXwoDFnupz52pMC7urjsaDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybuua7D370BFtcWojwKwXgm1HLf8v/HtnoSlgL4kvIN6/0yspC
	UHlGr7Xf22uLD+HYjOzFeiOuliCCyrlk+0cjr/BEioi/L5tHVxZX4aWRyPeMd+02VEz4CUFd3Yi
	M3SadqMriQqnUq3/5t3pvdf7MAllRIr4=
X-Gm-Gg: ASbGncupw1Agm4yAu1LP3K3ER95wATlxaYT3BIn8q+GIi/CJwOZeCcNrmMiHuu/ocJz
	6xm3zYKEmpMv+8BRC8ghNtHErSHPvjYDZksTbBS8zHgfKnjxVADM8ROB+LbuelJCCcHFqEIcKko
	rOHEdK+P/LLfcp2gSOjjHCaCJ2JqrNAX3IOqAFkiEGSUFstiOaSAA26LClcXQQl+IPXhTa77acB
	k+plguJ94/B6G7swb8krSxytcELTLvMx8NrCCQr0PWYWXsnjCJEAKX7vSo=
X-Google-Smtp-Source: AGHT+IFA6zfGpW3e2YRQJkcD06Bw5q7iH/apEoGfim8pJL2ZY94sZ4nvjnUySTqDFSdWvXYxiMu04t/6b8hxtsXSTnE=
X-Received: by 2002:a05:6512:1149:b0:57b:7c83:d33b with SMTP id
 2adb3069b0e04-5945f1e568bmr53063e87.47.1762541578130; Fri, 07 Nov 2025
 10:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
 <c6f8f015-267f-49e8-b427-b4524c134bfb@molgen.mpg.de> <0aa28372-feea-4252-a498-b3b8be7617f4@amlogic.com>
In-Reply-To: <0aa28372-feea-4252-a498-b3b8be7617f4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Nov 2025 13:52:45 -0500
X-Gm-Features: AWmQ_bmVM3rzEtih8fwMPwUDpjsoajbHrK5YOwQNdL46Zr1W4bSBB3i_tzQOiGo
Message-ID: <CABBYNZKQPBaxmxzDttOKumMaReycbSAbc-JM2P0mwzy=d-kbkw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: iso: Fix UAF on iso_sock_disconn
To: Yang Li <yang.li@amlogic.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Nov 5, 2025 at 9:21=E2=80=AFPM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi Paul,
>
>
> > [ EXTERNAL EMAIL ]
> >
> > Dear Yang,
> >
> >
> > Thank you for your patch.
> >
> > Am 05.11.25 um 10:02 schrieb Yang Li via B4 Relay:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> kernel panic: Unable to handle kernel read from unreadable
> >> memory at virtual address 00000000000003d8
> >
> > No line break needed in pasted logs.
> >
> >>
> >> Call trace:
> >>   iso_sock_disconn+0x110/0x1c8
> >>   __iso_sock_close+0x50/0x164
> >>   iso_sock_release+0x48/0xf0
> >>   __sock_release+0x40/0xb4
> >>   sock_close+0x18/0x28
> >>   __fput+0xd8/0x28c
> >>   __fput_sync+0x50/0x5c
> >>   __arm64_sys_close+0x38/0x7c
> >>   invoke_syscall+0x48/0x118
> >>   el0_svc_common.constprop.0+0x40/0xe0
> >>   do_el0_svc_compat+0x1c/0x34
> >>   el0_svc_compat+0x30/0x88
> >>   el0t_32_sync_handler+0x90/0x140
> >>   el0t_32_sync+0x198/0x19c
> >
> > Please add a paragraph about this problem, and how `iso_pi(sk)->conn`
> > can be NULL.
>
>
> I will update it.
>
> Thanks!
>
> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   net/bluetooth/iso.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> >> index 74ec7d125c88..89c7700ceb81 100644
> >> --- a/net/bluetooth/iso.c
> >> +++ b/net/bluetooth/iso.c
> >> @@ -838,14 +838,14 @@ static void __iso_sock_close(struct sock *sk)
> >>       case BT_CONNECT:
> >>       case BT_CONNECTED:
> >>       case BT_CONFIG:
> >> -             if (iso_pi(sk)->conn->hcon)
> >> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon)
> >>                       iso_sock_disconn(sk);
> >>               else
> >>                       iso_chan_del(sk, ECONNRESET);
> >>               break;
> >>
> >>       case BT_CONNECT2:
> >> -             if (iso_pi(sk)->conn->hcon &&
> >> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
> >>                   (test_bit(HCI_CONN_PA_SYNC,
> >> &iso_pi(sk)->conn->hcon->flags) ||
> >>                   test_bit(HCI_CONN_PA_SYNC_FAILED,
> >> &iso_pi(sk)->conn->hcon->flags)))
> >>                       iso_sock_disconn(sk);

Hold on since the bug is actually in the handling of BIG Sync Lost, it
has been assuming that it also means PA Sync is lost as well when that
is inform byt its own event PA Sync Lost:

https://patchwork.kernel.org/project/bluetooth/patch/20251106230943.877242-=
2-luiz.dentz@gmail.com/

Also note that Ive changed the handling so it no longer calls
hci_conn_del without first calling hci_disconn_cfm, since the latter
actually informs the socket layers about the imminent deletion so the
socket can go ahead and clean up properly.

> > This diff looks fine.
> >
> >
> > Kind regards,
> >
> > Paul



--=20
Luiz Augusto von Dentz

