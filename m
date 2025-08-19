Return-Path: <linux-kernel+bounces-774967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF4B2B9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AD91892B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2D220F2A;
	Tue, 19 Aug 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtKk9iCO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645EB20B80D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585781; cv=none; b=dPs+aG9/GfM3tJHn6woeknL6cqNpB3HxW24XZ+Ad8LGBYwdhFVjM0bZH9CIFuOKYQ1Yebi/McT41yeQTgzInnVXgTxVXuKrlGfEogaVqnW+otX6ScrakhLyst/xJ0uHMz1+t4GWRQQ0ep5IUn/8PlK0XoEVmdl4HTx1ZPT04fWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585781; c=relaxed/simple;
	bh=8w9gGZQ0O7gYriJEHgqdD87y6ep2mTrcyZvC1cwp1n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L78R70lJIAwdKvqpT2LHmWLWCX/4aSKZp+T2syC0Pgg5mdmRdlCp0tv5lkcVAISlSy1oQlStAArLyuNNm0EoxpQRJfTvoUt/gHhYngI/C7M6ry+4XruaVR7yUXf2VmB/EBJgRFeI3PqXU1LN45noir1CqNvWLm2oupUNPYAMlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtKk9iCO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb736dc8cso64602966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755585778; x=1756190578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NZfKG3udWMgsrYuCbWQzkndmXN80FmmveksBAwZ7vU=;
        b=GtKk9iCOVgCsCUjq4sgNArTzy+A/p6MEcGFBKsAuUI8blAnlAJS5QyLdELGTewsZGc
         LCNMWazpm49jIMc7zQGngE22sjeI0xcadxq/Q11MxPjQbyzx3vdnAA2wi/t6wbWznCu3
         kuNgevgzBpUK7D7+LY00YzpV74ovkiNeET+GbW83wc21MT/MDbLLIpgezQibBsLrGOHI
         MMHVuqk0XciHZ0emPLqH7Br13b66lEJoanCpFZ7km3YMJeNYz89b3fjFqVua4p8hywow
         kEx0LOAXDXFvAKZumQrJynxlhXsbMWHAGcQIC7E48tPI/xZHAeMfYMcs7wevJiWJX/93
         g5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585778; x=1756190578;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NZfKG3udWMgsrYuCbWQzkndmXN80FmmveksBAwZ7vU=;
        b=fBA3N6Q5JG63TDjd1KLLRwvbRAuoGJU7n5vuFawXSn6vRVnbRYlOhpipvKaITHyo7D
         YzAdEDwaj5jaFO31fqSKcmL6SHTjJmWKp46XEGgqlsp1/fR2NlgbCv4cI4JdwFVHW3Z+
         +HSNhKGMqqwE6gki6vRzBsRp+0JOYSaamQp9HKYCgypBgTu19dfBHt79WimRILf9MNyj
         ok/sb0TIuWbjVztTwCyj3ef6FRB0WcFjeb54pRgJkgFYXfB3z370bSDOm/8+h+J8NO2l
         OBeDNDAc2wjeFkUPAcJa6sJFaG82jsHvTcp75kYQ30X7ddZaFs3J8LgSRjp9tSJYdmbN
         CYbg==
X-Forwarded-Encrypted: i=1; AJvYcCWlBX62nPyoKzOMbzeeCL5bwNA9IuZHLdfTXjLtwtSAgLa3u0KggZct2cuEyPx/4VkFODikH+YvlC1XRB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAoyjzIoFuZAAO44RtQTxubA50JatUc7uvPY/dxb9itycF2bP
	0Jyq+nogxNtzI6jXjksFYraZg16/LI2LhlBFauOYV2B4XWHQGcAPOzg2IZ/2bMLnluc=
X-Gm-Gg: ASbGncvrM4m5+lET1+yymSJAi5WuwvDAssihPnkKHcvSfvi7FKVIM7Izj4NK8Q0892S
	4Ij30DB/443rEGDePdTgNmXXlV2GFRGokttJGpwapA+yVerfMuKZtUe+NH7tZHUNJYtlKfndHUj
	6bHzStbzhMXwp7jWDkbYnvrlPrnKZjV9NCf1Y1OLkbKxfHzd9vuH4tOoqOcbYBSvztcz5KboFHn
	LYkdd6G2DUFamndG+in5pAvnKszMbcXAaUlHjRuEA62pzKCHr407MV+y2CbLAu/rKJZaj9Qq/n8
	/VLTI1ZDk7fIBggAvxM8v5bXpNMjvQzr8zT9+sCU2p+Am1GQN/erzZzaDwoVJRFuVekg8CgvY+H
	f7r9BK+/v2JosJSTwTdsUigK47vVLZHH8rsFb9DEWL9LGathuCxku4w==
X-Google-Smtp-Source: AGHT+IGK+U1B0BTvP4z58K3V9N0HAGdkPpmK/TpDUyvBa2blzD5rILla7oi2qSDdcRptU4XVkMKZdQ==
X-Received: by 2002:a05:6402:3482:b0:612:e262:929c with SMTP id 4fb4d7f45d1cf-61a7e485594mr585881a12.0.1755585777611;
        Mon, 18 Aug 2025 23:42:57 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778c5dsm1161708a12.31.2025.08.18.23.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 23:42:57 -0700 (PDT)
Message-ID: <380246b7-7e7a-4843-b82b-2e8d74e01ad5@linaro.org>
Date: Tue, 19 Aug 2025 08:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Change ethernet TXD timing delay
 value
To: Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250819045018.2094282-1-tobetter@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250819045018.2094282-1-tobetter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2025 06:50, Dongjin Kim wrote:
> Very poor network performance is observed on the ODROID-M1 Board
> (REV 1.0 20220613) when running iperf3 (under 200Mbits/sec), and
> this problem can be resolved after changing the value of TXD
> timing to 0x35 from 0x4f.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> Change-Id: Idecd246e3fe93447b6e3e9b165d077d2050bbd75


Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Please rebase and always
work on mainline or start using mentioned tools, so correct addresses
will be used.

Best regards,
Krzysztof

