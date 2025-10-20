Return-Path: <linux-kernel+bounces-860573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33440BF0707
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05F93AFABD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6F2F6563;
	Mon, 20 Oct 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaTmQs8s"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C82F83B5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954892; cv=none; b=Gb/A7M27BdF6DmdE8+sPR7j5ufjxUTeZzAX54Npp3OazdHsM/BFd6on4m5FyWQ6UanveyP7SQCQA0YaUmkL8mQ25+rIr2680CNN4ikmmm9bVpkRGlGXprymkjdCkWHUNyrWQinvArwZ9cMPqyGRFyIJ/YsK9awh0wy7sKu/7p3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954892; c=relaxed/simple;
	bh=IthgwRg6yJ7su7+hxwU0G1XvJdmaJcprtOIDD6R14Co=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l6abppB4AprOIDQp2/fi2lECIxiRBAfJXT4OD9Nx2aaH1TRQYzpVi0omB2owLTDznVCAB4hEFmV7gMhveeYPMwjpSojCG32Tr4aP7p3z+w1n0BxlJif2kupRlRWJNOh7KFLsk0Ay9zfTy/rJlTIwj05QNxAayGZJNwPC9dWaH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iaTmQs8s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b1eac8460so93556366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760954889; x=1761559689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELGhRwkcey/M8p9/NQ4xSZezxHFCzELpwhxQQJfRai4=;
        b=iaTmQs8sGobgcCnAwOGcT2JMt3hGcDM2rPSWUTW1hga8LZ9R+75zYPYjbX7jjgpoK6
         xxGGF0MoeP29S5daUFe6Y7UMZZGOCjnYK7CZjFioe/glBogpjdOLXq/xKJ/A7/pIgFPw
         r/K1Z94H9ICDSPJyHI+itNbBjKgacdeL30X0uxDgGHWtJj9oeJd7uabpph0gOjivglKw
         2e7pZFgFSs1OTsh5lhftQBRx/MPk/ZM5/8l+nordHY7nbjIE62hJhtKA7yAkbxQ5ZKg7
         P4VAYVGV3s0WMixyh4q5nz1FImVxR5IKFGSBMJwNdC12Ui24JOq9cnKwMDoymEYFFJCL
         nZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954889; x=1761559689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELGhRwkcey/M8p9/NQ4xSZezxHFCzELpwhxQQJfRai4=;
        b=r79BOgM00ifWX0szVeR+W1DFZ3VnofSbss/ufPfow/cqEhSmPdHClUEyGd1PJEqAwo
         RubV42F7pWLD/88mm2000wv0C+qgvASxqddjhjtfZCA4tj18aGP2kFNDRzTqgKHwfW5s
         EEgsX0/S9GYfn0p6bZKhZQAv0tGPV+FGIH3PqR/+5i4cVn1WShQXpVlqouLsx86RlL4U
         UYmWahc0290/kWQYIpdaCNCFewEDSbF6/l1gEJie9UW2SzgKEPE4l+hlhEy1pl/q4GL8
         ZiX8IEeweef1aCMdCWEBzQx5H6GF7mV9NxrlcCCmqEWt48C7RhpjWYVp7EafxeHQiN72
         F4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJPROWaStvgVlHo7diwxpbFfKnIJy5b2lD8uItpwzEvMao9U7GuVSTRGG0MjoG107KZi+KY3PFvmYMXOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXCoH6YFMkM5D+6XhM2znmohbYBjS7JTap6o/fo+UxTiFiAp5
	VfVwDH8b0pNBVbtiMeWVQTJm3n5uZxW5WGbA6+xy63fr5FqBskJWh+M3pZnIyLGBkL0=
X-Gm-Gg: ASbGncuMU6vM+9NBbBDVdyiraC5LY5T5YzNYSTitSq8DtZbla6kcCLCd9Q9DCJzSdyT
	oaW1BPKw6589cSGJTUQSGZ32D/MmnjMfzXqZv/DEAAEwCYZucvJDfLMA2vmC5QuTT6Bz7SGqBBQ
	IMhtxBUCHrhQmL2oeuxOQq2m89xymlZJGU0DMPB8oUbTz/4zpEcKj8Rw2M4+9FDjD5UTVEYkckw
	NP4AN7Z/TPzysGLCKpw6X2HBL7l/UZyZZYMWczxWTBp2iDTnfcBLTuox830JmP3xuoF21kSxx2Z
	ADNxKU5GPJlxgQ3kx0fOt9WXSvUK46NJLS4d5NbCjqCmE9Ymd+VDhcbCLCNPXRCDf4U5XAh1Yxi
	fa5+4+IH5JlULtQxvA6mSG84CtScPLQeqU7B2Azs/WO6dK+YQdtccF6lwtgs9XhFr4NmOdXm8Fs
	GXJ6kz1PaaaDom54vtAaBEGfkfy44=
X-Google-Smtp-Source: AGHT+IHb4qKarfFb2e6yhqx9qlyNVzUbEwguNDAebFS+BWqgt85Rblg9ZZAJ2S/IaUQJYck+aE3lyw==
X-Received: by 2002:a17:907:3e98:b0:b50:5956:482b with SMTP id a640c23a62f3a-b6474b2e281mr817509466b.7.1760954889230;
        Mon, 20 Oct 2025 03:08:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm740987066b.54.2025.10.20.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:08:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shenwei Wang <shenwei.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-imx@nxp.com
In-Reply-To: <20251009222716.394806-2-shenwei.wang@nxp.com>
References: <20251009222716.394806-1-shenwei.wang@nxp.com>
 <20251009222716.394806-2-shenwei.wang@nxp.com>
Subject: Re: (subset) [PATCH v3 1/4] dt-bindings: remoteproc: imx_rproc:
 Add "rpmsg" subnode support
Message-Id: <176095488745.45867.896865155474758901.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 12:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 09 Oct 2025 17:27:13 -0500, Shenwei Wang wrote:
> Remote processors may announce multiple devices (e.g., I2C, GPIO) over
> an RPMSG channel. These devices may require corresponding device tree
> nodes, especially when acting as providers, to supply phandles for their
> consumers.
> 
> Define an RPMSG node to work as a container for a group of RPMSG channels
> under the imx_rproc node.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: remoteproc: imx_rproc: Add "rpmsg" subnode support
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


