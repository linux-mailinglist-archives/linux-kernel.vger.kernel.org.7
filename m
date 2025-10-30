Return-Path: <linux-kernel+bounces-878304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E6C20397
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCC4C4E9F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0F2EBBA1;
	Thu, 30 Oct 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGAySM9w"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565828643C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830629; cv=none; b=ZYQM4GtaKk/itXQQ9T1030Eo3iS6kjxmzUoA/gQSiq6B/jIFYJbA7BoRuqP1UNVyVcMPWQ9YDNamjpx0YurgzInWm2nLwQhBsrJHGZVB/zoMHMyPupSRx/fTIeilFQyumiY4cGMz0hUbvyUddScmL7ijwJJBhe78Lx957NgvGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830629; c=relaxed/simple;
	bh=FgE5WiJ8IHbwreJzl7GefWLHITMyWjRwgsHmbfomSag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+nEfzU7X3edZHO2q89itMyksOvXD8bQM3PwNMTKSv4ePoWoWSaSgDGbMQwl3SyXcDO83BpmCNn7XRgblM8kqRN1H+18LW0N5BCdLMYIHYiJ3QPH3M+VKV2DmAjEcxQSRPGrLXz45UGDJ5eTooW4Xgfi+5RZOmTPYdf6CnINmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGAySM9w; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4eceef055fbso16389581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761830627; x=1762435427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRVxqyYvS81StttYLRvMy97wGwnAqgu36t0qY6Aptgk=;
        b=DGAySM9wxyaxVBLROt+NKA1MM1vXWQse28hMIRVNrfOMLwV01yYIik8rU+zhJiktBV
         3A67I4Y4tED28SeSxMI6s0HvA2hhGI0soDnhUVFM9O/0wCIQ5UrqL0ZwspXBt2c0Diw9
         R5J2uJq05Zl84U4TunfmQHJhjnDctTnRkDFz4WUNEK/K5hpUM8ud/ZzktECVfBxUokpZ
         BbOGV6wse7OXfm2utUCB5uMB8mfatjcmAmPQ0luBmtq0G2K/9HRBu7Pq680g36QNVP7G
         dp1ZN6Yg07rFOp+yMM8uon4o/E796If7CtgpDOsAQeof4IFdfhGgjLU/GJb4hLTmNdzY
         3xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830627; x=1762435427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRVxqyYvS81StttYLRvMy97wGwnAqgu36t0qY6Aptgk=;
        b=ry83K8G6KaCU4nZOx5lKjXIgsnWedfQSWopB2KxX2fLCtMoRPIr+1JgNBv1mc62Q6M
         YjYV+C99a+OvJ2gUiYTgJ1FHiXxPowu/HwvkUscocuQXAnP46XOyhMDViZjgA0OcFEC+
         VyIlgeL8ptmnxQoqaRJgo18+c784UvODEGFvShTVL348EqUYf2X+Sw5/CkMeUNqk72v6
         +WByM2flfJcVqww5ggB+qIpunFEj8obyepN1Bx5PT6hKuS2svR6UPt7qmyFG5Ho8xUkP
         jnP8zedckdqgXJBHiybAcXWXTozN2Ys8i2zP95XGwZ5reb23Pw5EM1N2QxyRIc7T/Z2Q
         zang==
X-Forwarded-Encrypted: i=1; AJvYcCUnOGUGXpaXyb23aaMDFm+zXFvxn/Hn4AT7OLLgZc2E85ucWv7PRKzjkFPW8tsyiJG0BO3skII6de75qGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijhqSwncoBFCRJ8nnVYFmpyhQ+GH6QkCvOpQ8SZDvOwUWdtKE
	kGf3lz8NAtLirsBRP2YE+DhVgMjO+otEt5d/TxkKh4X0dYd9/+F9Wh+6
X-Gm-Gg: ASbGncvP6mFp4dqR91wqPiHMW+ETV4+/DtdAKoeaicTclakXLX0B91umWpo0ZERyItU
	65+MdZLs132ybnAKnhiUhTdn5Nn/8lSIuVj28O/81+KzowAEeOK/Dm0fQvoCfTC++cl2TuQi6BY
	F3KHw0y9zEQB7JZmsZ07dfRu3ldfbEHYN/HZwcBmEZM/obpz9oDSPi5sfwCHozs8e/4HuScoycx
	rljuNbfaCHXnbRPwnkjQGY0ixMwT/jls36wqDvjda/uxbXv2JnlJ5YfqtD9TbeTwHs06PU/Y0N3
	RklZ02mw9DXuv/XfewiXMZsL6Am6ZPUlRU0pQ+f+872ZxclWB5bl0qkq1bLBJdlrfCaqEuJkS8Z
	1myCHqfrq9JHYCbu4lVlLHAmOBj/W6QpGUHI9vzzYDUAB6aFYJYD75s8AJOL5zpS2LGryaOLBGh
	VZ0b52p0hjcMI59LGdEbVFRg==
X-Google-Smtp-Source: AGHT+IFscXJpdlCTxUmH19tcqISM366o7hFmwLuDaT+vypmSgu6IsKCqKIeWKa5nG/GQ0W/P+3pf6Q==
X-Received: by 2002:ac8:5e13:0:b0:4b3:3b2:2b4b with SMTP id d75a77b69052e-4ed15a23867mr72684561cf.0.1761830627001;
        Thu, 30 Oct 2025 06:23:47 -0700 (PDT)
Received: from [10.174.68.124] ([216.11.121.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b96d0sm111387781cf.6.2025.10.30.06.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 06:23:46 -0700 (PDT)
Message-ID: <df04d358-f144-47a8-930f-47ccf7cb105a@gmail.com>
Date: Thu, 30 Oct 2025 09:23:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/chrome: cros_ec_lightbar: Check if ec supports
 suspend commands
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
References: <20251023234239.23882-2-bradynorander@gmail.com>
 <aP7s2ib_nUIZ3X5O@google.com>
Content-Language: en-US
From: Brady Norander <bradynorander@gmail.com>
In-Reply-To: <aP7s2ib_nUIZ3X5O@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 23:54, Tzung-Bi Shih wrote:
> On Thu, Oct 23, 2025 at 07:42:40PM -0400, Brady Norander wrote:
>> @@ -550,7 +557,7 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>>   		return -ENODEV;
>>   
>>   	/* Take control of the lightbar from the EC. */
>> -	lb_manual_suspend_ctrl(ec_dev, 1);
>> +	has_manual_suspend = (lb_manual_suspend_ctrl(ec_dev, 1) >= 0);
> 
> The driver doesn't emit an error if lb_manual_suspend_ctrl() returns an
> error in the first place.  However, I think `has_manual_suspend` should
> only check for -22.  E.g.:
> 
> has_manual_suspend = lb_manual_suspend_ctrl(...) != -EINVAL;

Thanks for the review.
I originally decided to catch all errors to be on the safe side. After 
thinking about it some more, I agree that it should only check for
-EINVAL. Will send a v2.

