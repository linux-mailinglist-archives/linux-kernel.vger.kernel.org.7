Return-Path: <linux-kernel+bounces-808318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0012BB4FE16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE6A5E5063
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E170343D7B;
	Tue,  9 Sep 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA8mATe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E2215198
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425555; cv=none; b=fvU/+WT2Ky6A8EXoL16IZMBJms+QYWqxi4qjvUMZVuzh0WLnxJAWn0Wq1LLwRBqgqWndSiZA9lvdwgOfNMhFzdJLWueoRc9BFGM2xsRF9pfP61EgrH+SWmRBPMAkpcPyMfZcvFhTwPGT2zNj9yHKYEfmxn7fZ79w4pWaASPZcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425555; c=relaxed/simple;
	bh=acugdeN6OR7NbGerFmoGWx3LlZzgFbO+NsmhejthVGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2gT12vo0n8beEd8Ld/UXY0OQshwv2BCtaOGtIrFu1lv1Ob2y6brpZuyIrx1I0yQQaCiMlOTyH5ve6Lwqi+W2eF/11YlOdEqYfBKCdSFiFSTPSgodWSAgiPBcHfSAfunTmVoqlIsj1Rf0XkqN89xtC+L9TJ9S3VoagO0McYKiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA8mATe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757425551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KuUSi/wMj/deuFTckhCe0po1wpou4UMuleZXZpAya2o=;
	b=ZA8mATe8MEWGDAT7FgOEJfCfCxhJ/hpbd1yBqxg1wPv/Eyvsik24cUU/BZh0U+Ma6NGOWi
	eMrtAhhWqM7svqydPaub90hJZaxrE93/JqDrjdbZMSgT1B94Q+JeyrmFHDSghZO1qLcnXe
	8jqvkKZjvkuJpvz8lLRJyJZWigF/WzE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Pc9Cqq5aNbiSOvHIdalwBQ-1; Tue, 09 Sep 2025 09:45:50 -0400
X-MC-Unique: Pc9Cqq5aNbiSOvHIdalwBQ-1
X-Mimecast-MFC-AGG-ID: Pc9Cqq5aNbiSOvHIdalwBQ_1757425550
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718cb6230afso123152436d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425550; x=1758030350;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuUSi/wMj/deuFTckhCe0po1wpou4UMuleZXZpAya2o=;
        b=SoY5qqqjUjCKjLNoshlHplrw3vesxKIaC+Oc2rLdF+0o77SmM+mJnnILvxYWIExODZ
         jxf4tWPxBxUvUTLVi0+a887P38FBtGS3nh9cdlvNrk/Riq74ieGtv4eQudyeSs+TqTZh
         arf7IlsdJsOm2HuLyRc+hMY8KyB+QK7nvJz/7DlCkCqTs+65Nr5h2ECCK7rmDks5OTAi
         qOFf/6ALx9IQ3vW8GeOBM7jmUzP4325ZC/Kj13YKs34Sf/+BsaPrEo6ajmUhvz3nIrgT
         AjNIdLgzZSLHPjVZZ4R9KZjiQ3fwn+Q2DcuKabVPJEVcMwLGWlA3o3rvdGk/OWOVZqqd
         9VLA==
X-Forwarded-Encrypted: i=1; AJvYcCWLUHnyS8+dppt8qJZ58owv0lMjwY9I1LsX34/P5QJy6WrPZdRrnwD0mv6ek/bi7OSliNdyrwk4U2gzcLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT12d9b/+VeY9u0jOPOlsF67PjXawiETc1xfkiYhhuoeSolyEb
	w0Kh5cR18yKvFgqsQ3/2T6EVx8Ke3tCJWbWF73yi/BTjvDgCtqHEIrn2dbEa7BvOqlGeuzNMHwZ
	T+/+/uxSxyb3XFonfaXZlXoanuUhhKN0blm5pLbuL6gN4VnpsK3xc5jgLqfphrwKyHQ==
