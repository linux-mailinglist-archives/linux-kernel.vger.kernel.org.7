Return-Path: <linux-kernel+bounces-804138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F49B46AA6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C95D566D56
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD596280024;
	Sat,  6 Sep 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo4szKVP"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AA24337B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150232; cv=none; b=V4QwbE9YcSFRkq4cDJ+u4ApsD++5eS1dGwSkllCxUm6AlhfLS8MCQnwuHSgqbwV2FhOfYL672Rv/BSe6KonpbWFugiRp4ryFIFQR8O9OiD5RZjPsBL/WYkCNJiPpyOLTpzXBCTjCOR9/iyKzI3C4wPOIZJtGM/sNPNhyUvjJn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150232; c=relaxed/simple;
	bh=4tcf+x1bAGP5gLbbX2/0mJXn6QiSKzTB0gWtNPgyCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGneC3sKPl3QKIek5nHDMv1J9d9ytsgbJdKUcMrH2UJnWMe87YQmvHX4L1sdBEiAVUQCr5a2L/JfX2sLJBIV3ThKTt7nUwlIExb9CofUx3XMm6efJkym+PMT1sqgk1IHEWwn+DE1IA2ID35hwGPuFUNqxf2vuAaNw9CTPyDGioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo4szKVP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-811ab6189cfso125008385a.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757150229; x=1757755029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=Uo4szKVPKNwugn/xYEwclUxWlsz/wfzT0y9wtG3my9pHhhcL8wsOsbrRJZDfUE+9Vd
         qvkuh+VnfzmX76DBCPWCv1gaIuMdie+q6XRHbVKvwhgAe8WqTMih8rf3oXo7MtKzOqzv
         zAst9Dxnbkk5NC16gEv0aSMfZ3MJDI0sFkA9l8xteaGy0z0HpvS0fLcq95u0c7ypFFNQ
         j8dNe66mdVCav+vJOz/byabyP+13IqJQ3Uz4R8+GqF7Stt0cbNPrzcKvjbGXyQkw8ttk
         XjEfxfTytfyVaULVheLtxif9fxFABEp5m+r671ggybaYPoo5GD/jplvX+UVy0Jn/Pn/v
         C+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150229; x=1757755029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=RFTSxzajVwiFqX9VlqzLKrxCRG54EsGWBUbERFOXNKL9yGjkmI8R68M/sTwMY1yCEU
         HC41L6xLz00c7kfvYwbXf1qJTMu+JHHwsVfIFhixK723VwPd6GFNTUuiLKmlWuX8iDkY
         CkckmHQTU0W1Vo6m90PdpVqDxVy/MCgZ+rjm7Q79Kqh2LhCWk9TIqoVJ6lw8cJLgxfac
         K3YOAguNvhtC98x8cP5+5dB0cpj2I3zZg1Lg8P8ahsqv0BAagldxFmJGV5uuyqgz8+VH
         ge/rwWb3g1uWzlSMnpwDX0q2XAmlAIo8+qxr5Uo9fdvdUGQjF1AwoPlXaoVrA/lfjCWm
         ZHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn87AHq7QKStzyCp+lfWuxk7M8BdFQBce/mLOtRfhvRj5/H0N89v89pmvpYn1ouJQL6XkQXnr1DKXiErA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hFWx5w4gYfuQfmU/plC9BAR4gszamO7eP6L6OvDt0NH20JAr
	sHcyJhY1RnSYSR5hMQ48mJGN6WoPnea5YwH6U5aJB7+jV5LoWO5CmicO/nmK4u2A067/ChYW+Ou
	5pQgl4h5IU2Qps++I59k4SCM2xvUDI9J6GPzQHs9H
X-Gm-Gg: ASbGncvVrvohTdgN2EJZD7jQk1J/V0VbUE9N4a65StPLWAlpJQNQfFVijwpUXcdlM47
	cDtPVJnhmXsa+Bt7p0T5NcNYIglbqSTZAjs+nreSfSwb31EtitMYcThm3xKifITGsR3HUSrmWft
	6617GqZTRdNiX+J5tatbxGlemVK/j/l9COquca0ilzcumKrXhGhw7S3UPba0VKrgaKNnGVTERzY
	ghqqZGQKoVf27HTj3GzSz8=
X-Google-Smtp-Source: AGHT+IFNHk3o12uxwbf6OpMNI0I53ugLfIK2NXUHGthDfhTNjq2NSap4D+GDM5PavZ580+AiwTooTru70iUwX14qHME=
X-Received: by 2002:a05:620a:440f:b0:806:7c82:fd2f with SMTP id
 af79cd13be357-813c33dbd99mr153395285a.75.1757150229022; Sat, 06 Sep 2025
 02:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
In-Reply-To: <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Sep 2025 02:16:58 -0700
X-Gm-Features: Ac12FXxOqkfzxU_8v9kW7s_ChUAwPmKMRLy0TrO1zWLZ0WwxfLDIRZs52c2CrbU
Message-ID: <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:

Note to NBD maintainers : I held about  20 syzbot reports all pointing
to NBD accepting various sockets, I  can release them if needed, if you pre=
fer
to triage them.

>
> Question to NBD maintainers.
>
> What socket types are supposed to be supported by NBD ?
>
> I was thinking adding a list of supported ones, assuming TCP and
> stream unix are the only ones:
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6463d0e8d0ce..87b0b78249da 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct
> nbd_device *nbd, unsigned long fd,
>         if (!sock)
>                 return NULL;
>
> +       if (!sk_is_tcp(sock->sk) &&
> +           !sk_is_stream_unix(sock->sk)) {
> +               dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> should be TCP or UNIX.\n");
> +               *err =3D -EINVAL;
> +               sockfd_put(sock);
> +               return NULL;
> +       }
> +
>         if (sock->ops->shutdown =3D=3D sock_no_shutdown) {
>                 dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> shutdown callout must be supported.\n");
>                 *err =3D -EINVAL;

