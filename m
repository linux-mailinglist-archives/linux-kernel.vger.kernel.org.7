Return-Path: <linux-kernel+bounces-856925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9FBE5775
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA99580325
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9C2E0B6A;
	Thu, 16 Oct 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdSJQzpj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2F239E9B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647958; cv=none; b=hmBZy5ttJL/2jJMLjzU/6+CCU7urHmQ7HaWpe9Hb4X1YYpBEplfK7kAcceg1CFUk6igocXf9RiReFN545GKeOawy5DOTbCLQvG13hrd0p3c01yuHyCGADCRC8XhTno+3DFXVFdiJMDA++5K8zpUS50KDliPRU4gc9ui3SQveI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647958; c=relaxed/simple;
	bh=PU/TdxNHBz7m/8QSydcfpOGU6UIjKJsiLDtqA4s9uLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Se8Twmj8bnUO58KdGgH8cEDukjb8HOMwvSad2fzbZ6d+0svLhpXe2Z2qpjXbLAsGR6uN6K0/aO99oaktWmcRhf91oW8mdMbJyZQAUMA7OBnwVx7imJkNC247qLxOeyeQaTR5J/mTKRU28mmVs+tKErqzVF/KkCP94hS4Zk/Jgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdSJQzpj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760647955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cKRiSBHedJeuF2YiPC1JdZMWW96N+8/8JV1od4hamE=;
	b=LdSJQzpj6VonGYUkTxhD6cg7fx6ksYNMBWqfCoJxDsrxiYT3bMbnpvJKBGU6RMq5xMZTUM
	E5G4qHRdcNT+6dqMw+2O6QDXOnAtL1hxcFaZuHsI9Noy22zpKysZMbTQE1RjKGz3e8A35i
	hjddUnYxW0Up4Ihq3FrHbck0xWBRplY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-R5qFwJewOX-WNs6bSVpEGA-1; Thu, 16 Oct 2025 16:52:34 -0400
X-MC-Unique: R5qFwJewOX-WNs6bSVpEGA-1
X-Mimecast-MFC-AGG-ID: R5qFwJewOX-WNs6bSVpEGA_1760647953
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-86df46fa013so530071285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647953; x=1761252753;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cKRiSBHedJeuF2YiPC1JdZMWW96N+8/8JV1od4hamE=;
        b=wjgTbQ1MfCHeLxeDqj8I2HO2q3WPmp+ZPyQDitTl62BzuL3W7U7H+zunc5MKHaNvpr
         WIfQzSG9bydO+ZeneKfPZ7LrdPOREGYsAgo4qV9xFJJrjsFXrN5ohMDHTKt8V1JsTj7g
         9WWRCNWrK42ivzFXC9fexQZk8GSoLhE5V3nYcp6TfpuD1FWWrR+Vy2fd3XJDZ8hthlbn
         kkBOzNCHrDOzY6Atf61wXd+4VGkk3Fe0DAJpali7OJLltNq/O62vhSVNDKTgQM2mLqzj
         c0r17kT9BlBQRpYxMFFypfFRUYKyEKWz9N0//x2V2ItSPEe5+qcSzakOher+Ow03xNTR
         qaUg==
X-Forwarded-Encrypted: i=1; AJvYcCWWT+ndujQyWYi1hRuw2xH42SwTY8rsIzsEe68W7XxvtGMnLQGizc6EL8ya/AzIHEdNirGmsl64xRlaLn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEuPn+LOVSp4w/M6K8FN6cH4LqtPgT5sGMI+VUbhRaSXo7KjG
	eiUGK7xIqO63Jz+6V8poKEgL0bRfYj1HjtDkc54BQ52N38+ClBqDio0yJ6K0OSD/say10iprSBV
	A1a08Z/bBMebgnDAGt27IvYzidZ0iNhvrwO3Bcc5Z0ujJYLvr7zkd06PuHxFCaoYlJw==
