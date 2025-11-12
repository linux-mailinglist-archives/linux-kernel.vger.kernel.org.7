Return-Path: <linux-kernel+bounces-897544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC9C532F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B7B4FEF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914E33BBC4;
	Wed, 12 Nov 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZ+xoPmq"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDE30AAC1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960956; cv=none; b=dkwBu/yqFsOAqjeK/1cLE0YjnHWK+HwpxmDPLEShNnmt50CdCFveuYVQi3DIbqVNS+5cM5bAAjy6VI5NchNw7a6toJzehF9TPjlB1ejvMzs68I3jPD0+UvVThxWzRHbScpbGgQbxWnA1qWJENB1eE++bglgcJ9PWXCGMocFYVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960956; c=relaxed/simple;
	bh=210QQ0X8fq0FsJsy+nHQRHwEoHeTT7356Y9zDU0LrD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOUZ5CLu9L4tuWGmv7AglHM3J0comUA0P1RzKInpAYbGxfIDNhnGn+nlERdktpPBKGKia/U3NHafRf53aJEnQtDNk3/+ZEApnkAQFgzvNqwLS+qjkW1PQNSntHhkEtzuMeJU41bwLi30U8yPqZh3Dws6ftGLH8ywyNPRRBbo7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZ+xoPmq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso8657455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960953; x=1763565753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0f7cHeyj48y6Jvj7oQh+IhrQ2eaIAgk3d7czkbJdpbg=;
        b=nZ+xoPmqxjpzgnBm5PEj4FpVTUpDKQ/fXNiPB5bC8Do1/F76fU9QWX9Sk8mYPJtt/w
         yXvmzBEak/F4gbws7ZA5bnzr83HOri3KuTnuYQO5t67aAOJ4btkPt0Q0LLIsO/ZdAUfZ
         7ftRfFSvmGKWYO/5qa8E/OESgYSUb5YJPBk/8f1LuePnb4RS1gJE2P9BNbj46KIq85NJ
         c+KmXDUogXKOizWFCMLibTX1SOp2vcJXXFlvytaQPbFtIeqK4mGGJzfFQFIb78LarP9h
         RXuTpOteudWDWoVsCt7mF5tmCQpuJxJsjS3IfXXSUKvy+PWlNcrXS7/h/W2tVoMyZpfv
         Me/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960953; x=1763565753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0f7cHeyj48y6Jvj7oQh+IhrQ2eaIAgk3d7czkbJdpbg=;
        b=p7U6JWEthddxJ7rpio2KaY5o5rFo+iLVPZhO5grniJpZ5IbKieBHG0mHy0OJZDK/2P
         VUsG7NleGm3tfMvBG9FliO3FS+oZADF80qYXOdCTI8IbNc2aZ0vCOTPUEvPS0xiL7gRn
         ADU33Ieveje6PNsy4b54+kvDVGjQDX4LYJV9tSpkLxqj1PpBXmXNDZdLuASoCyHrKxyx
         THg4D+yYgdeuBNgvZ2YwmkywlVE7CewSrtm4gLatgi2yhqz9BYKv7E3RSvgATtgk6EJo
         7hKUTkIYmKPrXaURM8ia91gRgTQcbRue8eKCrcklX6P9XYKja3HNQJHXXV2R9DOakyeF
         ehTw==
X-Forwarded-Encrypted: i=1; AJvYcCWm6uiZDD8UqtKM9gbWhSplO9toDMeGYfNb8ZIpkM1w82BZT29QByKnW35VY0WYyUnnyykIrGm4Q5zXlno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRN7wpMFbeGLGk5UxZUHLkbpYAP0fVn4/5bplxFi/mPi3um2DU
	DIfkvZYbljvla3RnpA3DY32UZN+PQ8i1LGdwaIkYylZZ2FtfJcwAiIj6XWdWPgiaPx3tkczksDY
	qFoPjVBI=
X-Gm-Gg: ASbGnctXLgcW5hD7OI7/aIgstp/USuVueS5q00wjLAIKcBdI53TvT3ojnkInRmmoHvk
	T5w/wSp0YFUH/j/d6B4RSQCNCsSzkHL9732JCPkziaSLjf8NuiefayPVg+7iJ5sEKmIh1Q78kjw
	j58ZyoFUqAzb9Q78ug/sd5WCRNCAt6cq2w9AXpl75voSyMgZXBSGTmJ0CLxsSQ7OXshE2aSpC3D
	c9mMoaPKf0Ltgg7d17Jw8/Mefb0DFgX14fpmQfXLHyAkWxeO2yvu3YWJlJd5vTWSi7nyCsYXg1y
	qH7dOpkGsOZkRv9LTUGidMHgy98BLjgNv6tHDeYbpSK/JbVHrlOH5dehKnnDevLGTjrGRKcm71W
	PXxmzWi2A19FkLQEz9/VWygJLuTyCQAP4i+iSX9gs5J5VaPvryhvXZnDhTnIM4br1URdBp7FS+s
	T+do6762GYEw==
X-Google-Smtp-Source: AGHT+IGTWs97Njo9/LOi7JghZmPdDO+lqDr8Zjnw1ns9XWNM4GTecb2CrtmosaObhr2irKbWuwRS0g==
X-Received: by 2002:a05:600c:1f8c:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-477871c47b6mr35226945e9.28.1762960952689;
        Wed, 12 Nov 2025 07:22:32 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:10 +0000
Subject: [PATCH v4 04/13] coresight: Hide unused ETMv3 format attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-4-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

ETMv3 only has a few attributes, and setting unused ones results in an
error, so hide them to begin with.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 17afa0f4cdee..91132abca244 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -106,8 +106,27 @@ static struct attribute *etm_config_formats_attr[] = {
 	NULL,
 };
 
+static umode_t etm_format_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int unused)
+{
+	/* ETM4 has all attributes */
+	if (IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
+		return attr->mode;
+
+	/* ETM3 only has these attributes */
+	if (attr == &format_attr_cycacc.attr ||
+	    attr == &format_attr_timestamp.attr ||
+	    attr == &format_attr_retstack.attr ||
+	    attr == &format_attr_sinkid.attr ||
+	    attr == &format_attr_configid.attr)
+		return attr->mode;
+
+	return 0;
+}
+
 static const struct attribute_group etm_pmu_format_group = {
 	.name   = "format",
+	.is_visible = etm_format_attr_is_visible,
 	.attrs  = etm_config_formats_attr,
 };
 

-- 
2.34.1


