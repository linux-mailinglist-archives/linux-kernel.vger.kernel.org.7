Return-Path: <linux-kernel+bounces-809767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736CB511CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D2B1B2799A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F5311591;
	Wed, 10 Sep 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtYhyjNZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED32BE7B1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494291; cv=none; b=phhAgpjBNsflNfVQIfTJUPmlytN+o88TtExi0mxTEiJjZz5Vbp0vWxItRNcRmcxPqAAimwCuP0Z4usabvWVJy0Suvov5R2e6s39hYRs6V0BHbB0o4oR1uRZpJf71hIlLamZRnO6PYKSd/CLdq1DjqesW1VtwqqxWCfuaApiU8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494291; c=relaxed/simple;
	bh=h95NZC3WznybIgfLBCXiRz+GeXmO2EyWAb2gpj1pMnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdaQMTkmbAoMxGQHFd009FKd/34XdU//U+G5yRsqJrCYyiwmfLjf/nc+JA1IAj9X1gfr+XrDm/caX75M0yvpfXTz7zuF4tWvMU0fALOLGTwqlNhgi9m9qmBuSLKn1SFH/tSLpWaTePakcGJWLS7zI0xgMhUAKghLXEUsyXAfPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XtYhyjNZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso2526535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757494288; x=1758099088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lt0wF/OWQ/ioKUppX/gc/rE5dxHc5SpfvUdtB02aWUc=;
        b=XtYhyjNZrKe1/EG5mPONxL5+/qct2DtBDHDL4/Y95yfpq+OBx+rvvXRIHKagrK7Kay
         Bz4ZB/tu3NHbcyT9DwZwREQPFzMOc4imfn/qIGTG4yx7fHCiCDN8xF7VXslUbq6FtTml
         ZM+gKYYpC+RgL+gptfQB5Gdt/n+XCc0cF5eGvsE1AHxBeE8UxZZljAHoQAQ00RWqQ2HT
         0OSH69Fq8+HEy3wyqZYLp8JJZ5ZzLi7Rh2Au0bdUBwvGeUyR8vmzWaAJdsiR0h1GDgGZ
         F86KErdlLmZcDIaFLxRDvsqQdCk8fT7OByGWXaTxaENuqFtCRctLEY3az4es2AHTPkj4
         m3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494288; x=1758099088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt0wF/OWQ/ioKUppX/gc/rE5dxHc5SpfvUdtB02aWUc=;
        b=OazwXxiYduTxlXVhGRWo1VWeD2GF7oDsKpJSeZCCWeXwDUjy2Xrnlw191rOnu6Pcqh
         xX0BchCfLZNePb0ZabPxAbq1s7h88CgILgO1fwVPdLnU0qJ+m6ZVcJFR/XjYDZsjOqrn
         BohG+/7HxWRMfDOKaCGloNssv0DFCnOO3Xt99Zes45DeWBQn9za6sRHfzBR3SlBzFrMo
         RYh+biuHcwVKMKD7hkI8BesWjz7h1VNZUkJvZEI/PdjkI/l/b+QbeVBN62hkmP6DieRm
         rceLw4q2zPbInck3y69pkNCHkxz+PsXi0x/vW9DQFFNIemcx7uXs0ZdjCey4cvV1HmMu
         hGEQ==
X-Gm-Message-State: AOJu0Ywnl9NPNjhUpoPVOpTvmFObWUjl8xFO6/wWwDDSGWXMlBerblQp
	GKx+PiOnGGMr01kPeTdyIzEPLAA6sWu/GTvRlVARyt5P7V0CAKXraOVPPhOeCcKxCEQ=
X-Gm-Gg: ASbGncuIBFRWoiW8DeWKQ5qqmWtCdcaSzHAKX3RSOyGcn5NQs5iNEke8n84nIsQA4jB
	s51dEI6lUzxP+D0PMDFTaj36rpUhjAnTev8wkYTapM/Y55qy9KrxhCrAmx8H35gtHyrNFXvPkQI
	869Cc2bQK6awQTgmnnZ763Izh1sD/aaU5TkZlc/YLXDqG7AhoMaFPvQSVvQvzu7onPNMCh9KEQm
	gpaa7ECLsDPOeL4dkmXt1IKHb28lyGi609twipAyLJfwcaj4wX3I8JTy58JakzaKd7H4EKw5M3e
	iZvX+9HOYDyRlRY39HjHLmHsE61uh4aLrjDA31MFWEm+qtUE0PCqIzxNj26M+8zHgJGVBd8RcmN
	K/w3ZuriXJ2WmBhg+FUsTtnhkkJ61GeqRdop6DjRH+CDB6BZxYTgcG5qMPsmVRJG4GdE5Z+Xm/S
	EBFUJ9qEIIwWUc
X-Google-Smtp-Source: AGHT+IEwBU06wbwuvny7FTFNqZSoSNBUMU8mq9jiGtIjWDv7Xv38JXT5khTgI9ZIQNUKOO1v54nJZw==
X-Received: by 2002:a05:6000:2489:b0:3dc:1473:17fb with SMTP id ffacd0b85a97d-3e3051b7eadmr14140663f8f.20.1757494287831;
        Wed, 10 Sep 2025 01:51:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9717:723a:79cf:4f4a? ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e752238967sm5950021f8f.33.2025.09.10.01.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:51:27 -0700 (PDT)
Message-ID: <ba7ef6e7-04b7-480d-8e2f-796528a5f032@linaro.org>
Date: Wed, 10 Sep 2025 10:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about clocksource/drivers/timer-rtl-otto patches
To: markus.stockhausen@gmx.de, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <014201dc221d$8e785900$ab690b00$@gmx.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <014201dc221d$8e785900$ab690b00$@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Markus,

sorry for the delay. ATM I'm fully busy with some critical tasks.

I'll have a look at your series now.

Thanks

   -- Daniel

n 10/09/2025 08:38, markus.stockhausen@gmx.de wrote:
> Hello Daniel, hello Thomas,
> 
> I guess you are very busy with other things and had no time
> to have a look at my timer-rtl-otto patches. At least without
> the first one the driver is buggy and we rely on downstream
> patches.
> 
> In case there is something to fix or the patches must go to
> different recipients/reviewers, please let me know.
> 
> See https://lkml.org/lkml/2025/8/4/239

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