X-Gm-Gg: ASbGncvkrP2Kf2EzqSZ7NN5GX1MhPr6YVackv+xGsdBE/RIRkVLvn0Mn6NOUYHuk+yw
	sAueu3ZtmO5h78JPJEXTihg3pK0TQOpjofyxNtCzrAJqAj5Hrk3x3Ohad/+zVnkMpigkOSHvcYP
	IWp0pfLgymO5NhlsQwU+UmnbZ5CHirKtj9ZpkzuGxHFiA7AacgXGRVidD7Ekeq8L9n/QfW0Z9pH
	YNUQcw7kOu1cGS50tN13x/50eSxz0i4yXot02IKerwfvd6guH5aiMQ6KrCwkNAPbuP4jc39msk1
	Vt9DgnQfdCUZBjrbyZXNLSIL/9gvLSEP8E/farK5cFGJkFxwvBM5z6bobPjyzwl7PxE0z00sgXI
	q5aiUeV97ARJRO7Vl/xU=
X-Received: by 2002:a05:6214:624:b0:70e:3e:6304 with SMTP id 6a1803df08f44-739435cc42bmr94853926d6.65.1757425549545;
        Tue, 09 Sep 2025 06:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmp4FTmcXOP7+RMzS1+U7HWsbh9sfiIsI3KOLWl/uwcWgSrIp6/82zb9nfnJx9VJ/Da/CuPA==
X-Received: by 2002:a05:6214:624:b0:70e:3e:6304 with SMTP id 6a1803df08f44-739435cc42bmr94853596d6.65.1757425548985;
        Tue, 09 Sep 2025 06:45:48 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665fcbsm138866926d6.37.2025.09.09.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:45:48 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:45:46 -0400
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
Message-ID: <aMAvinQ4nn38E7tx@x1>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-2-9162470bb9f2@redhat.com>
 <aKX35U4jX55W3W61@vaman>
 <aKYFh5YI9j-MHKH4@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKYFh5YI9j-MHKH4@x1>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Vinod,

On Wed, Aug 20, 2025 at 01:27:35PM -0400, Brian Masney wrote:
> On Wed, Aug 20, 2025 at 09:59:25PM +0530, Vinod Koul wrote:
> > On 10-08-25, 18:45, Brian Masney wrote:
> > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > round_rate() to determine_rate() using the Coccinelle semantic patch
> > > on the cover letter of this series.
> > > 
> > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > ---
> > >  drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > index e51b2d13eab473dddace48c75c2a8d73c8c65635..b0b6497e7eedcb6867541b573d22156ded29a4d5 100644
> > > --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> > > @@ -90,10 +90,10 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
> > >  	usleep_range(80, 100);
> > >  }
> > >  
> > > -static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > > -				    unsigned long *parent_rate)
> > > +static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
> > > +				       struct clk_rate_request *req)
> > >  {
> > > -	return rate;
> > > +	return 0;
> > 
> > This does not sound correct to me? should this not check the requested
> > rate?
> 
> I can't speak as to whether or not this specific driver should have a
> rate check here. I've seen in some other drivers where the specific
> frequencies are managed in firmware, and Linux just passes on the rate
> request as is.
> 
> Some other phy drivers (most notably drivers/gpu/drm/msm/dsi/phy/) only
> makes sure that the requested rate is within a min/max range. Assuming
> I read this driver's set_rate() correctly, it looks like the min/max
> range may be 64-192 MHz. I'm not sure to be honest.
> 
> This change keeps the existing behavior of the driver as it is today,
> and just migrates off an old API.

I'm just checking to see if you have any questions about this series,
and plan to merge it for v6.18. I'm hoping that in v6.19 to remove this
old API from the clk core once all of the other subsystems outside of
drivers/clk/ have been updated.

As I mentioned previously: This change keeps the existing behavior of
the driver as it is today, and just migrates off an old API. I don't
have access to this hardware, or technical details about what should
be here.

Brian


