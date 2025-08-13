Return-Path: <linux-kernel+bounces-766537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592BB247DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C95F1BC234D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EE2F90C7;
	Wed, 13 Aug 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq5QvW09"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7D29E0E9;
	Wed, 13 Aug 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082830; cv=none; b=nxp6iqV6TxFuVnAy4VlKAW4g/FwS+QE62wJvfKo5AFMDER4OqT3cRx1ejXwd7kyG7/Wm11Lcl/TKmO1aIo/5EhyU7jOPh/TEXUzOn1M7l1XnK/UWdqvoxlRZ/P81lVJDAlRRgffxI0fGBmTgiNqR5egPI+djAXQsAbSPPU+u98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082830; c=relaxed/simple;
	bh=5pKdf5KCw8Ie22dGIIzf7YdaNoocUlU844YIpUij4cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnW+lZIuHREf0U57ejd4PT+kAyu8qGyIz+uHzMMdPe+qUXYrLOOpQoA/Jj+bmyrgDeMmI/+43mKs4VI0hHogopN5TThA+/VmqSf+YAqbJMp6ABfNHYb5Dh9I+T3iGnL0MnNZovrybEcpWcIp72X0Z8JaZ5ZXuYfN+hxI6jBUpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq5QvW09; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af93381a1d2so1016583266b.3;
        Wed, 13 Aug 2025 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082827; x=1755687627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mK9fnaIgOiHVaMHLlHb2Z36xFm4GtmFoascI593HeQY=;
        b=aq5QvW091qyj4a/iSdNGu6vwK8cJd4JAaXs6CqbFMhAhgVDT86WKWybOpuAThbhuMZ
         P3jdrAx6uxputM84vN/TM8HABKtn+I6vW6WYnEdz4zKnCIdn4+mQJTYa2dsPGsJMbTdh
         qjffYehobTDTyoPpvfI28r1IxMETwhI+b3SjswHy6Z1zk3gin4f9hqjxfnvC4yw4HlsI
         xxsKtiJ9oZasYXDh9e0FA2l8ZpNPYyjpIreLa5ysW5uQ9YhWPsXTl0tPAIfpBInAjOab
         G3gXceJlVZxl0XySMl0HJxD94S1D+00R7gG56XG036La5mWysSDCJX+Ui7ymSWv6lOO2
         +oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082827; x=1755687627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK9fnaIgOiHVaMHLlHb2Z36xFm4GtmFoascI593HeQY=;
        b=Mvyte1XnhBbIe0nF72nw+gqrqXZTgQ0/yGI+ag3HFL4TJk7QhNg1nWWN+/ztozxhXc
         39ogp0RetpqsWuHYQnZxtWzhjT41/its4+jgQHylQA4n3CeIqtmnv5znOF8jkHf9axGC
         K2q47uR+Md+FiX1AusU27rae5PAbCnaVPX5vP1e6j61B2qgoLwpWbfZOWFwy9+Z2rS3E
         BWLw1NSQkcYufyOaxt6WqhZMKyt6cWaPTsrLNG2C1uCBo/b+VRwdPjJ2E2bN6YRMQaxE
         xMK/BPuQ5Iw4rbM5rg4Phowy8Q77d135LcsWSZu2TrFeohcTWr7l6UmUNCD6ktxzjmjD
         ZxkA==
X-Forwarded-Encrypted: i=1; AJvYcCWDWEs+qrdS9cucBOj669zszKkvtRWnpe65wPQ2eWHWsLnbwKrUA15dhCF/gaCFYtADXm/NWYx9h2trIl62@vger.kernel.org, AJvYcCWeAdNQ7hBc1tZ0ad+FcBI/tpVh8qElK9HL40TJXaV01YRvpCjppHLNd5LJeICRxuxRCEbt5DN6L0uw@vger.kernel.org, AJvYcCXuVYr5kp4iig2rIVfBKbOBXVuUT1kVrSb/UoKPJQ9pWIGaNwmpZS0lP2bqGjgvdAayGiJ9DEngmHcf@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUmfWe+OTNCS10DedfEOyGAZAhN5TBq9gQl97TssDWpkE7Heu
	jlaUQLlaPQ5rPloQESdC5nRwZZg9e3lKIscN1t4ywMDqy9cAHlJq+9HP
