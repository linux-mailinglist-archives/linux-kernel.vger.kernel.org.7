Return-Path: <linux-kernel+bounces-881303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25AC27F49
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8314EBB44
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FD2F532C;
	Sat,  1 Nov 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeCsWzVg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20C2C0307
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003625; cv=none; b=hP7m7nYHGeIfqZxrJflL+BZXS00nXMDzgCSZYgivPwdt1R+Upz5w6NZD/yVr74bZnX6/pwZVPj/t6y7JnMTwDMn2y6XuI9I3CtyMOVJ3pRkqfkevB6e/znTOOjEOFG2TvEkVTPBhWINuhfQsUggqMTAruSg8mQR91bo3HmWAQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003625; c=relaxed/simple;
	bh=fWlbNlumtIJU8NMitW6PzV9ymTkF7fleZ1mZ6E3kFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ASSgo8r2ZhFq/m8VInR/qgLiyaFKeD2riqzgdoU34ewuCNLZ0cYAsPNRz2fMYi8F0BvPBS2MSvMkseKloOuLGyMbRRZP4d4DAoiJD94Q6pEqfTdTeDdfHolVOTJ0+Mpvh0TjdZ688Abg3U7Fm2JKA0i/5M0uGTpqQQyMPT6y6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OeCsWzVg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710665e7deso14250455e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003622; x=1762608422; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOljo+7M94iVLGqaAQA2njY3cBe7lZLjBtaF9D6zVHs=;
        b=OeCsWzVgfF+NDc5oR5yv2J0nyxO4AmTT+iqw5khA2+MbYRLxaB23hGLl2yc0/ybhT3
         Gk/Acjse9gghXVJaYe/Sim0lMguEsFapQAzbN2zLEdbwnsDMefzY/AW3iWaxcrOAfnoX
         LxY5klura+q5jUy8PL8igtFv0MXs6TKLhQirJa7s8UnjG2x/ToU9i33q2FFssnvHoDYx
         QpnSxoeRG98mS4qT2K6lgr6Ic9tC31NtDS5V20WWWbfGZJ6/bmEhQVYZZ5ldz1oS00jK
         s/mgceMlPwuoRr3zr76XQ+OVM/wYlf1uHDAEnj8vkMEkMzjdM6O7qkhz2TYsAEVSpEe3
         pIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003622; x=1762608422;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOljo+7M94iVLGqaAQA2njY3cBe7lZLjBtaF9D6zVHs=;
        b=p/GlIP7l3fBrmbx0JirTBPSEdGIM5HKzWUfVIshfF/2f7wUJNi826LVRry8O8yELoD
         kJauuVIzMwA2uwi4sUDsJsUuLuMaWz86YiY/Dk7du1NfmMkBK+9E/HmQ3MK7x4b9Mf8r
         DZDaY4pMl4yNa2Pdh00MmiZ01EphLUDqBaWxA1rB55Rey9bo0WZYaawTBcil5CBto5Px
         Wms09CMMjVxL6jV1bICDxQvchHt0AsCcItIdvqR3kPI8Bxv0vlLV0kjH7QnY9eAxjOJI
         mkmVrG9P2/84y0abOUwhDZRpK/CejryI9bSyE3F3aJeecFjQaWAqAYNvpRdnH0LaaM+y
         cLOg==
X-Forwarded-Encrypted: i=1; AJvYcCVvkmQyUPavfVyqU8N6R+Ts1xmF7cNORAspgWiFpwCHgmTholum7SX/RsYMcQwJqQ+WN64EryFbzznWMt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKj0hqH0rU8DS+GA0DStwG+BzXPgScQWFJfzys2kHHefYtmLb
	j489RhLNE5Fcww+DwzfXWuXXfb7Mgz/Bh2UEkRSA8QKeoTsMCmDtxGZSvJbPzmuXoms=
X-Gm-Gg: ASbGncuzJdmS/z0y+PnCjvpwz6IgzH/92SnG/yTJKoAMDzpHYVbjFiuj3kubVjNKGbz
	ke5PeX92F1f5Ysc1Q2swlGtFDt834vihH22yJPZ8qd0XSmdOH3t2Mx73LQlvEJVO0nFjAgfAgub
	YM7928mUtQhriL2Xbbqac+gdByKPpm0WfUQ84Tb+JQkTrMMXRhjMHg5dW9W0xQ8l8i8+tXKVUJM
	l3yCh/EoEPta/LOclKSXP3Abgb6KuKlulb4d5DzGh1Ztq7zpL0NbFSR7NzbplmzaSlS72cEX3WH
	nGV+FQcIWqjmzY2GyKJqB35C5ExY3ypRz4VZnKOTulQHTktsWWZKmhzEDKEKYgpCRysxa0/fRdW
	qd7R3seRPXdWSeJqKggdkOnRfeOGT17Y3HBAL77HpShnt+P9vJ9eW9kljyUv2BELA2G/2cMsCpW
	PHzraLphQV3G8OsC3r
X-Google-Smtp-Source: AGHT+IE4cFFbUyFklIu8Ul5MgDjUxTX821uY1/uQ0hddPoJ9GnQf41D7nTZg/rZeH9y2qNDX2ivo+A==
X-Received: by 2002:a05:600c:3f92:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-477308ddbe0mr65219995e9.37.1762003622105;
        Sat, 01 Nov 2025 06:27:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47732c2e725sm36882335e9.2.2025.11.01.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:27:01 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:26:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: Small cleanup in of_get_regulation_constraints()
Message-ID: <aQYKoiivuec3m0Jj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Just pass "init_data" instead the address of it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/regulator/of_regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 32e88cada47a..33463926a2a6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -79,10 +79,10 @@ static void of_get_regulator_prot_limits(struct device_node *np,
 
 static int of_get_regulation_constraints(struct device *dev,
 					struct device_node *np,
-					struct regulator_init_data **init_data,
+					struct regulator_init_data *init_data,
 					const struct regulator_desc *desc)
 {
-	struct regulation_constraints *constraints = &(*init_data)->constraints;
+	struct regulation_constraints *constraints = &init_data->constraints;
 	struct regulator_state *suspend_state;
 	struct device_node *suspend_np;
 	unsigned int mode;
@@ -359,7 +359,7 @@ struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
 	if (!init_data)
 		return NULL; /* Out of memory? */
 
-	if (of_get_regulation_constraints(dev, node, &init_data, desc))
+	if (of_get_regulation_constraints(dev, node, init_data, desc))
 		return NULL;
 
 	return init_data;
-- 
2.51.0


