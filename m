Return-Path: <linux-kernel+bounces-796597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E08B40319
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161C45426B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0E3090D2;
	Tue,  2 Sep 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoPbXiyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273E3090DD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819464; cv=none; b=J7xQWuRPEdOmL61WlOebYJ3y+S0HvaiSOH6QEcrkEavFoerQ77Q0yWUPRBMlETNi1Dq+qpAO4LVakKjqwJcBUw+P1TZgZSQpjjaRyq0TbfOYm2ue6RxpelVCWrmk0y9sJQuMoWI1E7RNZtarq2l0lOixrFna/qxqaM8u0bwSYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819464; c=relaxed/simple;
	bh=OH2KPRJdRKeC88rqgAwfnEjC2ko5FrnD5JbjS71ojBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeMCsuhAte45Yl5pR1A+TWEkN+wqpHfGleLAJ55VWbXl/218zvJY23XirqeUYrXHYfQA/FEu5dqDyE5VDBNQsOboAT+GLz+NdbhJiJ0bGMF+U7WOUIukGtYbLen6U+GOwwV2VaBHm6I5ccpHFf8/nY8teFL+wkiuEn450WQUC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoPbXiyj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYHhdpq3o9OaEYWMGamjRW3AE6EMxkRxl/8TQh1o2g=;
	b=NoPbXiyjYIHH/1Gt5R2GXdL6KdffCW4TqakxWSDMDLXGJ7tkL2aRJFxafcwmprscSW3Ky0
	zW+KnG9qBhrK9Z5RMd+520bF8Ni9K/+nAPO3ajq4Te3pNGc58xAn3iOYFjJvO0i7e9SevQ
	NmIPgCH4hNqxaoHyQDm+/OOUYnVTIoA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-p9YrZLzdPeKISRfYhuBUuA-1; Tue, 02 Sep 2025 09:24:20 -0400
X-MC-Unique: p9YrZLzdPeKISRfYhuBUuA-1
X-Mimecast-MFC-AGG-ID: p9YrZLzdPeKISRfYhuBUuA_1756819459
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dfcc58904so80592996d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819457; x=1757424257;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhYHhdpq3o9OaEYWMGamjRW3AE6EMxkRxl/8TQh1o2g=;
        b=OrQ8r0rUY1cUO3vHKjAKjdNGQFXzByEqhBjYxW8ZK0ce4RPSfslbt4DbiTppoenWBL
         O/3LHGyDbwiZVuw+twwfG2swffq5r8mDHizhjfUqNKFnAT+bOVSa0G8riD9D/pvWQC17
         zcgD6g0nX4Sa7V94P81TC8LxCjGtxznSSgxiTyfOb07SyriFm3ZvJMGjnym8EGj2xEuM
         94kdRq6YIFmt/T4rRLatPx6RxgGDekyMYqbs8VkTBj1fY01bWQ1h3/XQs/3iT3Pgvlg6
         rqCArnFtYd8h51GmWDfadj0forZX1/cEpZosd6h39hTflpQnOqOPhH9/FZpJZS7CNiom
         +uMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pMwG704SHkC65FWas1N+NdiTR6PJ2MS92dUiTg6TVtY9WbtNxGuXzzSX9cbAIukyaFRfZ+ehzexuh0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywY3Ah02ZXKNUpuKCeazMyTsyJcSNnE4e/w7rkiURNwxq7DW7e
	8yoi3iPyRa9+jYuVRJATzCz1nqFIiFb80t5GzhMzKNsR2WaLKsctZ+g4VHB9m5MpM9iGdjdQvQo
	WQe/t0YmC9bw2Lobt6pLvQyOAbiZkdtTVOdkvIjUxAeEXCFkVAne7gxiYeOQRXh7ntg==
X-Gm-Gg: ASbGncvTjSZFsrteUOM9vASENiUiWRQKMxLlxfnVjgiZPmqWyAiBG2ArFz57LM9CemP
	lUPNWKtpGbr5mAoiyx/t219aOBZq9VS1RGYTYZxi0FSBAeEM2rYl40Pe/b2OqkQVDSO8gLDVPPX
	Ro1DZIl1q4WYuwuGadxFqlc40NdJQfOiB+i+8hJncRPR4mBl04YNTCJEgjDN4L5gozKJ2vMPAkl
	MGsqZrF3zgUP3oPcf1D2vD7hjwaYJdgkh/ttDy3ycTtCpgcr+JapP3tS73BfvoFC3msFJVUjK6c
	amUvMmdD21t06hMLcgvfM9rhFyK2QUcigo1+CFT6xKTcofGJDv3QO5oitRs=
