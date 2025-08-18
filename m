Return-Path: <linux-kernel+bounces-773433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9699B29FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065C27B557E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA95310648;
	Mon, 18 Aug 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKi7dEQj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E130FF22
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515014; cv=none; b=sHkjzPfiPOL09grIjbyxqwYY1GY/4f7dP9QrGRiv3zLcOBMHOZNRYpDiS9evmailJzTK4DovDeULsVMT6ZtdDvzxqbAhOgKOy3S6cOtA2voMOv9ni5J7gStiK014mLyE1ghLp2bdGJcQcbfauoRmWAOeLP3g2RgKc9vKSzdc8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515014; c=relaxed/simple;
	bh=4Vrnl54e8ENja3qpeQbW9kYQAacjBD4IHfjVX06fN1g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=edlX4KIetCA6PJKBBZXXSfzvbiOZTNbE6TtnXgdOeUfZRvfpOJ+GowWO7NIduJtMR4hTE6rozX2TWi4FN9AG46ojftU8yMEcM7Qa1ppqQqYw64tf970TGpa291bxDcXP2b5+cNw7fKQU57iYvopLt0XH2gFjcjHfhMZ8IwUE1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKi7dEQj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so22056095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755515010; x=1756119810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ua8O/1O5+5nB5qEW6QCnDHLWUhwcA6cIXBt4qTLsb0=;
        b=gKi7dEQjpn1YlC8zkQsd25Nx026YFeWVE/vuDPLB7uE47HAMF6RQYL0ieBFVB/Xsah
         dbnnJNH+JYTqvM0kZq8THRMmYBOFZilJ68/t4cde/vE6bzwupVMm8H6iZGJ6oIsa4fyk
         igMyb40lW2OFw+iaqxOgf4pba3asuC1JCfO6Aoy1hPDm70konwWs0le7HiLEDirrzuIs
         Cl5QdHLKM7Oj76Lko1Sov4u2Q4Ur5zdhMm/sMnjE4HYoUaEvpj8FTj+0Sk09x/8G4OXv
         ug6ksrYMFYZykmbeimDwKnPYg/pT/cgFJymQcL3mtw/MDywFC+sRc9kOmjZsbnRK+6Nu
         NuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515010; x=1756119810;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ua8O/1O5+5nB5qEW6QCnDHLWUhwcA6cIXBt4qTLsb0=;
        b=IdVeyM3YlP5WbRJmzgBZ+moG0Lco4KO7jHcxB6ngqJgkimTCBtJb6DpLhEs1B/eO7w
         baO73rmICszjJ2qHfO/OyTQN+hvnNXETu2eH7WLXgc2DTGrF1D31R2CbADEoNfVdcER4
         A8B8EO7l1GzmmzuQy4sPsTyn/i6nn9v7h4u2fO9AP+wvYrVpbsaS66K4Vsq4K1FWsd4W
         xXz7nHBEWITSxx6lV99xR8vXITLr/Ww+JZz+zusO9GtUNntzzWIiBlNR5QJu7TaPorvl
         lOYQvqsUOf9f52jDZQTal42pcM4TW6yPCyRL/h2jTgvvlr52R9oW9seFEMhPccwXRQGF
         AfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVUABCfVd7j+2gZFxFjVG5TVuQGxwp2/G9GKMz8TjOvV9KNlM4zi8x6yBLe8o/o6LNBXpG8SbVThRJoq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOqBgydF3e4rjoNab2sLROpdXJtSYHdnySl5FTYS+Qj38i+Cq
	9ebingAYCklSF+ivcAmRU7ydXL52onEhehGdmpGGQWzz4XCtFRfWnxcXmwkEKGSD7kM=
X-Gm-Gg: ASbGncvixOYw7XYSnU4F8SMT1AqaO7aLCD2YcrbEraEgsoAxageSJq+gUjmHZYcYnze
	6cvaNKeBwyCJ4gj+uIhAo/fKVkPtxnlXOxzGqkk1mAN2BhUp65/NI021U3PChrLfez76HrXPGAb
	VaBJFtfeM9gwXm8rWI/8GbNRzXouNTl8ZPx7O7/0CQiU+U7hswl+MVKtiHmmJYKMQ1Y0iShCL/2
	DR39iAiMve78ni4Br3xIevkiBeubrN4qrx2wBgKTD9n3qcpMC6zA4XNEtuQj2QOVWdFjzSPEdqm
	0xrbPDSu24QlLMQRKcXzndZufa92ml3ldJhKByD+AN1bjXuOyqg8wvTQ2o4Xh9lRMVuUf1iVqWi
	0cS45HFdVdZZ5qYCXIdbm5WH3gSbmibxKsH5lSTPjs7yPP/SNscPrZL4vWIYqJgM=
X-Google-Smtp-Source: AGHT+IHHmd37mBk/UuuFz6An0XBY9iz2o54JOg/oul5o+HNUvG1nx/R428eD2ETm/rl5tKc9uMFbhg==
X-Received: by 2002:a05:600c:444d:b0:459:e39e:e5a5 with SMTP id 5b1f17b1804b1-45a22345439mr84584705e9.5.1755515010400;
        Mon, 18 Aug 2025 04:03:30 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22210ab4sm129022355e9.3.2025.08.18.04.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:03:30 -0700 (PDT)
Message-ID: <8c2e9767-feef-4d1c-8100-d66eb1207016@linaro.org>
Date: Mon, 18 Aug 2025 12:03:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Fix firmware reference leak and unmap memory
 after load
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250818-iris-firmware-leak-v1-1-1e3f9b8d31ce@linaro.org>
 <61f9767f-ee4e-4f93-b84e-59ccd422c98f@linaro.org>
Content-Language: en-US
In-Reply-To: <61f9767f-ee4e-4f93-b84e-59ccd422c98f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/08/2025 12:01, Bryan O'Donoghue wrote:
> On 18/08/2025 10:50, Stephan Gerhold wrote:
>> +    ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> 
> You're not using the latched pas_id declared @ the top of this function.
> 
> With that fixed.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

No I'm wrong you've moved this to a separate function.

This patch is fine as-is.

---
bod

