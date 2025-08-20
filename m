Return-Path: <linux-kernel+bounces-778307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0ABB2E400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877465E5E75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7121D3F3;
	Wed, 20 Aug 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnnIpB5M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868370830
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710868; cv=none; b=AnBx+uZSR7zNQvvOvdVgH1ZmmYV31WeXExcAkPkE9RRHtSLBGyaRyeY9bIhK+7dwbEMZN54/TyzmEYrl70+IVTS4NGVty97txUd0CwLWc+ClVxCL/Sl7jlqlgGBd1oFSw55Xo8CEUbjVnrtDYpnpIjMKQ22acagBHR7SFCuT+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710868; c=relaxed/simple;
	bh=RtlL+EgCWSEqrQ8XVWOI4y5fAiRecth7ou9AgpT3nJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCR7JFD+Mf+z1OK9Gru4bgMAP1sNNweArQTcixhvr4G9FGxOkwJGIytkHaW23hkJtKmgTZflS3axzYZ1lQZNr9/RAOdZ26IU68dZeqrGWaEtcy2tv9OC+AIJyfzR3BWn2A/NzcrZrdXL1C60aC6I/Ysp4LdtDO3bezPtmGNqjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnnIpB5M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755710865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y70NAvFqmHqQ/QHVWzEdqMxMN+9/pnnsuJyiP3UY3H8=;
	b=NnnIpB5MmTS3tqpycWSJCuGseWo3+Gcub3FH2jnfa1QNHKOCurrk1RXuazAXV6Z2pZUqsl
	9Ner46RDyckJA5MWLoRbuF3OQlApzEZZIjc31Jy//c0NFQaK2HlVs8A+xhc96q5bGCe1wP
	SBwJ4Oyjea9lxu7x03MzpfJwUgRf+gg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-OzCzB-_7MSS1sWjS45y6EA-1; Wed, 20 Aug 2025 13:27:44 -0400
X-MC-Unique: OzCzB-_7MSS1sWjS45y6EA-1
X-Mimecast-MFC-AGG-ID: OzCzB-_7MSS1sWjS45y6EA_1755710863
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10992cfedso3510891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710863; x=1756315663;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y70NAvFqmHqQ/QHVWzEdqMxMN+9/pnnsuJyiP3UY3H8=;
        b=Lw/9UFgDDgEuLKTEZ7FEFMVa1ti8N0Ytq5mP8fY+a6Tq5GREGJPK+2DY1pamORpOoa
         XbwJTaPPOdMOL42qnsSTCPErD3+kLAA8DGIeihtFVmExmWiJ43RXNbu/iDgEm7XqxNSt
         KlqMbTe4XSDOCwD61pq7L+OGzsOLptSDykBjGDGr0LjwHOsYIa4GpDtW/W16zo7xavFj
         xARHszZC6gLwHqbW7/J6lZhBplO3TRs1dxUNK0PWMgX91PdvU/8rufh4ZYDglolN6Aun
         7NyGOhqE4EVL54h+ixCzJTskpIZyn2vUDjphdW6XgT1hFHY5G9l0AMVul3CHR85bWGor
         ySaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdqHhDYZcuhdmkxt5ZQnyyrTvwfLtTkM9+gREOrRO5fH6P0qCCD42e9k+D5bVlZITQg7QuDki1zD2Sgtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZV8q8YMl8Wie7ePocc0+VzsvTAtjBqLMoV+3rx6OTGdWEg+3
	N/BN/fc2eLq8vbVPsPHEdnpOwmaRtRieTA2+6drDHRSuigH7ESMBymqh8UHY6TWkjKbdMkNAiP+
	NbHOANFnz2hg8PVGFJqMTYvGPZ/SrPjh3jNFGF0udSFFNKganDT7LF5DUnPqtS00xaQ==
X-Gm-Gg: ASbGncu/9yMUSkHeu0EuYqqWQhWWroaKt7X+pc3t/T3Jlzzbibie27Su5+LV2Nprl/O
	0x6ibvpaeuwc+BGKrWDUdL9DpEwul+Hq4JDu5uBEtIOIdEYZHqKbShOFOYDa5X6cv2VSq5GoUGU
	oAw6F0fVuCS+fntZFwVdtAiXZQ6pOCSNAZftO5AwQpNH653Bx3aOV6IlIe58xnta18GKGa4XxEE
	8g+EeMa30bZbJjJ0tYdlO+oKgwrSwkQEyrd3B4Z3vUQELzHfbOxrGqYxmmCSlEUnoxeO3PfF84r
	/ZJ0b68dgiRWUC4TeCuj+zGorGrFxnt1mJGfRuJyEWma/KlWuElVDs3uwN97B4Q=
X-Received: by 2002:ac8:5dc6:0:b0:4b2:9ac2:6857 with SMTP id d75a77b69052e-4b29ac27162mr22632731cf.78.1755710863378;
        Wed, 20 Aug 2025 10:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBHjmp0EQimLUiSVjKdx79ljrj20Q8jlRYnemWAhO0v2X5MfDUxphjoE81Tq8MZ5J1pPp2Eg==
X-Received: by 2002:ac8:5dc6:0:b0:4b2:9ac2:6857 with SMTP id d75a77b69052e-4b29ac27162mr22632391cf.78.1755710862940;
        Wed, 20 Aug 2025 10:27:42 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm87927511cf.19.2025.08.20.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:27:41 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:27:35 -0400
From: Brian Masney <bmasney@redhat.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/9] phy: mediatek: phy-mtk-hdmi-mt2701: convert from
 round_rate() to determine_rate()
Message-ID: <aKYFh5YI9j-MHKH4@x1>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-2-9162470bb9f2@redhat.com>
 <aKX35U4jX55W3W61@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKX35U4jX55W3W61@vaman>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Vinod,

On Wed, Aug 20, 2025 at 09:59:25PM +0530, Vinod Koul wrote:
> On 10-08-25, 18:45, Brian Masney wrote:
> > The round_rate() clk ops is deprecated, so migrate this driver from
> > round_rate() to determine_rate() using the Coccinelle semantic patch
> > on the cover letter of this series.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >  drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > index e51b2d13eab473dddace48c75c2a8d73c8c65635..b0b6497e7eedcb6867541b573d22156ded29a4d5 100644
> > --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > @@ -90,10 +90,10 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
> >  	usleep_range(80, 100);
> >  }
> >  
> > -static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > -				    unsigned long *parent_rate)
> > +static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
> > +				       struct clk_rate_request *req)
> >  {
> > -	return rate;
> > +	return 0;
> 
> This does not sound correct to me? should this not check the requested
> rate?

I can't speak as to whether or not this specific driver should have a
rate check here. I've seen in some other drivers where the specific
frequencies are managed in firmware, and Linux just passes on the rate
request as is.

Some other phy drivers (most notably drivers/gpu/drm/msm/dsi/phy/) only
makes sure that the requested rate is within a min/max range. Assuming
I read this driver's set_rate() correctly, it looks like the min/max
range may be 64-192 MHz. I'm not sure to be honest.

This change keeps the existing behavior of the driver as it is today,
and just migrates off an old API.

Brian


