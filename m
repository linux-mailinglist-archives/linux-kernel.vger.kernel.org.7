Return-Path: <linux-kernel+bounces-791773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1067B3BBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD45A231D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0E31A068;
	Fri, 29 Aug 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jxge4PQR"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A31EB36
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472261; cv=none; b=EpeK1lUJGFHS7btI+SjMBhcjVMBfE12y0PzJdXb4jVWShVL947lx4i9dp8jirN62AIO8ihT43/mvW7NfKqm26QrtOdPxm8cMw7J9qZF/1hcNUHHoMqrJae7leJOEouVIsXpY4PuzCI7FqU6QOhbvD6W7OzGqyM70jUCYg0ySwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472261; c=relaxed/simple;
	bh=4DJ5TD3LPs+dlaSYUK9sPSDfziv2OnIO0PiD9AsLDxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQVVyxGQgCbArsTE34IO1Nj6yB6jsx/JtZKc9J3wKryw8kT8hK6NCvaa9nBe2xsJCV/CSUgza37Wk292S4F8aXlsKSXqCXyZZKUkqT3TFyRxgwHprbYTNV3hv+jhyJI6srsTxhqPXXZMJQI6hKYtRaLQJDU9Vwg1BJx+95Tupio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jxge4PQR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so750555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756472258; x=1757077058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpA/ewX5yJEUV+0C4r0oVn+iS4syCSTzFuXWGmDLoYo=;
        b=Jxge4PQRM6ldn+kEndjUQsHwSfNENkYWtpTB761xF6t6jQWewME19cNo2vIXp4tom9
         1yw0gaiyfsW7s9LFCKMXrmFZnZ8l3Av1yqv+m7C6xCD5zSUwxLYDTyhBpJ/nPRTHR+zy
         cqsEewq9GnG6y12gQj1xYdR90v3+ZgYsWnsnAYO8a3Bc/fBbdZpORZBKjr5WfuuJ5swB
         jUGGpnrclPmvYOmgwFmku0IGFzs57LY0klRS/GCsYa5EDSFZtH2VLDGrTj54MuCl+rZp
         MBzQqycPPwm2Q4Q4guhZ1vP/uOtqUaInzCOx7Y7q/9GDvR+IBG2KTO3xVFVLTNc0hCNg
         Vizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472258; x=1757077058;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpA/ewX5yJEUV+0C4r0oVn+iS4syCSTzFuXWGmDLoYo=;
        b=DnpwQSUFtUJ117XHeQlvwu+v5KghR3VqieMp+aOduPMy1Z15i7PGhl/Otn0EqlxsNH
         Z3Gp296G04v8CLxczf+zxXxP6qJ7AylIOyawLttZpFXRsba1vcEBIPSGJJGOqt2tmo2o
         6ANm2AY7cbIb3t443L72i74TGMWoZdm9TOAZAcD1zAOmFFgnV8TE/s558zRm0hF914GE
         Dhc2h34GVZYoSOqoHb3phrsGKLsO8K6DU1pOL1jtbobsA0YaK8aYnfN/7lNXqsIFtjpO
         l6181DeUUbRN7v7rY7URDPbtejceKypgB+RZTkQWHE//iIFnr4qivfS72sWjE4YQRIyC
         XHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRiXHyD02TT3T08ValfHqsCZZZ2Xz0O0JXJCa9+1/DcyWs/LtjiEk61JImmXwjQG3MD/MecDPPrDUvCNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+JrfNACQ61IGNIkuqkdrnP6uqmUc2LV3Yq1E3unEOH10LlKz
	6r71/8rjNeNJ0/H8QYVhoq7VM5uxhzF/dHhE48cD7soHxcPzsKqUvBVqQhxdLPlSAXs=
X-Gm-Gg: ASbGncuhtP+aspn7zRbcQKRZhMzzf3jvGZOzc4Luioz4ztlXi8r/90vTH3vClb5Dvse
	t+apSc9Ge+s5LXN0b646A+QqetndvBn93TszxMOo6By9QbxFGuxpAho8mV8lIdPzZYeuqUOdbY+
	c7X3siCyWxEeO7aY3/jJ0KKmmIbWMhsaMQtMA0JQNvn4p4wcUA3K3rc01WCSu7qXrkK4XgIwOBT
	fSvmMDMbJBs/Hk5EfW7EgtMKTRiF8JKe6p6k7WjmVV/sqpjNiim1hwmD9D6iNEIYNStQ6TmlWbN
	tLsn4reWVdq2UgkPiOF60fVkEt1Q0N95Ew8/auwPR1jvIA4FJKRA6ed/JkKj8uDtvj1DYA4MJQ0
	YukM/JQ04GQvt5TmJg0s3lEa+suxbbUsdFb1y5/z67WMLfEel
X-Google-Smtp-Source: AGHT+IEk3X0SmDDJCM0kDCrUQkEzXw5unbHaqvpYBH8N1Kie2B/+aRAtHjZ8wJqalzmQyaEOC0bTTg==
X-Received: by 2002:a05:600c:3596:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-45b517cca56mr247842695e9.25.1756472258171;
        Fri, 29 Aug 2025 05:57:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e8ab832sm37195035e9.23.2025.08.29.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:57:37 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:57:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: codec: sma1307: Fix memory corruption in
 sma1307_setting_loaded()
Message-ID: <aLGjvjpueVstekXP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The sma1307->set.header_size is how many integers are in the header
(there are 8 of them) but instead of allocating space of 8 integers
we allocate 8 bytes.  This leads to memory corruption when we copy data
it on the next line:

        memcpy(sma1307->set.header, data,
               sma1307->set.header_size * sizeof(int));

Also since we're immediately copying over the memory in ->set.header,
there is no need to zero it in the allocator.  Use devm_kmalloc_array()
to allocate the memory instead.

Fixes: 576c57e6b4c1 ("ASoC: sma1307: Add driver for Iron Device SMA1307")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/sma1307.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 6a601e7134ea..b683e676640d 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1737,9 +1737,10 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	sma1307->set.checksum = data[sma1307->set.header_size - 2];
 	sma1307->set.num_mode = data[sma1307->set.header_size - 1];
 	num_mode = sma1307->set.num_mode;
-	sma1307->set.header = devm_kzalloc(sma1307->dev,
-					   sma1307->set.header_size,
-					   GFP_KERNEL);
+	sma1307->set.header = devm_kmalloc_array(sma1307->dev,
+						 sma1307->set.header_size,
+						 sizeof(int),
+						 GFP_KERNEL);
 	if (!sma1307->set.header) {
 		sma1307->set.status = false;
 		return;
-- 
2.47.2


