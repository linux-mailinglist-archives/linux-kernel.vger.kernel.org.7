Return-Path: <linux-kernel+bounces-842821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECCBBDB12
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1828C3A42E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E223B63E;
	Mon,  6 Oct 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foi+1gKJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E601E501C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746617; cv=none; b=qr5MiiJKMtr1Q5RRQI0cQhulQq5ac38Ww4ygY/Ih5ekzM4naDcIY+B2JY90WZoFJFEi1ODSLAuL/gSiW2FjJMvGTPoi5O4StvqJ+dAkdnOMHhLPB4O/6mwGlbdJJzzl7UbSgm2rayhURX/3CAqfHsC++SPxyiq8FEC+VIx2g8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746617; c=relaxed/simple;
	bh=LA0UzF2i7icKJ6QW651zRRsYUq8vJVx9Lxkwf1E//IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Do/BSKxuAfZ+klF+9/X66VCTGwc6KwpRbfb5S7/w73Fy4jOIyORdZHn6FsTW6Vrvk2Hb4Iso+A+DLN3Xx3Rv6jv4gqzJ9Jg7wO68UcManyOyhbj74mL8y56IlmS8v1ypxqG0n07uYPIZlt4oxAkR4pLM6Fts3se3cy//hlFmkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foi+1gKJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6398ff5fbd3so1960096a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759746614; x=1760351414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7O7Aed0xdhbVZ4wpBKNRAfanT5t/9q/8gOor9tlF6U=;
        b=foi+1gKJa/vJuenqyD8hRxiB7rKEjJ5dKiUSsFr7TRdLPifqoWNS0Eqsh2aVbRMwqa
         TEO7967phNVGs7uSRfN9T7is6wFsbmVvE6iYPBGhhuder7gavJ+UEZZqCE6nzx9uoykt
         kPHCing4I/tSTn+DzHvrVuOpvEVX66Ea4WCFDIjzW8Mul7kT7Xo3PARo518aY58AKqgL
         USB6gPxxZC7kq+iI4Qg/z5ZPUWCth68u/Lwx4GmBYvE3/Wa7OO52NvqfXXogEar6ozJZ
         B1heuD6YXiIkh5SBX2uCuX0u4fcdHkL3PwjzZXHVfI53qiY4aWwPBPqpVenYfo68/oZr
         REgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746614; x=1760351414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7O7Aed0xdhbVZ4wpBKNRAfanT5t/9q/8gOor9tlF6U=;
        b=nmR4NelkSaszYKFqlvWZqWo3F8JFfH8r5xgqiXjThy0y96oRwV3zHKdVLgJ1bDhhO5
         Qo7ou65dSwLX00nHMKxj7q8Wrdr834V3XvHLmg0U03jjIQWD4kYRlkOiKA2HIUBwYdyb
         +LTZ9S74/u7Qc8pz+yXVR4S+HuOryuN7xmu+QNpz4bV96W/Xh9eRJfDGBVJEJjdkLtEJ
         VyBDu71BU0YO3H3/XywNsxhoYBNjgX3bDhhqK0S3QsDzFQvFLluH0iuzgiW+7dP1kdLB
         sPxq4QUgkFMnUhOco6jhfF3rWYhNYBCy+AoAG8HHLkvql+K9ZWhDP+n8DEp6hsO5G94n
         cUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgo4Eb4BOQdfyuU2IEb1LlnvwLrRuNEJiWUiPOjcRveE/zhMMvG0lQlvJw1r0G+lDKtwP7EiyyKujSxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynN0SS5eptAtfEJF2J/DKcS1o3ivnFPk2+fyTJC305fKO5h7ne
	jnlAh/cAjF+pMf726hlMOqpksuad5w7vSYuNmUL4XH2Sn2d8m9w9PtQObvy0aYPiAyZtGhrbMzv
	D3+F6Id58SYiWwbxxku/tsZCysVjj5/A=
