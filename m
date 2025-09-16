Return-Path: <linux-kernel+bounces-818908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E4B597EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5677B4DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED892F7456;
	Tue, 16 Sep 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvZ/T4ya"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84028488D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030142; cv=none; b=KJtiHIEuR0Cb6CmaDFr1t1qCctjcZjVX01VfiUWe2wIppQjYfvXfi1kfbx4JjW+HT6VwvCctXsxU2XoWaKjmXQT57GBADmtMhtewg3FWIITMbLsOWDF7XTqHwDv2u22tzb7cVnVLw/MOFAGQzDIZZQw+f2aFYkNefiPwPagX0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030142; c=relaxed/simple;
	bh=vdr5u5q9Bhj48crDv1gBhQAyvxe62lx71S66JxSvogA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOTOq3uyTgsXvJ1mvI2YKe/3VW+s7TpBlAd6dwvluoK9wEIBKUTz312UyrklkGOj9DATOgGeUXK1phUQioMmU8yCukAA3fcknuh8QeENJoseuFg7OmRjpmDidRmgSpEZcWwkBfU7GtQMkVfGtd7dTpCDOoiOPMz8JhtirYlDv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvZ/T4ya; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso7487484a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030139; x=1758634939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDOzSlxCOtDzcq9eIlh4Lly5zShsc9FWB3XHBDP+e2s=;
        b=IvZ/T4yae3wlfJlbt2zzKfoaz5A7yYBdexXjf2u12tbKK2N5QNpl3AYkmemW4De2Qt
         7eUw2yYzI1HG5LXBCK9NHYWEirQuoBsuzQpz0Szf/8jFIvPtnk3Zys8Z0PGE+qCabZWa
         gC9DxErx3o4+u3bbA9pvmEsPsdN/svN8vg9xnmS12KhbDU8dDao4zK5guA4xLFLrn1MT
         aXMIcSrAvcJe6+6Nv4Fo71dJfgITPMTZ6ftzy7rUk/w74RMYIM53Kew+QVl6awqs8yhh
         F3F9tf+8lIW1gEewbN1qNt+0L/ismpj6zabRWug+kgmzkQRMxGjG6BSpTv5tJWI+tVTd
         Jc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030139; x=1758634939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDOzSlxCOtDzcq9eIlh4Lly5zShsc9FWB3XHBDP+e2s=;
        b=dWIwMnGRgWX+HIJmKdpFQJtNQCCoeFR1IIGWAlvsUXHkYkBbidBVCp352hEDd1c2HL
         EFD6RPcoMJ2Tfp7AG4aZmQuQnuacBYTYUfMQdDtOQXgxpxnSDxPWIQmUKdCWYO8N01yP
         kO0g2ER8iaRBaj5srThgCureR9Zr3+wSIFDPR28W5k3vYfnDxOG71w40esuZHHzYFWI7
         ru3JEus6mIS682Lo1yDwIM2e71EKVO1jpdEIieuo8p0d+GcVpY47gLMwltG4C1nffnC/
         fg0XyNfcNy7zMQAPxxKPyRqfevvLnPjTvmiJo4O3l0Uk6CDyP/wW5ePD+DDG45ju38D7
         5HFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFzdyQKPpQUnbPD7TnXb5XeYG1U94e142vD6i3pcPCZA9mtnu9Rv4xn5c1TFefwH5EnYmcI3t/+v/hUKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOiP8j68m8ODLsnbNtlSns3z/pZgpgxuyDxeI9CKdsIRDjTfB
	cffqBvTYqObbE+BansFfvjyPgxKXHz653DF7vxt75GEM+9zIRO81ceODrrfx8ud6r9VdGGjUDZt
	nGib8lzpgId5X1yKjY44ia2kCWw6mbkU=
X-Gm-Gg: ASbGncszN0DayHmu31Nfb9E9gDO5cxpbWDJT2ua6SW6fAGYz/Z3U2gJ8VupBacntox0
	GvGZ/c/aHBBfUL9v3TaTIdWMaivf21jV6KC+Ud7ft+sfBF+yQlnyEz2hVOhqy05RG3zUeFrYPCY
	xCwAmMrLzaBvXU6oBizKoqR9zUbkyBiPO6zS0JupnfuAMN76iMBqhs8UJRYTs+5p7E0vShaZPdd
	jmwIDw=
X-Google-Smtp-Source: AGHT+IESTWeH4wSxjUaitY/65yvL9/8pzc5zN9froOQ+oJHxJy2uWXIcKOi3fMWT1IW9U5NJbPpKnRWop2D6Pg2q27M=
X-Received: by 2002:a17:907:3e21:b0:b04:5e64:d7ce with SMTP id
 a640c23a62f3a-b07c381eb0emr1760478266b.35.1758030138986; Tue, 16 Sep 2025
 06:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn>
In-Reply-To: <20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Tue, 16 Sep 2025 21:41:42 +0800
X-Gm-Features: AS18NWAzvTU5pCxBju5qtOwMpUpsMins7tNgGMYJPeMC-JL7B2y_3lBiKBu_7JA
Message-ID: <CAJy-Amk5UTE2HN_Pcd5kbvCsa247CZ9sSMNX==itXeJkWuj-NQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Docs/zh_CN: Translate filesystems docs to
 Simplified Chinese
To: shao.mingyin@zte.com.cn
Cc: alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, 
	wang.longjie1@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied! Thanks!
Alex

<shao.mingyin@zte.com.cn> =E4=BA=8E2025=E5=B9=B48=E6=9C=8826=E6=97=A5=E5=91=
=A8=E4=BA=8C 19:12=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> translate the filesystems docs into Simplified Chinese.
> v3->v4
> resolve patch damage issues.
>
> Shao Mingyin (5):
> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
>
> Wang Longjie (2):
> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
> Docs/zh_CN: Translate inotify.rst to Simplified Chinese
>
>  .../zh_CN/filesystems/dnotify.rst             |  67 ++++
>  .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
>  .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
>  .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
>  .../translations/zh_CN/filesystems/index.rst  |  17 +-
>  .../zh_CN/filesystems/inotify.rst             |  80 ++++
>  .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++++++
>  .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
>  8 files changed, 984 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.=
rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-glo=
cks.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uev=
ents.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.=
rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs-au=
thentication.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs.rs=
t

