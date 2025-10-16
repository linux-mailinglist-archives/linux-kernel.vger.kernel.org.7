Return-Path: <linux-kernel+bounces-855797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5EBE25A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037B74F741A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40C30F556;
	Thu, 16 Oct 2025 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QIa1DI1f"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77630EF9D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606661; cv=none; b=oKgiiSBLFG1p/fudpXsx6PeDNeZXqzUiIFIZ1NWL6sohw1EH0EDnHgNcyJsRfM/IimouxccYURwJ4A1fqGgieUyPMi1pld1sYzrFkzl2VETztfUl7559oag/EOY+jFqI98Js+YpSU/VB/yw6EWRO0rOdEvaDoRnxkJnXiySQO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606661; c=relaxed/simple;
	bh=PPkKFnupn8q/AeA9zvdOdzxhpodro2Quuk6p4NvODlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRUkDkbCuJU7dXkEiYU7f0jktSLh6ME2yNKGBY0DNMj32O9ihE1km9cjsbmDPcdNxa7M2mCoY03ev9jIber0jtbbAQTSQbzWheh8ZqeF1OSraJ3xlGZ0dBRMpUFTPl+eLXJp2OAKM/O7zscwQz/5/EXSAR57nJzLPbCT/E9KW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QIa1DI1f; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 042263F730
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760606657;
	bh=Jj5YDavVXV4rN07jSdQ2E7BNofwSc+9mwEIbSMC3ewc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=QIa1DI1fMeVnd2KcwxR7BXS7lb9foo+N3zOiobSQuQPQwOE6pPRduKgSHm3AIirb7
	 oxdiK/JcPJ2soCGYabyDeSmhqlboYDPJXQFavWcS5K3H2VzQEiv6CGB5ZdV1QrJWXF
	 Md4X6Sf/qTxiZcWKlhq0nggjHJpcy+BZydVQ8YV+WiHZd4+WSWKBBc9Q8R6YKKLupk
	 J/A7FMifw6be9nyWIylG8s9TcK8/Fxp516b51oyHpP18ugrJXKX89H2/uVYOpTuD1G
	 J92dgWgGU4FQUmoJQn3wBJJY7eMFZ9uuv6u+4OIDPYkwRg2jCOKGJKr7JeQoJV5EgJ
	 JWOtnCZNCwve2RDj0HfDtq2HVmCJTCLKNq+Xv5E6A9xMickef9SM5EIXu0LuwoLp1I
	 LNkrUZvDeJCBQBOAlZIZRMYOujyWsdREFoc2H0Ma0usMp87ImbSP8lZiw+kW6h8Lvw
	 dth6gRGhYRubRJvfwdzHINzT08YJJkpwD39dnuhx6FegoEgq9q+jO5V9ZgHJUy39Gt
	 3t1sPU8obxlA4tGQHDK8rvmxD+0AJMDo96M1xYNgMenu1JxbnhQeBvHy9zSh3dDuzo
	 5rzlrhK26x5Of+m5pCs10lOhEjOP0qKQ0OnEoPqo6YUG1Xfg+eyjbrXTHqw/BwdkH2
	 GAkWgdEVXm546LsxilfwTvwM=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f63faso239298f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606655; x=1761211455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj5YDavVXV4rN07jSdQ2E7BNofwSc+9mwEIbSMC3ewc=;
        b=SEsr3aWwIa0kyg4jgDBMhtJyuIxuTkmmrhsaiS2dR5X7ueqKItncmpZg8CwSR+BPD6
         hRypECrlONuPrptd+wmOp2xEy0BT/Co+FjzH7rQ2p7i+qcUpZrBHkDt1unaBjzS/pJTf
         0dESXZtriZFmCYbkRbD/49TDTi1wZ48AGSrumqEcswSA2zAPEh9eq6lNiB1mC24PBbRJ
         j/KCYEVuraBm6cwGEI3v5BUJylo2hmxnBRPqSAyvTiU8vVBhfmHxlQnx/0htqZjdUkpD
         E+4tKg8pWO/1quKIT+YP2kpOUIjZscHWuMBXh+NewVsxVHAbRzPSlH7AqGrxe+SZHqgn
         tT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRoHEZZv3KSCm89kzTLWQhmoh5RwMjcS4NTJpJn96ELK59Ncd+9ZG4PUJnF1z3mMrFXkBWJuqk2rE8Xc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjI1Ukotfu12DF0sdqaCZPpB1Nb36Q05CTY1Hnpf6ce0kWVITg
	VE3aVgecr7TPGlg/sgNokmcCWFd9HtngB/SEq3sq+VaL4sd/kXTCrKs1/pweOHoSHUuFkSfsceh
	t/S6yOnett1k/+1s4rOTsSKQbKsPZ/rnR6Mv5pTdvkMwfbujLGnKyCpENt1mLNpRfe51T7x1iVB
	UxfX8cjw==
