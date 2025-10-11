Return-Path: <linux-kernel+bounces-849172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE3BCF566
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883D6189E9DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C0265609;
	Sat, 11 Oct 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3jiQNDw"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C317D2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186263; cv=none; b=JfdbyncwnVm4jg6+toZKqJIWK6TlvGEl2Vye9OCWCspk6lORPOcYNJWbNpp3OiYEhiicaIFSoVGH7XiNv7xAD5twTjNwl6X3hnqqSlQZWkl29SiwKpezMc2H88QF2EJs413RfkaP4VBjCKpN4kFVQ946MebhjILIU3ZLM3YZK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186263; c=relaxed/simple;
	bh=FMiY4ZQUUOd4P9ieRmAGobDcQ34k1Ch4+rby9oBwooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrTTkhAUg2sXfjr4JvnEyWpbuSi0cyisXaRmLnmGOFtKaRIp9Py0HCw+LpjtwbImwTHFHYfAcoDYg2mG59t59Lv+cso59/rBCF0v4kbtzntq2AvqvZdDRvTKWkqWsgvRRt2I/M935uMtMYtJytfz8g/eQYCosmXDc6+XFT62fNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3jiQNDw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso2441175f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760186256; x=1760791056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5qg8csjW/Bsuq+K2XEr/yyiuErSXJ4xPd831KWzAqpw=;
        b=A3jiQNDwWo5H9XdzLicEMRo1kvIxX6jBGTXL7JOhpCOgdRamoFUbY11g9a4muKldQk
         Rs4fBKWNfaVo/SfO7IGbtJ4UvMeAr6V9t4vqETexDVofavQfi5RpKrtS7QN+gcyONKVk
         lFIWk1Js6N3Ym8lOzZEJrhinfJ/yslzO0/BsyGZlYV25bMEOJJ4mpjgoWXWM60VwnJfL
         qM53FeHaq6zZzfY4fQwY0B7ZoPYOEh0McvB79ogJEfVAiMY5KOno4+aMp410lKes0X/L
         gDjR0SEp0AvoiIEfuU17msMAkWwTnfxZXsyxBA3ArQYO6+FdrU008sRTakMJzGMzzA/t
         u4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760186256; x=1760791056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qg8csjW/Bsuq+K2XEr/yyiuErSXJ4xPd831KWzAqpw=;
        b=UeOOQA7iauzGRDeFjceBucpZ6WRDRSl4hWUTpYQDZSRYZbXnyBd/Z6Ru40ZUXF6skk
         Oiv16JRPaFugsWACcqYwt810B9A32VDb3pFPptjLXvIzyN0jwtlj7H0X4Yms93ac8TIJ
         lxLmmP5OD8yYWA+sJfgUPFGksRASue8zu3h6QV95AZ390y91bQo8IOKs6nf0vr8+XvDV
         83KFXbI7CwT92q/gUfLFihNG0rGSC3ws43y6/qFzc3KrEiqi8CLw9Cd0SM98X9unodJu
         K2yo0ek3ZWaw4/wodoEl3E96GYzGWejAGo5IVkUq3IQKrJVuFkmap6v+Je0lqdTktb0z
         ymEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqSXHmqa7mfpCTQ+idaX5KQV/h6K9CNscEruZBBG1qdRbceionOJkxhEBKtLlil5Klx7JemEHeXgRUZWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7DpaozFwjFpZv3K25viabKLPPO9vV70ZaBFlJ4SpuZKOIzSB
	EF+Dwfd67HJAWpqkE5jOOm1QusXxqse91y2sjhe2hLt3Zx26wb70xljN
X-Gm-Gg: ASbGncvWr3GQggieE7wFocpYKvi/eMbpiTnDV4K/NvvFN5wW492NQ32glfiff0JDKLZ
	KtSv1G+U7iw4qSrodDeubejF8ew9QqVyrRnbYmI7Hfo39FU1FcE5a5tkhcyXUxEZNSGRTJ+DaQk
	+k2eYuxKB+09JVhJ4kBI2Hevvt8VyVj4pgQcBFZx5PRAm4kIqmawZgZ4UlHAESinv1dVgWYS52w
	/7Ce3LAfQi1QtiDTdnl6t6cWe1QziIBK/oIQXSpkFWodEEv/rcO6f6hm+2mGu2/8hE2unDpo5la
	EUOY1EML5/VpkOMFHsuEehWflVZWXwKFY53z7sAmzplttrJ//cYnlXZUEEkz/Vvq25U0Shc3WgB
	cH92ljl4O+aD3eAtQVDxKdUlCsfnhdmsUrNwXaexLFaA=
X-Google-Smtp-Source: AGHT+IF+rcib9YhfwxDNHT2wDPbjArqhOMk8C1S9qvSwF+nEblZewag0fFJaLComFOM1/qCquehFqg==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id ffacd0b85a97d-425829a5a12mr13673922f8f.3.1760186256441;
        Sat, 11 Oct 2025 05:37:36 -0700 (PDT)
Received: from gmail.com ([51.154.249.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm8795159f8f.37.2025.10.11.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:37:36 -0700 (PDT)
Date: Sat, 11 Oct 2025 12:37:35 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael =?utf-8?B?QsO8c2No?= <mb@bues.ch>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
Message-ID: <aOpPj86wEmtpIQQ_@gmail.com>
References: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
 <202510110924.dUQeeRV6-lkp@intel.com>
 <20251011122612.4fa7c97a@barney>
 <aOpAO7j0Uyo6FPcu@gmail.com>
 <20251011143123.094043ed@barney>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251011143123.094043ed@barney>

On Sat, Oct 11, 2025 at 02:31:23PM +0200, Michael Büsch wrote:
> On Sat, 11 Oct 2025 11:32:11 +0000
> Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> 
> > > It looks like the
> > > #ifdef CONFIG_PM
> > > must be removed from struct bt8xxgpio definition.
> > Ah yes, this macro somehow got overlooked by me. I will send a v2.
> > Thanks for the review!
> 
> 
> Also, the SIMPLE_DEV_PM_OPS macro seems to be deprecated in favour of DEFINE_SIMPLE_DEV_PM_OPS.
Okay I will have a look to it. Ingonre v2 in this case.
> 
> And please do a compile test when submitting v2. Thanks :)
Sure! I created another config file to disable CONFIG_PM just to make sure
during compile test.

Regards,
Vaibhav
> 
> -- 
> Michael Büsch
> https://bues.ch/



