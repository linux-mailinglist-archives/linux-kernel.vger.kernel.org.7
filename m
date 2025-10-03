Return-Path: <linux-kernel+bounces-841154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048EBB65D2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7164E77DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CB258EE1;
	Fri,  3 Oct 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThsuUTyq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508C1BCA07
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483745; cv=none; b=LAC6E71g2f3Wzo2Hg+X6ylFPc+eqx+a97a4O4mAFiljtKj1bViIdYEs5sz03+lg0/8Za9sLbQr5RyRJVJVGTq+iTYRY97fk+YLRz56wvspQofXn7rksPEpl+as/xrfVG90258lrSyejJdAYlmoa4ZmX6hcsZBrmHWTsXw+AWqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483745; c=relaxed/simple;
	bh=0LYi1Tzz0trPFvikVeM90/GMxvBi45Zl66BGbQgO2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mNGqliPjaJj/Hb09nb4o3dbJTQF3Jp66WzeVoADPuNGi5N6uAjGu1yo7F/Opk536bH3LjMHlv73DCiYjmH4cHdZzAKWN++QNu94SPTqXpP0OCO6De0ZOAltHD5F8aRg7TR2LIWcp/vaDTu3OcSNzR/PVxHLmd2HOHBFrwLaEnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThsuUTyq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so21748525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483742; x=1760088542; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UfvauRxR9/R9JsEk4Hh3KFVn8vp0N3miXsFkXlNhZw=;
        b=ThsuUTyqJG6Pj0olBmi0yJbxEd0llKJ2SPGysAprtwxkMCCEaTP/Mp3Xpo/0uJwEik
         ggzhX9BzvCapTGmM0LIUaxaDH/IFXoYWsYuDqFhiSBWfGwxyKeRmZ12QQlbasz6CLcyO
         3zP6KrJsqs1xRUIp6lG88SSGZ8IfA4m9dZAonW8+b3d0zISEhB+EQCLRugYLODxozzQf
         4jKtSIEUaK3z2RjyVlWB2SzhQkU3PMIKqWkj9nQQvw1s8Caqk1kMdCrzewaaCpYp71gd
         jqNDgD7sm+GMgukkzALJ7BgHxIK1zCXoF3rZR/7aMBt5pgxSsuTkEJk6vuhhn4gpTTzJ
         hCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483742; x=1760088542;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UfvauRxR9/R9JsEk4Hh3KFVn8vp0N3miXsFkXlNhZw=;
        b=bXDfu5Rv8Bvt1yRHC8KOdWFQTK8kYhMcUhZflsaDHbZ+umWQiDXChTe44mdOlY/VsI
         wyZQaNKK3UcPRQ1jh/27vJ56D3UWB/z8LZ8EqhfN6FjVu5QXFAlSRtEOM/DuIJ8Lobaa
         ZoB0jqw1YtdzbStvxtPZredlERejmayYtOE0PJE9tOO4Fnoicc48EZl1GaizCKGmpMCF
         cVevYN2w83F2m/hKECUFW3SyWsz44ZHyx8sFBe+fcf/XkHFR2ZjOQuvEJQ1cIByIvcac
         ql4AOy7C0yN76HjbkwdOq3m/11Z4zsZyWvhWdyj6RzA1RgeNUUJUZQxFnboneNycWuHR
         3TFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3caYVzrQRkEjYZxnGKAyWKjDX0OlBkPtwwx8ogqMDIFJgfXopHSiyCtce7IE2UxADqiGxUzhoNgXlJew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3HqfOHyh+TKHO60xiJMce1YxzJ3X9mQs+4yRBypFhqPYkv0s
	XI7F870rNZ6Y6CVf8rYEIIkrFCSwJVfbGWeMkMzwakEhL7eqUBw9Bc0NeCO7Z2GMYZM=
X-Gm-Gg: ASbGncvVVh4rxj5GrMoYNYyZqv/dZJ/r3Qqm8PwKX5Uo6pTfM3Rc3d/E4YYR7csLZti
	N+VGv7kuj4gK5xMIsqaFscsJ4K0+FBIorsQ2EvyOgNTy9to3HBzwnewEfHd2jUB0dXksdn8qLVI
	Ne7zWonXz2TZUtYgZUtE9hwKHnrk33GOETPn4w+a/vclvCJR6pw6G0E+7az6G7rWqRdVhoNYxyw
	hBmx+l2T3EFLAUQZmp/C0zAuUNR0vmGPW1rgjzl2HtbxAUR/B+lvCLytS5+bfMl9RSyl4112cWm
	cu//MIL9R92gERvapdfr5EGh96/orjiWq4658jVJjLb6dJhEgfI8seLOvaM/S+4Ymv7Y+Aqt4B0
	5FzIvnSC4pp2N8U1r0QdUpOo2DxCGsN1tkUrGE/QsbeOwW/sMKydqRxGRYs7u0BcZuxU=
X-Google-Smtp-Source: AGHT+IG07CTGc2N9qjox6UweqHLmZuOsYcOEWE8Cn9+VAG4IXrRsjLp8yXW0B3vd4VU2Xgs9xnALeA==
X-Received: by 2002:a05:600c:8591:b0:468:9798:2043 with SMTP id 5b1f17b1804b1-46e7114ea2cmr13004675e9.26.1759483742185;
        Fri, 03 Oct 2025 02:29:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f0170sm7212685f8f.49.2025.10.03.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:29:01 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:28:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Chong Qiao <qiaochong@loongson.cn>, Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
Message-ID: <cover.1759478975.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are two issues which were detected by Smatch.  They're not really
going to happen in real life.  Small kmalloc()s can't fail.
The devm_mfd_add_devices() function isn't going to fail either...

But still, they're worth fixing just for correctness sake.

Dan Carpenter (2):
  mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
  mfd: ls2kbmc: check for devm_mfd_add_devices() failure

 drivers/mfd/ls2k-bmc-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.51.0


