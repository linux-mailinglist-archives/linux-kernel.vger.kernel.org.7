Return-Path: <linux-kernel+bounces-822452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E9B83E97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F3E4A6A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AEB2EB862;
	Thu, 18 Sep 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2jk1CNL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722642E2EFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189048; cv=none; b=lOJQKt4xJH2jQ9oifkO/s4qJDKVxR1mhAql0fH3awQD9WYQAl4K0BaWEyPBeNRXTnWxWZJbBmK5ZobLF08eLfZ0TXvGxQGCvPg3APpoq2yp1G7ITpUoTXwrO+43rsT/rqpO7i9FayUWq1DMcB/sfOL7aJXiJMA+GNEiW5iGLvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189048; c=relaxed/simple;
	bh=E11JmRyH7JUTZes1+yw1WAAGyPZ3TxFZUkiSIuE1MFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JVxQ78hU3AHcWf6488CO7XXhGV/MFR+BeUXpSCX9ZxhjrDzwnMlMoRH2KByXsxwsxkQ+95e2Ko3lPdFUwIhfnl4QqTK2Sj2Ou3+zUGn6NtdDr1N+Sto5JU3D/NGOWY2HArTL7Nqh09sPI1YcUsFwfTfg496UUDeaHoTkkVfk3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2jk1CNL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso467963f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189045; x=1758793845; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/T2Fr2QIkCHSSj1+Ut/Hdbp7X7o/yIWkxiXRdzpcpk=;
        b=m2jk1CNL7QnqDVcFP0J3CkbRBO0VtJeqhAwO4JAfVIt4iWrNh6RdWqPVaIVCc9Uoec
         gXofYCONp2hyw4qbguwkELRdpTWR4sHKo9A2qRWL8cfPwqh3u7/yN+c0OQDabbePITqo
         iY7yR9ab7vk2K6ohOdtaafOpsdlbll7CX2jgELowQrYyojISRFG9Gzsw1wpydCJKyoah
         bs98BYTjb2RGB3kC7hZI2Q5wgvUxcMkXuDeqNsFYX5mkUWT2Xh19V+zsC4rqk8RaGRux
         f4McG3R/QIgR/R3snkGkJAPjHsF/ZQ8LWbregbZ+rJP1Tbuk01dWcLh0GZi9W/rd7EUt
         A1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189045; x=1758793845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/T2Fr2QIkCHSSj1+Ut/Hdbp7X7o/yIWkxiXRdzpcpk=;
        b=LRV3FsTDNrW8Pu0jYq6H7sReaHQ73XtH9s5kx9z163AYR2cmCIcX/jJShn+yTRj6IV
         Bbl+4jG20EYRLmivBbQSfQIomum/0393lEzX947qRxRY1cMq0EGuStXfkqkWRAXoz6+q
         /q/K9bU8QPIkRrBq3biOEK9/aZhYTr7mGIb/4VXVfypB3xY/leWqbgVhLKLlIXTJTmG6
         7o72z1O/Ord5Ot/AUofEznqZDIXQcFtPCgWhu0BswNd0hwDEQIxNf7LoKtcJT1YuC7Dm
         Qn8WNHEnEYhmaBnzDc3Q7DCcHpRQ5c/wkctERjmjP4EQXem8qe9S9tcCHx6jIR9pigv7
         YZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVk39kcV7TzN3N7VMFHYCxGoNI+znwr21BBP11YasLniBlWmIm+mjcaxltVpucXV3MyD7zuquIpCWoVIhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp/Ts7oAaKhYjJCogm4ZXMQdbt5IVtamWmDV6qPkyrPDq5hmf
	PkSglTvFQ5B/1lrRNneCQOS3+juYIm7fhdN/Di6lTtIKqzUXqaf24fuHAO46ZDepVbw=
X-Gm-Gg: ASbGnctqcNMnJce+X9fEX/DpR27pqLjNueH9kLF7NXMX4B50YboPEufsQ7HmOHvTiW3
	5yLrnzvlZOXIEcHrje7LitTJ6JXOmntSV9i43iVUoky2tNyMFT1v+8R4Na3ouHHRB6wtKHxzu/D
	Hb/e8ZKKFrCeKMmgFjF949ZrAFBUw9zguoSfp2+Gx/H8mds5m+WZeYaBO35hxx6KInjUAphM2SP
	JoQu4Mv6r5KSa1berx/R8zuKzfVpk4xp/pHNpDt53W53lS3udt+2fxR+tiRDRqloszQGDMSQfKt
	fM9n/ZLT+JB29kM9js13z8J+r57P097mHERTvaRGNuYb2NAbPUXBSTScLoSabGizMguP57qd0yF
	tR2X7Z2FKzJkfTW08xMLGNHsJs2eRFsHAfdhHaFAMIx91QQ==
X-Google-Smtp-Source: AGHT+IF/P3JGmGE10PIfdHqwzm4/ifWKYQ/MXC5mVGrGtyVgrjAOWjLFRwF4sj8gaNTy6XhjFE43Bw==
X-Received: by 2002:a05:6000:144c:b0:3ee:1233:4673 with SMTP id ffacd0b85a97d-3ee12334885mr1189394f8f.16.1758189044856;
        Thu, 18 Sep 2025 02:50:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f5a286edsm37363195e9.16.2025.09.18.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:50:44 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:50:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] tee: qcom: return -EFAULT instead of -EINVAL if
 copy_from_user() fails
Message-ID: <aMvV8WIKnqLN3w6R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If copy_from_user() fails, the correct error code is -EFAULT, not
-EINVAL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/qcomtee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 783acc59cfa9..b6715ada7700 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -424,7 +424,7 @@ static int qcomtee_prepare_msg(struct qcomtee_object_invoke_ctx *oic,
 		if (!(u[i].flags & QCOMTEE_ARG_FLAGS_UADDR))
 			memcpy(msgptr, u[i].b.addr, u[i].b.size);
 		else if (copy_from_user(msgptr, u[i].b.uaddr, u[i].b.size))
-			return -EINVAL;
+			return -EFAULT;
 
 		offset += qcomtee_msg_offset_align(u[i].b.size);
 		ib++;
-- 
2.51.0