X-Gm-Gg: ASbGnctJ+8RlVoadA1t5p3RjmL1HuCyCEOwtpHEnJi67qyX/B0YexlWfXirj1X8Ub3t
	A3zSky7V5bA1tOPPIqNvHBjoxBeehvqbFLQUC2pH6Ev1VlLJwf/6olLlX4ELRB7unWP+lAPAaen
	P6NJlpMAtmwjUfqs4BgPRc29/ZBxKDGbe7+gefH//mBMkFRVtHHvlf+Kp5aoa0+RAnee7uTw48Q
	vKq0/4+WDx7EYwsPWoyVwRvlIUhmCxvqpenfWS8RQgq/iGc8G7kWbOBOozpsig=
X-Google-Smtp-Source: AGHT+IGgV0qS7uGVLXsvRTilgu8ibwCIS22kd4QEhQildnmONTPWxDyae4C0E1r+u30Gj0yUBevAbJLtG5rmvRAjSQU=
X-Received: by 2002:a17:907:7f8f:b0:b45:7d93:b422 with SMTP id
 a640c23a62f3a-b49c45b24a6mr1436879766b.65.1759746614127; Mon, 06 Oct 2025
 03:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFi-9qYPnb9xPtGsUq+Mf_8h+uk4iQDo1TggZYPgTv6fA@mail.gmail.com>
 <20251006072136.8236-1-hdanton@sina.com>
In-Reply-To: <20251006072136.8236-1-hdanton@sina.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 12:30:01 +0200
X-Gm-Features: AS18NWDzO-OVtcZ9CXiAup1pzSl8ws60YwCSHbZRKmh-rtEGHiIBCriiD09rCQo
Message-ID: <CAGudoHFai7eUj3W-wW_8Cb4HFhTH3a=_37kT-eftP-QZv7zdPg@mail.gmail.com>
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
To: Hillf Danton <hdanton@sina.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:21=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Mon, 6 Oct 2025 03:16:43 +0200 Mateusz Guzik wrote:
> > That fence synchronizes against threads which went to sleep.
> >
> > In the example I'm providing this did not happen.
> >
> >   193 static inline void wait_on_inode(struct inode *inode)
> >   194 {
> >   195         wait_var_event(inode_state_wait_address(inode, __I_NEW),
> >   196                       !(READ_ONCE(inode->i_state) & I_NEW));
> >
> >   303 #define wait_var_event(var, condition)                           =
       \
> >   304 do {                                                             =
       \
> >   305         might_sleep();                                           =
       \
> >   306         if (condition)                                           =
       \
> >   307                 break;                                           =
       \
> >
> > I_NEW is tested here without any locks or fences.
> >
> Thanks, got it but given the comment of the current mem barrier in
> unlock_new_inode(), why did peterZ/Av leave such a huge chance behind?
>

My guess is nobody is perfect -- mistakes happen.

> The condition check in waitqueue_active() matches waitqueue_active() in
> __wake_up_bit(), and both make it run fast on both the waiter and the
> waker sides, no?

So happens the commentary above wait_var_event() explicitly mentions
you want an acquire fence:
  299  * The condition should normally use smp_load_acquire() or a
similarly
  300  * ordered access to ensure that any changes to memory made
before the
  301  * condition became true will be visible after the wait
completes.

The commentary about waitqueue_active() says you want and even
stronger fence (smp_mb) for that one:
   104  * Use either while holding wait_queue_head::lock or when used
for wakeups
   105  * with an extra smp_mb() like::
   106  *
   107  *      CPU0 - waker                    CPU1 - waiter
   108  *
   109  *                                      for (;;) {
   110  *      @cond =3D true;
prepare_to_wait(&wq_head, &wait, state);
   111  *      smp_mb();                         // smp_mb() from
set_current_state()
   112  *      if (waitqueue_active(wq_head))         if (@cond)
   113  *        wake_up(wq_head);                      break;
   114  *                                        schedule();
   115  *                                      }
   116  *                                      finish_wait(&wq_head, &wait)=
;

