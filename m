Return-Path: <linux-kernel+bounces-775345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D35DB2BE34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62A8686D90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821F31CA4F;
	Tue, 19 Aug 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ook/Vrvv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF1238C0F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597217; cv=none; b=Vd6VcYj1O38LU++p9IRSsHza85FVnxYXeROHZ7QKeCU7qFxp9+VAQF0Ech/gtltMTe1dOB8hXWvZanJ2WR9fsZIwj+uz2wpV76I97tRZ3eBh7RZhYQCbDi4KvCBfVIdJmb2R+oejBTZBnWrUZe9b2S2hXbqVKHzp3kgYALOh6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597217; c=relaxed/simple;
	bh=YEizIsE8/y/LtNcORPO8jldB4Nh5dJHp08eXLO5S9Go=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oDTUcsuPkbPUBAenVqgcxSPef4V7XzLmBgCkipBEKkSCVkDjdpjI8maPCv235PesuWhV8DBrKu4P6p4E6BZV7IG+MS0jAtvTZLfXv8QtO4GrWxHly1XUzNJESg0/K5v4iNdJhMvug4HjvzJ7reeDBJEg6wI9ZOb1EYKWm6+/wVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ook/Vrvv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e411c820so2752080f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755597214; x=1756202014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNam3s73jCkH5fp8vQUdOONkGiCMjeqztr8hoMDyHKE=;
        b=Ook/VrvvwxOS2kLOxw6+FvsqKbHxQlijniMXqxM+eBUkeS7h/95d8yX7vdrSH/Gf/b
         qy+J9VcWPBaL3uBkUsIzICVflrR+K6BdQMQitIO0w0VVA0U5XDGA9TlGrL2a0uUkBTxJ
         Uejid6a/sFr9iLTDV2x+8+MQNyFF1ECw9EpSt/4X0m2AK9J331bd1XRx5TKXpyNNQ/y+
         xB8dzRuAcQQBCegwLAWWg2Y98AvEYSSmEtEwmNgziXH8eWFx9GRHspTPVOSCXigQ24CS
         hWj/U2PR9fY6NgJ5RNX8Vg01bX8dQXnwpIDEr/03Xczieyvgh13ML7c2UR2X6Dxnbj5J
         3Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597214; x=1756202014;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNam3s73jCkH5fp8vQUdOONkGiCMjeqztr8hoMDyHKE=;
        b=gLkezOYb/OFLWqSWMkFBoxgYECrdq8onPiWxUQOkiiCSf1jwC9JcDcxIIAOPpLMA9i
         DUiY1/xQKsvM6pCDWWui6GcwL+uSJ65XWnq0CEpNIl7KU9ZkAv2tuc5uE/UjXsiX7Eab
         Vcl054DmMl3u+JQ9UVwbgDp+Z6f77m7fyuLXSBuaWrVrW3vrAPEmSP/An8yNQgbn+h6c
         kygyRDcqlEStC6Ia1PSN+ddtAP5FqBsy0Zp06j8rtFVepui12qYqyZgSN2d1mlhQEMfM
         8p5vnz4O9Dv40wLiIH/2+GRsvNeV4sMuQgFSj1wjrm3z1RLW5rCk71yJtF5iUQexqA5B
         tKMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+CqL/Tg7nOh0WqfvKejalDCPY5s04snZpyAmzlzrsPYLIsv7CCV791E+rw99f4gS3ViUJstPLUQSsgc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJPel/mXuI2VdelCA8KDADEvgIgvKcxCWtgnrxsFgSekA1tdI
	AcfaX9kge8qPJaQORjtgID/j9bcAZ2gLoyS19DqBIYHNY55FBtFeL07u+I0mY22fdtU=
X-Gm-Gg: ASbGncsQ3d2R43ktnnD9NHPurCtnD1VhDZPfpEcIL2MHxhG+tC43esuv1kmo/UkLtDx
	xxI5wkPXSILyGZiJ8vGTsiNJbmCs0bQ3bxghV1U9atrkxT9AB2gXTasuEpWQ2oAwtNqKCM0eibW
	kkotRCcQNNZmoSwovPQpJugWdLqrsYVM4mppouqmQhuwKiebfRDFe/XrPsC19SwPiJiUKxCj/+S
	1ibb11efGRWc8GCUUs6nBbrPRl1HQ0untVoI6YfdJjuoJQ7GozZFfKbQxZzOVzlmqnPPaxZXPrt
	dWchTfu8lbmyDKYEnK33oyXY3VAVcJc1Uueu/gQuBuU+huucxHjngQOORjAKpJzjkIUhtWOcbpr
	IOOAUzZOM+ICnienhS6hQ7Xv3MaVbcJSozconXLWuaa4=
