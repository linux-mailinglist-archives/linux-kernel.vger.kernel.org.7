Return-Path: <linux-kernel+bounces-781516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E00B31374
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477DCA20FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0B2FAC09;
	Fri, 22 Aug 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7Ix0ue+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81E2F7459
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854955; cv=none; b=oarNxyIItLlt+1389IS5Rs0UexrHFygl0o16kiR0iUGxZb84uj6zKLvxim0wMNPsx3Lxr4BxfH2Qq5n9k0sI1DpQfwwWnXat0AFLyQIGYO9hsxjTtH+n9OHVzkQBAibq7VF00zsZulNGIhJ/VJT5Xe6t6W1JMuTC+HLN8mP7+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854955; c=relaxed/simple;
	bh=ERNuIZkN5ATFt8ONMED+YutJLbS4r77RLXsvAo5QFc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HblQktOOYbPu8WgGWS5nnHgyCo2rvlDevqUwN/ODx/eOsbtO4YcrhoDcTcjiRziyVqIPXrqvBlv55Zoh6YaRYJCBa3gySqO6qxAENKGeeyQTDEr7si/l1hDpohNZIkJD83lZJqmzLjQz6m4Sk8jLpk3+rjDyQfuSWVeqrxvcEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7Ix0ue+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so7656f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854950; x=1756459750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x25HpmMhtyzw4pSPQqFnXsxEXCCiKqiHTLmj/iokeBk=;
        b=C7Ix0ue+dS4i7g2mrJjIRXeIZBrgiZrYs7z80KbMdab+q+WQL8L/svGaH56vFn7X00
         gL+FUHFV+zPjnDRZfSNaJleUsJsz2JxZU2hQlB4hg6aF+KugcS2jBNAJSchL/BCE5V21
         hyRsh2Utghj5jIRfYCNnFhcx8YtBWDTf/1LhkdMwq5SdNxb1L9U2mEfQpkgbt/q5klYM
         YinVsDNo9gU8ELMgFH/Q3Crsn5Nosa6FEztNAtJWlcND2stLu1eInhk2z+1iDtvlzlXj
         MN+oEU53ESvgyEVPfQhVIJwSjoWV8zn5LFeVArHXpLe8LKFxxB4DDzoizovLPYcwv9ya
         kA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854950; x=1756459750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x25HpmMhtyzw4pSPQqFnXsxEXCCiKqiHTLmj/iokeBk=;
        b=q5wiB5W4xBmbso4vCbGNYf6C3JIAYJZJprwcogvJ7/WLGfJhd/yLMeXHMUCHAlM0ds
         1tse7ti0G/mki3l/nz8+Ck7V7r1284Yx16y33H58XP7trQ+f0e7sS/PE4VW9emr2wrSw
         jzm3FhXJRCbXgtpStca2gh5b9Jld4DWhkT7FF2QklZyBYf3X6R1cyh81NbOyOdwUxC5O
         wn2r7ut7B+Y9oFvWQHOTKJgFMqL3id7yZasRczs7FQD7XuIlQL/ZhGw4X61twNMDKMpE
         fBNREOwzUEGGuP0YxkKYc/MvSga0SOW5nqjLu3aqnOxdM9DBO/P/jPTbeqlYBpa6Da3M
         3vyA==
X-Forwarded-Encrypted: i=1; AJvYcCXiy3zWaqnnUzOsQ87PROQ9JNKy1qbwfakRMxQ2uOTNSHEcHktx6TPwGBZ5IqDErBYFT6dI8xbM5BHBlBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKPJZTV47udctejILjvYg5JZ97xW0Pcl91xE6O60a1ZMjbM1r
	EXLxlgP6bjNzXY+nRk0yRo84C9HhmB3jZ2m3TCaCARQ55WQuANLGllI7j5/l4YUviJU=
X-Gm-Gg: ASbGncvFokOarjLKOAbKDn1GXjkee7IaWoV0aaxygq1STZXfw1hbgjWkKdP8/NU0aNt
	AE+FJDy90qlGyGgvMAqzksWghIlTWdUhYRsKXhnuGbqrVzINCKRlVcI9jT7J54tqQD9vf3hE9fy
	3AfxTPwdOsFLLQLkp8YoMobX2p70X6gHrV3qobxCWt/GJs6VpE/1PEAJkcmna7zAK7eEBx13BwA
	4zE/xYHYRCeJWLO3FSF2aCNzwiP/mp8fAmMBWwgaoPRZghWK6A8zYlS7DDjUxvKhOjwleqY91Xq
	h/y2yDZh81rVz3yCDdKgQSk6Mm2ka/5Yy18HGtvB5pQv5M0A/S/mVvs+QQvZBAT7L+FKwh5gCnz
	PtVM6yPx7Jpgx8dyTWXxUd/PuEknr5cBgcwu+m1ZjmH9v8i9x
X-Google-Smtp-Source: AGHT+IFo9o0397QP0rIc9HSMi+53dF00Js7QjeIiFJ6298UmkDNi9xmJ0KwXYDGqcFOg+7NrqZQ2zQ==
X-Received: by 2002:a5d:64c8:0:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3c5dac1aad1mr1434196f8f.25.1755854950063;
        Fri, 22 Aug 2025 02:29:10 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:09 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:57 +0200
Subject: [PATCH v2 06/10] arm64: dts: qcom: x1e80100-dell-xps13-9345: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-6-6310176239a6@linaro.org>
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

Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
bias-disable according to the ACPI DSDT), which is defined as
&edp0_hpd_default template in x1e80100.dtsi.

Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>    # 3K OLED
Reviewed-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 6b27067f0be66b5c41fa681ff3b4f535100bdf59..eb87164fb15a50fb9190706fae8225fb3a26bd08 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -900,6 +900,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


