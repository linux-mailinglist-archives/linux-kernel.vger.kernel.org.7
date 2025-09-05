Return-Path: <linux-kernel+bounces-802959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E7B458EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2201CC3938
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3082350D61;
	Fri,  5 Sep 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoWjfUq5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE753568E3;
	Fri,  5 Sep 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078711; cv=none; b=OTi9pttqT1BQLP6ltQBBpCEsN+R0xfx8/zHZpWy/Dmzi9S+p7iWjuC5I8L9fkbYCmv+nzyqWP/uIgK5JQ/WAXNqaaFOQMjvFfsahRJ4Vm527eVT7YJKVWGFxw2wnwEhEm/LVtEEfgvE02BxsWzp0Kf/AB5rZVXyLFlGYUrG5Hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078711; c=relaxed/simple;
	bh=FDItfwo3XVcZQeYXeRIh3tQs1pF/p5YekRR/RKji7FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfv00jdfR9OjEQgBjsvKcVJH7xuMj3wxGdfXh8GIf9UUjRob4IMuCJC4Bn8O6R5QzkjtJ6haW1dNELRUmELPEhV6rEZbEKDcHYocGQeay9h5ApKYk8imwnILsIIKN1v9LHWc9qMsFRnPzwiLUlCbGX3m1B5Ao/xCw2SOrxxeO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoWjfUq5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24456ce0b96so23044815ad.0;
        Fri, 05 Sep 2025 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078709; x=1757683509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjpCswRNwHm4qDuVXA6p6HddaeayOy1isCVMskpwHjk=;
        b=ZoWjfUq5X8Vz+tqQFA6Q/ZRE9sVZ7/o9NRi5OAFmqvjJLnZf780LKC4Q12Vunh2ygd
         LqCzGdqssEmGIxDCzYgL5LrRD0RUxmX9WYYg18DeX5Vy7NPKPWOosfxlw0T4c444pawo
         7mnEe8KYcFlTawuoInJNePEoS7koboZGgS9Q7LuowIcRihfzbnO0hRosrcyOlyvij0HL
         UfbFbqSm+7g/yVwlYfCFxMYx1mFYU3w8rClElhq2/FcoIcjij7OH3CEKMlX4ncwDnwF4
         8ReVRkct9JoKYFgVqTFDOJL5kt8NE/1Sg76frTP6Otnxz1Bf1D93oCn6sLBlam56wMYX
         068Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078709; x=1757683509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjpCswRNwHm4qDuVXA6p6HddaeayOy1isCVMskpwHjk=;
        b=Q9dkBaRTt18ytpoYHT03i0piKbFHIt9vg+G1moFOt5vUMNmNeSdpbNh8VkeXwEQpsx
         rfBeidY5D4jmJlzt1KlEoe7KP6cZDprc73kX+WsGeWXfO4G9nHVpUNGOM4pNeQoqVH//
         rZndsCN0enFuUMSK+m53tsXcN1VOeqrwdWsL78KKEfhWXKxNwuIVlHm1WPxnpfw8kyTJ
         8Kq5f6hriGJ+gYSGRfNEGTWKIq6ft9/0e9rADtGUA0OnC5+oBiNaXt/4FsXCnOXuELB4
         qBs/qOyUSNVX3isy5jk+JD1yZSERCqnkGYvRpBcMmKAYPP2nIJCNDnb2PwFYnDJ3hxe/
         0A2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/wbP1ZzBpnuXGaEURrpIy1PWQ76JfEMAmjIhUoH/VLRASx4hDl/HE5zeoOZxo+yD1a+mAjhHADziOqaUd@vger.kernel.org, AJvYcCWPwOJrbqCtb2H6/rjNtTLbOgAxaCCIDrHLCSi600YoFkP5bgOtz5H3feCrO0XNXuo21be9loJgfgQ2@vger.kernel.org, AJvYcCXkj4o2tFP0HNPSkPwzD9kQC2xxqXqUWzESffe4t8Cs9FpssxAce6iBl2Uz4v30ImTuSfA+Zqqw+d5L@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnq/y7ywyeq9F6DESdT+CBMZPsGKR0V+e5YlIXSZXyN/DQe7F
	JaK53qX8P56GB4HP769FLhFAPJ+dPdkdp6YZ6nquiPrvXHDQgQoyLGzY
X-Gm-Gg: ASbGncs47KjAEhfFHfR3sAPpbQYhBytxYy7tM+tmYJLGtvAaulebd8TBSd1iVSzqvOG
	L/Rbuh0iYqjSZCKbPlhkw3E+G8vgUs0oy9AIKOV0hu8dnhyTdzn4MQgD9eh4Y00qdHXIIktd/sO
	M3r+8FqvTbBHVPXPibZokVvvTkBCe8EVOJhddgygyRbzm5D2SBD4+i5aRMfk+tD5elwIfDqEf0w
	T5k0GYRDoMEk6iet9jcChkYzA/2Lca65351XND23S7MbCHT5gqg6oL5+rB+N9Q8uD9pioQySe77
	JlRhlzOnTGLEdOlGxrtNZ8kfoYGlCC6311plFf273rwUrrYoVNcYnZEC0Xz9A1kc35ht5D8HJT2
	h1CPTvofBETD6Y7wGdpKXVg==
X-Google-Smtp-Source: AGHT+IGxNwEqchbs6gvhjmUUItnd4HF+uIwOz1yiQdQWl5Efpol8faj87oXSrj9zTsiWjqWAwTJa6g==
X-Received: by 2002:a17:902:ef43:b0:240:ac96:e054 with SMTP id d9443c01a7336-24cef93811fmr39057815ad.23.1757078708668;
        Fri, 05 Sep 2025 06:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d8d4sm76447955ad.127.2025.09.05.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:25:08 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 2/4] dt-bindings: clock: rk3368: add CLK_I2S_8CH_PRE and CLK_I2S_8CH_FRAC
Date: Fri,  5 Sep 2025 21:23:26 +0800
Message-ID: <20250905132328.9859-3-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905132328.9859-1-cn.liweihao@gmail.com>
References: <20250905132328.9859-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need a clock id to assign clock parent when use i2s 8ch as audio
device, CLK_I2S_8CH_FRAC should be CLK_I2S_8CH_PRE parent so we can get
frequency we want.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 include/dt-bindings/clock/rk3368-cru.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index b951e29069..795e721957 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -183,6 +183,9 @@
 #define HCLK_BUS		477
 #define HCLK_PERI		478
 
+#define CLK_I2S_8CH_PRE		500
+#define CLK_I2S_8CH_FRAC	501
+
 /* soft-reset indices */
 #define SRST_CORE_B0		0
 #define SRST_CORE_B1		1
-- 
2.39.5


