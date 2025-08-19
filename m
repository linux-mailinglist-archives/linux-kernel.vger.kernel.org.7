Return-Path: <linux-kernel+bounces-775627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D067B2C28D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A48C34E4485
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675C32A3C2;
	Tue, 19 Aug 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asGMn7og"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BF3314A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604943; cv=none; b=dkobs8BWe8zcXlzI9mxX3vdwy2GZ/iRB162he1G5G1H70JIIMqbzLE+eyZnHmJHOlY79+HIUFnWPuAT6l00u4S6kDvucBU2ZcxeFPgRZhD43SxcRZiM3l4xOhvaivvHzpW2utKiTGvcywX1xCoaGgo1YRyAwfiAadeuiKdbz1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604943; c=relaxed/simple;
	bh=6TVZrx3yW/3GVfN0JiLDvi8HkyKmD5vQzNInrrNbY80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJ71mM3ChTHZdM8BV06xzM6Tp/w7ojz162ZnPh3VO1CJQUA1lb4vw/yb44eA3jPpR1eEiIkhLyzb0NGwbVGSlDl6QQAgTAgkdAEW1a9VKO0wlrjcdi49+6qEKjN7H5q9N+9idfRforwbj+zn21rMUmurAhMBsPsYFuAlk70tTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=asGMn7og; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33418dde187so20363031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755604940; x=1756209740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TVZrx3yW/3GVfN0JiLDvi8HkyKmD5vQzNInrrNbY80=;
        b=asGMn7ogJ16Dq7so1Si3iCYCVZiB7PMLqsXWsbmY4qdpr6p5EJ157gKjTSJ3IuRHYU
         49xxvMz4NGmaRLV3RpFUacJHPcpT53lJFy6FaYl3RYVdfgf2vhatH8o5C+6NptHl8cFn
         v7aS3buwXHjWWbjloTgxq+eKSNQdowYY5XOAwfbsfRNjeXbnO7Jf7BHTZ7ElTv869LaF
         365rzpIlhhG4JD+S+dZcBXQP6L4596F2ILi49jAzx9PhRjjiKvFLi36CGIvrGBpnswIJ
         cZWyLUX7srYwe4YgTjbIDoHInRmK7sqSlN8ITAcyUCRyVjiuACHUiIuYgTYcSFk6eNsy
         lzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604940; x=1756209740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TVZrx3yW/3GVfN0JiLDvi8HkyKmD5vQzNInrrNbY80=;
        b=flUEOVE0YXrezS4xa974ya/fJvUTBf66xyoiAgYKBQs/CoDH2nFC/97lkzutu+puCV
         8qP9ZvbLehRpw8zYb8e3LSQtOnIjICwkLr/Ce5TLhhZ0xg1MHd7IwKvZmWMtdV/r70NG
         EdclbsTxeIkVWFNHzdIta7AiChYx18wMQm4jmF43LznBS/dvZPHv0qyb1H9gFawy51qA
         627VGfvKiBAglBRWQRMfsLHLiWT6Ke6S8k1gSJOSuGHv0iwCwwMBUS5U86PqPzlQdJfY
         iy3rDErZBd5EZLg8560N8wGl80NNqGbh4J/sdupqparW8kMVCChex9ojgzypfe6/kpHj
         1IIA==
X-Gm-Message-State: AOJu0YxueX5q48+vm/5RPTLJ8WNn+H4iU5xE9GZ/F+GJY3+8e1V6WKQI
	vc4USx5C52me2RoJnKJx8F9dRbtxCod1icBG0NyVhOQYn1Z8hfTtkqbL35E4bwjYz1T5tCCQR0a
	Fsc5inbmcAjV/LVbf3QQCfrkE/VueSZUW6pa3vpU2Tg==
X-Gm-Gg: ASbGncvRHaKrCIPuMJJr01cKDIe9mAS0eQirBo47rvNHUxfrEO7u/QGGgf3uxrAa6iz
	EbKQFSx65umaa7ZQOpiUsyLvWcBv++KxcPayu4so4kNKEgO+i0P553mu3xgJtxeRvaXxXN+Z0O7
	oq2reZjK328e/R5W95akGRqugI+qdCc8vn7sciAcKPtfuUTUF2gdmyyrc13beTGm52WsOcnranQ
	COVvjw=
X-Google-Smtp-Source: AGHT+IGsV0nxIVKmGLU1AbxhgNB7rkNNlCrMxlfSh/p2qSJY/mwbJNKjy1UNUy4ywd4Q0n8jSPBLk4Hgt16QmJ6oP9E=
X-Received: by 2002:a2e:bea3:0:b0:333:f25b:2905 with SMTP id
 38308e7fff4ca-33530721b94mr7284791fa.35.1755604939647; Tue, 19 Aug 2025
 05:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com> <20250813161517.4746-14-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250813161517.4746-14-wsa+renesas@sang-engineering.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:02:07 +0200
X-Gm-Features: Ac12FXwYP7tCmXvvIyV-DdybN_dEgpuebivdGZAlYKXJ4ztPG0Y2kKaouge8baM
Message-ID: <CACRpkdZgmW9MXAKbMxQ9dHz8-Oi8pVCPqnV5OE3FbA4KT+0yQw@mail.gmail.com>
Subject: Re: [PATCH 13/21] pinctrl: remove unneeded 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Andrea della Porta <andrea.porta@suse.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:16=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied, rebased on top of Adrea della Porta's changes
and fixed the two new instances as well.

Yours,
Linus Walleij

