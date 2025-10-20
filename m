Return-Path: <linux-kernel+bounces-860525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61526BF052F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1515934AB73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99523C8A1;
	Mon, 20 Oct 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K13o+kNn"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198429ACC3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954043; cv=none; b=eAMg6XiIkgpa9C+sJpLkvPs9WV1mTySWP3X0bkzRefipKbuh/jdwVyTd3mCn39PHwvGRzttcDqvp2hXCZ1U4srdtGOYVxqBboyQ4Ulw818l476Q2YUGa0D6mK6PzhtLsTiTXaIGof+9m6JOHGhiDAMVOIsRQdGmh0/tXyusFdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954043; c=relaxed/simple;
	bh=Zk7GfMvZ/z+gK/VrZS+DewwGdOPqsTuMoJtQbhmGP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT3e7tVHYa0zBsz46agaOMgVwoYk8RYA0u1NMJ69DEmLa2ApjTNJgL1dLak+1CydD8vkmE3+/G55IgvVQCSWyvZuu7QmNhjhE7FRRpK6Z2nGhIjJQ7xKkCSvM10Owqx69n2dMHNq8BYEh6qvX/JADYWgjgvs+BK6yaGNRJ+Tdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K13o+kNn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47157119d8bso3693895e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760954040; x=1761558840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEZOmmPRU+6Jp7MDbpYX1wr9n73+5CZ3iAvnUvQZOdM=;
        b=K13o+kNndIzCbAauT0TsRA8iVO5BR+J5ROZlxwZQysceL9IyClL0PI+EX6ImiJz2UR
         B8ICLqaVcpUzEe1X6Xmd+KwA1fIOJey2GYkCA+v69UYVbocLLf4skKw81C7FUStESWyY
         VyIjKeuDPOnyVbUd+x4hqtqJ2wUqIUO4LvqA7T/C4KQ/dxuD/G1ULJN+ad6zPvOrNZeM
         GMLt0tphpxdE0VwGSVjVg34bl4Ua73UB/+CRLNFpgVpx+vU0bMHGZTXoXXYCvUAD8noY
         ZQ4pDi34yNlQt5N9AXVKxrGiQ9zGP0PhWApAjessJ0DCe6Nl1c30D0h9Vqw3WM2ai2kX
         Sp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954040; x=1761558840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEZOmmPRU+6Jp7MDbpYX1wr9n73+5CZ3iAvnUvQZOdM=;
        b=JItTdhnm/HDQOUFTsfhppevc4rn3oprdrT+WpUhofpKc09y7VDNKcrTkGaPz4PeS83
         V/be7pdVQRwhVZs36Q6qSX30ztnQNaG94VaTChTLLCfWvIcDxFZm0sDj+u6unkA2x/2Y
         TJV84zcTSzzTYWGSlKKfI03VFfr4ZkvT+DbY7ze3JmAwSlT98sClEog23Zr2tLnFU/yn
         56UdH+/PLrUa1w3Y2DdvvGSwMft5pYZT3sqYsBorITDIiOQBC1+kbtPUv2HeeS46aSpq
         V1xtoWmw/bMQqAUxzN8WXix9yF6WbczUFiz8IcN/qcVkX/uQM7r7SiSiNFM5QTfx0IJR
         tCsA==
X-Gm-Message-State: AOJu0YwZE7FFErkGkGTTtNQq0LWOk8qlDBshaLx2iyhWq7tLbfk/yJCU
	2u6+OsqVrR579hmuEd++m+CxtDiiiRidHNE7SPacY5Fd9hejlIYfdpGI95XGYwywkvU=
X-Gm-Gg: ASbGnctZPD3vWrEc8jBkL8d7JjdTD1LyHxCx+pLaUan26/PtuVcuCTdKMub9kbg8VP+
	fccdjLLAMPGKdRQXFdlHWRm7IhNJtJtdM72cMBRwdPnY7Jnxj/+Lv0OoAzdntRdAtk1BISly59e
	KZOkVKS5F9qLRM5THZHKbHex3gy9fwuFRPO3P46ttSXWBvYJqk56exLY0vsAfUfi1OjtcbkKIM+
	RV+kSRSGjsm4FfsD64XlyJNmJZnPlgBvEAI+mG8aILR8BBv1U8qfyNskQBAX0Q/yRLsdjoPlhpj
	+ktsBECVW2u5ZStvvC8O0giW/3/nzus3R++DvZElYj0PMKnQqg4Yh7h6B+jRF2jX1v4XCVll6bf
	Su7YnlfeqX3N459V7gEaSnRY08U6iCZntP3VG4ZAklRrXXe/AU8Kyt6wgBElD0E7UJ0M9l7/906
	2jtKEFELuKmGgbyhXMbPMmAY43KCOxNA==
X-Google-Smtp-Source: AGHT+IFX1wgTFn1MLKPhwOgGbyn9M3V01/rxbBTWs1eN7xRNGNtr9tOjyrzfftVxp4Ewsx3pfTiwYg==
X-Received: by 2002:a05:600c:3b8d:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-47117917155mr87074895e9.26.1760954040323;
        Mon, 20 Oct 2025 02:54:00 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm156200285e9.0.2025.10.20.02.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:53:59 -0700 (PDT)
Message-ID: <cad8f866-1655-4f4d-acf0-a974ad40ef39@linaro.org>
Date: Mon, 20 Oct 2025 10:53:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] exynos-acpm: add DVFS protocol and clock driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <4a436c40-0fb4-47b7-bfd4-0bc499e85b5a@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4a436c40-0fb4-47b7-bfd4-0bc499e85b5a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 8:03 AM, Krzysztof Kozlowski wrote:
> On 10/10/2025 14:46, Tudor Ambarus wrote:
>> Dependencies description:
>> All patches should go through the Samsung SoC tree.
>> The acpm-clk driver (#4) depends on the ACPM DVFS ops (#2).
>> If the clock subsystem needs to merge the new clock driver, it will
>> need an immutable tag with the 2 patches.
>>
>> The following DT patches depend on the bindings from #1:
>> https://lore.kernel.org/linux-samsung-soc/20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org/
> 
> You forgot to mention that this patchset adds new dtbs_check warnings,
> which are fixed ONLY after applying DT patches.
> 

Indeed, sorry. I saw how you handled the dependencies in your tree with
the 2 dedicated branches, I'll keep in mind.

Cheers,
ta

