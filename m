Return-Path: <linux-kernel+bounces-860239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA2BEFA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569D43E4CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E92E03E6;
	Mon, 20 Oct 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpHHwWsI"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9262DF6E3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944688; cv=none; b=ZmzWyuq3xReKObPkgPalMUxzscz6WndWZ0tiA+hYL/TVc9MxtBM04J9JdmOp+URuzhym4NS0A+aL48n7NePKumcxC5mPYRiQ2MZIXynCY0fl3SB+Bg5BHNlgSOc+DIhx+r4c599N3/T/s4jlcJJqTIdCokhjT/jbLrkj4KvlELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944688; c=relaxed/simple;
	bh=SEKtq8WlaDinzaqN6sbmXex+0jo1iDkPy6Zh0RvgHvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMz6lY/pxnmW7HaUH3926R3na0W7qKk5QbYzEW74dmnxFk3xKOzAmzaAYTSlL24MPUNagUtoA/xwPkrvWG1NuCyCxnb9GCy8mENKXImyS8XSE6v/23EVBxGwIANaeOo3VlUpiafKVKz0QjKOUYIMl9IdZl+AXuYN9dA5Bl9AoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpHHwWsI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so49667041fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944683; x=1761549483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5g+HyoylNTGFqMAbK4m0O1tDUAH9kttNvpRkli2e+0=;
        b=CpHHwWsIKUXCT6q5m9I9mxzTyt5s9907yxnIA9xQqj7lG4zyjBatIsMTcwNKZibolx
         gJlp0EFRw3ho6AIhVWlfFt6MMFmNwwyzR8Y3g7UovgqDG4wCyZe+0XFvpJtGm8VpZUgA
         j5PBrtmqnSWnoTVLYG19fOuPecfEf2Rih+jRDfCUlynL9GgvbRNI5d4w5H3SHz2Eu+sR
         2Vh+092jEv3i8FEK9K0VWTmPuw6gxGQI84Cad3EGxVSSoPlAQNTx+OWaBIO1Sf3UylO/
         UHq99K8Bf+eA09Hh54Y1YVT6EMEadhHCPRW8zxHAc1kidbG+umvxfIuI9Q5npRO9cxED
         3TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944683; x=1761549483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5g+HyoylNTGFqMAbK4m0O1tDUAH9kttNvpRkli2e+0=;
        b=ElGWY3lj1Zhyz47dZORMi96WdmaKnu2onL39VklqUoDyNpMLOlzCwcK6X05oux++yg
         OIAs63RVFT47h5fPdTqjl/HDMWt9xCOc0/ybREtzzkvsb1icOoJ92IvtxVsl1+edpRfG
         XtctdmV994VnD9H9rq/KTmWVP9zqp/sd4f8X79gk6bChaXjW0WHN/z4K0lSmr/Foi/zV
         ct1cEkR4vZf1mkXrUFbU8TdSjixBbEOl4BcTsD/NirOcg3VzQnkTXouXEGXQveGoNr+W
         E2PKOyGVsFnKJnIDk1sn780BLMHO/w0I4spW8vj4eC5/iaKdtnNIQNjo9wBJ8/5m7udu
         KrNg==
X-Forwarded-Encrypted: i=1; AJvYcCWtFqZlzrp832CkFzpVYqHpMSgKog0/IHKz4n6xPvDvb/GzIEpeVLfkjmKAmu4ANqQ5ZlPW5xnU/GnC9yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotqBpXQxOZOa4PmAgnY2YBqmruwDINUj9DnJCHi5Ne4czZUMg
	N404RB255kamdFe+MNKIDo4avY184MfjL1sv+3SXUKtWwkZ47RG16HZK
X-Gm-Gg: ASbGncuWE4F13ZxurAmd1pL4uEWoxdr8mhdLQCv01Vw+Gm7BMLILHE/hAwQ5jGOGaPE
	6+ICh6cyP+e+FOUPZ5j6C2JgZFCGs2LaipnZIb0ngMXdGLuZMFQxJJeR4jW71u81c/XZ0woOUKy
	BNDmtaA7Myoe7EiTmO1FGhW4E12lJIN4vtH0GftHljo9yFzI7kVFjV8A7hb5F/Yh0x7DnCJ4ish
	5ocbt7eTuAuqZshY8PtajXgYlTR2lBvBQUDtrl6xWrQsyPdRcEsiTOJ1MHKBNM1I8tG2RqkOPQH
	Fn1koOCUJMXPGNXyEx2ojbmFR1a+5Lm0fE+t6U5Myq8gejGHXOfPnFk2FVbHFMzibS/CLOoyVNh
	jzMiOCQmTLWyKleS0VcOqjejdsiHlVuv9Y+BgM1rVqliT8bhN5soF6/e00F3uwr2qolw9SPTcaX
	q5rNBAiyYrfyaMEzyFTmM5ojeS57arRp4+7tB27j03fyxk
