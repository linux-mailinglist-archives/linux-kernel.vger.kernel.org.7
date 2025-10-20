Return-Path: <linux-kernel+bounces-861372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B57BF28FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E49460668
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0432F763;
	Mon, 20 Oct 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNXt0DvE"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FE32F74E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979227; cv=none; b=EmY+Y6VLl4EbNWRCzli8nKdSXnmzW0jKWumr/yK3Or4Zi7f2xhwA8ckmJtRYAKeCpOx1Rd7JcvrytuSVSXECwhQ3uQHSumJsGnPN6sJiO60j1xYLAeag+sOuzeJklrxsBJhbT6wU4+me/v/dhl5hTkQcNz9juC4p74RO/rT8wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979227; c=relaxed/simple;
	bh=e+m6gKrJ9WVNcgrFV+aGX97kgnEJRRQEVjtTKxNaaSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5pWYvBCsqxdcF7fsNwH8qc+F7DsbS4MtoWXU6M6IffhzeXdWoeEDE0B06gIShWdq3LpIB4Svnc0CqAPxpWA7lyQZdkoGY5Ib8G4zsigzXbtlPI1/ExDGQs9gBouRE8z7mtoQ/RPr6SktafAL6Im2lftbaCAjigfZx3HZ+gbFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNXt0DvE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso2969369a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979225; x=1761584025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzrlp9ive4cPf/LVzIWWzUA3F4N61vvsn8OSNz8bN+E=;
        b=cNXt0DvEY8h8iMHGJQ76f5gu+dvr0ZElqSQDwIIJZSJdS6dkpJyQZ3hDiS+LlOxGLE
         IfFev5UOuL5cqR9Gq0kk6YuIp0Ps24t+LVBMVCYvEwsNIjkoCnAi3MOaYyW7i0LaLvfa
         got9B6cZleN2R1ZY4F7O0erI0bVJ9n2Kd9Q3mMIoOlnHPhJ5VqqP61e8nf5hBDONnlJz
         NKWbTTLdkMg9UzDP3RRKv0A/rk34J819LyN0Acqws6ET77M0X4ix0SB7qVA77ZKb+BzG
         /plVyhHGuE579Q6tt9sgDbNuWoGiWuiGAppBAsxBElJxEuRvbj9LkpnpiQl/U9QtFIBr
         8v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979225; x=1761584025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzrlp9ive4cPf/LVzIWWzUA3F4N61vvsn8OSNz8bN+E=;
        b=XMzwMZ8EHYJYL7bWq3+kcEhq66/5dguPkia44TLT8pQL8sFKA3meZeqK33U/0xSE/w
         jSx8Obz3yNenae38Vq6EWo1+nlUUzSBlMYfIPRei3JC2/LxNE9rKLdMKN8VOAe8oHQY7
         yn6w8XSUZEYTxzx/3BzH+5O2xqvoq1zlukG5SbOnvITx5uWotQR7G4oFinrZaN+vhIkq
         T2vfYNVlr5SMWz+gnLks8QQZ9uB4+d266b977KsA6LqGKz/QIf6YctC9wUMRF2LkBbBn
         6QBnJqrCZuSHSXS5V6UuJ6QD9ENR5HS4YK4lkwsOZQ8Mq6/DvF5aS9hp2Wf7EZPjeaEo
         V1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUoetpRzCDyh3PxIcsNefwSQcTmYQezTSpxd5MtvgAGqsdoQ9jlKaGCPkmJ6Z9pOazhsdkLShHjMQ5f+e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4lzLpCl0YbxTECEnmJy+WfEA2/MMvvtx0ZRcI6+/KR09yPss
	GEXSNZjkSw9EGU8VbbLTwtCRtHM5kPHYznHB44JlahTzRTrqrkQh96DdUzsO/bzbSneYDdRli4H
	lWGk53p4keBlwjGOXajqAPUn+NgMy4rU=
