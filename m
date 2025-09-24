Return-Path: <linux-kernel+bounces-830605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF535B9A19D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B3E1B26691
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549CF14A9B;
	Wed, 24 Sep 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQmD9x2L"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD61E230E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721547; cv=none; b=ik9URGe2lXKOwhc3sU8sQKo6DuVXreVfJNUnd3H4HkP243vBMbhvkhGj8Dzxs1V7nfpzNMoqMOZRulOGSJy2PY/hxJyTIguVnJaFvoNolSetObP0EPmdBrQfe3R76SY6cqmAT2xdzZM7IVMEtu/scHfhv2LOy6gKS05y1MesTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721547; c=relaxed/simple;
	bh=cEMmzRzXMTGSJDBCpuLpTyfKNk+jAauBaEAZNhHggag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruLkKvH8U5CtmT1YRYBMNSqfWhLNPEkHnsMQh2V905C8DKiHBruAEnIlOZe4zY6kIe9MsEunMuDRUGfrHVDUEwO5S8JFC1CQx9XepyzuC0+SENreg011nl021T/UviwlOlJb8xFk5LEUcs9PwNTnU3ix73LP66pujm2M8LunfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQmD9x2L; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ef166e625aso3961891f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758721544; x=1759326344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Si08GYvs7O7On4M1lZPat5JwQiuJTzJsw49avbAJ8Uw=;
        b=xQmD9x2LZEsVtPUWs5Yq320mJSpW1sJzES4OT4lbexyG66ku8TgD5qDoyqKgvg8pZP
         nW3gk3pDp3mNpd4yKQ8/XbylSSvQRvTcGm5yj2w8GtXF002izmpjH9H40zo/mV64TkV8
         +ue5zcm2s2a64Sp73cvZaZIbww/GllGn4TZGY3l+ePmHM4x7/8gAbaDqXxoE6P9EtStY
         n5T7yWZVGBbeIq0hZQmXOdpohoLPt/09MqXvFLvkyzlhC9n9PVdG3biHh6UTW1TF9x4b
         NCghEWPa46JPNotZUgCUVrHWoEzzR0t5nxPCWswAAylPpUVcaFMk4otsDTCEoOSFCh7y
         hhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721544; x=1759326344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Si08GYvs7O7On4M1lZPat5JwQiuJTzJsw49avbAJ8Uw=;
        b=dOywp48kvJaCUbtYPWBLbysEV5W7p6gyXeTpfAawl3EFWZds9ttrXHzWMcZSGe10L9
         h9eaKSG5QvT+GiBXCLaB55wWBY9vSrDou2/d68vQrBFFYQYi1luYVcH94uCHVaENtw5U
         f0JNpuGaDiS4tnFolEJIAoUn90eVxD+Wi5EHqkrwH9SVuC5V0BvLiETPVLPAn2feLtuj
         dPMMP/JEvf0vbHTLMgTLDdnd4ZARoYAQeLKsW1Zn4CQMtfn2haGq9WpzAzb64cBU5zsp
         NQkeThRw2Cpxsj1cNSGvoN79tKPNo3KRoJmCchImLWZFNEw4fp+HDTi3x3P5vsWgxIH3
         OrtQ==
X-Gm-Message-State: AOJu0YzN2NEnXPTeM1sjXaEOZVrZDASmMylazMpfLDlkVAoTRv+C1itw
	281vIASCJcfWkqExKVBpsFBNyEM4mD4Pk0a2hj8PrE5pgni4oOHN5nkI0cUy05uRcpc=
X-Gm-Gg: ASbGnctRz7ccguEjujBA42wfyuWnRDqHbvBedCnv3dWVGHrwuXKFTs5IMXA5HRR0krD
	9s5mW6Rce0kkSEnk/4tIhw2kVzpfgv0Pu2ttWpQ2CiRKAu/XjwMqIta4D5okfzNc8zdmKv1Ypi+
	6aSyqxB5dE1xsuJj9pHapmuFvwEISCtDGwfm5i7G9yNK7p4PJbgNKRDfvqAFNL75ysvLN3+L1VC
	SXc6tuuino4e6RNR69qWFJaBXVMUKExJcDqRZOrky+gFcCcY2F94prN5E/a2aqC5cOxDc9QGQCx
	uXtqtH3YkFqRirnFSrqw9XYsCM3E/uOumQfQqIcCAmWVG4C2DaO36B1kC+ExbsOowilQ6I2xOrH
	vTnaMEw3CM3+TO3SlkSls1NlkdyGLCa+uSC2u63alaF5sWETgxxPUWivV1alsRACBULeJpKy0Jm
	h1TlVkVAc8nHNl
X-Google-Smtp-Source: AGHT+IHMbJb58nATRmai0WS9gfnhVJul59uJVjNVhSmasVwwjHrrbyIG7ZESwXwPwm4dgPq89hsCDA==
X-Received: by 2002:a05:6000:2204:b0:3ed:e1d8:bd68 with SMTP id ffacd0b85a97d-40e497c34admr16417f8f.7.1758721543997;
        Wed, 24 Sep 2025 06:45:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bc4b:2611:54b0:29a4? ([2a05:6e02:1041:c10:bc4b:2611:54b0:29a4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e2aacd4dcsm35528145e9.15.2025.09.24.06.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:45:43 -0700 (PDT)
Message-ID: <e6a7cfe5-5443-4e10-981f-ca3811dadef8@linaro.org>
Date: Wed, 24 Sep 2025 15:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 2/2] riscv: Allow for riscv-clock to pick up
 mmio address.
To: aleksa.paunovic@htecgroup.com, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>
References: <20250924-riscv-time-mmio-v6-0-9c6158a14b37@htecgroup.com>
 <20250924-riscv-time-mmio-v6-2-9c6158a14b37@htecgroup.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250924-riscv-time-mmio-v6-2-9c6158a14b37@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 13:10, Aleksa Paunovic via B4 Relay wrote:
> From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> 
> Allow faster rdtime access via GCR.U mtime shadow register on RISC-V
> devices. This feature can be enabled by setting GCRU_TIME_MMIO
> during configuration.
> Reformat the clint timer to use the same mechanism if RISCV_M_MODE is set.
> 
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---

Thanks for resending but I was waiting for a tag from the maintainers.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

