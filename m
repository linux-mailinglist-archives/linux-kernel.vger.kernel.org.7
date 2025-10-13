Return-Path: <linux-kernel+bounces-849817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52626BD0FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E04E6DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028C19E97A;
	Mon, 13 Oct 2025 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOjzvtUw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1F1519B4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760314961; cv=none; b=GlGuQ1SPtNTBq3a8B+ONbb9cqazzAVZevvkE3F43A8VqMMosAoyPU3FEspbkyafBflvaQrYE7RMkFF6MOWM/vvGJ5tiFlsfUnJvimvvB4cfN8xe+4W1SStg8svosWtrSk5u3524uxZCHrakZGFeTE7s9dHRhyxEaDs0FNUiJ59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760314961; c=relaxed/simple;
	bh=+dTERHXHwlz9Q3on1s7pnMr9sQk3vgyQfbNftxESlcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=slpSS1BQkk/SgXTLuQCDzPFvxvI3TYdE1Uv41nbbLm9bIKIM6OIQBnjPKnoiSpBtXVfVhasEbiUCDfUQNEX1A5vUyOGotVJUxlN70w6rCqRSdaZbetoBZzC2ESPinvvTC0mQnpBVBQqbYM/8HqrLLONLTJmaJDFUvkC9YGQE3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOjzvtUw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267fa729a63so6385855ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760314959; x=1760919759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVqRhIZigralax4KbuXiwcZcRbWu9Ae0Ahc/RkKiB+M=;
        b=rOjzvtUwp/yh9Kh5vxsDTCOVN1ux7BeMhZj/iu2ZIEnG2yKMWynzfeKQxi2boBYZfo
         iP2Pf1lS60xMi8jpDyGch6iZwU9MEF44nvhQfNGgfA0G/Dwp3ttyk3EDLU+acZ6exYtH
         4aVdXAeCAmtF0lxf9aByTpE9GktHtboLp9G+sm8Kv8bwhpBU28rX2W/DbnEtjugt6Quv
         63sMOKRUEWSP+fekAEhzeMk4TD8gUZ3qMPo8pNBfc+pZV62k9cmtEF0mbuy8Qm6CcZbP
         2oh/hvaInb/P+yP99xor92f38GTeiLu9588d/tvNTrl09qY19pbRy0eWaKfLk7JIIw9B
         I4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760314959; x=1760919759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVqRhIZigralax4KbuXiwcZcRbWu9Ae0Ahc/RkKiB+M=;
        b=ozczXXNJieWjG/E3lmnY9BXbwY4KTmfeg5iQOUpvhUV6IWeGhWAyAYniB1HuBxIlRg
         Utf7G1/wWWYHX7Gq5OezCkOzHCFibxA5qH00VntSpXxc5w4pHbPAcIbjJm8mFts4WkOB
         PQNRfP73p9kFhgOA1QC5awPaw7qa78JZ1BBmqorA9Mcg0behIMKt2DdrOSgDdZElLdoh
         ewBPFFBDlFY4UdUClqLzfNEPOUepeoPkM11mOLkYZxVz5mW/RsXWqZ36pAscA/Hwg/2x
         ImD+l3z5cieyIUmIgMesXEOPYO21MW2L1b3B40Z2BK5T61WzIGEwF+iqlyrnA2JVNPB7
         FJaA==
X-Forwarded-Encrypted: i=1; AJvYcCUTwEiz5KIuevhcephHX9FREwIFH7We3e15USGTOc/Hfjwp9w7cknBzYLBMpCd0B7LS5L3I5ZfujhFXMNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfd6Qws9R6u0rSj7L+xvqk9pBdPuzb0ngalOeKsq17lbkQULlp
	1Mkye71YG15/qBsO0RhQO33jSBM8t/5R3HTkdlJUFtbwuxVBdtnwC/mc3JZayfsWJI3uxuvtPsL
	YPoHq4/g=
X-Gm-Gg: ASbGncuZ6oYnwm/OrV9mrXV3vuxHij8uR6k3Zr4SJUqKrzRgzN37SbntcsuyfcyhGdq
	FaMJrKR0GNMCbaCCHPiRMtlpfO46nEazzjZLtn0OsaK0Sum7PoMluCKNX+OwRX/1RIXincmtNOT
	Rxh7pwVx1O4wl0QZ2lAjZ8F+PBWXDgDwGtYha1wSlmWA2w8Glm3iQ2W99Gw3Plxe2fQgtp/q/ub
	oaAoMsZ20kbLyq+zek4FdJQL4O9wU91OiNOT8VsMr2641IVDk6FZS5YwoyijzpQOgyRLEY/JuE5
	oc8o3Io72vnqfZ70n/FUpl1dlXgp4SCkoGnyp9ps0hF1hpqNudRFPqMTgK/jfoBQNI4XGInYJeV
	XQT/jyJD9JfaUsDaX4spUoRoLs5GPU93Qea7t79zDmlmYda4cuqZsWQIaVi0J2/4M3iiVX3c=
X-Google-Smtp-Source: AGHT+IFK4ci2TGNbmqypL/3bygm/UTzER4LfBfP1yAru/4qRR98/cUW50Jp7i5jycMDRBEjIp5poiQ==
X-Received: by 2002:a17:902:c404:b0:277:c230:bfca with SMTP id d9443c01a7336-290273e17bfmr142190255ad.4.1760314959008;
        Sun, 12 Oct 2025 17:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f05bcasm115840285ad.84.2025.10.12.17.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:22:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v1 0/3] pinctrl: samsung: add exynos8890 SoC pinctrl
Message-Id: <176031495194.9871.10054397457165667570.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 14 Sep 2025 14:44:54 +0300, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds pinctrl support for the exynos8890 SoC.
> 
> Best regards,
> Ivaylo
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: pinctrl: samsung: add exynos8890 compatible
      https://git.kernel.org/pinctrl/samsung/c/9be3b7bb7ddd4e8ed466f41c6f43de34424aeb8c
[2/3] dt-bindings: pinctrl: samsung: add exynos8890-wakeup-eint compatible
      https://git.kernel.org/pinctrl/samsung/c/f416d35e6522f0c08d4e866e5d6930bfd504e645
[3/3] pinctrl: samsung: add exynos8890 SoC pinctrl configuration
      https://git.kernel.org/pinctrl/samsung/c/5b6b7d39cee69373dc61ca22164d616e4faf60c6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


