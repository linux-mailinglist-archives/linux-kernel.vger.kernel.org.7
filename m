Return-Path: <linux-kernel+bounces-735590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53CB09150
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F797ACDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090142F94BE;
	Thu, 17 Jul 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1UOrxLY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486162F8C4B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768422; cv=none; b=EA5QZkncc6PM6i7pGlqxf3ek7fecRZWO5UzyipcCfcim++GF/NevlCFCKyYZHS4ydi69/SlH0w99XLu9ojNDXdwT+tdRhwQ9FBQdnQSVOODFFbtxWDegzo3zD9YL9UK6fCfwgzjvacvGzdPcygGVdjk2bm/cqN/4EgFVi28nir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768422; c=relaxed/simple;
	bh=h6SUv5F3sSkMt4hliGGw5MzCkPQbyFnhTA9Kl2lmveo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXM0akNrIMN4tOdWI7oDA9I07p5EcyzHdHsJEuXKxlgQMQQoWbVdHrztTFABwRCODESdvbPcKRUmo1PXyg57gAY0dHCunS9TtX1vPIlY521zYDlwLb8wp+fc4EL+5hO0bgbyzXHrWLiWvW0i9NpLWRwCxHZErDi2GVxMxuodkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1UOrxLY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45629703011so8984415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752768418; x=1753373218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/BNV8Br8ggkW3UcK3Zf2ulHXs0ZJobMuBMxa/aid09Y=;
        b=N1UOrxLYzcZIKBSjo5fvOO0KvGyu+xLEk6xFkSZa626iPG8ai37xYoHo90VGBkP1ry
         F5xhEscVG4zHJLfHxIm3bw7lkh2Ec8x11MqVZuLte8bmeP92ccx0UwhIfJBOQWd/aG2x
         XAzYPPJxnTl49uf9XmrZzSZjCXuBPTmlG+NWVolzAhq/tdyZoRdWIqb/iCK69Iu0iSGO
         NXyVjKP/8AwUV2IB+y+pSONsY8TbesHVusawEcRWU6ciaj/731bFWvC6oJvgx+K2svBj
         ZQwkU/DIAbABU6Za214NrSvNhFSHtl4Xfa2OkDzZPFZ1hppcS7KAXWsi9LFwnROp2epE
         B4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768418; x=1753373218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BNV8Br8ggkW3UcK3Zf2ulHXs0ZJobMuBMxa/aid09Y=;
        b=LlgzFlLdOwSs9De2WwzrIsoAxWHnUxZFDoZHz58J4pUBWB/E9Y9GFLmJm4gJUXDDFP
         mb4WF+7MUJqgECTyFUsxed5S4kDJ61TuPg7H4sbzBwAVmUUWDLa6D6+j4mgb15jTjXel
         cP+P4Gryz5eGrEf/w960ssJ8xkI+kFosNBoor8D9iTDb92Cdqww08GnnLVeQPmDA5u9h
         hbGaNff5H7F07o3oztbaCpq8rwiVJCKWpvPMHUxd4LBSu+BuIg1LL/gsgaUh8BDukFrn
         Qiso1RB4a/2TCM/yWYfMBWplZm8KRigBjmBDmLEHDFND7jSxxxtI7izkqH4tXc204UQk
         axJA==
X-Forwarded-Encrypted: i=1; AJvYcCXM1qn/Plax7B5k2gK3jURVE9c/BIV9/m419GDSzno637vdi1dPhQudrnTfOR/J+tGkpeEzDuZAE685PT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HH/5IRmsW0xqHnvmF8rvJaJjo5lGL2TcR38BED/Au8g7zApU
	kEcQfu2y3WyAeCa/4JG4vQsp6FQFIzus/h0pGxwl4Ci0C2Unuzo5uzsUmbfIublTsRk=
X-Gm-Gg: ASbGncuULpQscCjSfQL6M64Ot2p8zJ72F13griz+SHCCNoRQKH6wlmJNtgCKEet32JV
	n/3MZ6zwZRSa41AR0cB0WfV4mtOxuwqZJ/SK6tZ7HbkI9q1Hi9GxKQizyQu4WOEKddjzyXNec19
	oQD7PhGQDBebz83vR1BA7o7T04hUXzrmrHVHHPzkH3rhhsrqN2SDlJml7AkX6QuSyQLGkhZEqX3
	7yqYcuoP9oW1MS1o2vIVq4gTCbJLQyJII4OtlroSU5rzYZ10MerbrGy3wFhkaNXRrfgQfBoU2kc
	3AvRqUN8eJ/MVV0y/b+La2sMPfDg5TDOCFQgicXBa+e+ocgGXAJJt3Eqr0giL8AyJ/3pO2qOUtN
	CVv019iz2oqdJRViB7L4u9bk=
X-Google-Smtp-Source: AGHT+IFd2pFskydzsXLxySJ86ae4Z4yBIdNrJZXhbrxV4zrWoKjgQmJQTRCDmqhUCimFVeIudsKmoA==
X-Received: by 2002:a5d:5f4e:0:b0:3a5:2653:7322 with SMTP id ffacd0b85a97d-3b60dd643bbmr6867126f8f.3.1752768418467;
        Thu, 17 Jul 2025 09:06:58 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e2fasm20802147f8f.77.2025.07.17.09.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:06:58 -0700 (PDT)
Message-ID: <c5d60a2a-7b3e-4adb-bd75-bd7c3437bfa7@suse.com>
Date: Thu, 17 Jul 2025 18:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: s32g2: Re-order usbmisc device tree
 section
To: Dan Carpenter <dan.carpenter@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1752703107.git.dan.carpenter@linaro.org>
 <14d3cfde-57bd-452e-afa6-8a468281e5e7@sabinyo.mountain>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <14d3cfde-57bd-452e-afa6-8a468281e5e7@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2025 00:46, Dan Carpenter wrote:
> The compatible line is supposed to be first.
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Closes: https://lore.kernel.org/all/u7glt7mn33lbdeskbr4ily6tjjifvffy64llwpi5b2rrhx5tnv@y2h2y3oz3xc4/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm64/boot/dts/freescale/s32g2.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 089f54415571..6f700085dec2 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -424,8 +424,8 @@ spi2: spi@401dc000 {
>   		};
>   
>   		usbmisc: usbmisc@44064200 {
> -			#index-cells = <1>;
>   			compatible = "nxp,s32g2-usbmisc";
> +			#index-cells = <1>;
>   			reg = <0x44064200 0x200>;
>   		};
>   


