Return-Path: <linux-kernel+bounces-849829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB4BD105F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5803C18917EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE61F582E;
	Mon, 13 Oct 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3HK5yee"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DA1F8722
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317294; cv=none; b=WhzE1ChkwbdbYI3vvQs+8OuxYWpcTfSiu7tQGcyBQ+Kf8nG13EzGkxckG/qOT7oIuqlgHtSoAAprz62ZrVpNqcoCrdAF5OLgVwayBvLVRM49VLxBtsIrgXIE7lFzlQs34LJqUQdHQdvtfJBaabNltaAGxwC6jhBBLEQHP3OgepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317294; c=relaxed/simple;
	bh=dhrLxPGTCnTlpUoyVGvUo2ddd4H0lO2MQd8iMkm24hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CPM5HBPGlMVTMyXtreQvp0s6IOr/yrJ5xIdlEiZRm6/3CmSLS4o/5jXLvuW1zz+16CCU0SsyUOsjxLfsvieKNGjliu/gQGRCgS+7ON15yjSTwxtORWf0Bf82OW6feIYpijV95XW4JkR4wTY0E6jltgQfggFdj3tyAejg2M4cBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3HK5yee; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ec3db6131so8371825ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317292; x=1760922092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeD0ycGia2aeOxgxjZnlT8Vbvac6TmHq5j7KmcNWbBg=;
        b=r3HK5yeedWMBhfa0sYr+F+SLA2HAqukwK1kkftd9moxEbAJo4Oj3nDf4Q40DsHMmJl
         7/hJoemEvN5jh5h/hXpyscpunQ4Nm2hLgM/yRdWfYMJ9rArtRgBF5KVujjzun7903gfx
         h5+8wJEMeFnK1lw+XYEeqm8tgXXvDp/ZaOiH2C+keKa2TsuOm9soFf2klWvLJF9yb4SW
         d+0ABNI+gwAvO0bse3699P17g1wc9Hyl1lCaxBTyv1IaLIoilgNk540WLyaDi49EYc0J
         02tJw9h13nrC/6wHqLO8XEr7NkO5kLQLtTmKOm8cIcmd4W5VYGSwlDKl1XNpv1YQ6gCD
         98Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317292; x=1760922092;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeD0ycGia2aeOxgxjZnlT8Vbvac6TmHq5j7KmcNWbBg=;
        b=fQPxcK2S3uoq5s7AORxa9hZrjbk9HiONQkm+ZsnL8Er2m3YQu7P8aC+3WoFp9rAgtZ
         ym6XIEg4+OkxzK96UI9P+zzcQ7XcPindTbceC3WGvsCM6QwNQ3Mz/iAH9XA8mQhSHXKA
         o+jtwvH6tveWFe6q+NiLNacKYhXY1I008r4jllZO3UCuFJ59RBl6IeC/xfnPMbhy9zsF
         GdRODEHgUaTfg6ga9B26H/32L2E42X3t7GpGU46YK3KLhaomAXush79RGo5LEIYGHIqy
         7Mp1CwOko5mUeWGLHtiU2833CELKRdAFlbYsnVE7OBBEl4+Adtr0LbphQKDRevnS5BOG
         Hdwg==
X-Forwarded-Encrypted: i=1; AJvYcCUeniEPq3yZF6r/5OETrBCbwP+qsW9OHYh7yWZRBIDkd3x6M/dRyfBK2Dtii+i7MRhExDqs8ov/M/gIBwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNC+kUJYTuA66Unsd+fC2lGAa/6KthdFF1/VPOe+hn+nn+yE1D
	ohsJFqomIBqQ7Sjm7wPxTU1Xz3RsAh+TqbasOBexst31KztV7IjVdXcsa8ZmZcxjjMA=
X-Gm-Gg: ASbGncuCKbFrAqj367MC4xPKasBOiF1Vmx33etXeyK1+S0/Edkfx/7/R3SmP8tdQ6UB
	kP3xOCIpPnb52ZyFfXOk2dr2sKvlguTeW7oCRVU/QVAVNNCFhYL9nZlDGPlYkLXPaOzhOW61o50
	IFuOoKr4EcIvt8DeujX57FQwDq/nuAdFYezCUmkbR+MWcTNSWqwu1LUP4ioUF7UupBban6qeoXk
	UHQgy2+2grKWvnr86f+lnlSQJSlkQ+yDEv3QbU/D8mzoxZH9EpHV5Zxv02iX4FCZdiQWXtYDB+a
	qX3ZoEq22c9ApAfVaxCcsz6xf/6GijiZifXQ1faC/PRbRBeY7QBBjs5j2hW3MVXIRgx+3ApIb5b
	S6UPuidldx7TpJgwzqSg/7Ia5SpuPuNV8kxp2t7H01C5eq2JKPJVbhPjQRs06BL/n2Z0d+0BTNx
	c5b6o62g==
X-Google-Smtp-Source: AGHT+IHOaxNaAYL/G3bBHEMSSdgsFReOlc8/uFblf96ArsJ9WQV3cPQ/wzrsOXueFnV0tG611gnucQ==
X-Received: by 2002:a05:6a20:9383:b0:2df:b68d:f7e with SMTP id adf61e73a8af0-32da8461710mr14755652637.5.1760317291935;
        Sun, 12 Oct 2025 18:01:31 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250915095401.3699849-2-raghav.s@samsung.com>
References: <20250915095401.3699849-1-raghav.s@samsung.com>
 <CGME20250915094512epcas5p223e2eb264967508527f478eb2200be83@epcas5p2.samsung.com>
 <20250915095401.3699849-2-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: clock: exynosautov920:
 add m2m clock definitions
Message-Id: <176031728689.32330.1215080941311408154.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Sep 2025 15:23:59 +0530, Raghav Sharma wrote:
> Add device tree clock binding definitions for CMU_M2M
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: exynosautov920: add m2m clock definitions
      https://git.kernel.org/krzk/linux/c/4914c17a76047ccbde24397cf9d406558183d756

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


