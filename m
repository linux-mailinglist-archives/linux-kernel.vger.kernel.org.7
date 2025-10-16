Return-Path: <linux-kernel+bounces-856560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD8BE47CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420574F8D12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B932D0CA;
	Thu, 16 Oct 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcJc6Nkg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DA32D0C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631124; cv=none; b=riU1cIzKyp18/UpaD5hjUqDNCTxaUt2YYSmD6M5Xtn5XNz0rkSYWCKW/4sb98QiZik5KU0anZkfwKiERshkQ6HqI0q/MWNSPyjM3BzXv35Md1Uze6zxR/9sYxZeBnPT1kGV74KrM6x3aXZb/n2grPPuH4iGaQajOvKRZ8wztay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631124; c=relaxed/simple;
	bh=bKJ3I/p2e0Vh4IFYAmqyfM7NJoRWxLa5VofXn+LHCDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uig+4D7WXsYdrsBMkW7oL4y/ep1sIxE/JAht9vWB5QLjek3ya20ToykzAsMJ7ysz3sau0HPnMjz5Oos/lPxaIhNa87J/Of2wswalnCrVTSIYJDRsYS46VgZTplkF32/BiwEGBtZpF0hw9s0EGZrUf4BLxjTrmT+ZbnquVdORLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcJc6Nkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
	b=TcJc6NkgkaIaNbc5VIw4/336yBy61vzpKJihqxik6DD1LyElysfG8Yorvc5wRoVlJSjp6v
	k//7p2fW7g6jm6LAy2RGolWROLiQOCNGYHfV2mK9crx9wcHXc4oET/uVl0U/64t8ZfsdZq
	ov7ZVRHxwLVks3TV/pn2b+Cl/Fodyfo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-HH_Wd7wpPzW5RPzT8s4vDw-1; Thu, 16 Oct 2025 12:11:57 -0400
X-MC-Unique: HH_Wd7wpPzW5RPzT8s4vDw-1
X-Mimecast-MFC-AGG-ID: HH_Wd7wpPzW5RPzT8s4vDw_1760631117
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e5b6f1296so29519166d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631116; x=1761235916;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
        b=FK1K5pmFhnyRgszMK0T1BB0hyf8bf4TAdRl8IF13j7MREKB0GWd2DgPejN0+KN2xPj
         IpllyWG9aB4rBQbUf2jRIKCAvl9NRG85rDJT1OSJDnCXKOwsxbaCrWRbGUHFr5Xj6dFC
         uqyg0jsEOJ4oBW0jR5DRiD9sMKLbzuK3/1beoJc2qQpQhYNSYtKDGKSONm2MvrxgpWHW
         ZHmyJv0ZOo0j6ZsmAIMRX/Qn6L7TuHtURIcJ2k6wtcjw0X+uF+riH72/Kfq9q5A0Ndag
         RhWxPWHup6Ww8SR2nZhHFcCjuZABoVcLlqBqVPHfp5FAOTE7kisCWKUwpkWVGwJ7d3Z+
         unBw==
X-Forwarded-Encrypted: i=1; AJvYcCWxC6PCgal7wyJTx/f2jhX1esIFTYK866BB1AOUOABsECmHHPCYN0nBE5Tr4ctqzEyA5JRJUCYoaxQA/dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUA/vmf2C6tmHVEZP9X0nG9ULYBQGqjJxjNjw4JHyX67SsIP9s
	gfNeGODZcD295ShAVZWTzTmR1Q5DMiocIGbjERTBfsXA/QwXJnKWwtL1BkL5FGT4vc4iVnn+63E
	jwgOx1yy+N5VdzjoaPRkWIxBRPLKZBM+pxx+EWrzGkGRXGST5GHosNNjPlCsFZ2t+GxBy4rZcnQ
	==
X-Gm-Gg: ASbGncuDF6ebGPeHulnf2VBmQd5fUWD2RJYvNB1LYtusAKhIYP7yhqSIYJJZkkWa+ye
	qKOY3g15jtJIdVz8KnyME1XyRm0ZocDHC+tnB7E1EXkhEntd6NAwKikf2Pz9tUofUFcMG/KVjsG
	PsKB1Ujwc5XzsY4KLPHP9XyJ/tjoCEitGLy6JKMp8/QXze2IsShJ+JXUthdavFtAgNMJTI8dqOn
	J6vgxFzAomkoEZsqv4IfLcteo0aoYMzQkUCb8pxlASPxqDl3Cu/e3NAiHlPjIhej9uNLxwShR4c
	pD/dJj32Ue6+snwEhveEsZpEmOUG3v23TjABBHxrqgEzj2KTyXVYKbDu7H3gtWlIlt5xkt0zEs1
	bLfm7heeoY4g9ASR9O75IvKlgns3KpkW0pZ/8Vy56NaRNuI8pTZyVqCC683E+YeaxGg==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr9221806d6.55.1760631116553;
        Thu, 16 Oct 2025 09:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3K3iFq5m/T2G5n5k1Ub/AwaYH7OwwIxLCZt5EEaLCKub8NnH0J3P6LhBuV98s17jbVOVRfA==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr9221106d6.55.1760631116071;
        Thu, 16 Oct 2025 09:11:56 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b4608sm42179536d6.58.2025.10.16.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:11:55 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:11:53 -0400
From: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aPEZSY6RC-UVclxN@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Andrew and Iwona,

On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> Hi Brian,
> 
> On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > Hi Iwona, Joel, and Andrew,
> > 
> > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > round_rate() to determine_rate() using the Coccinelle semantic patch
> > > appended to the "under-the-cut" portion of the patch.
> > > 
> > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > 
> > Would it be possible to get this picked up for v6.18? I'd like to remove
> > this API from drivers/clk in v6.19.
> 
> My (strong) preference is that Iwona applies it, but I'll keep an eye
> out for any unusual delays.

This patch wasn't picked up for v6.18. Any chance this can get picked up
now for v6.19?

I'm hoping to get this merged so that we can remove the round_rate() clk
op from the clk core. The clk maintainer (Stephen) mentioned this work
in his last pull to Linus.

https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

Thanks,

Brian


