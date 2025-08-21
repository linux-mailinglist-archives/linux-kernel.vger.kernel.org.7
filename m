Return-Path: <linux-kernel+bounces-779211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BD6B2F07E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70342AA2233
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92262EA148;
	Thu, 21 Aug 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVm3ZGwf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D11CCEE0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763426; cv=none; b=h9pswrceHJnVNrt4g4nQOUwbWL+ASqloxGaBa+0jUSx4ukb5xc2s59ONp9TEUMOyKRcjlryYwl4mzEizaEDKNlg/5PdrztWCgPVOaAJ0J93r72nuDtFJurMkRJbKBNyqpARhXiN/O8goUMpj8lUggEt45dgdxtPJcSf5gX2dQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763426; c=relaxed/simple;
	bh=C/eiv5q+ImrialkjcooHtCZD+FBwZF7ossUvqO8kMwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9tq64gzrNq+IoR4EdbyPEvNPeNAwk5NkJNJyEotiJpG8t2m7UbJYR5xgtFh471J0D4w6Yis+T65wF4iuI5yr14aBz25J5mgfYuSBSbq0KutNDadOxYNsjz7YiBCAEP1aO1jn1B/jLliz56LS2DO57xPxQyRRk8rA7uVKxhFRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVm3ZGwf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so5033305e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755763418; x=1756368218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPIf2eULCAMXs3+uk1dB1VPHgpKeONu4TT2vxqp0Ehw=;
        b=oVm3ZGwfH2EAw/ZOApEKvUD5EBU/NfD9oPCdilVtU6QRlyvQ8g03tTZhbqlWUPjde0
         WVFrfcRN+2fskFysG9SsjbXupb5zfzc4dleW5g5o9ZLZ9Bt48fqEhIAHhfpmHjv3RL+E
         cxxyI37fFQkXIRB+wrGNXhcACTIEiAEvLa+rbkLwtyjZX95RY72L8vqKNypNkA/+jPYC
         +9CtwcAPo3etREKHKtQHDnNFdykUGiK7SkP5+90I0rMPPqj7zms8SLgtY7K+Hab3tCo8
         eusa0CsxAHmQee6LhvR7/N2Wu01DUP6Vs4DqHGBjnlMeSBDOiz1ioIcuXHmrIcgmZYKq
         ppVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763418; x=1756368218;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPIf2eULCAMXs3+uk1dB1VPHgpKeONu4TT2vxqp0Ehw=;
        b=Ho6n756YEoSJSMgqSMUQG8AzPBoYUpX4NowRM4oVY+4lvcNIoVwDtVy1Yi0tmorY3L
         GFbQpdzU5b3THGw9snvLpLO4CSso42bCMM0mZ+Di3+7wQ3xQfDLaMNnqbHnCHpCN2AMu
         gtGkpwndu1zC/x+lr+z+9fUa3I7RbbvkVl2HXeKasVMW5iN3rB6iEkkMYrf48vcWQ0DR
         h6ugE5gcaS9ODPEtd0JjHfiPFAWBMdxndEr0gl0F5MVKViqRZYkU+suOUuhjHNHRmbC7
         7pCgy00Bz3CCbzisMCzRr+cTQZMTYX7Rgs/4OH/ddVexmdnmZ1I6IfBHvLpDNbVglnbM
         nGbA==
X-Forwarded-Encrypted: i=1; AJvYcCWGDjyM2Fuiy0hspkq6nj+xz6hbwgzzesTYS/fj5lVaYvEDXjUVMKcvrJSP32UeUNAbAFbhUepVd2YIzdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTcy7QChgkaqhZPw2mt2xmSmfXbNplAMN4oqPN883hxj4sCBi
	GIKjsRDTtkf8dy6ZkCzdfF4IebTt6qeJq7mbFjiGc2ijasOR0exyDNWxpTN7kY0QE9c=
X-Gm-Gg: ASbGncvkxUwQJDfXV1umIcqb968K9rQCnuqM2sgzNp1AmuiXZxOnGDlfuCgnIP2/f9q
	GGKflXNk9FUZNTLtBR4XrPBIIX3sdwDWAP+v3yQG7pxJNnAOvpjdzKZ+5+zc5f8WMNfuIhWY5I9
	jivD/yErttXLmK1nTu2s4oq96iv5MkCc82FM4JQsOA9aXBjmhEuZXWqunioGDUoSLjhzOEfX6mi
	JsJxDjr+xAV/GyVTtOZefiTIPxyikxGWnWuYfVcQ9UePbpwSILpn7afzN4vxMrg+C7QZDh++jgQ
	0dz2pMN8DIUAL5S58rl7Usv1Bxn/luTLsAOva6+P2vurj/ebqKg+obSycqc8q6Zk53QgU3FYYvd
	EmSi8HrAlQajIbpcLGBhy+CAdMyJui3ehILWz08AnCXsS1FLwpmEnpJuQAIUa+uBM6Sn2toDJBg
	==
X-Google-Smtp-Source: AGHT+IEHomoTcPzi3SYTo69eEu7KMiWuzYDZb7aLDP3qy0VA1T5c3IbeWt2cpIvR/iXXdxI0Ai4RWg==
X-Received: by 2002:a05:600c:3b85:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-45b4d7e8238mr11688465e9.11.1755763418103;
        Thu, 21 Aug 2025 01:03:38 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a12sm10376095f8f.34.2025.08.21.01.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:03:37 -0700 (PDT)
Message-ID: <95ffeb62-0a48-4d64-b6c5-e6b4ee932e5a@linaro.org>
Date: Thu, 21 Aug 2025 09:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/26] media: iris: Report unreleased PERSIST buffers
 on session close
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250820-iris-video-encoder-v3-0-80ab0ba58b3d@quicinc.com>
 <20250820-iris-video-encoder-v3-2-80ab0ba58b3d@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820-iris-video-encoder-v3-2-80ab0ba58b3d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 10:07, Dikshita Agarwal wrote:
> Add error reporting for unreleased PERSIST internal buffers in
> iris_check_num_queued_internal_buffers(). This ensures all buffer types
> are checked and logged if not freed during session close, helping to
> detect memory leaks and improve driver robustness. No change to buffer
> lifecycle or allocation logic.
> 
> Fixes: d2abb1ff5a3c ("media: iris: Verify internal buffer release on close")
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Tested-by: Vikash Garodia <quic_vgarodia@quicinc.com> # X1E80100
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vidc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
> index cf150b32d6c2f9c7e1da7abfd5211fdfc469d96f..5fe7699c611583463231a60058d6960b6749edf5 100644
> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
> @@ -246,6 +246,14 @@ static void iris_check_num_queued_internal_buffers(struct iris_inst *inst, u32 p
>   			dev_err(inst->core->dev, "%d buffer of type %d not released",
>   				count, internal_buf_type[i]);
>   	}
> +
> +	buffers = &inst->buffers[BUF_PERSIST];
> +
> +	count = 0;
> +	list_for_each_entry_safe(buf, next, &buffers->list, list)
> +		count++;
> +	if (count)
> +		dev_err(inst->core->dev, "%d buffer of type BUF_PERSIST not released", count);
>   }
>   
>   int iris_close(struct file *filp)
> 

I don't think this change warrants a Fixes tag.

Other than that it seems reasonable.