X-Gm-Gg: ASbGnctV5tF+OMG9hdrCxUXJAEMwb/Qi8kib2fF5iifiQWPa3lP4/8pWbYhFZhSNvfd
	koHeWAsAJ0NwZfgrmdP2BQKFb02uM8d1A0VpO7x7/XAh7iBMlEDKWT+LEdqQotplEl8L4VU1Dhh
	/9rdFWdyl5Iyg1bqqfxD4tUfXnyLW7uHyWZ9+e4WY26dBPe6MMzn3WOmk8eKJzEAdFTwbTMHVVP
	FYr3xO+asYh3UVlWtwC7yhGSZ48syPkuxpTBNNtaZaVJkVZO9BpUUt3TCDBfiBJC8skALWPRxSU
	hfmbLdaE78j0gQ==
X-Google-Smtp-Source: AGHT+IHRLawtbL1et4hkHzQFikS9RlkgNZ3tXH8Fnn3CVZHXzJcNVH96n3jZk81ZCVZWEMKh95kb9ashTsLbS1kPQ3M=
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id
 d9443c01a7336-290c9c8a738mr162660385ad.9.1760979225307; Mon, 20 Oct 2025
 09:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-imx-rproc-c3_1-v3-0-b4baa247358d@nxp.com>
 <20251015-imx-rproc-c3_1-v3-3-b4baa247358d@nxp.com> <aPZXNlY1MK4--Q_g@p14s>
In-Reply-To: <aPZXNlY1MK4--Q_g@p14s>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 20 Oct 2025 19:53:30 +0300
X-Gm-Features: AS18NWCDDzyLXdoJ1ww-uT69WkAwCVMMmB4swG4QnzjbOUSySmr_LsY0EDRbg2A
Message-ID: <CAEnQRZDk0qLb2kegEZrE24oBfoKjqcc86N5e9QLB800vsKbOoA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] remoteproc: imx_rproc: Enable PM runtime support unconditionally
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:40=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, Oct 15, 2025 at 09:52:57PM +0800, Peng Fan wrote:
> > PM runtime support is safe and applicable across all i.MX platforms, no=
t
> > just those using the SCU API. Remove the conditional check and enable P=
M
> > runtime unconditionally to simplify the code and ensure consistent powe=
r
> > management behavior.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rp=
roc.c
> > index 820b0cd5adbb17ce5665e7ec2786bca23f1a67ea..25f5cb4d414eabed7a166eb=
2a8ae5e20b6b4f667 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -1119,12 +1119,10 @@ static int imx_rproc_probe(struct platform_devi=
ce *pdev)
> >                       return dev_err_probe(dev, ret, "register restart =
handler failure\n");
> >       }
> >
> > -     if (dcfg->method =3D=3D IMX_RPROC_SCU_API) {
> > -             pm_runtime_enable(dev);
> > -             ret =3D pm_runtime_resume_and_get(dev);
> > -             if (ret)
> > -                     return dev_err_probe(dev, ret, "pm_runtime get fa=
iled\n");
> > -     }
> > +     pm_runtime_enable(dev);
> > +     ret =3D pm_runtime_resume_and_get(dev);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "pm_runtime get failed\n")=
;
> >
> >       ret =3D devm_rproc_add(dev, rproc);
> >       if (ret) {
> > @@ -1135,10 +1133,8 @@ static int imx_rproc_probe(struct platform_devic=
e *pdev)
> >       return 0;
> >
> >  err_put_pm:
> > -     if (dcfg->method =3D=3D IMX_RPROC_SCU_API) {
> > -             pm_runtime_disable(dev);
> > -             pm_runtime_put_noidle(dev);
> > -     }
> > +     pm_runtime_disable(dev);
> > +     pm_runtime_put_noidle(dev);
> >
> >       return ret;
> >  }
> > @@ -1148,10 +1144,8 @@ static void imx_rproc_remove(struct platform_dev=
ice *pdev)
> >       struct rproc *rproc =3D platform_get_drvdata(pdev);
> >       struct imx_rproc *priv =3D rproc->priv;
> >
> > -     if (priv->dcfg->method =3D=3D IMX_RPROC_SCU_API) {
> > -             pm_runtime_disable(priv->dev);
> > -             pm_runtime_put_noidle(priv->dev);
> > -     }
> > +     pm_runtime_disable(priv->dev);
> > +     pm_runtime_put_noidle(priv->dev);
> >  }
>
> Daniel - what is your take on this one?

This is on my todo list for review. Will send it asap.

