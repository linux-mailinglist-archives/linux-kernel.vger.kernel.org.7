Return-Path: <linux-kernel+bounces-759254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C454B1DB14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58175585455
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44926A0A6;
	Thu,  7 Aug 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0XYCQY8"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51C25DAEA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582029; cv=none; b=kN5QH4PEkPPKFAsFn+CVlbVlCQ0JLBoXMmkG5J8WL76N68o0PBCzjIaOr+FxMkDzdss6fvZLtc1sx8IoS4JcupPq7tpia/mGKS5W+qUTUUv0YOh7WpqR3FM6tlIumsFSvCAJpeuiK87HFV47E5JZyBgF8MtI0HLdRRlFA+w5yz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582029; c=relaxed/simple;
	bh=zsJFJgwKZVKu0gVQGRYuwIOMgrMMGHGdooipnK6TecU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=retVxl07JyRIusbBwapnTIEZBVF0s2/xchry9wux7dY05t14dOQhbItzQjgU/D3S/UJpYkg9QZ05I87w8OR+pBaiyiMofL/jjPPmnwp8rq/vKmpM/VbDTI+7HM1CDnC0W2sSL++5Uxx6t08uUeJANwUTsErnLAzHxPINjA5lqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0XYCQY8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b788feab29so700596f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754582025; x=1755186825; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOwl9OLQJAYVxduC2ayJxb7hSYBFSiSP9YcfR3LlKkM=;
        b=P0XYCQY8cCqFyG56Z5hVawmnwSxJbUkRmjNE+btq5ANzWnifnO5UeyOoA5BvgB6Siw
         0UEMzM5mbs2uKH5ria3yl+br6Vu6Zygb0994VbLm6RQJiZS94hNq5P/LTluVvL18250K
         rT+ITwQs55opqo2ik+xTZ3DjN+3BgR7omY2HyXLKR+XlTYHazDk1Jni7bglLvz50g789
         FUIGdo+routUXeZXJJPBmFzt4OW9mJPoT9+sO1tSLZc6bM1SSiDOkKXHSxVaWSNFARGB
         nrNxE628tdVjwSOeK3yuZAJ2qM3gRdMNfInR/xwefDlxW1uOBLpOoTxaTeppzf0XTBk6
         eS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582025; x=1755186825;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOwl9OLQJAYVxduC2ayJxb7hSYBFSiSP9YcfR3LlKkM=;
        b=T5QYa3Sbpv48gg5naeEtFlyConZTD7P/i3XTQRW8yhk3M8z0l9HgbFAacqvq2HpSx0
         W8k3ixXZAd6ywrVhqfifzgTuFM7ZoYHDuVhI5+uYwDaxXnt7vE0P3j4BVM7+u8TuDuxH
         zj1HgoAdr+PwClZLLt7ZktDyL0VRstM3+OA+lhGfuKSixNPqWoxvY80GvwGhmEm89gP9
         Fuw/IP9MSSgQ14sw9d3I90+F/Pc43TSjlKL/yc9d4CGLxNBV+rjpnytpUb4b/oTeB1jh
         fVF1NSwe6jQbGD1NLgdjFgDYJE+W+Q69BsqYc8kUv5J2WaUv+BrX4f2qk6S7gtVLfHmh
         AWgw==
X-Forwarded-Encrypted: i=1; AJvYcCVf2srvIFGyXD5B2kVxj0yDwyCklVxz02uMkRuP88F7QbM6ztvCBWrXHuuKSl1N/hSkaCxZ5BmVxhc7MqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+/u7k5lLzbtySvGJdHjLv91Y1dX637DR+7GgNQBXERzONKmf
	vwHyUS0CnHKqojNRwn84hvQsUsHqnRpvn1QVAe/UAvbD/XM2+63sr0/dq21LEqcpIrU=
X-Gm-Gg: ASbGncswFWpxN3D8waMhlbKNWl3Xu/9wL5XvO5BDWJVeOvfZluEUUJo1jzF6jMm/Qtt
	+NOQnT6tQaPvahn0a2Ge7nh+Ei0bSNHWJDpZzFCDIawO8Lyw8lvl7IC6gkTqkMQkW13fhWHTs2r
	e2J04noznOr5VF40AxXhwKw+WmD8OYDBJVZew2HGexo6Pgd2+PRyiA/JRkMTIXsCUlY/8UTyNfU
	pJTNt6v8g07UX9Vmml2iv++eG/b4lXh8qdR3u0tidIuNAfpBpBZoYGKhbiDR1Bi3nlgvOPImduM
	C0GAZBK05gSld8PYDPEogo60p6lEieHmeo3J5/y9epDWHNXvNBkNJ9UYbXylfBmXsSAuAIfzQHR
	NPhcnIoxpqANG3BEaxavfLZhq+gJyhOnUwvrE+w==
X-Google-Smtp-Source: AGHT+IEuAgZgwkFD7Z8Xqqn2h/YYU+isAy36WnGYO+M9a5Hc0G0oFkUuedFLpME4SUzRmU7sRh6FqA==
X-Received: by 2002:a05:6000:2204:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b8f41980femr6076763f8f.21.1754582025300;
        Thu, 07 Aug 2025 08:53:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dc7e1ddesm176487365e9.27.2025.08.07.08.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:53:44 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:53:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe: Fix a NULL vs IS_ERR() in
 xe_vm_add_compute_exec_queue()
Message-ID: <aJTMBdX97cof_009@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The xe_preempt_fence_create() function returns error pointers.  It
never returns NULL.  Update the error checking to match.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/xe_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 432ea325677d..5c58c6d99dce 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -240,8 +240,8 @@ int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
 
 	pfence = xe_preempt_fence_create(q, q->lr.context,
 					 ++q->lr.seqno);
-	if (!pfence) {
-		err = -ENOMEM;
+	if (IS_ERR(pfence)) {
+		err = PTR_ERR(pfence);
 		goto out_fini;
 	}
 
-- 
2.47.2


