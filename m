Return-Path: <linux-kernel+bounces-871205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF9EC0C9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987694E5D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CC2F25F4;
	Mon, 27 Oct 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6Wo+c1U"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA462EC08F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556692; cv=none; b=NFSVelU5atDphy7dPEOigl5jlRk2eUuCI5tzsgadGTyU3e+zVMGryZk2zpjC8qHLmmM72JaGsfGODEfRANrtcNJQK3eZ5nu5/5LD1TaGVkrWbqgPyuH9ZXb+4/rMZBuIsR0wVo3xsHpQQ/j++vxBWEKftSkUQn3p0MmqxbX3W20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556692; c=relaxed/simple;
	bh=fPskHNpEnASinQ2bx7vkp4RFIOTfzZ4Tr1rU4FC5YBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6WZcXNaIn7SrF6MYM6/7Ke5Qlw0NpkVhGhdbiRHzk1gmBYwuztmAJ2uQFwXvaYKa83jixzwbT9o6AXvCTBI/CeH+aTjnh1mDe1dhdZTakjxk/TTbDqXGf74IcTl5sNvwmY8Gu44Gm4pLXzO8rKcXSu/OOz7EqyC6g4q8BH6iU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6Wo+c1U; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eb861a8e66so36463681cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556689; x=1762161489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=L6Wo+c1UGYfbusRJKURqQ7YfENnRCvFkLp/MFu+ehh8E2a8uym9+d8rGA+jEpgdBBf
         7RKXqCEBMoUvp0Zegr7yZK0aHf2wTqcc8Fh1kciWnN46aH4nnN7RmTJQ9/d3MKtRV6dn
         lq1ZPCh3qJ674HAmXT9plsZ+GnPo7C1G9EZq/gteJOs7Fex+6/b1wACviXmT0YDR9qoV
         PsrDJswL4U/4UgQypHbBxPZ1sgQh48V1PYFpW2/lwmNQpDwY4xuiUR9yLSMPJkD3NQv0
         tryZwm8gOqbSxhb2z3EuI0axV3gdeDT1VJSIPOWlVvbuH8AKL6LG2PlVPoeFOM20yphn
         nP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556689; x=1762161489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=joUyP7jExdDyv8FCaIqRC9EUPclJRL+zDkPqyZr6uAVZrose/sOPu8iMkeTKDFCj/h
         FsdeRdd8qCU2EkmExELczdol9qWUSVkXOstY3r78F026E/Q5sIPHtarS6gq5mTFm3b2O
         iYySxieYxu1amVaBYu81JdVAPYTYXSkq47NQ4i85ycQtJy3mmfqJ8oVA8q3SyJ6ZlXE2
         Q9HvYFAjTOKlEfYFF/2FXD6pnpat9bNVRzoNMWAYu6K3rPO4iBDhHu9GKhVVTv/0G5Mi
         nW0fZBRqwgkKawvQqfW/7fBjyF+FP+gmRpMU4boNGg3ipIOQUO4ibQ+ExVsY2M9RH6Y7
         DAWA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTEXLv3xEgJE1fCPXsSfiMZ74NxKqlQbsPiCCFlVTBJiErH+A3ljLv+mqrpnOwJK8nyXfGQr5vdewQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2lVo3WpI706rvhW43aqGIG40Zvz4mc1afCYDo5oSVDC+LfjP
	OqNsujvgWFnfs7rkbRypHBptqRLaGTiMcPcgeoDvW/wxYfgeLxOZEvhu6moQWF0kBRbzVlEZDtb
	MYw1k1c5B1M6i6aUM9NvhvAuD7MS+DC3SuGupgu5x
X-Gm-Gg: ASbGncv9xrnsr0NRJcxmO/N0GIPI5/UMWx6Ryh5+WU4wILOwCxtWHkIOwzbe0bmOG9R
	rg/CHGHGrKP5JsNuf8BGMsq/ejhO7CxXp8uTdLElaeWS1KUMr9EL31h08cKNjFtk2QazwiEayNI
	LvBGYfCTnjWlKAq5XI0ZNpo2bgXU5WAVAfoW+XL+2jqmB8Z4jaNP9ZIpkEgjg14r3DnFRQrlRdI
	rpeX7b4nAH4XNvZrIYPo/1BQOOxLVxyck0hq2UFEewARDWa2ECJA/cRjTFyLK9CSzcXDa0=
X-Google-Smtp-Source: AGHT+IGn9kiXC6v55wZ2Z6kE1uL4cTaogteQRe65Qan4CvgMr20ojg1DZQnSbG0o49HMvVhY7LnDKeEAhavDJCrNcCY=
X-Received: by 2002:ac8:5a43:0:b0:4ec:f1e5:1b21 with SMTP id
 d75a77b69052e-4ecf1e51cc1mr36707271cf.59.1761556688706; Mon, 27 Oct 2025
 02:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:17:57 -0700
X-Gm-Features: AWmQ_bnwJIlS1v6l9rdALIdpQrpckWaD6-kZUS-gDcLcLrRu9vSgbv1vyX_nN2c
Message-ID: <CANn89iKbLadNizRB28AoNw8McQXgqtknbH3zdhErDku-m5rjqQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold sock lock while iterating over address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We need a changelog.

On Mon, Oct 27, 2025 at 1:50=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  net/sctp/diag.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..7f7e2773e047 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -223,14 +223,15 @@ struct sctp_comm_param {
>         bool net_admin;
>  };
>
> -static size_t inet_assoc_attr_size(struct sctp_association *asoc)
> +static size_t inet_assoc_attr_size(struct sock *sk,
> +                                  struct sctp_association *asoc)
>  {
>         int addrlen =3D sizeof(struct sockaddr_storage);
>         int addrcnt =3D 0;
>         struct sctp_sockaddr_entry *laddr;
>
>         list_for_each_entry_rcu(laddr, &asoc->base.bind_addr.address_list=
,
> -                               list)
> +                               list, lockdep_sock_is_held(sk))
>                 addrcnt++;
>
>         return    nla_total_size(sizeof(struct sctp_info))
> @@ -256,11 +257,12 @@ static int sctp_sock_dump_one(struct sctp_endpoint =
*ep, struct sctp_transport *t
>         if (err)
>                 return err;
>
> -       rep =3D nlmsg_new(inet_assoc_attr_size(assoc), GFP_KERNEL);
> +       lock_sock(sk);
> +
> +       rep =3D nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
>         if (!rep)
>                 return -ENOMEM;

If -ENOMEM is returned, the lock needs to be released ?

Please do not rush patches like this.

