Return-Path: <linux-kernel+bounces-819135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEFB59BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB5E3AC47D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8CD3375B5;
	Tue, 16 Sep 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZsVVx8N"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366B313267
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036148; cv=none; b=sPQLySpU6NOKrkn8N8sv1khL1vEON3PIdNzq5MZFFuhzFWvs4U1mYxwH6SVuasItEVOEAVj10c9ojIZ4ZkfCx4WgNNTxNWM2ANvMmyBrDcr50miCq2nCmUDUyrfwDaMzVVgYSjaJ9ucfEodomOKp3tsdvPsGpBniMrTGNO19ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036148; c=relaxed/simple;
	bh=/nF0wezrX8HC8RMqyG0TPBedh2UdBlIuZpHXidTvNEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAVJP2lfRD2aaWlTBYUsF1ZMDl4FF3XNn9VVFS7yerEHBY3dJvQVUO3zFGj4eaw3gCiVL/XMDrHbCPxuc8W4p2JdC5460qAzrwOKW47xOT2+bZtMc5D+IroveDqfo9QAiqEu+Hsm4pcQ+iqeMtSQ+gitCLktPpF9bJvGh/j6jEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZsVVx8N; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fe46572so59973587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036146; x=1758640946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+hqoJDq2BiqHsGbYM9yfS1OJ2MwVQ9DaOjGAY9kFSg=;
        b=gZsVVx8NIrUct+1P6pQhxMVaRXhq/3yWrNvjWQ0xXKaNhXHjpqgS39vl2mgx1G123E
         K1v3dx5tDlvJol7U6WOM/YxPb+kdY/MMCSxfTBRSPnmg01wrOIkaWpkCuYFmo5y4ZGVz
         9mK6SKtr9peQgfIYRmpjZZUu3oOsoooe7n6uHYnhdXi7+9j99HecqYiLxv22LxOdPHqR
         AC8KaY/x+X+sz0ASvrhs/dtCO/G4blZprszP6vcI5s1Hj8eOcKyXAHC46FSv602Hpj0P
         VNf1oaLBFJd0Sju2yQ3lFdD6jC5u2n+5aurL4oVYs48MO1TH489Q6Gpy4cjOxCwNuUep
         hLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036146; x=1758640946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+hqoJDq2BiqHsGbYM9yfS1OJ2MwVQ9DaOjGAY9kFSg=;
        b=sFv1R8bLVlTR8kfKon/8AhFJBIvi3xYQvZqVJRPu51Z4D+/K1Qnigm46BZj0i+PdXy
         3swwiHycv67VFlkXGWlvkWgq2krFSAtGE5t9Il+R1zfzwitswHifQ0BrDjpER6DMi9uc
         1MhfjDW/3tSByJctVsxjk2y/KxL4tNTRwbdfKHRJU2NINIxtdUNlv3vP6pRKwm0ak1yb
         g2/nMm3naiABHfu8tkEFC9XGST3b/xdnHDHJqGgemIyJwc1VFq1B0yQL4hYmmqe9V0Er
         s99FzhqVcRjI0W09DjCKgo7bG5lFxhQArSHUllbQyrZHw/6jbpJOgpMV714Q4ZYRu9c1
         3GaA==
X-Forwarded-Encrypted: i=1; AJvYcCUd9iVo+DIu26SzKKF0XkKi+VlUGWhHISRMtcNMKubevuE7UarUXryMUWuM879SbyhYqBR172gMuyq55kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEiWjkr92PwZNAzI+lrNgY/HouD1kd5gaKChmmtZoGi6E3eQSV
	DN4A0B1LuW7/8kExXtKzbj5p1/PMIyyGJ9wEDfD1lknOSRRhLDEwb1ef
X-Gm-Gg: ASbGncvd+uiBF7kAWe8VlbGIvNIaccqUQDOo/+fWKzs94w0kocZgncmvXF4IsZod605
	9bPEvFJN/WKMg/3hqYKPaediBm0b/fWQS7joa8HkIj2hlLqik1Kf0DZaRbnpD0ZWG9qKKc/N3dz
	C0AKEiF/GQz8p05f/lNfrGWQ2wvWVneGDRqVMCBiMubqFClnZvtrYqxq4rQ0Vccffe9nHMQfEE9
	CFgnMyTBwK3BsA6/E6vTjDaubdNoO+OYl2oZ37cyh5r8HbDTndALUE8Q+yq2LrAabbxhys1xD9Z
	9R5skjzfqWrMQXHF4iAIlAXH6+67TYNA67j6jnzGjOeo0FpnrKRCsaSus3l6wK6TWwg1HLsDgZs
	ZLc+PXCd0OOQr1yx2LPE9xBo4B+nWNUD9ZbS0s26agVpHwAvLjClx7fJ/Bg==
X-Google-Smtp-Source: AGHT+IGEQKbP+B42Bg/27Wc17/GObfW61wqyEbvLsQiwRRh94WgAv42a8XeuGZEAMbaGhW4UkoCMiw==
X-Received: by 2002:a05:690c:7203:b0:735:7d28:8ab6 with SMTP id 00721157ae682-73721985290mr23298597b3.27.1758036145766;
        Tue, 16 Sep 2025 08:22:25 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238392sm41603507b3.1.2025.09.16.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:22:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:22:21 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:
Message-ID: <aMmArVuPadJhn4c-@yury>
References: <20250915195231.403865-1-yury.norov@gmail.com>
 <20250916144813.GG224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916144813.GG224143@horms.kernel.org>

On Tue, Sep 16, 2025 at 03:48:13PM +0100, Simon Horman wrote:
> On Mon, Sep 15, 2025 at 03:52:31PM -0400, Yury Norov (NVIDIA) wrote:
> > Subject: [PATCH net-next v2] net: renesas: rswitch: simplify rswitch_stop()
> > 
> > rswitch_stop() opencodes for_each_set_bit().
> > 
> > CC: Simon Horman <horms@kernel.org>
> > Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> > v1: https://lore.kernel.org/all/20250913181345.204344-1-yury.norov@gmail.com/
> > v2: Rebase on top of net-next/main
> > 
> >  drivers/net/ethernet/renesas/rswitch_main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Hi Yury,
> 
> I see this marked as Changes Requested in Patchwork.
> But no response on the netdev ML. So I'll provide one.
> 
> Unfortunately it seems that the posting is slightly mangled,

Yeah, bad luck.

> there was no Subject in the header (or an empty one), and what
> was supposed to be the Subject ended up at the top of the body.
> 
> I'm wondering if you could repost with that addressed,
> being sure to observe the 24h delay between postings.

Sure, will do shortly.

