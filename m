Return-Path: <linux-kernel+bounces-861585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C02BF3207
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AF6425CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876BE2D6E48;
	Mon, 20 Oct 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kmMuzy7c"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EAA2D5946
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987581; cv=none; b=Hn6Swf1ki67RMiG4zcMO7/XNN3WLBnMX70O8HKENdNg/W6371RNKLIhl+t9xHfARM+U6uV6qPq+7dFb6Pp0NMpxgjsEJ5ElAni4sd212MSU3aEF+rvzGeOhEX/bs/4RNqC+YpVCfQtXgULznCe+LQjpb3O71/qFwKYuCxFLG4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987581; c=relaxed/simple;
	bh=hVT3hY6tz59tIIi7tKWV6ECT2wfeievMvQ7IIDTlaZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKl16MYdXbLgwFkDszpkqBzqSGoRkR78sWV8/BK8DSp3O3KLIBTL7M0gxqo/9ddARBX/MKA0PI76tX5TWgvCMls2xLCLyovg0b6iIhEgCT6k4gO2DLjR88pGWdA8Zi4GeyPWB84lIepitT40fgOlgD96NLbleEJNPnSdr4rri9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kmMuzy7c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5e19810703so778056366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987578; x=1761592378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkbTEtqdRTfgmATvZD4Qc4DJJkydsbu/UNnHytD9sg4=;
        b=kmMuzy7cenbrZS3mEbnvrl/Flo6h+Ut5Zy3e0i4/cyLMzgiPOHD07nx4GLSULE1XrC
         BI40h9Z9GUplh1B0F9PRVvHqyjuIAZrM4wg9RtqeghSfLoL2HWsoF8eY/pssQoSPYP08
         00s526vonubyBDyvM8X0AdXlcgAv+GdxHe6KnUO8CrLhjpbjXqubHK5QkACnfW+WltYr
         m3ST8uuzAK6RfCwq8+JeonzRHypVmsNfHyvli3jOwRL+Cm4XVWmxaMw8Dg6YB+l/g/nL
         /I4SrRXHn8keUbTN25quR4dp0kGmkMS1NkRdKo+scMmdKXx2xZUSOCr08QHMAtqIRG+o
         9xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987578; x=1761592378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkbTEtqdRTfgmATvZD4Qc4DJJkydsbu/UNnHytD9sg4=;
        b=cjGrkUdZ3cURbqHpMZCPLotETuqlTErk24370tKrnBwOVweI/h6BE2Z/SedouXH8sz
         qqTCuArCSVua9PfAop0vFIz/gsr+YOvQtBwzYKRhpLEsAS7oUlrf5QB2QnWvPyh7U5BY
         mitUB9cg1RtR0ePzfuOOTJUTwDib5Yuym9EbFAMzp2hMsuH/6EBJkQi8Dkv0OG1ePl//
         SVaAQra0ozvP3SVqShWwDhSWHne5HcbS+lDpumTUXn6h4F4vYZ+TA6lWAy6eaGGOvAou
         ff/5Xqgg+D/pB9hNVbRJpqg71moRfK3m+JxUlnKcIWXPNcKbXPaXV5Wf5HlgPQSmZ1xQ
         S0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUpCDraM67yE/GOMs7lsAcKCNCDPTbnIIc+zfcgI+mIUlB2nqNiBgUN8dUOlZFiDz0Ki/sKTguN6OB9/l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweD21xDhlWtnv9xuGk04y2lLXwS9WW7KvusUHOcw2zK8z/XxSO
	LrByf9wyBvsaqlLdya/fPhDFcIP5kO25QL5cg4ZQO+esRkNJVKlRWeJL38x4bPt3rq0=
X-Gm-Gg: ASbGncv6NoH4O+HJOzvqWL0jwCH2wSe+QPfDIhsXmEFqXyk2q3YqOPUngxlubaPgydP
	8AdtqEtb1JPscZsjtiQ5Q3HYRnGQ8GRoLaBKmYhbMSFDUCW7L/dA0+N9KvxVHmhbAAJA48JSJva
	+V04wBYHVipz/Km1Myi9j+aLgstDOOTh2uEM4QjaZFA/vYJptGRet+5uhR1VOav9MXGUNzWNGJO
	6zM7IAkPv+GI42pRx8PrmTmrf9JDwee7FmGhxlbop3Kpi4hOuqcB7sg9izi6m9/qhpk21WgmUcV
	BZHdZp3BX8KNgmO85MIYYEWLsLCXO24x4OHnbPcZQb73Eor8GXrfDGsFi9J9RZq/tc9uR20HIQQ
	hjnHHJ07YlcdSGY2pIh9Kq1YcvbHAt1PRaZ8vv6hpaQDCJEQ53WCmEuGbDWod8vWJ3KUJcM9Tt7
	2sYXxfUPMr
X-Google-Smtp-Source: AGHT+IE+X5JpzMaImDhaId50MFj6FY2X9vUqqcmU/xQrocAAwZvjv+bdBOOQS4rP8CKvZNBKJCdcDw==
X-Received: by 2002:a17:907:728d:b0:b3f:f6d:1daa with SMTP id a640c23a62f3a-b647443cf06mr1587664466b.37.1760987577301;
        Mon, 20 Oct 2025 12:12:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb952046sm861152966b.70.2025.10.20.12.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:12:56 -0700 (PDT)
Message-ID: <89e15554-e4a2-4f74-8ded-1fbec7ec5000@tuxon.dev>
Date: Mon, 20 Oct 2025 22:12:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/31] clk: at91: clk-plldiv: add support for parent_hw
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <ab562d7a5492e45878aa3d4160ad9079571625b0.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ab562d7a5492e45878aa3d4160ad9079571625b0.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for parent_hw in plldiv clock driver.

s/parent_hw/parent_data. Same for the patch title.

> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
> 
> All the SoC based drivers that rely on clk-plldiv were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>



