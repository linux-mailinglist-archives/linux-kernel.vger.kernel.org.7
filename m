Return-Path: <linux-kernel+bounces-724625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B560AFF4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA81C82505
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F73236457;
	Wed,  9 Jul 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDGu/qpf"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39B219E8F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101553; cv=none; b=Cm1nTqBLch5NYsC9k8oOp4KIIshjNVUuAE3TWq8HiwLzqpAnRNwlMWGD0Vg3Ot3BLFZBuKW/cSGAqy9s9H2ZNNFO/FYvvy+cAKWtQs7amO+PkVy61mHm7jwFHbk9wARQ79nCg25qfKhXoaTngjNSYCO7QUUL+UPB41iG0WMQlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101553; c=relaxed/simple;
	bh=u1Fj+kkUjVSJsYaXWgjdpqZKkvw6JkpafoVrzmBXZQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGzWMpPJH0dyMxjn/l7itcRYJq6TRZIdSEJ/nv8aWyBSthQNijYa6xhvrpCA2L00bp15u3p6zy9TqguKjHB9xyj+Hsr66RKONepzeNP93Pf/o7ZXZhEK1l4zYUMQCrcONusR5UZuEqV6dbuS7rl47dwrI30+F5DoNkGhQEFudoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDGu/qpf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2f77591f208so211606fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752101550; x=1752706350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ/jO6E9mFWmSJKCA/T8EW+3CyqgJCpMb+i+FDIme34=;
        b=VDGu/qpfST39YGT6Id67iJXvAhlFWnYLHAiVCxMzBNMY5Zg0iq2WnXL1ugzzYpzpdS
         8BV5y2qGclzxRSGhGV131n9eeF+GK+JPw/3ZztTpFpk5Aa523jms7L2MekFUiBGJWeGR
         McAA76SQJ7+QIYIuqsWU3zCjp3a6L8jL1rYD71TRChQFuNpekFLoKThHpX358DPNiwiK
         H+FUkLr9jqo81XU1p6/QZkLDl1aICExT/6l7XeMJ69qWsvjmIuYCcUA2v0oVpDJk91wk
         3+sCFcGYvhQxapElAKUqD4XcekqHv9IBwrCg2TeA88e9mSNyn3qdnPqHGtAnG14QeGH3
         p62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101550; x=1752706350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ/jO6E9mFWmSJKCA/T8EW+3CyqgJCpMb+i+FDIme34=;
        b=OD1NSRiF1jHYvGSbsY64mjIAN9VSKHKuLAHG1EIM+6R76T/284jHAYMKg+yDZseZ3j
         6EKM1MHPUqZf1wIyf34LHU1LWQsCXZOfptumXPPPPg/2U9fd54o6JDRz0EXCKJJ6h1CM
         dFFD4uZ05z4Q1Jwxdt2lnuCwgRDPc6RxBMysX1vcvELjKHEpVjh0R44OUiA8NJGc3Ack
         neVBqGCT8r2ghIADu/M4BukJbOamdy+qYtEMCM5cH1kqrIZ1sy4RTDMGcInavBwNqHVQ
         zNHEfNnKytkjdT4BRFt5alQegVX53YQb7uMS/nnycqIl3DeFT8aeQ30w3/wC+/eDOw4J
         gOMA==
X-Forwarded-Encrypted: i=1; AJvYcCWAgPqZRulAF3SzxYX+RnMiIxrE2K6urDjSxvqQ1PnlfmgnGIK5N/4jID9YJ+rb6fBSQc2KO3iQ3HjwOeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sNU7G35cyLUSAHrgSeo2O/aGtfHTJ8I5omHYrQlfNO9lY4H1
	ALvhl9lCeZA/AwpkfDxiVwPzWFb6ezdfddtubDEQHT9//A3QWXxjbv+B4CB4F4kegesWkOoQ8W9
	x8w0dPC+0rNm3aW7BZZx6p5Hq1hchQnmN/renHqra
X-Gm-Gg: ASbGncscmKZdELTmsW3ocWuGvProSDhEE82BNRihaWK8vwkoNJuNFtM8kfXw7H+vrIB
	tks4Tb4XJo1aW6TQkxBwqBD4Qxge3TlYHIPJ+SMpmBjLxSsNARzW2dVyjJftTvftaQYxr5Mln/G
	alwjnZYfrqWOtHbNrKdLK2ILLeiCI7WSQkCDRugF16mgRArm27X31W0V/G3hqelPZvbQKz9POZP
	Q==
