Return-Path: <linux-kernel+bounces-894851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7963C4C413
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2B03ACC30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030A2D6E55;
	Tue, 11 Nov 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpqBmyyB"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5715E8B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848198; cv=none; b=Adoc6SEY9Uw4RDnQVCpNC/Fj+sH5ccwLxvtw/kIIUsndBaDGtP52J1w2tJ6vps/i2WhfqGl9vn+p4MxXnDMsi5nYG4Qk3kCG3zr7C2OQeMw32wKq4h4i8eOjSXp5g/AsQYUo2YHBARi4QDNBcrnA6buhxwQmlSauhv+Ij/xC8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848198; c=relaxed/simple;
	bh=ThOitmR0pqJIaqOmdOvinYW0Io7CS1P5LLlQe5UDqLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhe5do8Eh7gapDVb2MS5J4GtZSQpWUjjzNzd+McIOdWXjPfn/QSNQO1IMx7Gf4Y1bB27yIXtfUvL8U8Vk0iCCjw4py/8iqV98GBqlb+kKNFkxFPkTPEn/pAU5sFu7EaJ0OauV+siVflncKSiIXO6bjDX6xHrDp4TQxxpATBKPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpqBmyyB; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63f74b43db8so3649508d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762848196; x=1763452996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZyrHQ2ZNrWsf8deWZQXT3ewHU4+uqpU/uLdHwVausY=;
        b=cpqBmyyBWMt1z9xyfQLvVg1q8h90DQZheaU5u2hSQS1PxJX739v/11ZcbPDt03LBFl
         FfF+EL2wfYqxUmDqA2RzXMSWUNsk8AHWb9OMttEx4ebpl7sEknh4PFvvZRhQogFTC5RN
         B6ocgdMfZ49c0MD1JddKWqe1vcoqOKCVRCHTvVh+g3G3et/Tgkh/R6FMJhoRdw0br14l
         mXKlwNiwC0T9LPsTx+ghqPMPrtaKGHpvxk8R7BMd4ZEGvi5rSCPFpo1J7izmuWlnwQvF
         7G98rfBnp83Mujpeg5dvck7y9n0BCfdmKlNyVoj+tDUdqX99Kq7hdsXD2yuooyN6GuB+
         kDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848196; x=1763452996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZyrHQ2ZNrWsf8deWZQXT3ewHU4+uqpU/uLdHwVausY=;
        b=QwOM+t52nyigDiOS6tn1+I6i1VYzIk0kllFR8L8cXF1OXxcepTZ7hgsQXGziUbWHe7
         AXNdN5XgS0Ndc3FCv/jtgkBtP73DJm6ZChDArHjr6T0kkYNDwBYU/c6beTdncYSeeye/
         6PxLoPuwSIZ6ATdlZLNm65bsSVfjs17oQwd9jgNy+DQv7X99Kklv2d05YogdPnVCWXwE
         Pnu7gvEplysA9bOa3QQ4xAAnsPD7OmdEsoHjMJjeo/40tikvCJL45raRBWUge13CqS3l
         AxnOjrGRFRv7cXMS+L1p00wC+VSpuDptI045tzMZ6a4odE4otzjlWAvKRNMC+HHPFiPQ
         JAgg==
X-Forwarded-Encrypted: i=1; AJvYcCU7BKE+nbG5MMKi0y9iNxS+NFSzTq9VOqm3/n3X+UU9q6ZJoVEQYZx5obQ66LhvcQT8sSLM+EmY02US6/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtgf+ova6qKjLzVUNoMaxiQE0+k4UigyHBYUIbV8Airr3zzheR
	mrrUC1LHANL+ytn9WjfohqZrUryZUP+sx7blStYWCGl7JqQpE4NKICN7Y15mWH+kZEsCNkHj9s2
	Txv1zu8/TwmDpCOmjq+j2VY7Ndlaq1oo=
X-Gm-Gg: ASbGncvyq5pWa/ePxBkRKfR+iqHjHCXjplVPHJLAZm6eHGtFL/EWQ61AGnbpEJ6cLgB
	CwMjt32qa4lSyBjrOrgprccquYHs9EPdnXJLlolmW1HDedhRXl/gkobssYKTtPLAz0W/US658ZL
	mHxFEn7u36BDf0EaM9dI37e7HWkoeJJ3OzbL7/0xicNrxhIpkHaDgr4YfNnD/wip+4HPDPW5PZv
	qRNtH4M1zcwEYX+/zfy/lQeccWD6pNDAVQGrjxGI/xFfHFMK1viXOrEf05zjBUbiqliEHmBYAjQ
	p5eAUkgK6riBPOyutuznNPZey6KTvDaheQiI+g==
