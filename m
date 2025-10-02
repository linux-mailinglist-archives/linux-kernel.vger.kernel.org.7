Return-Path: <linux-kernel+bounces-840233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840CBB3E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE6424E0493
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E331065B;
	Thu,  2 Oct 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt6BcQ8s"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0243101D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408379; cv=none; b=NQ6rnaCSTe34oiRqcbbF9HtET+tvMCFMELpzNuNlkGXJQtJ+Vfo88sR+fYWywY278S1kevPeedy8jxFijrFAB5nYOPavm4+Lzfhk47emb4YifJjqCRFGwQ2NO6ZrnuFpQTntrnoITTXBs+z5JSNfgXQKC4xzIqBpGEOH8chJ5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408379; c=relaxed/simple;
	bh=NQfmquux42wuhxo0BQMxiOBKNdj5p01NoIvPSKU6GnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxLO3ckzdHIrB/OS7wLjUzHHP+elXm6jt4KUEbh/qD1pXrl5E9wF8v0zR5f1Q0/6ODth6bAscU4jS1IbqM23QDg+zxIP0i2mZCEN7IUqMmmhKbc2jSTV2H24Ur311+eK8duzVXKWpx1Vb1gfW7rqcezYBYbujLNJeGgmOrCtvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt6BcQ8s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57e36125e8aso948071e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759408375; x=1760013175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfNC3Xb4lpD24hJLVxldrPKbuiKZxGen+G2CEMgTUcY=;
        b=Nt6BcQ8sMGj5OM919sNRN5ivkFshbSc7BLLgaW181Q5WwXooVwW2r33rRN0QTu7OJm
         8t0X5tOcTUuothf/DCnZIFMvySy3v0+G3++bx++9XbDuvDz+/9jB7mtKnt5xtf7irFyK
         Y2FeZA5pNEWWSOMzejXFreqM9DVsSiP0TMCjrLvoK/GStXaoGtF+AOWQ+0dn8Pe/sdGr
         HTCttIqI5FSDqC17IHWL3oxn0eJbws5ZbtMqwuk7EjOyxaXqnX8ASUVqX4md9G+Eijn4
         oaxjIhqUNXXAO8NT+6NoNFfAds+suAu4MYCiesOwJQ6/ru9OAcJt19qEqs9/g9RkW2uI
         RKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408375; x=1760013175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfNC3Xb4lpD24hJLVxldrPKbuiKZxGen+G2CEMgTUcY=;
        b=DRSW6oG1z4UpotL7qRZJ+dPd4ItdZe0SPwcUR7H83vlxuR+i+DPHhCSoqEqDJfS3KK
         IWam8FqVfKZZpzXmD8tlUSjfVQLJvxPsGh6s1LsWfCYb6IbbTeDSPMKF1bYcjORclicT
         ZDeLjiYd7UG55/lyczqAANgPEtqFb/28QfZ6MQ+BBmjOfuVdFRq5MnPETrdOrfj7EkZm
         qZbg0qw9icoFlr036U1ZKwJ7uvP2DhZLeaGvObEg68Q7Q6Q5Igmw4UhMkOO/nk7r13Ec
         WBEz11pDmczjBN5PoE1R0M2KzGMLsUQ68O+LjpJQrGlTjWPZhfwt08cfhaBDttoV2KYn
         hIXw==
X-Forwarded-Encrypted: i=1; AJvYcCWw9GufKo+HcaSbU/TPjbQsQTIoqMXSjgM8rnlet4e/lTm+Lv5JVelB37Pluyu4a2iLKRbttibBlvICKcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABN4W4rhThBSkhTEGAaMde1XyHRQiDh4m+rmucmUni6/RaEYD
	5Ax2W2WJi3uQCoucY37/FFSv88T7v3mTpPbSO9CGvOprJy2D1dW96mR1
