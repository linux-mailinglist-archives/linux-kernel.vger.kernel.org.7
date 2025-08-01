Return-Path: <linux-kernel+bounces-753714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D53B186CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588211C839F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4628C84A;
	Fri,  1 Aug 2025 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOBkt2Mc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298E27A931
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069931; cv=none; b=Makk/+dvDhlqCvbTU3Tvu36nvX0Se5JP5Ivve1JYekw0zxc+UoYoeMLXQPVx2e7tUDwhM/hH4Rkb8wIWzH9M8T9/BeT2IkMck6iItn6G8EnJWvWJjHKFujVa2rqWsLs3QFZ4sSZmoFd2XpZEpzWDyzF6Qu/fgdaGtrJ6JG3afno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069931; c=relaxed/simple;
	bh=aQYBObWgzoPj+il0GZKSY+WiA7phu3h4hRG7IyoJstM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa+saGX5M1uwQuSDBo47TmfGE3P2mJ3YiQ0veeQoPVJhnPnLMUTYmNuRhWtTGBIvE9BaI3LYzkdasJJjDSswJ9IPVfhGeaJvnajHFNhFhd1WnylWs/byPOldl9bl3dKl1j3XZNMbnF1pF9Oc6yg9HLeWtvgLJyB/sU6ajm2JAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOBkt2Mc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45617887276so7307175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754069927; x=1754674727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR778IDq2awUud7Ws1UQmVLj5RKdygQyf3jIFUrFC9w=;
        b=cOBkt2McV/03IDW9+r4hKBtcHGpg7/f9aR+Td/bQ15YmXGLK2X0B7wWJMRWx+gcXSy
         hUIu1olZvX/KgamkBdk2Ld1r1Js5yJnpvUeiC5FymPy9BE4KtBegaMOZqQcv//6EApQQ
         V/SirSArym273C/r09UcuK2XSUGS14+dq2OI22ZEb2iD4w/l7bDA96w/Aq7sHcmoy+rG
         dM/c5TBwaAA1Xg5dOnylHlxveDUJiiGG1v6k5LUKfz8P8RyRr9iN7L/ENWHWTztwwOTY
         GMqC86Bg8ZWUYjDy8F25xJSXmdTdFUypQzjZ0Rcho5bzaiRnoQ1C0dKV9mLbxZ8czXhS
         MPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069927; x=1754674727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR778IDq2awUud7Ws1UQmVLj5RKdygQyf3jIFUrFC9w=;
        b=swyFhGikIuf/z9OjQ4Dclt/HidoX5JYa+MYgNz+uRuBFkoAA728N6hOAQ+XB13E9QK
         h5hB5Oze5DIljIvERmJSSmRHrMDJrmIDerye98uU9g1Qj4AypmA4lmVDB9n7IkJBe5QQ
         cCJuhYbzhsmIMZloz6yH/Bwr8Od4cTCSVcbGC5oEffU8tp/bjWD64VHYdTeC0P5f5Ytt
         D3nN5oXB7afDvhzXO1LbgxXNuyMbEHpqkRZW42NEe0CpONHrZ72l5XWRA5Yz76xA01F9
         NYokSF+dLxbgMCCLv2iHr6jhLnHeDfmj7hW6Whuqp2p8oofSM3KPPi3iMJ+UTVbJVQ+w
         9Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCWBvySACOWgF7JawAKraPid7hn7eTd58KN6h4M0NqSGif+1FbG3sPTztYp9FWdhCnbqae7gO8OtMvTTVW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsK9FD0acR66QziiWk9UkJjNBjpfTAItdorbwj/uLn3VLdNad
	CiRBg/vmP/e51AMtPUV14dS962HKYLaOAOHvSHT3aRI43XHsN8i8oVL8xTgv8TK9Kic=
X-Gm-Gg: ASbGnctKRV8z3Vu2PRMfEllK1Jvdzxt1hez7lvUGHj6VHZcUVgHy2zNPpKOJkGzCGNj
	zjyDuU6FtygAvOY4iQzCKcEidDCY8XWOb4OvGcupH5GXvFHOqa7kxok2EZBDJZwvJy3SBhq53pm
	lcVd5wFihpU8m+j+5qHBBvhSIT8+vPa5nS0vrfBRmET4GU4EaP+IME0fjF5itpMMx1HzDZ8c2g5
	yMmI9XyDoTQxxK6aOO+ZzEOq5AvSXFxvzycLFq6eEWc7fRHUflZLs7oocynNdhhWC7fcFFZfQgK
	/31pL6EJwiSYMHsfgb+AHx53WarIesw79vsXZYqgc8kKWDB8BOfxIuV8KaDmDMwmjgE98kGTJCx
	xWR1IwDrmyBOSiI4CmBIojNsqjyW0//1D/SC1OyFeq5ckgD7roAq/WoB7lVvGrg==
X-Google-Smtp-Source: AGHT+IFSgI7ynQO05ITDIMMGNQuV0NhyoU+S80DP5VZti0Les4bHUCSN7kHUohJoYSqboUd/PkGLIQ==
X-Received: by 2002:a05:600c:1554:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-458b6b34cb7mr1416375e9.21.1754069926804;
        Fri, 01 Aug 2025 10:38:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdf4sm72965545e9.11.2025.08.01.10.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:38:46 -0700 (PDT)
Message-ID: <9e4db85c-83bf-463e-9c6d-bc31e5889574@linaro.org>
Date: Fri, 1 Aug 2025 19:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: qcom: lmh: enable COMPILE_TEST testing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/07/2025 14:18, Dmitry Baryshkov wrote:
> Rework Kconfig dependencies and make LMH driver subject to the
> COMPILE_TEST testing.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

