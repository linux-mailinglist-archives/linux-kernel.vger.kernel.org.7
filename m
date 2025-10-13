Return-Path: <linux-kernel+bounces-850595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E4BD3420
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EF9C4F2326
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C56308F1F;
	Mon, 13 Oct 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmknIdw2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C98308F1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362927; cv=none; b=CG87xQunwrfvfMJO+kA2zBBaNTMZnxA6MWAvRtuTCtv/dW/3MRSa19SdsaOW6i7skiO0i7v7Bgh57ko+x23le3yVijz/6MLjG8JpRYKkLnjReHddAdu5jVgGPvSQ/C2DNvHUUpmVVqxCX1ylFaO1QA18Gdq/HTKoLdNFyhbFMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362927; c=relaxed/simple;
	bh=vh/hIeQB05qjlIgWDhfjgy/vwvluYj0FXcfCExT1EEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZc9nsDRUDXsNOCTOR5pfzjnIveGtEGLs6TxPiNTZUFF5ge6J9pxMHcQZn4WWY98bXhPylL0hF3t+iFy+N+NbYrM79wRHYY/31EJfoRStSToGUsSiSVXGjkksoqSR/rnCOl+rc+rkkwPKg/Pa9aOrYU+zAXqg+3orwTg9OcthCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmknIdw2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6685616a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362922; x=1760967722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUB0zP/a55S1pa9D33iQN4CRyeUZ3bxGl0mgNYJShCg=;
        b=hmknIdw2RdhyFMbjAsBaayD+EToD2Uj6/KbKot7Zp2Er7QYFQhWpqMxYYKFoDIVTMS
         ApsI1nCvIvVHyEmMo2M+hiVk10Zao1j0qXSiB6TszLSauNwUxZ34jIx2zQtINXuhZepl
         rWmaMkiRmRDXSxJ/fcD75lZTZ4k24silrtYYkknDGWYDAhUq5uxNC8I9jv/6FYfC2wJG
         dFuXbCJtyDTjKVkFme6Osz7DnShIJkTSplRBEiKETUA0bt6Yk355zo0pAHNb9lKOYTmI
         Q/gzoC8LqRwPS0fhsF2wemY/FTAEIrL622v0f5hWhyWB0QP2EPHsOak+F6ePTLawPQOc
         2rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362922; x=1760967722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUB0zP/a55S1pa9D33iQN4CRyeUZ3bxGl0mgNYJShCg=;
        b=b1wMQWRayFNTxL36zQc7488BxSEW/HpIF4bMUWFO//a4nDALLZeaMGDAAVspVlh/DN
         SgaIgW3xM/iI4WJ29zGbdoybL3VIyRw5rh+k8gZeVd+ydsKlPjgtskaniXjKVbyKALSj
         +B9wB0IAAgSBsCOS5PxI1Dm4PJoWY+JfNc0thv7Jf3VCeECPChX8jfMiSijviU8YU14n
         wKBx87xK9o3pR+njTUx43rBu3EMenxFa2uVcmiwTBW+HAqTvjFvYAtH8kT4bio1jvzKM
         OEeAOM+DjexmT8bs9H9+mqosWN/tFDNYjLlnUQtLBnMBwK/dcH/M10HCCdK1oMyPp0Jj
         utHg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrOywYylcQ/YIJRA/lcSpj5urJJBy8bXbcC+QlxJzV3aWto8PG8hsalap3LDs/GqP4VZCaEM34dPvsE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekORW2t2quNWr0bvBcn7L9Jy5eg5r+esOtYANjVhc+13Rznet
	zh6RnGmasmeruKSG1j4L1N71qvVaEj4ju04gk2qUVIxU8CEzzyQXthEix4yxh0Cp
X-Gm-Gg: ASbGncvB9yQsr6EQM/YG5jWMT+L69Z/JdpjsfjCqYNCtGTnB7k5I9X10dNNT0POiymQ
	GG2vtpvO+YmIT1uDWsAiMPkRf/3ztPkbv4V/8LVrv2HM3jbjJcoTMweAC7+zCYsvvIpVio79buD
	swUlKQL+1VgzGCveMoekCpHTA8H6zG/7X4nvsMibJXE6v6pDmW8MlU3YprUa0hY3yjbrStTDrOX
	/OJXDK/9l0S+e8EJnkFv4CHD4bvdUBPZervTl5TimvbAkuB+SPIkXnEL8tHfLr/7iOk+lTYkVVs
	FmljHttGp/8Om82px3tFAFAs+KIdTus4dtPJPraghgVjFbD66uci9uCkIULgdkAbAZwrB4N74ET
	NaWBI4U1xNl8NUtSGdPfa4T5F0Np6qbxHYH3PG8ieObAkEu5KyBzsRXtvaFkoQ4PZ1sq4IY3Ess
	KT+dgt58Kd2DK46FD5cDgGtsE=
