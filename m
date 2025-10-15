Return-Path: <linux-kernel+bounces-854441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1FBDE62B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0A0480E27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD37326D49;
	Wed, 15 Oct 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="gbHinxms"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71026221FCB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529849; cv=none; b=bY4U85qjFFVNoJORXQtdfvEtQJaSEFnacDkx69jmC/P6+hJqWE7j2Mg/GcM0+gb33OJfLbClD+5mS2pAPBc9M8/bWMEt72sfzr0yuFt4gAQIfghrIEpBm4wsGGOFX20BwmrjPI6OnFsyRXGa+UhoDpa86uokRpFU6jafSHwK6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529849; c=relaxed/simple;
	bh=cYYrig6PV1TMFUpvdrC38s6x3cKU7TXE8XEtRmDi518=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcQ6oyv/4ZyueFlSxaEf2mfHTGsK0UO1ho/IM/4C7V7D5U3G27FEscTB1PoonoQwF1vOoeyRX50kq+DFOOoroWSvGOgBMfNO+zokWcnHD/+BsP5ptJ3jG0ppAJqN0gJ94X5dmk8F0q2L0tf3f9M3YMaxxIcz4aS8KawEC/PE/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=gbHinxms; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-856701dc22aso931010085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1760529845; x=1761134645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
        b=gbHinxms3waUS1kvo/4o42nFi5wR5zATAEeFcTdXakPaO2JmB3AEw04uJ7vkNJcEPa
         sU+kXRoxb8GKeD4muJSOKxC5VPywpgosH0tjG0Ayy3I8ehYimALfavjCaVh/IMmNLgUG
         J880YDrd8s8Xt8yFm93mOQ99BtA3EFoOyz6CQkMRARWDnnJ7oSQ5Hunodj6UVuXfyY9p
         g4+viF4NKNsqdxnmWI1sG539HetY1GY28q864trXmjWyrG3VJyIO8xDvBtGbIVYf9Le5
         yYLLbKf2O/yTXzFHoBlT25kKCdHSTDGouLNz05teZHKCrmyzi1T5VAf9+AIEAqg2GhHS
         w9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529845; x=1761134645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
        b=Yn/Ndfje370TOeVtsKuc+Y+o1A1Fdqsf6q7pE36PQnPxXeAJY8caWPjahuUKKJ2LdD
         FcaJ7fgRKK+Xab7swNIRN0IToctYDxxMxVqctt4Nu6M0xIDGi9URPo/bXjRAG9lFALh9
         RUa7e3Wpt/16NaBWuBK1iUcmnCoj/ag2f8x7+/AK+ktj+2gzosZ0mepqS+XW3yshiS1d
         NHNgeIMVVsWJuaAApNm9WxWhOvwXf4JoPH08pvs5hmuOpO5/ypTmJcG2TYK7ojBCKixQ
         paVF34mlIcMYnwOUCgDxx9tFJqU1cPvstlbYi0s23q9ewYpa8oPUJJPQA+LEMc+lhXH6
         lRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlMyWwIOg3oLDTJFSCwTF4rkiSV1mlwVE7sKcHQPt7KXhDPkaeAWi0jrJ44Rb7fYeuTa20bB1GxJk7X20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKadb+vxRdu04vHPrZZsIqiWlGuZoNp7HzIG2vodOw7uoOzfg1
	Q7quFUtQ2nrqDOR/c7TPKlyLM2SGYH99gS/zBAXvvcahJAr8f1OE3O32EhdG87xVUenLmJwCeRK
	htdxlFZVgMEnTQ8WKaTP/Rncs0WZFq/0SNMhs6g+eMw==
X-Gm-Gg: ASbGncvrdUYGYpnKkpr5xnstFOWJUjzF51VgrVPtkY0OlSjPmVN6HM/ohranJz4xAqW
	kH8OJk0uQ5SJfDXd1mPreeMxth3xetn1nraWHHxzaoHWI+3OUuAGSQ8R9fd00LMrT2Lwm2Xm+N9
	bNMgZy1FORJahhK9+hzC8WTfFVLcIwbsZSqce5C/uCnCTgoKzZ4p15R5aJscMijHwzjh6tDkG6T
	TuLcBuenomdn6HA+DojggMnCzgnB1xVdA==
X-Google-Smtp-Source: AGHT+IHqCTndsaW9mNNOpEoxqpK+g671TVftkJwHJncfJRnISWrovh6jkW0GrLsJk4LzlYEdY/SfnIetRnQxqll+9N8=
X-Received: by 2002:a05:620a:d89:b0:859:7e5d:efb0 with SMTP id
 af79cd13be357-883521dbdb5mr3978297485a.43.1760529845105; Wed, 15 Oct 2025
 05:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
In-Reply-To: <20250718105407.32878-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:03:53 +0100
X-Gm-Features: AS18NWCXawAF8rrUemNB4cY6pOyINS36FA1C_QZssu58BBI9i4GnKsHpaQ9lquo
Message-ID: <CAPj87rMRKdm4BvfD8gMmSF3jjeMK4nurzTKPOFY15V0tBr4pyw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] drm/ci: add new jobs, uprev IGT and mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi VIgnesh,

On Fri, 18 Jul 2025 at 11:54, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> This series introduces new jobs to drm-ci for testing the following
> devices:
> - rk3588-rock-5b
> - mt8192-asurada-spherion-r0
>
> Other updates include:
> - Uprev IGT and updating test expectations accordingly.
> - Adapting to recent changes in Mesa CI, such as:
>    - LAVA overlay-based firmware handling
>    - Container/job rule separation
>    - Removal of the python-artifacts job
>    - Use of the Alpine container for LAVA jobs
>    - Various other CI improvements
> - Disabling bare-metal jobs for apq8016 and apq8096, as these devices
>   are being migrated to LAVA.
> - Updating the runner tag for i915: cml (switching from hatch to puff)
>   to improve device availability.
> - Adjusting parallelism in jobs (sm8350-hdk, amly) to better utilize
>   test resources.

Series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

