Return-Path: <linux-kernel+bounces-849138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10625BCF486
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4A114E959E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF825A341;
	Sat, 11 Oct 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGLMg5bH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2B220F5C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760182339; cv=none; b=UQEB/yHrbVVVulvfsx9LqeY/SSUVdqmLmq0ndccv0n/707jergIG2qzHgMiQUKOSoVAggjA4YWfSaOiXHWYsug3uTrIJYVNC9J3Hc5wnHkVCSbqav0uHYXvdNBhWlsY39/f2ALJwAUTOqfqN7XCKKKh6wZw7gjX3K8Nse0aWSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760182339; c=relaxed/simple;
	bh=ZpdfRoBap7LNXkf5zLdbDNb3gQIfNj+XPTaqjYigr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLRXv/MpBkbgLI51rMZmBPp+PL/fvCsvybmeaEj7Iak0QscllWnaF4mEctCagIH5guQOL5IzAHiGFbMqVWSIB2E6g112VqhCe2oyYI+gW9xeM6g6PecBngtgUqlQCIUFP6A7yrnD5hCAWGqBjsUYYiEPqtXqXeNIpVLFtMAPyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGLMg5bH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1990906f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760182333; x=1760787133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/WhtfIdoyiawysQgDo2chqo5YvMHlXM3yb3ox9uDzOo=;
        b=ZGLMg5bHZxPrHPZfZWcK2S87Z2xCBD0g/VOGQ6mMCp0A6K0yq15Rec1KimnVGKyjeg
         3qMoT+9NaYGra17GIggBdqpNpRsj6iRn/OC647KCo78fxKooNf82ZO28RGlYm0p34g3V
         FiZVLN8MmMRgrc/fUtu6QgoS++yLUks4tnspOWG6XB3o1V5DYeHhDJQ0rh7kem+WEDXS
         ziEMqDncVfKmFOuG8ywTFT+Veoee0XlHIBfB/izdcIVVvyJrU5rPZreB32krjbIn7eZY
         Kb3m4DA5SADsmuCd148TQsy5r4xfJ64/D6AJ1BLH8/KSw5o/onGXTgDpO1S2LF8fa1aF
         Skug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760182333; x=1760787133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WhtfIdoyiawysQgDo2chqo5YvMHlXM3yb3ox9uDzOo=;
        b=ZkxRYUf0wmFC8rlvbaqVKlhsbc6kKen4HR59haaae5r9U7e2xpf6GtdAB3+BYp1Um3
         auy/rHNe4dc0ZnXkLV7tyR1BXGuCAFXMBhI0bw8NGognOD8TY9OzyKnICheI2hLgvoYo
         +VXWKwtIJrjAPuKkQfKTC8IVII+/sa3JgJmkfs1pdfn0+yJ8zBDi5AIgHOIQB0X5V0v+
         7/W2LwX0wYTvZ4mdfWSmddD6GOzErFvIbrKrabxMn3vSrTVXTmQpI9LwEW9dQdUbZnkv
         Q43YWcJxSMc15xRDAMpg/UbQZzpBf07FehDT/CDEAGtpxQXHT6fMh8f169EQg0oGkYkK
         bU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfFWX3dN4Qgku44MKmw240zMaoV9TkWw65HbWQ3rJV1FdynRAxPlU6l4x9AKUW5WaRozXwrziXHoSCt3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODBchRppXRGY3ru6fNNRUIicB1HvgicheZM9QL/ohakHHPENz
	Ww+zhOSmxaRch6yblvAjE9QPQLbzBKqyLHa4USEu2/nlFF4S+0ocMEIK
X-Gm-Gg: ASbGncvN+fefDJ+lqcIRrMQ3c2YrI6Ur4C8UgL1Nd3FT54TIzHbX8XN7UFYPc46KO9N
	mA7sW7kh1ed3Y801EP9tYlL9JvR8TtLkNR95Ke/39SgjYSjsigJf56v2vTuKTsOOzBiVYGUv8ts
	ZYSsTZo8WaZZm+TVPOv4H8SYskCvgNUXxhq3DexyEuS8nRKAgtB14ICiAf1HoSwoXuthydXT4lm
	E8dXH0n8Rp3ZiRTtpbR1oXbCkvAn+ArI4Oa/H18UdaVueKgNmxfU8X78h15udjPrv2GrsJZISeE
	tm78mqzONOquo8abLgZ+Pzijsfxn5U335Qie37+FyFmUuyP98CIYP3iHSmfjTjRKA5n/WS2dUQX
	gJU9tHQ3Zq7xr98WpeGeQsD9IOfjAi/vPM39RfxrERCh+BruanJQ4
X-Google-Smtp-Source: AGHT+IF7DO50xv43OfmrBovVOqHhm6Smo19LkroOnjaPG77MXlD2olVAe7mIm+QWfvK5CGw0ung3Eg==
X-Received: by 2002:a5d:588b:0:b0:425:86c2:7b4a with SMTP id ffacd0b85a97d-4266d0da0a8mr8912169f8f.24.1760182332662;
        Sat, 11 Oct 2025 04:32:12 -0700 (PDT)
Received: from gmail.com ([51.154.250.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582a9csm8676910f8f.12.2025.10.11.04.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 04:32:12 -0700 (PDT)
Date: Sat, 11 Oct 2025 11:32:11 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael =?utf-8?B?QsO8c2No?= <mb@bues.ch>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
Message-ID: <aOpAO7j0Uyo6FPcu@gmail.com>
References: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
 <202510110924.dUQeeRV6-lkp@intel.com>
 <20251011122612.4fa7c97a@barney>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251011122612.4fa7c97a@barney>

On Sat, Oct 11, 2025 at 12:26:12PM +0200, Michael Büsch wrote:
> On Sat, 11 Oct 2025 09:43:54 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Vaibhav,
> > 
> > kernel test robot noticed the following build errors:
> 
> >    drivers/gpio/gpio-bt8xx.c: In function 'bt8xxgpio_suspend':
> > >> drivers/gpio/gpio-bt8xx.c:233:19: error: 'struct bt8xxgpio' has no member named 'saved_outen'  
> >      233 |                 bg->saved_outen = bgread(BT848_GPIO_OUT_EN);
> >          |                   ^~
> 
> 
> It looks like the
> #ifdef CONFIG_PM
> must be removed from struct bt8xxgpio definition.
> 
> -- 
> Michael Büsch
> https://bues.ch/

Hello Michael,

Ah yes, this macro somehow got overlooked by me. I will send a v2.
Thanks for the review!

Regards,
Vaibhav