X-Google-Smtp-Source: AGHT+IGp1YoHROdSXnH/uYRYyc4xRRnoYn8XBIGIRo9FTNvDdUeBD58r78uBHGeJccaDt+7VPakDHA==
X-Received: by 2002:a2e:a9a1:0:b0:364:e586:963d with SMTP id 38308e7fff4ca-3779779ed24mr36793911fa.19.1760944682677;
        Mon, 20 Oct 2025 00:18:02 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921ae62sm18863341fa.21.2025.10.20.00.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:18:01 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 20 Oct 2025 09:17:27 +0200
Subject: [PATCH v3 4/5] i2c: davinci: add support for setting bus frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-i2c-mux-v3-4-908ac5cf9223@gmail.com>
References: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
In-Reply-To: <20251020-i2c-mux-v3-0-908ac5cf9223@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=SEKtq8WlaDinzaqN6sbmXex+0jo1iDkPy6Zh0RvgHvU=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo9eIZ1Jf69x3LAuim1DypUebtkcRfpVSMEi+DS
 CMACgQmyliJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPXiGQAKCRCIgE5vWV1S
 MoKdD/968DvG23fzIcVGZGpsOk49d/VnVy7WOHLZ1aymMwSR226Np+PcY3TW95V8f0lrR0BfWfC
 GZoxRRTcYiVCH8SMN2YnKcJFISC5/aTE4pcOwvrIKGMj0qOf8QFuH3wEHjAHOgtPwKhqb0tu/bd
 8FXDShyfUiR8poUbWGZhdw3OhzrjdTApQc++Lydmlb4QiF9eB8p1gu+Hk6LtyOS4AOFr2VeA7tS
 PcltmLnDsNAZPGxFxqBvScGfXpijOnmShj3NDXSVdR25VbpHy04sYPxLfoJc5eW8MM02ef3aBdi
 xuQYjPXvVlDXF893/AG1mcEO68CoSBXN6RHcVCNlDEa4YHl6ztpASahiMpyrOqyt5KI2zwUxE8E
 1TBi9CG22ppH1Mk2qpXY3hX73i+s3h1JWg9cEUH1Fps5nHROoWIsm9Ot+WiDWKo6T8+KcHJY9df
 ehIalq+w09UyIrpC+qHd1h673ADHbnSIVdRuQ/B0lh6RX5so1uqWwt6WbMa4CgC+LhacwwChb0N
 tznonRbF3lm6a2hymMgR0huj6TEWHKoZPt7kfmlAnEOYzMmrUROjZnhqxnHR1LL9K6t4g6gGxPo
 8P7LXYkkC8CaVx8ODOLAxAzNXfvvmsNB5z/Er/9icX/OD9YLfxCM3DZn1veaSZkYlt3RE96d9cf
 R0Tju8jd1zleopg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Populate adapter with clock_hz and set_clk_freq to enable support for
dynamic bus frequency.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 82f295619c4d0ef108c57d13c10004aa25014cbf..fdde573eb59d11a7c6a87141863df1b9b58f64fd 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -279,6 +279,27 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	return 0;
 }
 
+static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_hz)
+{
+	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
+
+	if (dev->bus_freq_hz == clock_hz)
+		return 0;
+
+	dev->bus_freq_hz = clock_hz;
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+
+	/* compute clock dividers */
+	i2c_davinci_calc_clk_dividers(dev);
+
+	/* Take the I2C module out of reset: */
+	davinci_i2c_reset_ctrl(dev, 1);
+
+	return 0;
+}
+
 /*
  * This routine does i2c bus recovery by using i2c_generic_scl_recovery
  * which is provided by I2C Bus recovery infrastructure.
@@ -810,6 +831,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->timeout = DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node = dev_of_node(&pdev->dev);
+	adap->clock_hz = dev->bus_freq_hz;
+	adap->set_clk_freq = davinci_i2c_set_clk;
 
 	if (dev->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;

-- 
2.50.1


