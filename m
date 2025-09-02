Return-Path: <linux-kernel+bounces-795512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFCB3F3B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7F41A826F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D525C809;
	Tue,  2 Sep 2025 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MqKvnxMs"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E8228CA9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787096; cv=none; b=EsmB7HAFJPJVTIvr6kJj7arKc6uDRgEDXdTpd5fH1ZNrdB+9FIjKO2nxYCxe3mYbmq8z7dcQJs0o4h/6iztES/dsxvMZV5bOpmU/i8lHdoYhTIP3inFJORI1jjesmPmugteGLOzXV5CoabfKr7Tvllmnpl7u027iILypbEkIOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787096; c=relaxed/simple;
	bh=+YpuvhJCI/yShT1rtWNvOFpxGI7l/ehsFRhKIaNPItU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IH6Zq0krXFK2I3PMbkSQXfd313xw2Y7H9NoeU0eHSc6aDq2rkMeW9A2334ssZM//2KwoZ6bKLuBV2U18H+nHUk7qBULqnjOkEqbpiv3RxQyAGkai8ruWVqY8vX8PQmVAzIYyYuUtFGaUMGhofwI7+hwkk94CiBMg+1xTXImycUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MqKvnxMs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327aa47c928so4095973a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756787094; x=1757391894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=MqKvnxMs9oxnfQM9c+e6IHQnxwkHh+5AQUzrc9UCetW+PYZz5pANqlS09oQInpbLLj
         ifOptgvMD2g2+00O7DuPF97ujSfGAWKpuR7yNrZUXZ/Ai+gXI8dx3rbG51ZsJNX09fWL
         FlCiJMv1U1j5XuSsG6h9BWgrBDGQ+s7RNCNkRHTX8/kDjX1cljUVFiouSvM9IkFASlcl
         vtKZK76y/jVD0cfbImNVdjD/jo7QZcSXol2z3tlxWbcUJE2fIyn3aJWRYjtFpJjZDHEp
         yGXJEheH8C7rkZiZVohRnB71i8PHkcL1sUTrrPPa0pmCABEFReuHNOepGWGe20sYSUGm
         eTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787094; x=1757391894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=F6aXavGMGfBJFTu73UPuSPStXlOKL3rVzUA46VfqLwaSimNBJ0T+dHH0CCZvr+DyVl
         N1CCPkJSKDOruTHkfwfmN3fFMLdYpnqCZI9OAdekx2TPSxUQ6CnQ3IkECweMrLtCGDq6
         rDhok+elRN0H8kby523jXXvo+P2rnF7SZ5/gqGlTAj2m5TnCG8ZoCscfzBYIZr6wJ2ly
         2+lstYcHk2qS2/WtmEIhoLLsh8/1eD2/bqPA+5oAhei8/BFT4+zw87D+1FImZJmgw4Iz
         oPklhkaODDzHUebq5FxPxpPABS/NyjPRREj4KmkVohLz+Z1oHSQhAYAfC7Y3KmHyASGD
         WuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgrJ92Zd12jttGrBn9Q4/x/piPoHD/kD+HalspLNkq1flgwW5otKUZY+RY0rJG5/EZUyCd9Z7kpm19xoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybvt7D1h3pDdrVfPm8+D5+q1IKr3BsBPcJDXfyMDCiRvLdZNW2
	XWdYIA9ki9KNaFVopF3Pp0awhALknEPwYBnmjLJ6JsFm/IbGiK4PJmPcz0cc/4VGPWA=
X-Gm-Gg: ASbGncsL28ywOYI1AokNKpgJHvC33tYEXjGRCC6IYWliW036Q/TuGN8UG9goxdcFTRr
	y+SnSOrLGXIw1AEtYPNWlOpNzbAs1b6l3mxXW5dx6a1/lcRgurqrrJqRf4DbBgC5I8rkuuIKM0U
	2Ess4xXsB/ktRxcMZnwHP6vzUKAHuDUdOtor10nt1/BrlHNLZxNt2w/tpLytlgNqTlnRQHe4MD+
	SZd+c1E7eXEAIg6r2DcBjetnZpjGdcPSevwZA5tI40uSIfRWSiZ/gGf0AGbOJqYUE7+8s/Z4AJF
	O+wudzMIQl7D7rle4YF3dtYQbdCp1ol74aTk3Ne7HEOb9RY6tx0v6KhaVVFhyoysO7m1SYsqS1q
	vmFVp4cBr7xErQ4psKyNahBSWrjepKUFebrhtGGQ5TgYNClSJQ63BJFRzMeptSDUyv9u+Kwgula
	Sv3cto0KGApPtAHRZjbMQiMRKT8ItZVGIjCEOVEzDUwgh7wx8Yf9LGKg==
X-Google-Smtp-Source: AGHT+IEnmNFl2IKFCyIgBswInELByShKQ4l0hZtC5CN4ow3TwqNmWqqVVXxHS00T0raVklLsDS75bw==
X-Received: by 2002:a17:90b:3c83:b0:328:bff:12ae with SMTP id 98e67ed59e1d1-328156c5707mr14802701a91.18.1756787093860;
        Mon, 01 Sep 2025 21:24:53 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm12216706a91.2.2025.09.01.21.24.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 21:24:53 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 2/4] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Tue,  2 Sep 2025 12:24:30 +0800
Message-Id: <20250902042432.78960-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250902042432.78960-1-luxu.kernel@bytedance.com>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..100fe53fb0731 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -242,6 +242,11 @@ properties:
             is supported as ratified at commit 5059e0ca641c ("update to
             ratified") of the riscv-zacas.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zalrsc
           description: |
             The standard Zalrsc extension for load-reserved/store-conditional as
-- 
2.20.1


