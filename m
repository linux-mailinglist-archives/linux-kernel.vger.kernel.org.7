Return-Path: <linux-kernel+bounces-671782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D051ACC619
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5887F18825C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FF22E402;
	Tue,  3 Jun 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="iDSwMKXD"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20746B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952159; cv=none; b=sHtbLJtreEMvozENpQ2yZ1Vs3m+SZTnXsVd2XjmEAxxnFM6TvI14BXzXDQzusGiVNCDIULsK29ea1yJKUMSAgGvciLBFx3bUs0V11opnx41jSMcgidCbuRwQ3sr2QsXIZMU4Wrrh06ld1XYxnn3OByT8WorCPs7srS+k9jTmva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952159; c=relaxed/simple;
	bh=ySecT7oudCi62ydAA9H9f0Ik2okzEegA1oZYeqkiocA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvcYg6D8H+5N67jtW+ph30yuwcmDGFEm/2S0llyjoCZQLdj9SIhvr36PftXVJ4ghdNniut2IDIpKM/zErMhr6jv0HAzmc3OXK9JT45xCzfGQThH/xYIAsHmgdRcTSr0FKDR2zDDSrFlM5qjpd0Z1TBGWDQy0+HMBeq51NVU5Udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=iDSwMKXD; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so3836960fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1748952157; x=1749556957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l28DzIkqr4LEntW5mAp5FkeCY/PQV5pWO6CRFrpZ3n4=;
        b=iDSwMKXDrZdADo6shR67KH5gemOxSmhF5uAXvuxY2mYkAtUtR6Ig2FDANKKRMm7fco
         OjFbZhDJipDFoufWo3jYD+6pwAj4mBfZMV+2t8xYOOqbXvex6QoSyOKpK7vXxm1YVSsI
         jJYGHnMcubliFRa1Oxx5+o3Kg4TfOkFh4OUSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748952157; x=1749556957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l28DzIkqr4LEntW5mAp5FkeCY/PQV5pWO6CRFrpZ3n4=;
        b=Zf+1hxtrHzVNzoq6h3yE1YmxU1IQhCSqVurTNYaFjWS7ZezcBxfVuo3Lv54NE2BgVH
         YIn/+1+UGWfpLzHOrakgcVHyrbKJXlwDhYzyPy8a/yUJ/LDbnv7IRNZHbWUCE+J8DOfA
         d4qOkJS9v43quTxzphMeydKd2z2NSm/T00oHmQquyllOKLc1GLFX3XSUJZgvvyWabGQq
         swATF05ohWnvUk7dom4rXRa6wPAPVtKZfAugdss5flImQdcXKPcFjvLtq1W6gj+TACq1
         Ynif3vF39wmDbXoSrWSBaycCT1M7XKuQberQGRPr7mHu2FDZAXhm0iB5FKJc9sE4RI27
         C8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVn0ez5Pgb3w9P/qHT2l8Gj+jVlCxBPHsAqK0d8Lw9ylvyUErw8OzmJPtuF6UKy90LgGgrS+AuHqepzz3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZoM0hz6YMOjXNhdY+RmmXy61nnUGQ5scVz8P7bLE8tJMnjRJ
	SK/zX9OEPqDBH+VVr5X3+X0OX691dKPgvYqvUPhXi2CmKy5k4jo6ZWplJF+pLxTjgBz2neGLMaA
	rRTJxP3O6PXXszQQlcCkU5wa8xzqxzF5VWsHH8Ofi1XD0DXBI+N+ek4NVjg==
X-Gm-Gg: ASbGncupHFODFfUiMBRbeUGGKDKzbwvwytAcjRnG0LgFWijaQqhVactsHvYS7cq/IXF
	ta9i4Z9B08OUzMMpl4et8KdKScvx4Iaq5WivL8OShfS/i1frK5/HJdJxhG/aBsZPDqqQJtvXkmu
	74gDMp/gZuIRNiK71fI9pfRiROVMRIwaIf2OI9arcq2WVj
X-Google-Smtp-Source: AGHT+IH90LSqAhHHbxsryMPOBXHIM+oacXfr+Ou9Le9aECoKuqARpni6suYK1t3MEspshUGQKSRE8tFDeNvwiZvRRg0=
X-Received: by 2002:a05:6830:7201:b0:734:f8d1:6ab3 with SMTP id
 46e09a7af769-7385906511bmr1302534a34.0.1748952146469; Tue, 03 Jun 2025
 05:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602053231.403143-1-pavitrakumarm@vayavyalabs.com>
 <20250602053231.403143-3-pavitrakumarm@vayavyalabs.com> <9f6b4442-1fb0-479d-9514-410d4d8bfd98@kernel.org>
