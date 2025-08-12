Return-Path: <linux-kernel+bounces-764504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA0B223DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315291B62E68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E32EAD16;
	Tue, 12 Aug 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IPC2Nvs1"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05782EAD18
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992690; cv=none; b=S4euzp59wiwJVD81sq2xOhnQbn1inIJM2/lnzY9uIKTwP/QmH+4wdkIIVw8d+ooeflby8hGycHEOP4Tl4JYBKtA2cOj86Ma3JXq+yBzFPYImW7TIVGYvzyxMqBSzmXTqbfmgEuvUHR16hnqY7/lOQzSkrM4jTLkNpCD2zdhUvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992690; c=relaxed/simple;
	bh=weXYtvOJal0gfVKqkBOQyBy266M+SxjHRozHrgmLGEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJV5MaI1bDOJWboH0V9VEwidIIbqN6lmS+6Px+y36M7yZ0OdLBTHUKIpniB1xaVn2O4PwwoIychYjBP+Y+tZJfvl3zS17BFD7MA49bw4dEl/WAAXVfmJsJrsiyr3GNPrazcZ8bTKSFkzk1BoaxCaeLKYiRZWqGPJpTKF/u2JWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IPC2Nvs1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b914a9c77dso159433f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992687; x=1755597487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=IPC2Nvs1lc8hYO01MxA+pPttH9cIOYlqOhIEAdn3ai9MO/+wVdBxwzckHlBZCnnnFk
         y8xyDN2PQxv4BGvAOK/srVh0Lod9eayzyXD3fH1j6FVP+YD3p6/QyCX/kcqm5Msy+leO
         0uRbhCbuqPmxm3fygMQLEIr8Sbje6V264bhZ1wVtrj+EgHHYFm8PtY5gbwlnmOsE8SOS
         xzjKA2ncrCqnLOUyYj7nbS55GMwlxgbCkZyin4lNcaoJil+QtTvMJBGZlzVeAxWJyafn
         q/m4mn1O4Jwr5nJAq6qpjsMob7ux/JcMPwxo7lxBvdBOTLyqzvFDLpoNoVGDqDQ3020U
         abHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992687; x=1755597487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=IyGIlHMlrELvArIVDc7T3XPqCiGLaZDPux00xMgFgINZO9jJHsyJ6BDFeEJfCLf3f+
         jyyUUmFtOUUKNB/1KtlMSK92EFOkhh9z8jcSEcZOYkRjJGBpheXwZEQio6VtkSXnu8NR
         TTMPAP9sqgLVAeM4/F74ByXxo//L8aMpL5Mq24a8KFKxULQcOLkWzPITbZXcNzKpRAoj
         pkQdhBaKio9tHyq8cnSLJ4r8V5qFHN4IXupDkUg7Axtrkg+zArwNrDzws4IrCw3UAAaF
         Ph6F2rHspB+eo3JUbvYr0oLrwiaufRca3qUJH2CKh8FsP6JkHitk/n4bpptKfxOHK8/+
         BbAw==
X-Forwarded-Encrypted: i=1; AJvYcCXsZ1GHcvVU1ZxO68tPLPoqGqxv2D1LTV+cg/df1hOfooIE6Opp0wHCeiKCN5Q72Cj5yGEe9wJZsA77KNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDxIRCuCVRubRAu409XNnp9sZk630XB4wnIRz6dCCneCHddxq
	lrVt5KB2pr8s1FCV/4BXuAl08dcE876TRIVgd0QKhecY06HmJ0hNAeYO2XlFT3Mduj4=
X-Gm-Gg: ASbGnctnD/u8iFDSjO0F22a/mZUP0QCyk73sTE5Cz9dzVsT8nj+v2fagCJOawoGCxpV
	fb1tTUI4d8ZwyB4t9/clMH6xU+HlL+fUAsIw2pZTlgAy8PA7aZS9HXpSXXIK7o536eECSkzmq5e
	gEsT9dcDtlVVhfUURZ41t+Jz07Q3+UOQJYdnjFmZLujeeusXt3bLiEuVtzfd2OBpYfzGR8vS9Tq
	eJmT5jN7DkWdIT+939Er1mZ35gYOBDCEVdI/KUJttXmxLpVTI20Z03K4B1xfJCdRxHb4NwMj91W
	miE0hAdECCUL57ZKaUp2Gfk1/U9xuHNiaQ9wQcgcaTFp3t8aQN4jYYJwTjojMFDDiZTl5mDv6r4
	G9vrc99CcY3EevB9C4eWxuYFr
