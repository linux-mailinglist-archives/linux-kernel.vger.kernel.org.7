Return-Path: <linux-kernel+bounces-883238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F230C2D066
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259A0621A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FE7080D;
	Mon,  3 Nov 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB+NiSrJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAA322755
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183601; cv=none; b=Nbele+s57yfcRzwB8JtfvxTeE8R6yBrekPWT8UaWY9mCSpDHSEg2aqCQH1V9pvAV6vicbYPbQbOvR2ILWlQKelg3e0vsjgpH+CP/T5BJm3+tjmoppllzfmN0OOSO2tasoU/rjDCTwuraOSGfYjmekjGNwYBW88fzNcgFQsVCVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183601; c=relaxed/simple;
	bh=+7gZH5dM1CyDXyb/S0b17uF6cHLi/U992sd20U7pa/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxZ9EeNJGZzzuDeym5dlK1vVUkB7OBI0D9J3Rqn3RXOCSiTYmHSmtrtpFxySO164Dye8vbwrZx8NxuAKnwr+2Acd78AMQc4AqU0NCwTWBYdsWgfqxUBb1i1/QHcOU/siPGkmZH4/FMgqRHMYMU8iRH4mjuVsy3tfL6Qk36aAL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vB+NiSrJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64075080480so762602a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762183597; x=1762788397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cvbV9bnnHq3TInGKYCNMpxj4N2pXQIeZi96vII/uw4U=;
        b=vB+NiSrJzqKQubDPDMmDCRKqtWd2tRpqeMoOtLsOlLNgo3V4YmiRrobxn2ekMksFFe
         38oMm/t1pvi9gGwc6k8wE7iv/d6DU7/m2EFF8Q+FzwzpWRTPjLA+wcRL3f4NW5mB5Tm2
         qBthNyJLZHG0W2TBLej1CAZESZk1B8kq5F5soB6sEsOjqOhhCvfTmb/qJ2vFYC8NW9py
         nResaqb0/c/1rATRgQSZDeXHrIdpMeRLf4ht8O2u7JKfxt+5Qm92+rriulZSTv9JG0Eh
         wJcYUGS41zrqSf662wxLyw32/TIWaUb7K2N0Vf2n91G3ZX73iEctSNeXHgXiXLsHAW6f
         j8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183597; x=1762788397;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvbV9bnnHq3TInGKYCNMpxj4N2pXQIeZi96vII/uw4U=;
        b=adGdyPxGUrrJWPN+xERgKJqbBeQGaY77PkemhaqS44BlAbmlHLWDwKVasYIfJHODGV
         E/tkrFk0Pmy7rsIU1ZNFb/QimkqxwDBY9At9pIStWxOMkVTNZQwE8UFmzg8q9OtgGstf
         IOB0wwLABhnqp2ItSy46RBq9aG4qXBbMv1sbVcNu81DGtvIUxUvT6sBrfSHnIskjQzny
         91jH8Z7nO64u02gkq4DupzUT4is/yDhgnuPQ/JifCTHtnB/Ux+Lr4/uXM/ubBcfPgsb9
         p07eHQImF+/KrgaB3pPYf50T33366hLiy+FCzcZo+DbATyIH59e72kqH3QkNIT/IH+ZK
         4OBw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoY9IRah5ikCJgILb7mDxkGMdOwJaWW8doyCDHc/UhrUhz80ZJPgRR23+JcEegdSdIY230t1MRDJ0SZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdnKMhYz/NNJdxp+x3/Lsr1YxK3S6n+w82tH9EIlWJmMXNNIe
	OMX1ydWnspCKvKxSeuzuGpW7/TPeFmknR8ZMmeBjgaM1YAYrQJh7U7jBK2GDJzPj9kk=
X-Gm-Gg: ASbGncsbFDUfMi3zYay0wlW3w4sWzrQHfxWVfHPtODMzODXO117+jqrOdISByPaMZXB
	9yqb+/bPRjwy8YdzOOcRgzGXAs0pU+muL1FyQ0ELDBtS8q4gHlT0UC4f43PRQ53o6HkuSJFBnUV
	zZqTVXqs8YIhZpPwHTmTtuElxyZm8f2w7wI81y5UOTI25SFXQ0UCAiVvUHLbSAZ1efbjtAFIjaz
	yHGHZC7I809kdYzSJKWhrnNjj5y3sOLfs0p1MoRkOhw8ANcmXVqKYQJPMnJbrzT++nYFWqOG5AZ
	yJimsq/kGRPHxeHC68Bc/4me1kJk0n7OHtr5LiGxXsAVyo36GA2H1I10mWtlN+LI2WhcBoHCcDH
	tmVT3WBTMhmu52ikexkDSA5RBV6lWFFUsqjvRwEGcoFIq30m85+h0dfp4X6pbow+GnI6iXVr5eo
	YXMibyBpv5VeX1QvwqP9Fw
X-Google-Smtp-Source: AGHT+IGpJ8usQHZBgC7OYhA0eA7SADFYgG3LCPRSw8LpYHx5BaMGo7SkXhMDK7PnACMPoFZSd07w2w==
X-Received: by 2002:a05:6402:27d3:b0:640:9eb3:3683 with SMTP id 4fb4d7f45d1cf-6409eb34460mr3916536a12.1.1762183596687;
        Mon, 03 Nov 2025 07:26:36 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438b05sm9728264a12.27.2025.11.03.07.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:26:36 -0800 (PST)
Message-ID: <30f56029-49ef-4a74-97c9-9ee2ea0495be@linaro.org>
Date: Mon, 3 Nov 2025 16:26:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] reset: handle RESET_GPIO better to provide the
 fallback
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <874irz3e8m.wl-kuninori.morimoto.gx@renesas.com>
 <61c8e3fc-af35-432f-9bb9-300c953819e4@linaro.org> <aQjJTQK6Dgsx63YT@shikoro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aQjJTQK6Dgsx63YT@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2025 16:25, Wolfram Sang wrote:
> 
>> Started to work? So was it broken? By what?
> 
> I explained all this in the RFC version of the patch which was linked in
> the cover letter of this series.
> 

Should be explained here. That's the reason why you are doing change.
The most important information.

Best regards,
Krzysztof

