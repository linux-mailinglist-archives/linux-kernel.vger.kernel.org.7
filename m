Return-Path: <linux-kernel+bounces-730337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96151B04345
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05204E1F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9687261393;
	Mon, 14 Jul 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKGdL9tE"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50B260565;
	Mon, 14 Jul 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506088; cv=none; b=fmcphXhNcGOwdRN33jZ3p7QLZauEw0yJOASzO8XXIscJ/bes5EQgYlz2CZM239jGb5ZN3t9H+Gf4FSPQlSb3sHeiFKcMu+W/LynZBISLqi0LzGFvYHaGPNnkgelx3t/dtdXg05rNWLuiKB0BjumhUQOqk4yCFimcha5Nw/Z1KXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506088; c=relaxed/simple;
	bh=fS7UAHzRAQgqQaPzwCc+k+6GCD/YdtHZbQodaTOqCHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irr+s3jd2vtH5VHNMU1zcavoyrXS1NQsGuMN/Lug4BuB5tNBz/O4awhGOKn7DsqXV6hYncNDGqgT5g4VebTNKNMpqQyHdDRuC8RSvb+/RO1tMAxjLvP5H8xda289JieMUkhW4DqCzFty0sI0hMIBI2C5iCKcUyn4D9q4674+qkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKGdL9tE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8697196a12.1;
        Mon, 14 Jul 2025 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506085; x=1753110885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PeQD1Y6qSI8rBA+Va3N4iXrKAhnjsutZilvD5RN/6Q=;
        b=iKGdL9tEEpsB0lmk58gIig8BajD7AU5obRttcKOqtgn94krWZvb2B7+3d6wg1gXTik
         LvNcpm93LKGmtea8l3zYOTUovx7otbbIXxC9EfOmmMDffPS29+sMyI/P6jEqQ4it8Qgj
         0oyy7Hm06Dfg4pkwftMMn1VqBgxzgiGLWUroN/qbqlIhlnyp4Z5nTLcnnZIbbRvIKRj9
         6I4WrD5RWnl9pQSpfbnFaO5iT2xMx3TbvMHkGHycuJzT0tszqSZ/3m66cHBYEwAUXqEu
         iQOhULL2Ucjf/NQh1bjS6taC5REW0JiizJCcJ45hTPE0TrHKdQOo5PSLrZhCaSrCUNHV
         qI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506085; x=1753110885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PeQD1Y6qSI8rBA+Va3N4iXrKAhnjsutZilvD5RN/6Q=;
        b=RhQX2obGrwVajIouXNdubnidN5oyg4teD152/1kUcuVEmtyEjCrhUwakfFHI2NXfCP
         8d2I2FJzqsGYBlIm0ftDuyaU4gHJV4YGkuMjHratILkU0SyghJttsOFc2B1bBXniGeRA
         A8yVQwe2BldG232FmutRaDImrxp5LzJgkqWKFbNPbRBJBcN4dfC3rL+m2n5HNIHIgMHC
         64edmhbWUNeCETnPFKqg6Wa6px+Vb+TJef2BA5wyNscrc7Uf5FBKvu+ajliPUszhzcEz
         Tu0MZ8GRrJz2bkB+H16t9svanEY7ZAFigCa+mphU6g2YikOptjgB3r1MWG/fQZanG6PY
         FrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/9oKOtMApCGejO4e9qjQ0yDL7H5xXz1sU7QCaSQxfTb1z7D8G1sx3zyzvmKQaukeFJEqrh+OoFqv@vger.kernel.org, AJvYcCVQ1Kx8V0JYsGNk2DGan1xzi7qkHtaOOwXps/YdvyBZ6/WZVVUdwH+RGRH/F1OR+rXww8A3VBDDjOQecgvL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsq2I1QAgq9YC1TZw7uEvF3qB4NApm3+8Luez4b+qAlI6Kw1j2
	s5J0NS9FB/pNe1AJmgqztj8saDbb/brKsRlZs2JsKrCHLFyYayuto6G/
X-Gm-Gg: ASbGncuqFrJldAv+Pq1Yy8HQ5ZMuz/GQQ+QznwHlidEJVHvYd2mWf8nS+SSLz9QJeB2
	k8xIc0LEj1SLVzfygPGIx4s6+IBREhV5NwVQwTuAMmp5gPG1+uij20o5R5j4zANGCWA+te6TXOd
	vaVCXRPvodllFwHIYx83M/J86d8CiDmuCVW3hjpES6G/DuXQ0I/ynM84UvnmG3EB9fJnv+XwNGQ
	Au+FAVb1FbrCF0e5af9ogW7MrPc7dx3AnZBvifS5C2wjpZhWF0SABSSV541jmHEA+DGY0YRoT2R
	3sB1WQBiYesDGzGnb4LZ6ylzeqAF5IWbMk2nyUJrZt5IIUwFGxECoiGKaI1BwWPvVukLVR9yQX3
	E6spBQNrdixMGBBu05FDqxej+CPaPrDbK3wjFSIMFoEO+QiAlFPRcV29tkMSArI8+J9U=
X-Google-Smtp-Source: AGHT+IHbr1DUfsxyJQ/Rn0DnkunJshTrtrZW0VywVHwhgB47bSh6fWGAKYyG5rgMrlzWkWy7RQNqMQ==
X-Received: by 2002:a17:907:e2ca:b0:ae9:8dc8:511c with SMTP id a640c23a62f3a-ae98dc8534dmr626945866b.13.1752506084433;
        Mon, 14 Jul 2025 08:14:44 -0700 (PDT)
Received: from playground.localdomain ([92.120.5.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2b1sm847701266b.68.2025.07.14.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:14:44 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: add i.MX8ULP EVK9 board
Date: Mon, 14 Jul 2025 11:13:45 -0400
Message-Id: <20250714151346.7575-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
References: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DT compatible string for the i.MX8ULP EVK9 board.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a3e9f9e0735a..18ae807d5950 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1382,6 +1382,7 @@ properties:
       - description: i.MX8ULP based Boards
         items:
           - enum:
+              - fsl,imx8ulp-9x9-evk       # i.MX8ULP EVK9 Board
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
-- 
2.34.1