X-Google-Smtp-Source: AGHT+IG0JFbzvxgcB6X4MyZBqm+2xPe40r8xhGAf0WOSzlzFftx7jbu+1MVfa5fUGL+ohg1QwvkoUw==
X-Received: by 2002:a05:6000:400b:b0:3b8:fb9d:249d with SMTP id ffacd0b85a97d-3b900b2d934mr12705009f8f.21.1754992687241;
        Tue, 12 Aug 2025 02:58:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0b2d2fasm33098977f8f.50.2025.08.12.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:58:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:57:56 +0200
Subject: [PATCH RESEND 01/14] gpio: generic: provide to_gpio_generic_chip()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-1-8492f4a4c1e4@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=q7IZHV9NOU3n+seY+p1AeQbkCwKHTjI/3z6Qnen62yA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomxAmwRO4IQbNhdYvzJyHfuqqGp/NqybhgbKLH
 Eiji2ez+r2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsQJgAKCRARpy6gFHHX
 cs/LEADLl4q5Pp9BmcpGAF8+4D4VldZtJWYz9SJ98k/ce2tzQ29zimKTLwC20VXHTZuYGjDvQCm
 IuqcLDT2QEKqqMzdPPAASqN/z/heGoW7W+ANwWXhY+AL+mK7ndBSvCx0I4ZZRkzOvpck0EDo04D
 URysnHXBiXHO5o4wtfVCkJcNStCJSlP49m4xz7npz625zWjJVmTmArzd2qX0FBRp+RnKwdnMlLn
 kEDxHP8qeVX1GoNaairRnPuMRSt7CSzDa4oK3UWwMl1ODoUvCXjDx0LNaEjr3jsGoeaJyQSWrWW
 LA3ecwTWriz3GW4lXlZPsxk/JMLJFjYStN0m0YTaHilKwTVnGkTJSE5OZeVxei4vgN/CaWyOCsR
 /INhTtXPt8/FgFiD5901OxhuaOc2eDnE7z9AtCsHAynRsFhyGswM3UnwBwwHn3I/w9cNmGXL4v8
 ZAXOYcNeYtcDeczP60htbgUv9u/t818B2GGZ8UfhoyCyLViSCSdJ4O0Bo+ck0cvqbClej21ogsg
 lumzlDWb/QgrgbFaeGdFhLrbtvcIy9TpbuR5oIJCkD7CCY2qYG+VBHyD0bwV1h68QE6cbNIBVx+
 PYPJ2h8R/D5Gx1M//2p7KfUM2tUdw9iLn4nw0tZcKhYDQDl0HGDCe87CrtYC2Ms/8up7QZ/WHxU
 wr+ngzWXtIQhYFQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a helper allowing to convert a struct gpio_chip address to the
struct gpio_generic_chip that wraps it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/generic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/gpio/generic.h b/include/linux/gpio/generic.h
index f3a8db4598bb59f1dba4fbebace24dc10be44ae4..5a85ecbef8d234d9cf0c2f1db7a97f5f3781b2e4 100644
--- a/include/linux/gpio/generic.h
+++ b/include/linux/gpio/generic.h
@@ -55,6 +55,12 @@ struct gpio_generic_chip {
 	struct gpio_chip gc;
 };
 
+static inline struct gpio_generic_chip *
+to_gpio_generic_chip(struct gpio_chip *gc)
+{
+	return container_of(gc, struct gpio_generic_chip, gc);
+}
+
 /**
  * gpio_generic_chip_init() - Initialize a generic GPIO chip.
  * @chip: Generic GPIO chip to set up.

-- 
2.48.1