X-Google-Smtp-Source: AGHT+IFhVoXOXWz933OS2H4MYPh1tnFGv79hui+RhHHpUYqmH0GfWUAlyD1l4ealbPI6uEAVPOGUJg==
X-Received: by 2002:a05:6000:200d:b0:3b7:8832:fdd5 with SMTP id ffacd0b85a97d-3c0eaf4f6dfmr1431883f8f.16.1755597213853;
        Tue, 19 Aug 2025 02:53:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c16eesm3152017f8f.37.2025.08.19.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:53:33 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:53:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Lee Jones <lee@kernel.org>,
	Corey Minyard <minyard@acm.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com,
	Chong Qiao <qiaochong@loongson.cn>
Subject: Re: [PATCH v9 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function
 support
Message-ID: <202508191519.uT5io1jk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1809103a948545df93b7b439df46ca6393995aa1.1754999365.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/mfd-ls2kbmc-Introduce-Loongson-2K-BMC-core-driver/20250812-200258
base:   006aa8f57f55dd5bf68c4ada1e0d3f4e59027d71
patch link:    https://lore.kernel.org/r/1809103a948545df93b7b439df46ca6393995aa1.1754999365.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v9 2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
config: loongarch-randconfig-r073-20250818 (https://download.01.org/0day-ci/archive/20250819/202508191519.uT5io1jk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508191519.uT5io1jk-lkp@intel.com/

smatch warnings:
drivers/mfd/ls2k-bmc-core.c:389 ls2k_bmc_pdata_initial() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +389 drivers/mfd/ls2k-bmc-core.c

71ff6b050ad788 Binbin Zhou 2025-08-12  360  static int ls2k_bmc_pdata_initial(struct ls2k_bmc_pdata *ddata)
71ff6b050ad788 Binbin Zhou 2025-08-12  361  {
71ff6b050ad788 Binbin Zhou 2025-08-12  362  	struct pci_dev *pdev = to_pci_dev(ddata->dev);
71ff6b050ad788 Binbin Zhou 2025-08-12  363  	int gsi = 16 + (LS2K_BMC_RESET_GPIO & 7);
71ff6b050ad788 Binbin Zhou 2025-08-12  364  	void __iomem *gpio_base;
71ff6b050ad788 Binbin Zhou 2025-08-12  365  	int irq, ret, val;
71ff6b050ad788 Binbin Zhou 2025-08-12  366  
71ff6b050ad788 Binbin Zhou 2025-08-12  367  	ls2k_bmc_save_pci_data(pdev, ddata);
71ff6b050ad788 Binbin Zhou 2025-08-12  368  
71ff6b050ad788 Binbin Zhou 2025-08-12  369  	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
71ff6b050ad788 Binbin Zhou 2025-08-12  370  
71ff6b050ad788 Binbin Zhou 2025-08-12  371  	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
71ff6b050ad788 Binbin Zhou 2025-08-12  372  			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);
71ff6b050ad788 Binbin Zhou 2025-08-12  373  	if (ret) {
71ff6b050ad788 Binbin Zhou 2025-08-12  374  		dev_err(ddata->dev, "Failed to request LS2KBMC PCI-E IRQ %d.\n", pdev->irq);
71ff6b050ad788 Binbin Zhou 2025-08-12  375  		return ret;
71ff6b050ad788 Binbin Zhou 2025-08-12  376  	}
71ff6b050ad788 Binbin Zhou 2025-08-12  377  
71ff6b050ad788 Binbin Zhou 2025-08-12  378  	/*
71ff6b050ad788 Binbin Zhou 2025-08-12  379  	 * Since gpio_chip->to_irq is not implemented in the Loongson-3 GPIO driver,
71ff6b050ad788 Binbin Zhou 2025-08-12  380  	 * acpi_register_gsi() is used to obtain the GPIO IRQ. The GPIO interrupt is a
71ff6b050ad788 Binbin Zhou 2025-08-12  381  	 * watchdog interrupt that is triggered when the BMC resets.
71ff6b050ad788 Binbin Zhou 2025-08-12  382  	 */
71ff6b050ad788 Binbin Zhou 2025-08-12  383  	irq = acpi_register_gsi(NULL, gsi, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW);
71ff6b050ad788 Binbin Zhou 2025-08-12  384  	if (irq < 0)
71ff6b050ad788 Binbin Zhou 2025-08-12  385  		return irq;
71ff6b050ad788 Binbin Zhou 2025-08-12  386  
71ff6b050ad788 Binbin Zhou 2025-08-12  387  	gpio_base = ioremap(LOONGSON_GPIO_REG_BASE, LOONGSON_GPIO_REG_SIZE);
71ff6b050ad788 Binbin Zhou 2025-08-12  388  	if (!gpio_base) {
71ff6b050ad788 Binbin Zhou 2025-08-12 @389  		ret = PTR_ERR(gpio_base);

This PTR_ERR(NULL) is success.  It should be "ret = -ENOMEM;"

71ff6b050ad788 Binbin Zhou 2025-08-12  390  		goto acpi_failed;
71ff6b050ad788 Binbin Zhou 2025-08-12  391  	}
71ff6b050ad788 Binbin Zhou 2025-08-12  392  
71ff6b050ad788 Binbin Zhou 2025-08-12  393  	/* Disable GPIO output */
71ff6b050ad788 Binbin Zhou 2025-08-12  394  	val = readl(gpio_base + LOONGSON_GPIO_OEN);
71ff6b050ad788 Binbin Zhou 2025-08-12  395  	writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_OEN);
71ff6b050ad788 Binbin Zhou 2025-08-12  396  
71ff6b050ad788 Binbin Zhou 2025-08-12  397  	/* Enable GPIO functionality */
71ff6b050ad788 Binbin Zhou 2025-08-12  398  	val = readl(gpio_base + LOONGSON_GPIO_FUNC);
71ff6b050ad788 Binbin Zhou 2025-08-12  399  	writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_FUNC);
71ff6b050ad788 Binbin Zhou 2025-08-12  400  
71ff6b050ad788 Binbin Zhou 2025-08-12  401  	/* Set GPIO interrupts to low-level active */
71ff6b050ad788 Binbin Zhou 2025-08-12  402  	val = readl(gpio_base + LOONGSON_GPIO_INTPOL);
71ff6b050ad788 Binbin Zhou 2025-08-12  403  	writel(val & ~BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_INTPOL);
71ff6b050ad788 Binbin Zhou 2025-08-12  404  
71ff6b050ad788 Binbin Zhou 2025-08-12  405  	/* Enable GPIO interrupts */
71ff6b050ad788 Binbin Zhou 2025-08-12  406  	val = readl(gpio_base + LOONGSON_GPIO_INTEN);
71ff6b050ad788 Binbin Zhou 2025-08-12  407  	writel(val | BIT(LS2K_BMC_RESET_GPIO), gpio_base + LOONGSON_GPIO_INTEN);
71ff6b050ad788 Binbin Zhou 2025-08-12  408  
71ff6b050ad788 Binbin Zhou 2025-08-12  409  	ret = devm_request_irq(ddata->dev, irq, ls2k_bmc_interrupt,
71ff6b050ad788 Binbin Zhou 2025-08-12  410  			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", ddata);
71ff6b050ad788 Binbin Zhou 2025-08-12  411  	if (ret)
71ff6b050ad788 Binbin Zhou 2025-08-12  412  		dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", irq);
71ff6b050ad788 Binbin Zhou 2025-08-12  413  
71ff6b050ad788 Binbin Zhou 2025-08-12  414  	iounmap(gpio_base);
71ff6b050ad788 Binbin Zhou 2025-08-12  415  
71ff6b050ad788 Binbin Zhou 2025-08-12  416  acpi_failed:
71ff6b050ad788 Binbin Zhou 2025-08-12  417  	acpi_unregister_gsi(gsi);
71ff6b050ad788 Binbin Zhou 2025-08-12  418  	return ret;
71ff6b050ad788 Binbin Zhou 2025-08-12  419  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


