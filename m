Return-Path: <linux-kernel+bounces-878224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EAC200F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A744E4EC38C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADA32142D;
	Thu, 30 Oct 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/Ei5lNH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86331BC96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827960; cv=none; b=pq99kwZnxxSaDl6GkTU1AT7hNLa678Em9/Ms/sO95HgkU8XKx1iRTAI/OL2CdYjqg1AyBgjViZTf3G7ztTU0n7Tgt7Y1cJjQWIwvvEEf1+c1kGXDWQci1dWtjPB0NzOcym7F2VB62cCRSsOLeUhvxNibLBW+sdhQm2nvubcOVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827960; c=relaxed/simple;
	bh=4Hfgd6pZImaL5bMSnhX1xRi+JePF8OhxSTdcJcG0kc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMGDy1uAnmzWdrzb46OfLpkycCPSrfZIidwJNYP4B9t0OL2REmluPVzFyzxbVIsB6ob29NSN76Av7gcunl/YKnnq0KftkQgx5mbdToLecJMA09XqRREm7/6UIdfKv40SSLn7vIaPjsazoJ01BDK8dN5D0beKOSMsnhbbAVGypQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/Ei5lNH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so8387195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761827957; x=1762432757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SHgl1jXnFM7GEAOvyl3kE/RBKA4OU9aP0eCADEKP2c=;
        b=B/Ei5lNHzGJS4oB2j/W55TyA9tbj0ak6jsFl9UOJJIAc4tewe6O1PJmfyywNLfUyeu
         oYrjCPytjjxyUThoTae+RweIybtYsg6QYzws343fx4bCBAlhGGTgoGlaQpQMUvtznUy6
         pO+TuyHF5JlSsR/XNh1/8MtOxcOT3ZzbubrMyMxwsvJPPkWaQ7VYb4G6KsNuCQHGGiQi
         ARrq40AbCAk2mCaXtY4tSfahnquGKGpds6EOfhe9PBXbspTvv0JPvvu62bmTqY1lcafe
         daKOBKwkZ0hp8NGkdHzGWCZh7PcI9R9aNJAHrbrs8R7QoBIpsJWubgIX1UD3u1ZGqciC
         5sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827957; x=1762432757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SHgl1jXnFM7GEAOvyl3kE/RBKA4OU9aP0eCADEKP2c=;
        b=GeEJP5FBXoATOfAyXPYTJ99NhwpcDDErAXdlSZV5lGIZyEHFzuPDIf0pV08UK33PDt
         RXgQkqHRC8fpd+ecfUVCIZAzqwvc+oxlN7/xmzqNMCOFnqLZZ8TQ1si/PGDg1vTM+6CZ
         E5Kywu/ORRy+BrLW1gG4mnWFE9qYBTe5mM8+XKjOOD829JHVRtHEUQwbqVsYvUBfSK3o
         5u0EiCxNOE0IxGwUCDapt7wX/MWgeADXAlPj9FiT4I4grJJSpDvxkAWfoFlCjA2FAj4X
         F7wVvwmt8Eo414IhjT1eEriHF49ejzbh2x8OrjFhHE9cjpT0CvMk1pT94Gj4grH6A9mz
         EeTg==
X-Forwarded-Encrypted: i=1; AJvYcCXnFLu/kA7850hYR+VqUYw/83XuQQfl72qftxEIsw+vqvnO+bzYsPttk2R/i3GhVIVrKu9GlrEbOzoDu44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSDqcN+ZqSIDhroIaYhzQquzAaa0qEs5TnvA7KOvX5CsLBiiF
	OUWCkMs53ecjyeXVw2XNB60n79clb6AXn9J9StmqQEfjBS2u0fTyQ1AsPDrp67hDHoI=
