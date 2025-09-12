Return-Path: <linux-kernel+bounces-813470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34388B545E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942937AB394
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E622F74A;
	Fri, 12 Sep 2025 08:49:03 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E42AE77
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666942; cv=none; b=bYS27go53iwKtM4dGPEWRN1pkBdRDfhPlblgur81+ySJTOpomPODgaGEohfnP4kKe8N5PQJ285EBfhjqbVIomJqVh+opo3uVDTLb5TtdhqGN3mlQBDCDE3Nu9xs8OjWmjgnb/7MQlwGv6V6QLmGtavxrXa21f5jnjKvAtjXgLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666942; c=relaxed/simple;
	bh=pfequ67AxMRG2qp1IorZvEGJU/BS32aaLb+8hih0caA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imRz7R8PDprMlVZ8qMy0FaoAziEY9xMEuwtFSkMSQ5YngazeOeM+WxuQ4s80x2HN5Z5Ggi9IKrPTi719u7gi+tQgJpI1+r4jBaU4us3JZWCcm+hw4xOFQzeX5cXS7Qsj73b1+2b0HRwcNDgn0p9CbJXY8Q29DyyT9/NsN6yJWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8943501ba3dso1048136241.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666940; x=1758271740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvFl2wUmtFFxKY2KBAM++CC8ombdEefvWb0q1iJCezw=;
        b=u8PdlgtmCpAVfz4zsj0mY+lKDdTNx/L3Oc/ufHh/zmnc20du9zWq+jtfqIzXvegVIg
         SPlyws8dJJkuDL+MwPBjU/pjyCi492W366XTOKAj9s7yW0jNQ983DVYr4Uy/cgruHVdP
         n0xuQE4wRcEvF272tyT5hHtORN5ZHDD/Tv4XPwpt0Ecm5nNPeaTPcE12FMgbEPIoUIfP
         AjNsU4eL+wzklR3lUj5BdKGP+WJMo+h29v4SSPoLHpAMC07WTEGBPOQt/6Hy5rbsOjgu
         NxTb9grK+gn9egfB79dtggt+rqTGdUohW2PWfy2dcSQNABOrri9AM91k/rZQ7CAe+wLC
         AzKg==
X-Forwarded-Encrypted: i=1; AJvYcCXvjP5V8xYf5TU+xFUpcmpU5rgafiV3gcyXKVUOE86n7gWxGP0pNvJKS0QebA13sfTO+M0Y1HNw1J9/SDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYVa5p5/13YOEGW4Q/DG4V8uICS0Cwl+P1WW0VZyHiMFMBdx0
	MjwzU8t3tyGAeOSKKDw/jRilrF9cRbH7IxQEXupsZaIePB38JUja10QUzHpWipRP
X-Gm-Gg: ASbGncsE9xc0NEWKDbqGqvBHjKOVnrMbJKwbIe9wDvqxdQYQcRlvyYrdX3cpdZjzLhm
	CMZ9UTcgphDnAjag6YDhdrEKLbF9S6OVwQT2QFuupyldtmyHQthj3kCoTgKAHS9vsYU2hkZwmMf
	9oM18Ve80xz3JqbARMaMEIqwvTGDNaxOlwC/F+AndoNFhi6CIfxy4q/Ic2eGxVL1makdPA9JrDD
	pH0BxM3A9BQPlvdTSKd3VmJY99lOws3mfOBhKccvvQPTQNE6NCiUZELKUOGQteSMkePd6Zseuch
	OZVAjV6zvZxCQt9TotfSCuo2iYiF8xYH3b0Y33PLh5IRO/vlCWv3SAW1PYMyzNpLSbkw1GBgCOu
	zyC4GFEMA8RLFZsIUnvL31doE2O9Kr85QF9wdJZmyH6psgGqbsuFtn9nnvIqC2T6qkNGBoMU=
X-Google-Smtp-Source: AGHT+IEcZSOxFAQxZ0/+XYEJpsSJo3f/PBrZxT5Qu+ARCpWxKfAQ13UPvxsYfWpcWWPKZQLb7bw2YQ==
X-Received: by 2002:a05:6102:c4f:b0:522:48fb:9478 with SMTP id ada2fe7eead31-5560d94d63cmr930341137.28.1757666939683;
        Fri, 12 Sep 2025 01:48:59 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccb99b1a9asm723131241.0.2025.09.12.01.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:48:59 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-557a6856135so257692137.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXk7HgxCESAZ7TmtN7yJLQqm4KhtC5zPnZeDBLsdIEPJnHfe7XJnXG7oeeA5CmLcla85itHxIgnQPRkAkY=@vger.kernel.org
X-Received: by 2002:a05:6102:38ca:b0:52d:56e7:379 with SMTP id
 ada2fe7eead31-5560d94aaa2mr992401137.25.1757666938783; Fri, 12 Sep 2025
 01:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org> <20250912084112.2795848-2-mikko.rapeli@linaro.org>
In-Reply-To: <20250912084112.2795848-2-mikko.rapeli@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2025 10:48:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
X-Gm-Features: AS18NWBiuYTvyIQj6odp2YphRi_cdJn-bbWmQ3arIwrCLTZ05PO_-WVlIOuk6lU
Message-ID: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com, 
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"

Hi Mikko,

On Fri, 12 Sept 2025 at 10:41, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> According to Heiko Stuebner <heiko@sntech.de> all SoCs
> since 2012 have power domain support in HW and
> ROCKCHIP_PM_DOMAINS should always be enabled.
>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Thanks for your patch!

> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
>         select HAVE_ARM_TWD if SMP
>         select DW_APB_TIMER_OF
>         select REGULATOR if PM
> +       select ROCKCHIP_PM_DOMAINS

This requires "select PM". Oh, that is done below (out-of-context).
So the "if PM" above can be dropped.

>         select ROCKCHIP_TIMER
>         select ARM_GLOBAL_TIMER
>         select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

