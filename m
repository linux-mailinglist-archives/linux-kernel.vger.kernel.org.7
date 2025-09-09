Return-Path: <linux-kernel+bounces-808794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE68B504D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE63A1899C05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88523570C2;
	Tue,  9 Sep 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi/Q5WSM"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B711259CA4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441127; cv=none; b=jRj8U5LeagkR8t67tG0O1YaOdqn+jwgnNfqTh620BIZOOySD9TJkCEbABtm0RIKOd3a0+iRHY0HxPA6SjdLaMGgbBWRj1LZ8rq/0DR/Fq+J/qccd5dcG9CrmsarlQfA0eEKKnC/abXITby2PizXWf3iPNcSW1YpmI3L+wioOQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441127; c=relaxed/simple;
	bh=KQnBKWiKGDvpyRUHkX9MClcceIL7m2tOELzThwhZocI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgbjeIXiEbTBC1uMytQSNNoEXRNXMpsIzowx+PNMyux3abI/vewsu3tRxoMHi0/7WRL/RFtdX4ZDVTpggcbs9v9u0We1yzKiS4+M2comQfinPopOSrOA/2kAkAtYEYOURfnqibiYryLt9cEN5gQxGFgwyuneCtWjRiHVZ9dbh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi/Q5WSM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5694f0e29a1so1395e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441124; x=1758045924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JzUzLkWPMiRqdMU2PWQrLrGvNPVrl2fkDBIgw67gME=;
        b=Gi/Q5WSMrC0wCOEp3QRMImuW9buVdiKy1KIsbhQKRIdjt5tu4Ze8/0KL1GcUM9ufNg
         PHivylWrP9aDsM42FKV3PuF29oJo45fG2zbbsWAiV0plKT3M0zo78sf1zFEM/dS8D9CK
         R6t+qohtbetx9LLIJ1JFlI7hm0ykgKyp2dArMknK8Xm7LMdA7ykpp4cuSLFJ3VIlZgOq
         nIQ9xxy/bzwub4SBfbB3kx5rIvtefef5Nhrz9r74MkQe+qfolrkiGxoOze60pRbI+Q8W
         37/X2SS6Dug3WSKpkCtqhh9yQVZnGjMkrX1LNauNcdN62RAzycgppRYD6YIqJlEUySTt
         +5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441124; x=1758045924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JzUzLkWPMiRqdMU2PWQrLrGvNPVrl2fkDBIgw67gME=;
        b=ZGwpriut2jPsYJgNCgzxiuQqFRSBBOzkvF5OWMBokjSoPmsUYdruxK1w6zLNiY+vVn
         fJFwNN1UOhhuvRBO58f80roiiQ76DMeyHUrFkOYsE5CxXqhj7ahprTkaTKqmTcY0ZsJ5
         cPPNUlg+rY+N1CkXKeZPI2qGdBautzQB+CtTwDMkF/RcTjm+C38cRzRkE9xtj2VkLahj
         JHAoISHTkmJF5LwZsNxyKneVCpO67fWLJ1ycXHMaBMZKtxacTTwgsNfkymaXMI4YhiVi
         iTnTDUYaHiUIjC0pfhuvHwsozElZb+9zVcltOzYC6ZbmLbyUHE1e2wiPUQqt8+yhqWey
         Zjvg==
X-Forwarded-Encrypted: i=1; AJvYcCXKsOCAWEB5Y+uJ8ezXGNREW4zfnh6U+SSmExu9qkgj+4NmMKhgeUsloZDi1/0uH7wxBiCkALNpwpfLbNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxm7eS+7fQ68SMYdnFdDV7Z0/O74CS3wOYklhRfM9khpIIh4M8
	mT6E8HUJ61xXo412vAbLyJDNkwGSwOEdBJNZdw13GmvPcLhVtfcex7OgJCD6Ff051Ehaitvc3ZZ
	NEa/ezpzKYZFnL/YrI0WOP7SvY7PGippXg3opLKLJ
X-Gm-Gg: ASbGncuoYqxDzT6J6NVWk4qWa+Fbcy1H3+DGR1QNveIG/s074G+Kp7t96TxfaXxKnwi
	xQ7eR1L932XBxzSI9CBkIIeMhaSGD09YM+WSMp3ojEuI4FclNUjaoIsULjAAHogRyM1klPu/AaT
	jJPpcPkF8DCK2UbFXLGsaO3zVBGWj4xzO8M4yxzdB08PZKbGr4d07mxaEbvUNt63pzxpP42qWfb
	Gf2iOUA1wEFC65J1z1PVMqtBg==
X-Google-Smtp-Source: AGHT+IEq0HRTqN70vCk22jYNZP5mnjKPrWVQCw7vun9YsLjMMwNy0CqRt92AN65UbMbFM9LD4XcQLKRKwceU6IW3cTI=
X-Received: by 2002:a05:6512:428a:b0:560:8398:e9a5 with SMTP id
 2adb3069b0e04-56aed65b73dmr20459e87.2.1757441123492; Tue, 09 Sep 2025
 11:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908175045.3422388-1-sdf@fomichev.me> <7726e657-585c-42d3-aff2-c991eed42361@kernel.org>
In-Reply-To: <7726e657-585c-42d3-aff2-c991eed42361@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 9 Sep 2025 11:05:11 -0700
X-Gm-Features: Ac12FXwbOdbzcbK_hUaTNFAZfeytFY_q3maZDk1PEYKLZ5mfBs3ETGGpJ5DRyzw
Message-ID: <CAHS8izOSONfHk2pOYpoRxHNGvp3i6Lg3+FBsjZuRz6NAOOkrxw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
To: David Ahern <dsahern@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, 
	kuniyu@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:44=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 9/8/25 11:50 AM, Stanislav Fomichev wrote:
> > tcp_recvmsg_dmabuf can export the following errors:
> > - EFAULT when linear copy fails
> > - ETOOSMALL when cmsg put fails
> > - ENODEV if one of the frags is readable
> > - ENOMEM on xarray failures
> >
> > But they are all ignored and replaced by EFAULT in the caller
> > (tcp_recvmsg_locked). Expose real error to the userspace to
> > add more transparency on what specifically fails.
> >
> > In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
> > copied=3D-EFAULT` is ok because skb_copy_datagram_msg can return only E=
FAULT.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/ipv4/tcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

