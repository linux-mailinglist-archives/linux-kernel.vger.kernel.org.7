Return-Path: <linux-kernel+bounces-794229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB58B3DEA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C3162B25
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22730BF79;
	Mon,  1 Sep 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3GoD57z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FD30AD00
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719251; cv=none; b=LOinXKBqJXI9mX4YUhM90YAnjPe6yiRVTIYVApSz0rC0HTp6dWfSuco/yEOThkgX7fQyZRmPHd7+Db6emwi9Dgs8QJNvOg7EnQEvBcWf5zAoLGk/ddiBkIW6bjbo3B4ZD8rSgOum3+dTdw03gbyVHO6BIgxWoiiVkQQuULWzRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719251; c=relaxed/simple;
	bh=GuDLxhxkpxUrJF0zaAYoCSBFOVzvpSqpOZRoh7Feu5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=irRfte5wdcjGHMxNWOorZ80YpEh5iwFPReWuYkmJHMG2JH10sUcGZ3vdAgDxuyTlah54t48ISTJkjiSJQTLb/YKoZ9E+aPLnd1PlJBwpBCYAdDX7FNWM7J9QbQ8UKl00gYR0rlSvZmUedEGPW+Jhiua4S200rpEQWh94/lpaHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3GoD57z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so9850145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756719247; x=1757324047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yK7qoa0SBXqccrleO0ZiLm7b34YGW1LnytieNZ12nU=;
        b=X3GoD57zboSXhysbQ4WLRXld9DZN0bhTWZ1iN735FGUV1tTvUyqX5gJMzvj+yPRQ8b
         dKxYCHYtREG11SiAGao9DyRzIqoS+whvhtZvWqGDsC6BM2sj8Az3UUrr1uZqodEgHjdN
         T6dvIz8Xf3cT7YW3HQidSdbRNw94Q4QZYizlLSSNHCjrlazGC9GSbTA4ShDT0Mt0NL48
         Yad97wfSTMsqLqbQ0c4BJmLfUIaMswbPkqD/p1+0ey+Xfy2aIm8fO8/K9IXfkiDvFgLp
         ep1GKhfZfD2pweWPGWiQ27DXhuv4u76Rc2ePNwryJKfQurzQ29+HZD0DVeCNJx3r/LS7
         MaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719247; x=1757324047;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yK7qoa0SBXqccrleO0ZiLm7b34YGW1LnytieNZ12nU=;
        b=WAu6U3atFVxLpmTDixxHB0QeWyqRCh4TWHryUOqvu83Kyc6j8HAjewh/4l/pdEAb3D
         cGjVrR3tVPPnAu7O3ISbKfl27a2xABodyLi01aazlMkDYHTMnIhqK0pteGH2LMS2gi5O
         LBs7S3+XmtFCIU4gTs8A67j9PSwBIpCz6XSOC/9n1n87DxVm/rZ03IzM8qgNVGjuNo4U
         lkOSDnihxpr1D4qKJ3tsdroPlMvjmyJuSEL9B5GfZki11qEC9QpxHQ4KFYpcyXZebHoS
         nA2WmpI8KRjbsqjxahMeOLS8rRgT7SMkY0dFuKqgvrR0biRxD2qsicrBYIby0PNdkS54
         mZKw==
X-Forwarded-Encrypted: i=1; AJvYcCXpHg6xjQhu9IkcvB8MnUNegSRkv7hXOzTLRJsbdg7m1iDp5Yn7II2IiUU+rI/CIpAsQF3bA+Ir2y9a6Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNoNxbAl9HTOx3Qv7YKp8jypCHjIuqtwjP1j7IHoCBYt/PTGIO
	8MwhV2//OFnKxZGWve2ubd03xTQzJPaMRPgxwh2zzqHg4toM+smt2qzY1bAtJz1Mtt4=
X-Gm-Gg: ASbGncuU7cEBV94N9ppofJYvwl1Zqo0J1sF/CNW4vSsWb4o07IRrVEaE3bvwoC23Ner
	FD4coypMUfA5RUFCfdQVW36i1spZNcUBUMSmV048+WxqC6oEYBJsP7u09Gf4/F5obAwKB6PHgvP
	f+t9b4KP5QJFrstEmBHeZiXDA9xd/Ilojsy13JpMKNecxTv5AVHJaImhUVEebm6+Iev0Z0RD93N
	bEqwM+gBZfAAd7JXDADfbzD6vYYmXkfkTa+SHxxwNdFrGp1s8OWoJfnM5d5eeCUyVbNlcBkQ9/8
	AC4m84sTlAQlk4l4ifJ3Xh2Ic5+DvMZvu48co24c7OBcy5N9Wj7FElikqnvl6i5ArwzGoOd99tq
	SFuK0Ao4IVbvVeUWO4Tp5DJYiDfxD0IjFdVVL1+ubb6c=
X-Google-Smtp-Source: AGHT+IFMdrsS+cI/EkOu1sec3q2m/EBe3g4qDLbZmrgtH+8JAW+UKFNhDhaZyh3huGcLSAsClTBY8w==
X-Received: by 2002:a05:600c:3111:b0:45b:8c5e:5f8 with SMTP id 5b1f17b1804b1-45b8f43c876mr10235375e9.28.1756719247418;
        Mon, 01 Sep 2025 02:34:07 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fbb3ccsm14628150f8f.51.2025.09.01.02.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:34:07 -0700 (PDT)
Message-ID: <919b4262-37aa-4cde-a2dd-ebdf553178f4@suse.com>
Date: Mon, 1 Sep 2025 11:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] module: separate vermagic and livepatch checks
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-5-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-5-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Rename check_modinfo() to check_modinfo_vermagic() to clarify it only
> checks vermagic compatibility.
> 
> Move livepatch check to happen after vermagic check in early_mod_check(),
> creating proper separation of concerns.
> No functional changes, just clearer code organization.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

