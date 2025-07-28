Return-Path: <linux-kernel+bounces-748137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7EB13CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330457A46D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C426D4CF;
	Mon, 28 Jul 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZcDYfv2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD268248F4B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712157; cv=none; b=RYxa2R3HPuAAgbQ7GgdHQrIz2qzLNaAEnjwKZkmAe+aAPU40gAt+DZ60lyIjr5su0PLCoR+/4A8hU8tjuOpctFmWsw1WmCpiPHQGZ8XbzoGW8F2fbZn1WARpKhlJfGPJ7UGzR7wSQ0qn4Dv0ZkOABc+SpveCw6WFeDysaZkS+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712157; c=relaxed/simple;
	bh=jBvO+LGBhqE/ZtUi1WtCmXwaYi2oY/wR656ALdWYXLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLqd+YjPEQ9dDU10vFhs76YCf2Pvv8B3EGPVvWWjs1ii0LehA64qDncbSFGBGK24cnKWxpXSBvhmn65fX58QNQA1RyS/+e1TMpxWFPGR2fL6H2060IR0qLztEoyKxE4eWIft722TL1ZUpvASF3Kkg64k7WpXphKV7SIPXiBFgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZcDYfv2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61539e2065dso1711003a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753712154; x=1754316954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEuv/0OvcRGSMGgwve29GQ++Tx/D6BPMSmiHsxXgsyA=;
        b=uZcDYfv27Ljxwu17Bw3FiP0sF5BjqFvDTNy6rm49vj6002/fsukH2qLjiRG4PzMJzG
         Pw6Et/OHsa7Q3GlpBgcC4lyW9iennXdB/C02pAoSKqGWI4ADTuy/pRe2+U1eBcXbJPER
         LVxOGO5sY5DU6O9QHXu+wVGaOsvKizgmppB8+kbi5QAcorsbHZT3Im+yYEPOXTWkOS12
         J+f60FGNTaagGpdLCnWUu3Dgg50Fz+9R5F2r4nPLKJKOR+xO3vyp94HEDoWOauojbQT4
         OThBp98FRd/DIBeVwaBaaFn76Gaw+tVAqhm8hfr1JhR0mBfyK/cb/29ZF9s6d8UOYxvg
         bGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712154; x=1754316954;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEuv/0OvcRGSMGgwve29GQ++Tx/D6BPMSmiHsxXgsyA=;
        b=vyeZVYYOCJusyRzYoE5WJBu8rQLG6IQdSqZcl6aBLZBGOvIt9kJFQLhhbOmTO0vs8I
         2IKkcRno2MhXrOtSEHH/Vkbbx1FPzu/e4+eWCEEsZlbwfdHQuEimujpY2O9EcA8Gz//h
         kHgfrFHuFaW9RsDopSsmi4rK8Tjp29GZxazK7amKh2tZ59wHHRsu+RVYvjhQ+/5Ydwce
         NgqDsEITanV0dfKeNN5uabx0q068SQc93rCltkiyaLSoECa0vYK91suPN1ko1elRIA+X
         DGmqGhOYzfOtrNI/D90CIOOaIOoJh7eTtTLDaSn4FMviN+MoHG8CmXUa62KltKEjj/Hq
         yyHg==
X-Forwarded-Encrypted: i=1; AJvYcCU51gQkAnmsrc/wbN6sKpvib8kYqn0pzq7asgADBjmiUWSlbyhlPqjxJfvuZK4mnhhzcEWTJZwt3Ot2rUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vHcuKNGHHKOlfNU5RoyMFwMN6/aa6LddL1Sy/9e+piEVczIe
	m57xlX624hIxObnde6IfNoM7qtNKXcd6qV9J6iZLDDPROgBA/Zo3tHV4m42C5Y8FdSo=
X-Gm-Gg: ASbGncuA6r7dj9LwIMFuw14+vy+s0MHDMXc5oDUWPINMssjLCz9RIKiBSWWB4pg/Yb5
	b1Ks75uPQOJiFCBLmCzkWRl7wc6LemroIvrAId+4uyZfHYS7KmZvDeeaO8VryyL7BlQHBEqx/Oe
	2fTDBWhWIE7RNIq+kLa6nG5WsWM/O41LwRkvhU5PYl0ODCEzBSSYdMwpiRXMUBz77c3a29bANjo
	PcDpB2POat3uG3Xmm92vIBKzUx39pyZZiAI0QJg51brZXK+FjOEUA288qTdqDB+0NKahNp5WdO5
	dTFNoGufANo69w3m8B4TZi3MNTyNPemovZi61h6Ylm8EIGthjPaoKu7YSY1KFbpEfcZgdGL2JGy
	kXrxgLIWW19E+H8KAcM/WKUbKsWV2Z5edDviiwOIlYOY2eC2CjYh4hcv1DqiU5EnMeoJ5sPpgyA
	==
X-Google-Smtp-Source: AGHT+IEbup0WGzQKdd/SdReGqdXO/wPA2vfo/bvQOhQ0kc3j2Opi6K31loxxw0o1vQUzbFcAu0y+0A==
X-Received: by 2002:a17:907:7216:b0:af4:20f2:2dcb with SMTP id a640c23a62f3a-af4c242b969mr1664623966b.9.1753712153796;
        Mon, 28 Jul 2025 07:15:53 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589c8ffsm419726066b.34.2025.07.28.07.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:15:53 -0700 (PDT)
Message-ID: <48d78f51-c094-46b4-a9af-91a9d855e296@linaro.org>
Date: Mon, 28 Jul 2025 15:15:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] media: qcom: camss: Add support for CSIPHY QCS8300
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711131134.215382-1-quic_vikramsa@quicinc.com>
 <20250711131134.215382-7-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250711131134.215382-7-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2025 14:11, Vikram Sharma wrote:
> Add support for CSIPHY found on QCS8300.
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>

Give the commit log a bit of love here.

Please add more text.

---
bod

