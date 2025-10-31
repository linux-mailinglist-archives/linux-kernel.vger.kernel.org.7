Return-Path: <linux-kernel+bounces-880865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A54C26C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DF63BA712
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF334F466;
	Fri, 31 Oct 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8hVTjqu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C03491CC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938906; cv=none; b=oHYZm5BrQy7d0nBf6lRKTgsaDPCNOdyp0CS2eZmsak1moC0nJfNDWfSp7/ffDg/0Pl7rRzSDYpR770ZZkkUsZNB0RM4sli7q11uwmc1CsGz4+fCzY59W2JIUn0u+oTewK3A0s7tElI3bmdaamFiNnmVp7UTtynYzWBDxyANCsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938906; c=relaxed/simple;
	bh=mUJznE05kUPl0IhO/e5znFzRpuOXnTth9Kcu9imUesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqY0bqxv1mEqyOLGsu6FbjKD+qvmY9HWcXbaF3RccKzDfps28eKdZ50TKA9Ej3D7QM11lEkAREn57NXaFchbtNHFmZSptrq9+bBkyfIUZmaBQJUT9P2vVOexwKw3fFP2sR7Urwp38swQIDPlFQnkiQt6dcyotIHFzmaVCGqDChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8hVTjqu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698384978dso22384255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938904; x=1762543704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=m8hVTjqudFney8nxFZYvBqMxQKej6AwYCS2apItgNKy/k2kVj9wcesr9yTwmpqGdA9
         P69WApwnDpcMgqsBjOu0PbAq46ewJZVHWJDNCeJovvs3G27dHe7c/bLwmcGQ/GY4kidH
         6LMFhz4ALpX2oKhPzimcDzeet5llptAyJskMEgA7guUigV5W7ltoCI0x4jiY0uBnM8+Q
         qMAQ+BAqy1Mg3N+v76c/LNDFD0CcKRb/8AOf6JtPdO6aWNVNLntc97P5SceH3WXhK6gO
         mbgbF2ndxALECRsLY9IWJolTZyvphF0xXx5GZ8qmcJH6/impAvfmdCqHN8WVu9wzyL/e
         LbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938904; x=1762543704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=qm5OvZHKoB+rYOPx9iySW4/QL/KZVmc04Z2ncKsw2AbK/hZ6N1WvPFQJ1c4ZwXgZWu
         wCufxV89bC4geOzyPx/eUk9pqAKWU97tralIDxu1X+Sda2mPjdGMcvr+8HhfiO8JMUMF
         p/Xf3HSWM4RLN9qEJ24VRI0WHgHhbFWz2MS6Ke2gTc548NBQd4STe3SxPUnmhIYwKcc/
         m+4bsx/Q2VrDf8VDLIZnM76ZvNavkFCRZcVfG/1fcCuPl3t50SMOg6DKNBOsyWrcmzaC
         LB2nRSkSL3rhAB848qYfCDjOciXG2vZctZIqfAgKzLFiif1KGthPW1iW5np+z3jQE3gj
         oW2A==
X-Forwarded-Encrypted: i=1; AJvYcCWOW2D14V0eh7jm2kJ/tespWQp0oPnlQKywDQSaD2GY7NvuJn7ejzwKzqO3S384KIFRbIUCl6D992+tIpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNj7sstbn+AoQcGsvhibpy9ODOl3o5ELf2KHuZhfnoqKuu1jU
	Eax1APzdA3f29VSDnqKnnFgN2cw2EoMFR0WGXmidomUti6IJW9AbiRvfoE9sdC3WZkZwzNC7gAU
	BoHtPnAKcgZqpFGNLUn2nyM39dJrJOmKiEF/I0RbY
X-Gm-Gg: ASbGnctG61MGEXVUewIeOAK46acja0OVxqu21C9em++P4zeDXziU5ca32cBbSZhOTfk
	Lj8M9X0GKs2sGrX4E6QhGdWO1vrkqf8/wEceMwmpoMJiaea6BzJqUVMOXNAiQ4N1GcuTxVoy6Zh
	+nIcnxZGSC8nrsPEJD9E8YSchkOMbI4I72Dg3vLl/RTLRo3p5xg4dhMuxME8t18iNhXrjJxm186
	l7UoRSLlexgGDFgu/YhfvQhN2ewujgx7807ddJcnXTJd80ZDCALZVIczXy1daUq36E2MFX+aK2p
	Y6N1pfZ2/LjBzM/tog==
X-Google-Smtp-Source: AGHT+IFigqOtFBCYUqwCmY3qziL8qVWGu/nRTorElbmyiYpFccuK+2gunWWZPScjAXWItngFYakwtYJJBQr3HV87VJ8=
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id
 d9443c01a7336-2951a4976f9mr68144065ad.23.1761938903604; Fri, 31 Oct 2025
 12:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:28:10 -0700
X-Gm-Features: AWmQ_blgcBeSUdxPtx55HtoAsZERyYHkYCJ5aCAKAIqjn5k5KTf1zjWOPzbN5ao
Message-ID: <CAAVpQUBk7CnezW6bOK-5GF3-kQwJZBwz0hLS4TTEiPYTkov+HQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] sctp: Hold RCU read lock while iterating over
 address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> With CONFIG_PROVE_RCU_LIST=3Dy and by executing
>
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
>
> one can trigger the following Lockdep-RCU splat(s):
>
>   WARNING: suspicious RCU usage
>   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
>   -----------------------------
>   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
>
>   other info that might help us debug this:
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   2 locks held by ss/215:
>    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netli=
nk_dump_start+0x84/0x2b0
>    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dum=
p+0x38/0x200
>
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e=
9a6 #5 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-=
0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x90
>    lockdep_rcu_suspicious.cold+0x4e/0xa3
>    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
>    sctp_sock_dump+0x131/0x200
>    sctp_transport_traverse_process+0x170/0x1b0
>    ? __pfx_sctp_sock_filter+0x10/0x10
>    ? __pfx_sctp_sock_dump+0x10/0x10
>    sctp_diag_dump+0x103/0x140
>    __inet_diag_dump+0x70/0xb0
>    netlink_dump+0x148/0x490
>    __netlink_dump_start+0x1f3/0x2b0
>    inet_diag_handler_cmd+0xcd/0x100
>    ? __pfx_inet_diag_dump_start+0x10/0x10
>    ? __pfx_inet_diag_dump+0x10/0x10
>    ? __pfx_inet_diag_dump_done+0x10/0x10
>    sock_diag_rcv_msg+0x18e/0x320
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x4d/0x100
>    netlink_unicast+0x1d7/0x2b0
>    netlink_sendmsg+0x203/0x450
>    ____sys_sendmsg+0x30c/0x340
>    ___sys_sendmsg+0x94/0xf0
>    __sys_sendmsg+0x83/0xf0
>    do_syscall_64+0xbb/0x390
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

