Return-Path: <linux-kernel+bounces-780265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208BB2FF72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0590E4E6574
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7602848B2;
	Thu, 21 Aug 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE5meurF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A5284696;
	Thu, 21 Aug 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791894; cv=none; b=OCY+s53eUpfBybQ7itnVXEWqGffPKHZVXOmVUzYhlHTlvYUCSEz0sCG1PBV61oJW8JHf6eE9cv/p9FtgfwgvdiINQhoCpjY3oXdlEQVKLy/w2dke+lHi6CGXxN77P77JJRdMJACwS3eApL5Xc1fpvhKAlzDVv4NxSuNytN24Re8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791894; c=relaxed/simple;
	bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUMBijnsiI+xAUiLqrywPcT0kb5jtvykdHjqTB/d/iPv4ErF+H/YRWmIoq45mvMUBCfQJklzwu6nUijIkMC0YuKobm1E7gyrkGwgjukfY7Xxt16SBuA4ALog19lrRonqFO3AzfyrdD5uU0ikhOt+53nvr58hgfLnuEbUgkSWg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE5meurF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1147708b3a.1;
        Thu, 21 Aug 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791893; x=1756396693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=nE5meurFQVpJAByq+Ncw0Trll6f6+OC3q6ohNDt4Ai882EX7FTOFVu5h7gfsp+monQ
         ZPhQaO+DYwQglcGsqP/IB6+Xss/cdQ1WZyNTwPrOnjaSrjlVYPytJji/MwXcNYQ/1txI
         m7DKaa38224IhyCYN0ayCYXu0zlj7rkV3Pz+ZGWaLhLsK4BB5XvcSQvzk8JZ7lZ6RvC3
         DWUHHZA4oDBfGJYPXSDWTv8mcsvDl+gXNcHnTqzIz1mxs08PY9zB8Y+nAWVaT4/Hx2Os
         fZSAnHMeshK9muqQIaVJq3/Gl9FBZyCxGswXiie0MljfTwQVeqVrYhRLdfpASE7SnH2D
         u6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791893; x=1756396693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=f85CV4rQVuhIfG6GyLIaIS9a4rybszT0Cbr9QxPQ93VgnyPhIuSW8SCC2IW4sVHtib
         MPlsLSWmh3poAIqaltUawr99D0vJ2J1sfL0ZVTSH2OEdpbZDqe9ZFiUHxdFX1K0u9EJ1
         8GG8UrPK8YQ0NN3akj+JVbegOgkuRJduP6HEjyi+5cE6DkTe5wtJy8sq15QFe1aVmQFW
         4Stwk6R49X26cHX3kJWaM0haXkPIfxC+iGID00DLo20rca8DkggeyroMPKrF6W0pvIuQ
         0hQN1EAZwB3uuGDB+4wi38Y+6IzLAT+ImlOiSoRI2C38sYYJ4yc4miSKTwg4soykaoVu
         9uTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjQpXkMBjh7GwWbe4O/k01Xy4qT8gQLQ+b8ctqdtmZPw+dKeiBQ1q9vqvyKD3b8kkhLR/v0/CF0x6jjAZ9@vger.kernel.org, AJvYcCX4B37YE5dPyu2xs/DOdBO8KdYGHXfDRkKDw+bM9MM3uehscq3cEMGKTwjXlHaFBCHnK2S3wDYOErQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwdtmMi4r/OVZSVmmNC3dXjDSrQObx0+qoKPjZbHYgQ/pNWes
	uWiop1QDD0f7uNFN7UtQnYnEiCvu/vHTehuIsdiFxDCytJIhEW91sPi+