X-Gm-Gg: ASbGncuFfuipr7IaC4Tf9AGioQ2fykOn8BbvhMmvIZ1FJ49u0z2CJ5du81oQXaGLIZP
	KVFBdYc5ZRbCyxczIg57Kv4ccMS3qmNPgx9kd20lh51rSajo0tMXsgoFN7SA2iD9I8PBd2NV8JG
	aHBb62SDePTMRyDCV6RoFeTjYTcsbThtZE05GmZSZyYQBTjXpmIm6ZFZ7aqLU4l2PKCdyWmlPYt
	nn8bL0Xs2RIZKES6qBHZSXphxbZF/vuadKyGprHsWxQutJo9x3by+1C6vBhWfXzL+xyblTP2xRG
	axfvmcVQHxpQ2sMNadqD9XqCYyiYowMvt4iFr6AwsMSJE8Bem8sizS62R68kuWE3DPsy3koF1I0
	cwzrhsWNJgScq0W1o21RDJhDiUq3SWf5SglBKSerjE8khQ/ysHa0U6+RahXEZ+S87TgA4cS0T/j
	bO7L+O
X-Google-Smtp-Source: AGHT+IH/KEBxleXHnkiaha4MyffAZdzDiHfCJLx8dSf0sSo/Y6BkJw1JF1jJKhUAy3iXEr68vACBWA==
X-Received: by 2002:a17:907:7e88:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-afca4e01537mr234024766b.34.1755082826837;
        Wed, 13 Aug 2025 04:00:26 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:25 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:10 +0200
Subject: [PATCH v6 4/9] clk: bcm: kona: Make kona_peri_clk_ops const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-4-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=5pKdf5KCw8Ie22dGIIzf7YdaNoocUlU844YIpUij4cE=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA9H2aGlmoVVWD0I3gb7BPzQbctsPXNk0CKA
 8pGFdCnpw+JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aHo5D/4lOEhU9bOf5fmKB4f8JLms6icz4q6c6xI2X0IOnq6utt2EIFbxrRXPGiNnKFsUtJw1bbf
 mJU0vyVXtHk0vj16DAiBH23r60+8uIQFg9zj5do1L2TrLl3Ip326lEBYgsZeUi93oCjXZtl/zOA
 rLB/yesGJy5j5KUlbMLMfRZxP/sb+rzBX3WGGsyXaF2wBI9HI5ywPm0sF0R+HDJ2MAvSM38S0j4
 eD2exrGluBFHzkGVsvhMAhnyElXtuDWlZUawr16loThhSrlH0O+q+/g9plcNcAys96pdsnHrE1M
 tKeS0m9Yoo6rhyusHWuLrLC0CjdjluSG3YHMSDuH5kKaB/mVCXJ5P8fRQM/U9Bf0vVrOyKzZEGZ
 dhENqj4WINx28uj0r11fvBRirySzrvPj3w55JRDk/qhNiLcXn1aVg1fVUctzAP2/atYpXGwsVT6
 W4dzX1xLNPL9NL1Q2cpaLRePABowVJP0n/pgAd3QuQm1ZqNH4OAQMB2JBxyg49NmHT+IkP+IRIJ
 81LDYpigI12bGFB6HEktBp/b3xk8WMhROP9S/OxCOxV983ikMFitnpazT+zX6QI31AxM2+lqxP3
 JfG439ZrDe0aEbLaAgdSydUahJa0XhHZW2Mqsuppe2oXVTkmhXzlcXXxDRCUHg27bGScsd45KVH
 CiUieBDmsXBHukg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Fix a warning raised by checkpatch about non-const clk_ops by making the
relevant struct const.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 drivers/clk/bcm/clk-kona.c | 2 +-
 drivers/clk/bcm/clk-kona.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 0171e6b2bfcad51a91adc15f41405aeeb351c260..2641eaa4ca52c2724aa1dc9b4bdcbee5bcac95e4 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1154,7 +1154,7 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-struct clk_ops kona_peri_clk_ops = {
+const struct clk_ops kona_peri_clk_ops = {
 	.enable = kona_peri_clk_enable,
 	.disable = kona_peri_clk_disable,
 	.is_enabled = kona_peri_clk_is_enabled,
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index d7cae437333c83e05b2960ba8d51e718480e6155..7064ce316981ef8f32cf20cd4cf674e5f0169101 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -487,7 +487,7 @@ struct ccu_data {
 
 /* Exported globals */
 
-extern struct clk_ops kona_peri_clk_ops;
+extern const struct clk_ops kona_peri_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.50.1


