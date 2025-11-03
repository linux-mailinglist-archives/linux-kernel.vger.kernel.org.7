Return-Path: <linux-kernel+bounces-883182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A492C2CD71
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1984422356
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966131618C;
	Mon,  3 Nov 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0z4+U20"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F9315793
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182529; cv=none; b=G2uO9T8lDnjYSXfYRilx+G+3ionicIU3dS8PppHWVFQ0Qf/7FgWCd8oqj8h1eEbu8nJIzLBOg2aNhpj9AtJ81/u3++Jhb/cGf50f8xW26a6nYynHX5Czo5V7PHbkyvn9kkSOjAZ6PnbVhN0PHg2/C4UkNcN+tpRjn8jaqjzfCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182529; c=relaxed/simple;
	bh=6WUxV/Y3QF9G9L0fnxB34hjYzjxWTRTiCavgyeY+AdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLyawuVXEf1R2MXIcuUBiq/N4BS4eaQVZWYZnCNFAKU3irqyohLsLMshMnakUkW5dA30aQdso4X7Dz0ywkdQR6V/CtV/YtNLGY062j6LAlckUqnm6OP4CMhyLyaen4kVBwVS6N5izIZ3cFKLq8sWEE67RRuLiFP1ocfyUzit7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0z4+U20; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70acf7fa58so14488366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182525; x=1762787325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s/jZqQix9VRtxtKfMuzIZFEmI4hpkeByCEuHM+D7e5k=;
        b=w0z4+U20X4Pp5JPjzEcw+/+Csb+98MMGuU4iOERdylADBdrUCEYTU78eFZB21ozBiw
         U9TjcZgAqY43CGulHP9psG9Ffwfp+MctWl1WtMfeHtN1mcSY7qNrOsCRdfwbZeGjOOcb
         IVt1nOcN3QRIdP5BlOv8P7depf2k4a/jH/potr+1Nob7gSA6OPZ7kr7OF4ihBlLXOesm
         Skx7uEMYKgktEburKPjzuSBTFPznjK0tkc2EOis9hXn4W4fsJvUx2Vt+dVjH0XTHFxUZ
         ZK+1RPxQOukgFtNtoge3qewb8GqREnSLkuYxnz1stLlOOZGSWzlnRA7fa+C/Ra6HDSq0
         +jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182525; x=1762787325;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/jZqQix9VRtxtKfMuzIZFEmI4hpkeByCEuHM+D7e5k=;
        b=V4pz1CjHzrov+bpxIFHQXiQ8EYON5wSBQkeXzBR6s74NIuGABujst+2F2n8eKJsWVI
         MXP/0eUeDBgmfMxxBoa8K3/dgrkX8Tugnt69J4kbR9+wPAIIKWLiOwAAkXSfIcTBAFs6
         17yO9D48L5SatC59N0e+qNLeZTKv5PIVBeamu05G+KH52IKZ7AbHxSDQor/sDEg6tWvo
         Wx7xYx8qK9+hLA4aWmNfh85zznCKP7IYX74suXduiqSmYy/YbAdwbz29UR6jRgEZSc3e
         qbYaUaMt1kSGlvFltWKFXWAjCW0cynp9LV0cIYKD8PfNCdz/DCJyqDiQU4EgiWLaP4tp
         OijA==
X-Forwarded-Encrypted: i=1; AJvYcCWh+9hC814L4zs5jK2Tx3IBELNpP9lnxhjPkYFMbusL3kFysRKTZhndozNC9lyfO0Z2yWMjDfKWa6P5FQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaJtnzxwtH3M+NGFMAD7PsCAq9Yk6db+7sW2d5zF9N+2XG7Ys
	mHpSnKDseHrFAExUPBd6FAYv/as1W1HeFBTIoeDmn42JB/oGnhNvwcv+JrlLMFE4UKDQoMfKryU
	zlGNy
X-Gm-Gg: ASbGncvS3XSU+oIg0Ef1ufAI3fokc+NS4JLEuyoP/Y7Ntd1VmRBHzVeJVKLCmSKBe7/
	SL9ctz4eeMJv+u6V3Llgxm+RpjubiQEbjyq6irTSQrczj9JBusPIUqxvrdPp9fXDUY5ybvAHxhd
	tJvy3rn9wy/MgFaGtB15NAQPnns5Ya4p1E2f1sAZ2UG7z3oHPDJ5C/d5Ph1TsrzRngYIKjzWqmD
	/J2uMOnjO5MEl8PvW262G6tf4wtxz6yuaNH+AyY7dIN7atXBeZ2qGGg08/BAC8+jbl2QR1TOg+D
	n4OtDFCbqAhTUhMNc6sfiY9ZBkrYQthp3brtYG1z1m0i5o2xC9L7jMEOdT4qcvMvg9UB5qrwnn9
	cxW3P3PNLcvW+KNua7jVBvtFKGklXwBOZGXOXVH8fdUynCbd0PWtqoi/K2aVm2Q5xO7w+aj6wXU
	rwnaYUEM4uWr82G7aJIXZt
X-Google-Smtp-Source: AGHT+IGb+RwPOBqL429ahEH9nMmdkpa19V3x0i1lFs7UcNKotOpEosqy1DxPBQaT7+8mqvq+PFnokQ==
X-Received: by 2002:a17:906:e17:b0:b70:e685:5ac8 with SMTP id a640c23a62f3a-b70e68592a2mr154033066b.3.1762182525238;
        Mon, 03 Nov 2025 07:08:45 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70acf84c51sm542320566b.30.2025.11.03.07.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:08:44 -0800 (PST)
Message-ID: <61c8e3fc-af35-432f-9bb9-300c953819e4@linaro.org>
Date: Mon, 3 Nov 2025 16:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] reset: handle RESET_GPIO better to provide the
 fallback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <874irz3e8m.wl-kuninori.morimoto.gx@renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <874irz3e8m.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2025 02:02, Kuninori Morimoto wrote:
> 
> Hi Wolfram
> 
>> After the discussion[1] (Thanks, Philipp!), here is the updated series.
>> Details are in the commit messages. Please let me know what you think.
> 
> Thank you for your help !!
> My board started works again (without .config manual update !)
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Started to work? So was it broken? By what?

This driver was always OPTIONAL, was never meant to be required and
there was no code which was converted to usage of this driver.

I have doubts how this was tested - what exactly problem is being here
solved (except breaking all possible platforms by making this
non-bisectable...).

Best regards,
Krzysztof

