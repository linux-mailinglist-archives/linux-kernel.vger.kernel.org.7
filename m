Return-Path: <linux-kernel+bounces-868985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B7C06A78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9B23BDB45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E955320CCE;
	Fri, 24 Oct 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAtv9qS2"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2975313554
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315235; cv=none; b=AtcfGbGOBfSy9B4cWu/Q+I+hfVoN+W6wDR18cNlJxe/Di/rwDAFU88A+tR17iB2jTUT6IpguaiuSV8k1NTl4JCQyS0OpMiRFV2Nrr66zUtdw/hlT9c81r4cvPQehecwWYHTHoB1jECnT7xOwvQ/La7kIfGMlpB/N4ksfpXVbR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315235; c=relaxed/simple;
	bh=UMc4DAdZ3wELgwJc3P0/USAY01EMC3U9Jpr3hVyWTuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTCvL+X8KcIrWWv7YYZz2ro6VV8PBFwPaSGle4nu/zY3A6a2x2g7KwajaPC6qalm7krisAPQDKAc6Uc6ezlQZ1jgZ4Qb5maqfxAaHa389reD2fe4iw3FlmwqszU5gO5Mt97sw2NjuZdSe3xdT1Zu0Ik1e81Xql1Gmry/cnQVAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WAtv9qS2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2130542f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761315232; x=1761920032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVsA5NUMk7Er151JpLhnqPMBBeiJc/C7dvaqVJvIrmc=;
        b=WAtv9qS2VqlUdLgPVLqijR1pZv93MK3KFjzNVR0EKkxs8mVCiJYT37dZuOvO+T+8gr
         WNW+MSQxj2gGuRNxxIHieQO75jPqxTT6pHhWr5rblHVwrshRWiXPyUm5Pwyx85uhFcZo
         jMVjJKaA+/T6kuJAC4nXUjvQLfbvt7YzR7HtIysMLIUFHQrlTia9t5E+654boZh4q4W+
         iSK7bb2XdhIHNWInbB4V84kTtX/QbzpNJ3mnha7oK5K/qR/9SN0y8/uD5664YNC+v1pw
         EOrCFtgoiYEDJqRnaKczWGhFWRAIi7UXbombh9ekW3SQ736YI2Lk4mXS2X/9srPqsdW9
         of1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315232; x=1761920032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVsA5NUMk7Er151JpLhnqPMBBeiJc/C7dvaqVJvIrmc=;
        b=shigeF66wdCC01eMUCJbPiDG5bnVlY4gbr0wb3SjBxBPkEz54PAGaWGQFCiWn59qD6
         weZ3QqCgLIUcFs5sqyxdLV9beA9ILy2VhhD6ZA2aGIK5+b9iWW5GZplQ0N+Gxb7ewns5
         xAlGSXJD7yf6MD/neVtYls4U77B7pC1YSlVvadM968Mpd3h0SkttG9kqj9y4eNDT71Y2
         vZadvC/aZ/ZVTySWoG2zxcI4ewlrXtEXzcKdvdX3c/zKj0Q/EGo4SCxRDysXSbyFIxUM
         YybjcY6HmYWmxQi6Q2B6wh21VlyEPupAVKr1/oXvhRsTNxZ9hbemG5Jbf4V7wUSNWH0i
         Ctbw==
X-Forwarded-Encrypted: i=1; AJvYcCWvB4zTz0lJexAj5AQjOITN//ODcuWyFi8mNTpX3XoNtMFMG0U5J/n/643lR4/S53l9Ml2CykKIrBFzVgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKrbwXJLkESWEgX1Amo5TwEoZvRS3vkQ0aa5VGPD9JNbdk23J
	xDwb4HJ/HBqeUH6LaMEsj4iN/4puuO8WFmuSNCkA12rbPO6I8wJb1FViI5ukaQnCNyw=
X-Gm-Gg: ASbGncucZKmbc5p4STQflk/y7+YDDka6VkrjacttX1G6INKyDhzdl7gJ/0dsDkdiAMI
	bY1Oxq+vtgNIoXiqsFDQui6cua0ETpgv5ZAOGt9EAlw0LWcWELZdZ24dFw5fTuCRWpN1wb+X+tU
	jVBzhqta690oO/ucitHVycg43nWPgMjQ4doqU5IQ22O90MRlqWU7+3svcW24IZHk1kQ6CLUsMvg
	lksYeSFmme3ZWsUqZia+L0TIF4E0B191f1ue7oBl8F7UFKBE0AG2oSsHiApPx9lkAFc+QLGdgC9
	exVD6vvjyXfSXoox70unc8H4SR7/BgxdBVGUh3LrNP+9QIHs2xsiFlLbrYu/ol15EmmsdAYsCnj
	d81IQ91xnnZVm1kkluIVKRuz9mMWrj99oecJ7esqaL2b9Zyp+o7L9bXFbENV8eGqCmOKxH0sg1F
	znmoHppQDTIEdfvNvm
X-Google-Smtp-Source: AGHT+IGOwSSq4cPlqfVI2+cQc4DNxAbP8ipcdaug6FB/HIUIzgkN8w1ERIrzCxdii8Zp8hIOBEEMaQ==
X-Received: by 2002:a05:6000:2912:b0:3e8:f67:894f with SMTP id ffacd0b85a97d-4298f582512mr2780216f8f.26.1761315231940;
        Fri, 24 Oct 2025 07:13:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4298b996aaasm7851320f8f.3.2025.10.24.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:13:51 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:13:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Yixun Lan <dlan@gentoo.org>, linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: spacemit: add failure check for
 spacemit_i2s_init_dai()
Message-ID: <aPuJnJIeupM1PV09@stanley.mountain>
References: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>

On Fri, Oct 24, 2025 at 09:11:01PM +0800, Troy Mitchell wrote:
> Add error handling when memory allocation for dai fails in
> spacemit_i2s_init_dai() call.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Dan reported here [1].
> 
> Link: https://lore.kernel.org/all/aPtiNCZ_KBezL2Dr@stanley.mountain/#t [1]

Thanks, Troy

Normally we would say this needs a Fixes tag and the Link: should be a
Closes: tag.  It would be easy to make the argument that the
allocation won't fail in real life so a Fixes tag isn't appropriate.  But
actually it's simpler to add the tag...

regards,
dan carpenter



