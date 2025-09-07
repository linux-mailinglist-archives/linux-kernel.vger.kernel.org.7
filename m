Return-Path: <linux-kernel+bounces-804881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D9B48156
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660EA3AABAB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1923184A;
	Sun,  7 Sep 2025 23:29:02 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D9E219ED
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757287741; cv=none; b=BBd+9NSMLk9mhnm3RE2ncac/jOXAyejdhFvjOhuulAWUAgtiG/cedESsL/eNCXOgV79KFLBHbRqQecMU97R0PF+qALz1Vp55IXx5xA0UW6/K/nK3cYhXEbCmiAuEELDJXSf5644ciqrj+SDfKJKJurB1Okk7/AodEWhlLRxmFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757287741; c=relaxed/simple;
	bh=qC3LDgn0QXsjdpMpUjymiw5zBmyrBgFV6iffyCRgGfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HREFRYo1zlxEP1G6aF67HN8agRtn8MzIHXk7I7NMr9x0yGFVm04TiLMsdZINwGFmk2sY12vPYgj03zN+9iTXZ5FT2KVyb6YgqEhIpVcQu6aOrKMNapZH9KYRuyqERlKfa6COz2Y0AeJ9umQNi8MjJ6g7KL94kYTcjPW8W5siMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62221568039so2693554a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 16:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757287738; x=1757892538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76zI8GwRW6lnDcSssWQ9O3Kr1qpDNaM13i6btYtNGU=;
        b=g/ZShhbDy+/07/iUQw27nZcXgIsA97XywjHzpZkjhJER0urM3UNrf68N3T9lHMlyIL
         xchiHyS8x5Bn52fJRPd3Vg2ORLZkOKiU/mhVx3T0BP2UITsZFclDcLlrmc2kx2uCeg+4
         iOYCAwRJQv4mBjJ361x7zIbiASvq3/rYfwTtYaJEJ8mvAPFgvz3NJHOzfpLOuwQ65IIr
         xgA3rJEnOD/zr2hbPpNm32fR+f/yscP36a78hdfbdffZNvhEukiUg0MJR9jA+bxOx3mT
         lCGmWdjTu1VZjlSU+Dp/jWhlykTMarN9+B7cdanLezMK1WwXNi6UnYIIpzbfRx38v7iY
         utkQ==
X-Gm-Message-State: AOJu0Yw9W9PMx2KQpY0eVTKqiUDAy6sZrKCU7JCTmCyKeZ9lxQIqPHKS
	ZPWPmKka5A4yREKUbVTtwx75IHeO3SwEgfYj7v6DSRgL04tK47zwaeQPpJP6JJQmVNk=
X-Gm-Gg: ASbGncu0mdMJubk/GqjN1nV/8trpf2CN204cRJBSE0/QOmnEO/yy0NVRocYl1rquV27
	jT4LzeVeYhRL2leikq7shM66OvfnfHk3bu+fd8p3um+eZfDBALaamuHc1it6/o9WVKM0KYbnIU3
	ZKaR2EL0wc+soRALPUik5heFhQl7ZKJMarAdGZHEwgG83TxoI9jO3xup4rkfVgfQmOLMIx6BIwS
	MIJ+HvcNefy7MeGNhxxIhrOzD8ToN1W3d+RCKvXg6ht2d0zqoNNoj4EI3O38jo+RSSXhxeclIe5
	+7GGgxbPjo7OGQh9i1MEYlya0XtmiZy2izwRvcRJcqTWex6SMgqRk43PuFWlSLeNR0sLVNify17
	KgStoOR+7tWixdFULTS29Gc8cR3nBk/6SbQExTuQpvy4Zy3JKsCqH5RBonswUWOkK4Jl33nWT18
	vEQnj5hMPi
X-Google-Smtp-Source: AGHT+IGIzBl7TO6iwCCpqvycrMEXs87TwHAjIddmi69Br6OeyjLa9qnHyyK+RQqBY2wjUhAowI8u0g==
X-Received: by 2002:a05:6402:27d2:b0:617:b662:2272 with SMTP id 4fb4d7f45d1cf-623786455b1mr4763129a12.33.1757287737785;
        Sun, 07 Sep 2025 16:28:57 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-621295d635asm6716921a12.40.2025.09.07.16.28.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 16:28:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6228de281baso3041815a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 16:28:57 -0700 (PDT)
X-Received: by 2002:a17:907:9708:b0:b04:848f:a0d4 with SMTP id
 a640c23a62f3a-b04b13d2146mr575971366b.13.1757287737210; Sun, 07 Sep 2025
 16:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907-kernel-retirement-v1-1-e6f4b2eadb88@rosenzweig.io>
In-Reply-To: <20250907-kernel-retirement-v1-1-e6f4b2eadb88@rosenzweig.io>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 8 Sep 2025 01:28:20 +0200
X-Gmail-Original-Message-ID: <CAEg-Je_HNBPwWgm3sS9JJh+43wyo-QSjr1FKKJq22VcuF2cxVg@mail.gmail.com>
X-Gm-Features: Ac12FXxHcnYbJm2cztwXph6HDZ5s0fwABHYoAep7isIx_Mvof56FMZykcTuLhkY
Message-ID: <CAEg-Je_HNBPwWgm3sS9JJh+43wyo-QSjr1FKKJq22VcuF2cxVg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove Alyssa Rosenzweig
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, sven@kernel.org, 
	j@jannau.net, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:56=E2=80=AFAM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> I'm moving on to other projects [1] and no longer wish to be copied on
> kernel patches. Remove my MAINTAINERS entries: both related to Apple
> driver support. So long and thanks for all the fish.
>
> [1] https://rosenzweig.io/blog/asahi-gpu-part-n.html
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7ff55b5d321752ac44c91d2d7e74de28e08960..3c10a189421c9d20247ad1546=
ba4af31556c87cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1845,7 +1845,6 @@ S:        Odd fixes
>  F:     drivers/input/mouse/bcm5974.c
>
>  APPLE PCIE CONTROLLER DRIVER
> -M:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
>  M:     Marc Zyngier <maz@kernel.org>
>  L:     linux-pci@vger.kernel.org
>  S:     Maintained
> @@ -2364,7 +2363,6 @@ F:        sound/soc/codecs/ssm3515.c
>  ARM/APPLE MACHINE SUPPORT
>  M:     Sven Peter <sven@kernel.org>
>  M:     Janne Grunau <j@jannau.net>
> -R:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
>  R:     Neal Gompa <neal@gompa.dev>
>  L:     asahi@lists.linux.dev
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250907-kernel-retirement-f11b99161435
>

LGTM. Thanks for everything, Alyssa!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

