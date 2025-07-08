Return-Path: <linux-kernel+bounces-721032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B9AFC3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA770189DFB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBFF256C88;
	Tue,  8 Jul 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynZIxnA3"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF52566D3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958773; cv=none; b=UtYaGFaPGFZh6TMBz+0pjve1YRHVwps/sg/4dQjOnvuQHx7PPJUcrn/6HZ2ZVanA/BTm0VcsaF+J6EIbqlCMRFA3pS2/VcyG6Y67du4IfKpjIpKxWps61ruaijqeEgPDQI/7rr4a4iMXJP9ijuVY3IxiSUEj4Yn8xXoX8frcM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958773; c=relaxed/simple;
	bh=XscmS3TYLZWbaJ1v/tB8VxNbRqDYd7mpJ2kmhToD68c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC6eF4XMfGjasMgM3sYqdgwyhrktDLSYDcRkW12deWE/xfj7pWbQpcsPdodi4MULVoSD7Phz/kbv+pALMU2TNq+joS94SQTgHjawPRB+y08b6Vdyjehn2W/m3kPLazHHRHbhCKKnnCqhnDcdO7eM0aCwdwYTUSa/rxc3LM0s9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynZIxnA3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44e94f0b0so52114501cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751958770; x=1752563570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zp/fM2/qnk7Yqx0xtmAfSu2PC7PxlBF+F3QEFTY3nY=;
        b=ynZIxnA31CHvFvzE6+Dl8VtP8/54vI4TpFuzpuxK7MD+BQsie4DkVODR0QTYGM9EAH
         fz2UHha+agv7DZQzgZKgOMmH9ITrxMlz2KaqXWOn7clNn5SkGlG3fggk1hbOUmGtBBki
         xBnKbD6vhVmjtmfTmqL3jDcWP5MSQ0AOTmCTyIR77lE3Vd80yslW9Rsn5NiRVNwesWB8
         K70C1TGnX3kh+ZLwP5kSCQ5jFhNiciHwwI6TYHa0oV6UbnXJbZvL9/SNXINRoI7zR5qT
         itSC9QJLdlwTUwF6qFSFAmVnr5j4XNC7AjApuwotgeWgUkDZ3c24dnczAmQ858rSi1Z4
         LgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958770; x=1752563570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Zp/fM2/qnk7Yqx0xtmAfSu2PC7PxlBF+F3QEFTY3nY=;
        b=iQVE8BwmmpQA3zUJ8hAGc6CxDxt5ENs1kDjdv2CFWtdZDcPXHSJ/FEQ/QkDaiNm4Lz
         GOyCvu/8h1BsP53O7iuoM2c5JoL4bVJb+lBGC1VfNAYEaF++jxJpbY+e1jUUCdl3OGZI
         JBU4LaFqNzFJDi+UQJ31mCOuL/Ir0fRX22dZ4g3PMd9Fg84/eqCFYSLGllvKpXR1ozas
         kALhi8ArPJyffgQDyGNJ4ncAeCyyZHjtAX3cIOBuhudQ1p4B3hI43vVw36jzy4iBlZZf
         /yYErgXu7VrGZUkErf+1cJ8TkkSTw4DnvFAhoS0C24p7z2fAQocJAzUWQ/ZuFLVUsmNJ
         oZng==
X-Forwarded-Encrypted: i=1; AJvYcCV+WogU8v9PJxcJxE7Ru01u6+DFY4CvlHmVMDjt9MkHNbIVaU/r6SwanfSEt3QVl+lSnS/D/5Hmp25YI9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uc10WhurCrdxZmgKWKkAyPjUOKivnqUXo/A81tc9V564zjYl
	31PmFWxhNAT+bhNL/RGqGLzqE+mc5JCVZ0gAWXo7UPEp0Jb4ajBThS83tWfRPwBBPLtB4jMUBxP
	ykk0YgZhNozHSgMzKlfwQcg/OUUKWMkGzLOX0a5ys
