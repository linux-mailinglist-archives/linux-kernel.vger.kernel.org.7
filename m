Return-Path: <linux-kernel+bounces-729871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0188B03CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F94A34E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0B24467C;
	Mon, 14 Jul 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N8UfufDt"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA223B63C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490545; cv=none; b=kPjUev0+2qeA8LQNnJ0e2BwnsrAN6yFKkGRDDpEytjUaXMy4B+War826FmkuKWhkN6mrzbTgP2ht8nRMRZd7M5OXMQqApkv9gsMABnrS7fIxEXU52aTZmwIYYLG2LsEgLFPDJUu8owSYVLqtm0LRAUvViT3sfZyn6tMF0q5oAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490545; c=relaxed/simple;
	bh=7cb9WFYUNWjjjQmPmDciRuxuAnrKRgQqbOvIuBlWNwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLCnKqtC9hTC6FMXO6mctMfZIfexXmhPXWrzmuqpIcJEO7PhQz29Iy/rIPhRn+9bvrn8+yWFUyRZJAOPTnFTTuR5T3InTPWdOWPcT0XxtzWJsZKA9XmMgKnUZ34b+upl1capotIaG6YKHNHKicuvuMBO9VGn3QhTPqE0+Qe2lYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N8UfufDt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45611a6a706so6192485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752490542; x=1753095342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgF8yRc8donJJs1fRORS+/MubsokBXuPHpy3GY/uTu0=;
        b=N8UfufDtVlnkde/ma/tnfKjuJPaLFI7XKayFQDJXRQGCcFsyNruezpFjMyth301M2m
         idPuk8/CVuw0mHWY0AaBcBQ1QFzJKi4yRCZfviFLmx8VRgBMjk7jJahrFoqXHegPrMvh
         lhn1F8UsfRMQvhef8iazlXkpi9d8zPZVGZngOKDCCShwNZ/wnFiLJH/CNymlhEWtBgKa
         NNAdvdCiDzlJKDtuf6D/7k/6zlGM3LPTDoRDKlazfJXTCPL/YcOTTVCfsMdmtfS5ho0T
         7wuR97oFzvDbYu1FtlHfvZcadWqf05rQVz7ybShCygDHdtvQpooP4YyukNg4sa+L0Woj
         4t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490542; x=1753095342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgF8yRc8donJJs1fRORS+/MubsokBXuPHpy3GY/uTu0=;
        b=kJoLgbp7hDHYFBTbueEBWGKIyClYqJ+MbZmeq3OaLTNvf7ZvBWtPLjd9UElUa81IUT
         uMKRUNTO8fYF3WTkT5CW1vqPTJK9ccU06kULe+KrueYuMU/Epj1cvDQIrrNe1cUsf/YP
         Hl/QcbkElJ6IcHBan3OQkNfrdYw1JqrCE0LtrCxEwptsxsiS4LFkPRzC4hSO8BNqfI8e
         WQ1TWLZC04/w2PqtbCFx94ireP/5d6Zq2xHMuWoVbrd6MHxRwmMNnoUoFm/6bj3OV3RO
         DSUTY2Ja7pRAAQzJpvCc/QNxE43GZP7B/EhCF0+g1xoQAfxuhWNaij83tXe46iX1ieVO
         K2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWe49RlI+/A/9wrKo2iXo8Wr99erHks+2/ESL38m4w8NbVWGimc0F5f6/O8jefNb8Tfi7FubYEohZnEm5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxazAhAYhzW662zbv7lqNHWF17KkyYYtWA1IiXJadCepfxq46K
	a6bzKOjt004KTnl2uhBUDPS0DJu9DKgSqjBp+Q6IzP3kBR8D/hIlGDuuTX3u8hj1lSA=
X-Gm-Gg: ASbGncva4L0Ca/xPvKBUKsVWrNWLijImy0YLzxr+cwKO8mBP62jZTteQwhiY24C10aB
	SU5KKN8keKaiH0RCvKdEibnLT+1Zk5Z/nXrYixQC1CqgL4Pnxejbah7sYWqLvbnifMUxT7ew7QR
	J9cyZOqs+cNJDIXaNOwbwC2OCxyUIfzTDSN5HGEW4lINPTdIyJnhgjH2hINaNJCYfQQRpBX2WXK
	90AvoB/HuhlQWx+K6TQH1Vis2S0mtEfF6Ce/uM3H+leRm8/IM+yYNMizRxgRZeTovSRc4P5sgUk
	9WNayQ7NM5REz3xIhHBj1nyvF9chRSwjoeMgveuhNDGrWiCLdIOd+JkurHNh3QSkjtjJwV6DT5K
	w2+fW090hfH1RqC0KlLio6H59
X-Google-Smtp-Source: AGHT+IH7P2KUJvmM+7c5vG77bksdjjHB64AZp52LKTxT0JM4aRbHuVqCtO6uw1MsCfy3fWTQ2E+Acw==
X-Received: by 2002:adf:b64a:0:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3b5f18f8742mr10077598f8f.48.1752490541798;
        Mon, 14 Jul 2025 03:55:41 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b32d8sm128834675e9.17.2025.07.14.03.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:55:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:55:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 0/5] dpll: zl3073x: Add misc features
Message-ID: <zel6pmz3ohww2em46yx6ofd63cvb2l3fjeaj2kpw3uxcgba7cs@cgrixeubgnfp>
References: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>

Thu, Jul 10, 2025 at 05:38:43PM +0200, ivecera@redhat.com wrote:
>Add several new features missing in initial submission:
>
>* Embedded sync for both pin types
>* Phase offset reporting for connected input pin
>* Selectable phase offset monitoring (aka all inputs phase monitor)
>* Phase adjustments for both pin types
>* Fractional frequency offset reporting for input pins
>
>Everything was tested on Microchip EVB-LAN9668 EDS2 development board.
>
>Ivan Vecera (5):
>  dpll: zl3073x: Add support to get/set esync on pins
>  dpll: zl3073x: Add support to get phase offset on connected input pin
>  dpll: zl3073x: Implement phase offset monitor feature
>  dpll: zl3073x: Add support to adjust phase
>  dpll: zl3073x: Add support to get fractional frequency offset

dpll-side wise:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

