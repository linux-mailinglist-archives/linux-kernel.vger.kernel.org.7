Return-Path: <linux-kernel+bounces-824223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8057B886DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EC617572E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73682E62D8;
	Fri, 19 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnupp8Kc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06028C866
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270720; cv=none; b=EwiXMbaTIt809MKPwxwJwiZpCKnbi4Zlt+ajqNHiHvTu0pW4859rpMPf8uSGL9xeiEU8eWd+O7/Bmvu/UMlOz2sPLywaqFTfbO1+HrvbyWfPH38ZVCA2sME94YcepgNLXgeMRHgM4S9NVGjN0mz3I5Zxa+Lat92oSy7aq5REWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270720; c=relaxed/simple;
	bh=s0STqFEhMnCX09Owud8Ryjp6X1y64rjHZvKfQlkmEbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxqXc+T2Jv5KikdJ0zKzralaxLwd9bhHRkLlnchPZEQvs0lM1UEFo9usk9Z3XfDYH6d1gmAome5VTddQgWzH/P2ndt6rlTuv5zA5cG7L4gqKfY4pceezy6n3kycCUCJSYxSHbFP/SxfMjFJtHzh1/uV2ircoy8HAWfK57quw3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gnupp8Kc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-570d0c280e4so2141275e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758270716; x=1758875516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vCBrNiEKTyi9Q3k3Ml4hn7pfySJO9AiRtZz93HFOeM=;
        b=gnupp8KccrnH1rqg5z4lnSWrW5Uw2BhfBHiifSIbQk16NfA5r5ZP+35aidV9dF8QzH
         yYButNlE12zNM3C0DOjQ2fsj8s5aF0/O1K0+PV93pTJuxhu/66ib18s/imA8BD9b0zIu
         LoV+eQEMV0N3KwXiQVm88y0YpNV6Ybpf+lsgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270716; x=1758875516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vCBrNiEKTyi9Q3k3Ml4hn7pfySJO9AiRtZz93HFOeM=;
        b=LFULl1kwl5GKj+9q+GxLiR9ugRux59NI9VdSNR8RrclA03fT0sxEOSFg5mnBBOHmPN
         XkWMQgq96HJY6vfkUdfnhyywmYQAX8xohCnPlcv9DCiiS43QZMAwCamMXQMO2OhV7h6l
         anOiLZK/uFcE3X+bWplb8pIf3zd9E1IaJ36ujFE4zJFwM1JBLjD1qwH5nJnlZXP5qWn3
         ZKeDSq+zg8kQtip8FfFFaV2GPXR+xBLDTCFK9/Oo84IFp7n1707najAMd02Gf+maEJW1
         CKqPgER9rZ1wHMhOxz1jIv8cnjcrG7Qv47ZxrMYpsKrBz34j31kvxjE3UJ5ieS38rKkW
         7RKg==
X-Forwarded-Encrypted: i=1; AJvYcCUryW2xjmsW0lNzPmhVT90Cb3BkLOIJJLvwyEmHK6xXyV4q2nbTGCSKpHsImqkpndBJfSBEAG9bbpMhyno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4uACWFBMK7FYOjbgeEaixzzNRWV+0bYZW/bIlF2Flg4KZE9/
	U1oflb4QHfVJh/Ne5LS7knM+l8kfVr+POPY7MEdcP8AcBv3Woj+PkFUwc4dSMhruVpkYxoCKKGY
	UqrFwacjebcLStm5p2ryLax1Z5kGcP9r0LIXZfflx
X-Gm-Gg: ASbGncswMy+Zj3aTGmJiNnt9k3W5d+499wiAlMdJ8MACknoa9atVLZ3tOMPFMWVeI85
	MKhJorS5Lbio9BPpITPhjMFM/UkZ+j/iQ78XF/Z6QgZif+F3or+KaZkk2pPOzfqfMvrfu62O8he
	NvEbfA7fhdWIM/dsPOLHHtXeumHZraVupPaIuE8B5GY5KGysRNMPszDwhz8lFHD8D7pHrpjvnTS
	EPacSeekGzi1R/RRmd7N5K3HKbeDUgwlBg=
X-Google-Smtp-Source: AGHT+IGJyLApucLYoiVvLVyhVW2X95UA+hKEnkJWRx68Jso5l2IUFZ6Lp0yp/otlrkifX0mDYXdbFrB33I4Cq4SdXuY=
X-Received: by 2002:a05:6512:308c:b0:55f:536f:e8a2 with SMTP id
 2adb3069b0e04-579e3d2d463mr792114e87.53.1758270716503; Fri, 19 Sep 2025
 01:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <20250822021217.1598-3-jjian.zhou@mediatek.com> <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
In-Reply-To: <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 19 Sep 2025 16:31:44 +0800
X-Gm-Features: AS18NWCHPPCOGpgOPgYhcar-Bfyg0XTAKO-xFCzjeyIm7xmJf4PNr7KosKW0NG8
Message-ID: <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Jjian Zhou <jjian.zhou@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:50=E2=80=AFAM Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>
> On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <jjian.zhou@mediatek.c=
om> wrote:
>
> .....
>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +struct mtk_vcp_mbox_priv {
> Maybe 'mtk_vcp_mbox' is a more appropriate name ?
>
> > +       void __iomem *base;
> > +       struct device *dev;
> > +       struct mbox_controller mbox;
> > +       const struct mtk_vcp_mbox_cfg *cfg;
> > +       struct mtk_ipi_info ipi_recv;
>
> Maybe also have "struct mbox_chan chan[1]; " so that you don't have to
> allocate one during the probe.

> Also if you have  "struct mbox_controller mbox;" as the first member,
> you could simply typecast that to get this structure.
> Something like "struct mpfs_mbox" in mailbox-mpfs.c

I read somewhere that this way of subclassing is not recommended.
Instead the base class should explicitly not be the first member.
And then container_of() should be used.

I don't remember where I read this though. But I think the explicit
container_of() is easier for understanding the intent.

ChenYu

> ....
> > +
> > +static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mb=
ox,
> > +                                           const struct of_phandle_arg=
s *sp)
> > +{
> > +       if (sp->args_count)
> > +               return NULL;
> > +
> > +       return mbox->chans;
>
> return &mbox->chans[0]   seems better.
>
> thnx

