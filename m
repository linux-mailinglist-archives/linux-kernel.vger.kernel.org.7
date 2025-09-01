Return-Path: <linux-kernel+bounces-795371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052EB3F0ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233131A86C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95228369D;
	Mon,  1 Sep 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyzV55mW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8D223DF0;
	Mon,  1 Sep 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764985; cv=none; b=RTcELKWmUbF3maRCG+GESsWaXpvuF+SiRzMC7bcr/B//jrkcBZxlLPb6j738kKBokOzVdl8X4OQLS3Sis5uPa8uI2rbs5o8Z1tnpbILX6e2IH786GeFtkkGtPLVpzMjGeRUrQOB7T2SRvRXbkNTpd/XHIwlrKMfhcmVMCurJxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764985; c=relaxed/simple;
	bh=oLskMqaHBZDQ4M+92Ea6fkMbA16LtpzZszxWHw36BKk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjHMINJ+8IX9dQSBVnZvLH+GfccdbdGug2C2syvd6y41EIpDH27B11yXvM9rNP5UvhvJp3suoI0FYnPXtRwQ/JSq4JvQOT8mlCc5KLRP8LjsVAOJvV1xmmg9emMpV2s3sAhHuHRkVkMmjVqQ2mMR9l3VAjJdp8KonVkayi32voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyzV55mW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so4321187b3a.0;
        Mon, 01 Sep 2025 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756764983; x=1757369783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=erf0LGr1RXc9Ic0frfV15S6ddZ5bAby40+1+C+q1TDE=;
        b=CyzV55mWi3B8ofzM/la7yAuLlAwfJxghhN1wXayorkXjTMafejKRw9QgI72Mzl1K+4
         1p5SyXL3HebV10s0CwtB7jOwqMY4m+/shwbV8G7uHdm+Cu/hv82pJgy0VFPVKsIO+bFM
         GOzqwgKWsinj8dixXbQLCUR4w5EdilGWO42XPe61/smzviIQhEcmIIWZ67cwCT2z2FPn
         5aD4pMo+MjylisX/bH+IAPfk+POEIYzNpcf4lDB6favbZqU3/ssuD6qxd1nm5EWdlVPR
         V30Kki/HZT6HgOY1Eow/Y40HBVzkhfHxvk/xD5tDOJswDkAzSkmR/7zM9lvgrwdWV5ny
         JIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756764983; x=1757369783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erf0LGr1RXc9Ic0frfV15S6ddZ5bAby40+1+C+q1TDE=;
        b=MRAXTl9ZfjntYvv8ZhgyEh5x4x2Lw5IzbilUNC4Plcriav3ZJ5JKtPlvKnQNwcg1mS
         QmDSB+IWcsTnQVXn/O4Kjh+YoTHbCzbWPteTyEvH3w0SvNanhUcNrlnG+HnDZ8l2u4LO
         0fM8/CtSNcnoTIWNbjK4hGzBp8Ujr6Nk+Wn3bp+YcR2cLdw4Y0tNQa04piMpR0M5H2Gf
         4tRWREWe1Oz1oVaGYmbijJd5hCLYAyig2TXrnXNMq9sKoHrveLYx3M4TDCpn+F93Jo+7
         U6Ecu3UtfDHE1nn/ulwu/ckQwx5/GPy8luj3a1D9H5lhyp9MGq5xAh+lK1SpKItV51Br
         qFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/wsXTP6xsaxUhV0KZUMfeVSY8ol3SZIYBqeSHwtf0lwZNggTUs4mYBcZYRgJhH76wYJiWVRkGR6L5@vger.kernel.org, AJvYcCXD4Gyn1wxR/PSoWK3skuAGowqEjGZ+YDiRu9K4Jc7NpZhM0PWYGCcppeVUpUDLZub7nFAVZ+a/V4PYduel@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jVABwQMij8V5K2eil/DfBLePuEg58Z0WH+a+9obQWFrGhWOx
	ibDZwaV/ZQVsEwYvyYm/zWXKQf/YlFRqF7QmKnhaqgGbD8no8/jssaoz
X-Gm-Gg: ASbGncuHKwdD7NROQl/U5AyRPtAMOPHqv+YfYUh+PZebeN0G2tHFy0Ipntz0eronP+z
	zXAgnpCZvnhTM/MPBjFRo1B0hfHKrwXd/MRPBlXk937czcmmZQGkjP7ebas07G9aJtp98/YOa93
	PDTBsNLtDF3buSuJBDVBdwweyCYVV+rQqBKoHx+9ZLRPPkdrm/bI6lVAxBQ/qgVVrUxqQ5o93pE
	STe4uU5OvVdVyTX3snXOeXuH2rnqe92T8hpRAee98FYriVWED+PNQX0Sybo6I15l6fRKsFrIAR2
	n+6DUq7eRJzwzRrdwnGqyrSfB+S4IDgB0s3pqze7PGdO4WqEBali8dk6mY3JQjdDcYpMOA9yT2V
	8UIzanW+Lq6bpKv5ppi4FAQ==
X-Google-Smtp-Source: AGHT+IFWF0I/dXBzxrh9+lgnjxp+4hm9yfWG/1QG0n322Ke/LdJEyJO54HHlRnJIo9PFXfBtS2k73w==
X-Received: by 2002:a05:6a20:7490:b0:243:7379:53a9 with SMTP id adf61e73a8af0-243d50948b2mr13602559637.9.1756764982262;
        Mon, 01 Sep 2025 15:16:22 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4e7989b53dsm7071350a12.29.2025.09.01.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 15:16:21 -0700 (PDT)
Date: Tue, 2 Sep 2025 06:16:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	inochiama@gmail.com, krzk+dt@kernel.org, looong.bin@gmail.com, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev
Subject: Re: [PATCH v2 0/3] irqchip/sg2042-msi: Set irq type according to DT
 configuration
Message-ID: <k3blxflvwicykiqv4eo6hx2notcp76rdf72oe37wkkkcq4ookr@fyydrsjv3r6z>
References: <cover.1756169460.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756169460.git.unicorn_wang@outlook.com>

On Tue, Aug 26, 2025 at 09:09:13AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> The original MSI interrupt type was hard-coded, which was not a good idea.
> Now it is changed to read the device tree configuration and then set the
> interrupt type.
> 
> This patchset is based on irq/drivers branch of tip.
> 
> ---
> 
> Changes in v2:
>   The patch series is based on irq/drivers branch of tip.
> 
>   Reverted the change to obtain params of "msi-ranges"; it's better not to
>   assume the value of "#interrupt-cells" is 2, even though it's known to be
>   the case. Thanks to Inochi for the comments.
> 
> Changes in v1:
>   The patch series is based on irq/drivers branch of tip. You can simply review
>   or test the patches at the link [1].
> 
> Link: https://lore.kernel.org/linux-riscv/cover.1756103516.git.unicorn_wang@outlook.com/ [1]
> ---
> 
> Chen Wang (3):
>   irqchip/sg2042-msi: Set irq type according to DT configuration
>   riscv: sophgo: dts: sg2042: change msi irq type to
>     IRQ_TYPE_EDGE_RISING
>   riscv: sophgo: dts: sg2044: change msi irq type to
>     IRQ_TYPE_EDGE_RISING
> 
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
>  arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
>  drivers/irqchip/irq-sg2042-msi.c       | 7 +++++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 8ff1c16c753e293c3ba20583cb64f81ea7b9a451
> -- 
> 2.34.1
> 

Tested-by: Inochi Amaoto <inochiama@gmail.com> # Sophgo SRD3-10