X-Gm-Gg: ASbGncuGkpWZFQk0bJBKTySq3f0x1ynTcMJXA7JW2Z6YS1w4XZX6lRPDn0wsfR5V0JJ
	6yjkKPifFyfUjvlC3BD/Al3GSxknTmlDlRMxLc0KPLJGDK9m0ArZEQnDs7WgeZvdw7kXEnqPWuo
	kSul02n4wzzYDqmpYtNmcmry67pWfa4iFG7VdafMmngOGJjfDqnmpgrqLxX1MGUjtPl0uOOFEDb
	zBO+TCz0W18yUqxJCpqoQLQ1fyP3sJYnXXcGA0qlwyIS9zlLVHcG7RrSkT3uQPswJcz+cQbYRW5
	Dhh4e1wxVsifmlhqo5vUQ5+91TwEly02Rd+hxKPZaghJss1buB0S7VovQhM7Quyy19wCua847S6
	vb45CkTOtzb4MsNpQSwLlxMUBh+YTisAQZjgpUmvkdrjxRWvtKyADo4KZiz1gbrn38+SZm8BS1d
	sOlZo+ie0G9eDRlrwY
X-Google-Smtp-Source: AGHT+IH67xafVrhHY7veY1ynhOacSgGxfhuwrU8B+4INPnFgff3lwO9MEBwzQ34ecWnkYLaKp+NANg==
X-Received: by 2002:a05:600c:4e88:b0:471:9da:524c with SMTP id 5b1f17b1804b1-4771e177c3cmr58937425e9.12.1761827956891;
        Thu, 30 Oct 2025 05:39:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771844127fsm69563425e9.2.2025.10.30.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:39:16 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:39:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Message-ID: <aQNccP-lHqgygmsu@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
 <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>

On Thu, Oct 30, 2025 at 09:33:39AM +0100, Arnd Bergmann wrote:
> On Thu, Oct 30, 2025, at 08:33, Dan Carpenter wrote:
> > On Wed, Oct 29, 2025 at 08:43:33PM +0100, Arnd Bergmann wrote:
> >> On Wed, Oct 29, 2025, at 18:27, Dan Carpenter wrote:
> >> > Most syscons are accessed via MMMIO and created automatically.  But one
> >> > example of a syscon that isn't is in drivers/soc/samsung/exynos-pmu.c
> >> > where the syscon can only be accessed via the secure partition.  We are
> >> > looking at upstreaming a different driver where the syscon will be
> >> > accessed via SCMI.
> >> >
> >> > Normally, syscons are accessed by doing something like
> >> > syscon_regmap_lookup_by_phandle_args() but that function will
> >> > automatically create an MMIO syscon if one hasn't been registered.  So
> >> > the ordering becomes a problem.  The exynos-pmu.c driver solves this
> >> > but it's a bit awkward and it would be even trickier if there were
> >> > several drivers accessing the same syscon.
> >> 
> >> What would happen on the current exynos platform if we just take away
> >> the 'regs' property? I would hope that we can avoid encoding what
> >> is essentially operating system policy in that driver and instead
> >> just describe it as a device that expects to be implemented by
> >> firmware and doesn't need registers?
> >
> > Exynos solves this because they only have one phandle so when they parse
> > it, that's when then they create the syscon.  If you had multiple drivers
> > accessing the same syscon then that doesn't work.
> 
> I'm not following the logic here.  Do you mean that they avoid the
> issue today by ensuring that the regmap is always probed before
> its only user, or do you mean something else?
> 
> > If we left out the "regs" property it wouldn't be created automatically
> > but syscon_regmap_lookup_by_phandle() will return -EINVAL and probe would
> > fail.  It needs to be -EPROBE_DEFER so the probe tries again after the
> > regmap is registered.  We'd need to add a check like this (untested):
> 
> Right, this is exactly what I had in mind. With a new kernel and old
> dtb, this would not change anything, while an old kernel but new dtb
> would run into a different bug and fail to probe instead of using the
> wrong device. I think both cases are fine.
> 
>      Arnd

Actually, probably the right thing to do is to leave out the "syscon"
compatible.  That's what the drivers/soc/sunxi/sunxi_sram.c driver does.
There is still an ordering issue where the sunxi_sram SoC driver needs
to be probed first or the stmmac driver probe will fail.  There is probably
some kind of way that SoC drivers are always probed earlier?

Beside the exynos driver the only other place that calls
of_syscon_register_regmap() is drivers/soc/renesas/rz-sysc.c but I don't
think that syscon has any users yet.

regards,
dan carpenter

