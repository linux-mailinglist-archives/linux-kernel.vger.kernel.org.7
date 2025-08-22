Return-Path: <linux-kernel+bounces-782287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE71CB31E51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F31D412CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CA3093C9;
	Fri, 22 Aug 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dSYUvsAP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F43054C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875832; cv=none; b=NtRHrLQW9XtwH8kmxulFOXapVXj3biVqS8pk52v8pInUaSHsbr9HQ1EXUfm25NBRfGvEABfjEkOceHzy0Todl0TSzVxWgLOQDRuXgT8a3XoViakfQGvJyhbali5A7QuNng/Nk9wIEyka3z+Dnv/stEzXqB4RGhIPKqJXq7ugPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875832; c=relaxed/simple;
	bh=y24e09Te60oIGgGJpyKrT8gzaOYkUAB6uCKHewL7Pbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W56/KT8WlD5b31QQ+fEYUnZgf9tAsFtCUJ4dcZpbbzM6Imjp2ZElz961tgUE3o275KTtBgwx55Zf8A5n1SIUhAbBx0RdlSsqe4GjWsur9DHTuwdmxSFl6JnWmJjtah9z9EFD2kimTalBapY7OSjZowIOvtvr8mmpzWbid1W3riA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dSYUvsAP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso17107265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755875829; x=1756480629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIKMURTzGnc0o3Eec57Nl0ZpPfL0lnmgxqpSyQAZbI4=;
        b=dSYUvsAPsiAcmzim065bX3bqQE4/9iG6eyy+tqkYqF/DYV6auiTfuPCranA4s9c4kr
         AOUehCA96epnFb0w68GcOHxH/zfIBqlhxtajYiCFJnUfy3+k++CvTFtwQPDsr9Izf4xe
         Tqd1QA0rbRv1XyYzay0Ej3YOIhjvqUGoxJrRx5asJopwtt7jpLxTdLIZbqpEtAVpMtZy
         Ox0kdlmcM8GGRz53T5N14lpwEljM8Ll0hug4yaIobFy5RYalFNwCSDGui6/MAarUlzTe
         r8fAS1aiPtZai/wbJLCiPS6ZJJZ+EBpaiep2/s3v57qUmxHH5HrQVBLBNITieNKptWgg
         oxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875829; x=1756480629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIKMURTzGnc0o3Eec57Nl0ZpPfL0lnmgxqpSyQAZbI4=;
        b=OFXAFe33fyrsG3pmZv9QxuYGCqaGbZg4WXPGgRmEhcdjdbOyrYg87XcusYmZ1RjVYt
         QtQ81mMp99QcVhUYNH/qRHoRGGfRk54k4o1iFTXE1/8ze0veUXezYjz6JxM90Jhhv8uO
         Ja+G0ZRqkMl1GlqHZTrtWyCMv6n+CKEABlrAUvKBGR2t1DGeN7/GbtXvBNkVh1dhhcpY
         pX/T0Mn/RMYj8wqMxoNhUvhoH/0o8J5TQA2SVq5+IpC8cTsa+aiAULPFq6Wv7cuvjzZO
         7J8dO2rW7kAFPayEHygEcyKr3qfUn+nmXNmHLhkqPl9YQkjUpY7ErYP2y3O7rm5ClyWp
         jU3g==
X-Forwarded-Encrypted: i=1; AJvYcCULP5RPqXY3OiDVOC6j/xsvxatbIXXDDuNLxayx8yc844D5HD2szWf2KuH/UbVHBk+WwPEvCMpa3QStvxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6bqJTYnFlyibNEaWYFd+nPGXkWdLErKdL0C01FVyEME0JQ0r
	0hdR3yjajkTeTEWPwxxl/VnuQiLF1sFViVbhyJcWWtJ1BsAe5AvWEAuTp6AztIw7Ufs=
X-Gm-Gg: ASbGnctWeq9PUZoPkz3f+iejT3rC/RjLmApPEQ2TIjYFV+vtXRY+kzpQn2Ks9jrnZ1y
	rg30inMIPpMRPH0YjRmwDDP9Lalub2YR9htTK8wnQQQINyfY7SbGiDDzJLIZAcq8A8zqQCnmhY5
	Hn4Q6Pid0FuG4LeCGUky9HCcXY25bjlbnHgt7FH6jN/Quq9LfUF2sYiYH1GuXV3pp//csvYh26q
	VUdsTVgGeLqsp3/qbWj3XBGhmNtyG7RrVAh8OupCFSccOM+6686g13HONXbRRWPYsSBFCdxZgRt
	xe7UyHz1U195v8JL6LDwmH753Hm/MGj3vF1AF0QAk9RG1ilugRz/4emsanGK1CGjqwWfTgWfEqO
	+Nm5fcxtgKDVYKs54bZrMX+ycx/IuMw==
X-Google-Smtp-Source: AGHT+IFfCxlBLYp46j2up+4x50Ih1kKtjjCCeP9uWttzOiVuvk9BH4ASeoYU65ehdDMkjUePa7z9oA==
X-Received: by 2002:a05:6000:40dd:b0:3b9:10ed:e6eb with SMTP id ffacd0b85a97d-3c5dac17469mr2333176f8f.8.1755875828487;
        Fri, 22 Aug 2025 08:17:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c52121313asm5508248f8f.57.2025.08.22.08.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:17:07 -0700 (PDT)
Message-ID: <770e936b-2c4c-4554-a567-6e7b0f688512@tuxon.dev>
Date: Fri, 22 Aug 2025 18:17:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: net: cdns,macb: Add compatible for
 Raspberry Pi RP1
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-3-svarbanov@suse.de>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250822093440.53941-3-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.08.2025 12:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The Raspberry Pi RP1 chip has the Cadence GEM ethernet
> controller, so add a compatible string for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>


Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

