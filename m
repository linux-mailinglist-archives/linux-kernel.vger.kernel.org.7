Return-Path: <linux-kernel+bounces-775303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744BDB2BDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619697B8B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857EC31A071;
	Tue, 19 Aug 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEvL1X2E"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A026C39B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596408; cv=none; b=hmcac31BhgftztPKbnCy0Q3TqqfGPYoDl5C/zInDATu751UK7ixdJbHg3x4mIULk8JDzY3dBvWd3RZOpsxDZRQ6RQbq+dY78YDtZ9xTa8TixCRkkTamBnKaiG+YqMOWSXrUNDPEXQv8HZVNeQ+AcWaSl1FJHHCLMcsLadq0+L8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596408; c=relaxed/simple;
	bh=lFXMKJkD77TVv3skoL2tVIgQ3axtVWHXSpWd/kR21MU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r0Gbs3A+M1yFcxyz4bLvRRJkWYJBuhdwbSIXeOXQCvc+HIn90mr2JAlgoHnBCSmQXYFp46toWwY1c0KZE/vR2Ba0qw4z8S7VSjNmsbbKEcs4Q4cMQgy690X902mSEyYziaj+yGr6aLLNN92flG9e4sQcg2cBCn1w/pqE02LrZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEvL1X2E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b916fda762so2863505f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596405; x=1756201205; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiTftMOuutV4vYFy4eckN5Ll0Y2Ut9a5Qvq41E2l5PQ=;
        b=tEvL1X2E7O2/t2xOFEtaaVsUrGPktLAJ8T5HmXB0lbBdKob4n1S0oP6L2DxA3/+K8R
         3C5YF5XPZfyUcwgEw4UAnUJbgURm+sEeV+e8bXJoS+LItRN/q396vfXUh4ovS5khC1sN
         LsxbS2Nv/rlqCypVZkR7TWuRcBLwgA5UjKg1QDgpsxDNhSsajttcnX4HkGeqAOZHXNba
         NPlpF5oTyCrEVWTTCffyVNX/0SQbtWu6yvKrETwkEYF1xnBV+Y1Y1P45cMEjrlEYthVK
         5cc4j7wW3kznVXREJlk8tAXFQ2/bnQgw+TleCT3FqCqmNazp7srCL5izCpAKySY0nAvU
         fB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596405; x=1756201205;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiTftMOuutV4vYFy4eckN5Ll0Y2Ut9a5Qvq41E2l5PQ=;
        b=Q7VstvK/8kI6DHH1wntl0fPFcooUSiwgoRYL8GK+fkJOmYBJnqcRUuk2JV+QbQj+6d
         Ow+c7DeH4cqOzZ2PAkwRcNKhEFM6fPoK1hYPxWpkeO80KxFh5KyM8A6AkyitAq+XPymS
         sGL13sCYt+/LjeeCiYNrMSzqtZU9QoeOlB/0j0pO4Q5MSzUoAqiVprb0LwIdpEcVKDpw
         H9twdY73JOQLIHbX9Twr7MuHknK4g/8GmAozN7Ux8IVMgld4US9ELq0BU/lHUag2REVG
         AgVTU/FMZafvE2aYe8WScmCsGE3CvpTAnsdmoqNoWSA72ZVo2Ycg3jmLwC56ziU7EUpU
         W33w==
X-Forwarded-Encrypted: i=1; AJvYcCXpD/3A5zqF0yJALYY8BOpQ66YWpihCOkBeNZLT5hKUvdbxrXqNTyq7lW3qoipr9gIlf1G5RYsWzikiWV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRCn1Z4hqES0Dia/ua0Y9mfU+kkoQNQrmPr1/vQqW+LIdLomi
	sNGpM+YUVvJX+nChiIK3ClisHgwnDwIgYZCBMouVESsLwg2io/R06LDdDEgtc/711Gk=
X-Gm-Gg: ASbGncu1W1KdXZOIw+SnwAAVJBnsUjePo2SVWIxv23Weq4PjIgXqzfob7jEcCgKUiZe
	rkrVITOjGZo2xQW6yWkMU85VQOSmdOdkFbYMRzMzwT+w1wVoJatxpcdjlQaHcPEIyfmQCHm4eYx
	krYf/5yU92RqhxzKIiQfpfXcgY5UhHaFs1HFKzY0MnB8908+XloB/eYHFraP2G9Gw5QrJ71AvyX
	HnXtYBpGIfKomOsyoGwGGFzDqlQV1wVfzaPrY6R20uNnr/8/2chdzRHMdgHjMwcZlzSNkF/vmS/
	M6y84gaMBLtCS2xq/99ph8zgkYMPLDLULrfdMxdofYgEyYn0zGo9nFEvpCmA+aoDu8NMZ+GcTsq
	s7YYibAIeCL+3awbNFxMGEFjrt+Q=
X-Google-Smtp-Source: AGHT+IEmA2rIqWh10N25HpFTkyRTLf33hBwL7CA8l3kzmU1d9YQ8FcSm/BSFS4F04By6ZWvUc9Balg==
X-Received: by 2002:a05:6000:2310:b0:3b7:6e64:bed8 with SMTP id ffacd0b85a97d-3c133d63836mr1403055f8f.28.1755596405461;
        Tue, 19 Aug 2025 02:40:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6c324fsm201628175e9.1.2025.08.19.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:40:05 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:40:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Elad Nachman <enachman@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/mvebu-gicp: Fix an IS_ERR() vs NULL check in probe()
Message-ID: <aKRGcgMeaXm2TMIC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ioremap() function never returns error pointers, it returns NULL
on error.  Fix the checking to match.

Fixes: 3c3d7dbab2c7 ("irqchip/mvebu-gicp: Clear pending interrupts on init")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-mvebu-gicp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 54833717f8a7..667bde3c651f 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -238,7 +238,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	}
 
 	base = ioremap(gicp->res->start, resource_size(gicp->res));
-	if (IS_ERR(base)) {
+	if (!base) {
 		dev_err(&pdev->dev, "ioremap() failed. Unable to clear pending interrupts.\n");
 	} else {
 		for (i = 0; i < 64; i++)
-- 
2.47.2


