Return-Path: <linux-kernel+bounces-738881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7BB0BEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66A81748A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F40286D5D;
	Mon, 21 Jul 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbRMkQGM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7B286D44
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085890; cv=none; b=IdVJjBi1SEYK7qYVGluCPgCGXmne1x8P1vh2NHyGpMlNLOuQiwzfhDT/emIawDgM2R8/ZdNQHIIgOFboKieY970ZlhBZrvhlm6UiidkPb1YfSyS49uZK2lsJZsarhFa24qSbK9lXhpwabjAju3yFW3lVb+dv3+F3OEtLDCAJypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085890; c=relaxed/simple;
	bh=4Ta0TLua0Rtt1YKOLIaPtKpMij5Yc4Q/7c3JdU81KHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ign5rvtaI4GoNZT9o1kAXq4CCPLVn4qItXQ09VpzHmJAs3D+31u3Bxdn9pvF2yJUpdmhexz0Es/o2LiXapoDn1SXXy+svQX/sc0fxV6qypzUE96FVc7CgKKc3ZWmShk3qmnCpuU60pr0oDG0ilfMSXV+OWZe4EpvWq2p1Ylb/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbRMkQGM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae6d8584e08so75855966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753085886; x=1753690686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPXELs5NvkX+PM7JY9uaPhAOXWpOOKXEuN/iIGPovgU=;
        b=FbRMkQGM7VBrdpBGUvflQlloc2rn2yfEABtKdB10zr93jtXOcAs5tP/pvf3P1mN9sU
         gm+7QIUOgZy7SX5TefXxuketzpL5qpyCKEDJvgTyd3DDHda8cC+j/nd/EhdcI1isWvBd
         YeS+2uk/0sKbQNCLEEOOxnPEg1nBspW3dYRA3vPvBgAJ+n8Vri1oF0xWOsFb9xhGnuc2
         HUV5RpmUV67As/ylhg9tSxBMw0oVbG3eaRveR2BaAYWQlraSKa6rkqh4HcBgfbReI7dc
         MNbDsTA45X9hJ+PAe7p+hvQdQPLqEbArMJyk9JsxZiSk0trT1NkY+/lmnedel8zenInC
         NIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085886; x=1753690686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPXELs5NvkX+PM7JY9uaPhAOXWpOOKXEuN/iIGPovgU=;
        b=aanQTfNFxaB2xZkdRUSUC0ioT7aZrvTOWzdDtnh81MAQHoB6RRHpCKMJN36Vtw2ivE
         LW53SmZr9MbG48exNbxqUNzg577p9lksfEkmUV0B7yKlvVgvyXnTIiKgcvt22dnHwTyw
         mFh2H/C3L16lSRCRBmirc7iUzuozduthaBAvCX2eD0MlqGpkWGzBS0zvEWd1oftxr9o0
         sPhcBLXaUn8qoHQyATlvGOx20L3mympzrQAqnN0FqUyL3O0rBsfJhMuYKbQJuo1P9bvK
         mYOWMW53PLUKFZxVP9c5yeIzmozLpSnDNCTc+YkSDl9ZfXIInnC1fKpld/9SM5DhK2jY
         xXkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmImB/aaYxPp28SPppxW43AMpgDZjDoKZON38ovObRQBvzExPVTx30z0LEWy+Af3fiOfoXNUrBXJk3lH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPri5s0QjmSTMcC2N2XcxtVbHxu+wktN9TIGLnxWHGpFkbu/p
	Nt0auPjnziV6xskwKKed3mYleug0dZj0RyrFRjS960r6HXXYvtFuux3KYUAEUCNM7pE=
X-Gm-Gg: ASbGncs7Xt/JmPPq719r2hPx3XrdspuwsBaQ4yT+kIDZJE5XQUzWgsE/SlmO2/gnz+0
	4KjXWVEE5pRBoc0sgGaS3TcxJ6hDBSETKw4+++L6az17MHU9hij3ICuMgnZ2l6aJ5hQwazKXAQI
	t8/MjCoqohq2QLVcrEltQCCwVmFZ/x6PVg8pXpyyT6CTyRYlWXcN0IWJ5BeoSZS2BDfpf9O/CnF
	IrPVWnpKujacREjG6pmFqgHeCALNOWsxzu12VFNzsCeQN8Pvb5dCiuVahwTYJHQj0UKKhK6B3Si
	0XMpYhXuWg263n6zRfnf79qasQvCU+mOnvmfXJ9puEfiUno+NdX8jhr9TeJe1CC9fcV3NIlW1Il
	zpvyTJf5RtTVnHjGrhbnTNcsPZQXc7P65pTUznLnSMq8cB3fO
X-Google-Smtp-Source: AGHT+IEwTbfpXXMQ3S49s4PgHyCV/u6H0Q8oR8adAG+0t/NE/c8sQ0/0zI+RNG/o7SXdvdd/cnUXsg==
X-Received: by 2002:a17:907:7f20:b0:ad8:a282:1c2f with SMTP id a640c23a62f3a-ae9c9b2153cmr688926866b.12.1753085885643;
        Mon, 21 Jul 2025 01:18:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d524asm633642366b.45.2025.07.21.01.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:18:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: William Mcvicker <willmcvicker@google.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@android.com, sudeep.holla@arm.com
In-Reply-To: <20250717-gs101-cpuidle-v7-1-33d51770114b@linaro.org>
References: <20250717-gs101-cpuidle-v7-1-33d51770114b@linaro.org>
Subject: Re: [PATCH v7] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
Message-Id: <175308588382.28993.16370211179082448125.b4-ty@linaro.org>
Date: Mon, 21 Jul 2025 10:18:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Jul 2025 17:22:36 +0100, Peter Griffin wrote:
> Register cpu pm notifiers for gs101 which call the
> gs101_cpu_pmu_online/offline callbacks which in turn program the ACPM
> C2 hint. This hint is required to actually enter the C2 idle state in
> addition to the PSCI calls due to limitations in the el3mon/ACPM firmware.
> 
> A couple of corner cases are handled, namely when the system is rebooting
> or suspending we ignore the request. Additionally the request is ignored if
> the CPU is in CPU hot plug. Some common code is refactored so that it can
> be called from both the CPU hot plug callbacks and CPU PM notifier taking
> into account that CPU PM notifiers are called with IRQs disabled whereas
> CPU hotplug callbacks are not.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


