Return-Path: <linux-kernel+bounces-862736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E23BF6052
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38CCA4E61A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E432C33E;
	Tue, 21 Oct 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRNc9TcY"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34732B985
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046074; cv=none; b=M2SVjWpFqUWZamU5F9X1Bmu3h/BUBXVz4iXI/RkrF+cIAfQ3ckCt3W/XygNb8EUzYizHb5cmi+PwcXysRT1YGz7QO+u8nqe6Seqpftsw5sXN7GhSkBbyomDUV6P3T3J6jmS/jfzqYevODg8JsDE021kiGYsfGJxDk8wsCEwdJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046074; c=relaxed/simple;
	bh=XwK3B4eFqi6bqCPYWqhOCbr8BhBcCJQPVuxdp+E6HLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaQNNveZi1V83oeRxiEmG1FcTCO9OL3O9T6LFiMvCDIYgTNRRPCb3PLVzkN01ER5+iuVul4cOrvsJp4gIqIJ44rPtJgEdrlT5fiSt3g7TgC8+awKtDf1DD+RsoabRxh/0/O9hncam72kc/748tb3AspezfFfZ13i2iIj62PmLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dRNc9TcY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ece1102998so4681484f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761046071; x=1761650871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sFpzlVevSmJgUzGev8ONEttz1Yf2GX70+x9wdfvUro=;
        b=dRNc9TcYSN8QzpABLT503/Wn3fgyLWxoIX/Lx0HzWXV6cLmvM08qk1us94Qr3gatuO
         l6lJQJsrmEtfmVRJYryYAJqdXa0gS0lTip0UfJw7//Tcf/A9ykBQyySakyDSZ7XH1qfR
         duu1tNMLzTbqY9zEGLI662ZuFlX/s9fPnE+KJbOG5Gx7T6NKW5wiyNxBXtZWil50V9Qn
         RtwsneBImVBWt0FBYWUbrset6K33+RFlvlJAFzcgRpVDH7zQdFZwd0D7slg8wAL+Klng
         s+KI/0bH2ERsz1awpgOs52b5Wvz8dLSmzPzwNYSBbaxSHxqIm1rP6bMNT+U3xtjYVNXg
         WCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046071; x=1761650871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sFpzlVevSmJgUzGev8ONEttz1Yf2GX70+x9wdfvUro=;
        b=tEiA1LB8JA1VCPsK9SYC2kfRDb1CGl2Ftg3MR5wBt+GmzLbmlaU0L42Z9S5BQPe1xF
         OK2U/wOdKADGF0zVR51a4C1iNxQOoqbcTaU3GPrZCAIXVqOi6kSjnKDj7m1OspDWQNrN
         ZPQR3NGNgub5GUibUlRYuoGnn1OBupezZAWwelKuQETY8TsCDclzOmEWeuZT+nO/ZQec
         0izXEwijAOu7LQMXvPWwh7SzmPPWSA//U9G9WkxRDTIDGOLggv4O9DIdGQlY2eTAYVCI
         oKw+1yyRM1Em/6lB7R2MaJJ0rKe+Ins+o0zi2evqsWbSZDnaIclqx8yP6bIC9yGUWdcB
         r/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWUwrS+1Svrw5SR0aSgOMIzWmRtjr6MzO6HDgT7OgBV806qbU0i7r5H5kl4Oz7B2Zacln1KUId4B8/ZQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLaT7pjBjg9bI45fUVpCnbdc4pCuh4dwRL3IgWcfU1Lrc1baV
	PQlLwLjz90w8RhxDnnwC8JrtantoHVgmO2V3JMpFe+KM7oIfaa68DLHQDvVAG+coCXA=
X-Gm-Gg: ASbGnctPGuSaUHtkwSz1XXPWF3HxSothwpA0rd4D0fblUyvhMRvRXDdgo6c8CgO4ABb
	nBnfnUSWbV2P8bBezC3q8n9TI8Eb1MERey3g4YiE7hFqWyc+FWKZPr1xYf8NMxbqyD3GaB/RLsg
	1+lgXFsFj2fuE5L4dOpRgqpJM6QqjNqySF82rSxJRhaqKTjGJt3AAmutcZe9NXrE2AHMXbzcSE1
	V3oWbYUpZvQUjcfurlan2c9slRP9zJcJC24aqQ3rChhNXkSYNe71VKiRGNO/YDT2hLFdZ6JAN8I
	KDojeQskzAeH20/w7d9SsctKJL9vU0AujHTzW8IJGvfpllhrtTKpS5DTln3umxS45P+8LId92Us
	P6ARewaV63nH9FfB2EB7xLaj/zQjRTg7TMnCkz1YrKvF4hYbe8ySIo1Japw/sB54EWvtut3sJNI
	Vjcm6IuWqnEnYbDTOBjCnzftxJIIiRscCBKT4AJib5xGM+OKpMcJkPkgVYqESkoCRm
X-Google-Smtp-Source: AGHT+IGV/ABVqWV8MsAww0waMr7MTa0bjI7NdLpLREyhUO0GVPuR0EgaD4ahBwL15tOIyvx1SltTMA==
X-Received: by 2002:a05:6000:400e:b0:427:9d7:8720 with SMTP id ffacd0b85a97d-42709d78893mr9365897f8f.24.1761046070736;
        Tue, 21 Oct 2025 04:27:50 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce178sm19861570f8f.46.2025.10.21.04.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 04:27:50 -0700 (PDT)
Message-ID: <c80e6d85-e1a7-4b04-9e84-7f0cf1a983b8@linaro.org>
Date: Tue, 21 Oct 2025 12:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: qcom: iris: Add sanity check for stop streaming
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
 quic_renjiang@quicinc.com
References: <akmAGosBEsOFS3HpzbJdYH2z103MndEu9B6T4EBnkbPiuBpzCzjn8LtnVr-lJ0PHOqR0jYiIXbnPTwJR0B3L0g==@protonmail.internalid>
 <20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2025 09:15, Wangao Wang wrote:
> Add sanity check in iris_vb2_stop_streaming. If inst->state is
> already IRIS_INST_ERROR, we should skip the stream_off operation
> because it would still send packets to the firmware.
> 
> In iris_vdec_kill_session, inst->state is set to IRIS_INST_ERROR
> and session_close is executed, which will kfree(inst_hfi_gen2->packet).
> If stop_streaming is called afterward, it will cause a crash.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Requires a Fixes: tag

Then add

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

