Return-Path: <linux-kernel+bounces-871948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8DAC0EF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C9324F7DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31037308F27;
	Mon, 27 Oct 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcmD5XqW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63142C325C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578309; cv=none; b=u49xr6qhO+lvLE6BgILql3znmgAUY1fkv4SsEp4bW6lxYNGyXHqJOQV6SwBuVDrLIgH+kkKXdpWdDcl76fO0Ft7l/ydqAk2bjcfMUqW94ZiVPEpvtPIFj15BMHD2vjsou8peEsBl2ybWMLQOsQmE+VDboSFJNxeVbYtbOY+CvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578309; c=relaxed/simple;
	bh=q2ebHg0FP5SJZw7LCfwFjACRYxvCtncQrxpN01n1tpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGXvaE1VIwLtwIZ4uGP5dbQOsQ6i7KqtSI0E6tuhqL4DiApS8PZfkcH5uV416DY60qiOGZEX3K5nn2FikaHe+WJd/AYdXmdNhIwth+nQ7py7vKNExdW547+rjZahVx+DtJrDaZO1AlKDWzQHMupKiBzO4BfqXTMbzGZ4NWXXMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wcmD5XqW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47103b6058fso35352465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761578306; x=1762183106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZTFmK7GZ1TVUPmzZfwKDAML+TZOEpqWW3nJyVTGLdI=;
        b=wcmD5XqW2iZ13Gn1ejeWVbwwFAK4F33xho1Z4o3WYYQW1rC6jj8NlVcjCkSyl95ti+
         OjqqD+IjV5vLlyiRjm3b3E9LnqWi477LnGeqmOPy6ENOFrGApb9JyFJ66fMGOaaAZX+4
         wKNOFfLgl394/hWM7N70kDaMKcBsd2DW9Ye+vn0GNhwr4F56V1rAgS+TZJzi4+cdshPC
         EJ8TYhrta3KiNYJdqFA8O+Srfk9S0tAtP1LRtegXR9D9eu9a5MdAp0Ko0Hlh90rkSqr1
         tpxoquWMVQ+OnRXdGO6nwRevnCJl7fsQv5t/YhUQ5ZQHQvCC9yNpnn0m6+LQyljsF2TC
         vWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578306; x=1762183106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZTFmK7GZ1TVUPmzZfwKDAML+TZOEpqWW3nJyVTGLdI=;
        b=amxg7haorcao2U1EdngJn1K9/v856PMxvzTAfwCk2Fysz2Rdkao+yW3Qz/ywlqfa1M
         gWpXR1bM4pfkXrJjqrO0JBm0gDw/KV7y30HC5Kha6VtRHuy0U3vEjtyDJotTLLqDHZUM
         2Zvtbr8rBF9kF6b3jlojlmu6cCSXwHSgzrZLGr+dvbNg5mjwUyVed7Q3P1SLjDEd1n8O
         1/fewA4bcq4Mq4Dsd0gW6QNFzJY7PZRbpZNNUtgsEd6JRq8qh24MQsUm7HLqOwL+R1vY
         8dFNrY1LjYaDFkweglT+UQOnavGLi5QUVK0FLHYFt9NcZpeHyUU7oroFEbF7txd03n9k
         4/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWQillyZad+DXyU7CYL3D9foJXUQYfaHbtjDlTND/DeSs8E21Thq9qYTHJqGQqWlUtUCG38D/xYM6rBrUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qWTtnrC9d1RADjm1s1Cpf6HBkD3/C2pie44ZklHgO9ybXlJ2
	gRvJi+fvm6PJT5vwhpt0ZFVZhP39egw/GCmBvLDzGYSWvl57hiXyZ94v6XjnHIve6XQ=
X-Gm-Gg: ASbGncth6wHjzfJt6N5IkeMtPe6rh9LmhEz58vDXmw3XXGSngP/63yyxHCCD/aKCgS3
	yFa1g1FLntX7HdCEc/xKHIosBfd4CiEhJyhSMLUa5d+l2SOXid3HpohDMVx7KqFPyElJHC7aGwk
	dmi8z0XO8Vyb4ZqrY/Ul83yCdUIs3V7YVNVx/rYB8PESAFj/jcxZZetRDYPlLmHI/x4hk6IJ5Gf
	HiMiYrzjANjFrEGGAYW4O5IY2Yf3H1Z1xfKZwC2mOMqeY2pGlKon3z3TZADupzi+9+hV5VDUO+N
	ThMZN4MLga1hK/G3gVgjEmj+EtfLigg2KdB+PssJaDBGFJHRt9hkK8l4j+UBIhM6j7afwNwp8ZK
	8bsG2PY3+4RBWoKWsj48LcjSpb0fSSl4ggJogECHvUdvDm/XYUik5sA04e8UavGpytMoNCShoF0
	cGFy0qdYl8DxAvspZ9
X-Google-Smtp-Source: AGHT+IGdQ3Pl8WJ0Jr9WgElxkVUFCnaBaIruVM1SpSmzXhkaMb4CpF22naG2Hn16N7UnuCwyffttJQ==
X-Received: by 2002:a05:600c:3150:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-477175ab715mr4793705e9.2.1761578305934;
        Mon, 27 Oct 2025 08:18:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475dd4783b8sm143053295e9.15.2025.10.27.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:18:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 18:18:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl-scmi: remove unused struct members
Message-ID: <82a8a4b206ec02dd27a119d7f05d2bd6c8d2d3fe.1761576798.git.dan.carpenter@linaro.org>
References: <cover.1761576798.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761576798.git.dan.carpenter@linaro.org>

The ->pins and ->nr_pins members are not used so delete them.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I sent this as part of an RFC earlier.  In this version I deleted
->pins as well.

This can just go in by itself.  It goes through Linus's tree
since it's int the drivers/pinctrl/ directory.

 drivers/pinctrl/pinctrl-scmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index d14528b9aa31..af3ac031e362 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -40,8 +40,6 @@ struct scmi_pinctrl {
 	struct pinctrl_desc pctl_desc;
 	struct pinfunction *functions;
 	unsigned int nr_functions;
-	struct pinctrl_pin_desc *pins;
-	unsigned int nr_pins;
 };
 
 static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
-- 
2.51.0


