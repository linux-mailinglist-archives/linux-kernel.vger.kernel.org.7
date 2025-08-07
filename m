Return-Path: <linux-kernel+bounces-759256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F5B1DB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02477A201D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005726B755;
	Thu,  7 Aug 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK9ocNyl"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BDBA36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582107; cv=none; b=U9NaDBLJsabZUPtS1HU4ELAEN/qsbi9GcWCaa1zcNxrV/LgtWxyKMoBsGs3VVuuqHXNtZPtqTor713OmblP9tjMFzCI9jcka6lxuPHOVrPu8AS1eShW+1t0h+I4OMBfZKKre48+26Onn2A8BDTdr0joJc7lC74F5RvxGsLAIBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582107; c=relaxed/simple;
	bh=SQqxK/HCej6ZDpPKgE3mF20MElkN0tQ4FKvSHtMcEcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s4bOXUMQoIuUlatX2OR6ziSei+0zkp9nAVNMeULtk/rzGbEt0UK6sWrgDVV8li0HgGlKKe6f/NifuNk9zmr+lZKjTn4Fi9/UqRTC8RxysNTs6KfFc08pLC9fH6QJLIZuUUj9vNEG8AZWvZdPSI+uKiLiaxj9FHEznHjb5+Nx53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VK9ocNyl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78315ff04so879324f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582104; x=1755186904; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxONtqpEzsy4ybhTdJqv60dbpH7hpRv1LR4+l1PPyfE=;
        b=VK9ocNylvoLr9S9lNJgu38/c0uAQXlbA1LxjW+qSghoeFw5XPtLFKvn28nISMj8OjJ
         HWYXwAdK0mhBgLuLb2/NC2+/A8+/9hfd14ALmHefQJLTjUrocAOKnrnSBJD/98r7PzVg
         4BEwf7emMvMCaTRt9/QUHEaAMHWeU31nSRWarBknfmKDu/fMHMaVroJdMl+HZsgleTbb
         deXq1PVAzb0U7Aow2MdMSy2rnzGc3imL8hzrf1uztzkRxkDqCGppaJfyOzTvmReBYZE+
         Hz0803TfF/05q+JC0h+eZIF+NNT4lSlgQGgh9IL2CjutG5i457Q17zcP69hSMWnHXx71
         DUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582104; x=1755186904;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxONtqpEzsy4ybhTdJqv60dbpH7hpRv1LR4+l1PPyfE=;
        b=mtDxIPmMVgxhb/A7+B+Sggjxpw5Am3jbL1NUXzgkhyjzTgUu1R0Tp5Y0/2lSaMHfC7
         T3j0C5MOBVHm2j4QTEEenhH4s5Dl0PwfceCuXsocCcCAdBeMtBUvCGnZY46/u6PX7qk7
         7apjwDmA7TtcLFtfuePrX4tQuI/uFt3RIO3b6p1GxrMiRGc3whkTqjhqCcyQMoAU7u4l
         1QLgmX8ZPbtmQ+2SqbYvfXABrwa/nUjrc6SRkc7jxBIGNyorvrFdBtj7F83cPGAgyRGT
         IPDUzaqPYln4SIPcySbP9lt6pJRYmToOX88ft32sPptNIoS0pNr1ik6pbYOG4hgzTfuy
         F/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF+EBxqy3bxdU//LKLFaNIypLL5bPISDKMtPyFPqAqwHC5XIW3DtlU5Dep6Rj4ymbfuiIbh5GvbANiZoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEMyI+IEVzPUi5bpg7vf490uFbQQkPHXULFxdJOHxqjuboCWh
	K/1NaBEb3aDbnPoQ2mYEi4Hc/hfsgCMCI2uqGLQ4i4z1ZtsauX+kjZUCF1Nx0tBN8z4=
X-Gm-Gg: ASbGnctkDkecigs1wKwuBhU16I/tytptnjjWKadIZtfwXyirSGNSUfDVzcfo/7mxoBi
	slZjiEEmtwnJZOF2uVYNrKE9sLg7ZIfmcWccEOg64A0N3cyhTZKvU6/pVr6GGUKtQIn6Zl4EhQK
	ElxIlum6iUyexv1gmEt2ynpA7ftLwbM5i8TvI8IgSrcIgdJEkc1xRzTKpnTD6HwwHoUIGXb6SBq
	msl1PsLAqrM4GBbwpyPsWxjE9gzlyQKIZNAXxKyufRVqs1Jz5dRwlDJx1IbUyp1NQFhQrbpCrK2
	eo2zFocywXIzbIiJrcpBb7sEI5ZPRU75U1Sc337HdbgovaKw7vqUtbTL9jkiWMKtgmiyJnQwXJJ
	izVWGwuPhzXzI7dtDsLjfKf9YF0A=
X-Google-Smtp-Source: AGHT+IFSsIoqsVrOVwk5VqvA/2SIH6BZKHjU96VbI5Tfhan7NUjhqokIhx4f7tecjAIif5yQbhliEw==
X-Received: by 2002:a05:6000:25c5:b0:3b8:d22d:a8ad with SMTP id ffacd0b85a97d-3b8f415a367mr7225532f8f.3.1754582104349;
        Thu, 07 Aug 2025 08:55:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458bbf91b69sm124250855e9.3.2025.08.07.08.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:55:03 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:55:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Mosberger-Tang <davidm@egauge.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Stein <alexander.stein@mailbox.org>,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: host: max3421-hcd: Fix error pointer dereference in
 probe cleanup
Message-ID: <aJTMVAPtRe5H6jug@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kthread_run() function returns error pointers so the
max3421_hcd->spi_thread pointer can be either error pointers or NULL.
Check for both before dereferencing it.

Fixes: 05dfa5c9bc37 ("usb: host: max3421-hcd: fix "spi_rd8" uses dynamic stack allocation warning")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/host/max3421-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index dcf31a592f5d..4b5f03f683f7 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1916,7 +1916,7 @@ max3421_probe(struct spi_device *spi)
 	if (hcd) {
 		kfree(max3421_hcd->tx);
 		kfree(max3421_hcd->rx);
-		if (max3421_hcd->spi_thread)
+		if (!IS_ERR_OR_NULL(max3421_hcd->spi_thread))
 			kthread_stop(max3421_hcd->spi_thread);
 		usb_put_hcd(hcd);
 	}
-- 
2.47.2


