Return-Path: <linux-kernel+bounces-851824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ABABD75FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 821C74E3280
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B8286415;
	Tue, 14 Oct 2025 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6CzBUtq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF528640B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418803; cv=none; b=HMZpwGvZddqji1AjUy+syy5mY8j4Lhi1GT3soGE+zZrA2LsSBkq+ORTaPJn2sykZWSh+BR/PBpAsjWGCuraoLq3FLnYkgs/WpPW/6cuhtGYCiAm6wrPINztuH9lDVwYh8bZd3YSNbWnVPdUMhn1yOU89d5CPqvjLTkh11Q20Pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418803; c=relaxed/simple;
	bh=fxxAVmPJGca8589Kqpk9mJo76fAFnptROiZXxjqZbz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs7AbQygchtZDsckqRXh8SxNRAWJF4qL7sXtPrzCf0H9bxtncKwM0AD1LsaWRqVmM8faAekhxKnsFhfaFoFFznNYCw0OshjOY1HdxhXGJ0mu6QvkZmLkuKNm23fvIJkolyF+F6dyZCMTZojX/UIy8ymbpSAjfC6Rh1d5xl2izEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6CzBUtq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af743c232so4423784b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760418802; x=1761023602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=e6CzBUtqbFs+wcpLtINU2mCXFaLTw3jzT6sGaM3S0ORuINNKBbvX/OedlANLVg365C
         1zEZBPE+tyqYxnaqoXXf7bnJj9n+ZL+4b0gvTcEbmlHMIE3y4eEcbqqWM/qJ93k/pxcl
         JvjF6C36KRR0zUUqat4CkVW6EJjbtD9bnPNsIM584s3JQF28g3IHcMRdbdJwaaZyyoli
         V+HR0G2Yi+OSu/QUS9NllfsD1R4hkNm6ncDIlRACvKHm8UY5D3M1wMvddLLUAYCzaxcc
         CugzNvEEv0DYMk/z9CzJ1uZuUCskbdpd6mKm3FV9lfLfTQdpiME0AiEhUOSbMLhD919r
         EU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418802; x=1761023602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=gXo6iKlZmaYBtQBenguulpBWsLxjlw/OBu/KbQxpDnrAO1lUtH+cpJQY2zQobI/luY
         jz648ZT5J4U+ATajYp+DJg4Xc4BzrbHbBbQrBXynLNdRYyG2FJEPc7HkGILGOXA0PEbO
         +toAnNp2SYnj4LOl6/MzW/x6AY0BvANdBkjxEHrEASiseUgnmISMXEuNI8SZLpHt0Kyh
         U5zwL0V3g93noF0ZB/p+SuiXmAf6yapslYxmKGM5fbfHFXMKxwV1uEp9saTR9MMx061P
         qYY30FBMKGCUh9O2v/ac3v3jsg/zz/cM8/kEvx9/BMlOQYE5BPUqW/dJb2Mz/JmwY936
         eycA==
X-Forwarded-Encrypted: i=1; AJvYcCWOulzGOwiUt0kQ9YPFSccKh+M9gv+xRCM/jHmNbONJAw/71DYk3Ezyxl+MJtlw4xAZAqLSk78G4iNTMDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRazwleq3/HNkcBKIUes8XtrqrCn+9c45CopE4SNAE7mgK82H5
	W6qcxLYgB0Csn+Ko08Pwb6gA5pstYK3pVu0x2FtZOkkEqUvzE4A1+YaV
X-Gm-Gg: ASbGnctSG15q/SJuWs6GGMd9fq8wlsBfjqFVtmHASmLvYtmQGFbRoxJJrPHLmvNpg8x
	/Z+tEA3gayQmh2ugGgARFCnGsli01Gtrn1pZKYOei5qymsOZ0iw/o72FB2utmCIOojAw+4xICcg
	bOfIWKOuAZFgr9mzoXpwD9XFvB06gz4WQVh161zJINQJ0oT6jLfeCAAFz3jdC1QJFr+r30oMCjJ
	2QlA6nDWz5RQfZVeLGPMMHYGHmHsTCwTPwH3hP5tMRD1rmqVVPMo9NsFTpat+/5piWajMd3e/pA
	MBuiKSc5oVtiBX6kzZlnSDvaZS7ID/vC78lzqzu7barx7urS7MyL6Cid9Xv4RYk5JJif1GQC/IX
	hn/+RGVQGwEqPVJs8k2H2OJBFA5oz+45kEMCogcEbCGHYOuoP1PvZRr4ZgEnDohYfSsC1bBh1hp
	XwhpKwvS57hJE=
X-Google-Smtp-Source: AGHT+IFdGEyJI+FP+jgDwvUb1DBtqjAdgYlnNf0O+uLevyNOD0Ahuubh0DHStrxuGa26n0WttHzXtw==
X-Received: by 2002:a05:6a20:12d6:b0:2e4:9004:52fb with SMTP id adf61e73a8af0-32da813449fmr28943523637.4.1760418801797;
        Mon, 13 Oct 2025 22:13:21 -0700 (PDT)
Received: from localhost.localdomain ([223.74.108.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddce4b6sm10902353a12.13.2025.10.13.22.13.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 22:13:21 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Tue, 14 Oct 2025 13:12:25 +0800
Message-ID: <20251014051226.64255-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014051226.64255-1-jjm2473@gmail.com>
References: <20251014051226.64255-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0


