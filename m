Return-Path: <linux-kernel+bounces-781508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB93B3135A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883AB622039
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE852EF673;
	Fri, 22 Aug 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/JnkB0G"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6C2EF667
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854948; cv=none; b=LHvwgKwdCDGscoPPvVO6TmJXX1pwrx15nfkbZur2xNpplr6SQGUlBv6UOplAQ0cDZ9YpzxYx4Bgc2joRTnhWePEXdqz9Ha7vCm40n17DyBjTTBRjSR26mRZ60K5cx1kpZgzv6hxx7xt1TQ81m+YkIdur2O9ljQn+ga+WyodMAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854948; c=relaxed/simple;
	bh=vBMNvMwlW7o6o1xWYoJMdECi7yJZhAi5LiYcGyrWEuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJx5XGORCXgx9wvjkx4GZEwlZhCTejCZ7QzGD0AnNajBfqQi/6EkHG27p84x7Z4C0GN+WGRvipMglDpnkfYNar63prUnWiN+CEdilzdCfMOI5ON1ONPTZ19PUg2A9Wgzrd9MtXcxZQLN8VOBU8FGlSONH8fSgfoq+yv/WDdEPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/JnkB0G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so11577225e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854945; x=1756459745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhkWbjoA7TQSL+zMe08xDLYt0I1Xn87bnNUqz6iscfw=;
        b=H/JnkB0GGHord41cjygWW2Y0MGaWUyXT814aDH7P/e81/E+/pbhACdkkKAsTTRYQ/G
         efFA9Z2jcA1aNEHsY4j1HagiQwK4AmA90VFN/3LRURYRefpMKCpusKpuaZQ8g9TGlCEF
         Qz0Qt6JmkgIB0YAxQ6vivlnOnXC62UOuk3UXVYefAmFtW0jHWfAMK9Hl+zLllwZMH7Mm
         lCOj1zxEtumbpBAyCvGR1fmRGllqKcaBXauK+evpUcCE3eIGgxFv+OcfqecQ00T24mi3
         8kpQpk3kIJCuST7fdL2w48elsx4BkFZhNkbBgzALHlRrvmKZClBX4XQ/FILF6E9GUY7G
         pm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854945; x=1756459745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhkWbjoA7TQSL+zMe08xDLYt0I1Xn87bnNUqz6iscfw=;
        b=NK7SUfYO7NLCFAYi0v4mf+rXdIsvB3QaHAbW8vKbL1wdsvk2iZWOzq+0OI9cJgk64X
         f9xkE0zziTm6agqUZPwcxqs6kUzJ/E4yrNrhTSYDh0ySkdhRYicrPXT3cpX30c9GJYa8
         gZJw7bJz8e7WZE4Z5UhdZsEgZ8DMhwEPIxfEJ9tURzYeMnA3a+dm+UdNoPgO4t/3wCc6
         Vk9locw4hOrdMjphlColShLsYSTaxMQ3C06EOx6hlQCl60eEij6t2IIZFNsZ8Db4Etqg
         379MG++dKI0DklX2FXLCJcAm5LSLTigX6xWUKqLkJuVGkoGwrANOmlYVHlNU+TgX/vmb
         5Z8w==
X-Forwarded-Encrypted: i=1; AJvYcCWdrUuW0ORkFhsZMPdqZU8xDiLGhUREyh4wEXFJakRlLEfjESFjRcAW7cBmUw3027jJCTFg9EV9OoWxLXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvh2pt8tQcwthT/2TrhPi8n36XOqCkynKpQbSsmfbPqiSRcfnT
	Na88g6JVrE0TC/Ufpxyxqz44xU8JIqDDZecvip4xooVEe8fc0sDT25hmuUrKwDppBpg=
X-Gm-Gg: ASbGncsXetYyisfrSY/w/MPzunvBx4eWmtiqieFXi/OyWFXJH3nXvrzQNc4NTRRs3VE
	IynAW7wfFsNU64NNbfvyTX8XBlkCWFScuD+eoBZz7pi/w3ZUsoZFzvpJNdL0vNAZv7W+suZQFaY
	sRtrS/eZlI9RloVDFYjYfovI8xvoZc3BMmhZyKoY/fcAaHMiUxlnVLyu6AyJJlQs1pbFs+hNphi
	vRJAMtW5YNTK3g5h8HajRFrvEJJL9jJRlzsIycGG8QnXLMzJ6rutQfamuIlpxjEke92Y7eFS61x
	6AV7NbyIMd1rE7l81Y+Zuuh4eGu+5MLpYmYQyF7DDEucE7eCOnF0Q68kUBcsI36fOZslhop4yQF
	G+7OiiRI6SGrLyeh9DJBHdIJnu4Z3fIb1IkSwYg==
X-Google-Smtp-Source: AGHT+IE6Rfg8U+FIj6zpFxhGKTsfkPpD/3AuuxhXFzsGfi41Oqhra93t2reI6lzi/1xZXfxdbdZ24Q==
X-Received: by 2002:a05:600c:350c:b0:45b:47e1:ef7a with SMTP id 5b1f17b1804b1-45b517ddc35mr16587355e9.37.1755854944641;
        Fri, 22 Aug 2025 02:29:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:04 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:52 +0200
Subject: [PATCH v2 01/10] arm64: dts: qcom: x1e80100: Add pinctrl template
 for eDP0 HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-1-6310176239a6@linaro.org>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

At the moment, we indirectly rely on the boot firmware to set up the
pinctrl for the eDP HPD line coming from the internal display. If the boot
firmware does not configure the display (e.g. because a different display
is selected for output in the UEFI settings), then the display fails to
come up and there are several errors in the kernel log:

 [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
 ...

Add a new &edp0_hpd_default pinctrl template that can be used by boards to
set up the eDP HPD pin correctly. All boards upstream so far need the same
configuration; if a board needs a different configuration it can just avoid
using this template and define a custom one in the board DT.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f293b13ecc0ce426661187ac793f147d12434fcb..32fa9fa6fb946c4933f74fd0ee820ecb9284901e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5808,6 +5808,12 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 239>;
 			wakeup-parent = <&pdc>;
 
+			edp0_hpd_default: edp0-hpd-default-state {
+				pins = "gpio119";
+				function = "edp0_hot";
+				bias-disable;
+			};
+
 			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				/* SDA, SCL */
 				pins = "gpio0", "gpio1";

-- 
2.50.1


