Return-Path: <linux-kernel+bounces-864193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D0BFA23B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB1D1891392
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E352422FE0A;
	Wed, 22 Oct 2025 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsEJvJfQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB723AB9C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112760; cv=none; b=NI3VRvDeYVANTdhbo9uxhaDtPBi5G8A7uGCkmWiiiQrPtdM/iExxbv48LIQZrJ5vU2GFTkftbjZbC4E54U7vCgvuH2cZZ/lk3srFTbnSA4BvClQb4Tkymrp7e7EfgDxrzrhtc1o8iFa3yuJmHrsHCy1VRBfHPYL+8qZRonhhc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112760; c=relaxed/simple;
	bh=1mAYXh5gf85r3zkPuSLEJiUvmaJbkw4OlD/ZND9lC/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WfJDwLg7oKnj//mx1Tag7Jjar47sAL+ncls8nE0XVpW2t7IaQ8a8aV4WdojZmfFMXEjtd1g4JhjikLnNkyXwWAhiZEzBVNQnSxKb90+R06hNsgJ9pujstNV/f6UV5D8edWY/Rq/1jXtAc3cBnyyE2nZjsyyK3mL+1xwCQEFkESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsEJvJfQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5dfff01511so165996366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761112757; x=1761717557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01+Fe0eWiJBF/0jGmWtSiJdY8eUSJHrRdRgDTl7S34E=;
        b=NsEJvJfQGIQpdYFZaM6kvheklhKveP0WvhzNoRHlLUPfv8u7RYqRKR7E6AEjKfjY3M
         06RWrACHsg43i+78HLM6myjd/vAteo2r/jDVB+o69GRczSkSPn6t9/RlVU4ZPEK/0Xcl
         IfAGRAzc2RJ2Jfvj1aeW2w8mFfprcf8sXIrJV01WzRuH9vmgOn6pRZy20/3aztwY8bnq
         IVOOudvR4XodL93BmfYgp0qnAeNeTPf9wbRnDFJbRDmF5nKs8liDQK2g3Blcl5+iWh9x
         Doy3FRvF6iWUcGWRWSY5XOjDxxnwoi4zXN21Ul0WpvLV46RpAww+fjADIlnliukyYv6E
         X9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112757; x=1761717557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01+Fe0eWiJBF/0jGmWtSiJdY8eUSJHrRdRgDTl7S34E=;
        b=W0T0pCMhTcBBN7ZMM2qjwh8cz72AWmE1V+MfINks6UgUlOJdOMpr+bGvtKOZa8vyr6
         K+jcLOhvezfTBy4dW22uXh5lfbEkHR8tf8urSXd/ACGVVEJ6waWFjtlDGuYArbd1an2O
         X2ksLbBkqhM/liCBTj7dgntdYAI0PnKMNG4+T8PxrbhyjAV2MpYhy/ryqQjy6F6ncosm
         Cfu66xr2Lm8sttSuMMnYJ2qCtkkBLqPG4j+8Jj3pdfdtsIJlqGFivUase8hnkv9NbqJG
         nmFtyuQGj9urxtnwC+iGuICE7kJ8I6gUQQFMpA3jmQ6hJ27f9dQPAPTtEfzEX/2UY9PS
         f/zg==
X-Gm-Message-State: AOJu0YyKJ0yekaNcOOLTRqufjWYRJRGq4pYaQtFIdAIES/7lPzjvzKzC
	EZzghkQZcaeISc6RHInOyVdfGPpPkUa2NxRX4XSU71blyfKb90Xi3HEHjCk7FhJNBBQ=
X-Gm-Gg: ASbGncve3Gcqi6JokmXiBDKkoT+Uz2YLnM/fMg2ik1Er87nDN8Ny5Faf23VBV0bWTOs
	R8LEN3XKp2Rv0p7K/Uh9glnvhUACi9Uy/4v0ERsmuIRpY/Y4cDOBSi+Zm49gxzNfvmAkodt1ijV
	ykRXU2Agd8J8DvW/QnETS/0l4i/Hi5mI/pHjgvanxkj9vnreOfD3si9ZoGeXwQDVSa0xe5RRztO
	We4vysoQkdD7gy4XGIm1ioQxMf9MidYKaGfukEIzKB5S/ENqHmES+vx9ngMGV7Ff+WP1tRBvfP2
	gudZDwyOzlzAyc27P7VfWdgJNRdsllV8tyUNLRuCKmggymasxGl556cbFLrMNF2lu7YTlX5loqy
	9IROv8P6SFuyJYyTK0UtdXlVxJmEXdmjFSFqfksodt4vYZU0AmoCZigmJl3cLM1x+YBYsmKWu4I
	yN5cZSPpNCprPMoSNj8FUzFlxGBG8=
X-Google-Smtp-Source: AGHT+IG1W5Hfo15+e9j6LfyFkdiiBEUF4jK5x8ekTLpFWUxvmYf1mD24olvCsGRfz8UWl/h5IepeGg==
X-Received: by 2002:a17:907:3e08:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b6475a06d9bmr1365635266b.9.1761112756660;
        Tue, 21 Oct 2025 22:59:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da33d1sm1251417966b.7.2025.10.21.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:59:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20251021-fix-acpm-clk-build-test-v1-1-236a3d6db7f5@linaro.org>
References: <20251021-fix-acpm-clk-build-test-v1-1-236a3d6db7f5@linaro.org>
Subject: Re: [PATCH] firmware: exynos-acpm: add empty method to allow
 compile test
Message-Id: <176111275526.8693.8621837502734274047.b4-ty@linaro.org>
Date: Wed, 22 Oct 2025 07:59:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 15:24:47 +0000, Tudor Ambarus wrote:
> Provide empty method for devm_acpm_get_by_node() if we aren't
> building in the CONFIG_EXYNOS_ACPM_PROTOCOL. This allows to
> test-build the CONFIG_EXYNOS_ACPM_CLK code.
> 
> 

Applied, thanks!

[1/1] firmware: exynos-acpm: add empty method to allow compile test
      https://git.kernel.org/krzk/linux/c/6837c006d4e72d6add451411bcf407e0dea4ad25

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