X-Gm-Gg: ASbGncsv/aJt0wOM91AbHMEvj79IRDlgsVKe5UVaQ+UGEuo96//uar+Opg/8LPU1I1Q
	pQgq/E2BaLGUE5wHhTZ4oPYA2HY+0FUOSD1tSfSETQzEjDhlLgIkngOPb6KHc1W1ZOu4WeF7twm
	cmJpgdfmwWLMSvAO2OkYqxJ9aJFb6hq6aQ67kYUfsMQqkAhTHCTcHxPTljJ3Nz66/015DhhcaFI
	sgfW8C4m1VCkIvE+I232IBxklYR9S9OQrxy+v/4aO4Pu8G5cfmFduM0XHHxZtH6jN8xMTJ0h+fy
	4M5qhFItsi6He5aYgnLYN8ovw2Xq0894DYnAzg3K9jvdd4inFzADrnnmKq6cCe/GZQ/+j0WOrhc
	AgH2oISK9tpr0GvlxJvmOxRGg8YWwLLSARnqmlk0h6Oo39rfK1fWGUsExAhIkdsTjDA==
X-Received: by 2002:ac8:598b:0:b0:4e7:1f00:2ce8 with SMTP id d75a77b69052e-4e89d281865mr19861911cf.18.1760647953500;
        Thu, 16 Oct 2025 13:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHATwA2Ecq5ayw4bx1RtADAqnB2jb/OZrDzGJ991Q3kxbxfK4bp4SH8V/S+x7MWZzR6YqvEcQ==
X-Received: by 2002:ac8:598b:0:b0:4e7:1f00:2ce8 with SMTP id d75a77b69052e-4e89d281865mr19861681cf.18.1760647953054;
        Thu, 16 Oct 2025 13:52:33 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0120cc36sm47970366d6.2.2025.10.16.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:52:32 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:52:30 -0400
From: Brian Masney <bmasney@redhat.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	kernel@collabora.com, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
Message-ID: <aPFbDl_JKyDay1S5@redhat.com>
References: <20251010-mtk-pll-rpm-v3-0-fb1bd15d734a@collabora.com>
 <20251010-mtk-pll-rpm-v3-1-fb1bd15d734a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-mtk-pll-rpm-v3-1-fb1bd15d734a@collabora.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Nicolas,

On Fri, Oct 10, 2025 at 10:47:09PM +0200, Nicolas Frattaroli wrote:
> When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
> operations, such as setting the rate or switching parents. However,
> another operation that can and often does touch actual hardware state is
> recalc_rate, which may also be affected by such a dependency.
> 
> Add parent enables/disables where the recalc_rate op is called directly.
> 
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/clk/clk.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 85d2f2481acf360f0618a4a382fb51250e9c2fc4..1b0f9d567f48e003497afc98df0c0d2ad244eb90 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1921,7 +1921,14 @@ static unsigned long clk_recalc(struct clk_core *core,
>  	unsigned long rate = parent_rate;
>  
>  	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_prepare_enable(core->parent);
> +
>  		rate = core->ops->recalc_rate(core->hw, parent_rate);
> +
> +		if (core->flags & CLK_OPS_PARENT_ENABLE)
> +			clk_core_disable_unprepare(core->parent);
> +
>  		clk_pm_runtime_put(core);
>  	}
>  	return rate;

clk_change_rate() has the following code:


        if (core->flags & CLK_OPS_PARENT_ENABLE)
                clk_core_prepare_enable(parent);

	...

        core->rate = clk_recalc(core, best_parent_rate);

	...

        if (core->flags & CLK_OPS_PARENT_ENABLE)
                clk_core_disable_unprepare(parent);

clk_change_rate() ultimately is called by various clk_set_rate
functions. Will that be a problem for the double calls to
clk_core_prepare_enable()?

Fanning this out to the edge further is going to make the code even
more complicated. What do you think about moving this to
clk_core_enable_lock()? I know the set_parent operation has a special
case that would need to be worked around.

Brian


