Return-Path: <linux-kernel+bounces-827359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7337FB918A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337F23AFB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2E30E821;
	Mon, 22 Sep 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="CPg+PFRT"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9B30EF83
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549501; cv=none; b=jeGpyRzwFKxQuhaNKDWYn9Vbpp4Zb4WKa2f8cIadESt1HaNYe2Ep1OVzBqIB32yPY7Gr9tcYgRM+hRzCxzd3ZqwKobKMinNh8+i0aOHjODR5M1FPbsaiUlAG0A0cgMnqsIGxpb5audNaajibx3KlAG9vuRcjC4Twr6x8uArg92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549501; c=relaxed/simple;
	bh=/bByTikaDpZO4dIRnrvdQkhLXizAJIrSrRF7ztsfqEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkbLlz1y6v1n5+3xqjtzO+8xLiaj73Y2B0sd0Uleg/lfIGOCLJpwENMhrYgy39SxQlqduynxI8wJLDP3+Xw9FIm84T0o5NuZEEed4rNUZGMtT+29pKtN2VoIehAuwrtESdp1iWhNCBM1ZONTHWUc2eFg6XGocw6cOvMDyNVJujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=CPg+PFRT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b7a40c7fc2so70084611cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758549498; x=1759154298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXzUT3wmSEFa7kkyt4eL+Bcr+Ou5keciQCQXtOX12iQ=;
        b=CPg+PFRTnZ5QgxUjnzN2Il86DPxkoatOhuaEHkl8Q3Rs7rFmTZTtnw39JWtLHlh7JW
         h02YBKj53b9jXD1niEJUb7zHj/carCFdFem3VnotbSDVT55XdlonvHfwGj2KK3Guzo/Y
         EXAjHTaThUoeh2Jynz6GeSTJLJauuD3a1rUGb+awZuL1dKlpL5/ieDNFxeKUjksdLRye
         EjTuL5p2lt/6zBu9UkW3mx+qxJGhuxa/mwvLIgQTpAWmRRrVKLD5Cpy/vwqFeXd+N6RQ
         lCvJTJ2Vhaqq7vW87RBxXayjeLK3gq3erCc6yOtSUp5aYSG6CYYyHblCVf/wfZjwV2K6
         PuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549498; x=1759154298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXzUT3wmSEFa7kkyt4eL+Bcr+Ou5keciQCQXtOX12iQ=;
        b=bOxZQY5usKu6984rS39I1yflSQHv84d7bSPYYwKk/x/AWfSxQGAyNWWQEc4TYmsIuT
         +leYZmbJIW50akV8D/hGuQsz+vBYa6CzDzsljwK5tY2GGQHPcO5gcAtm/2DhfWFtfPMr
         6hjR5tqM2bpli+l6MeRDdkC2eJAiO9JuxXqi0dinpfstljcXLXRaGRjT87VE/o4YKuQG
         GGA7WYDG5QJ8wJR4OfsEHoN5fOZQ8NXUraS4d/06poKDLYUEwsyP1ePm275kae0JN0tN
         fRUV3+qOpFnDbcRz/sWv+d+J5TaSxU+pFHXoM3QQHylriq42qPyiIr5A39L2CODQdGeu
         nCJg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUjgkH7Rn4+wfMMaudJSSekDH5TkdED9yxCxrvzpuM4jtvcUh26b7aTDGeZH0RWQY3yRVywjkw9gihuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMBFWPO6O3zKsimewgyipnKLCVpYzMcdHpVlAPaK0RszfwUni
	ePYmRlU/DZ9r89tEdok3z2p7wgVizCy+gE2WyhVb7Kix4LmzBqvCYOOPgYz4xXNmAA==
X-Gm-Gg: ASbGncstshs5vrcaQ78ybYmoQjyHMI6JkG+x6CUf+A40pvALhprhvfbFcTcX0mFJiuZ
	EXV7JbIAlTdEWUYUQdiwKLfJP2hHYunRN0Da4ST6TtMupF+iQhoVKfpDStuqAstLBwuUk2OyzHD
	axjeE8QNdkeG6RGTWT6Rsn/pCOFU2UJquwa7e0ZjKuBqvnb76pJhgmghn9ys6ULYl08wcPbj3op
	197znplZMNFttpEn5qb36ReI/zzEhveXmtt904HQnuGZrDBnTdmfHy5JKENDkwU1jfpkyJd9hgN
	sptxR0UZYxNc63xW6wkYlNPt09Vd0aC3vkXqF5Qa9i2GrtGd1+DMoV6mYDGUq/ZMCuU0byunKOW
	CeVme/1XOgQ60d3yZ4ONo9lAtNBEjoEsggy4hHuCSyQ==
X-Google-Smtp-Source: AGHT+IHtndZm+LoDIY6i4VIuumAfRCnHjP4xtexFeR9g5QzIS3AMNSm/jB38OCE/Tg2E+A3OLhfCDQ==
X-Received: by 2002:ac8:57c2:0:b0:4b7:925b:43ff with SMTP id d75a77b69052e-4c06ef831afmr135708501cf.35.1758549497820;
        Mon, 22 Sep 2025 06:58:17 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4c99c644758sm18559371cf.41.2025.09.22.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:58:17 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:58:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add Aspeed AST2700 uhci support
Message-ID: <67259dbb-4586-4099-9762-5c1d143db7db@rowland.harvard.edu>
References: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>

On Mon, Sep 22, 2025 at 01:20:41PM +0800, Ryan Chen wrote:
> This patch series adds support for the UHCI controller found on the
> Aspeed AST2700 SoC.
> 
> Compared to earlier SoCs (AST2400/2500/2600), AST2700 UHCI:
>  - requires a reset line to be deasserted before use
>  - supports 64-bit DMA addressing
> 
> This series updates the bindings and platform driver accordingly.

For patches 2/4 and 4/4:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

> v4:
> - usb-uhci.yaml
>  - fix errors 'make dt_binding_check'
> - uhci-platform.c
>  - remove IS_ERR_OR_NULL(uhci->rsts) check, due to reset_control_assert
>    will return 0, when uhci->rsts is null.
>  - use dma_mask_32 as default, and just add aspeed,ast2700-uhci for dma_64.
> 
> v3:
> - uhci-platform.c
>  - add reset_control_assert in uhci_hcd_platform_remove.
> 
> v2:
> - usb-uhci.yaml
>  - add required resets for aspeed,ast2700-uhci
> - uhci-platform.c
>  - change the err_clk before err_reset.
> 
> Ryan Chen (4):
>   dt-bindings: usb: uhci: Add reset property
>   usb: uhci: Add reset control support
>   dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
>   usb: uhci: Add Aspeed AST2700 support
> 
>  .../devicetree/bindings/usb/usb-uhci.yaml     | 13 ++++++++
>  drivers/usb/host/uhci-hcd.h                   |  1 +
>  drivers/usb/host/uhci-platform.c              | 31 ++++++++++++++++---
>  3 files changed, 41 insertions(+), 4 deletions(-)
> 
> -- 
> 2.34.1
> 

