Return-Path: <linux-kernel+bounces-861645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9618BF3400
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C06418A8276
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B68330304;
	Mon, 20 Oct 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="f38f3xHA"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677C2BEC23
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989310; cv=none; b=AtbMPaQvklGLVjHlr8Z/335mAEiM5o3Zc7btI0LQU+mVb8UZ33IxNENYe5Q17TMoP7R6DqEGlaepJmfyjWAHtTRLmirFC35BNlQxWNPpZSj5ljSoamAlezWd6ER8U6q+t2+o1i5aZjmWUxMRnLwOFU7uT3EL+VHlKXWNA9gmecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989310; c=relaxed/simple;
	bh=uQSzjldxRTZ35ORML6b3Cd4RgGLVmAPkW+5ZxaJHB28=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fp4SmONSkB14q6mWheQ3lvxAgGZi/KcLTWO+mbrKkfmZyrZxIWEWQa0ZZSNGNT8qP8SD30wD5dezEBJCxzBx06Dg7hSYcC4uOLrytBPAseuXmoMpycmm2tGNy1PTcBWWTMH9Nh448LybGjk+hNuPJNlRcRC1DiU49GFOYD4Q7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=f38f3xHA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so3565758a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760989306; x=1761594106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+3slhELo00fMq3w//kko/evMNTGZF1TLZtlTKBnvEc=;
        b=f38f3xHAdE+ycTYIPZX40GnfoIm4Kvx3pCaNBHweC0BH1cqw7K5HswGsRf9vqYrqnZ
         wRdyVjB8ptllWQqgH3ZNwGVHM9GiUKYuF7icRp5JW/T6Nej9tp8uuRSfM/MKf8cn9H75
         qhKS6XAlSQuf28XqSp4cWNI/XzEbj5fL9D/rrgtZ/IDhYlaj79XO6qUUUhl/2boLScMS
         d0QZfGqR2ZaX5mMr5Ol4gRVN0Tmp1X7XBiJwmyeW41sHT6OSwqGZKAbe7k7EBP4PVswg
         eLypgtM+ECJ91S+6j8u75cmVNz4gnE8YrendcQOis7ABOqXQxKEYWZ4AKFDDfqK3P+Cu
         AS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989306; x=1761594106;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+3slhELo00fMq3w//kko/evMNTGZF1TLZtlTKBnvEc=;
        b=N9j+eIXxaKy/7j9JYAOMmq5yPcXHV0T0rZliQB2godjg1eizx/pFub9VHzbNACHOoL
         Omr5Y4wbqAl729xTXyhF41GtGGEP4dKKiibjKBsr92LNohcB7lBzyo5ScQ1alBqE5qTj
         CK2M0FqGOoqUyJ7ehUB6zuwlGSG15LlifSzx3fRvzkyCq+3dcZXO0ZHU+reLymHCQb50
         1CwH1OSF4sBWgDqnevFdZDZ0XWPECP6rK2xULNcaJSx9VdZlRjJP4NbtyzO9V7b8yuu1
         7vprhWX81IP+rUXjghRDTHXYaSeJuRdcYhtiUP93h8ojnkqhdg6dIPfacCYeXDtWbmx6
         aiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCURlfL2+vKEjy9roLprXfL1vArUz0NQzaBKIvEbSZinQSZeyWEpxfJWWWDjfmlVv/y/mb/7f/fDoHtLfwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyfZKnh9rP+edCiErJn1h15orj2kR0fiqVEQ2aOynQpLmblD3
	gDacatiK2eQ3XNGwkxTIF09rRfGah883+8l710ORcoyGFd10WB+o+2Z+vihCQELR2YA=
X-Gm-Gg: ASbGncvwhn2I6h7PdkD2KYPZLGwQ1+V7uwHr6ugVtBK4hQ9umiteX4lyG4kdq9cq7qp
	NUBwuXqdd+ONHmmZMDWGxBVVFr9ti8tpc4oO4EQwWkJ4vqjjpL8LpzK0C7SHyzCLKNAN6cpY7RX
	Oy6vW3GO8ZD2ZmhXf4A/KQm6hLvUHUgQk8eTmaQyqzOZ+LM97nr5F2bjMDidKzSaw9BfLiZoeEO
	6eBPSEOIZH+GSwyWh+aYLMxTLFujCXK6uESkJ6tXfuTCwpw9NbhUxK7CwaBFUyDDL33/rP4gZjM
	eXHk2vFYaQTBQeNJJni4PAF0qQn6H4K1OmKjPZbt3I0LU9ZXI7Z6XgVu9AY7cQ33+4W7Uji8uLG
	vhwo7ZIP1+V1WEAyGDIwDOYP/SlHBvYF3baE9Liu6gMNM/XFteC8cN0HBU8qePPAyUSwE49tgcT
	O5U4t1rsR/
X-Google-Smtp-Source: AGHT+IHDIxoLORK8TXA5ZD6/WsOqHWJqq7Eq+n+YHr0BJm7nwggP3jvxI5a/xsatvpj+kR59rawzjQ==
X-Received: by 2002:a05:6402:4306:b0:628:b619:49bd with SMTP id 4fb4d7f45d1cf-63c1f6cea4amr12864517a12.25.1760989305960;
        Mon, 20 Oct 2025 12:41:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430145sm7409668a12.19.2025.10.20.12.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:41:44 -0700 (PDT)
Message-ID: <5650e47d-97ab-49a3-8342-7aad9daa5a1c@tuxon.dev>
Date: Mon, 20 Oct 2025 22:41:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 05/31] clk: at91: clk-peripheral: switch to
 clk_parent_data
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <b0635913503630a8e1880b0b9ba8656465020181.1758226719.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <b0635913503630a8e1880b0b9ba8656465020181.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 9/19/25 00:15, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Use struct clk_parent_data instead of parent_hw for peripheral clocks.

Could you please explain also why as done in other patches?

The rest looks good to me.

Thank you,
Claudiu

