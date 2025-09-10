Return-Path: <linux-kernel+bounces-809857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8EB512DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8ED3B2FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E54314A78;
	Wed, 10 Sep 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecgLE8LF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE082DD5F6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497280; cv=none; b=ibJ7akr/3XDpNM+EowMNx73MepzxaAcfIAHWYB5+I+ijH8gjjBC+9yHWC4MiiVDcpF3CQjAId9ZM/5w0cuXttxpcIwnn5F6QBsgs04eMGwJ6TPuTeqnF0mBMdLx/sur2zy9HjMiPg/DRq4Qc7bKGVubR1T0ArwbYHIlXHuDMr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497280; c=relaxed/simple;
	bh=e/kiWQIK0YAP/k8eC5ojOTLdahChMbymRDPSoa+l+lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p5Dunpnbf6iOrecHMzInhKEtgsOsG4BngS9hY6rDhd9X0oS+/l0pSHUo+R2zyvtSsx62LZ5olrX1RIyuZ/6lJLsCGDEC03WJp08sAsAsC8fuz9VNCJ4DYTWBBjJUheEt9QZM+wEbbItQFTlM7Q+I67X2cMj1NsBD9Flx9haFh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecgLE8LF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b049624ba2dso75972666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497277; x=1758102077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pt4wmXkU07xSJDhWQaMnUt+2pOc32GfIf3u3taNxfY=;
        b=ecgLE8LFVWZBvs43abCu5vIIy0CbrhXheFdt52h0+Z6X/3lfa5hpqWOzeuygD2hHiU
         iuMxo/9s+UR11GqZCpLe5lAdEzq+hDrgOcxJAj+Eh5Ar9UU2TtLgzbvK3ghwk6I3lDe3
         01slapou73yz5DESjE9Uh33Fa1qaEXTZt0kUjwR0iVdEFcWoSQlLf9A+O/4OkxRGI4JG
         DY7vAn7NrVeiNtarquuHfUcjGQQwxoxbaFBLvpIWtMXJveENLaQih1nEJQkW4MnszP4u
         cBTdGclpg/qTSJOBMQsJ+Xum6msqlKgDJm7zAo/5ASpi0ezOEb9cHOC33absZfwG0vJ7
         x5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497277; x=1758102077;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pt4wmXkU07xSJDhWQaMnUt+2pOc32GfIf3u3taNxfY=;
        b=JKKqJNdxuc6TEJoHsq930f+oFtJccf71XWSw4nxh4FVABp+KhokBImRrAdRnWW7rjM
         3Ak+ca4MGpAGHpq21jatjY/ty1VpPoIyPWIMe20MKkWslpoTUNAnkadiVIzAGkGDddQH
         WZnGUDhapZaAFRx56s73eDSoDjUEtY2N2jkrwoUTeSypqnt2MSW2IVn5cPtH3zke6Z15
         kxX4rWL42V1tt6q8oXr8liEjTa+qnLJiGpT2Jzz/PsieIw79Wlsbh0haqUrLooM3HoBc
         UUxrDQn3gEkzb0Z3OjirBwo3ioPXWFJhscELPS8vflzjq8pvJJHGYFwar+u20UwwLcmO
         gq2Q==
X-Gm-Message-State: AOJu0YxRHiUrmaXNH6LV8uAzUYmRy+AT0Wu/EY1j6qO5MJOYdoPe/+In
	gBAvbuGTQTWDPXOMFullKum5hGs13WkmIt6cAN+9mShZspRToz5LwCCv7sHmsq5xPe8=
X-Gm-Gg: ASbGnctaC/MSjVUpZyX+WSRoyqg9PJddQK3Vbj2p2CSjyA1Zwla0wHbWRvW8FK3ro0n
	AbGbBwIh7DWb8ZbNXP8iL0bBcG6sQ2gRCYKC4lGpR6Wc0ntstbGVDrvmlegBfOlESoP0mB8CF5V
	yrO3AruFxd9R25enKOBrs8Ml+FYlOfSEqdjZVoFIT6Jtj+k1Cs0RRlXIWVExtN8hqIZxpzSKZbv
	fPnbb788IHYNs9S/LMxh16Y8nbKN8p+cuCnlbKVnnbmX6xpcV5MwyqOQ7WVUPSXQ93oiMPdFSy2
	YNik2fD1MvH/qJu4n63jR1I7QMDP67gI1hWgZ5sCvyVCzS7nq1nitN2UC4+8K+VEuu1K3UiVdpv
	AMD8uVhXbw5uAuq+eLrAb8wlVLrejcyX195I7mFw=
X-Google-Smtp-Source: AGHT+IGveog/Q2RUQ1K2kmwHRA0crLrj7yzg10nc1PBAbCu+y27ReaxfY24xmgNZqJ6GerxKvTkBkQ==
X-Received: by 2002:a17:907:7fa3:b0:afe:7575:df0e with SMTP id a640c23a62f3a-b04b1737c20mr799525566b.11.1757497276998;
        Wed, 10 Sep 2025 02:41:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb7e9sm3021590a12.48.2025.09.10.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250906-t210-actmon-v3-4-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-4-1403365d571e@gmail.com>
Subject: Re: (subset) [PATCH v3 4/9] memory: tegra210: Use bindings for
 client ids
Message-Id: <175749727534.29308.15110527994326578124.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 11:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 06 Sep 2025 15:16:54 -0500, Aaron Kling wrote:
> Since the related binding is being added, use that for the client ids
> instead of hardcoded magic numbers.
> 
> 

Applied, thanks!

[4/9] memory: tegra210: Use bindings for client ids
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3804cef4c59742cf695e7b41a9aabe8d5bb25ca2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


