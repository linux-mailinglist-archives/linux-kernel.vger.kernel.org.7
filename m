Return-Path: <linux-kernel+bounces-799604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33574B42E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A22542A28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457A217F33;
	Thu,  4 Sep 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5LHdWa/"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633551FAC37;
	Thu,  4 Sep 2025 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945359; cv=none; b=J03Ry1wVd9vsc2hW4JlfypA0lY0AWCfh3l7+xcz0Ck7Xq5Zz9twFEutYaq8H++lSysTXZi14jJBuX3S3KfeqpVQNZ/682B9LrAOVSbYDcrvy/+lr+VyMnWh4Dt7LFCF5WDfqH/gqd1xgBIlIOEgxxHfBYJYRi22yIPwWH/WTAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945359; c=relaxed/simple;
	bh=b4ZukWe7yiBdcabbbAxz9qKjbUuFf7mSe99tMtZ4gZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWG1Cb2SXCyqXlpaFoXMdIFkfEHWxji5lZazWf82KDry1885VBlpc4OqmNUsyLUK60NHGvtcpJ7R5bMbm7uPygm3eahwuqKaCkrGwfJSO2JYvesInCZpsDGeYDGwes09eUXbxoSA1LB0ay4GJj+zn6WX/64kgQdUvFUawx3iRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5LHdWa/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f753ec672so456026e87.2;
        Wed, 03 Sep 2025 17:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945355; x=1757550155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBiYrOPvN4WtYOzD+XOZybGex05ltnyRorDWZhkE7SE=;
        b=f5LHdWa/bgytIUI+DQMzfDw0OdbGoQu3YCn14cvPFRPyYbX0y7rgHvcgZMzd5JMSvZ
         qr/9WwiyeP8xP0LmfNluPiiqt0S//TMvy/qLpIB6Z2i9jctZ1ryBy+/PixODw9K0rGch
         P6fD8b3U/9E+QcdIta0MEQVV6Kh/M0Pb9Xt+aCXzvovbJ1sxg5vOAyoagta4YJzKAfMb
         gjeTeNeVu4VEdkBE66WUlCbrkCTPtUzUAqYaw8sTTFoAtWIBVXBgV5Z1mqrcc8VecInI
         wVgfkU+HYiWBptOUM53xS6QACI9kxNQ1iQhd0JXIZzU6YdTghS5GihcTwLTsaZ2STq8v
         d73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945355; x=1757550155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBiYrOPvN4WtYOzD+XOZybGex05ltnyRorDWZhkE7SE=;
        b=LLXBzXDeMmiMhjhg2IHmKvo6EBu6rPf2niOkuvxGfISpAxo2+2uZjJHltCzlQOHpaK
         gCWEKH35Zx3c/3+lBP+mWDbjARURw0xg+A6dEKyg0wY7ebDdPln4yvKuEYjGymLau1qv
         ltp77Fm1Snws2T3zq+4WjpOFst6eZrWaZBcSqlIPOXmnpO1LsU61dIGFOG2RNTWISxz4
         OZ9jo8eq35ap9cFuwyxT2PeqZTmj+PrWuOrv3m2n+FJedqZsw/7g8qehqSrrYkwnnjq9
         WvjJnLOUhsgIuHXxefHP2izh11s7Ffovm6iZPpxkyLcVZEuvfR4hJBYZHYUuIe+dHmQi
         JUAw==
X-Forwarded-Encrypted: i=1; AJvYcCWGCM2aVimX3AuufQCb18+3NLauSXS+mNgInxxSo2EOehCZPXHL5cXhpPFfhzuGGD7yiQrcs1yMekwzch/f@vger.kernel.org, AJvYcCX/9caoPUaLIRcMC8E/epGcQEYeYYHvo/GVxqjd1jQ4nMCpFTQjLYtBvHcSf1jf67U6a0VdsYMCf3nQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVAALUSLgsIlUy0GPxKV0pHmqQ5TspGik4ZE4id4kfPPGFRem
	Qh+A3Mb0PsAO2hR5uuzBnmYePQqR4MV0hO3anY4mMGhnO7tpSjGa5+ap
X-Gm-Gg: ASbGncs79vCDVZfwHVQRdNqUkd1RbBFq+6P6+RLk3oWwp9gM+kHA2K+fHTXLnq4o7Fh
	eXqCVPbRG4ksou5V+GTZOnAvRYPeID6pE93eH7sGz0I+8q/FSRkXNiiJIgjgB4bDbyQPqWKqyCX
	y2mq4xazdgyWfFy4B4a3QN6d56kb234Rv1/R06YHrjtIx8Ty9+Jt6Wt+ms81A4y9tp8iPwqZuaT
	7m6nzVNfE/bAzFJG2kmuO2so0hMGlPm4qTPn6F4l18xLooQrfqwh9QEq19c6rVN0pbywdeMNt2b
	l1TFMcGZpEMoNSP6AcXMcQorBkpHPbxfl/r/LD3dYjZo352ENeF6rjkTbtvg6A9aCQxbdZWlX1/
	vb6mZ+6Kb2rc2o3BIaJl9YpUiuGISIk+hUOhdxtLZ44E=
X-Google-Smtp-Source: AGHT+IE+PeRboNKszfEwJx2PTkwP/Zj2Dlb409sTUk17eJ8SHjk+PSW8lBvdHfx4jDZY8tXEZr7agQ==
X-Received: by 2002:a05:6512:6512:b0:55f:391b:54df with SMTP id 2adb3069b0e04-55f70955022mr4200036e87.47.1756945355383;
        Wed, 03 Sep 2025 17:22:35 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab8e95bsm821613e87.34.2025.09.03.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:34 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH 1/2] dt-bindings: display: panel: Add compatible for STARRY xr109ai2t
Date: Thu,  4 Sep 2025 03:22:31 +0300
Message-Id: <20250904002232.322218-2-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904002232.322218-1-vovchkir@gmail.com>
References: <20250904002232.322218-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The STARRY XR109AI2T is a 10.95" 1200x2000 (WUXGA+) TFT LCD panel with
himax-hx83102 controller. Hence, we add a new compatible with panel
specific config.

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index e4c1aa5deab9..37f4187698e5 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -28,6 +28,8 @@ properties:
           - starry,2082109qfh040022-50e
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
+          # STARRY XR109IA2T 10.95" 1200x2000 (WUXGA+) TFT LCD panel
+          - starry,himax83102-xr109
       - const: himax,hx83102
 
   reg:
-- 
2.34.1