X-Gm-Gg: ASbGnctc2Wdhb/MToiL2EG1bPoKIUJ+KyOQLbAAwN9rpuIMCr6Ya0NXxoETicQLPEkj
	4tJLUZdYPPcVna57Jl8+T/WJR9GOgzA4Y+bV3uE2DfwxUK3VB3mEyIZLXXnmqpin21Jq1ebAxfw
	TqNJMnceUAdnlcaIBsBKqwhvUjMhdAMzI7Nrp0oYXxMWiGOFwgaObQbsx/V7h93808iQQlFvVwb
	L9/L1Ig819W7RtAI7Tk8Y879FZ6I0/FJAeBdmcR2PuGwPzwE9ijEjvTFVwi0FhjWbz5a3vjUbrA
	f2rxZ1LRTkxIbLCTEzW/QD+4AZ7zwe26n+OknqLU959HQuNlGFrJNQU3+FEG0NzjkbPYUELG7Rc
	8ubXemtp0NzZMkpjCSqw5B9s+YTXikQspOMKrMjP8WxQAKs8n0iUrkHcP1teUndKC9e9UCnV2
X-Received: by 2002:a05:6000:4305:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-42666ac2ce9mr21148693f8f.11.1760606654852;
        Thu, 16 Oct 2025 02:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcbBGP+l5exuqbqvAtjI14viHyp0QSM9sOIa9CsXS1ysxI1h4z19klvDWfmi0DQ1uixQfYDg==
X-Received: by 2002:a05:6000:4305:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-42666ac2ce9mr21148675f8f.11.1760606654414;
        Thu, 16 Oct 2025 02:24:14 -0700 (PDT)
Received: from [192.168.103.116] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cce5sm34412027f8f.1.2025.10.16.02.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:24:13 -0700 (PDT)
Message-ID: <64772268-54a1-4495-a901-bfd0e4b06f78@canonical.com>
Date: Thu, 16 Oct 2025 11:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
To: Hal Feng <hal.feng@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251016080054.12484-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 10:00, Hal Feng wrote:
> Add device tree bindings for the StarFive JH7110S SoC
> and the VisionFive 2 Lite board equipped with it.
> 
> JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigrade
> and up to 1.25GHz. Its CPU cores and peripherals are the same as
> those of the JH7110 SoC.
> 
> VisionFive 2 Lite boards have SD card version (default) and eMMC version,
> which are called "VisionFive 2 Lite" and "VisionFive 2 Lite eMMC"
> respectively.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   Documentation/devicetree/bindings/riscv/starfive.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> index 04510341a71e..797d9956b949 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -35,6 +35,12 @@ properties:
>                 - starfive,visionfive-2-v1.3b
>             - const: starfive,jh7110
>   
> +      - items:
> +          - enum:
> +              - starfive,visionfive-2-lite
> +              - starfive,visionfive-2-lite-emmc
> +          - const: starfive,jh7110s
> +
>   additionalProperties: true
>   
>   ...


