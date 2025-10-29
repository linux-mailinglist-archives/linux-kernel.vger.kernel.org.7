Return-Path: <linux-kernel+bounces-877263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4316C1D993
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8C314E3CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B72D63EF;
	Wed, 29 Oct 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPpqN9MU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA92C21C3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777497; cv=none; b=M4Xe3XoQs4nKFEE/Fu7js3w996d6hjtJN09hvlpLUVQFUO11Smgu9lQ6CdVMlqywKhMlZbCNPcTkOOFs443RCW1wKwoxarg6+ZW05o59gjIeYFgb+/ZdCgOj88UPqsJrQAZVDOBruJpOJvvCmMYa6FCiSm+By708JKWiJOHVCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777497; c=relaxed/simple;
	bh=LzhhJeyhuNotVzEFbkuilK+xDg5eMa2kqkHmG2gliAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDU0P/++/G745Mr0kcbUGIEkPnsaHDUJV9JktgxZkic+8bYpU5gD674kESpzoUyBfaKTQ6HjDp6MTX77tBd6RZJZkyDLEmBNamU466yrm3qWX+XWh9Av216gV2akmTuG1ALATLPZ3CC1DqBZg59gKdZSojBRzL40wMbDy9AybKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPpqN9MU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592f5736693so388734e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761777494; x=1762382294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzhhJeyhuNotVzEFbkuilK+xDg5eMa2kqkHmG2gliAs=;
        b=pPpqN9MUWQS8DSCB7l87y2AV8zKWw9R+G5PA4zzS7WSQznwgNprLHGK8gJKV1c1C/y
         AOZjfl9X9aMzX+Accmr8Cqjnilud1+775vvnG4Bm61ndqKKwY6kYqB1OcYQaleOdHdl+
         O72ExMWKIHT6dTI1WezuhG+5K8+AJOl5Ee1zuOYyJGJgrtEnQrG9w8noHfPozGxXcgW6
         8qtHqHjd/lAXzMrFA90PHFtY4NhL6na/qBjUgv7rKf1tp/O3ihf1RxRoeJo51KuekKuk
         mJI/XnswqodH/clqBqsqTX/ZvPBsPXpcK8QYao9oy5dkfKAg+1dG54eh4zZYB+N9IFgV
         ZMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777494; x=1762382294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzhhJeyhuNotVzEFbkuilK+xDg5eMa2kqkHmG2gliAs=;
        b=uAy8DUWZ/Mqc1PW5ydG0yJ1YGWjtVwYj43Fk+KneetwBI2+WqKy7kZTC6NgR8Vxbus
         VTamdx2rDOHGKhGPNVvPphQfGZBYJpiRp8zTfQifJNEYYk8crBAjSUmDx1SZXqx7us3E
         +ABQKtZv/Oin35v9lW/DyDh/N9ae0a1AmIkOzAIYYFAhreVnDzcEeZsdj3Nm3zdYi6go
         +THrmYGe4nHmLc/duL+Go4zfXodqHsZTbKWyLb1n5tumGn9wrQ18EXbv2+0n2rRRbd7l
         JQXK4G5u5iy3+SxF8ELxXlCNXnGmd4jCPUZE3iB+yWsfKWLKeFYAlpoTeGGDWUqpC7pF
         sNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC+o9NIWR9PkeslOrgHgQnjPuLlR853UILJ3oaVnazldYzz76bmn5LRqe7RyQYfsJGezoHawFM3trqoWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wCb82z/UP14GfI+OmcuP745ld3ePIlYStbDTEKVY36KjUiWR
	8TyBeHFwdKJsZEcRIMFSGYE73qsevxGZMP2SfU0pRxADSwTgumq9ZLpwsUiNjdZY5iG2RlefvWz
	G5iexWmrHdiGEnUPGg7vwspb4m0X3Zli4aiXMDBS0ZA==
X-Gm-Gg: ASbGncuaZbBys4aELmmkb73Icmm/lmgqpREbuQ5fP40kKPFOd0nt+tXI3jg3XiV5w1u
	MNeYwDkvTI24pwMeGBqcZHge+GbpVICWmjeKAlXjH47VXgLsoTvpV1GAUDPnMa6dlzCqU+85ygt
	mXHhHxlSA7YV+ZT50b390k1Y197/ylDlckxrXaw1axeUTkyaSGWYGaBvvfYJtN/aor3aUFsaJIX
	pM1GXdqzJ2voheqss77lEOFzLtXwm3BNNJ/CfiSEBtz9btJpPF7bN3+M8XGLPTfE37fbO4=
X-Google-Smtp-Source: AGHT+IGSUDEU3GIah9012vj+4Pg6s5GLROpJXSNa8R5tFKJQLl26wMkX/AWwD8Tr3hAmRNfydWUkSQRxKrXdGT5PldQ=
X-Received: by 2002:a05:6512:3c96:b0:58b:8f:2cf3 with SMTP id
 2adb3069b0e04-594128696femr1551857e87.21.1761777493571; Wed, 29 Oct 2025
 15:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029014252.178-1-vulab@iscas.ac.cn>
In-Reply-To: <20251029014252.178-1-vulab@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 23:38:01 +0100
X-Gm-Features: AWmQ_bkwwJG8Z6hmew0Xb94qZ2C3iHp-j72hqofQeN8YiL8UtJjm3k_2tYVG6MQ
Message-ID: <CACRpkdanWwXSAu4oH9LnnTJ0mxB+7sorUKj_juFrRebhdL1WKQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: fix hwspinlock resource leak in probe function
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: antonio.borneo@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:43=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:

> In stm32_pctl_probe(), hwspin_lock_request_specific() is called to
> request a hwspinlock, but the acquired lock is not freed on multiple
> error paths after this call. This causes resource leakage when the
> function fails to initialize properly.
>
> Use devm_hwspin_lock_request_specific() instead of
> hwspin_lock_request_specific() to automatically manage the hwspinlock
> resource lifecycle.
>
> Fixes: 97cfb6cd34f2 ("pinctrl: stm32: protect configuration registers wit=
h a hwspinlock")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

Patch applied!

Yours,
Linus Walleij

