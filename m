Return-Path: <linux-kernel+bounces-825802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2ECB8CD7D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9D71B2381F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDCC2FFDD7;
	Sat, 20 Sep 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipHxqFzg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660442248A3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387147; cv=none; b=TyuR6ZPUpA/v30fsqID5+uItJabOYl8g5hgSROq2dl66I7a5KXO0aNIFr1NhOJVEpm6QKuEe1TpZu5oM1wnJQVcPbKfNg72AYJLrj8jka9zAgWxmTB9gJLrS7t/QNEI6JUOJKYZtfBXVACvuQQsIaS2enBwW0ZS4rThb1Ax1JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387147; c=relaxed/simple;
	bh=GWpvS5x6cG1Y4f2S24NEW8dN0quQ/cx+TBhU9hoDln8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0v0fQYtFqfQ4TgJp3mBJx7LEW+BV/BTg4916+40KEoiIWGAJskwLsXC/6e6buqRjEiKObC5W1wDa731bI/TnD67Im1Cw8rmxkA1lmp3j2b8tJMpl95WIsfcnzYn+5lhedpQIR7gmS0bRAY+50qICdY8jNdpIqYLU12Xjt2mN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipHxqFzg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb0870so2659134a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758387144; x=1758991944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6t0lvNAvBHvFjIYOZdnPwHv9uI7zn4mkRak4VLc3x+o=;
        b=ipHxqFzgmWoxFnQBawz23NUMuyU0ry9vKhPQg5SDsvLh7zDpF6y8iv7WehZmb5f6+M
         91kdYgsLlAALngU2ik9ua4TeCacnnRGXgqrvBlukiESsLAwhrP+jnn1s2uiSAvSTKXr0
         oLu49Fmz5FXaABpW8TZzLAUvrkIcqoskVU876JuWQM74ggnaaBfsdJ4Kd5IgDFg6fbiu
         LfdlpMWQBDpJUMCGYWLHC8uBFT1Cm3QdUDlX9bdmHqUd8qxK/Bnu8M54fnIivaELmfiS
         Y/fGCHn18bCEwhtRl+sk7Sacl8wKNaXj5ZOz3aTRnd9SicgFJ0Z77s5+KupjlUQs1gRw
         1m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758387144; x=1758991944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t0lvNAvBHvFjIYOZdnPwHv9uI7zn4mkRak4VLc3x+o=;
        b=kwqrfxoEg7127lNESTKvFDsHPgcqwPxsQuwB/UvxoeUgybz3ucQbrPdbiCcOSiC93z
         lNPbfK37J0JFOhs/nkCl9jukK4SqwSwF+3P8RMxxRlmT0GoICtQ9POkBfkyUurTg81Pc
         4xnClSt6+awH49wtctvFjlH57hOp+y/VMZfXTbZNSMFSTYysrKtwsA2QD7hCLWDtCQuS
         EnbVkXCq7W4dQYxjLNxBq0KnN7rhmE2RdEj3Vq9jckKyUyYEwxjAuHFJ3/pAT0YPtw+/
         7+vn0N48qfQEcTge9gH4XfMsHHw640LEyuXJU5LTi1hpeqtVxNUtAhsiDJeRlSzkCXjB
         Vm2w==
X-Forwarded-Encrypted: i=1; AJvYcCWr52+wfDfcFzmV4Ag2p6qsGSTDZDKuIBw4JXeF6Z3ybpsLRNKTi7amzY8Rqn8rIUyKp94sfg23JYOs2NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+YqUbrtVyT2tTPe9/XH0tp2y9jtyqZ1SMch+kwSkfw+rqTPN
	SIUUISP+xSaxbPL2+1NbHhJREXlOVojtWV2SM6avO6lUS0kUpzNFRkzI9xUswnQLbqhxgKxoIIJ
	2oVvoGmgyR76w+V4vvtTt7D1emWs9/7Y=
X-Gm-Gg: ASbGncsapuS3aj+SJDVoOamUSITYc80SEQwQlpsoVq+Z9C1kR05zs6W43DX3HQzsCzo
	sVQSZCpzH0XdW2bm4y/pAJfAifgB3/GhZzM2jBENGms2eunM3/OrNFzdYkdjDc5tAHGP3s187n0
	o/1fpk4cOTCUG8IdGMeZGuuCQdIeTzQMoML5Ez4iwoeBCmy0f/Tn+PnEYQDFZ6muyUc+3H1EGBe
	GSU78ZVRBpMsuRn29BL6z2OSmJEFzCBjN8BPfWtzDiF2bwzj3CreMdJDQlLqXagcms=
X-Google-Smtp-Source: AGHT+IHHbxws3SREQHUm9DXYPSh1lNZGC+x8Xy2uJwCBquseYOMfarK/RwziU8Ml2w72ef92uUul+cCZANWL5gTtfzQ=
X-Received: by 2002:a05:6402:1e96:b0:62d:6cac:1ec2 with SMTP id
 4fb4d7f45d1cf-62fc08d2120mr6186264a12.4.1758387143494; Sat, 20 Sep 2025
 09:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920045059.48400-1-viswanathiyyappan@gmail.com> <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
In-Reply-To: <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Sat, 20 Sep 2025 22:22:11 +0530
X-Gm-Features: AS18NWCYwk4g8GKTtmeraqfyKpXAyJkc7cnfC3ztEpzTK4PVyVgiyuigIenJluQ
Message-ID: <CAPrAcgOb0FhWKQ6jiAVbDQZS29Thz+dXF0gdjE=7jc1df-QpvQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Andrew Lunn <andrew@lunn.ch>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 21:00, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Sep 20, 2025 at 10:20:59AM +0530, I Viswanath wrote:
> > syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> > This is a possible sequence of events:
> >
> >     CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
> >     netif_stop_queue();
> >                                                                     netif_stop_queue();
> >     usb_submit_urb();
> >                                                                     netif_wake_queue();  <-- Wakes up TX queue before it's ready
> >                                     netif_stop_queue();
> >                                     usb_submit_urb();                                    <-- Warning
> >       freeing urb
> >
> > Remove netif_wake_queue and corresponding netif_stop_queue in rtl8150_set_multicast to
> > prevent this sequence of events
>
> Please expand this sentence with an explanation of why this is
> safe. Why are these two calls not needed? The original author of this
> code thought they where needed, so you need to explain why they are
> not needed.
>
>     Andrew
>
> ---
> pw-bot: cr

Hello,

    Thanks for pointing that out. I wasn't thinking from that point of view.

    According to Documentation, rtl8150_set_multicast (the
ndo_set_rx_mode callback) should
    rely on the netif_addr_lock spinlock, not the netif_tx_lock
manipulated by netif
    stop/start/wake queue functions.

    However, There is no need to use the netif_addr_lock in the driver
directly because
    the core function (dev_set_rx_mode) invoking this function locks
and unlocks the lock
    correctly.

    Synchronization is therefore handled by the core, making it safe
to remove that lock.

    From what I have seen, every network driver assumes this for the
ndo_set_rx_mode callback.

    I am not sure what the historical context was for using the
tx_lock as the synchronization
    mechanism here but it's definitely not valid in the modern networking stack.

Thanks
Viswanath

