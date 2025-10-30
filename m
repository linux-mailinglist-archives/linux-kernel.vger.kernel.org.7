Return-Path: <linux-kernel+bounces-877815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F18C1F162
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750634203A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC4339B51;
	Thu, 30 Oct 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMK0oWWO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BED339B3C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814196; cv=none; b=WcDo2W+hg7BryXvrFloTcISry9TS8WNm2Z3gAe33iVp+eCOdqDVJQ3smCq/xYypNLtMbV66qzxboY7rlJKTDiBCosnkI/WScx0fUVwgPjwKT/t3YJ37XCg4PhpIbaypGG8F/Z/wEsXMuYBBj/7UElfI6GtvLtONiLMtn5CkI4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814196; c=relaxed/simple;
	bh=O9ngAMdN0iTdd2CKDUPBhw8xtCsVQMnRHStMJzuytoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2clyO7oGtVg1mKcdqp+tKmKpjc3UFv30/G23KzTPb5rxVCSv2FEthbXE3AlivvpP6nwJiOGIZu3SbVb+OMaSJgsm7aqPgX12Ji2yww1Gy1xlg8rhn9FgFPYe9z18DKBJQUvZh8/R0R0C71ZVEv51/KCEgJh4QkRkqpxAkxIggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMK0oWWO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dae5d473so6014515e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814192; x=1762418992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYu8V4ijzaBLkm1tRJJh4KdGR5evloyxFTS8Kfx70Dc=;
        b=CMK0oWWOdZh4a07RZCx35M4x9dTvs5yfBVPG6eM3XbN7Slg8LzRk3ZnXy8kNiPCty9
         j3pyJZgmxCGBDDLPXqbKROKa8b8Ahk/Ugl0nCGfGKD7EwETnRs+TA8vP6QoqEkHCJ6hu
         Fi8QwoAGMdekKLrkiwd9q6XkDCwj7P0HPsLx2rPwlMVjZ2hngs5CTsxE4msEFRKCLgHL
         7FpWJHBPoaPXBqEuJ3z4/VrkEyxUl6xbzhHuovR4fEGaOc0Num6GrcPyFbvMuTzSCJPa
         SFXhq/Z59VkcYMHuO14jBGsxS7chXxLwrzBlMR08ckbGAUKDTPyldoIZhxlrhiPMz8TU
         lxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814192; x=1762418992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYu8V4ijzaBLkm1tRJJh4KdGR5evloyxFTS8Kfx70Dc=;
        b=kmC4sT1UF202OEAMBBsmuFg6tNIC+j1jqpqfxP33tN9xTFjO1U82ymicN8NUoPuyH9
         aa8+VEy1B8dnq4+xJ3LCNV7nhlqsuKsZvrw124aXZcSEh3AbYRiS9ILro9DDadc9/KX9
         Df0cPmBLmpio2/C4V0IL0ZGFM3bIkraAEmYWzbkS7178Z6ZtXIJ6Gh0BiHtcsCpN+3Pv
         4OWqeYIdNQYfiN6q8qu0Kob3hjROaDQ/jvvz6UdnrXdt9JD8STW9+gi+dQuLJGBtwDXC
         oQnloT7bBLW8ifrI8rRICiVPnsqt6xGwgoc+ZWnLsR0aVQRS3GFGwqvZUGDftAPjv36c
         CE7w==
X-Forwarded-Encrypted: i=1; AJvYcCV5s9dm4OJAGNbyWnLW8UJaG/Cx3aPoXFAuc0TsI9m9xUs96TDXDcRELK8YXo/9/OuYTPWI/QrmG2Yve+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyo0ZZofA4d35j84rqKDETM532xV+A+mJuDdvh83SBATdsnVh
	U+Lwai4ecKttWz0XHo9YjR29P4GTNN8JGnurfbEpJjcRMTnLfWpcVg3DAIg37nf5yIY=
X-Gm-Gg: ASbGncvCklISfSGmGQzD9YmSDLOP1MZBQJZnBfufGD78hgYeQbtC0goz4veWPNZODiN
	pJWN14WeklmOdHQUaqX5rmwtXfns+g7uKr31mgqQLcXyKNEcQ/FcJssTGVbIKnaJqEZyirvUAsd
	CvhJiQddkczpHsy1hdaFADbKBFqFH5ytbJ5HLzIrngOq98NBmq0tboJTZsAJiJldOxN1nUq6mAp
	3toguonHmldNfMkhWunt0znoHLlkpXMg6QDBOP3s+gH0T/vkBrdRN/GHacSazg5L3Nm7XCRiLFQ
	XfLepW8voXPRW5rZMWi6Rru9laH6fV3Nmgk6szw4/zS6ek9IagNYNX0WsqGNGMF4i7ivWKCary2
	BmiZcRm24sJBF8Uet6Ybu6snYKl6i+/1c+To7NHDvu7Y6sVbFV2GSTq41QoqRv0T7Vb/gdkxFvK
	R0I8xFqA==
X-Google-Smtp-Source: AGHT+IG2MfttSdDfp2WgKT04t7ubtuMHZor2LLT/p8YgLwBgQBYgELcrb63n/2vm8P+PHynnkpP+mQ==
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr48670315e9.4.1761814192284;
        Thu, 30 Oct 2025 01:49:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771832f372sm63063835e9.0.2025.10.30.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:49:51 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:49:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Message-ID: <aQMmq4BfsNzAEY78@stanley.mountain>
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

Yes.  That's what I mean.

regards,
dan carpenter


