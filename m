Return-Path: <linux-kernel+bounces-828910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F54B95D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD92B1897661
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B8322DD2;
	Tue, 23 Sep 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPSCy4mV"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFA322DA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629997; cv=none; b=uWhvEI/CHqd/+CdY+kh/sD81QOlllRpxAdIb3j9XpL1UtnJ4Jh+Jb/o12toDFgZ3yGxda1fInNeocIpcH287FR+wC8nO1s1KUkSzmEnWwnaiSJ46XGraK3+TLgqFSyTlBnXt0tPsXGmac1oc+/OF/pALBe3BtDBYqfcgaOEU4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629997; c=relaxed/simple;
	bh=DL5/MM4QMDxu+y6pVcFung9FsS2xYx7OXCyD3ag7/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQngG7eNU8cA8x9DYOqXOxkWOMEd8OD/+cQL4RuGGvCpCzXVD1dwD0vswj/CVowTif/H9xSdIbiYMO3d1mIZRmDp2kI3P/5x1mGCro83o77lEfrshxbe1NtjMns6Ik1sP48P2tlYqlnIbxixRhoDmbzXIUOVNCNzQp8MnnUCc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPSCy4mV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so5190592f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758629994; x=1759234794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sTK3npgW5FQLE4nPFWDBCNYEm3feIUUETDGkLbnmceI=;
        b=qPSCy4mVgUrc5XMvGxFAdeywp3Mz5TFMNGeFc7j4ZKOdxpukJteJ1AFNLQDgg6EUqZ
         Q0E+bWNit9SItr1nKM2vPruTJioq4OJL2XqxiCpDekrkxekEwZUzVi+FjLVErCRCNyoC
         d39zdLBFfJhskeZC6zMiDIrSbZ5dpDD8w+1LM8qG1fX2BPcskeua2FnRUuXnAsAt+itQ
         hAu1atZLae5GuViBhoGd5YeXgRmbGA8Txfx0M5sMr+2r0TQwE4ylMRfSDFYrA0minkq0
         GdmJYacqdVuFspp8EakkZRTyMbVOYXvni3yZdJ8+eU54lFW5xgWy+gsSXN5wmAtYKiSu
         3Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629994; x=1759234794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTK3npgW5FQLE4nPFWDBCNYEm3feIUUETDGkLbnmceI=;
        b=uvAIopKl4t9q8eWXASHEqCMtmRJju6+Ok42kV1dvf22kJM/zKpUPCvNVNlI0u7ISIf
         zzfu2xBpay9UcyQArAGcA1CzChZOdVxe75oL+F5pY7AugE5MQshYQIpsbnlPV+l7wHUM
         zwuQpOm1r/zZAxFf+lx5HxuGDHgf8pV9XJRHwCzgHOtzfK7uFt3P1U36YAwpkpC3+SCC
         6/vVJWnUterjt2vvvGdBAPVu9pM1TY6CZFn0LWpFpTfzxfssYX3kY3vhrJyIgGVr35Rw
         S2Z0ATTyBuANjYQKuaWwORH5QWK4Ta28xhzrrN5slHaLxiY4YxgmSEWjalGyTl4IQpyI
         jnqg==
X-Forwarded-Encrypted: i=1; AJvYcCWEZe4vOWvMXtJxzrKvylETRrWdEFlYFlUt2c9aJoCeibG3byHhGJQrkr3/GcK5ANSZHN4xGAhx3JZyZnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCh+CVnyM8wGeFfnMD/4KQl7bPp+ppa6w49Ng1clqvYWyJep19
	J3tmTcAhAtA1NqFHNR2i6w5uPlEb+HuDHpcdtk6w0ecWzF0ukONiX1zEiRUxzG5XY4s=
X-Gm-Gg: ASbGnct0aGMEGgbqvCOZYZY/a3O/Htq7BwK8/NFpWCcdwgBkftzjOj5feOE5JaSuUvU
	jxOXfx8ilufYcY57kbRomTzVx0qSuAvcFh3B5ARDI9uf7DA1c6ohOVNyXTPBVFQlzheCriHyxI3
	PTB+Afc9Xl5dumPwUYJXG3mHlclEYcA8lFJEVz0/FzO89KX+XXjNaZI6bdEysT9T+oy870+UiOI
	o91lIFomcxoznLkboT6AvpS+7PGM+8z1UfsY1rlnQM1HBTQc/8WXqImxUM/yfosshwnqft7wTY5
	Hps0EH5Hndp6GwLW6L/AumJp6z9sOfpoY0Vv3IB+eYG+FWs6FE9sOsa3+KwLtRbYkExdGvsbt/T
	D3gzI6gWie2sfzP9XAh6Zok5y+pVN
X-Google-Smtp-Source: AGHT+IHzh4QmoPQ01FP6OX2MtxPxTNk8wndU9qAYqgeeBa3Ms/9nlpcl+WJEjK2427UHhz9Vf1Arow==
X-Received: by 2002:a5d:5f49:0:b0:3ea:80ec:854c with SMTP id ffacd0b85a97d-405c5ccc9fcmr1639265f8f.19.1758629994203;
        Tue, 23 Sep 2025 05:19:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f61703b206sm13621550f8f.6.2025.09.23.05.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:19:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:19:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Simona Vetter <simona.vetter@ffwll.ch>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dma-buf: fix reference count leak in
 dma_buf_poll_add_cb()
Message-ID: <aNKQZqWwWu_8WesG@stanley.mountain>
References: <aNKBIcpF6kZRG6Mg@stanley.mountain>
 <7bb48401-ed99-4263-addd-ec1462d68168@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bb48401-ed99-4263-addd-ec1462d68168@amd.com>

On Tue, Sep 23, 2025 at 02:00:28PM +0200, Christian König wrote:
> On 23.09.25 13:14, Dan Carpenter wrote:
> > Call dma_fence_put(fence) if dma_fence_add_callback() fails.
> 
> Well that change is obviously incorrect.
>
> When dma_fence_add_callback() fails we already call dma_fence_put() and drop the reference.
> 
> When the dma_fence_add_callback() call succeeds the callback will drop the reference.
> 
> The problem here is that the return code of dma_fence_add_callback() is an integer error code instead of a bool and basically has the reverse meaning than what people usually expect.
> 

Ah, yes.  You're exactly correct of course.  Sorry about that.

regards,
dan carpenter


