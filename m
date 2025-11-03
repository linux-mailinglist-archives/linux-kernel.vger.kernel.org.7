Return-Path: <linux-kernel+bounces-883630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8DBC2DEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21987188A061
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B63203B6;
	Mon,  3 Nov 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAdLwYPM"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F029BD8E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198919; cv=none; b=mrkzoUPbEqKlNE5E/qbiXSvRT2C9Nm3zQS0+r/6XwN9pnfV0YpZQd/cvqe71ecOIwrGv4WLMw4a9OieGIMT6PavUsunwOhlaEau9usHVzuek+Z9HwmPyM1FZatKP3A16xj1+yunGf2WJNWVMqLE9trAW93UcdjmRvJ7+sIUIcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198919; c=relaxed/simple;
	bh=ytOAUmNRkyNrb+8SNM2LQjWX8qc1SfKmf5XVP7jIKcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+P3W1ci82kOHvXHjqPoPqoseQE7577ibUbqiUFnern7L72fJMEIfRqPcpcss4vS86OOHtGYlx/rhP/qyONxVtfmxjxXKrLGdl5zD6Qa8cGRjOlt5EqURNcBCnbPMam921/dXtQ1WCv0b1yTBG1YOq7pWHcln3NVCLKj/Mg+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAdLwYPM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34101107cc8so1589246a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198917; x=1762803717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=SAdLwYPMVlamNqGleD5GADzeZti3STqcp1hg3KPkwHcWqbWRmapVv1qUphJv4+chTe
         IsqapZOkAYB8wg/emd8YLxsHAyweMz+h0mfCLmgqUpjWw+x1qeAsEj9D6D2GxIbr6BYC
         s6fOmVFOdTpv7qYbBWR6uTXPB+sB6N8vcBnjgPIj8ilLW0McyHdtHwmY276gwBLvSfFM
         4KFow4Kqi3sGYcrnIRmzo0Gv08mjwMI7+8U/Wngr8xGgKte4EwbNkBZK7GlHJWv+8iW/
         6JnUH3wz/9dJhFTYD4eD57SNrKAqYIKC+rrqdLK+75G+8K5vduiHp8Ebc0i4qVnO/bTV
         qpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198917; x=1762803717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=mw2x179coalTWl52+hGvwOvwns7/Q1JvBh9X54Toltgiij40P3/5gMkwP8Ia8aY9dp
         lU2Yw6o4/BSKjlyup8uFwrMlY44aJcL8BgWcQUyXE76HSgi4RvJXOafRhi6GtP6QzO7x
         fHDmivxL7+x1t8zLE9u49jCbNb0xDn9P81qQctGYCMnHiv5USBluXzadP5ODssinYVi7
         VtG+GDvhNFa/gscEE1meNHOG+b9BnxSTWoArxD/i0aFvNY3TcnnXg6YGPlsFtU4r4V94
         RTRFs6rtU5wfXI6litp+ITDTV0HiGZTvO1G6dmfO+1r+/61B+5xLiLQ+oJ8WQgThWojZ
         UMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUlCZq4dZ81gObM/GZ+vlrh9hZ/tgKdaB2aTSMPsAwVI3Wi9rCHFbRflxtO24P4JbM3zpoR8bkq8v2ADP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1DI3QVIGf5DhCJ6FW7ncO8dzSNI+RaD8nROwVEpOwSoEvfce
	8ssCncRfHs8XcS6jy7Cn9f6FJuWCwvux3RcBWo3CX4B9i9I5yPYkCsyZo7gUCldzhe+j2mYzoe4
	lAtv09qQn5xDnxr/MH3oDjUNX9NdgZ54=
X-Gm-Gg: ASbGncusZG5tCN7/ekl5fN2qyFgKSqeezx7oMdb7HJ+PX7BU7NNbUBNLzCX617mx+T1
	dZfvl4Ic35rF2XwbtQVW0pO5hO0V4EJiG12rHKIVwpHlTxp8joRLcBWeqIFVe7BOtwqJ6GJ3XyU
	OrJWeip+w/Ux3mD6C3FoNShAN3UyuH4dMVYUf1th8GQAFMZyitfum+/hBPKqykEyT8BhyBab3r1
	oiweCNxIT/dQPXxziDGjIwM7TdRe7SSPXaX/wE1TZUdgOa1lMn9wt2+1iADETvIECxgZAo=
X-Google-Smtp-Source: AGHT+IFF702hXzMq3F2a8uGm8E60svn1HEyf0oLw6pQ2hliT+hDxZq38YemBD8AMk5LJLMgs3f8KaJ09KIEXyWShNJM=
X-Received: by 2002:a17:90b:38d0:b0:341:25a:ad4 with SMTP id
 98e67ed59e1d1-341025a122fmr7788990a91.37.1762198917347; Mon, 03 Nov 2025
 11:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:41:45 -0500
X-Gm-Features: AWmQ_bnY9CHWjDcwZC0Iq3uTXqVqXa1nB6j2AnO1OSN-u6hNqbFa3oymkdmy2U4
Message-ID: <CADvbK_cFoj7Y81dGTmBzY4BOyZrkdoSa37zkeavRy4gaMEKRwg@mail.gmail.com>
Subject: Re: [PATCH net v3 0/3] Fix SCTP diag locking issues
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:15=E2=80=AFPM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> - Hold RCU read lock while iterating over address list in
>   inet_diag_msg_sctpaddrs_fill()
> - Prevent TOCTOU out-of-bounds write
> - Hold sock lock while iterating over address list in sctp_sock_dump_one(=
)
>
> v3:
> - Elaborate on TOCTOU call path
> - Merge 3 patches into series
> v2:
> - Add changelog and credit, release sock lock in ENOMEM error path:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027102541.232=
0627-2-stefan.wiehler@nokia.com/
> - Add changelog and credit:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027101328.231=
2025-2-stefan.wiehler@nokia.com/
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251023191807.740=
06-2-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027084835.225=
7860-1-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027085007.225=
9265-1-stefan.wiehler@nokia.com/
>
> Stefan Wiehler (3):
>   sctp: Hold RCU read lock while iterating over address list
>   sctp: Prevent TOCTOU out-of-bounds write
>   sctp: Hold sock lock while iterating over address list
>
Series
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

