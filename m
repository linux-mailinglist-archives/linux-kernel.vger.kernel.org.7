Return-Path: <linux-kernel+bounces-772786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3EDB2977F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF87203032
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7625C81B;
	Mon, 18 Aug 2025 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJ5KLW19"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36B1E5215
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489205; cv=none; b=aeikUjf7TiyT+ZBEQi+B5VDix7d3GGaoObd5IL9lNVirNREbP/7z8xC15PljaTYxssLSyXdIGo5UUkaVunRGD9i5qBeqdFMSATr/vu35Il1Gn6ivTbZBxD7Tu9T8994RuA2YOSd0EpTuQxQBssUZHowo0BdgcYeXT87yRu0G7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489205; c=relaxed/simple;
	bh=72HjhGwzLL0PbZTSkv6wDk9duccZmIns+xeA/qk65fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQK8s3LsXZc3COiqo8DwQx1eJewwzVJ2igZqMyDoW0g8iZ1znvD/BODqLVLqa2DNHsaGjZupdzsxicyDLkh0VWZNSte5eBdwQibFE0xM4usA5Nk0X6qDLXWShhXQFdS/t4fPHRe+oM+FMBt9ibD3BQDvGDmMb5FxmCaRL4soUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJ5KLW19; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-333f92d682bso31027041fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755489201; x=1756094001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72HjhGwzLL0PbZTSkv6wDk9duccZmIns+xeA/qk65fA=;
        b=WJ5KLW197/8G2neR+DlUCExP4EYRUC5hmB3WAneNnsobQca60wIt0hJFm+wfN5HssC
         NWqwJh9MogpgWsivGgHJyZjDoxKPoPiNYFDvVDls/mg+rxkE2LweIzVfgrw+GxvDNLaz
         VXGxUaOZ96A4hx44fk/mdnWFodcjLv7D6wiGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755489201; x=1756094001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72HjhGwzLL0PbZTSkv6wDk9duccZmIns+xeA/qk65fA=;
        b=fKetjvH/Pnb5eQBaes1X1Qep8ACz9bKdQjfspu2i0FU8ULYRfMuJe7uvxs2uZ2Xw51
         oyDqRKqWJ+v1nF2hJZUW4Q7r0K4I0H5XXlR6csLPlS/a6UxHQbFSX6gi0WMa/bIYwXbP
         XdiqWjVpnZs76NAEA7Y+T/1tsdPsxxVIh75PwV9zqW3F37dyzlWmN1xi30f5vOq/1n12
         tNTOoJnYzlkmwyq51BNmakK9v8SKyTmlmp5wCUUiWxxNJQlxZa1Q7M/3ZUUbxeTqtM17
         VOcTBekQwvv++yTYMZoFo3ccc6uEvPNULk0HO+7ZPIKImIgPWv+uLBxpUenxYjIr/hdv
         Tc5g==
X-Forwarded-Encrypted: i=1; AJvYcCU4y/q6F/ngcbts9JhHpgMNJ191TeTiKuWbnQ5mlNtvOsSg8X679ssMykn2XpYuK8wHKkanzYkqIMHPaVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LBBdA68fxvY1hL0YRxS90PMDwluqLA4XbYLNhxhuIWybzPUj
	uxRqEVkCuj36EqUMUT63uGJwErV0kgHTHQY7+zPf5jC+TKlwe7IV/JC9JOGklkFcc8RuHrDbF96
	uy10FDV3Cop3Y0wAFc9oncuCgjTP3lz2HJhDfk4Of
X-Gm-Gg: ASbGncvxGplIDKJeqItUACtMIb0myhz9R7OES94B8y4jLaTBPip+wKVJylYM2guv+7X
	hYjOldrI3NMT+9ccistRuPeKCNheBKAnk4KNqyIqfq8AP/J52rJiN+nMewHjBY4DNW/Fe456wu/
	yXaMQYGKjG1Qf4M9oEJDX00MEq5JcMVNujpWOcdEEExuLr2QvNoMtK/XE+kKJdc66LyiQgwK4w9
	ICtNB9ZTnYCuN76cYyBCjcB4ki6trjzDFE=
X-Google-Smtp-Source: AGHT+IFPS+3sb9CZbTWfnTjbDa0k7A4z8cLwROgvhlDgLeCCeIOup1wcDfmt4xXnfNBN2Bv5bh02EwambURnN0B3nkM=
X-Received: by 2002:a2e:b8d1:0:b0:32b:6bae:e3fe with SMTP id
 38308e7fff4ca-3340982d970mr29405411fa.9.1755489201494; Sun, 17 Aug 2025
 20:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816075434.31780-1-leilk.liu@mediatek.com>
In-Reply-To: <20250816075434.31780-1-leilk.liu@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 18 Aug 2025 11:53:10 +0800
X-Gm-Features: Ac12FXzbC3a5fYlt94iOei7CP2T8RPhSU-BFGXIPrEu4iVpFb5TXKRGwyAlG1lg
Message-ID: <CAGXv+5F8ABGTRdUrf0j68cLiHZHSEFjwDOBtfTZBTOWt9APVVQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD
To: Leilk Liu <leilk.liu@mediatek.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Qii Wang <qii.wang@mediatek.com>, 
	Wolfram Sang <wsa@kernel.org>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 3:55=E2=80=AFPM Leilk Liu <leilk.liu@mediatek.com> =
wrote:
>
> From: "Leilk.Liu" <leilk.liu@mediatek.com>
>
> The old IC does not support the I2C_MASTER_WRRD (write-then-read)
> function, but the current code=E2=80=99s handling of i2c->auto_restart ma=
y
> potentially lead to entering the I2C_MASTER_WRRD software flow,
> resulting in unexpected bugs.
>
> Instead of repurposing the auto_restart flag, add a separate flag
> to signal I2C_MASTER_WRRD operations.
>
> Also fix handling of msgs. If the operation (i2c->op) is
> I2C_MASTER_WRRD, then the msgs pointer is incremented by 2.
> For all other operations, msgs is simply incremented by 1.
>
> Fixes: 173b77e8d8fe ("i2c: mediatek: add i2c first write then read optimi=
zation")
>
> Signed-off-by: Leilk.Liu <leilk.liu@mediatek.com>

This was

Suggested-by: Chen-Yu Tsai <wenst@chromium.org>

internally because the code looked funny.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

