Return-Path: <linux-kernel+bounces-793453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C0B3D39D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996AF7ABBB5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B060266560;
	Sun, 31 Aug 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3t+JERb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F33262FF8
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756646894; cv=none; b=cAhEZQQnOuhXbFfjpLeVrjM7xSx2XYXR1Jqgfcc0/i21OwsIZe2DioFu9iBsZhabmxzR6Ar2099s+42336PEBAoPVBjq27nuOL3BShhwcGxXeBJjmVkv22lwlO7wkPrd9EH8xGPR27qFgirPXnfLcV48Wm26d7Sv2Q0rjXbAxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756646894; c=relaxed/simple;
	bh=MEVeAxVhndT/7Ap1qgmz1gUcPCdJBlzqawgLrzkMB+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nl+6cE9NcrqMFXcbu7sqytmAh0QWrqSTYiFP67pshHZoXV2OXrMvLczUzAXBqrrfiJNAiqLVrLoRvAt3RV/8ouSjy0PUBEXu0zq+IB+WZh5Rg2j0anMtmhhS8Ab6EMhzUBzAM8qFH9WtkgdAk+VxV54rGdLNrxgL0sBpNoGKYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N3t+JERb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d323be1617so118380f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756646891; x=1757251691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C174R2YaizzIOWtPzR0PtYRjLpsIdj5ksrAYTRWCGTw=;
        b=N3t+JERbTGuRAAyVCqxfce6CgTvhdneUFodRUq2lDvdaQwJRwKYIFujw4LOuBqFgQk
         fVKtgr+WVqXsbv/47c9Q8HxfY8JLcJiKtT22VbLiKHqoaRjXpgLA/5umHaW0E0bO3GA9
         hQYnMtbvyFpv1AsF1akwcDcsBWTW9BL4P/9/sAxFYgGE2zed5LVTUIO6n9d6wCqlnUq5
         rfKBaZD1j3OzJtqFtdkDk0e1vkMKbjdT9R5oQSYALmvP8CQyaxyQkeeUqU8l0+nA+8H1
         y1X5nbVqU9dKQHWV4K7uVuZ5sM0bY8KXf0DK7vPq/uvfOPwNsvn+jtXxgD0Ls7a/E6wL
         +8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756646891; x=1757251691;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C174R2YaizzIOWtPzR0PtYRjLpsIdj5ksrAYTRWCGTw=;
        b=c1sMnL24+Kh15z4jSYMh8x3XDP1SUp6TeSvWZ8n9AqVNVkq6jG0naDz5OqxgfMWQXJ
         c2+T6Wt2xmQuVdE9t98vaq5qUSQILQLkL7Mgk3MuojA1smwZWI6/Xqsat7ydDaLnsAXf
         m+uX9gyLkHf1qk9XABSl5EwGh0kZxlGdD01xqtRbKdA+2KB4bCuGDEt7WHkA/YFtarsg
         OU4ztpkhaHzjtR/ixMUBXKb5PXvVQidj1PqDguoTxql1+FY/i5WBAhUmnGFyayrEFD9E
         PldFNfvcjbPwxgrVTRabMfTVwK+gclrcCtnKzzRl9hQUT/fh4lLMoVneV6qjLuUNI8PU
         weFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCKCkv+L5IrvKNLLgQU08mxN7cnGwHv7V7L15fdbQxoKWfmykk4tpSzhQTjOrPrtyZV3R1cWGQ8bp05Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4+Ebd6u4224w44Y3wiMQu08br9pEp1Szp8ALcwTdaNCl0kPq
	JiijvIuGaUDGuQDCY4V+qTUGAyH3i/uQSbo2S8I6Yd64gHEEG/Q3W7vAKHYvxIVXd3I=
X-Gm-Gg: ASbGncvtwPVQMExmQ2bNSWR9GZDhueJJVZHEosu5+1K1zGyhHmqWdjSwnkbKV+m9Xh4
	EWJIayTOdVoZdTL986yWtyXeahdY0d4Jzvlayq8cG1zAwnqujewf9J5dxJoK0655ZIIWMWrwyIU
	ImTIxnAIwIfgGA+TEXJFS6dAYZ7ZbNdR68CWlsg20BSoRgesgoiqiHo1IT46ti2inrBhQc3UGNk
	s2VFHHfmu5Oo/pYkZVBNj+hK+3NIqmNYoy3fXYHlG6dSCEXhJoNV8h3RFQEBHV2eh9g/81LQuec
	Whp+RUyTM57nGrFupqrm9s6XKi0nCdugSPGiznsCI9riZL5N2D+h8ubnaa9VPuYIxs9JWsyraJI
	0Wa5TqToxmH55Zjr/yGHd7xpu35HYmlNczX78h4g=
X-Google-Smtp-Source: AGHT+IHkPBdwt6L3VH7t04bp7Le2oXr0tHCapltVXb93QgdyVU4QJ8bZvFGna7E4/zYnUQGrTwhkug==
X-Received: by 2002:a05:600c:19c7:b0:456:1a00:c745 with SMTP id 5b1f17b1804b1-45b802c57dbmr32352025e9.3.1756646891177;
        Sun, 31 Aug 2025 06:28:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87b3900dsm29956925e9.0.2025.08.31.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 06:28:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
 inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
 dj76.yang@samsung.com, hypmean.kim@samsung.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, soc@lists.linux.dev
In-Reply-To: <20250825114436.46882-2-ravi.patel@samsung.com>
References: <20250825114436.46882-1-ravi.patel@samsung.com>
 <CGME20250825120659epcas5p47ea3377840efb9ce3d5901a27c85e4ed@epcas5p4.samsung.com>
 <20250825114436.46882-2-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v3 01/10] dt-bindings: clock: Add ARTPEC-8
 clock controller
Message-Id: <175664688891.195158.13270877080433356384.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 15:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 25 Aug 2025 17:14:27 +0530, Ravi Patel wrote:
> Add dt-schema for Axis ARTPEC-8 SoC clock controller.
> 
> The Clock Management Unit (CMU) has a top-level block CMU_CMU
> which generates clocks for other blocks.
> 
> Add device-tree binding definitions for following CMU blocks:
> - CMU_CMU
> - CMU_BUS
> - CMU_CORE
> - CMU_CPUCL
> - CMU_FSYS
> - CMU_IMEM
> - CMU_PERI
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: clock: Add ARTPEC-8 clock controller
        https://git.kernel.org/krzk/linux/c/91f98de42310c70f9a23595b3b20aa305717d955

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


