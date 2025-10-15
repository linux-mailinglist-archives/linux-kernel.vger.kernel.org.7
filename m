Return-Path: <linux-kernel+bounces-854584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C49BDECAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B52F03561A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E072405E1;
	Wed, 15 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eas/vt6K"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72222A1C5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535742; cv=none; b=mBGxWnblGBOCboeYquzHU6r5gXEqP1SwoYEm6ZMzKtaPTve2GvchY4X0zTt6k4TbohVw4uu8jKD43fV9qw/KMBNe3xbFZ7dOHBnP8RmGIDr1Q6rR6jY9+j70TyXJ7AzwZqyWosMguWog3DFPTQ3CfwmB/FjD3FPd+2qArllGG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535742; c=relaxed/simple;
	bh=8ZEjVMazAtWAvqIzRKTRefBLcLx91zYhhGw4XMuX0xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu+/VYPO1RoLz6MDb/pOoIn1vG/RKOjR1c77Kx53lRIgdu3CXYP2FPnRD5fRAIWQdCNWpEX0k8lieCN0w7X0XpPTcDdv/5M0S/RxXBmqEEZO5P3y/dcZsQYQ6g1MSrhQYKYI5hzseRogwmuYPkTSC2HLJIXMlYr+eRr+DhhZPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eas/vt6K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e52279279so47784755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760535738; x=1761140538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hy7Sxq2jeauDwIsq3RFiUz3/9uTUpwLAUFOHgM+Hwug=;
        b=Eas/vt6K5AVEUAc8QjbYHcLtShNnek0UkPwINwdPX3okqHlzvyTuFgq6Mz5eYVIXZ2
         qhf9Dj5UoeUqcRo/foGQ9iFXkhVNjOXvu93tjZXWTgOlCJkECsJIdWHoKdNkz/bA4F4G
         kVVxw1HaXB9qjrWzJb7LyH0lKNw1QxIw1A71R4JmXcBkym/ZQlU3cdB/S5jb1zIgNXcC
         GgXYFjZ5NRp/EFhFID+ApfdduF9MLcxW5xeHoXFjJyqPbVyPu9K7iHKLt66pIeFk4/xD
         ghNyp0T1aVJhlf6BBDL2fwuIrRycYGM159km9+fFjbaeoNmXvRdf17iEorGMlfjXdUnE
         UBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760535738; x=1761140538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy7Sxq2jeauDwIsq3RFiUz3/9uTUpwLAUFOHgM+Hwug=;
        b=u8HnYF1U3U7RlF9pC2Sjt56WKwKMXSL+vFhBgpZaJ5rfEWZCpnz3TKslODpsWCKdAz
         AomrT+5kzpXN3Y5ookkNsvibLYfeTxGOoEWJQj+K1Ugfu/hz4nmPAHecoe20pI7IeKY6
         Bb7jD4YmmNulOijBkFP3IfqnBO2Xch4+iPglFKsGGOhz3/yGp4zXvLFtQ9Cpu6zItiyt
         Unzik+TUxczq26pa41Ib8gih0ulK+sAEPZdE6G+Q82u5nIBC/HjSHhGn7hQbv7uPKKr3
         eKTLDxya0ZqBYBEVaJbUi6fbujVhkcIcrJmkMci2X0kCcu8a54+OQgopT1ykXMMmoM5+
         iFZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wwzDyRFNXfvm/FMSU4ncwK07rCtqNDy1GXK+Prbyn43wlj98ekkZwXEdzfSZ8mrCG0QTvkaz4id6KIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKoGZmmAxcN+JaeR2EEilNF0n/F0HMQfSzsMBE1MoNPCzSeRu2
	r6Fn+x0UNtbVDlK5MEKLF05naA+GeprNps7PDsVESmxPNW+vk9bzhfl9L/6eklpoydE=
X-Gm-Gg: ASbGncvFh7D1A6D6k210IlvZzZH3nRBgPSV+FsT/fslFPcR4v6uR65Q+1PI9zNoiVJj
	NIgow6JA6itRPRbsVsDQ0VBN2Tc3ScjLqBqtgW6oIICvoMS2BZ25iGqsJasC60KyqmdksBs36ko
	fydVWxn9kBvej5BwOGaBI0G/yScX6MRYTQ1nrAzmEskQaxWAwaWpVJyULX6lH39VIjYQZUXqiCJ
	Mw4eW9ziGIis5/qrf52/agt9IUc8tLZVCfyARL+H6a2Pdi3103Titwa6XhtuaubLmYBjk2sh62Q
	9H8hGMw3EXr9td0mwWOm0yhOhyEYHYr8rePRATeL/lxfrczpkFjdUhLD48KXgXyWxW4IcBoXl5b
	CXyrlziQdtRr5nlVuVzZvM64D/yqMcS46wK7nnXs1ngKZe14K/hEFZUQCQA6NowgQSbnDL/9zKm
	4rx3u8ScJs2/w=
X-Google-Smtp-Source: AGHT+IGNyrbP28TPNxoPwZO9FwODuDXd4rA8MhI1zvCQw4TzwS02DCNbsFRGuJzAypYvXf9n3XAkEA==
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr193578825e9.25.1760535738467;
        Wed, 15 Oct 2025 06:42:18 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583335sm28846561f8f.18.2025.10.15.06.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 06:42:18 -0700 (PDT)
Message-ID: <84f17b74-a3ea-46bd-a6d4-efa79c1cb43a@linaro.org>
Date: Wed, 15 Oct 2025 14:42:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: qcs8300: Add CCI definitions
To: Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 quic_nihalkum@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ravi Shankar <quic_rshankar@quicinc.com>,
 Vishal Verma <quic_vishverm@quicinc.com>
References: <20251015131303.2797800-1-quic_vikramsa@quicinc.com>
 <20251015131303.2797800-3-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015131303.2797800-3-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 14:13, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> Qualcomm QCS8300 SoC contains 3 Camera Control Interface (CCI). Compared
> to lemans, the key difference is in SDA/SCL GPIO assignments and number
> of CCIs.

Codename should be "Lemans" and since you need to update the commit log 
for this it should be "three Camera Control .."

Assuming thats fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

