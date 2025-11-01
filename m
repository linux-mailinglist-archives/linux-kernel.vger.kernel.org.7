Return-Path: <linux-kernel+bounces-881299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9EC27F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8044017AE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD32E0926;
	Sat,  1 Nov 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwTD3xXO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E928CF7C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003526; cv=none; b=cpWna9QaF/JlpI/k0vTYGJXHAhK7QSyqJv4xFoOT27LOLeRtmwmxAKKBauR2C48XzrV1XVwMmvWtTbIkfFeepVFP+R4lk9HbtxSUYqZsbqOgcD0wFIj6guQ9yKCq+QDgK97YJYSt0c4t5HildzPd0YQ8hURqIU1lNUF4d+BGLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003526; c=relaxed/simple;
	bh=iyHWDRHqIdQqUjQt4Je8Lh1m7HHX7UTqjbeJ5D3U40M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SwJVuh2BfcWPq8Yfr1QL6QFYZQ6eoHhL/nNnfEhsaEEyapP5gupaiUL4HPF3I9d7LnxhLG+142NDPPBEf1huZm14Fe62sBzd30gz0RnzkZRR20t+vCSkK4q5bwPqTVOYrKZQ6ID0wnDS3rO57n1lgVTSSuUzMFZsJ7Vd6ot3ZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwTD3xXO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475c9881821so25439845e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003523; x=1762608323; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da/X0BAO6IQgxLa90hj30nT8tKzSWhqU8L60WSbzH/k=;
        b=iwTD3xXOM+qxlMwWMd1K2KaslvSaC2jOgu+6rXoKd1XUWfG7TVc77nbuEY+b7HBAMu
         JKr+h0Wt9zqLhJrm410eVEHBoxykkJP1d0bUobLlQhkppRqFDWvw88Gh4xbqtqMXx03G
         aIvzHW9LHuW89OkuGIOehSCaz1WDilq6IeXQBup9cygDZqZAOF1Y9NKY3PSqpfBKZj9e
         0UoUqSeXWwMMfgCobJEZ55Uwrc8UW7ns5pzW/kb7i4JADTXmaW4W5Ax7EYAG9/KCtiXH
         c+tz4v4g6RLUnNOy9HSuXayj7M3mrEK50oDlbZrbTyxSQybRqdhF01MEAaIgLh/E2TGm
         oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003523; x=1762608323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da/X0BAO6IQgxLa90hj30nT8tKzSWhqU8L60WSbzH/k=;
        b=SaNsY1h4RAiympI+7KF/kERdonLrWxPOt7ytgQQXJMFLFalH3Lf2ZaL+5JHNxnMcT2
         +ZXiXB40T/NjsMjkZulqtv2/Fm11fKLld5q20Xf0e0QeIZO9a3NZ6jc6uyeonrIa602n
         Yt7+hpExRaEyr2l6g8EL087HIeGjLUQRE1346cxtrGoGLiHcdyWtpiRoRNgEcxjrMtX5
         UKU58QVLW58QgjJDXC9ZuZ9E6P8KceZXxpFgRcsM2ZlTPcAuYaDMG9+4h6I2g/5lJ9F4
         2SmxY8PW4mpDOGCD2wtbqoESXtPEj4DEVeBQmhjGMx8a33x81QwXr2VRQZQ8VEj7dFTk
         a17A==
X-Forwarded-Encrypted: i=1; AJvYcCWiS1ci38Dn5OA7FlJZBzt7eO7tt0EQu/2YKXozWIkkTMyi7rdNtzuVJp1WRlTS576jMaKw1mYmoWPVTNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIGK/wcl+nFIkX9EWZIcn0DBMoS8NUIph+l5clUAX6Vjn4gYy
	lCDmY/X52sxyek8Jrmr0RCCB8jnj5vZG5PXGG4NQ7BYjwgPk6aVno3zsKrNhXCvbF+A=
X-Gm-Gg: ASbGncs+7hs5kJ4jnJwJ2O9SRNHRD5oyHrIh30QrR+CbpsqkZfL9WsvmlVg5eqPjJtz
	RdF7pc2u6WaS0L+Y/Ec/Y6FITSrUMfC/crZW36x5aMR5I9WTq2lqY2UNN4+Em7acn2hr8AzRudr
	YViadfXKj4W9HpunMM9CUgME8BaPMb9E9XJcLbAd03JCUxrI3iegsB0LQ0iuJGtFkcsOlBigUA7
	IS1yQ9Kn3/U0/pHs4EweezsfRvsultz/wabZI9SxyUhV07A9pNxluJujzkr49XoW7V6bWz5No8W
	2QNx7GZ0sFdGOZfWcxze5WuwjF1Dk+gBJD8B7Oh3Gg4lrynZgBgow87xG+HfgTg4FzQg1jViwJ5
	BfTiVabBSoFWURttyg81hhV5Qm1hmmB/dwrCeTfMMfyIc2kt0vco2D/4LTuYdjsIaV4KgtiiAHa
	8YBK4EzS/+dKP4TnhW
X-Google-Smtp-Source: AGHT+IH55pTq1fGBGY/yaTd6Zj2Bh1mij01mMvvtUN4wVORgA5e25w597fEIJ18x5AR1pis3PFBXAA==
X-Received: by 2002:a05:6000:2910:b0:428:56ed:c68e with SMTP id ffacd0b85a97d-429b4c3809bmr8835430f8f.9.1762003522937;
        Sat, 01 Nov 2025 06:25:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c55dc6fsm47662015e9.14.2025.11.01.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:25:22 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:25:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: drx39xyj: clean up some sanity checking
Message-ID: <aQYKP330_-4LBa7E@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Delete the duplicate check on "demod->my_ext_attr == NULL" and delete
the unnecessary curly braces.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 428b31e60874..57bd5d53339a 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -11350,12 +11350,7 @@ static int drxj_open(struct drx_demod_instance *demod)
 	    (demod->my_common_attr == NULL) ||
 	    (demod->my_ext_attr == NULL) ||
 	    (demod->my_i2c_dev_addr == NULL) ||
-	    (demod->my_common_attr->is_opened)) {
-		return -EINVAL;
-	}
-
-	/* Check arguments */
-	if (demod->my_ext_attr == NULL)
+	    (demod->my_common_attr->is_opened))
 		return -EINVAL;
 
 	dev_addr = demod->my_i2c_dev_addr;
-- 
2.51.0


