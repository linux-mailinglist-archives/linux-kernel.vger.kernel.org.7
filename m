Return-Path: <linux-kernel+bounces-732619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A898DB0699A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52204E3303
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCB2D0C9E;
	Tue, 15 Jul 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/5Ienai"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E64A3C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620436; cv=none; b=qDb01gpvt52Sm9GdQjFlmKgFU3YA2xaMqrfSLT0m7FSOOBdfulfq6DpX14T6SsknhXFxPtWouTNPXZYZKyianFpSJo1AYfOOXxjk90M0kOS20wctNTh1vwvcQR6QLH/WV8Ini1v87XGbu65Lp0TH0iKRRTvtrX/Uocet1tuWnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620436; c=relaxed/simple;
	bh=Rd4EWRAxme2/2cezG0hoAVJmvXZzbOjy+A5VWaeSXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lMJ2CmViJRwNOpOJp4K+/RwxIj5b2VnzrUb6PAiOp7B7pnCPe0dSnVW64RZUoC54LzkEUj0JxFO+vFNw2AehhHIg0mRyCz2bYtU9+XzHCnu4shIKnvGNzrZpMUPI9HHs5r6tF7lhh1JjJQOM+e7SYI4SJhMaLOsfsG8aMr5iWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/5Ienai; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73cddf31d10so2769059a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620434; x=1753225234; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEHhLS9AKp6YfP0nzrVbW2+c1LEO3R60cxZmePqCOIU=;
        b=o/5IenaiA5OeF+X5gz/fXfbclYGCQGk6ZFrD2nW1ZzbKqUhBpSEqIn346duWuGbbDN
         WuOjqlimo9mKudMks234yt8xEcC6kg2P5NLzuLLBM6TBJ2uAPGJ9zh2mdwuVQxKXYzVE
         BBYpXBIs/495qdLElGPn/AY7CDLsOzWz0WCujZjSYuvnAkLYuiv4GhqOv/cVC2XmxVy3
         BdtCd1xR+N7LhUCsT0kOTwoU1DSj4JSFhgU97LYkskV2Pg4/BJbZwuzUiqPUfizFjv4d
         yro3bOPBb07jFF0Jrv4qN3KxKEf4MfycQfj34L97Li8IVGG5dG+XRBdfPx2g4cFqn/tJ
         WU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620434; x=1753225234;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEHhLS9AKp6YfP0nzrVbW2+c1LEO3R60cxZmePqCOIU=;
        b=GuUGMVqeRh7C7uRkkkaNYrJT1fMddn5Ykye9aew4ZRgvwoffPyKtu+FpmxMVM++grJ
         XbhheuZnf2GUQC97kmlpSjW+f1LgrYmxxThXzdXFQFcJMf0+U6dN6X3B8e73WcIbn1uJ
         f86qzYz2ko9CK/IAwP+F1YbY2v6RhdyoFfPVKwSUBvquo+QMcgWzzrDxDoV3aelgODFc
         bh7VggBlKID03el8SPeRUKxI7B7SB4GzXaxnm4+lSXuNh1UH3R2lvREQdg43Vhtz60tz
         uYR9m/QsJVPh4zMC7kJWIXZfTZKFVIzWHOEXCxqpuEjwnz6XBza30tzk+SNXhTHay+Xc
         LSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaSpkyAG7GVK7q7B3WX/5R02PSzYNgMw/AY7+9ber1sCZB0vG5ZU5fNNhWICuN9AIVdE4vdKvcXx1dPQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/puPyzamwllAZcsOOxXjgKzMlNkcK9DjLgC7c5N5rpUspztt
	Hp9IfWq1e5tFwjRojDT+cLoSFCmTS3UqYLSSqHpHMswaSouNM8ql6yxdriXcS12Om18=
X-Gm-Gg: ASbGnctQW0Xthj7Ce30+hj3m6pf2x7wLpF8nnnMfIUzMaGFerbWfFpPQwGoyIisXYKJ
	+pTV+/BTP8YzotTe04SRl1cP6EsyYVNZrvfWviSoy0/PbxkY/P4fRb5XPCLqji6khKZYwbxsZx2
	qzoVfPkhIdlC/jIzZ2p86o2B7DrdvddU/lr2+5Tla3l6GCkzv15g0PwoyqEsvPfoaNGdF42nwFW
	4Df2p61ZrFFWsfxGu8xaX2ycInghg89jpkEywl7pG244ad0Vp9zUr6wk/zvuey3LYx1Lh6Tilq9
	d4uwuz0Rr8hqxkqFXlgTRx+poSOJLCjeYOjUq0oDsu/Y+y9M1Bied+rVhpmmYx3cIdMrOz4sgGk
	l4odcfQIqCph5R6O5wNBbbs1yMylx
X-Google-Smtp-Source: AGHT+IHnn0iv6gW7AenbYfNa71UIVVvLtMsOtgKfhXxzBG8x/zCO8jdFx2PwxnbWY+hgyLCzOiwGHA==
X-Received: by 2002:a05:6830:7204:b0:739:f13a:6f41 with SMTP id 46e09a7af769-73e662c791dmr301764a34.25.1752620434508;
        Tue, 15 Jul 2025 16:00:34 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e44f2fb4dsm1348594a34.49.2025.07.15.16.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:00:33 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:00:32 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] media: stk1160: Restore deleted comment in stk1160_fill_urb()
Message-ID: <fdab5e2d-47b6-4551-8aa8-3e90b2207a75@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This comment explains why we return success when usb_alloc_noncoherent()
fails and I think it's helpful.  It was deleted during a recent refactor,
but let's add it back.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/usb/stk1160/stk1160-video.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 416cb74377eb..3e6bffd49346 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -408,8 +408,13 @@ static int stk1160_fill_urb(struct stk1160 *dev, struct stk1160_urb *stk_urb,
 	stk_urb->transfer_buffer = usb_alloc_noncoherent(dev->udev, sb_size,
 							 GFP_KERNEL, &stk_urb->dma,
 							 DMA_FROM_DEVICE, &stk_urb->sgt);
-	if (!stk_urb->transfer_buffer)
+	if (!stk_urb->transfer_buffer) {
+		/*
+		 * If the buffer allocation failed, we exit but return 0 since
+		 * we allow the driver working with less buffers.
+		 */
 		goto free_urb;
+	}
 
 	stk_urb->dev = dev;
 	return 0;
-- 
2.47.2


