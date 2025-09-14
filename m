Return-Path: <linux-kernel+bounces-815548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D019B56800
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DEB189A15A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260F1DDC08;
	Sun, 14 Sep 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMX26hlL"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF71E9B37
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850307; cv=none; b=ZwN0X519S+dWUy1yi2ZKYzDdY4Gv0sUYRrEeRosAE8pnfKnkrhFblzL6DpvByK9aOLwvoxiId/DQCBymFfXu7+i35fuoai+ZoNMc6DlFa5lAVB0JoOhs2qQvXTb5r9uQN6oYqlV1CR3ahndUHTzy2W4SmzauSj6K0iGJ/ZdwMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850307; c=relaxed/simple;
	bh=ogSWVbPDpjLlo4b+vc5rGJJ9Kt1VHCymn7/dpTScrdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB8oMWf0oPBi1lbS98zG7G/shr1UPtbFC2yLLWLLE2P1TcKab/E3lWPheEoA9r9rC0fgRpE3B7ycDg1zj7Oxwl4p7beL6eENjfgBSPOxhWUcbtDi1sXBYtl1on7REpiovlGA+J7PkI30aZBXqk5lE6Z8NJV5iFhgS2n4gAoC0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMX26hlL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so247511f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850304; x=1758455104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXrnMo8AcgyeVtAkkZty6h5coZF1I0BtRGtERaxF9cY=;
        b=eMX26hlLeMJQUl+9JAc8GKmh9N274eqJ0STTZv/Rcn4W0aoyZxkXwkUYVJ/fnDiPF0
         GHtBxSbog6J7RYYqfUe0i/mHu1fxAAC0LOEmkT2mb+Xt+4yWTRhtX/n1WeON4fDLMCgO
         4NbEaEmy7y3QGXsPVf8lAaHaGDInfVOqUXSPObMJKZSha4R00p2pt0f24ZEAngjurKjd
         6V/R0ZpZ6kqe8KBLb/MIEhytbn2kck02y3qjZfUk94pRCBHloCT2VyF8Q/NyaoRzyIjQ
         CoIhb109g4Zm07nvv6JRJoOt/cSFzXq20kIkkeOLYJYKDlL8536sdbeugzEjD6ozSV5L
         RvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850304; x=1758455104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXrnMo8AcgyeVtAkkZty6h5coZF1I0BtRGtERaxF9cY=;
        b=aRuwFLAsCyLlPlzYlcWlQ5o4plTiiSSNflOXXkyrHLcM2Tsv+b8cUWhT3QV6aaj73q
         Lc+arW9fcczC//kNjdLhaMArGNxISPCPfXlppurk6sB83VtIlvlXWE0CAc7zvkMxtyov
         GkQ7ygy6YYZMUs8ARNB7qAQNV5WEPyUWGtg0K3jImwJodaYHev/3BVaE90y99/Rkju+f
         iRBkoKhnhYZxf3B8u0zRXDW8hKDM06WLtVJE2oGL5ElRCtqr5ein8s/+HrN/PcxNH9m/
         zt76CO+WgQ7wBCyl9dYPhKa+0wqEG4Z+JfWjAewVljth4GJ76Cf4ExyV1nEVBF3QU2s9
         ptsw==
X-Forwarded-Encrypted: i=1; AJvYcCXr65nzkzou5Dgo5vQhy9KTceFmLO/7cI13EEeM2n+TWMBIFUGOpBMnLgjPn24Uol+yD5t/NCCrZfcH8G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbnow4iOq4UYrQN4op6PrjGEzOXsqcP1iC7hcupU8aQQedbD8
	k4zxr3U1jDTmrz07H1PM33+3R6dw0BLEL4+ZTWN3NmX5g4QMUdBhxicZ
X-Gm-Gg: ASbGncu0qJ61mRMwfsn41X3XSHiA8Mx39Y8J6tpIKbeT4ITfN5vluEqsBWKBd9Gw6wr
	xG7FXVs6wlulUDyHLmptJVWa9Shfaqq4nBnkYaVBlZMPv3oggOmgaGMjFvkLNumlSyhh40XBaoR
	LtcO++UAqHPF7vCLf5GUW+Ln0HjGhCS7eJ451PfHZiULC+J9IuwHgbztMIrYwDXoRPBzMltRvKn
	aIVB5gQmmq+Vx+Vuo0px1Z5xh3NicRdm5tSNlIpsDcEM2TDjm7xJ6HgoAc9jUYzqB0N1S+lu9vz
	8IzTiJjRAThmmL1N2Rh0uB49cESdSB5QzZCiSzT6aFvOxUqke17GvkzPtZ7JifpL0aaIWxvWyHj
	vfosQFNbDYLKw0EX+/PeSOhsTdHDKO4TqMdZL6T49KRelJ+qNKP+uNZ27fi544S/J2JznOAKeAZ
	9aq6J/qjYL
X-Google-Smtp-Source: AGHT+IESZdZImuHvupg31XiagY9dmwJfZhjEPnB8mK2o9JeW0P+8+vI82HCX5Qrgtqz633EQ0Ul55Q==
X-Received: by 2002:a05:6000:2284:b0:3e7:47c7:9d5 with SMTP id ffacd0b85a97d-3e76579652amr9007686f8f.21.1757850304075;
        Sun, 14 Sep 2025 04:45:04 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea21a6e4basm1503252f8f.11.2025.09.14.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:45:03 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: pinctrl: samsung: add exynos8890-wakeup-eint compatible
Date: Sun, 14 Sep 2025 14:44:56 +0300
Message-ID: <20250914114457.2610013-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated compatible for exynos8890.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 0da6d69f5..dcd96104c 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -43,6 +43,7 @@ properties:
               - samsung,exynos7870-wakeup-eint
               - samsung,exynos7885-wakeup-eint
               - samsung,exynos850-wakeup-eint
+              - samsung,exynos8890-wakeup-eint
               - samsung,exynos8895-wakeup-eint
           - const: samsung,exynos7-wakeup-eint
       - items:
-- 
2.43.0


