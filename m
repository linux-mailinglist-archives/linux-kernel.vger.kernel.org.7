Return-Path: <linux-kernel+bounces-894048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0FC49244
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DFF94E4900
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38933BBAE;
	Mon, 10 Nov 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m48rzm3n"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF692F8BC3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804311; cv=none; b=CWcpOeU91GJD6IPqFRHcSGFfg7qr5R9HAqAGM8Q31rDw8QSDkHmIMbtM4TyO8j8Vy+LHMZWJNzj067ImkN8HdrWcvz90e0J81QW3wY35Wxpk9Sfu6AonQlMYt5cxE4A7MDWLzlZxQQdoBod4wAdOPMbRagqB8w7EwSUbgVvv2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804311; c=relaxed/simple;
	bh=qkHNrqZdFrGbQ2sFVWvTU7Vf/JCQVLrMMbpthhsCB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrgbHVuaS0lUFeR6SOdNUp03oJHJ75c2ehc8RQqYpf5VywMTeCnqMC1G9mQT8byUg86zzHuORG36iUQWg7MAkKK8eqPaSFfaSmdzhEtpTJe6ssE696q7+KtOnKjfle1Auwoh/8BQxsz2I8kdyBhh7zGI8trd7pQJltlXt9fvW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m48rzm3n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso106746b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762804309; x=1763409109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwnhoUomw64HUQztzgJYcsDLgM3BoYLfj0X2UoQeEr0=;
        b=m48rzm3n45uUB1Jg18rCE2UkTl88eKW94wMMAwWXck4BbVI+7A4I/ycLCpp8unDmsP
         YzWxzBVduMX6EQ4Z5srYFQRrvQx1tWCGaLxLK8JQrchmA1+5IKKd/dyIlSQKeUeZwkzw
         22X5u9ycdHGt90+HOaXI3iouCRpbA0YqY7S44PeqM7WibuliNb84uLtbCmvW+eCeiZrb
         Qd/3JA5b24GWQvFol18sfe+O9xuD7AqmyF9i6ajn/kmNB+UFRrJ36NLomeK2EgHwhF51
         iZ7wTcyMwWEmu2Ah6fN4VzXpiFz7GYhHvCbLuaxPhi3OKi5DCKpUTUrZe8QIy6jeyIQ8
         3UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804309; x=1763409109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwnhoUomw64HUQztzgJYcsDLgM3BoYLfj0X2UoQeEr0=;
        b=v8mzpx0VzmvrP58cazX+MdZBn/2jddlE/ZzGo1KGhmR7WM97LtFaZO7sFFGLJRajsX
         kl7Uf+FESKnTqgL6UOf3ff9OtMn9Uvpy1zafL38w65vRdQ+rpWrolCNujV9Qsi9cwdGj
         sWjFNuIqIUvus+LCulbYY6bYaaRaDVq4mgIFEy0bmGTuBTSXW8G75DXLtlW/u+WboDo/
         gXQgIdE+T68fcTKVQcnfk3VeaCCnKP7A2/40up8APwPK3ZmzAIH99G7O44XxE06hfXPj
         esNo9bwCZAhxWLY6xbw3c6yu1JljEj8UpY1LIv/ISZDk9Eguid0ukp2QoZ5uXiOhxsaY
         i/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVF9g+qt60HJs/lJfaCGoGMFvBgdJNO5x/yTtxyQRUU+iEnCgTZDtZYrGvvyIAcU5E/HHhj4Ofr7RF2MjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdJv6SAPm0Imu32pV/Zk5/OXGpBKZQ+rNNwzJgwHvkP5TwJFK
	Qu38QIbx4o38jd5Z+FpFsBAmDXjpVetAMDOiZoVVZEnw6cao20dg4UoNiPc1UC/i
X-Gm-Gg: ASbGncv+Axk6h0kOvEdCnMjprX+2+ui6r5cE+u3nB3ZfQiuCSTsIuur5i78SGJqUMQH
	UfEY0LPVQ0XBNr6MNL7hSD7pEDvvlDe0A2BxA1vEkRA6Dn+hVB71Y7BpknAEE6fG75oVqNYpXN+
	S1p1y0fqFxYf5fIvTfDdZndyC9U7gaOWTa1MfJmxoCaOoJdrqwstylWjv2zuv2g0eCXehF7hBm1
	VVZmoelvFMp7mhCkvdeeyBDLFSDxbu+QCIKSMhcsPFjjz3uEML2L31jzWrfnRZAC+5f0tcrm09/
	GH6Qs/Y2fCd2pVfzm5m0wfCwPKkohuI117OB8GkVCdqtHxB8l43uZ7AFf/zcMZuFo5wGysR4LL5
	QuPEvkrVCRJELejs6GJczfspbB3TZELchWMEKaX+kyFD51R3MUFxXTAPtGH3rm71+i7+ZwNi2ek
	doDtO58dPVKWlqQfy25gr7n1eaK78=
X-Google-Smtp-Source: AGHT+IEcdjjpBCPZmtRzTDq8PPd6/fWOBQ0tt6Y90TaCfOOsTB1S9g0eYsl5fdhEFnCj07aTnMpWpA==
X-Received: by 2002:a05:6a00:3d0d:b0:7b0:1d84:8634 with SMTP id d2e1a72fcca58-7b623afeac8mr689252b3a.15.1762804309058;
        Mon, 10 Nov 2025 11:51:49 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a31esm12669098b3a.63.2025.11.10.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:51:48 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c
Date: Mon, 10 Nov 2025 19:50:30 +0000
Message-Id: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
  Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead

The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
This patch updates the comment to correctly document the
`zl3073x_fw_component_flash()` function and its arguments.

Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/dpll/zl3073x/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
index def37fe8d9b0..ca5210c0829d 100644
--- a/drivers/dpll/zl3073x/fw.c
+++ b/drivers/dpll/zl3073x/fw.c
@@ -352,9 +352,9 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
 }
 
 /**
- * zl3073x_flash_bundle_flash - Flash all components
+ * zl3073x_fw_component_flash - Flash all components
  * @zldev: zl3073x device structure
- * @components: pointer to components array
+ * @comp: pointer to components array
  * @extack: netlink extack pointer to report errors
  *
  * Returns 0 in case of success or negative number otherwise.
-- 
2.34.1


