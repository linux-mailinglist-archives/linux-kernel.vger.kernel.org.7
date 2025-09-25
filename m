Return-Path: <linux-kernel+bounces-831726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880CB9D693
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A6C380531
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021012E7BAE;
	Thu, 25 Sep 2025 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuiiI+sN"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF662E6CD8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758776083; cv=none; b=LrrinE/TXSZ85jxzpLB02mTenGtxbt3RlOIcxZ2hEB8YICt5AidI+mhJyIKMLCuizhfQ79JBfoPMpqtiblDBo7GlBJdtIPgaUiGOIbrF0q7uDnzaKjMVE6TTlivCKK/3XQir8SJk+1INdZGN7l/FIQEUDbSO07yJK/ursPlarn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758776083; c=relaxed/simple;
	bh=rwFjnBd/arunXm3tp0XfDKTYREgqSAQUlx1L0O8iPLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVOqlD2G6KVgm3DUIepQcJ/1NZrsy72p3lZPlzeVZawoqymCqx8ONlZoKDWguWzf2qcfFizKLxr56E75yB1WZ7ftPOvYYvB1XZEbl3XN87X+KCqiwRkHN6/mHFGsCTGX+CsBI27880pp34Ry7uGsi9lN4aAvXg2gYxysbFrVNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuiiI+sN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36639c30bb7so5108731fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758776080; x=1759380880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfOJlNr1JeVzQacNsJApm6u3eklKPliDP0EOZ1wC62c=;
        b=DuiiI+sN2rfnSnmhoELKNcQaxFUwfYvWCtWx7eDqipFUGnqbLDhyFpruGG2OyCL8eJ
         dnw8UOppbNLUmg2S5fBHa72faZdTW0+mAqCzCK6jUdm0Axy7tLwGcUk8ZGb5TZMxjb8F
         Mzo/fY8D28IvwJTOyD1s7oeiJk6UJV0l2sI5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758776080; x=1759380880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfOJlNr1JeVzQacNsJApm6u3eklKPliDP0EOZ1wC62c=;
        b=aBg/9eZHXbGgu/Ahci1LyykxbpviAfL/cx61sVicm3x/Jgzo1iEr7BfpwizHhK52po
         QcF4MSPj+r8uMGKDuTMMacR1N4IZ3JsBGuVdROuXroRwGU3wEDpLfz39jaxpswH9L/Qb
         2Ksm0vh8JfWCQ6xJBWr7+nYB5V5Zct3Lbt1mMZlENE2uIIpOdf27zOU5Otx4hOvJE+pP
         tuGeTd6fkdxbWx9+v82CxlNds3guFjBkZW+0TJRZYo0b3S++WDZByIXmi8FH4V7lrGe1
         7VGYWXkhD4aaVVX/oN8h6qQD+pgFg3dp1fn+Y+XAapFYum5n0dStvrvJcJELxZ6yCikT
         Tj9w==
X-Forwarded-Encrypted: i=1; AJvYcCXDKMDcU6pYrthOM81DEKlJ0k4Q34JdN0ozOg4gKgv49xx+FScpcLXHpXeXC/pttLRikqnTgSvVzAfvLQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztCf29MW3aQhn5RVlxpzZgCw6i4RvGwkMueZUzPUDlgifC8Ok2
	w+TpexpgW7TJAWPbUJoOfYPz/xlUR4NASrUHuJL0+5E6GCB1fhSaxndMjSVBzuu+PKMF6W0u1Z1
	BdfW2hjn/9P7WOdM20CwXRcY52+ytt15rFewszGG3
X-Gm-Gg: ASbGncuRoLZubq0hmV6YL1AkMamJyB2BcvZCPEwU7cdiv7bS8AZu5Togz7bIiSQUAAL
	8gi5cvu1ns0MLgVJS36Mlf6mJbahaYLtjsQ4rHf122CVR1yX3yVM2Fy5l+j44h2YOPg2m9XQUBe
	qBfKCd9FkZpOaoomdh8NKHWsdZ/wdBghYa1zaZLbH3C1V0VKKDgCP84g9T+wBqudsLDebp6C6Go
	flkOcQSvzaoJcn6A5+SZOSX4LjADcBwMQGn1A==
X-Google-Smtp-Source: AGHT+IF0+5f68ueTJchiy8OVva2aPyot+zNZ1LmHpjgzKmp8yTmlbDcDBtW5B2Jmd8k/IXzMW6KzTG/3d0FIWAKFPI8=
X-Received: by 2002:a2e:bcc8:0:b0:365:b79:8845 with SMTP id
 38308e7fff4ca-36f7e795878mr4719381fa.10.1758776079768; Wed, 24 Sep 2025
 21:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924133552.28841-1-johan@kernel.org>
In-Reply-To: <20250924133552.28841-1-johan@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 25 Sep 2025 12:54:28 +0800
X-Gm-Features: AS18NWCf3jNifuSG2T8itLUmSv-v41oBGMU6IUYuN3HfGIanTdAfEHlrZ5xZLDM
Message-ID: <CAGXv+5FDyB5U+ec62D9E_ULvsDm7GCddpQqw15eQqN5oVPohDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] media: mediatek: fix VPU device leaks on probe
To: Johan Hovold <johan@kernel.org>
Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:36=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> This series fixes VPU device leaks during probe of the mdp and two codec
> drivers.
>
> Included is also a minor documentation update to make it clear that the
> VPU lookup helper returns the device with an incremented refcount.
>
> Johan
>
>
> Johan Hovold (3):
>   media: mediatek: vcodec: fix device leak on codec init
>   media: mediatek: mdp: fix device leak on probe
>   media: mediatek: amend vpu_get_plat_device() documentation

Whole series is

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>
>  drivers/media/platform/mediatek/mdp/mtk_mdp_core.c  |  7 +++++--
>  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 13 +++++++++++++
>  drivers/media/platform/mediatek/vpu/mtk_vpu.h       |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> --
> 2.49.1
>
>

