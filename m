Return-Path: <linux-kernel+bounces-694209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B28AE096A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B643B1FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8522F765;
	Thu, 19 Jun 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqHNZFEJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F4235042
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344922; cv=none; b=deR4meMOTF6GOkye3h2LvihMftgz2tggW30vq+axuxf5zlVbF7QiBfhyKhQ2Q27N64+Lep6doeXZLOIOwiorTSuYmG2nMYjHOBz/kyV3JEaMdkfDtnHKtzBFtBTlqSLVNEX3m9SXCCRKcCqTVpKvrMUMxZzEV7VXp/0vugAEEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344922; c=relaxed/simple;
	bh=MB5gNv4+QCpg94YIRZF4W9VQB93gw02YQkHuOGD6vUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAK7aJziWiyyYdLFqlohqZogA/77TvZKeYCNwTo58RLQ5w6H9QdWTHgf+qOwn+1B5vZEd2N0BOlfFi/SGzesvcV1Pks+oLour+gcpG0aDSQp7Ga0lh74RxYb1IjC5Yj3/rzoE5MyvIIEZi6YmCYFL7PrHd4inQKiAXmDtKKwM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqHNZFEJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6964795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344917; x=1750949717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e226Tcn8nARRrl/o7ezCwkhDY/r/vdSmLiez583al2Y=;
        b=nqHNZFEJA43FDoybqSa/jmGsD09Q0uWkhO2rpMUJW4sKY2/E2k9a+w0wUvtPuZGJ9j
         swtFceSO8IGu8MwVdjy6VJ2WCpTCl9yoVo/QzCnQVdb2duRIkKjDyV8ftaPPltEqJyEa
         aFcdCg8bdp+NpoXwKduxu097QWaab7F22hRuZxyyqymuQn+g7m0+VhG+ABcvFNrsb7Vt
         LKmoIp3uQsLFudcdUkpnMSQLCPfhTY//k1tTKLpE5evelLzTBgSayba6B15qwvJCUhgC
         iaZnEH6R0yd5X3P1A/fujzlxpiBuzzLRbryq03fiIoLiTAvnJekj3ceTqhyGAqjJVbH8
         PDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344917; x=1750949717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e226Tcn8nARRrl/o7ezCwkhDY/r/vdSmLiez583al2Y=;
        b=P42NFHSPbfaREFcgE12uNrOkhsZ5TPPp+b7sfXurq5QzfMDPm0H70C4ov9nkKhD7R9
         vZUikoHxOetXWks72l6B0exegqpkevIlkWyM1MbQBIij+RcA5r4meWI5QB3mBoOX6Wq4
         +zrVS1uubZp1Mrx3dnG6pQmJ6hvtEiDNMMEIKH11FWsjbqisRKmnzuDLo77JyWOL6RxJ
         XSjWfCjaK2ieXvb/aAiPQHntE1cOZfUQ8pTn1dZgdjqbkzc+wVhmZ9syVWSFMqc+Yf9c
         IvenfyChCdPpzajsWVDtNUVBZAfz5Tdcru39dLAK5Os2IFi75zVgxi1hMtKq4nqtUPm7
         XDIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhKT9cfzw98Ogo97N99Yg9D2Goy4jX1XEIYFBYFkFaruKohOI6SC18FLimkOnIWdhZMkedlvDB6GOX5Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+V9stJd+jJkImEBTvopLAwa74MTTRG51ZvLDV+EnnqaMO+p32
	cXELwLZuEVb9QlWcDY47PzFcY4cPnQOWSlRYFGd3sm8XLxK1NxOLviQPKnzgMAZJDI4=
X-Gm-Gg: ASbGnctD+RcVMGZxJnZWpcGonZhe2ImmgLXQ0O+pTTeGwXy0in4BD3KlRvnLInsR/Yp
	D+B7Jw5DKOvcA13xbhU7HM9glC8UbC5XHTs793M/xyxWZ6imSuN7ZGg/qQN5JoWMkJZyczxTiNK
	wOuIw7b6/GUbcBqsTlCjxUqhHDsDdB3+mGAa+izF9j+HB8uwHDH8zn8PYbxzEtKCNo8K5cpSHOj
	DmEXLeYZZph+Rw8ofRCKbACrZ+r9llJZ/LUZXsh7S4LbtN67uQGdIAij04R3YJxujEGE6SuR+fa
	Xp6Z8MufUMjg6+uSlDfYw2nx5IBlmTok3FpXWQUT1avWKjVv69dvSh30KUKbZXdeLvpC4ZCVPMz
	ojMW+OgvPGAQ=
X-Google-Smtp-Source: AGHT+IFQzca4+a+ltyk7vQE3TZE/D2mu0OwKAeR+4tbx2F99S6hmXreNik1ilhlwI9i/rW0dhkrFBA==
X-Received: by 2002:a05:600c:870b:b0:450:d5bf:6720 with SMTP id 5b1f17b1804b1-4533ef3dc36mr211428225e9.3.1750344917257;
        Thu, 19 Jun 2025 07:55:17 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:16 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:09 +0200
Subject: [PATCH 01/11] dt-bindings: power: supply: qcom,pmi89980-charger:
 add pm8150b and 7250b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-1-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=MB5gNv4+QCpg94YIRZF4W9VQB93gw02YQkHuOGD6vUQ=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTR5stwaRD3G+1RyljrB3UVlYuZ+3+s+ShMF
 as6OYZp7liJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 ttYDD/9KFimD2p4h23k5xwtIATlmZZyylMC73cSMtYuVsujSDMChaMvxzCR+hqEXwJFOPamuSsK
 pGjKknYRSfjfbxlnwUnplNRJDaTLLE6LMnz8Dg+nqIHpYIKUabmGbcGchwGAwi7R6IEvjRcqXFG
 dJSoRpByMALnezFURpEV0rgBSYJ6t4bpne+Nfq10A3jWutIYtV3Nh9UrUHF2z5EG+fEjXhds1nb
 lkm2xGBz58/R97WDxYI2vuP9HIVB/x/lo10izOgvF8v+GO7rFuTE8Q/sRgaZ04bLvx6jyxcpBNg
 bROsC2G/cLSeQ4Ka+LzcUHe1q/KAWRvlJcdVgHbpUuQMufcl3rNathQbVQvZudDscvgG+7V7eDP
 RtTkX8okMc9GTQ4oXCsjA0hg2iUemH+gp1uV5CI8d+LWBPoIDkxqfhhXickhWFys1KLgn5d15sO
 j5is6KBoi9XaDltq127ONHfW6sd0V2Yyq25KfdBvGkUd2CsPp4dlMayENF5s/CHlo4cfBwccRLz
 5/XY6c1yGhaQidhpGz4xKUxv7qlbmAnLE1Z2KYElQHRVbvLwUQ4aWgbrWq1rFc280fnU1jjMAen
 wd6nXa/uzyPYg92Kcl7EyF/uYihEUKAbxFFy+AGOnJgekqnRQUyNF/9bBEJ1HCOZzNYtrqUbSgh
 /i4F/G9yKI0VTsQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Add compatible strings for these two PMICs which use the SMB5 generation
of charger.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 90c7dc7632c58dc5cbfb3abcde8e730882bfd936..d19746b64fee19a07bdb8f7a996e42103a9e0e73 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -11,8 +11,10 @@ maintainers:
 
 properties:
   compatible:
     enum:
+      - qcom,pm7250b-charger
+      - qcom,pm8150b-charger
       - qcom,pmi8998-charger
       - qcom,pm660-charger
 
   reg:

-- 
2.49.0


