Return-Path: <linux-kernel+bounces-874637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D9C16C00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F7E406A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998F2BDC27;
	Tue, 28 Oct 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ9coa7+"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B996298991
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682806; cv=none; b=NWXxnmNWjCghBHjqp4XE0PWb13zl4YufhJPFf9myaX6g+3CJi3Gx0NhU8GIeKU/9QfaZT/N7/lbDf+ylJAj+TDOhe0OK5jIMFua8kzJvXpnZS8fbd5EqDpS1YkKBSxI78l/ygAFSmgtaAXCQF72NOinAdwTL7QJno/kTnG2Owck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682806; c=relaxed/simple;
	bh=1DL7qm57wub/f9vhoCnXsfxm9twR8KCYygrnXx0fhOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZPH+WX3/nQ1WmXwxpF/W3ol9svBWHwk9W5rdxE1NNcLVHekSeHA26HMvxyoJPAUp1kROUjgeR21MvvRajT2gPfLsG5nRmyKi/Z5UeBoxAFJvdSroepptL2hfHzq1FiwvdzkYOlfMA70kODZCuTIEoDPw0E5FN3zz/4F1ly6uuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ9coa7+; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e17c0fefbso6955604d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682804; x=1762287604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lEnOrPU7t9BTi0lIm6AXk0/RgDoLHUnhIVJitTcT88=;
        b=YJ9coa7+agFZT+GjtubljnQLVrI3/nFNlARYWqx2XKiwMAFEuH5pOWdpcm0wj7ppSv
         lskvQG7wh+uQNWEWm5MSp5eqnD0G2vUa/tiWKtmRVah5ij+nVEj6LhiEaCzyXiik/nlG
         +DB6lEWD/LIUi82yBVknCkJizSyRB0llrWFyll7oa7ucuVPBeNNyK0e3S0T2jUtCg3BD
         NEXEACJ0XNPFh+0qX+0R2ILuRCJmwyeJlD/0ym6ZZR+Mlu7wFPk9xtV8XcNLG8rFPVod
         V24yOR3+dxGsQRk5zqvEtsWpBW8NAmHoh4Qe92xI23/1RSXyQF10TtVFKs07kK/83aHy
         j5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682804; x=1762287604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lEnOrPU7t9BTi0lIm6AXk0/RgDoLHUnhIVJitTcT88=;
        b=Z1Kt6Yk3ZfwyReo+ilbdbreOvqNnUpDt4mfSwUljlzTh5Ethx29iwwL9N/o2sf0ER8
         iseQcbFmIACbKhgHDUMOwwP+lamwYuSpW+70tb0BLEsLSBiHZdsBr7QdwFnFC3N/Bk2+
         RmzKK0SmwuwM48hd8rn5e1rGtSOd/z39JTRxX+Az9ySANSgBVjwkzp+9BhZWFdme3Zz8
         VcNNh1smae2NKxq5eRUwbp9SDrgz8A+q9N4EZwCIrmJmbjk4lZklXuperaYqnG/BH8gq
         KELArF9wHlVGQF5A+SvLWMXdJkajxXgsEoH95FLhAdEqgSS2kqHgfoQGCfxIi0uT5nC7
         Sg4g==
X-Forwarded-Encrypted: i=1; AJvYcCWl1LEJ/0QZvWHEDutSug7R5peGAtJ1/OVpcy0yBWHIDZxTClhbx0UxZ3RSQaoLjujM8VSPEZYCEgq3flw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVh/fPiyg6KVN52b3g2nalikMvOIZOHc+DzHisIbi1sdPlW69W
	/Jgx8mjzcWsex+e9D6xKQWvP9Fs1V4/l+LAkUFuEfFZKp0Wwvl1bH0t5UIubYWxgoMVqZ9u7LGA
	06gACLRogF0hySai7pk6gfQyUQyo1N2ZoxQ==
X-Gm-Gg: ASbGncvOuq1xgG2rFcHfdyox27DIR0LDqLYIs4oiR8uLKGg/toHz9KM5Wh7V2PCtEQm
	CqrUqzGWkvMxKNrNuHY56H0+3qA/sE81Y1AKR1wWPqhNEMh2crQ8z4yeHiHKnM3UyJrEjif22S8
	DGMLVUmVTyk4fzfS0jyEVbPZ5yCmkaoklNwWdD5an5iOm0lhaafg2HxwzWh1S5dmbFOgbMr2TJM
	FEHhkhwR53q+Zh1OJl6vO7/C8jcE/WQltjb6fnrmFrYjmLo4VLA7uzZIZU=
X-Google-Smtp-Source: AGHT+IHgKGGElaUgkNdyxfVG3niQuHRbpKqrhRCCJLjNWkcWpoez/iaqA+lCNPGD4ysIgKN9cdylbUkkCIi+yZAgSns=
X-Received: by 2002:a05:690e:42d1:b0:635:4ecf:bdc6 with SMTP id
 956f58d0204a3-63f76dcb9eamr529307d50.40.1761682804232; Tue, 28 Oct 2025
 13:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027171759.1484844-1-cjd@cjdns.fr>
In-Reply-To: <20251027171759.1484844-1-cjd@cjdns.fr>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 28 Oct 2025 21:19:53 +0100
X-Gm-Features: AWmQ_bnFo7mm_j1RGqm_idjiztE8WhG05zba6SQTIj4ViGB8NtmMx-tKQzB1yd8
Message-ID: <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 27, 2025 at 6:19=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.fr> =
wrote:
>
> When on a Big Endian machine, PCI swaps words to/from LE when
> reading/writing them. This presents a problem when we're trying
> to copy an opaque byte array such as firmware or encryption key.
>
> Byte-swapping during copy results in two swaps, but solves the
> problem.
>
> Fixes:
> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
> mt76x2e 0000:02:00.0: Build: 1
> mt76x2e 0000:02:00.0: Build Time: 201607111443____
> mt76x2e 0000:02:00.0: Firmware failed to start
> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
>
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wire=
less/mediatek/mt76/mmio.c
> index cd2e9737c3bf..776dbaacc8a3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32 of=
fset, u32 mask, u32 val)
>         return val;
>  }
>
> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
> +                                         const u8 *src, int len)
> +{
> +       __le32 val;
> +       int i =3D 0;
> +
> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> +               memcpy(&val, src + i, sizeof(val));
> +               writel(cpu_to_le32(val), dst + i);
> +       }
> +}
> +
>  static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
>                                  const void *data, int len)
>  {
> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset, da=
ta,
> +                                             len);
> +               return;
> +       }
>         __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len,=
 4));

Maybe just replace this with memcpy_toio() which does no swapping at
all instead of double swapping on BE?

>  }
>
> +static void mt76_mmio_read_copy_portable(u8 *dst,
> +                                        const void __iomem *src, int len=
)
> +{
> +       u32 val;
> +       int i;
> +
> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> +               val =3D le32_to_cpu(readl(src + i));
> +               memcpy(dst + i, &val, sizeof(val));
> +       }
> +}
> +
>  static void mt76_mmio_read_copy(struct mt76_dev *dev, u32 offset,
>                                 void *data, int len)
>  {
> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> +               mt76_mmio_read_copy_portable(data, dev->mmio.regs + offse=
t,
> +                                            len);
> +               return;
> +       }
>         __ioread32_copy(data, dev->mmio.regs + offset, DIV_ROUND_UP(len, =
4));

And memcpy_fromio() here.

Best regards,
Jonas