X-Gm-Gg: ASbGncu32DAUq3IfduyUS2Ov2qzNYn09dQ18OW9CE16nrUFaWh5KHcPsHDeykAS3W90
	wNwtqu0COkM4n1zJBist3YoDhs/kmk6S3zKNRcqkIUfqJekKiAk9folloEjSrorLXXtldKLSRQu
	yhBGUcHeVPLRzGqAAM2arX4U+pzGQP7uGmwQUV2rmpb8MMQ22ZJ9jjLn0r9lVfdoXkTUungY5Ap
	ErP8yZJ8JzmBY+KWxSB1hiffSgPeP38G9VGCtPBIrz1AZYdNd0rRNDVVTTZjOo/kFgJ6oofmvLj
	nY3clb+YiG2rovO4HUJA75yZC47U8FxsFBJ2opieO0VErml87Pk0AeLJn3tl+DoFG4n3dRRZLnc
	Kp67+nT651ACSn6KJqSoWeja6Ck2u5p3TzGVoexaeGTmRJcQ=
X-Google-Smtp-Source: AGHT+IE1q9OtVvcB7jD7CQCK6LT73Fkhhe6O1oTYoqIaF9COWn7bTSzZtptOlx0VklEzRU+W2Yg10g==
X-Received: by 2002:a05:6a20:7d8b:b0:240:387:cee with SMTP id adf61e73a8af0-243304a2ddfmr4276481637.0.1755791892695;
        Thu, 21 Aug 2025 08:58:12 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:58:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:46 +0800
Subject: [PATCH v3 9/9] arm64: dts: apple: t8015: Add NVMe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-9-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVNEQSbAL3+tZjzyN2WWJPuPis7prsUJE4e
 r+/j8uvOM2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JHtuEACKC0KzhrgUSgUD0OWXRKnND+KJS6S49TEY4jfE8wS0+7bDXXPBH2LHqwFwyEyUHh/y45R
 QBMjGqJsVuFtjLjuAqJea9McDOJOf4anhYQck9UPhKFl5+COnr9pw9/Hw9HrvMN+hjML603tkJW
 MW3sW4RscbE5AOdDH1+W3o7Ib11FaiVAnEbu+XX0IsRfOgEVCg4QdPWM/UCcaBk3FZGMS3abXGn
 r6lqK/zwO72cRcZg27mdKqnitSyjbmqBF8ojB9aGNnET/9OeyaH3tn7JSIASY1wlarATt+z3GyB
 zkuVbwthmU8wJHm3xeq2bzEdpAdRxY4qn/OY08yzrXaJKnJi+Ex0yiqW5eHXXyxWQylH62oUP//
 3YBFV4eFtDyGy7ApLSESHfrQ5ch3m/1J21oOOR5+LB2yzcOUajZkbCK1AzgzPHb7cz6cZI8LQeJ
 5QKjLbi7r2JRXTjlszmvxMpi/0Eq3ap3uCeV+rs3FQn/N0N4Bau3X+joy+3xKmTHGCR3GEhqGgx
 8rRN5rSrgf/UTKqsiUq0C4XPwE5nCOvg6WczE8UW5ORdm7z3B3ls0HvvzZRJsnDL2mhYYlRQJ7z
 l+TYMXGGRm7oI5MJfKau2yTunT+RcXdSK6+6kA2NjHOcNyRxOs5UeT9TLiXcEDyZYFFJQ8fPDDG
 iFMSRxoy6aoLIKw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add nodes for NVMe and associated mailbox and sart for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..84acf2839fb6279dcc956e1f4cee1afa909d2f27 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -402,6 +402,40 @@ pinctrl_smc: pinctrl@236024000 {
 			 */
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@257008000 {
+			compatible = "apple,t8015-asc-mailbox";
+			reg = <0x2 0x57008000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@259c50000 {
+			compatible = "apple,t8015-sart";
+			reg = <0x2 0x59c50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@259cc0000 {
+			compatible = "apple,t8015-nvme-ans2";
+			reg = <0x2 0x59cc0000 0x0 0x40000>,
+				<0x2 0x59d20000 0x0 0x2000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_pcie>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
 	};
 
 	timer {

-- 
2.50.1


