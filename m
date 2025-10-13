Return-Path: <linux-kernel+bounces-850800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB16BD3CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA118A0AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06EC309F13;
	Mon, 13 Oct 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0nJDQEe"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E62309F02
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367152; cv=none; b=eiMssqTszlfkLY4leLwvyPSCLzS6sOtt+eXtLpKDl780agUj86qVEgNtEvZzVeoGYvJ5fIsSjzjQKXnqqg3zt/z1N2qIR25oah8g13HzBzPmJrWD4bIpUNK1vmNm2QHB2bKxDhID1Lsa9eLfVVQRjUvhO0Xu7z4OZMIxOtklxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367152; c=relaxed/simple;
	bh=ehKGfZgSjS6V9yj3+PS5sl4s+AURZPsv7Zg5nNIPtno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NU+3IyJrd6sDPf3/fxob7L4exlj+gSlvA6ExbvbYnCDVXAyZS/vwbhjdXV2fXLHL1kx/7WW908FF6/TOGzfGm8Ir/nDLMiVFqYOpIDot3vZFQrKTf9dvCuSWxEd718WUzTADWtVnxKxkmFrxbFkDi7xutYg4OGoRSaaaVfW5ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0nJDQEe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-375ff2b3ba4so42739701fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760367148; x=1760971948; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndqybwsxO2QFLLjTy3qgkVgt9RREczDl4RIa/Rwx+w0=;
        b=Q0nJDQEel5gc99GmRnr8ploVEESfqJQ8OACKI6pmhh95YW+rTgf3oaTt8WDzcuB0wd
         WoounIzesA/9JcCYQsiZunWfi4RCBklLo7Oy1ptedEccHc7vmA2OzUFRvbJTw/GggbFK
         1lUNjWqiMY/3XtfytAeKviMsm3mgHZWSO3Dlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367148; x=1760971948;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndqybwsxO2QFLLjTy3qgkVgt9RREczDl4RIa/Rwx+w0=;
        b=mS28ybr94uNHmmh3jYIhnOXb2G+ziZL8VbLFuu309u25CQX7j/2P7pjSH9gZxGB9Qs
         YGXVVbzep6Dq1V6/qiGqYfy3FovR71YoN1NTXU4sNwGuw86nmWZZlWh1vQ/K6Auo2XO2
         nRw963ZkH/bZjQXbYLN2XSTYV5ZNNORQ/su8CnZEWkHUfhPnZVff+dyQ1bsI6MqCOKy2
         F+JmpES549HTJh47bgtJDKtP81NgxkVuaWtuUOPfF7c5RGMDJlJ8jMfs3RcHlu1JLDaW
         8qCzE3uVEzonwf3R4dpEU3/2qUjQpUqfbO5grnZF6UsH0PY0cww9QMnsFvBu9U95/K0Z
         vzfA==
X-Forwarded-Encrypted: i=1; AJvYcCX9L5+czebk5nKTHeVxfppTRVxpq+VKb7qXdh/UPQoYvxYtJXLsnWJTFbUB9HUybz87VEv1PpQqFw4vQtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gMLrlMsqMBIpe/s7ztianVJEnBStyQROXunTSOlhYWwDM9tW
	JMLyt5MZ028Fb/hBol7564N/+UlYs4OQrv3d+/htpnwVcy/sbUjReyopJTCsqj1QuQ==
X-Gm-Gg: ASbGncv5Q15Yucr78C0PiqaGWHtO6mEy6USXHF0ySdAeszlZJGH20zWssc8QOUjdMU2
	ohSX8vMJqgXQPgwIyC9N+rsGzd2W+frwydxhusYrArUNHbYcNwbRbjGSia5EWBX1PTU8GmeGmPB
	ogCnMxYTai7bbIvcPzuYzBpfxOHY2uk3Tpz12oQVUmAgV4vyn/qa0aD7x1r0ZoydiCUcApQYMth
	jGsjx/pIytrui7kpgwyIyH8wvdous/tbDiWcuMZZ+VWp/QSuuu+JiMiF1C3sHxaat5mrOsfkp+X
	sY0/w7rdnGC5z+X9mZDOat0qQjJktVkdBDmGWR2WYQ/pj2EFirTB1Qo9orEwd/lbLQWCP9LHqJX
	v1JPPstBSPv4d6Le/8LVuSNQrcDEcohz2RUEfCYb07TClcWiXscq3sZBBwGrWPUdTAakmM7MyRA
	xTaunjA1uSI5f2DK4qnQ==
X-Google-Smtp-Source: AGHT+IHv11J/UiQuXRPc53mXWiSRrpkDd1UzSDOJ4DL+ON/DEt7ZP7ZjRbXESDq57CD/XFRcpXXCtA==
X-Received: by 2002:a2e:a582:0:b0:372:9bf0:aed6 with SMTP id 38308e7fff4ca-37609e64b6bmr49929971fa.25.1760367147927;
        Mon, 13 Oct 2025 07:52:27 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e77b8a6sm31980121fa.10.2025.10.13.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:52:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:52:20 +0000
Subject: [PATCH] dt-bindings: media: fsl,imx6q-vdoa: Remove redundant quote
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dts-v1-1-5731ed92684a@chromium.org>
X-B4-Tracking: v=1; b=H4sIACMS7WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3ZSSYl0L4+RU8zTzJMtUUxMloMqCotS0zAqwKdGxtbUAwYGFfFU
 AAAA=
X-Change-ID: 20251013-dts-83ce7f7b9e54
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Latest dts-ci complains about this:
./Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml:19:12: [error] string value is redundantly quoted with any quotes (quoted-strings)

Fix it to make our CI happy.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
index 511ac0d67a7f2360afe22b81d76644575081089b..988a5b3a62bdebeda6b922a986b9ac93d0933e51 100644
--- a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
+++ b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
@@ -16,7 +16,7 @@ maintainers:
 
 properties:
   compatible:
-    const: "fsl,imx6q-vdoa"
+    const: fsl,imx6q-vdoa
 
   reg:
     maxItems: 1

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-dts-83ce7f7b9e54

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


