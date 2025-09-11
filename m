Return-Path: <linux-kernel+bounces-812200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562ABB5346C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CCB1C8682B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39733CEA3;
	Thu, 11 Sep 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJurTIBg"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E633CE83
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598630; cv=none; b=H7PTDE1vGStThPCHKzOxIyMmrcWrYLZsUVGAN35dH1+z3i7NGWPztV9E1S0MFRb/5C/KsXMHJkB+CKkVm7SJPJvpKDmbs71/vqGaXsk+do11h+xFAUNdcPtls1btxZH3xWueJFvGxC7IrLLW9o/kMEb22MbV4jwOMInS1nA2sI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598630; c=relaxed/simple;
	bh=IkVF+7F9WyqmG87CnPExaTvcAvbRHkr9Pe/0B1R1Ayc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5Ewf0nuBtW8YmcRf4q2vKJW/KZEM/x22QtZxXLTgonFGaVYRIU6zljtrfOSO8vQH8iZL1CxDqAWzXiump3tSH9OkMOgKIM/l7VsFNw/WjDs6TFcyyV3lGrJptzqKEXziLOxVSh+XxUpDMT8ItRkuxez2h17OVTqmboOxph5no8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CJurTIBg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcac45so5334857b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757598626; x=1758203426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMt0VPE9nsvTEazWH1lgiwsk3x9NY1aluOH28YbXegk=;
        b=CJurTIBg17pcMGNTwpvrMd8BbgdD8ZkQwQKZ4nRT4PAtJW+4bZ+dIS4lpb2i7gx2FY
         oPXV9gK0lFLYB7S+jsLX0Md5i76WRl1N2Zzfyg45+HUllQtxOaYRoyp3kXNkSpfHPn0W
         yCpFxh9tD1v5kEE3kWLrd73q680BywnmRzRFtyupxV4l65D26q/1EFa1lngRDN1knR8N
         F4HsXnCw/6sKZKjgNh5SNTUhcSN8O0c41smMbaPmsyWfvatYSAtnV//hdYrm1OTU8L9P
         KoXosQfDOvRRKcGBLFwdL4B1TX6EgAhqlXR+gB+B4p9mvtptCZjBn9481694/VhUt0Zn
         Ge5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598626; x=1758203426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMt0VPE9nsvTEazWH1lgiwsk3x9NY1aluOH28YbXegk=;
        b=j/f9jyAKlmm5W5uNJayaWGzrlSYY45zHuJJj00dxxriEObwir5gggA0ezUsUi5q0jY
         bm2VbMv6ElRcIzLSY6s1R/5gPciJB3wHWY3EsgH0oWZefibn0J0i2HjhQdvQlzsIY0zy
         VGi4/1pyIhDLUb9gnGZfNcOH0n2E78hJ0vXEiwPoGeSSW4Y/cnUIMomktMAmj2M7TwFE
         wwKPYHudLOykQ4ZwSv7dCaFL0p8BuLnPewBCKW2hWKoKAcbeaFgHVI3j/Xydpd8W8cUf
         B2IC/oTU3P69V4vGK4XLcBsakCQHPgv/dkQWLTZag2RUDUU82wxfB85XegeWk49KJb+3
         WSLA==
X-Gm-Message-State: AOJu0Yxt6WGmuu4Oef8PszIj42vz7I044HITnAr2h8jOz6tgWDH71Cju
	kKqkHvGN8XFYb5BKGPScGWifigzCVdEwT6DNIYUcCPeQtSs5/bNzF52m9wXsHCcjtPnogPnJjpo
	8uk2lzB+Rjg==
X-Gm-Gg: ASbGncsM2k/i/CMQ/F8E+JYmxuDG7h47lTaHP0+640Iz13f5OXwc4Rtn99DkRXtLzMZ
	JypZv2jAiJKZXWJpKpnT7JTeH70CaJSCNsWPg8Bz5ufa50VzF5EzsOWFM8X6ErRy46fGqmzTkxp
	rJYoI9FYAZ/NgpvABg2Ji/RHctYkF3l/XBzEbda2bvYCapGhOrhlvmiL88QKwACMiBymp4MOpnd
	Z2fHtx+9Qfw7jq7iNbHAtoMFV80ld311+i1rWYfIZKaMZN2xYbZ9IItb3wSEG9++YDdddjZW4jW
	40qRpwyl+Uakv37/bKFODHr5yxUADNmSNhBI5ZAtValH55CTdragiqQiOz3WQihYJEZsrlm/cea
	7UAOBY4ObXflzMFuPwi6CJVfRwPgtt37Lm2QJpAOBJyIOTDJdhFLliDEt3kTPWJTUgT8tWE1WRl
	g=
X-Google-Smtp-Source: AGHT+IG0oRMoou++RsxpxUsUtwpzC5AT+90eCVdw6DARCJFWQoizSSi/Z2eS8ssSBxttr2gzHNfb5w==
X-Received: by 2002:a05:690c:7506:b0:72a:6e48:d7a9 with SMTP id 00721157ae682-72a6e49273amr160447507b3.10.1757598625802;
        Thu, 11 Sep 2025 06:50:25 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623434csm3526257b3.11.2025.09.11.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:50:24 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	robin.murphy@arm.com,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v12 2/9] dma-buf: dma-heap: export declared functions
Date: Thu, 11 Sep 2025 15:49:43 +0200
Message-ID: <20250911135007.1275833-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the dma-buf heap functions to allow them to be used by the OP-TEE
driver. The OP-TEE driver wants to register and manage specific secure
DMA heaps with it.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 3cbe87d4a464..8ab49924f8b7 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -11,6 +11,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/list.h>
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
@@ -202,6 +203,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 {
 	return heap->priv;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_get_drvdata, "DMA_BUF_HEAP");
 
 /**
  * dma_heap_get_name - get heap name
@@ -214,6 +216,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 {
 	return heap->name;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
 
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
@@ -303,6 +306,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	kfree(heap);
 	return err_ret;
 }
+EXPORT_SYMBOL_NS_GPL(dma_heap_add, "DMA_BUF_HEAP");
 
 static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
 {
-- 
2.43.0


