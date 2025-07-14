Return-Path: <linux-kernel+bounces-730828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C9B04A72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A207AE284
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA71283FF7;
	Mon, 14 Jul 2025 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="ZZEeYIqB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85427FD52
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531499; cv=none; b=Aa9HP8vQEBmh7L/03LzD6ckmnmHsC2rRLVqlVWs1fXxVfDrnbcferEd6Ij/Dcg808npMvKjkBN4rmz6tBfQC2RdSBUTnhPscom5C9KnfRJU9UAPhh7a9uc6eCoEQ7sHdA6baCMpw0Z+FL5JNkjko5Y3eIpE5rwYEShm8l0MIkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531499; c=relaxed/simple;
	bh=YLR0dTVZfAu5LlRsEWmmg9empbYzMLHU1znVEa4gBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfA0qotX9zA4QxzwpoqzxeaxFG8qCknGBOfsScs8C8C2D3fFwSMkdqpNkMFIRyeKi5uvxny2umEFxoMmMrYj8X1hsPVLzPmLQCGXIA1xsfdM4rF4FsWYIpHH3lPDfvRdLACmF9/AkY36il491556nLWse5+fbTAVKc2BCDOvSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=ZZEeYIqB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab71ac933eso9964841cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752531495; x=1753136295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouMuj11MjFvdwjVughz3WZjGk79DPdwniSFwLLOcIJQ=;
        b=ZZEeYIqBcQTgIfCa7EZ+2JZkzc697MgW21NmoGf8sMRzZrOZRb4ocHJ0P0QLcNs6At
         4XaJe1fw9lIALqCbV20LF2fc9FjG3kMovAunQxEDwPKS04u7tpTQOMh1US86UYpo38xp
         s6R1hLG9irtS1eTVbXFwWhYiUkr+46x1hhZYZnWGwRk0mw5RVu8sKmMLgZEOQhlQe/3I
         CB/+a1H4Y0vCRyg1i4gJTW4uiIWmFVFQJch6Ci8/I3yJrgGXXQ0557jWNds2bUmnjIKb
         ENIbvmVcB/azqRsBXLjEtMciQiRPe1uhF0NjE451AWsgbfhevdvG9id3gtnjesSwiyH7
         1i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531495; x=1753136295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouMuj11MjFvdwjVughz3WZjGk79DPdwniSFwLLOcIJQ=;
        b=DQLBNiKWCBSydU1c7Gd2aqV8DsZ3ThakAtgs9uvZ8KsJUh4MDzCnaW/nZvxUxxJ/dA
         kpKL5NdQLHUxRBGvZntEDJM2oIk5Y/4bHNAgr/I/eqhmAQ1MxXgw46YdELLvljpxAt7E
         Hb5iC1qN+/23CluzmXIrcZVoRpp6z0TRHNe3JvM6at/DlA+nad1QVKvyk1xDlUXQlj8H
         6R4xI5i6Wi/+WFoO/Cru8DVT8qXbL9CSdbK5FUtx4VXf5xjybUqhpVYhb6U9voYKeY4s
         BD3Ow4oJJvDyikpQvVUodNHZxa6PGKMgdANvLqt3tiPLtm5OpkKEnGHH4q/QiLe1W9q9
         OYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW14jLtQnJYsIdL6PEs/vBr4dfDYY2NXHuNFpjylYzv8es6EJeD5pwhoGaiKH98ti0BRNpLLIz38INBbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmtxyu+LNNZSKXzp1yICdJzbtZHv9xVks8V2+FdEiapvYXSPc+
	ZNCYMALG1dDs36BQ38IBD0OAGI9fNdldt/JXkeM0YlXhHxfyToH7zWieU5Ho1xvp5u7Oavoj9q8
	PPeglWGs=
X-Gm-Gg: ASbGncsaeeeECmEayO+Ou6d8km6rMjVzu9GoXGxMSvpPQLyiQkhBcWCfuEb4pDIcy5/
	yb7GEqVTdY3X1yttO0HkkpnsBt6X0prsRcOYyPUStjJXlWY32ubeo4L6shctxTCy//rf5I9m722
	UGb6+a8CaGKwenw6IIlXtGDO1fZnuBpVY9dECGDr74cHtHsyUg5lJ+19WBRyHzscqZIQtlpYDzS
	76/0ZGLz+vvHwd0BO75N+5zmrzxRdbk7O8a1Teza3p+b+UKm6N4/DlvKST38ydQr5K6EdH80P/Q
	0kv+mcMXjZ8/C0kpWNJjGeursdgIvvVfr5sdxoJ4wxAZOtAPAzyW1NH03CBZ8odBS1K2pHa3naE
	0uVazaOw0wBXdilRcLbtU1Nnx9LYU3ETtKMGlP5AQRvXda7RxqySEaaPMeak=
X-Google-Smtp-Source: AGHT+IGSSrEk0sdISqge7G0djRIjWuuV30fns6i4QsiVDwWMYt0jZAnn6a3hXxiBvovc3VD+dN/cfQ==
X-Received: by 2002:ac8:6909:0:b0:4ab:80e0:955f with SMTP id d75a77b69052e-4ab80e09e16mr13247631cf.34.1752531495432;
        Mon, 14 Jul 2025 15:18:15 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3a1ceae0sm37822021cf.25.2025.07.14.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:18:14 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: ilitek-ili9881c: Add Tianxianwei TWX700100S0 support
Date: Mon, 14 Jul 2025 18:18:00 -0400
Message-ID: <20250714221804.25691-3-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714221804.25691-1-richard@scandent.com>
References: <20250714221804.25691-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible value for Tianxianwei TWX700100S0 panel.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index baf5dfe5f5eb..28d5fff79992 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -21,6 +21,7 @@ properties:
           - feixin,k101-im2byl02
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - tianxianwei,txw700100s0
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
-- 
2.50.0


