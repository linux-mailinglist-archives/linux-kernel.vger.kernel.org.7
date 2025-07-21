Return-Path: <linux-kernel+bounces-738901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E384B0BECF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA68E7AD3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2022D781;
	Mon, 21 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQcDS4Pk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CED288CA2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086295; cv=none; b=aqloa0omEFFRdpknR1kvOF62Uw/95LIWF7sGx7ZvAesPuqr4wsPCtAq3LFylU8IJxj7N+yQsnixHEOvii8wxQlSj3Ltw1M4dxyQmw3pYbnergIpZlpwuE6RIL+0C5goV9ShgalsY8CNXZcc31cSD0UzFi0l5677TCLvf5H4PV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086295; c=relaxed/simple;
	bh=GToabdAjteaGCUpBSIfqJ1avVfcQNejcqdkif1y1MYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAYmWfdbes33dZSIDCoFGL/Is67bsqjAQcPp6b/Or4mYw1Af7ElnnvJQbLdo1iAZsaA6C4Ha1idq9QpAqvk/o/5d1Fk4P0dnT4P++WQFsmJIIveXC+dEzWpVugtpi4vnE9sbnhZ21gFGoHh/f2JJZeyqJD4Zh2SRst/A0ebT+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQcDS4Pk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo6311234a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753086292; x=1753691092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdywicGMC8PWpQoI79nyLjxZDbmHom2ul/36bE097Ak=;
        b=EQcDS4Pk61Mgp0W9F4tMkGkQC/6+O6oGY2HLrSlNNGOiFjNJIwCU8L4GW7tY3GC7yN
         G0hDdYRszLA/IOpOpgEM8Z99MABCGKKPP0XSxCCQNUqfNT9OlqK5yfg029RUm93mDQwu
         pSUJiJgphXPw8RDy5Ae4nsapbsLJuvVtUYnA6/IfCaEQz82LZVsp02k/9ng/uYUqFlTq
         SOMLOH1mfDxuEzGAu85vEtdUAPDyCUMVx+1sz6se0z6lm71MY6yIrA7Fj+kCnzdThoP0
         B2X91Z8Ve6C655tcqPUzHGWHQUy/NLaJ4voOGTZ9lfmdtvJl4/Y6Nvq1miPuyS/6pmMZ
         WRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086292; x=1753691092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdywicGMC8PWpQoI79nyLjxZDbmHom2ul/36bE097Ak=;
        b=TeZicqaspOa+YdyqVXRkBE5lOxS36fzCWEjYSRopG6sGRGH4wjwYVkQearmBiSDDp/
         tBICHpQgrWgTYQVal5m4QTxjCuWHYPlSYlB4I1anSnWSYy3x198uz6O3ByO9HQhPSGwq
         HNKoWqoN/BR6PgdNPwdEwwN3lgYnhLD2X5jImysDL5vyye878lA6/8RK2XfeoTGjr9q+
         D4xGFEN+Y2v9k1KfKqxgn3bGmrFR7waom9nmR5QOZO5/w/VE93Xf1dAACuG1m4Kodiht
         YUQ7J3UqqGEXeH4vo0C1MoTWl5u4dd7b52jfeyzeHGERQeRfmzUvmZm2CHXplHz+vXli
         VSVg==
X-Forwarded-Encrypted: i=1; AJvYcCWUxaIMO3+ls/yHvw05SrIqDntFrpw1dMgbp09+KNR3SYJDc5NJWLzkcsg2ERv6rNawe9HpScs9MQLi6Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoB6wodtk7OY3qHvKEJtzIGFGXdCd8SLsMRtszLtg5dEX5oNbK
	N7Bpso/DP9JCJAzdTHoB1H8AngwTHNFRMFlyFawvMSJLKpsYndvSmkp/j1IXgi2RpRM=
X-Gm-Gg: ASbGncu2VkdSlaA9yRUpK6l76sC+lg8UVB9NMt8VnM6ocZka9G2iIqjAibQNKMdso0K
	xZpAcLdUJDZDQ2RlGGr7Rx623UCTo6IFZS7uMbJjaJAZRZLZATm4Mi4UKSEJvh2Rooz6hp0rK2i
	mbP7BwEVp/+nsnzMj6mgzf+LB5iLzA7IQDb03MBMlYR156f6HYx32WX9nKgFQOXr8v9sWQ0P8SO
	OWNiXIRfuHr9HOa20WutHfIWA8+r0JcwMiZb/7zWEHFjcP4SZnXs7ApynomEUfJ3IQieuXay0Qy
	of1iGUS4N29plWQgcOPMZlMm9EtXFIRCAMlJhWAJBvSbIzhUqq7GfyBKIXlQQvWBYLyf+Xc/+ua
	JLReYGEp47SwnlUSt8OiB
X-Google-Smtp-Source: AGHT+IGXBWkrr0OYxAUb4JL3ZpYz7yNfjNojugUdotLeKq4sWMewk8MwN0wQ2Tv8Q662Ax1Tz4MBzA==
X-Received: by 2002:a17:907:1c17:b0:ad8:ae51:d16 with SMTP id a640c23a62f3a-ae9ce198bf6mr1960198566b.55.1753086291837;
        Mon, 21 Jul 2025 01:24:51 -0700 (PDT)
Received: from hackbox.lan ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d330sm633826566b.126.2025.07.21.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:24:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sandor Yu <Sandor.yu@nxp.com>
Subject: Re: (subset) [PATCH v3 0/6] clock: imx95: Add LVDS/DISPLAY CSR for i.MX94
Date: Mon, 21 Jul 2025 11:24:46 +0300
Message-Id: <175308625432.1291588.12529765608002208630.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Jul 2025 10:24:36 +0800, Peng Fan wrote:
> Similar to i.MX95, i.MX94 also has LVDS/DISPLAY CSR to provide
> clock gate for LVDS and DISPLAY Controller. So following same approach
> to add the support, as what have been done for i.MX95.
> 
> Patch 1 is to add the binding doc.
> Patch 2 is fixes when supporting i.MX94, but the issues are
> also exposed to i.MX95 even not triggered. No need to rush the
> two patches for 6.16.
> Patch 3 and 4 is to add the clk driver. Patch 3 is almost picked from
> NXP downstream with a minor update. Patch 4 is modified from NXP
> downstream with a few minor patches merged and updated.
> Patch 5 is the dts part to give reviewer a whole view on how it is used.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: clock: Add support for i.MX94 LVDS/DISPLAY CSR
      commit: 0b0cd1857b783711b4bdfb8eb513c263b8a84f6d
[2/6] clk: imx95-blk-ctl: Fix synchronous abort
      commit: b08217a257215ed9130fce93d35feba66b49bf0a
[3/6] clk: imx95-blk-ctl: Rename lvds and displaymix csr blk
      commit: 88768d6f8c13ede81b248177fed3ac285499f77c
[4/6] clk: imx95-blk-ctl: Add clock for i.MX94 LVDS/Display CSR
      commit: 9678bc7661cb34bec4be92685039eec68ca67dad
[5/6] MAINTAINERS: Update i.MX Clock Entry
      commit: c78865241ecffaff7ce5db00ed5b71c1a70c0ff1

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