X-Received: by 2002:ad4:5bcb:0:b0:71f:238c:1495 with SMTP id 6a1803df08f44-71f238c1812mr45372486d6.12.1756819456915;
        Tue, 02 Sep 2025 06:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2gpj5sDjHqMalc6nLErCXydSa307HuH4gEcNe0djbjrEuBMYzkPHUoJgDAmOWEyhdUzjogg==
X-Received: by 2002:ad4:5bcb:0:b0:71f:238c:1495 with SMTP id 6a1803df08f44-71f238c1812mr45371836d6.12.1756819456245;
        Tue, 02 Sep 2025 06:24:16 -0700 (PDT)
Received: from x1 ([2600:382:7727:a6e4:b49a:a295:b546:7faf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720acdff0dbsm11654266d6.18.2025.09.02.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:24:15 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:24:12 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: claudiu beznea <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
	sboyd@kernel.org, geert+renesas@glider.be, linux@armlinux.org.uk,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 0/2] clk: renesas: rzg2l: Disable unused clocks after
 resume
Message-ID: <aLbv_FmJV8xV8hpR@x1>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
 <aKyX4YJswZLuqA6Y@x1>
 <0d71269f-1c78-4732-8235-5640bf340d00@tuxon.dev>
 <aK2gE0CysSWisFwB@x1>
 <CAMuHMdXNnGg0rEcM1hvvjBUJXFFAx4oiX=qVb3nKfmd4YBxhGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXNnGg0rEcM1hvvjBUJXFFAx4oiX=qVb3nKfmd4YBxhGw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Geert,

On Mon, Sep 01, 2025 at 11:46:34AM +0200, Geert Uytterhoeven wrote:
> On Tue, 26 Aug 2025 at 13:52, Brian Masney <bmasney@redhat.com> wrote:
> > On Tue, Aug 26, 2025 at 02:01:56PM +0300, claudiu beznea wrote:
> > > On 8/25/25 20:05, Brian Masney wrote:
> > > > On Thu, Aug 21, 2025 at 11:03:30AM +0300, Claudiu wrote:
> > > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > This series disables clocks that remain unused after resume.
> > > > > This is necessary when the resume process is done with the help of the
> > > > > bootloader, as the bootloader enables various clocks when returning from
> > > > > resume.
> > > > >
> > > > > On the RZ/G3S SoC (where this series was tested), the bootloader enables
> > > > > the SDHI clocks (for all SDHI modules, of which 2 are used by Linux and
> > > > > 1 is unused) and the clocks for a serial IP (unused by Linux).
> > > > >
> > > > > Testing was done on the RZ/G3S SMARC Carrier II board.
> > > >
> > > > Do you think that other boards would also benefit from this change? If
> > > > so, what do you think about putting the call to register_pm_notifier()
> > > > inside an __init block in clk.c so that this same change doesn't have to
> > > > be implemented across various clk drivers?
> > >
> > > Yes, that was my other approach I was thinking about. I wanted to see how
> > > other people consider this version.
> > >
> > > > Alternatively, if this is board specific, could this be fixed in the
> > > > boot loader so that the clock that's not used by Linus is properly shut
> > > > down on resume?
> > >
> > > As a result of your request I did some more investigations on my side, I can
> > > say that, yes, in theory that could be also handled by bootloader.
> > >
> > > I can drop this and try to do it in bootloader, if any. Please let me know
> > > if you still consider this (or the variant that implements it in a generic
> > > way) necessary.
> >
> > Personally I would go the route of fixing this in the bootloader for
> > this particular platform.
> >
> > If this issue affects other platforms, particularly across multiple
> > SoC vendors, then I think it would be worthwhile to have a discussion
> > about adding this functionality to the clk core.
> 
> How would the bootloader know which clocks are not used by Linux?
> And why to offload this to the bootloader for resume, but not for boot?

If the bootloader is involved with resume, then I assume that it's also
involved with suspend as well? If so, could the boot loader save the
state of the 3 clocks on suspend, and set them back to that same state
on resume?

How widespread is this issue? Does it just affect this board, or is it
common across other boards?

There are some longstanding issues with clk_disable_unused that Stephen
talked about at Linux Plumbers almost two years ago [1]. We'll have to
wait to hear back from him, however I suspect he may be reluctant to
expand the scope of clk_disable_unused even further given the existing
issues.

[1] https://www.youtube.com/watch?v=tXYzM8yLIQA

Brian


