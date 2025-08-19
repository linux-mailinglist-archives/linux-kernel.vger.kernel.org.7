Return-Path: <linux-kernel+bounces-775905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EFB2C64F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2565C14EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B823342C82;
	Tue, 19 Aug 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bVh3bz+u"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758B33CE90
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611444; cv=none; b=hO8DSUucBDF1GT9Rw+AJLDdQSV9CdITgK5mYPJIG7787y02nhF6euW86c4xpYqhSwG86cFWul5Oc5Tx5gxfj0aBTCJjnxEapBdNdY1dhNdB+L5oAlSp2wpG78cORqyZKWiJJswx52J6r3HSYFKqxeb4KAtCYqXXUNIflCElqrq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611444; c=relaxed/simple;
	bh=4FLK4uwd9XdTQFJsLCjn7vRojAV/LnaXAkG7LhXSXzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWr0kn0uziwC2gzNlcQ8iTloxshqzpePVoCgKjgSG8w5x8eQNLM/Gazu3kJlbLyuEiZRK/Y73vWVA3oTEtw69P5M96RKBaG95/fFl3e2vEgCa6fNXoTO3xSgse5l2EjU05j5rjCU3ru6irjT8xHRPu6bxxRQU9Io6NROizoryhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bVh3bz+u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so29148505e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755611439; x=1756216239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDSkE7U9Qu4I+xfKyU0ZKG/iraqseXuPT2xyK2sdU+M=;
        b=bVh3bz+u5fPXs7gV06n1Sp7bll/5JSo6QB7YdaAn0FpW+GsXETkgPGA/2eda3oQJVo
         0YmpR2RyrIHB86nbfwHV44GCTmueBBau/cB0Ah5RCIxMdx35a4igGMUiryiLJF0w91Yh
         ONm39a3joRxaAnL8nXsRBcKV89thMknocVQBuo+1crP04FGY8KDMXq1jfE6N44FszoSJ
         DXpvtO7Sce2SvV4l9bxwUKzF/A4NumK1DVaYLDSsUwSdzqMKBis/6HsCSvMqSCnbpcer
         LVkfYWuWGev5V+2kX8GzE7UxjMbtbqlCg6Mi0Xlk4J+DZEDJOiwlYwhPHIBFmHb+tcR6
         unQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611439; x=1756216239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDSkE7U9Qu4I+xfKyU0ZKG/iraqseXuPT2xyK2sdU+M=;
        b=iauCuU5j71Xc32nmZMqwghStLPsC9q72QyM9LJbuhqiD4+kXHV7G+0UOM5w+qOPM10
         qGIxjA+5iTVmQcfnsqDTqnuYfgLuM0qeDtvDYdQn+81M7UILHUCL+1EFMs/qKOSCfGcQ
         vhDl6JRu1V4VG7Q6TsSTHfjGjk3koiBViKU9aROpcYNrQppEHsix4T011CXXSFoES93B
         pB+bQo2DEFQ4DEFnt8N5xga7F5Ke1JIWXx6eJf2pmSwMdSDiIrmbWNJ8bbBkLV/hThxF
         bnfiCv92tJtUUTjs0yfzTropFa/3T6b3X5t94y1eDwu0urKmqkqsQtu+UF4dZmUW5xdn
         /pyA==
X-Forwarded-Encrypted: i=1; AJvYcCXmTLnd9oBvAsL+UElP543h7wxjiNSpXixpFRUfSiJsUB8Mi7EzrkdzGtWJPKfo1j4CCGQ57/W9lDY+cpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEk59YStBIBbiWj6o5Y2i+XHQQkjfJ8X0VLNNvDNoq5luHvbU
	j3LxqxmpZG0Xu5PWX8ABrg7R432ZTfC+RL+SFkIw5Xf8TWmsII/H4J73e6jnZFK4tzg=
X-Gm-Gg: ASbGncuc/RbAftKtdBBCDdTyDYMd2RzHTA+NQPdLfEwOMkp9ZcCdFXhv/eHX7tL22/O
	1v8g2hrPyRY5aez+Q6e2MECidFZpWyJQOAhn1VhXsq9/6RS/ZCeY5jEUz5+aN5hZ6sqo/qRF3fb
	w4+CPDiQuqPVDNrodbMQ9zxoDHQHXUrMlaoIN0ATrTdGahJNjfp4tzyC+Z0ZDyu0qVb+DmYTjRo
	l++SiXZo66Z+IQc+/sPVc0hC9bjgeUlwcOzFtuO03Azns928sqHTzjk+B06L4EsxdPC5EnKJAL2
	nFIEaqeHEOhIMUt8DZSQzFcz/KJPkhGtqBx1eDBw6A91mJ3hcpf0k4hb0c8/YklBdoqxPbV5zWQ
	mRcxLhcCiy9psc7dA0PDNwCkLT7P2ZC6w3sw3nvrO/GudwHoIeoZC1ob52BcuAcOYavvC4JV+k3
	whbw==
X-Google-Smtp-Source: AGHT+IHX13y9qpR1ov+G1SAxA5zb/tzK+QDekRax5d5YMmmYIt2QlNFE9FY4s/8+jyJkR7c3tds4tw==
X-Received: by 2002:a05:600c:8b5b:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45b46854158mr6209225e9.2.1755611438859;
        Tue, 19 Aug 2025 06:50:38 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:620a:8b00:75e2:191e:43ad:ebe1? ([2a02:2f04:620a:8b00:75e2:191e:43ad:ebe1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c61a66esm214297945e9.0.2025.08.19.06.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:50:38 -0700 (PDT)
Message-ID: <6322a45a-c1bf-41aa-b2c6-f169a61e3a41@tuxon.dev>
Date: Tue, 19 Aug 2025 16:50:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Add suspend/resume support for
 Schmitt control registers
To: Biju <biju.das.au@gmail.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250819084022.20512-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250819084022.20512-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 8/19/25 11:40, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The Renesas RZ/G3E supports a power-saving mode where power to most of
> the SoC components is lost, including the PIN controller.  Save and
> restore the Schmitt control register contents to ensure the
> functionality is preserved after a suspend/resume cycle.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

