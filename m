Return-Path: <linux-kernel+bounces-740433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD0B0D416
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFC31896893
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E92BE045;
	Tue, 22 Jul 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yc3XsOs0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513A28B3FA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171438; cv=none; b=LaDqRw+5Fq/Yu3zSgouRuo94OtEJboH9NQjNfCl+QZH6mc/DqA46KKmHSrDVuyh2By3M7Bc0dojxi7wcU/Z+w2OF0a+V7Sq+vxZfKGDYRa42ZRT0BHorpcujUW5+YFW5Wup8oc7xndG/gYCG8ZHtpYWPE8Wv3ShfKx2aKmu/vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171438; c=relaxed/simple;
	bh=WNt/lYZe4GhHTFBnAPM0I+9fMp/6ZrqD3e5VzDV/4A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeE70s0aLKuOWDbGfEa+9MUmpbnga+UedK9JXojn7UYZw5xEGQmi75yvGuGrO0PdsFT9SeFRvIPOa+GH4kpWvvzCVWG1QBgSDNn3ayRI8xEGC9kIvomm5O6t444Xj+YGDdWYhuumn0wJ4ncS6fJ85sg06pqTr17AuO/LNaYIE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yc3XsOs0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455b00283a5so31168255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753171434; x=1753776234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEmEf6eIIroYB8olMob+1Spc3WW6pbbUb9E694QrtfE=;
        b=yc3XsOs0HnLelH6dUK+iyNKOYdVGb8yxtloiu2Z8dGBKnZtek/H5YoVqtmibYfwETG
         ms9Ue75kWTR5MnuT2aRVw/Mj5JCxXp/5zTJnGm4rstcRbJjbjqTH+PmUzUmIylW2T4eJ
         vVVxCWWyiOouSw6LQmgGf3MahAPxjEGY5t2s/tO7ENxYngZCpVjP/4E4fDV80vgoS/6M
         MVy4E2nrsEXjCo3fEIEvDDtCU8FH/0mOKhMjL1jMUucaemxjB85pncjC3Gki6Dhy2BbN
         V30najhJ4+PbDuVPr4mVDt7dd0j/2emZsPq1+qEDQSGtsocHT8JXKT+URad5PVDYuxyv
         uiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171434; x=1753776234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEmEf6eIIroYB8olMob+1Spc3WW6pbbUb9E694QrtfE=;
        b=DWBqX7PKhxsod5hwEmOhpfyTYhyXP+J3RpU/dC6DQ8/zUtqohxSHplUG24yHr151o+
         DHFXQtZ8kEpumDpjekTj7OJ/ZzyMNzuLeKJS2BnesQm5WHSSHXt57cgM9NXxlZMe+YJX
         DAYLEsakBTsIIgDhxIUhyvLWntLBXR82kbkhsUDO5NS9USlXSouwdcOvVnh1YqIW6xM/
         FOQdC2+ZcTE8Ejrr6EeqywNg6aEUYdCVDm4bNMH4sPJWVVfNcVHXPyfoBWFRQai3h11e
         kgP2A9fe5HCNoT1aGjyae2v4pFMefMsCZ5jVC5RiB7MikbxTEGjXJU02oh8OWORIwc5w
         QWow==
X-Gm-Message-State: AOJu0YwT/t7TGn1VkxJSwbOZnB5HfOTB0Gl3n5mUe3237b0w6rc4f8Xx
	ueYIOEk/HbnOMBe0KovwGB+vnBAvCiV4o85fk2OFeM3ickRUvjE4OnRpjHefmErBCYw=
X-Gm-Gg: ASbGnctfTJXxBAfg+RnDfjdEAcrkDXY4garTuzyS7QqcPVBEW/CVI1dZn0eSdZs8BYS
	llBj1aMkrnVUdQ+x8CU7L3mM+q3RuCpsWDLaBtgyrkfDT+uliM/XO/TP6w3PjspeD9aRV2XhYIm
	yYOY9nt5L7D1AXAQJJiwVCedAHNcDFMlLQHigB92mmkEsQr4JyZW01ouXr2G+81pA0bpay0iFba
	rHMybMXKM9yxUmYGx8Ias/sKmK45eZBP08kKZpXyaVf4f4KUhh6cN/oDONhWboUuCHa5Iab1EB5
	E/6sPC/xVrDFguidkuZZYGGVXLK0guZ9oSKZDMA43hFaOUUcZuJ8g8O/CpB7xU9eKK0QWDzpovc
	uma68jBBLstnhIXpSAgpN8CPJzLkjbt6IGKzsY6RRG36RkSKBJgerf5vKwJzX1TaDw4FOTQ==
X-Google-Smtp-Source: AGHT+IH0HJnl+dwSi0EWYLrpcr7/uk6BoHHegtmmKMicoHxCMgGX73lCJhcNP7HethjBe0TSmHbeew==
X-Received: by 2002:a05:600c:83cc:b0:456:237b:5e4e with SMTP id 5b1f17b1804b1-4563b8fcd8dmr125773945e9.32.1753171433982;
        Tue, 22 Jul 2025 01:03:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860:59d3:864c:7ddf:2abd? ([2a01:e0a:e50:3860:59d3:864c:7ddf:2abd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25533sm12474855f8f.11.2025.07.22.01.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:03:53 -0700 (PDT)
Message-ID: <9d77242e-8cf3-4179-82d7-24109bace40d@baylibre.com>
Date: Tue, 22 Jul 2025 10:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel: irq: msi: Export symbols for TI SCI INTA MSI
 module compilation
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
 <20250707-timsi-v1-1-80ae43b2c550@baylibre.com> <874iv9w72x.ffs@tglx>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <874iv9w72x.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/07/2025 à 22:57, Thomas Gleixner a écrit :
> On Mon, Jul 07 2025 at 17:35, Guillaume La Roque wrote:
>
> The made up subsystem prefix is not really useful. See:
>
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject
>
>> Export MSI domain management functions to allow the TI SCI INTA MSI
>> driver to be compiled as a module. The following symbols are now
>> available for module use:
> While symbols is technically correct, it's way simpler to understand
> that these are functions.
>
>> - msi_domain_insert_msi_desc
> And with that you want to use function notation, i.e. foo() instead of foo.
>
> Thanks,
>
>          tglx

Thanks for feedback i'll fix in v2.

Guillaume


