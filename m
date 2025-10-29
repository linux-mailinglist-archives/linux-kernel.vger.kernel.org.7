Return-Path: <linux-kernel+bounces-876533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE43C1BBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6E35A6F94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199E3385A9;
	Wed, 29 Oct 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIxRUFcp"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3833F8BC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751964; cv=none; b=noPbN4RJvcGR3LxS15MpKtO6Qm677AV0lXg6pLd+nB9kOXtXiO0q6RcpteON7gD4crcGdjBOjPFWktInxV3r1eQHvAXwpGd82ms2qxjAroSYGzyi0jGaKE/tJuAlkKngTM/X0CTNUdoOXS/kV44Fj7RqWilLdlVRvbB/ulGdMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751964; c=relaxed/simple;
	bh=O5LYngdRuGQGjiLGrPFcUjIUov9snCTAkMU/N8J8a8w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC4jxOrzZa2DDPpvoyHNsqdisPebTEqhqPsg1mfyujUsvaEZruAdTHudDMNayQrxs3ACsZmSUFgEqVQyW04B9g5gS1jez9Rtu4yLTBcceJy1BwUwMk7kzCd/bDL5fYrWk4pk3mvzV+gK9Crq7/HW+8vIWCqhVB7YybZg/CeYVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIxRUFcp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bcb25so4540429f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761751961; x=1762356761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ikPywo67ZbgIof+9yDMrcwmh77/FesmeUjBMpQ4Gfk=;
        b=DIxRUFcpOZNB4MM/bjr7GSvUrFnZhaIXGJHW9FB9dafTlQwuFDpJEr8TKbAOlEMUez
         i8vQaX3yg2MI4UQKBHBAcpRPfr/m5tcEjzCk2GS6K7xbJpQX+yYV7cAVkhfzIVb/vLYK
         vbfE9fdstS23a3pLs1NHkIyb4+4eNDQNG6cymT6Nh7B/1usYxQsHdOyMHK+TfOWNvgLZ
         AyS1KTIFpe/epsDDaGak4KA1jZ13ajAF04BGOWwp2W/aDM6EfxXLYdPsBV008TjIQABi
         ATEZ6WJxQ67ZEv6lJR4PJva8bZ5WsvX+A9c26yhy35KqDZSnQj52KixrvmyxiAMo/iYi
         VLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751961; x=1762356761;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ikPywo67ZbgIof+9yDMrcwmh77/FesmeUjBMpQ4Gfk=;
        b=WTzpsEByYME5GgCztJdxkIUPgkBL6pPZFHh5FvBkAnOH6MhPy7rd/qrpN2y1DEOArX
         Lxb2mUL5fzrUZ8kWxMetdJbRy6mUOn1K2zb/JcgFzFiCYWtQPx7joW1noLNoNfvGb2dE
         S6NEmd4nvtLnDkMZ0gJiEgDc1ZW7HyMolgvY64J79tv2ICLZJbJ3pJm3tqWiiIlTfWar
         4esOlwu6j4f8l0bC3pfyKIUMS3aLMkDhw/n84N8dC4pORiPAEhJeXoBeNAOg3ovQ7FKZ
         Vm4jil/oqT7JqP2+luwOCpVb4Szy1DkrnH4mP63mgxZXG3zzLeXjwc1tQ0hc+ZlBMNVv
         Ldww==
X-Forwarded-Encrypted: i=1; AJvYcCUlLGw4wI2V6QeQJE3UsZ3SmsI8W71LHDU7PAbp3KC5pHD8Can5ccG/E1H+p9HS7r+JrOsHK8wCoJu+v20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lAtyBJdXjlooSAT3AN/sdkJIzGq6ZRj+gNsJkLP3v7KZEfqD
	lTaIx/WPKvithcbmECza6t+a+YSdMb9w5/bMucoOxmRS4aI0+ecyMucO
