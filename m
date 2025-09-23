Return-Path: <linux-kernel+bounces-828839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE0B95984
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FAD3B9F36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC732144A;
	Tue, 23 Sep 2025 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0PqUndd"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D141182B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626088; cv=none; b=uPqqi/Pb2rlRfvoPwFXxr9xpMgxcf3udQ9wRboizcPU2HU0LQV22UYa9HHgzGNEDRcU/VLZ0dcqUpX/4icuGm0Mwbm5omuGFByODFx+y1rF0q4OMxuYVX5brMXqwARFhqlAFMFF345KgSa/vlUJdE1E3jRmDEUDjydmBXR4WXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626088; c=relaxed/simple;
	bh=YptwYi2KhyqTs2MPDUowQsobfWUXyvNShpVbrq//inw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rKTbt/Lw21oy+SGD1/Yj++0Fmgz0DWx5TxKdzEnecT1D7UFe7xJFKvX87lGTJCr1YZWtJEi5KfMqKlVKNL2F57r1O2zLtlSWJWDmZWIAuaN0t/HCIfG1FLF533DVXXYVZDn+n/fnGK2HqDhReEFiHyIF2FCeXfoohqsga9F+D5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0PqUndd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso25695505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626085; x=1759230885; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veRQoXTOP5jOH7336MItrAXBwCoB6ZB/LrxpVKH7RUg=;
        b=o0PqUnddSAS6bInqUUA6bb5FZBQvq8yHaQJuN0nfxLYkcqvfG5vgDd3MA0uKxSo8R8
         9A47geBU6a/EmrK2quEftVqzHyTIr6M8BTSEtzbcsQXrqTzRJi8wbCz6YHMEAoTEl9dr
         nF5lofTZwRwrK9aNRXOoIsJGmF7AL/AIBdI9rRtE/MEvk4i7ZNCt2Wl9itowgfz7q4Dl
         IbDJDm5NLn7P/TAtKi2RSxEgBvHbcjfETZympUEIemBvMnHZfiIORqxPxHQUm2wjSmDT
         V7isVuffOzb+qy28ghGfujLf4pmCPAZZ91mo8VL8NPChgMKry/0wdtDfstToqZqcSKPI
         JYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626085; x=1759230885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veRQoXTOP5jOH7336MItrAXBwCoB6ZB/LrxpVKH7RUg=;
        b=dpIRgWdl1EWDXnWm0WbuWi/YX19PZ301UZ7oLKv/M/l8YutkhA376DIeOEhHWAIw3u
         WDcVLT/JKLWQTjgkymWzudmPQwcqZSP44qmeeCicByL3Rs0qip1MVn1bsTZIClYGmLrQ
         NoedMZHtlK64y/n+1WKUJQfW0BOeksWI9LBRJ7NRyr0RgzobG8EJYymzxCcZ9OED+FuC
         86/CQZ5XxpXmgQhyI3qjKTWE50e6YriDSuIvQ1RshOyDejtXflc4vAxL2F3GnYqrK5M/
         jmCVWF1ioGx9UkVE5Ojy46lPv41bIaY5yjh1Y8jL9Lla2VDTMQzAJBtPyScc9lg4ZnNV
         0Ejg==
X-Forwarded-Encrypted: i=1; AJvYcCXZjwSggu/c03+oQ73gzaOgbgKoKM0evCs/f6kBtslcirQCiQwacYXTCsbaRH5VNwQLx8u9fiJYVv0+2dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdwuqaKcBPOXo60/gv1acjp427gs2V1cnmlIDa819XcGItvbs
	kFoIR5aVA6eJ1HX39a3XErW76MHxhkSpM25E2DV9WwCDB/MSp7ydz4okaxB/Xzl+nQ4=
X-Gm-Gg: ASbGncturSQPr+9fKFhdUrJfDE9cvIrhTFRWwVzJAgI/CKjR9mFsl82r5YI7gUT14dC
	Xb+7WfNl/b+RlEDWV0YtneX8AUkeLDgHU/0PmURtO8VkOvgywj20mzptKDdQXYsOuDtrSdw4wXE
	JpsQsCOMqwX1/s5t2d5rU7mIwAOpB3DY//vMr/+JZ7cwf26ALjESTXzr9+R5a2msTqSQMSpgTqf
	lH7XpcTaSDzMoZYEMvVuXrv9UFZxPdHQSWgM81j91Pn8zMOjGylHhX0AzJ/JihMvLMctgoF85Es
	91LqsQMTIFkQRt1u99BQNeyBD1DnNlX2cigBdKBilYbIj7s9+V4e/cqFueoJCz0Tm9kiN97rqTQ
	3TZ3Dp0IyUkH7HVA5tdtFikcgq7ry
X-Google-Smtp-Source: AGHT+IGNA4ZE/G6xv8PAXiFATMi0x7yx2B6IdUPeinnVHdHE221ujk0cX1DYaOF+khzLyUivuysi8g==
X-Received: by 2002:a05:600c:3145:b0:45d:f804:bcda with SMTP id 5b1f17b1804b1-46e1d9817dbmr22553515e9.13.1758626085008;
        Tue, 23 Sep 2025 04:14:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f5a285efsm270902105e9.18.2025.09.23.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:14:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:14:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Simona Vetter <simona.vetter@ffwll.ch>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dma-buf: fix reference count leak in dma_buf_poll_add_cb()
Message-ID: <aNKBIcpF6kZRG6Mg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call dma_fence_put(fence) if dma_fence_add_callback() fails.

Fixes: 6b51b02a3a0a ("dma-buf: fix and rework dma_buf_poll v7")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From code review, not from testing.  Please review carefully.

 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 2bcf9ceca997..a14e1f50b090 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -301,9 +301,9 @@ static bool dma_buf_poll_add_cb(struct dma_resv *resv, bool write,
 				fence) {
 		dma_fence_get(fence);
 		r = dma_fence_add_callback(fence, &dcb->cb, dma_buf_poll_cb);
+		dma_fence_put(fence);
 		if (!r)
 			return true;
-		dma_fence_put(fence);
 	}
 
 	return false;
-- 
2.51.0


