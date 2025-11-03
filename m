Return-Path: <linux-kernel+bounces-882689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA78C2B227
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A844EC4A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223B2FFDED;
	Mon,  3 Nov 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vf+Kbiye"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2921DE3A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166925; cv=none; b=G9MqL+SSabeecTgsYUy2sqUGf1pJ6YHUnjB0/imfcPOXuIqc8fUjXbOEa8+pVyzRJEUkmS/31XxFo8XJqzMWVpi96T2wZPdzDpwDv5O7IVFnAqX9hUG4cOQbOk3kkvsYeO0wzY5fMb1/s5Ql4nCIVGA3uFbBhMuKhORsmBAEmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166925; c=relaxed/simple;
	bh=Q0axP7ETcYnEup2g4QMYHRxFWs2wS5e4vu/YmLWZIJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4chzfxSJTlnYIr/IIXYm4HuYYmogNew7qt6q5tTxQcp2309mMR1CGT2BaytGPeQAxSsjHJKEYPWUFdTVCtt/l3h9e5LWGX2OpO4Dq4jSjX2XD0paENpZUnJ57Huz7bBsKEhlKaMRWlowD7KKAEAlh3s/1OWWFR2wnReKBZphlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vf+Kbiye; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2184639f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762166921; x=1762771721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gm5UI0a8gJneLZRiznMNXx7ABUbqRL4XwkxE1PuudI=;
        b=Vf+KbiyeCpgXPyW58fP0TOBoezVi1nstP2GPKqQ9XZrd2hc0Xkfi9dtwcaEzo1EHvB
         1Si3Cw6g9JeQt+Wk0qNneD2srzPWg5jH2PQLzaPmn8Vs8R3TJeevqWGfAiISlGFWLb0Z
         mcaffyPkkXphpYUn6dkYsfm9e2gaFugTvNAUzWpxPxWYK7BLCDehGAWHgke29YGIuZvA
         po8fD8EApYaZ92Q9gJEXEnOQHLfR2z9RRgVVf+qrzsngJun8woiKuhjW3mgRMp3emq5j
         cPYPu4D9K5uqPhPjadHRdb4wgxZuiOZ2RewEolAO53vdxA2Xvb0LbtcIv24owSrsGQkb
         PBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166921; x=1762771721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gm5UI0a8gJneLZRiznMNXx7ABUbqRL4XwkxE1PuudI=;
        b=mrC/e8tG8Dq326/pVCCjXxgQxlh5MAHJyRi//ilrL/ibgSFFcXRObH/KB4++g5p94D
         nCNS+OiFbA2nh9C94LGddeDXzcaKiEYiwzhggXM81TcGS/efPCdUfGln2vFZdqFj/ew1
         NxZbJaxFGWHLezP3JX91pE8tPCoJAFykm8WXFHXYBWQ08IBSst2SH0iR4RZVCCDGWNTO
         Tq4Gjwj8t2MkNDSM4I8w3kPoylpeLIFlI2UIc9ZeXUVJOKd7EikuYURzxJUWIn6YRct6
         ENrU8qVTgbm1xFlmiDTYgodPil+atxGPqH3mXuSIxNMSsT0/942GU+9R9LOiuMsUOuqi
         g45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8THVMM91O/SO3TLbb4jLtlm5feVqgttrEIA2/HwaHf9+WIqiwAmDCvRzLebdvWV1MHiZv0lbm6b2IaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEFKQtdLR8ElSuU8kv/9NX6vwPsanZc8vpVGMiZHmnEN592d+
	dq9eK3HtUSaZVuefQ5Y2suiwj3GCiM7I0lT/LwTTrs8iytr1Le4WB/iMYMZa43afkF4=
X-Gm-Gg: ASbGnctRRPSW3sMJJFGyW1yi1GDskqnEtFjkYOmj1Rcn+yFhvynzak9sUiqnDcTdriw
	PEQIc2/sjnRKApjElgaEtrRaxQZQL2SIVnoKzh/Z8pRRfRomPapkTE29FM32nhdmdS15dWkwIhC
	q50F2wI1P8HyzGm0dXA84qNyBGqUJf4Z4S6/+j1FQ1VytXuoLuQjEe1TD8UB32ahiorbBFJZLLw
	DESOQPdobSmjC2wD9/plZkLCYxWgEc2highdEDu4a8AZxp1iEEoUdRbjB++Nsvyoh+HdKD9McYv
	6cclaEhfGYiqS6hBJ1u4wUoz2hqN+xxVDgDz+9vmHNJwx6fdX44WKmoPO7HQKf8eKN9hut4bLUW
	7bbYD+XCK4nW07vx68ZA6TSb/lZL0eskn3BZuBIgsdfRyZjyZdBi9CijftegtePigtXZdOQE=
X-Google-Smtp-Source: AGHT+IE/TkquzP4ggQueLS98r8yrdu4ozRBE1t+Yn5KNrc0ectXwdTIGdjfBNAgyxbItSUV+XIH7Lg==
X-Received: by 2002:a05:6000:471c:b0:429:c4ce:eeaa with SMTP id ffacd0b85a97d-429c4ceefd6mr8497128f8f.60.1762166921518;
        Mon, 03 Nov 2025 02:48:41 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm148762365e9.11.2025.11.03.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:48:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	lee@kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5] dt-bindings: gpio: ti,twl4030: Correct the schema $id path
Date: Mon,  3 Nov 2025 11:48:38 +0100
Message-ID: <176216691575.32454.14353160997062734188.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821194710.16043-1-jihed.chaibi.dev@gmail.com>
References: <20250821194710.16043-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 21 Aug 2025 21:47:10 +0200, Jihed Chaibi wrote:
> The $id for a binding should match its file path. The ti,twl4030-gpio
> binding is located in the gpio/ subdirectory but was missing this from
> its $id.
> 
> Correct the path to follow the standard convention.
> 
> Fixes: 842dcff8e2d6 ("dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema")
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpio: ti,twl4030: Correct the schema $id path
      https://git.kernel.org/brgl/linux/c/4a372798e12cc777918db90c06e11c80e90bd001

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