X-Gm-Gg: ASbGncv65IDDTsLZ1r+TS+p1WL4QMzDL67kMwCsOSH73dItY30UjLWIbS+wnyJiBHMF
	IN/bi6UTbSN8dxnEQ25YyLXKKzfSjvfPsTPrIPLGmCxVz0kcdW337C/ga+PhwFLdskaIGCavXpq
	5tJh/JvscmisTssuLMx54TKWRjIsEeEB+ZypzqOIOd2SKG7+DzdL2zWkfKIagm0/vcS17/HmUXX
	lU6BH/VlmALulGadIEh9IopArSB937Sqx9o3NDH+t6Wjmzf5sfMQqq10hoOiSbW56YOeJP6sVWc
	qmvMJUYjH0qMGTQw10Ihl5HXZWHFdKfFCBBs0VgzN8rq5gmDkIvm4B7IOhJoQSA/itwzuCROmRt
	ls50FMpU7pph0tHvYGleVusnr7rp4Q07u4hQmDygkeLUvRx4Ho75BsU2eBxGYwMSmawSprqCKnQ
	oWa9qPny3iV1EIcUp6f+bVuzf/HnLBwUWR3rgro1s=
X-Google-Smtp-Source: AGHT+IF18yTu4umAkjA3/Qx9zPqlomJTIYHVobYviXEIsSwMeDgT8lj+VIPft3Jjzw5OnhnlzajAlg==
X-Received: by 2002:a05:6512:3d10:b0:55f:5685:b5e9 with SMTP id 2adb3069b0e04-58af9f0e54fmr2524260e87.8.1759408375230;
        Thu, 02 Oct 2025 05:32:55 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01134a4asm802635e87.37.2025.10.02.05.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:32:54 -0700 (PDT)
Message-ID: <609ec2e6-c877-4fc5-95b7-935ae2549b3a@gmail.com>
Date: Thu, 2 Oct 2025 15:32:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: am33xx: Add missing serial console speed
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Tony Lindgren <tony@atomide.com>, Bruno Thomsen <bruno.thomsen@gmail.com>,
 Judith Mendez <jm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <63cef5c3643d359e8ec13366ca79377f12dd73b1.1759398641.git.geert+renesas@glider.be>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <63cef5c3643d359e8ec13366ca79377f12dd73b1.1759398641.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2025 12:53, Geert Uytterhoeven wrote:
> Without a serial console speed specified in chosen/stdout-path in the
> DTB, the serial console uses the default speed of the serial driver,
> unless explicitly overridden in a legacy console= kernel command-line
> parameter.
> 
> After dropping "ti,omap3-uart" from the list of compatible values in DT,
> AM33xx serial ports can no longer be used with the legacy OMAP serial
> driver, but only with the OMAP-flavored 8250 serial driver (which is
> mutually-exclusive with the former).  However, replacing
> CONFIG_SERIAL_OMAP=y by CONFIG_SERIAL_8250_OMAP=y (with/without enabling
> CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP) may not be sufficient to restore
> serial console functionality: the legacy OMAP serial driver defaults to
> 115200 bps, while the 8250 serial driver defaults to 9600 bps, causing
> no visible output on the serial console when no appropriate console=
> kernel command-line parameter is specified.
> 
> Fix this for all AM33xx boards by adding ":115200n8" to
> chosen/stdout-path.  This requires replacing the "&uartN" reference by
> the corresponding "serialN" DT alias.
> 
> Fixes: ca8be8fc2c306efb ("ARM: dts: am33xx-l4: fix UART compatible")
> Fixes: 077e1cde78c3f904 ("ARM: omap2plus_defconfig: Enable 8250_OMAP")
> Closes: https://lore.kernel.org/CAMuHMdUb7Jb2=GqK3=Rn+Gv5G9KogcQieqDvjDCkJA4zyX4VcA@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Tested-by: Matti Vaittinen <mazziesaccount@gmail.com>

(Tested booting on Beaglebone black with a config and kernel command 
line which were NOT affected by the issue. Well, prints do still get 
through the UART to my minicom, so things seem to work for me after this 
change as well :) )

The change does also look Ok to me.

Yours,
	-- Matti