X-Google-Smtp-Source: AGHT+IFAhbvzkQ9NSKa3Q0SqSvzUgs7xGbWkTpZuApSHT4cWQ6HoS8R5Pc/WoeUwcDLZzMfWOkj1AgggKlOAJPopPo4=
X-Received: by 2002:a05:690c:4d09:b0:786:58c4:7a21 with SMTP id
 00721157ae682-787d5475313mr103408897b3.69.1762848195815; Tue, 11 Nov 2025
 00:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030064736.24061-1-dqfext@gmail.com> <2516ed5d-fed2-47a3-b1eb-656d79d242f3@samba.org>
 <10da0cb9-8c92-413d-b8df-049279100458@samba.org>
In-Reply-To: <10da0cb9-8c92-413d-b8df-049279100458@samba.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 11 Nov 2025 16:03:03 +0800
X-Gm-Features: AWmQ_bndi8ZMmxydevjeR7lvaNCCS_suACy4WTu-4G55naBoG07uf9BJv13cSCk
Message-ID: <CALW65jav2wiWzz6q6vdnjL88GJB1eWJtLVzH3M1CkOHbdgSDWw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: server: avoid busy polling in accept loop
To: Stefan Metzmacher <metze@samba.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Nov 11, 2025 at 3:16=E2=80=AFPM Stefan Metzmacher <metze@samba.org>=
 wrote:
> >> Also remove:
> >>    - TCP_NODELAY, which has no effect on a listening socket.
> >>    - sk_rcvtimeo and sk_sndtimeo assignments, which only caused accept=
()
> >>      to return -EAGAIN prematurely.
> >
> > Aren't these inherited to the accepted sockets?
> > So we need to apply them to the accepted sockets now
> > instead of dropping them completely?

You're right, TCP_NODELAY of a new accepted socket is inherited from
the listen socket, so it should not be removed.

>
> Actually the timeouts are added to the client connection,
> but not the TCP_NODELAY.
>
> But looking at it more detailed I'm wondering if this might
> introduce a deadlock.
>
> We have this in the accepting thread:
>
>          while (!kthread_should_stop()) {
>                  mutex_lock(&iface->sock_release_lock);
>                  if (!iface->ksmbd_socket) {
>                          mutex_unlock(&iface->sock_release_lock);
>                          break;
>                  }
>                  ret =3D kernel_accept(iface->ksmbd_socket, &client_sk, 0=
);
>                  mutex_unlock(&iface->sock_release_lock);
>                  if (ret)
>                          continue;
>
>
> And in the stopping code this:
>
>          case NETDEV_DOWN:
>                  iface =3D ksmbd_find_netdev_name_iface_list(netdev->name=
);
>                  if (iface && iface->state =3D=3D IFACE_STATE_CONFIGURED)=
 {
>                          ksmbd_debug(CONN, "netdev-down event: netdev(%s)=
 is going down\n",
>                                          iface->name);
>                          tcp_stop_kthread(iface->ksmbd_kthread);
>                          iface->ksmbd_kthread =3D NULL;
>                          mutex_lock(&iface->sock_release_lock);
>                          tcp_destroy_socket(iface->ksmbd_socket);
>                          iface->ksmbd_socket =3D NULL;
>                          mutex_unlock(&iface->sock_release_lock);
>
>                          iface->state =3D IFACE_STATE_DOWN;
>                          break;
>                  }
>
>
>
> I guess that now kernel_accept() call waits forever holding iface->sock_r=
elease_lock
> and tcp_stop_kthread(iface->ksmbd_kthread); doesn't have any impact anymo=
re
> as we may never reach kthread_should_stop() anymore.
>
> We may want to do a kernel_sock_shutdown(ksmbd_socket, SHUT_RDWR) after
> tcp_stop_kthread(iface->ksmbd_kthread); but before mutex_lock(&iface->soc=
k_release_lock);
> so that kernel_accept() hopefully returns directly.
> And we only call sock_release(ksmbd_socket); under the iface->sock_releas=
e_lock mutex.

In kernel v6.1 or later, kthread_stop() in tcp_stop_kthread() will
send a signal to the ksmbd kthread so accept() will return -EINTR.
Before v6.1 it can actually get stuck, as accept() will block forever.

If you're fixing the issue when this patch was backported to versions
before v6.1, this will not work, because kthread_stop() blocks until
the target kthread returns, so shutdown() will never get called. The
sock_release_lock mutex seems redundant because of that.
Instead, shutdown() can be called _before_ kthread_stop() so accept()
will return -EINVAL.

Namjae, should I send a v2 with both issues addressed?

-- Qingfang