In-Reply-To: <9f6b4442-1fb0-479d-9514-410d4d8bfd98@kernel.org>
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Date: Tue, 3 Jun 2025 17:32:15 +0530
X-Gm-Features: AX0GCFtmQ3LxaxdSxQJE58tRGgH3M_sO7OJwM7eQB8o9k6zn20ZEaWVsKEKH-DE
Message-ID: <CALxtO0kitR0MnjzPwVT8nsuYThTRX+fbyOH9i2z1KKnCPg1dqg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] Add SPAcc Skcipher support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ruud.Derwig@synopsys.com, 
	manjunath.hadli@vayavyalabs.com, adityak@vayavyalabs.com, 
	Shweta Raikar <shwetar@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,
  Thank you for your inputs. My comments are embedded below.

Warm regards,
PK

On Mon, Jun 2, 2025 at 11:35=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 02/06/2025 07:32, Pavitrakumar Managutte wrote:
> > +
> > +static int spacc_init_device(struct platform_device *pdev)
> > +{
> > +     int vspacc_id =3D -1;
> > +     u64 timer =3D 100000;
> > +     void __iomem *baseaddr;
> > +     struct pdu_info   info;
> > +     struct spacc_priv *priv;
> > +     int err =3D 0;
> > +     int oldmode;
> > +     int irq_num;
> > +     const u64 oldtimer =3D 100000;
> > +
> > +     /* initialize DDT DMA pools based on this device's resources */
> > +     if (pdu_mem_init(&pdev->dev)) {
> > +             dev_err(&pdev->dev, "Could not initialize DMA pools\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             err =3D -ENOMEM;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     /* default to little-endian */
> > +     priv->spacc.config.big_endian    =3D false;
> > +     priv->spacc.config.little_endian =3D true;
> > +
> > +     if (of_property_read_u32(pdev->dev.of_node, "snps,vspacc-id",
> > +                              &vspacc_id)) {
> > +             dev_err(&pdev->dev, "No virtual spacc id specified\n");
>
> This makes no sense. It's not a required property. Just look at your
> binding.

PK: My bad, this is a required property. I will fix that.

>
> > +             err =3D -EINVAL;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     priv->spacc.config.idx =3D vspacc_id;
> > +     priv->spacc.config.oldtimer =3D oldtimer;
> > +
> > +     if (of_property_read_u64(pdev->dev.of_node, "spacc-internal-count=
er",
>
> You never tested this.

PK: This has been tested, but on failure it picks up the default value
for the counter. I will fix that sting.

>
> > +                              &timer)) {
> > +             dev_dbg(&pdev->dev, "No spacc-internal-counter specified\=
n");
> > +             dev_dbg(&pdev->dev, "Default internal-counter: (100000)\n=
");
> > +             timer =3D 100000;
> > +     }
> > +     priv->spacc.config.timer =3D timer;
> > +
> > +     baseaddr =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(baseaddr)) {
> > +             dev_err(&pdev->dev, "Unable to map iomem\n");
> > +             err =3D PTR_ERR(baseaddr);
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     pdu_get_version(baseaddr, &info);
> > +
> > +     dev_dbg(&pdev->dev, "EPN %04X : virt [%d]\n",
> > +             info.spacc_version.project,
> > +             info.spacc_version.vspacc_id);
> > +
> > +     /*
> > +      * Validate virtual spacc index with vspacc count read from
> > +      * VERSION_EXT.VSPACC_CNT. Thus vspacc count=3D3, gives valid ind=
ex 0,1,2
> > +      */
> > +     if (vspacc_id !=3D info.spacc_version.vspacc_id) {
> > +             dev_err(&pdev->dev, "DTS vspacc_id mismatch read value\n"=
);
> > +             err =3D -EINVAL;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     if (vspacc_id < 0 || vspacc_id > (info.spacc_config.num_vspacc - =
1)) {
> > +             dev_err(&pdev->dev, "Invalid vspacc index specified\n");
> > +             err =3D -EINVAL;
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     err =3D spacc_init(baseaddr, &priv->spacc, &info);
> > +     if (err !=3D 0) {
> > +             dev_err(&pdev->dev, "Failed to initialize SPAcc device\n"=
);
> > +             err =3D -ENXIO;
>
> No, use real errors.

PK: I will fix that

>
> > +             goto free_ddt_mem_pool;
> > +     }
> > +
> > +     /* Set the priority from kernel config */
> > +     priv->spacc.config.priority =3D CONFIG_CRYPTO_DEV_SPACC_PRIORITY;
> > +     dev_dbg(&pdev->dev, "VSPACC priority set from config: %u\n",
> > +             priv->spacc.config.priority);
> > +
> > +     /* Set the priority for this virtual SPAcc instance */
> > +     spacc_set_priority(&priv->spacc, priv->spacc.config.priority);
> > +
> > +     priv->spacc_wq =3D alloc_workqueue("spacc_workqueue", WQ_UNBOUND,=
 0);
> > +     if (!priv->spacc_wq) {
> > +             dev_err(&pdev->dev, "failed to allocated workqueue\n");
>
> Memory allocations NEVER result in error messages.

PK: I will fix that

>
> Please run standard kernel tools for static analysis, like coccinelle,
> smatch and sparse, and fix reported warnings. Also please check for
> warnings when building with W=3D1 for gcc and clang. Most of these
> commands (checks or W=3D1 build) can build specific targets, like some
> directory, to narrow the scope to only your code. The code here looks
> like it needs a fix. Feel free to get in touch if the warning is not clea=
r.
>
> > +             err =3D -ENOMEM;
> > +             goto free_spacc_ctx;
> > +     }
> > +
> > +     spacc_irq_glbl_disable(&priv->spacc);
> > +     INIT_WORK(&priv->pop_jobs, spacc_pop_jobs);
> > +
> > +     priv->spacc.dptr =3D &pdev->dev;
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     irq_num =3D platform_get_irq(pdev, 0);
> > +     if (irq_num < 0) {
> > +             dev_err(&pdev->dev, "No irq resource for spacc\n");
> > +             err =3D -ENXIO;
>
> No, you must use actual error code.

PK: I will fix that

>
> > +             goto free_spacc_workq;
> > +     }
> > +
> > +     /* determine configured maximum message length */
> > +     priv->max_msg_len =3D priv->spacc.config.max_msg_size;
> > +
> > +     if (devm_request_irq(&pdev->dev, irq_num, spacc_irq_handler,
> > +                          IRQF_SHARED, dev_name(&pdev->dev),
> > +                          &pdev->dev)) {
> > +             dev_err(&pdev->dev, "Failed to request IRQ\n");
> > +             err =3D -EBUSY;
>
> No, you must use actual error code.

PK: I will fix that

>
> > +             goto free_spacc_workq;
> > +     }
> > +
> > +     priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +     priv->spacc.irq_cb_cmdx =3D spacc_cmd_process;
> > +     oldmode                 =3D priv->spacc.op_mode;
> > +     priv->spacc.op_mode     =3D SPACC_OP_MODE_IRQ;
> > +
> > +     /* Enable STAT and CMD interrupts */
> > +     spacc_irq_stat_enable(&priv->spacc, 1);
> > +     spacc_irq_cmdx_enable(&priv->spacc, 0, 1);
> > +     spacc_irq_stat_wd_disable(&priv->spacc);
> > +     spacc_irq_glbl_enable(&priv->spacc);
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_AUTODETECT)
>
> Drop all such conditionals from the code.

PK: This is needed in the driver since SPAcc has two configuration
modes, "Auto-detect" and "Static" configuration. In the case of
"Auto-detect mode we have a golden input and golden output for
matching based on a sample operation on the SPAcc device. Whereas in
case of static configuration the algos are enabled based on an input
list.

>
> > +
> > +     err =3D spacc_autodetect(&priv->spacc);
> > +     if (err < 0) {
> > +             spacc_irq_glbl_disable(&priv->spacc);
> > +             goto free_spacc_workq;
> > +     }
> > +#else
> > +     err =3D spacc_static_config(&priv->spacc);
> > +     if (err < 0) {
> > +             spacc_irq_glbl_disable(&priv->spacc);
> > +             goto free_spacc_workq;
> > +     }
> > +#endif
> > +
> > +     priv->spacc.op_mode =3D oldmode;
> > +     if (priv->spacc.op_mode =3D=3D SPACC_OP_MODE_IRQ) {
> > +             priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +             priv->spacc.irq_cb_cmdx =3D spacc_cmd_process;
> > +
> > +             /* Enable STAT and CMD interrupts */
> > +             spacc_irq_stat_enable(&priv->spacc, 1);
> > +             spacc_irq_cmdx_enable(&priv->spacc, 0, 1);
> > +             spacc_irq_glbl_enable(&priv->spacc);
> > +     } else {
> > +             priv->spacc.irq_cb_stat =3D spacc_stat_process;
> > +             priv->spacc.irq_cb_stat_wd =3D spacc_stat_process;
> > +
> > +             spacc_irq_stat_enable(&priv->spacc,
> > +                                   priv->spacc.config.ideal_stat_level=
);
> > +
> > +             /* Enable STAT and WD interrupts */
> > +             spacc_irq_cmdx_disable(&priv->spacc, 0);
> > +             spacc_irq_stat_wd_enable(&priv->spacc);
> > +             spacc_irq_glbl_enable(&priv->spacc);
> > +
> > +             /* enable the wd by setting the wd_timer =3D 100000 */
> > +             spacc_set_wd_count(&priv->spacc,
> > +                                priv->spacc.config.wd_timer =3D
> > +                                             priv->spacc.config.timer)=
;
> > +     }
> > +
> > +     /* unlock normal */
> > +     if (priv->spacc.config.is_secure_port) {
> > +             u32 t;
> > +
> > +             t =3D readl(baseaddr + SPACC_REG_SECURE_CTRL);
> > +             t &=3D ~(1UL << 31);
> > +             writel(t, baseaddr + SPACC_REG_SECURE_CTRL);
> > +     }
> > +
> > +     /* unlock device by default */
> > +     writel(0, baseaddr + SPACC_REG_SECURE_CTRL);
> > +
> > +     return err;
> > +
> > +free_spacc_workq:
> > +     flush_workqueue(priv->spacc_wq);
> > +     destroy_workqueue(priv->spacc_wq);
> > +
> > +free_spacc_ctx:
> > +     spacc_fini(&priv->spacc);
> > +
> > +free_ddt_mem_pool:
> > +     pdu_mem_deinit(&pdev->dev);
> > +
> > +
> > +     return err;
> > +}
> > +
> > +static void spacc_unregister_algs(void)
> > +{
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_HASH)
> > +     spacc_unregister_hash_algs();
> > +#endif
> > +#if  IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_AEAD)
> > +     spacc_unregister_aead_algs();
> > +#endif
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_CIPHER)
> > +     spacc_unregister_cipher_algs();
> > +#endif
> > +}
> > +
> > +static int spacc_crypto_probe(struct platform_device *pdev)
> > +{
> > +     int rc =3D 0;
> > +
> > +     rc =3D spacc_init_device(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_HASH)
> > +     rc =3D spacc_probe_hashes(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_CIPHER)
> > +     rc =3D spacc_probe_ciphers(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_CRYPTO_DEV_SPACC_AEAD)
> > +     rc =3D spacc_probe_aeads(pdev);
> > +     if (rc < 0)
> > +             goto err;
> > +#endif
> > +
> > +     return 0;
> > +err:
> > +     spacc_unregister_algs();
> > +
> > +     return rc;
> > +}
> > +
> > +static void spacc_crypto_remove(struct platform_device *pdev)
> > +{
> > +     struct spacc_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +     if (priv->spacc_wq) {
> > +             flush_workqueue(priv->spacc_wq);
> > +             destroy_workqueue(priv->spacc_wq);
> > +     }
> > +
> > +     spacc_unregister_algs();
> > +     spacc_remove(pdev);
> > +}
> > +
> > +static const struct of_device_id snps_spacc_id[] =3D {
> > +     {.compatible =3D "snps,nsimosci-hs-spacc" },
> > +     { /* sentinel */        }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, snps_spacc_id);
> > +
> > +static struct platform_driver spacc_driver =3D {
> > +     .probe  =3D spacc_crypto_probe,
> > +     .remove =3D spacc_crypto_remove,
> > +     .driver =3D {
> > +             .name  =3D "spacc",
> > +             .of_match_table =3D snps_spacc_id,
> > +             .owner =3D THIS_MODULE,
>
> This is some ancient downstream code. Base your work (means START from)
> a new, recent drivers. This was fixed many years ago.

PK: Sure, I will update this as per the recent driver changes.

>
> Please run standard kernel tools for static analysis, like coccinelle,
> smatch and sparse, and fix reported warnings. Also please check for
> warnings when building with W=3D1 for gcc and clang. Most of these
> commands (checks or W=3D1 build) can build specific targets, like some
> directory, to narrow the scope to only your code. The code here looks
> like it needs a fix. Feel free to get in touch if the warning is not clea=
r.
>
> > +     },
> > +};
> > +
> > +module_platform_driver(spacc_driver);
> > +
>
>
> Best regards,
> Krzysztof