X-Gm-Gg: ASbGncv7W2f3od1aXqpqFLO7wLjRFUDpmP+OX/gHXg45HXckrqRlGunuuGEsAnZcGo8
	xhHeFFTdJfu3JxlIX5ERhnBdW1VHEp3HEtJQRuI2Ls1COObumsRHK8lCc2/J9oF7lT9X3iaK2fA
	b6d31YR6XXJtw0fDBSCBgkEDJrPXPhClDNK0NNN45x23qJ9SihL23kDqFCt2pzWHi7pf4nBFNoV
	4cQTISE/BzgLi35p0DRDGc4FRQaEtVhGxebBByTurMXF5eem7jkIQnftIgDpjv8l+rnn+GHtb3N
	8R8h8IyJdF9zRjGM4QsSH4hIWhO1hpKES3XsXvoSpfDLs5iafHLgDPg/KlQiimq6q42NJ+bAKTD
	XA14qh8aSveXOb48Y2VXuH4zH7aU70/xX3ePMWQYMxz4rrLMb3mlbvn9NVU2J2FuaewZwYMFC9I
	Gw4lOmNYth/ScpRHxcmxDno1QcEXsB
X-Google-Smtp-Source: AGHT+IGlxJUMPBcCnrjnToorbT55gMyEn0KVla2FyyxiHdY+dzp3Fb5seo1sUo4Wkl5T8gZsMwX+yw==
X-Received: by 2002:a05:6000:22c6:b0:427:72d1:e398 with SMTP id ffacd0b85a97d-429aefde6f1mr2944132f8f.62.1761751960915;
        Wed, 29 Oct 2025 08:32:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm27355108f8f.21.2025.10.29.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:32:40 -0700 (PDT)
Message-ID: <69023398.df0a0220.25fede.8d9c@mx.google.com>
X-Google-Original-Message-ID: <aQIzk1wYEQJgJAdc@Ansuel-XPS.>
Date: Wed, 29 Oct 2025 16:32:35 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: smem: better track SMEM uninitialized
 state
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-2-ansuelsmth@gmail.com>
 <aQIyZfQ-Tvxmh6vL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIyZfQ-Tvxmh6vL@smile.fi.intel.com>

On Wed, Oct 29, 2025 at 05:27:33PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 29, 2025 at 02:33:20PM +0100, Christian Marangi wrote:
> > There is currently a problem where, in the specific case of SMEM not
> > initialized by SBL, any SMEM API wrongly returns PROBE_DEFER
> > communicating wrong info to any user of this API.
> > 
> > A better way to handle this would be to track the SMEM state and return
> > a different kind of error than PROBE_DEFER.
> > 
> > Rework the __smem handle to always init it to the error pointer
> > -EPROBE_DEFER following what is already done by the SMEM API.
> > If we detect that the SBL didn't initialized SMEM, set the __smem handle
> > to the error pointer -ENODEV.
> > Also rework the SMEM API to handle the __smem handle to be an error
> > pointer and return it appropriately.
> 
> ...
> 
> >  	if (le32_to_cpu(header->initialized) != 1 ||
> >  	    le32_to_cpu(header->reserved)) {
> >  		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
> > +		__smem = ERR_PTR(-ENODEV);
> >  		return -EINVAL;
> >  	}
> 
> I find this a bit confusing. Why the error code returned to the upper layer is
> different to the stored one?
>

It's INVAL for probe. But for any user of SMEM it's NODEV as there isn't
an actual SMEM usable.

Totally ok to change the error condition in probe if maybe NODEV is
better suited. I assume there isn't a specific pattern of the correct
error condition in probe.

> ...
> 
> Also, the series of patches should include the cover letter to explain not only
> series background but additionally
> - how it should be applied
> - if it has dependencies
> - etc
> 

Didn't add one they are trivial patch but I can add it if needed... it's
pretty stable code so no dependency or branch target

> 
> 

-- 
	Ansuel

