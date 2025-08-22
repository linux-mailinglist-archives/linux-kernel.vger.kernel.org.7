Return-Path: <linux-kernel+bounces-781347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BEB31154
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADAC6833C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B02EB5A6;
	Fri, 22 Aug 2025 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNksuNWB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E1248867
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850132; cv=none; b=AfFpQBHf7mR044kFnk8NNhVJ67OYaCUMuZJoF8jUydamNivioTfIhNCmmJRRSac0Ao0UbuONJL2BZPgwkJ9ysaQsFwPqtpsbzMpeBdLciP/tttuJf5wwBERgCvdbhZS9kMga/iwOctQyGkBAujXvQv/IYtb7QW5kRWlWyEzbxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850132; c=relaxed/simple;
	bh=gcyyJ3A5+OKGc6ZQvYcrHgZc5PnnJU7+8btR3+9SeDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CKS4WUYX7i8GQH7uuN7U9lA26a5USQ5m8/zjIf2VToFDK2BAjZfGAa3h+fXy3toFwYg2MkHmrv1HhGS8rx/JFoji6ZsPSqdu7G62jXscbxjbknUTM2HQ3IfQEz78g14XgFsYdUwzx2dJtvQ8Sb7z1xUZ9Ezs147eIDHWFLGz+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aNksuNWB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso13729825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755850129; x=1756454929; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNEBpGgZdG/2jJwkaxvAijY+ORi32/fy01Nt/XLeMz4=;
        b=aNksuNWBZ4gPWFE3BOx95zh9f8QtMwqMY2ZiY90uWqq0ZmA0TsdBZx94V62m85ukIT
         kPv4TklQgWLPQNWMiX60q2fenqBu212tdQbHrrJ9YDeerIHyAYGC7VIsoyVaso/KpZDC
         mENG9bPS8Oi/JIqQoWINePz0hrodaJhhDibhGx5e/nMMO9qgzFoKGP0PRLdavONsvUY9
         k9BwxUEIfjppiJ6NTGOBNmQ2oZ8VpLny2QNxp1POG95AGLVjyUY8RHzJcKmeO+tGWY4+
         5Kn681SFjV2emvXt1SFtZs7tfK+f89IxHsr+xT/ZPY1zrwv7WAoTpDY26jWza5DdRnFL
         6dCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850129; x=1756454929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNEBpGgZdG/2jJwkaxvAijY+ORi32/fy01Nt/XLeMz4=;
        b=k+mtdG8SXtMXC6SSd8tCDotc2NHUAPmjY57WoGAtfi3A1Q8uZ4kSen9kewImcn3B86
         VMMA9IGNQbQv5/VctRRG8owRKP6KV3d4GnPZCzpuFZlnizl5iiWjLD9duYPa9tLlMPkA
         IyX6FIU5u3MjA5rZqLG0rRkr+IscejYR9sYC1JSuo01M6PUXWsF8QWNJGB6Mra1XYAOQ
         uW1ffcLvNZIlXkREK1/tAD+3K0Hs50kDYq+ExVRzKFmUJAnhMyX5I8MBACJaU0w6Q1Lz
         aQ3PQgtdHsp9yM8KNdxXWSivoqQQ1voD+UjHC3d+6+G1Ob2yCpbF4T7Ed31Jt3L87BRD
         dHmA==
X-Forwarded-Encrypted: i=1; AJvYcCURXD+8nTkp5PysezPefqsWo7f93EW2gk9vaZMRQ+RspFmy85TCOxi22Nr3DRhlffiB18U4NAwIzmOv2UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+nhoKBhPQLF0dDqA3Ox9J9qPtxCMf/RYzQSaGZz6GO0TLVyZ
	/zUTMna7VI+f1DUqvhWbnB8RZpIMwk1631WE2roQoQZfyFivfs+KpjTKfrisrZJE5GU=
X-Gm-Gg: ASbGncssPMABzJ44kgSt2pODD2sU/ye04YwYWXcxey18eT/SpXvYvDstnHZntNvj9bK
	zwnYrEeMe5Hkkl9eOVyp68nRmJmJCdXV4N8/MFvsKdYiSt0C2r8khs5wZRn17tL44dvFXQ7kopD
	6Akv8wyjh2j/MsKvs5Suu5+/CCVlD8TpTHcy8ZrhgnNnASRTwbtrTRXLaO5ApukMA7XJQ/wYsrT
	7N5Eviag96hlQqfkJaCOo0gAFT0cT6LZ4RZjENxEkzcCzol9A4YbPORNl9WlGTntEXRY4wH82fy
	9UV+nFkPIfENf4D8uW4SDqRoTjwkcDnfTnmO6fQKIofC6FaoRIbmiJnmw7sKXLRIgdRB4803UCV
	IE7BD/mLUtVz2asgK9Nl/S5sOKYY=
X-Google-Smtp-Source: AGHT+IEsxW6o/F7dQT5UHqvxMpkKhAVZlHmWm8Xnxd3OnhbNdincCBQd5nTWNUKg/zsTGxuq9w18LQ==
X-Received: by 2002:a05:600c:1c1d:b0:459:dc92:b95f with SMTP id 5b1f17b1804b1-45b5179ce00mr17667625e9.5.1755850129318;
        Fri, 22 Aug 2025 01:08:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50de8a94sm28905885e9.12.2025.08.22.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:08:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:08:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] of: dynamic: Fix use after free in
 of_changeset_add_prop_helper()
Message-ID: <aKgljjhnpa4lVpdx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the of_changeset_add_property() function call fails, then this code
frees "new_pp" and then dereference it on the next line.  Return the
error code directly instead.

Fixes: c81f6ce16785 ("of: dynamic: Fix memleak when of_pci_add_properties() failed")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/of/dynamic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index dd30b7d8b5e4..2eaaddcb0ec4 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -935,13 +935,15 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 		return -ENOMEM;
 
 	ret = of_changeset_add_property(ocs, np, new_pp);
-	if (ret)
+	if (ret) {
 		__of_prop_free(new_pp);
+		return ret;
+	}
 
 	new_pp->next = np->deadprops;
 	np->deadprops = new_pp;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.47.2


