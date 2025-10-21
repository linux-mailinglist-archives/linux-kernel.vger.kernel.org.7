Return-Path: <linux-kernel+bounces-863065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE0BF6E96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDBA19A0D76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6093396E5;
	Tue, 21 Oct 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hs1OoVm4"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E71338935
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054905; cv=none; b=ZXw0BhnuEM7gk/ugDs8Vhlw4dlcBgd2W7BjsCesDnrMcKMEoeXDBhsTPUtKP9Uhk8JNJswzEuK0cdZ5errH0SCRdZpOJ7EhJl0RSXsL5m1hZ5bzO54Dj1ZdyFNblhIpqErTYkrz1PReL3jhzX/+++1BEJGidhSFwi8Oh6ehicks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054905; c=relaxed/simple;
	bh=dtENIpP2ymfiJq2a+uxczvxyLyuLM+4hnAglKE1I+no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jji90E23QJZ9ZRmT8V1uU7Wsv+NNTSq9+SlKidoJ6igsZqi1+NVqOmjj8VEqroFf+I8h+PGXMuus9rXBMNi+u7nBp4PE9iGH+a04XrfBqwVGr8Y55vuzeTqJoybw3yz9Pa+2MeIG0uOi0uuZBRXgM14rQLJ5KFJz0a4aXYkVa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hs1OoVm4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-781014f4e12so70063677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054903; x=1761659703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZkRqgQmvQUxe0HkH7YLcOV5VrwBVz6cPfsq0k36X3M=;
        b=hs1OoVm4puVOTtiW5YZKgNbhd7ncj7IncEdJ5JkCRy2ciVfXlDyCAV5ogD0ch8ChhT
         FWIDdh8ZwsHEOpyRj/8cUBJClnR9wCE+WJiLUUZHHQfPBABgkxLIxzltzkL6EBHq8yxb
         r/LVZ2JHgzvbiUwRd9M3tzPjV9LkiDmrSYVem1EQBQ+JRvb7fDDWUAvgEccuTA31hYGe
         JpO9bModiWT1/Ca/uuIU9EdCSOfCZAnMucQVYwbVaCdK620HVzoEoDePL6im2E8WD7VP
         3PJnI1jNWpQOmgEM0tWumPq8RHTuczLWxBPT0u5UmGSGsLDW4ZhixaygkS80rWwjswyR
         nOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054903; x=1761659703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZkRqgQmvQUxe0HkH7YLcOV5VrwBVz6cPfsq0k36X3M=;
        b=mMkgl6kDvry7DT42sqWE0S1vMn2Vydu4nQ8U/mWV0VA0/MVHCeQXmM5TELzLa+K7EJ
         tjGGP94qGbzX6NR9gaVDFa02wVblcRwYWAVMCnpqEGnVj1QD3RQ9qXEOseZ4LZxicRU/
         0dzn2glNYlweXYZFfHf+vQ+GXdoi1f6qRvvUDsoFmnqh53GQWS+UKb5FBRKjaNzHlICX
         X7WNTU+C86N8qHWMl9rVII1rVAJlJ/zYnefchyjLWPPvbTD8KjhDoDo2Wy6bp9PAapg3
         rfQz+MprQQh7WvH8vwf6llEt9BxV2vDJBDCxQZHrlWPuc7hbGfO84+3uLArQtLPKGfti
         tB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6m0IEJpQxG8faJWl42a2BcNEC5vWsROnvHN6IWjGLr4B3HtP+qCLSRo+OtLO1JrXgE34Q9sGwexG0KAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5JtpPc7Oy/NQbe3bfVlGKMvZw1U6GYLkNRNT1j2BK8Nx10uF
	UjkzVDRudc+i1tci/oxng+HSzqlVS0dbp71Qu9flCRxm5B1xrf9SjkHAX13AYPDsObdh2HxgHck
	M+1qMRTQ4IGNVwiJe4nXVTY5xZomS3W1lhx3H3jvaFQ==
X-Gm-Gg: ASbGncuDDrxdzpYF3NSg8NU3mGB+EwEf5UIO1bsJRuZ0xpIRsn5lNZqn0YUZQ62r0iJ
	/GqxGLi69zpO/9uKQO9M+sHSE68Ma6WNggLW0smFzBQPKF05jduBvBdDa0Dfs78/WAXYqk+tcb9
	3Z+Esy1zYbPhUAi2YljCz3UeGY0LXWAmPSFUrW3hCsytvTICOnEYk7YW0XX8AIf5v2TsiUxiVmv
	1VcNiXOfs8YCGLMc33LmR77RTH/qA9cqrzbZ8TnOa8GcbgVZg9Y5r+IUWjeEYKsvlOmu6zY
X-Google-Smtp-Source: AGHT+IGwCSwvvGE3O6NbkG51mymMqSVErgL+88mCbcZ/Sh4giHy8+THUXBi9OuVSQ8LD5w3yhlK7YcdBM0SL+BQqwY4=
X-Received: by 2002:a05:690e:134e:b0:63e:3296:8886 with SMTP id
 956f58d0204a3-63e3297a274mr6263197d50.42.1761054902681; Tue, 21 Oct 2025
 06:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 15:54:26 +0200
X-Gm-Features: AS18NWBHdAFp1mwITr0UmXnrlHznqrsFfmK4pqdcEpQD90Zx_dU1-YGQ61Q86vs
Message-ID: <CAPDyKFofohpEDcowp-MwtJqKu4wN4qvXz+BKOG6=8jhWS_k-PA@mail.gmail.com>
Subject: Re: [PATCH 0/3] power: qcom,rpmpd: Add support for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 01:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> Add rpmpd support for Kaannapali Platform including RPMh power domains
> and new RPMh levels.
>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Jishnu Prakash (3):
>       dt-bindings: power: qcom,rpmpd: document the Kaanapali RPMh Power Domains
>       dt-bindings: power: qcom,rpmpd: add new RPMH levels
>       pmdomain: qcom: rpmhpd: Add RPMh power domain support for Kaanapali
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                     | 28 +++++++++++++++++++++-
>  include/dt-bindings/power/qcom,rpmhpd.h            |  3 +++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250922-knp-pd-f639194fd7c4
>
> Best regards,
> --
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>