X-Gm-Gg: ASbGncvm6GUVznFs4ndU7GhI54bhz4yqBjEg/byBjLTWjI5k/C3jBsqnOmN2o1s12uR
	d1Y6L+iyfCaTqBcpmeZHF+v0LV0fzszE1FLOf2IR8rW/pCJjEeMIr7hUDGiunSMY65MiPcf9ErZ
	ZIbZPnJI4nWK0Qq0z67gm55D+lgWPandowaQrPM/9KheQMcZzOj2Qjtg==
X-Google-Smtp-Source: AGHT+IHhkMvmsDCUL3FUDuybpzrVJI1QMQzt44jXPwSlTwonG6zNEdeu6TlRuVYBnI0XFwUmj/OxQMuqYSOP0qRONk0=
X-Received: by 2002:ac8:7d41:0:b0:4a6:ef6b:af17 with SMTP id
 d75a77b69052e-4a9ccddc5a0mr34918981cf.35.1751958770074; Tue, 08 Jul 2025
 00:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708020642.27838-1-luyun_611@163.com>
In-Reply-To: <20250708020642.27838-1-luyun_611@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 00:12:39 -0700
X-Gm-Features: Ac12FXx7GzBAIyyAYSTsp8BsxlHWfg8I5emuM-v4Qk5cHT_Bn-LbE-CFfIHZD1I
Message-ID: <CANn89i+6g+VwByu-xeJ-PVuaw8X_yQdC2buB7q=YO5S3MzMTUw@mail.gmail.com>
Subject: Re: [PATCH v2] af_packet: fix soft lockup issue caused by tpacket_snd()
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 7:06=E2=80=AFPM Yun Lu <luyun_611@163.com> wrote:
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
> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
> execution condition of this function should be modified to check if
> pending_refcnt is not zero.
>
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for tra=
nsmit to complete in AF_PACKET")
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>
> ---
> Changes in v2:
> - Add a Fixes tag.
> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_61=
1@163.com/
> ---
>  net/packet/af_packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 3d43f3eae759..7df96311adb8 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2845,7 +2845,7 @@ static int tpacket_snd(struct packet_sock *po, stru=
ct msghdr *msg)
>                 ph =3D packet_current_frame(po, &po->tx_ring,
>                                           TP_STATUS_SEND_REQUEST);
>                 if (unlikely(ph =3D=3D NULL)) {
> -                       if (need_wait && skb) {
> +                       if (need_wait && packet_read_pending(&po->tx_ring=
)) {
>                                 timeo =3D sock_sndtimeo(&po->sk, msg->msg=
_flags & MSG_DONTWAIT);
>                                 timeo =3D wait_for_completion_interruptib=
le_timeout(&po->skb_completion, timeo);
>                                 if (timeo <=3D 0) {

packet_read_pending() is super expensive on hosts with 256 cpus (or more)

We are going to call it a second time at the end of the block:

do { ...
} while (ph !=3D NULL || (need_wait && packet_read_pending(&po->tx_ring)...

Perhaps we can remove the second one ?

Also I think there is another problem with the code.

We should call sock_sndtimeo() only once, otherwise SO_SNDTIMEO
constraint could be way off.

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f6b1ff883c9318facdcb9c3112b94f0b6e40d504..486ade64bddfddb1af91968dbdf=
70015cfb93eb5
100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2785,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po,
struct msghdr *msg)
        int len_sum =3D 0;
        int status =3D TP_STATUS_AVAILABLE;
        int hlen, tlen, copylen =3D 0;
-       long timeo =3D 0;
+       long timeo;

+       timeo =3D sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
        mutex_lock(&po->pg_vec_lock);

        /* packet_sendmsg() check on tx_ring.pg_vec was lockless,
@@ -2846,7 +2847,6 @@ static int tpacket_snd(struct packet_sock *po,
struct msghdr *msg)
                                          TP_STATUS_SEND_REQUEST);
                if (unlikely(ph =3D=3D NULL)) {
                        if (need_wait && skb) {
-                               timeo =3D sock_sndtimeo(&po->sk,
msg->msg_flags & MSG_DONTWAIT);
                                timeo =3D
wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
                                if (timeo <=3D 0) {
                                        err =3D !timeo ? -ETIMEDOUT :
-ERESTARTSYS;

