Return-Path: <linux-kernel+bounces-846475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80233BC81C3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C217C4E35D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430F2D24B4;
	Thu,  9 Oct 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/i+9ZTf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AC2D29D6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999553; cv=none; b=ErHR6jY5tj0gRdjOYQjUwc4kEzqBnz9Jd5KJ8c0O0cQ9tDrKugWZ0bZtC2fVTf73DAMMbAsC6qtSTPqfe63SFf5/qLHxfJEFsgCXjyXNO6yHle2nVWSaBgptNgU5i+IJMwTtNjzW5Ty/Ne1TSStjl2Q63k+/fkI2tYxPkIhnMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999553; c=relaxed/simple;
	bh=i8ILy3efLeOoD5Qf+e/n7DFmvbPzfKevH825MWgSvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU1bkZxSx3OTu8ffMjXgyPa3f2CSFxAqw4rNCE/V3MrPdZesU9X7QfKJOx3AyI9PYRPCeAqSxdT0Ku4eEpDbiiIkqHWZ0Yh702dKmszVhml1FMXmSXSAn0RXmw27uo6MaJUAxOGcGNE8HQzCsDTTYG/TUQPidWYa2qSwm3nSVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/i+9ZTf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so545198b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999551; x=1760604351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=c/i+9ZTfkO6eFrNmVI1vPuMFIy2blOAwtm7fGMZoN6vc8cq0sHweMdvhA+amIrB7kR
         BF1qtLEZlXfwHkaOca9/VcTrNMS11jZZZ1pboioQ2uTS2PtfGUNLYdEMmNRTt5bGpZxI
         ahTpnCH7I9NYlHpULwdzeNQc+jOmQQhmBbvf7zefc4j8LYK/Fifx7QitV27Ik+JJiv4F
         uvxGyNaEGPqlU0xj1PEC9AfiPtf6bUZ/uh2uQ2XBVzWcnSDxb7pkCdDT+nK9VGzkaAYo
         CNNsVcPKqqbSyFm5OvBcHSXHQGKMQB7fJe12ZI0H69V6wDdcoyE0q5pX9uM5F66nn+Tv
         b2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999551; x=1760604351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8OhPkz1QMasSzFJcM2SsPKD0i5kQ3GIw9/NmjM3cWc=;
        b=FcilDoSlxfCqmFIM/UCZC1FFMbFHlUeA9oWakwyglAyx9UZhLL4bHjcjfTdQ1kQ0CX
         6u/1upCIHlpJLxfZuObvYgqv1TwbqF1UXqgOHmU8vmPV9Uilmo7XY27Eh5aB2PNm3iqb
         jPylcb0azhLA+pWA6zRDzPzt9FEBl9+oigm4nCYGb6Q8l4zp+auY6zXbW2KsymDwIPFq
         hXL8XgznCza4Q1QlJu73YDypYC1fJ63ge0JoJAYRBQM2WdCBPMjxYCZnNmS9rbWDqrvj
         924or9uLOfJYqJd+W4caDjHKVvOqx+Uc4RmktR/G00yFLjeC6KIgqn+usTOxn22OlNwL
         CWyw==
X-Forwarded-Encrypted: i=1; AJvYcCX6j1EhTI5iOT+jCN7S1/odufMnu2Sff604mTCAa0tW42l+BxITziTXamCWgmfgu4xxmMGgdHqcYMB/hnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArddvhbOy1lLDl7X881PfBixwGPeEyyQKF6ERvVsopo5rFQz4
	CMbvrbfm67Yy1NMITTCexPwBwnPOPEWhpmkpY7FllQxrKE+UZIOaE0Zv
X-Gm-Gg: ASbGncueERgJUxXBhgdyHjTIVGjKzdBKOvz0o0YHIw5BFuO8YxcGF64DSQizZ6PceCv
	vUihtG07fhnj6CgHG8ygrUeUuSLCTMh4oedQYzMZnVBpNeGoBfqHQXdDtaoueiAJbma3ZQl7smN
	r0Gopu19v4Q6yApb5yiy9aTgAL+KDoawWb0hiwjiWwYVs+IGq4rJsUv7j1X8SMR24JakDhFLnll
	rAEa12/+vIb92ZOce+40QJOxYaE12P4WKYXlkdAP4oWtojksTYDOah+zUCbO+wI8gn9vb6l5HqU
	dlfH6MfOpqYZrWTKxNFnfTPPEea+CMGmPlPTrEbER1Y2zBF3Zkm8vVIOk8DKtvuKRie1ACQGN7E
	LsP9x4FcHb/gvtl7h4F2SFfCtBtb7ULHb4tS/3YNUdOjNlOQcDNF05IRchy6rtHFyUWwvgGYMny
	hx
X-Google-Smtp-Source: AGHT+IFsUYI+Uzlw6afQAv8v8QE4Z1XIw1leKiEaEKz3k8e65BDwjgKJwZ8Au7x32eU9NmkOPg5Kxg==
X-Received: by 2002:a05:6a00:3cce:b0:782:ec0f:d279 with SMTP id d2e1a72fcca58-79385ed579dmr7200904b3a.10.1759999551109;
        Thu, 09 Oct 2025 01:45:51 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e1bf7604sm2130924b3a.55.2025.10.09.01.45.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 01:45:50 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com,
	andrew@lunn.ch
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Thu,  9 Oct 2025 16:44:14 +0800
Message-ID: <20251009084416.45542-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009084416.45542-1-jjm2473@gmail.com>
References: <20251009084416.45542-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase is a company focusing on the research and development of
network equipment and related software and hardware from Shenzhen.

Add vendor prefix for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..db496416b250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -873,6 +873,8 @@ patternProperties:
     description: Lincoln Technology Solutions
   "^lineartechnology,.*":
     description: Linear Technology
+  "^linkease,.*":
+    description: Shenzhen LinkEase Network Technology Co., Ltd.
   "^linksprite,.*":
     description: LinkSprite Technologies, Inc.
   "^linksys,.*":
-- 
2.51.0


