Return-Path: <linux-kernel+bounces-865635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35801BFDA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F71D3AB2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4FF2D641A;
	Wed, 22 Oct 2025 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jb34y15d"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9472C08CD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154893; cv=none; b=RttXVek+k0LSzRVZ9a/gB8+QHCGf2LVMOk+u2yhqV/6QEhVhtEzZPbRH7r0rHlEsryYb2+HjZQEUmPKNxYrgmtpDZYsmZFXppCpa1oPRYsVaUDnirW+a9Sg9QAdL20Ul7IpxHyJsgv5GxvKiOjhlJDw6fgBs9Weho6QMhpN0CAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154893; c=relaxed/simple;
	bh=HLBPhheU6Sdkv+wRlRlVzbDRgyBTZMrIiQW9rt4vggY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II5roxtH+RPEzD3V1YApGSQxreKbabFCEwpD9n1qcsTh/KQsR2b3xKeZlaBPqTMz4pxVgtXNAnIsHtE1OC8l/PMoVeJ96PSXa9GCMi+dZRK7KZf8WlnYarFSYJuNWqdfm5ENu/kJzWmkxFT2mvdyEDX3YnoCtIdxKxeXlMsnnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jb34y15d; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-796f9a8a088so6491125b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154891; x=1761759691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/yVbcNYBKxI7HZmam8giV90V8J7uwfsDvse/7ETWpU=;
        b=Jb34y15dFuzwpYPsSIhaX1Cr1AR7lDSiRuuIiaS6+c+KuINzsKJB2kTk7GN43rdDMi
         wjatJ0vVMnlAhk15gK33TZowcqCApwLU4wSNY/EiJc8tLiHbBaO6MVvBTGaZjiGDx9Os
         CdxLoIRxvico/WD57SxZlSea/ymKKU9/Nj9xA6XuD99yRTvZrBXnaciWNoaOMnDJsUOx
         DQB42mg2uqeqyE2vOFdE9uK3GXPFFcofe1WaWtq5Fe9MkIJYfpcqKPaA3pbrxDtchPk2
         wX6RGejlAe7KECtRqZurXEghXA1gAk/do+U6gCT1RMVTZRdRXuVWSVYE4Ih8q9SrszWv
         72jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154891; x=1761759691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/yVbcNYBKxI7HZmam8giV90V8J7uwfsDvse/7ETWpU=;
        b=WW0KafuS8TLZpkudQ4h3HsgnXA2gm9QH4damqYGzxG7Oh2VNhQNkXi/ju79/6jiIEJ
         G6+7ldEnuLXY95NX9tQU5vu8MPW2lxRUShLExE136lVSeHwELEHTsk8TlgLqHj/XJPOw
         V2Bk2bdqCHnEzeEHBSpHrXyEY0YIaTyL+ju30fcED9tvWc2CbvXTxrFhOGul5tP1FzPf
         I8EbXuAsr2AX9irGdKIG6UWq9nvZyVaFkKdNGwMRsMybwRi9HVSXZgp9eNoypurrywTD
         8v5J6GaGUnQuHMGXr8XepOq+OBP4PBPahbIP0M1aZE8iIr5F6/c/tkGhzAVaAxdTtaEn
         5F2g==
X-Forwarded-Encrypted: i=1; AJvYcCW80w7+6Od3n4G7SPsbE4YdJGtbNI56Mn+L0JKGVOIZd4wPDo0Zi8hvVIoo62S/B08hRFhZ1tZ04Mq41DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQPgwkQ2ePRKL/mZorl5K+munIYKsmw4bLDp5z55WpVxCn3hm
	5v62zoI/VAO3kJy5GEwbPDeTi7d/LowHg2Bqs6fHDjgvraeoAuj7lS9hcbGMJlYLLg8=
X-Gm-Gg: ASbGncsz8ue9EUMI6BP+Hp06BQsgJ63DJL7QdNPuuuSiNyFsCddVJCYu4FiGMgAzYn7
	UxOpK7ZwmAIwb5ZrhEiU16fRL5Q3ChSFFOh7UTKOVSqG9YoVfbtzzO2q2mFiDHYv+muM8mdky25
	Wmgzt8BzDrCT3E5u7F/UUO1gGUwnyRiOzUcCi4EcIOGpFbYdONAtTTWdNYnLqzIwfQ+mARNHqbN
	WjTiJNeWQ1iUgJ6FOTsceaHOqUoH4mpOz5bkuIjQAHxhgsss9SVvE+nfZuyCvlK1f/kRy1N2/a4
	OS91dCecwQ8QuKN8s7hvH+xbSuJXpbKZoNSVpcmC/zMJqz2c501bZXVmnAFdg5xeUJi5i9flMz3
	RZ9DAISL4T35f7BEDp+keCasqW6qAjNiFYGQykXATJOaVczOM0ZiI90PqBdynFH85WblyVKmRpE
	cPVLoPbwByZTwSYg==
X-Google-Smtp-Source: AGHT+IHjwdJFhyPffGM4FBkB+w0a69ezxil2LnB/hHwjzMGVo9Ioll+93XMe3fLrl1LPLka9UTkijg==
X-Received: by 2002:a05:6a00:9a0:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7a220a7e712mr26747780b3a.8.1761154890617;
        Wed, 22 Oct 2025 10:41:30 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:7843:84f1:e4ca:d99d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39654sm14983897b3a.31.2025.10.22.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:41:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:41:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add an entry for i.MX remoteproc
 driver
Message-ID: <aPkXRy7TsPCrq_s-@p14s>
References: <20251015-imx-rproc-c3_1-v3-0-b4baa247358d@nxp.com>
 <20251015-imx-rproc-c3_1-v3-5-b4baa247358d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-imx-rproc-c3_1-v3-5-b4baa247358d@nxp.com>

On Wed, Oct 15, 2025 at 09:52:59PM +0800, Peng Fan wrote:
> Add an entry for the i.MX remoteproc driver
> 
> Acked-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9cdb95dc150a55df405adc3cb853c61f4c2b467..02dea709a5a5d591f156becd35640dfd93fe62e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18610,6 +18610,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/*imx*
>  
> +NXP i.MX REMOTEPROC DRIVERS
> +M:	Peng Fan <peng.fan@nxp.com>
> +M:	Daniel Baluta <daniel.baluta@nxp.com>
> +M:	Shengjiu Wang <shengjiu.wang@nxp.com>
> +L:	linux-remoteproc@vger.kernel.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	drivers/remoteproc/imx*
> +

Here I am suggesting:

M:	Daniel Baluta <daniel.baluta@nxp.com>
R:	Peng Fan <peng.fan@nxp.com>
R:	Shengjiu Wang <shengjiu.wang@nxp.com>


>  NXP NETC TIMER PTP CLOCK DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  M:	Clark Wang <xiaoning.wang@nxp.com>
> 
> -- 
> 2.37.1
> 

