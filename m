Return-Path: <linux-kernel+bounces-823773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CAAB876A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D80F624DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902B13B2A4;
	Thu, 18 Sep 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbgXFpzN"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020C34BA5A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239456; cv=none; b=t5+bzyS/wwA8AAwU/29mLLocoK+9qsdW3ue6iPn0UrrW54J/fBdZvwR8XR1XLAmAnd3T/c+pYqTqi1B96btGR3hoiG8gil7Q0+tu1msvYMkNzq3kvMbHJEbjKhn865/n5fjMR/cWaSRPi2fUyiTsHRDjA7+zG0XJmKE/aoCaGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239456; c=relaxed/simple;
	bh=d0qikBWOGfbxJYLoS4R9xhwuXRiOgBLIpHJT2Z2Ck6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyK2htNJ4QTIXyEIptoHCUIhud6Z3oCDZ0FBTUL+BHiWg6QBushuulXSmWOJraQqUpQwCJWgfgcZ1n79wzRH5q2OujItXejH4r6uYd/4HX3O9R2rXKYT9S/WvTJJQL+tErLwMWBm4/maa4MXwMULahjT4q3cq+377uK44w2122o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbgXFpzN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cceb3be82so1261336fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239454; x=1758844254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfjSYheYrlVR0uqLfVkFYD26bK3rG/XlSeZtdEtGwIw=;
        b=SbgXFpzNw4Ic6S3PnC9oIC2OalaUoqNvCpHfK7/II05iY3qjMDND5CsPdaHMSClsmV
         vDe8QEk8q5dGJiZLTH5JFfB7JMze4j54+JWDuW5DH33zOzQ+/rHHPRy43E3LsODUSjdp
         dEP+DFJMUBO6IyCxNO6NhftbRfEWRCapjZzAwlBgrX5IN5+vL1OiAzI8Sijtu4AawOBv
         dATPQjBIFK3y3MBk7JsSzY2H5uZOMHxhSjlETM2nDOFQVwWdYl3LsZ4dK2c9BFLhhdsk
         tHX195/ALG2EO1S0sU8F4JtP8mYsk5bo/2fDMQj4OtP18+w8GMsGtjwitKqnTtLDUK4B
         Cx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239454; x=1758844254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfjSYheYrlVR0uqLfVkFYD26bK3rG/XlSeZtdEtGwIw=;
        b=BQx/cIJ08k42YrSIjFuDZrmhEjSnYWV0v1aFZOQY4LcGCgIv4HHnFgBAOn6lmZvuzv
         DUpXZUZyLyqzYAX1Sw5p0B89biN9/wGIZWhAbF29bUaNetFAhS+bJnl+gvQCLSIV1o+N
         iooUc+XYywZxThKOOIr24/91SqMramUZDWQ0Dc7jolfJv9uHicDtbCKYfKSxsXAiCAKR
         lUVxplIzviZCFals2z7GzuhyhyMBiqfDrO7j4A4SWpf0HMbjPTClrdYTvTEdUmVlMewc
         XdLnb4K+qIU4SFaF6QNrL4HYHLyrFm2ipkTD7hIMWj0hDEWSqotbXRJxqsrEQ0gu4QKd
         yWvA==
X-Forwarded-Encrypted: i=1; AJvYcCUXF2d4MRmPUlDyYvR5Xe7fqXFZLFVN/DLs/10UUYDOAfjYpcfiIVzR2eQgLv2AKfMRyUSVumEsbgH4QRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrfN8Nzuqnj83kYlDUdUHQgrb2Xs6SzyLvzmmduo/1LdgPCvI
	OcLDBFbUF8WFJfPIAyWcHdMve4feZ9vjCwobUECpPKGP+afVRUM0DVnVZq+N75Om/6eFBtRGhW8
	MLbyyIpKlzRLZirMvAEg/hF6ix92ddnc=
X-Gm-Gg: ASbGncs5CIjwyZJFUKMpyPobI1vCNgqGre3i3eQX5tbyBgKXqXWxGl/4XZFrKVdARqu
	mmce0O/VTNqArgg9j+d5pybjevb+u4ZkiCIOLN1pkjm3EZQqk/oMYAtlgG7rjCMOZ2ffWp5z9jb
	1wdApoWfKpD+WosY88ltSZcrwJA/fSJi92gsiTsXi0s8QVoDcFGHPNEZAF67f4zS21MdbOrKfeh
	fOVbMXDTaMKGY1r2KI8HhrCvjU=
X-Google-Smtp-Source: AGHT+IFl61ezr6lGg9Y8huzd4lUuItQQFeCjeYkcbAulR0oeCohvd0FtJ04m812XYlXTYo+4qdyMj6+Phytv0CLbQXE=
X-Received: by 2002:a05:6870:c151:b0:31d:8964:b4aa with SMTP id
 586e51a60fabf-33bb3ab9686mr861868fac.6.1758239454270; Thu, 18 Sep 2025
 16:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com> <20250822021217.1598-3-jjian.zhou@mediatek.com>
In-Reply-To: <20250822021217.1598-3-jjian.zhou@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 18 Sep 2025 18:50:42 -0500
X-Gm-Features: AS18NWC4m9av00lwavoKLMq8wYvsb2rbN1xJZakR6WVpJIjFSlMM8j-tfAib_HE
Message-ID: <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <jjian.zhou@mediatek.com=
> wrote:

.....

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct mtk_vcp_mbox_priv {
Maybe 'mtk_vcp_mbox' is a more appropriate name ?

> +       void __iomem *base;
> +       struct device *dev;
> +       struct mbox_controller mbox;
> +       const struct mtk_vcp_mbox_cfg *cfg;
> +       struct mtk_ipi_info ipi_recv;

Maybe also have "struct mbox_chan chan[1]; " so that you don't have to
allocate one during the probe.
Also if you have  "struct mbox_controller mbox;" as the first member,
you could simply typecast that to get this structure.
Something like "struct mpfs_mbox" in mailbox-mpfs.c

....
> +
> +static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mbox=
,
> +                                           const struct of_phandle_args =
*sp)
> +{
> +       if (sp->args_count)
> +               return NULL;
> +
> +       return mbox->chans;

return &mbox->chans[0]   seems better.

thnx

