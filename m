Return-Path: <linux-kernel+bounces-812189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2DB5343E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F27A0220F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CF327A03;
	Thu, 11 Sep 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkcKBu/K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223A81AA8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598410; cv=none; b=ifWEfVEG8ogQwR8QTqbbOiH19fDU6XBIP4Nn8QPKT994MBjhpGUAYvKpwZEy3LWnG7HyCiQY6vrntXrPYi68Z+gNegIoUhGrO0a1rROFOYTXiUV/wiQewJvb5hnaDATfJHQvkRfYD50qlw5DJ/a8xB9P91O/767CVzbhd1ZWfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598410; c=relaxed/simple;
	bh=ZmND1jxWRj6B+QZKJOcM9mi5fG1sk8ssJasB6XluhTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9eiRL2SXmB0XDk4irjJ3wUMKZJcuLZ78ISbHnPE91WJZWfnTr73Tnp+5yr2Jr9s5OrRJ4f7ZtthB+Wm3yJKT10OWKKLvBIruH6Riz/mM8XSQYoH6pd7VZgihEKKBsoQPBB7gBM3+JNqzJKlO0H0LEiNYHmwIdbdSNJSmszWAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkcKBu/K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757598407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJomC7l8VyN+Oq6vLPb3hr3RXtewb7zgJ9BjC+tUcz8=;
	b=XkcKBu/KoceOo+7pvIdgl11CFJcgYTvadseoXT1o8jdb8Bj6Ps4yZKuwJM2af27BpeeTt2
	ZDIqcPdszVs4hmYfZcl21d/g31vU5UybMxXFgW7K+ZswFeBjPExBnMyXPR3uyUYAsuDUUA
	CAyiZul6UyW4FYxyKhI7BcbcJKW1wVk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-86YCSkysNCKhx2dlw8kzPw-1; Thu, 11 Sep 2025 09:46:46 -0400
X-MC-Unique: 86YCSkysNCKhx2dlw8kzPw-1
X-Mimecast-MFC-AGG-ID: 86YCSkysNCKhx2dlw8kzPw_1757598405
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62297f39033so750996a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598405; x=1758203205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJomC7l8VyN+Oq6vLPb3hr3RXtewb7zgJ9BjC+tUcz8=;
        b=TrnwHXjbWSA1cg6nzyr+i3e0TQrg5L0BE+YSZu+nfDSzpRyte8pFr5DLR4CzSuMkOZ
         ls0IueGwBlGUzZYpMdc+b6JuzAQeZaUmudqsGbnUB+IJHYPF8/BzCCCYYuNpgZvADOJM
         8A4VSKmjCgi795Sk3PUzSBpHBTLH3MglmEzccWVBvRjj3wlmrxxYQ/7gWrcwcEPsobqR
         b43byFWd6L8H+Q9Wch4RSjl9RQ/Dwwe4/wZ0q5kEhj4fMh3Fkwp4FnSvxR4SZFd7DzkC
         JAx+oRggzVBa9wiG3jxe/GRCPGoPypcVwkq47r2Q31tOGECcm1I4R0q1Su8dEde6nFw9
         vIsw==
X-Forwarded-Encrypted: i=1; AJvYcCVxhBOJAWfKSd6XQ724DjN0A6IJInyda49PTgeRWvNIbkQuclZhHCf8qKfR1aWLEXyC2Cf28R85dZJhlqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+f3SlvmtVBohJAtIbDGdoQbQv9NFyp5AGMFZEfd5AwlyCMeo
	ihplM+M2T0DYzDJb/8tnZWee9Z9GO/9ssfHewcbpjY8UqTTqIaluOL5VoI+wCF3a97h11aaJTzu
	nzpIEC2zJLeZr2ultnCdHAL8vIJLe3UKw1pFptPIl33VI8QCJ3MUYC2IaH2JNAyquycS8yj8bwH
	q2VmrAd4/LZaSXMKKWF8Eny1mEN+aejRj6niXm17HC
X-Gm-Gg: ASbGnctn0WY1lQaj/Et8DxkPQHrb0X5kQ4VIpiHc6+HkPFCR3bVnLpNH2N0dekujLsV
	Fja1Huxu9iRT6lQtVFqh7w11Y2GUgMMdxpU5sgOGnVUEZOBuISua4NgLHCnlylhd8aEbpzU+q0J
	0y/ZWrmg6ABkoVHdIpXPFGmw==
X-Received: by 2002:a05:6402:26c9:b0:62d:cb6:687e with SMTP id 4fb4d7f45d1cf-62d0cb66ba8mr6743590a12.24.1757598405256;
        Thu, 11 Sep 2025 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYG2o1FnjP9fsGPNzEo0BUw+nYr83QFU96UG32+VUh0e4aiIiyaWkEAie1/ZcB53x8WRZUc+uqk8px+C1mwx4=
X-Received: by 2002:a05:6402:26c9:b0:62d:cb6:687e with SMTP id
 4fb4d7f45d1cf-62d0cb66ba8mr6743564a12.24.1757598404790; Thu, 11 Sep 2025
 06:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 11 Sep 2025 21:46:06 +0800
X-Gm-Features: AS18NWD3xSVbl1wxOC8rlYtjyCxzlP11W8_KCY05l5fYLzSO6dDLpasmfV_vh8w
Message-ID: <CAPpAL=w8=V1O_d99+3rxXRmF1k9nQCAJeS-gSm=DCYYFABZg3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] net: ethtool: add dedicated GRXRINGS driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Wed, Sep 10, 2025 at 4:24=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> This patchset introduces a new dedicated ethtool_ops callback,
> .get_rx_ring_count, which enables drivers to provide the number of RX
> rings directly, improving efficiency and clarity in RX ring queries and
> RSS configuration.
>
> Number of drivers no implement .get_rxnfc just to report the ring count,
> so, having a proper callback makes sense and simplify .get_rxnfc.
>
> This has been suggested by Jakub, and follow the same idea as RXFH
> driver callbacks [1].
>
> This also port virtio_net to this new callback. Once there is consensus
> on this approach, I can start moving the drivers to this new callback.
>
> Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.or=
g/ [1]
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes from RFC:
> - Renaming and changing the return type of .get_rxrings() callback (Jakub=
)
> - Add the docstring format for the new callback (Simon)
> - Remove the unecessary WARN_ONCE() (Jakub)
> - Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f2=
8f@debian.org
>
> ---
> Breno Leitao (7):
>       net: ethtool: pass the num of RX rings directly to ethtool_copy_val=
idate_indir
>       net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
>       net: ethtool: remove the duplicated handling from ethtool_get_rxrin=
gs
>       net: ethtool: add get_rx_ring_count callback to optimize RX ring qu=
eries
>       net: ethtool: update set_rxfh to use get_num_rxrings helper
>       net: ethtool: update set_rxfh_indir to use get_num_rxrings helper
>       net: virtio_net: add get_rxrings ethtool callback for RX ring queri=
es
>
>  drivers/net/virtio_net.c | 15 ++--------
>  include/linux/ethtool.h  |  2 ++
>  net/ethtool/ioctl.c      | 72 ++++++++++++++++++++++++++++++++++++++----=
------
>  3 files changed, 62 insertions(+), 27 deletions(-)
> ---
> base-commit: 9f0730b063b436938ebb6371aecb12ec6ed896e9
> change-id: 20250905-gxrings-a2ec22ee2aec
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>


