Return-Path: <linux-kernel+bounces-723627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80FAFE93B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AFF5630C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C32DAFB4;
	Wed,  9 Jul 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3i5HEK9"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11152877E3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065068; cv=none; b=sqCpggpKNJvN6A1rlgzcf+e/IOM5Yl6da/YxRTwRKJ8zNrAIbwlOpIvjpZp2cMdH/dZL2n/wQXwmAoBSMveZpeYebXJxTvPGn/a6UsdnoCdNr0ePhFz/XIR0M8qkaQev1FA3lxs5WbP3Ll960btMmSbHYuRMCI7Ub6+75yovneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065068; c=relaxed/simple;
	bh=IAdlkXmYJnbautpH45eYgye/PX0Z4HUwzD9R6awi71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjQVhEfUQX4GLrC1QbVo/EKmr8YXCyrOiRAhD+3Kqp7nEiNp8GR0gWyOhIG+haFXPaJHWk0xsLxrL4uuBbzNudaXBilYIUnQW12083SRRdQgjnPdIBcjiGgExghILUl91MseVuyt14RBE1E/KZLxtf8iJQd667fcBa7g3+cpTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3i5HEK9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso8033281cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752065066; x=1752669866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ2pFoBfWssWUMIkFLx9BPizPkUSvYsKoHWqJr87Tgg=;
        b=g3i5HEK9YC4QjO+dLsQKwAT4baYDcXZZTZGsvydP6zdHHc2yRtJOWp8sN5aBN67VCg
         gm/VU5953mC4hJ3tGJqmmH8IKtBJLskzuzDHMbyeBlLw+L9JrpLaw0sBTGnfE1A9RStm
         jlaVrb626nihlkZdv470Twtz5V3Y+ZVNLakPu99uvadun456WnLt2e/ESmaQYIYULNt7
         t3xM7W8o1yg9lMx8mJylH7yo2lbHoS5TtvJxEQokO/vkyU3SCt4vyDtUw9Ll8M2+hAwE
         6t3B5K1nVaHHr0YqoetuSNFJcEZh/5NoGSudC0QGYUyMbnyLmiSvnSvevVUOsFqvgzj2
         mTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065066; x=1752669866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ2pFoBfWssWUMIkFLx9BPizPkUSvYsKoHWqJr87Tgg=;
        b=JCpzYJFAjKdMA1Sv26lAFZIYclXeVJqmVoz54Q9yYYGqzFIpq0rphL59VK6q+dd0/f
         Ahl7mi3zwMVBRFZWuGJapijpsrWQXDiP3IobsxrQE1QzkygS1K3jxYYPbYyXXpOC7y60
         tP8WPK1dXK+NPj4ox0NoAKeetmVPQXJDSsjHP+iTy0f5tUg4wlerwSOxYB1TAkxtEvms
         3tbAx15lzGD3u9ULBBAU0APZpSjTRzwmHUHamVM/H1Kwv9qtNKoe+tk7SlbW5fe1Kf44
         LhKgy8L9Son/XQQfIuUl1dqeRnK8QyKwNPL8wUK0KXiqXnP0BuFzcndbgojCdbwSdhMJ
         uoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc7vGt0rEJuNMWs03SoBOC/XbrcxKwKXNEz/b8UfWNnfdnTvtfsioDs2y3/fce2qPd+S+4K5AdIaLwnVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9e6LNL7IibpaacB4ENkbr6rMVa40Pi0tD1jhd+IASw19W2H6
	0E/4BPbE2Sj0zZEn042fymjCzIra/t/EsE+CMF2aU0uwKCOpF0dKb6I80b9D60SSkTw+zQvTwbY
	Aefp4ch0DRjLUx/Nceuz+GHBGYltxgay39NFTvKSo
X-Gm-Gg: ASbGncunGCO/vCSyR/7gRnv0/yeZ8kxPnS1DxIEGAvLAf7Y6IXCCk187knkWyjQPBET
	JDkbZjhh4k9r9lbeChrL9i4ywcK0Uaxn5NRuZxOO9n7v9+sJT1uC5Hnm0K/TE38z1rzC01RENHu
	hsB07suYGPyK5ZCmo30Q04ft5k1roYFz3B4TNxR8dbHl8ptMmIY//n
X-Google-Smtp-Source: AGHT+IF6HV1hGzAbRKcrDqbmUhNZQ3JD6E5sUCFQXTonDPWmTLwmgflb3xbsoN8Vq+8aWGcXfWI1IoV06zTydysA4DY=
X-Received: by 2002:a05:622a:5a0b:b0:4a7:7326:71be with SMTP id
 d75a77b69052e-4a9ce4c08a9mr100566731cf.5.1752065065445; Wed, 09 Jul 2025
 05:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709095653.62469-1-luyun_611@163.com> <20250709095653.62469-3-luyun_611@163.com>
In-Reply-To: <20250709095653.62469-3-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Jul 2025 05:44:14 -0700
X-Gm-Features: Ac12FXxyCO7LIPlCP2Qe8xqhwgnGFOKidInr8A6Xi3bns36W4r2F_LC-4GXwjZU
Message-ID: <CANn89iJZ=t6Fg4fjgPooyTAbD4Lxj9AKFQx_mnJty5nq9Ng9vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by tpacket_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:57=E2=80=AFAM Yun Lu <luyun_611@163.com> wrote:
>
> From: Yun Lu <luyun@kylinos.cn>
>
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
>
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run. As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
>
> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
> wait_for_completion_interruptible_timeout() should be executed to yield
> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, move
> the penging_refcnt check to the start of the do-while loop, and reuse ph
> to continue for the next iteration.
>
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for tra=
nsmit to complete in AF_PACKET")
> Cc: stable@kernel.org
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>
> ---
> Changes in v3:
> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_61=
1@163.com/
>
> Changes in v2:
> - Add a Fixes tag.
> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_61=
1@163.com/
> ---
>  net/packet/af_packet.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7089b8c2a655..89a5d2a3a720 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2846,11 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, st=
ruct msghdr *msg)
>                 ph =3D packet_current_frame(po, &po->tx_ring,
>                                           TP_STATUS_SEND_REQUEST);
>                 if (unlikely(ph =3D=3D NULL)) {
> -                       if (need_wait && skb) {
> +                       /* Note: packet_read_pending() might be slow if w=
e
> +                        * have to call it as it's per_cpu variable, but =
in
> +                        * fast-path we don't have to call it, only when =
ph
> +                        * is NULL, we need to check pending_refcnt.
> +                        */
> +                       if (need_wait && packet_read_pending(&po->tx_ring=
)) {
>                                 timeo =3D wait_for_completion_interruptib=
le_timeout(&po->skb_completion, timeo);
>                                 if (timeo <=3D 0) {
>                                         err =3D !timeo ? -ETIMEDOUT : -ER=
ESTARTSYS;
>                                         goto out_put;
> +                               } else {

nit (in case a new version is sent) : No need for an else {} after a
"goto XXXXX;"

if (....) {
     .....
     goto out_put;
}
/* Just reuse ph to continue for the next iteration, and...
 * .....
 */
ph =3D (void *)1;


Reviewed-by: Eric Dumazet <edumazet@google.com>

