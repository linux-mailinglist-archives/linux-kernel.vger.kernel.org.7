Return-Path: <linux-kernel+bounces-885138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26916C32155
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9534A490
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32A33345D;
	Tue,  4 Nov 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn5XBqtv"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE732F775
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274057; cv=none; b=PcIzYv0PnIGb02nHPHS1xTc9jhzXutC059wTC9HX4iafVbEyr3n78bmMdR2rtyYJU1daajseAyHMCsqEv4AHQPxwTr2TcjMMub/+5MpaUSpaagOfJPQsj5LTggQCHEHTmtXrmnwgSdHGCV98F01V/ESMOM0wRIoazN8fPymWREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274057; c=relaxed/simple;
	bh=a8zjnlZJoP75Gcp3unqAhRNeNHZZuPHHbDlOcyOC1Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkpY3RCk1dWg79zlooE3zJzj92dernu3MOjpdI7tT4wTeYIKwElHhr258N2NcUPUCaB14gHfKPMkKJiM13YG1m1eXPQco1U0Ny+urqvji8dluPjK6i2uCFepGR1YcIuyfnN66NRFLmdiWdEc6L3n2bVNbrpUFi7APRkZk7P1op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn5XBqtv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7814273415cso51731927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274055; x=1762878855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=tn5XBqtvJGKyjMeeYb+FMDXgjPt/GJuVrq3OqqMgC+IpQH6JgcYtcnS9COHnqLqyBT
         GbbzoBS+tgJLMtwvWaDQIvcWRjpBzr4C38m+IVJrhTQ5ppd0CcMw5gjr6v1PYvxjsEOq
         mtMRzliYCEPA9289aGvhp1sTw8i1ST96lNQ5zvRYWqiSw5qLqaxGX9bxlRNXvYBZvieF
         iFmrfcsjaeWRIC1G0/BqcTGTTjVUgqUDc+8Ca6qGSYL7SPwzb8y2rJpyoZq4aprRFFvN
         6ZYCOj12OaVPp86W80o5WD07DCOduUq5hMS5rWmukOWoe13HsxELhOQYI72O2YuHfKRM
         nRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274055; x=1762878855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=Kox8MfrJ0u2qgNNKkIKtn6ccllAezsMwYLntm3VkJzTql2C1vz3LMK1yWfj+K6ieKP
         /T9ok3OfdfL8P63nA1+dJSjeHfmJ3jYon6P8mmJCi8GMaNvnT/iJJA38JKUX/vpy3XWO
         KASYdEd3mASv7Z/Ch4xMh42Z5IWnSqUoO5xwRyglZDsNZ2Fm9v4/qOSORT5iiM4kjnpJ
         UAcGTy4ZAlMAMO13Zue41Z9qpDf21ykqbAYbvylOB9MRs5Oti/xJvetwnrisD2yRQ13g
         /binsyvz0K2woSKcpiIWUDxs/k3F6pHLM6oI+YZpO8JFMlOZ8Fd6Wp2Yi2LmTC3p5Nz9
         sX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9hJ4DnhZZRDMnzefNvIh4ijQMd+xz6QqVjjsHvo+Lwh/QPwAzyn/FfXYNZYOkbi/hoajpdNEnxyLgOHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0oeZadxlURNJYxSdI+uM8hup7bfmWzcYWySF2IDOGEYvVktS
	G3oDG1craPzxhEcRS54mXloWTpYTRgkN6pYr04xCnQ1oWuoLUxYnf/RLUTmPUknFQE3p4j+i/1h
	9dMM4/gz5sbj1FUiyclUMdyZU54ZEUmbNK1kbnKgVTA==
X-Gm-Gg: ASbGncsl+EFgzGTfZUFr1bK21VhV5uqF118+wGpDLmNEq64imVNQPCZT0C8rV6+qh/a
	BEG1LW7B17FL2j8dNESW1PYqVJkb4QgOQB8jPE7gwJ4To1g4m6oBEH6IMjTymHvNi2T3AK4V+Xd
	hJxpb84cF6jMfjt3d0CPPfZXfihgxQLTo5dQthYPejel6uE29P6sh9xy8TdV2W4sX6P2ZSZa5+L
	cPJXKfPzMa/yac8AHo4b17RLGmWO+awc1eueA18zLlMFDXN+deijxK1QPWAwQ==
X-Google-Smtp-Source: AGHT+IF0Z/yNF7yi6Lz9tQRkNyi37+NTyOPEnzyNmvGQXNJdjD0tMjSSXuyBHzY73wkfo4eUOH3v52Gvr3xMHkvavMo=
X-Received: by 2002:a05:690c:4882:b0:786:802b:d7ff with SMTP id
 00721157ae682-786a41efce2mr752787b3.59.1762274054906; Tue, 04 Nov 2025
 08:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028031623.43284-1-linmq006@gmail.com>
In-Reply-To: <20251028031623.43284-1-linmq006@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:33:38 +0100
X-Gm-Features: AWmQ_bk9KtCzO_f_YWM_AynJxSlgpLBL58lIquCitQc40-GRB32NM5WebMbg_Tg
Message-ID: <CAPDyKFqiNeO==u0j=VTKmWaG8VdMR-mS84QoLjrussfMYrr1mw@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 04:16, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 33991f3c6b55..a34b260274f7 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
>                         return;
>                 }
>         }
> +
> +       of_node_put(pgc_node);
>  }
>
>  static struct platform_driver imx_gpc_driver = {
> --
> 2.39.5 (Apple Git-154)
>

