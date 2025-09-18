Return-Path: <linux-kernel+bounces-757682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D9B1C555
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B7720600
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304B28BABF;
	Wed,  6 Aug 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwxsbImP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBA28B4FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480779; cv=none; b=l/POOCWpDtxfJkwjBRBmUjhvwR8hmk/i3hMdgN+e38YpLkPwE+o1m7c/9O2Sg8VaEHu8yLz2cwnWauZyopI3tX8uaBqjVEkVyce2CedUeDjwAebZ2JpwCQD/8ky0BvvFkGc7psE0A158E8O8VAnW6hUMsUq3WcyK9WYO0WN8qaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480779; c=relaxed/simple;
	bh=Fxa7WIPYBSoJoS4PyzclqGgPzfyBj56GoeXvqUyHqOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFzrsQ0xmJziYrJoBy1zHHw5sg6vLOfyTO44GeK4iGl2S9OvbpiEdO9BwljlezmaGm9+OOPUlZUmfhMub1h/eMJ5uFXvCJs7Z1WYuHb9gC1HMZon1eyMREIx4nDb+jqLh5Y31TNaPbYhZUA7YSO7a42FDtN21Pu6Bkj8ZORgZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwxsbImP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459d7726ee6so22874975e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754480776; x=1755085576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/knRBN0t/PO4IhYBTGlAeQhM5GVK57F/vQLxJJzqBM=;
        b=CwxsbImPp6WIQGLXn0TBN5aWS1rFGXz0ft2VN9qFLrkdiomrOLnSvqGyXn4BocT8H2
         BUFwB3oGFEsjJ3X6zfGIzhSnWeOt7FkBSZQiIdyOt2wIrdeDPznKL8zf+utah2picdX+
         Sb6vv+h7FFYoevDgGamFvdEc7Z9PPEasS1wHvfDO5s+vIyBsMcDxY1ZW09qEdxCYIXWP
         AgsMwuZeIzX6ATsoPlt7vc3uNzLBgdeoAo/EC9ZP2XpLkv8ou5+wIewTF/5FKbl46r1A
         VdMRCihCR/pU4Fp4p0iwiC0GfOqu65H7nr7ho6+5Ual3wmVTszLg/WVGP3X42KoD8wng
         +ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754480776; x=1755085576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/knRBN0t/PO4IhYBTGlAeQhM5GVK57F/vQLxJJzqBM=;
        b=Jqlglpvqblb40ia1ngwF0QD6pjRF/ak3TpZCIIoMMOZipePwx/cyQKtty59dh6eoZU
         6K9ePqkUKak4yPGlJxJKNqQD1x/qiGOKAqb3bs/D4mFMusceyliCcVS751Kkx291TQW8
         XMaLYlWu++irCK6XP3b0p0EvsuIcQNphghskJRyE6QcOEPISTv0whzhyUloBKlyBgOIE
         OzQWK5Y+9mxuYJGSue5bkP8bvWQ0uTaI2TNpatS6Oqha85XzffOkbObeV1MggIYyKyMu
         gv6Za9qWCifE7pF4EFY5DQyS7eLZhzs9zzWlWjb1tPIYGFUqmPKi2GADPWTlGmYytneC
         8H3g==
X-Forwarded-Encrypted: i=1; AJvYcCUJWLWBr3T0bh+7RCymQwNcy0Iz4yHf0/7yHFgPvVqWUpV//BY4ICmk9olS6jqoc43B7Munk07HPZxpt1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoQ379YR4FqMyjElaQbAfZ+Y/RCZdXOHYRnat37fnQY2oubpn
	KFFi/Nh0gwXt45r/qySEvGRb1q+wmSz8cfkon0vAPFaJq/wRMSHyFTnz1EQa3M8SHBo=
X-Gm-Gg: ASbGncs9z1/KiR/RaD5BeMd3+NmoZWTi9mJ7lRZVztkQG4ASsyZ05DooVuPtlX3imUw
	53bL34il0OoIRf45tVQnUuM8bgQXKcTj6TpJN+T71Fy1flfT6WRe+WDcjPLN90uB4/gAhiWMuV4
	Y4CzH4Z5uLt36arovey/ZVqtFQO4UpxaSra8Sk8xV6fhUQYD8ZptWZNwhXB8gwFfRJGLdvye1Yp
	QgMMlWWbFdMoXc/0ekaiVKLST5DGffMe5bZD13hIotz3aF0hTZ+3WdEuYFS5pMFR5l5sueoDZrG
	I/jguTV4elJYCtbM3L+ELA5Uk2GLkLuFx04QXS7N0t5of8XCDL4sO7xx1tQJvAgmG/fHf6qmQsF
	KuLp7Btw7DM55aC+wRjNiCWt/mfA9elWJZ0OFYw==
X-Google-Smtp-Source: AGHT+IHp4t97LH3g3myvsPF/lVT9OiZdwNWuTbfp/8P8OoiBNQhRDIsU1Ck8258WRDJRYx8siI0mmg==
X-Received: by 2002:a05:600c:474b:b0:459:dde3:1a37 with SMTP id 5b1f17b1804b1-459e7103474mr20600785e9.25.1754480776097;
        Wed, 06 Aug 2025 04:46:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0e70218sm75901695e9.20.2025.08.06.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:46:15 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:46:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Input: sysrq: delete unnecessary check
Message-ID: <aJNAhHtKkhWjosDV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code checks if (write) is true twice in a row.  It's more
readable to delete the first check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/sysrq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 97f8a9a52285..1f78b0db3b25 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1133,8 +1133,7 @@ static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
 	 * Behaves like do_proc_dointvec as t does not have min nor max.
 	 */
 	ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
-
-	if (ret || !write)
+	if (ret)
 		return ret;
 
 	if (write)
-- 
2.47.2