X-Google-Smtp-Source: AGHT+IHIV/3z6PdLLPSDIyl3VRl88VX2aPY1onB8eflF+EcitN+UIHC9L9hxZeVemwR3ytTx4eUIzfgYk8t9xXNN99w=
X-Received: by 2002:a05:6870:a508:b0:2b8:b76f:1196 with SMTP id
 586e51a60fabf-2ff0c8629ecmr956460fac.19.1752101550160; Wed, 09 Jul 2025
 15:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-max77759-irq-wake-v1-0-d367f633e4bc@linaro.org> <20250707-max77759-irq-wake-v1-1-d367f633e4bc@linaro.org>
In-Reply-To: <20250707-max77759-irq-wake-v1-1-d367f633e4bc@linaro.org>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 9 Jul 2025 15:51:54 -0700
X-Gm-Features: Ac12FXwBCWPW8EZwuDpf54UTDanwxs202yidYGWWROmZV5BpUoEW98OitzLt1EQ
Message-ID: <CAPTae5KKK4pYo_BdK90=9u+5C0TeRHXnWKrHM3qzMpZ2yzWK5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: typec: tcpm/tcpci_maxim: fix irq wake usage
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:50=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@li=
naro.org> wrote:
>
> This driver calls enable_irq_wake() during probe() unconditionally, and
> never issues the required corresponding disable_irq_wake() to disable
> hardware interrupt wakeup signals.
>
> Additionally, whether or not a device should wake-up the system is
> meant to be a policy decision based on sysfs (.../power/wakeup) in the
> first place.
>
> Update the driver to use the standard approach to enable/disable IRQ
> wake during the suspend/resume callbacks. This solves both issues
> described above.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 46 ++++++++++++++++++++-----=
------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/type=
c/tcpm/tcpci_maxim_core.c
> index b5a5ed40faea9cfcceef5550263968148646eb44..ff3604be79da73ca5acff7b5b=
2434c116ed12ef8 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -421,21 +421,6 @@ static irqreturn_t max_tcpci_isr(int irq, void *dev_=
id)
>         return IRQ_WAKE_THREAD;
>  }
>
> -static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_=
client *client)
> -{
> -       int ret;
> -
> -       ret =3D devm_request_threaded_irq(chip->dev, client->irq, max_tcp=
ci_isr, max_tcpci_irq,
> -                                       (IRQF_TRIGGER_LOW | IRQF_ONESHOT)=
, dev_name(chip->dev),
> -                                       chip);
> -
> -       if (ret < 0)
> -               return ret;
> -
> -       enable_irq_wake(client->irq);
> -       return 0;
> -}
> -
>  static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_da=
ta *tdata,
>                                     enum typec_cc_status cc)
>  {
> @@ -532,7 +517,9 @@ static int max_tcpci_probe(struct i2c_client *client)
>
>         chip->port =3D tcpci_get_tcpm_port(chip->tcpci);
>
> -       ret =3D max_tcpci_init_alert(chip, client);
> +       ret =3D devm_request_threaded_irq(&client->dev, client->irq, max_=
tcpci_isr, max_tcpci_irq,
> +                                       (IRQF_TRIGGER_LOW | IRQF_ONESHOT)=
, dev_name(chip->dev),
> +                                       chip);
>         if (ret < 0)
>                 return dev_err_probe(&client->dev, ret,
>                                      "IRQ initialization failed\n");
> @@ -544,6 +531,32 @@ static int max_tcpci_probe(struct i2c_client *client=
)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int max_tcpci_resume(struct device *dev)
> +{
> +       struct i2c_client *client =3D to_i2c_client(dev);
> +       int ret =3D 0;
> +
> +       if (client->irq && device_may_wakeup(dev))
> +               ret =3D disable_irq_wake(client->irq);
> +
> +       return ret;
> +}
> +
> +static int max_tcpci_suspend(struct device *dev)
> +{
> +       struct i2c_client *client =3D to_i2c_client(dev);
> +       int ret =3D 0;
> +
> +       if (client->irq && device_may_wakeup(dev))
> +               ret =3D enable_irq_wake(client->irq);
> +
> +       return ret;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(max_tcpci_pm_ops, max_tcpci_suspend, max_tcpci_=
resume);
> +
>  static const struct i2c_device_id max_tcpci_id[] =3D {
>         { "maxtcpc" },
>         { }
> @@ -562,6 +575,7 @@ static struct i2c_driver max_tcpci_i2c_driver =3D {
>         .driver =3D {
>                 .name =3D "maxtcpc",
>                 .of_match_table =3D of_match_ptr(max_tcpci_of_match),
> +               .pm =3D &max_tcpci_pm_ops,
>         },
>         .probe =3D max_tcpci_probe,
>         .id_table =3D max_tcpci_id,
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

