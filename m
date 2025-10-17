Return-Path: <linux-kernel+bounces-857351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44937BE6960
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CDC1A648C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4831AF22;
	Fri, 17 Oct 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoxFuiqz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC2314B72
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681468; cv=none; b=qFRpYhWjow5SxpVYvHmuslW3mAPvCmPK8Y4ah0c/8lSAgUV9ywh7bDpnrAiDWmgAdL7u29xL8ssH16V39WfZk5oPMswy6LsCalPfGfN2cliqJYSgE4VKB8gMjy7UyfaisT3lFwoZGLhVVSU3K/OEBYn8Oq1BALg0NpEZWjW+1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681468; c=relaxed/simple;
	bh=pCrMlpjFzN/XrjcWfs3YB+fSeVkmexAvaoC91gKso/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF9jN+FSEr7+XjIhJOl9fJ65Zwv1hLrCBuU+xHfzFeZbw3Kb3fhts1OYNjOBw1WVvgIoe1rKGiYwgqft4MrDEe3PU68OWyt2nRvzmqzzWCdg/Kz9OpcljU89p4Gl6TFQ8kiLEunxq7PeZAY1U2np/PpjvsLbgadmDMJVvqp4gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoxFuiqz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290c2b6a6c2so11136975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681464; x=1761286264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4jV3SckoWHX2zGnHC+rYU8Ui0+E0D3XKDL6jcUcIDA=;
        b=VoxFuiqzPS2WN95byxDpAHHFuGK3A15yl3clLQgoImTK8+v/0M6fgtDzoPpUppIMEi
         Zger2TJmeNiLNj6XtNeZJY31ZP+oed9qFKOM3XsAy4/ehnA8dYmAPKBrC2mWcPzoiCps
         lF0VYLPBiWUT3uexc+agBjwS6IXT+tdysYQ8vj498JX2jQyDdD4MhHf5+uiAOXoFfPpz
         LaHt1syjxUxzpZtGmpzawp8nBYDiDmZAWMX/BggTQqM+HO+4OJ8HxULU9NNrdr46R/QE
         PMB8s30WLiZAd0ylucVjjxY+nasjbqt/ZYinPA6sKq9bA0ODboU01ngYN6gC5qUQV7dI
         zbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681464; x=1761286264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4jV3SckoWHX2zGnHC+rYU8Ui0+E0D3XKDL6jcUcIDA=;
        b=EVVB99/Yqu+dG4fXmAVaKLyz6gA8lZQq5D03Q+lNncyypYZNygNOQ/sAXUh87xxCrk
         m4cSQLPyVWM8vyB9y1sxbJTrYiMLOu1OgMtillDl4lq4TKKIzzinpNfB2kegfItjSpjc
         gfpWY4Dt0PrSUWA8AiODZR+UyO8gQWLXWHcW3mvVs45C6wFkUJcs46mgzJLMaJUMootQ
         KJAHQTfLU0UQNaPcMG1gYcwpYq16smV4wkErPxso0eBk39QM2qHuj0WHgK/VtpwkEc4n
         +2F1bXP0orspPNSSepIp4VWK6lJ+M6r9eColoeLiYBsk9n9CLJ6Ciwmm1ow66+9LC7KO
         HL4g==
X-Forwarded-Encrypted: i=1; AJvYcCVc4mZ1qxPPtYBzuOKZBksVRvQ4dRn0yHOaayN9FZunK5RZGrbScasq8Gb7sATa+KPy0KaCYWD1Du+Q280=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElTQy7nAIBJEx913nzSXGtfCHfRc1xQ++KTnQgMVhHTiA2nEq
	VCpesFW9HkkK9ARky9GPvBmZ2S3ov3TSpLK+3dacMKy+1qkM4U2Wuz9M
X-Gm-Gg: ASbGncsfcEmpBC8id80nWknUXbkLAf3I6tDnwKwrHXMrlo6ADigKBohf1DLVNeCWJc5
	4w8QBI/LguJuhaK2zBvurang+/oKaL/fRdWfFwyWC1lnSi1merMDieAb5Qq62i+75mIgwlWmBRK
	ZR6cPSrek42NTWjxAE3z1W3hNHm7J1i/SopUWivg+78eUFJShjeN6UOSRe9xabOQfk6IFBPHmrG
	fI2rL1gIDYbsjIZ0QKNb56ZMHB3Eq/4uWvkhxqMVYpN6EFVDFF0/XPp075F9gCX20aSqaOkmHpK
	qvjGB/EC4JSRKVcdhRvqN9e0uiXt4DG07RbC958hUNLIey4gA6k4XEzmxVK8lpe6jupa4vdq2hA
	euXSS8keQi3sFr5yFaqYPARbG0eLBW6VZGmPHniBq6uczLNTWUTPhd0R7CxEXENumgj23R7DwRV
	t+s2czpEnEiW/5S52v4CMk4C1vSywV
X-Google-Smtp-Source: AGHT+IH5ImymZLKDALz+oetlYqaue91LhCFN2bDDJh6sQMmR3UMcGoG20bbqt1QrYkz1S4wAj3MGrA==
X-Received: by 2002:a17:903:3d0c:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-290caf83123mr30401595ad.29.1760681464290;
        Thu, 16 Oct 2025 23:11:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909938759dsm51315475ad.49.2025.10.16.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:11:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v14 4/4] MAINTAINERS: add entry for Motorcomm YT921x ethernet switch driver
Date: Fri, 17 Oct 2025 14:08:56 +0800
Message-ID: <20251017060859.326450-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017060859.326450-1-mmyangfl@gmail.com>
References: <20251017060859.326450-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Motorcomm YT921x ethernet switch driver
and its DT binding.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4faa7719bf86..ea72b3bd2248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17435,6 +17435,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
 F:	drivers/net/phy/motorcomm.c
 
+MOTORCOMM YT921X ETHERNET SWITCH DRIVER
+M:	David Yang <mmyangfl@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
+F:	drivers/net/dsa/yt921x.*
+F:	net/dsa/tag_yt921x.c
+
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.51.0


