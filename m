Return-Path: <linux-kernel+bounces-867211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D96C01E54
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4943A3EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E632E74B;
	Thu, 23 Oct 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5PXgpVw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C02797B5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230552; cv=none; b=G42iEIK+f/1nDKAHRpIrypCETkSBnXtDSv59r19Ua+KigtFM0kVZkyuDJpwIdfRfnMD2zX+fraUd6Rf/TlJ5zac0KJO7q+UyHqLte+ymL0kBcP1I/iHw9JLyHDbIiXsQIXSPB5o04Smu8HGwGqUdrRS+L3ISPh7XomQ79qiURN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230552; c=relaxed/simple;
	bh=k7d7L/Nh6fQVgygKQp5+lal2MdQ3vWdFGswzj2ik54Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkokWomBlhdRvHIlHavKyiofkAaO6n43YNH/+4WOeSD1Fpm1RfNMeyKvljX9juH2+aWwCdsx2NSvkfeVTIO+nq2/SCF8CsFZwpyhx65QfFUPTLHuIopzjgF7wh021/tVqQp3MiQLVtKFclRjyEC5eEKelJzAj/XY+IQHcR+/9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5PXgpVw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761230549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFicMu98gfAcT9m3j73eRKJRP9V5+Hez4KBiO4yt0/Q=;
	b=S5PXgpVwbNZoqR+HzzsVzaj4dcI1OoOof+wBM9vz7quhJrYtYBeD19JTZ8jdjJ79XnK78z
	y3tcYJtMRljtpPyj8C4zJ8ClEQUM2BgvBi9kCOfLOTSh28qvwzqbdi5K8OisCN4T0vjXpz
	+l4cXC3yxBYEXexgzpCuATbqCigrUs4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-0nqG7HJ2PleywlSz-GfUKg-1; Thu, 23 Oct 2025 10:42:28 -0400
X-MC-Unique: 0nqG7HJ2PleywlSz-GfUKg-1
X-Mimecast-MFC-AGG-ID: 0nqG7HJ2PleywlSz-GfUKg_1761230547
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1115d604so22401916d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230547; x=1761835347;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFicMu98gfAcT9m3j73eRKJRP9V5+Hez4KBiO4yt0/Q=;
        b=DC3PsGMtRQ4l+5Ok9fs8IzCb0a2qWV/n1rvKlfRLbW6hORNdBISsWqAIT7I9XtfdF6
         /Yuv/2s91FNvGDODUwBTm3l0Cxpbszn3zKguJpeR+yeJQaNgF/rn6V8w/HhVpdBdHcSy
         u6KYvRnYTh1U32M+fWuM7boWQbqNO3FHmlua/VEdJzPwgWeVuZqo01znRa4b5NPbleoW
         41KSl2MrrUMGVbCOzecwInzNdZ9i1amI5UeFPoo8grlfWkDufgEcpcWGIA7f/7XQGwgM
         Bm8Q4m7pDfS8Xi27Jk6yTs1IKJQGMBZN3hy8BkFBXw9Q5OTrnLyo5RRsoqxosuELzrkT
         o3KA==
X-Forwarded-Encrypted: i=1; AJvYcCUTqFz9mCRaobj+tiDLVmrXOM5z5yLIBRzVbce5kIfp9Zd4JmstUgCVXq9Xx74NgZXOVrPKEkpOaoH44fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywugco3V0UVwybdTNamTEY5fjbWzb+6JKq3eY2GrN98d/GEtKPS
	cXvW6/JrPwWDqdqj4SE/tTLhlvI0/SpXrdQHmxIb2IWMyBwuBO3fc7nLYJbE1IvIveM14PwqgRH
	pix5SVNddza47tENtNdgqHOTz9mfFFiatswO/e6d3lkZmlAEwHsmKrR9bHVURYKenqw==
X-Gm-Gg: ASbGncuootpTJVMcg/JOJiXimPAybYlCkilmApMUEPOkM+zc6fi03kwZ4CEFa13j+ae
	NoPh6ZiqoRlFu76oAleL530q76v1xVjbCE+vXeN45lL160iLxy6Y8GVJZslHYYAq+BWry7RSm9L
	4pbrYE57sTDa1mqnb3HlGqR7CLFkIdmILPq1pluw7BBkgAc7USWmF26YiXWptjSeO5pcePhtC/8
	Elf7rf90aE0jnejI8w3L/gyBUHCLctZeNFmdNTOg9EGzi6V5mJNAKUG85b+ITcj8SCa4gcvOaOx
	ETYTxyWtBs81R/TlNY+PTp1yr/bucplxf0yeg/PyWY6i5k/edL7+4/UKBqnjDazPkTaHu/FDQMF
	hOdkfllE7Stf3jqCvrFVcLCkKbTqC01QK2zc85V3K58alhVGK0w8ftFPki5qILm9/Ag==
X-Received: by 2002:a05:6214:5289:b0:797:1a0d:cdd3 with SMTP id 6a1803df08f44-87c2057312dmr353179286d6.19.1761230547695;
        Thu, 23 Oct 2025 07:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHoA7a6YUkbzjRlWZlCvM1CpjEdcBUEk6K50Ddg8gNV5roej8uXfTpBfwhxN8OmaIZYnha0A==
X-Received: by 2002:a05:6214:5289:b0:797:1a0d:cdd3 with SMTP id 6a1803df08f44-87c2057312dmr353178766d6.19.1761230547171;
        Thu, 23 Oct 2025 07:42:27 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e824cc2sm16169526d6.61.2025.10.23.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:42:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:42:23 -0400
From: Brian Masney <bmasney@redhat.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] clk: microchip: mpfs: use regmap for clocks
Message-ID: <aPo-z9QOIqd9kxS7@redhat.com>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-undercook-flatfoot-70dca974cd19@spud>
 <ab443375-524d-4e6c-a640-7e580c2d0c64@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab443375-524d-4e6c-a640-7e580c2d0c64@tuxon.dev>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Oct 23, 2025 at 07:06:01AM +0300, Claudiu Beznea wrote:
> On 10/13/25 20:45, Conor Dooley wrote:
> > +static const struct clk_ops mpfs_clk_cfg_ops = {
> > +	.recalc_rate = mpfs_cfg_clk_recalc_rate,
> > +	.round_rate = mpfs_cfg_clk_round_rate,
> .round_rate is now considered deprecated. Brian (added to cc) tried to
> remove all its users.
> 
> .determine_rate() should be used now.

Thanks for referencing that. I'm still waiting for a few remaining
patches outside of drivers/clk to be merged. Hopefully I'm able to get
these merged for v6.19. Then I'll be able to post the patches to
actually remove round_rate from the clk core for v6.20.

Brian


