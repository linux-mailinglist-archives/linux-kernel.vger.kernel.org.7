Return-Path: <linux-kernel+bounces-833590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBDBA25CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969241C02278
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CB26FA5E;
	Fri, 26 Sep 2025 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uohg4VZy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD126E6FB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859416; cv=none; b=nKJ4WAok5DrgwYWp5mDVjzhfiniPggMl0lYeehZ6CalET45JPxAmT9/XfdIPDPgVXrpjwkXq3bItACPI/UPFEAOn56AqMy3vctjHdlHXkMlIi1sjBwHkri++Qnbxw3dTYbMNMc5svMGEyQzW0dGs+w1pjKu4LtNvyOqyGukk9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859416; c=relaxed/simple;
	bh=aDhxeCkC8fJ1lKK66xBz3OEbwpp7thZqdmHZS7jPnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4vvu8a4bace6LMMaEyV7+NqQJUViEZ+D9AOZe6JY/xIvssTiouyZoBu7dkztNG/0TiDJN4yaQisfqGIoSTvo/G2+w8bYXvp+3ChqBvMM21Cku6gF+8FILaBCYFyJ3qvnsBHBBwy3t5JjlW4DVcSYctxbXbzaZ42CYsj9+dalVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uohg4VZy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso1686260f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758859413; x=1759464213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAvxUIgiwZnoN4z0j99g7O5RjAHri0iT1cfvlyji2fc=;
        b=Uohg4VZySZa6WsDVV2omhDyY2sq4dHlJjpLPnFR0WZ/ZlCPIENZRYFszx7GJUsqNkH
         0J0Tf3Gv0brDRb8yogpe+WMhJ8tQ8gOCju5mMKuUgN1mAsq7U39It+1dWlZqqTtkT/Bj
         HRoQVstJHkZGIg3ddBmylNEx+fcgxhJQsIiyKZlhoRFNOc2M1u9u4zQMlUrILkOoX0Mu
         eV/KnAi9c+ijq3cvvwWoy0dBOWfxcOQ+hqaaP0m4Z0b3+Nv9hJPzaoRcbX+G7/cxDciz
         7Z2tjZ+6PFPeG2z7SimYbgAssrzbQUFgTJdqWLqbcu9E2YAOVYLm/O8FmukqRl+B/u51
         zC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859413; x=1759464213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAvxUIgiwZnoN4z0j99g7O5RjAHri0iT1cfvlyji2fc=;
        b=HmtlNRdji1FQrzuvcBdagPGNOmUORPMejSCml9+DqRN+twoUIurrPT9aD4JcMDkHzN
         uOuAUplKfnH2CYXtMiT+oVoP9mjNaOXp8DrOnptlc/gR1PoCosDZzqbffYgmMhuv1qi/
         50l1IrzLFM71Wdt2vLqBGm6R8JXta8JVHfHIIAX1XSiCtm1DBkwH2q9ikF9STN7+XLlT
         5eb5M4O8KpYwX7EPxVhulfJ0lgwBlavUc7blDsbtVwfXU5u3kaMP+SHzQOWjZVyOLVf4
         BOBbG9alx4d6GFER27JklEqd0MI9r5EUykTrb/rJp3aMfyer8fDoElBh+LD9R5gmDG3V
         ooXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXajiFBlk1ipA5hdFVNYQgLroQpsVX9gHc1EuL7D0IH2xVRg/2hZ86BulWxekiRfvka3NqXmCaCzF2gj6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEr9jcLlQG3IvMCJThw9DuNe89xOg6lEsPbwIPUU/taJIWE9XG
	JcWeKZSeDLX8drYu5P3Ft5BuCuad/kjn2+whsM4tdih2MZ7ihxKKo7mesZYX4zMUWzhcbR5g9xf
	XK1N7
X-Gm-Gg: ASbGncvz+tKlnvBW+XV6uByxJw7D1hP4B0o7BXLC8xcfWo15CAQ8vjJFn1GdaQkVNnh
	T7C4PaAIuMwQeXqdbHklROj/1JG+gfBuMlULr1s+tc9A5VToG5O0PC1oyrDfikv7oTGF5GviShq
	o7ZM/GLLR/Oc+/wUbg1Dpl2IdEJl+DgkrNxOFOLnK6l+wxqPuvBHJRflDX6PNEgLBw4aAEXCg00
	wGq/9+/sSuZZEulpD/bQCaFPTfbCjTDoUGJquhfWP/3SXUVJoI57pv5ZV3LdmUcjS3wgVmEHXrt
	8bvNNJQrJ6aDjvnY0xO0Oux2W+u/7Vo0Ms0Zs5xz7gUgPDz144W34tUf+ZhoOzRS7VHU4XxuF9a
	1/aKzlWHBkNb2CY1PjtZQuDzaisHS8nc9XIMfbBqjwSdOc8+ipA==
X-Google-Smtp-Source: AGHT+IG5qSGA+zLmaSVai6Z0wqDL5M4a9N7yHXLm/VuFTKV5wrkMZ8mE7n7IYfhWmV2EMBcPnVktpQ==
X-Received: by 2002:adf:9bce:0:b0:411:3c14:3aac with SMTP id ffacd0b85a97d-4113c1440f0mr2029219f8f.7.1758859412949;
        Thu, 25 Sep 2025 21:03:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33bf70b5sm56361345e9.21.2025.09.25.21.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 21:03:32 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:03:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pmdomain: thead: Fix error pointer vs NULL bug in
 th1520_pd_reboot_init()
Message-ID: <aNYQkVuVpP3Daq7x@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_auxiliary_device_create() returns NULL on error.  It never
returns error pointers.  Using PTR_ERR_OR_ZERO() here means the function
always returns success.  Replace the PTR_ERR_OR_ZERO() call check with
a NULL check.

Fixes: 64581f41f4c4 ("pmdomain: thead: create auxiliary device for rebooting")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pmdomain/thead/th1520-pm-domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index 5213994101a5..d7cb9633c7c8 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -179,8 +179,10 @@ static int th1520_pd_reboot_init(struct device *dev,
 	struct auxiliary_device *adev;
 
 	adev = devm_auxiliary_device_create(dev, "reboot", aon_chan);
+	if (!adev)
+		return -ENODEV;
 
-	return PTR_ERR_OR_ZERO(adev);
+	return 0;
 }
 
 static int th1520_pd_probe(struct platform_device *pdev)
-- 
2.51.0