X-Google-Smtp-Source: AGHT+IHqUc4fx8LUFQZ8hvav+GM1r5MA2m3puQngPSAz/svFdWdEv+ZFSFoy+G7J6JLulAFjEXGl3w==
X-Received: by 2002:a05:6402:350a:b0:639:ff4f:4bc3 with SMTP id 4fb4d7f45d1cf-639ff4f5019mr12949247a12.4.1760362922068;
        Mon, 13 Oct 2025 06:42:02 -0700 (PDT)
Received: from tablet.my.domain (83.21.75.22.ipv4.supernova.orange.pl. [83.21.75.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm8729019a12.41.2025.10.13.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:42:01 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 13 Oct 2025 15:41:51 +0200
Subject: [PATCH v7 4/7] clk: bcm: kona: Make kona_peri_clk_ops const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kona-bus-clock-v7-4-8f473d99ae19@gmail.com>
References: <20251013-kona-bus-clock-v7-0-8f473d99ae19@gmail.com>
In-Reply-To: <20251013-kona-bus-clock-v7-0-8f473d99ae19@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 phone-devel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=vh/hIeQB05qjlIgWDhfjgy/vwvluYj0FXcfCExT1EEA=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBo7QGgLIh1OotbM02cBSNImXPm94eR/rNh7qr71
 hhNVhx47+WJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaO0BoAAKCRCzu/ihE6BR
 aIC3D/9CxbU4X9eZl7sCJWQeJfaKDgTtg3p4OPDgGQH4OW5X+rcW/olUGRpjJ8i6+7lS+r2Mrc6
 LYuT+TdS/jgYBfs/F8bWeAfyi/YqvGZ2dl2JuSNjb/Gu8F2FQsLBF8qQmvyHkT+NvZ+nfvA8sow
 7hhA7Pfsw+VjX4DRa4k91qrXgRMks+pKfS5/adZW4R+Dn067lgEbSF4oQec66elLUoItwxmg6zx
 gkWrvmZIYYbITyBRT3jCP3Vo69xP4sqlp13L3B+YklzquZghPbUaq6QBF4DuprXQxFrBFfMPTmO
 sWnVrtbYzhW8TfzkvuNVsc6BX2iH2Mbd78jaOn5c7cdZWO+YtXL1LUS0TaOh9WnBhIArgQ3jbWj
 PmBB59h0OFBD7GkZIp94AG1iUL7cQAMPIRoLQlPDxjDHYigpy6KqDyGbHG3jMJwk7waTY7R8eq4
 pFQCPpRmbgnNFS1AYjz04+W6zMJpHeuk2vXwjeQDYSF9PWE/d9b8q0LB6yGgZ5svLQk6dQKeWfu
 fkjOJbPiogzhMlClRu9X4mWBZGUmz95zxKq6AaQFpd5k8SkUNZhLjReh5sEjvJsg/g9+u1Tx2+t
 auMPAxhhQpfQhoua0mH7qn4MUhbuAfEGuSGpwOwMvv91fEf+hx/4q81a051Ndn4L6YwQN8PRVsZ
 89nyZL6D4wZBjuw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Fix a warning raised by checkpatch about non-const clk_ops by making the
relevant struct const.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 drivers/clk/bcm/clk-kona.c | 2 +-
 drivers/clk/bcm/clk-kona.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 0171e6b2bfca..2641eaa4ca52 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1154,7 +1154,7 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ret;
 }
 
-struct clk_ops kona_peri_clk_ops = {
+const struct clk_ops kona_peri_clk_ops = {
 	.enable = kona_peri_clk_enable,
 	.disable = kona_peri_clk_disable,
 	.is_enabled = kona_peri_clk_is_enabled,
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index d7cae437333c..7064ce316981 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -487,7 +487,7 @@ struct ccu_data {
 
 /* Exported globals */
 
-extern struct clk_ops kona_peri_clk_ops;
+extern const struct clk_ops kona_peri_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.51.0


