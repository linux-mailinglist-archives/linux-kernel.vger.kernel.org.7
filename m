Return-Path: <linux-kernel+bounces-894352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E0C49D19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 142A14ECFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD5305043;
	Mon, 10 Nov 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="siIW8zRY"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380C2EB5BD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819022; cv=none; b=MYWCiqPvkVd1ihlWCKrMkp5o0uVoJ+MWxbX3/YitvsxuzT5O8Itua5usv2yfr7p5MRUps+sSnlsDwm2GcGYf2ohlHymEVsg9KYQRLRSck7IopGfKEc+n09Pk/lGpw6WYbZzAFJ/E1j4Bfwho+ArkeDUVYHUsAv2I1FsjTkp3tEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819022; c=relaxed/simple;
	bh=tgfiS9cTra3MjR8Qx3EjT2AU898OkeuQf4TpjzJhbkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2BvLkNMU4vR4KmHb/e0mMcsOpMPnBm1DGwGj1vUX11HBNvyjYCGw863wC/dYaQqdHY41lMXpmZ+DhJ/tn4ycVfDyBhTnEi3y6CXRlsps+LPuO/jfrRKIWpxRwsOTtjgaBOopocN5K2Th7STJ2IaDbMzBqjUN2P7jZU1YKDnmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=siIW8zRY; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d4f2f13dso2293468d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762819019; x=1763423819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nj1q0mNcasYTnvKP6x35pxta4p3k2au3FFGEe/4tvQ=;
        b=siIW8zRYc1ReXTsTWSrWGloL1nOBHgK3ZKVtOjr5UnCW0OVD9mcV9NGbbWQh6XGHQ8
         rgf8IX0zB+WjQmJ44LrJZxCXRG/Ef/ic35wy09a2RlCedUJKMgJ5yPbn7vodnHLzvHtm
         tzVuIWSmklSeB3q+fuL9WmlhCz41m7VbQ6AW27EW+2iHrCGhn6gemRcNsWNbt9A9SZu7
         h6BernU2zDVKqOYKA6uxWOCfQbGVGpU+vfTb1vFn092RJh/Rkxj3ExmCY/Q7fS9VQ7l3
         lrn/ek8rBdmxj1HDs5TBoE3a7l6cOKeNaKgy+ag/AY8+o/NvCedvYCLu20mOlFv1ALmF
         a8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819019; x=1763423819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Nj1q0mNcasYTnvKP6x35pxta4p3k2au3FFGEe/4tvQ=;
        b=KZNS7vImWw1hKKHGDQC/u9FYh2Zy6OmuNz/jfRCba9A2AReaOe1Gou4l/bh2RJk5n+
         LcJuOw6p+6NsxodbDNTSJkH7VCQltHWfl6gztbbgcYOSfwzI1H04kraYXs8rEMDXwrTn
         yvhVgCrZBZT2R2TMXLAfNMU27OmQMHjoa0MM5BgE5Eg+xjjTMhFpw+znCMJKqg/SFBYo
         FYnh5MdiYJP4y9GyboJwKBi7lWnE5v8tyahTNToewZrLm+Zj3HdUmE8wJDWtA2DNuBLO
         Xa/7+4G91mDtzJO/oRujPbN9Rdl+L/aKBZdu8EIpLPDTF7PI8CylvBwZt9Rt4Zp3yzbF
         vnLA==
X-Forwarded-Encrypted: i=1; AJvYcCUtfeSkniyFKMelpzqjYE9wb/bYwQyRlJw8bFg3aK59MJkecLq+RoI8x+yhVuz/Rp9WCH2NVDorkB8iRBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy4G+X7qqG0ObwyZnXxJDS7FXFuvbNFx34PeILJzL5snXcOZR
	qsIT3NpnHwNEf2C1L/FNcjUFBuw0zaBzmcJqSeuLff2xSrFHReeauM9yoQbJQCDFT3PqW0GnyvQ
	0JSXD5RvG9dzxQIDW7bZeVUSGOY1XkzBNLEQ5/vGAUg==
X-Gm-Gg: ASbGncu15oAIt1RfT+H9G9/s4iQ5v+vZIUQ9jbVpEGQO+HFBl6u528GVQ6dNaA5sht2
	sRnfb0SDnOSJZ8wsgkLXxfde+/pgK6wPdDoNyrkhrZgu6n3SgN/kZz4SVVncn9aiGEMSSBMnb55
	ditrExQkeTVV+4Bwp4n4E+kdaY+uS/WzXUTT4YCp14Gn3AAW4j5Wnrkdj/tZ9enBMKL298pSAyZ
	CYmS2/YJfel3nFlT2oqNt7J+b0pPGHPBFOwTdayrgmqdk2aKj4ewi3wjKthXUk=
X-Google-Smtp-Source: AGHT+IEYS9SgK5WzsgyfFw2SD3xybWKtZXTp6PZoYwrkPfKwTSmMkqLzXwB/JbmTscVTXPcbHxNw0AfHx1HwzeaUldc=
X-Received: by 2002:a05:690c:4681:b0:786:4ed4:24ff with SMTP id
 00721157ae682-787d5350164mr91957387b3.1.1762819018909; Mon, 10 Nov 2025
 15:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-13-tj@kernel.org>
In-Reply-To: <20251110205636.405592-13-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 18:56:48 -0500
X-Gm-Features: AWmQ_bnZeNnUS9oP_2Fx4DPImpvH26pzs7x9mbIoeSRMS41rpiNw8pWfz58gD0Y
Message-ID: <CABFh=a7x4rXergkASTr2T8c20Yu1E0+_5ZaPijLhzGEkM_Pmrw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] sched_ext: Factor out scx_dsq_list_node cursor
 initialization into INIT_DSQ_LIST_CURSOR
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CUR=
SOR
> macro in preparation for additional users.
>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Acked-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  include/linux/sched/ext.h | 7 +++++++
>  kernel/sched/ext.c        | 5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 4b501ad7a3fc..3f6bf2875431 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -149,6 +149,13 @@ struct scx_dsq_list_node {
>         u32                     priv;           /* can be used by iter cu=
rsor */
>  };
>
> +#define INIT_DSQ_LIST_CURSOR(__node, __flags, __priv)                   =
       \
> +       (struct scx_dsq_list_node) {                                     =
       \
> +               .node =3D LIST_HEAD_INIT((__node).node),                 =
         \
> +               .flags =3D SCX_DSQ_LNODE_ITER_CURSOR | (__flags),        =
         \
> +               .priv =3D (__priv),                                      =
         \
> +       }
> +
>  /*
>   * The following is embedded in task_struct and contains all fields nece=
ssary
>   * for a task to be scheduled by SCX.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d16525abf9e0..82f0d2202b99 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6249,9 +6249,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_ite=
r_scx_dsq *it, u64 dsq_id,
>         if (!kit->dsq)
>                 return -ENOENT;
>
> -       INIT_LIST_HEAD(&kit->cursor.node);
> -       kit->cursor.flags =3D SCX_DSQ_LNODE_ITER_CURSOR | flags;
> -       kit->cursor.priv =3D READ_ONCE(kit->dsq->seq);
> +       kit->cursor =3D INIT_DSQ_LIST_CURSOR(kit->cursor, flags,
> +                                          READ_ONCE(kit->dsq->seq));
>
>         return 0;
>  }
> --
> 2.51.2
>
>

