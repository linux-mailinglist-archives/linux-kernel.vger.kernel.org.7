Return-Path: <linux-kernel+bounces-846877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66774BC94F1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A633352305
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4B282EB;
	Thu,  9 Oct 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOYpd02K"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78572D9EDF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016684; cv=none; b=u2aQfaCy5dkbwTrAeICYvP/IhCj+aa0k/NyvM8X6WJfqs327i0DTVVbtVt2pUVDdmciVgWxqi6qEBSSaT0Lm1ZwsXg22Z7d2E/DRNJAe9nczT9vE0bRNFucZRk5E+9TP9flQlZiiS0NWl327usRLT4EEzQLptyf0XeKsjn/lyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016684; c=relaxed/simple;
	bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0slTJ71UdZdYsIr03ZvfqRu1M/ZTKzyts0uTyBGHkChhtzaAuekL/Kzba+c2GWgI9MGzI+MWYneSXM+fqPlwlgNmaUZd1WmkFCLP6ly5nUGILMxQ09duBwS+AMZIWXDgwp0dJ5+BPYYVm+RkCN+Van/digQpQfVm1Dvta8IF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOYpd02K; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so1879653a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760016681; x=1760621481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
        b=QOYpd02K8BVgNunRW7q+mLlUaygR+qTqS46lbZKjTaHTxrBVGFu/XS56SXqS6lEl1s
         AR9Z3Of9CdnuTxKzHufvGgPmBuMbj5wN7FdFS7OhblKcWPYcU0xVVk17QcnozeQc5NlN
         3t58Ff9n8TcIXt5jbCIq2kiPrxypK/kxOAADc7VJU7FDn5QtnjF4jvkGa4RRJYvKs36g
         CBdJOnige3e0uILxxLYTM0sW9xze/h9D4yZah453EBY7UqePVO6KOPtfXm303AkeAu7i
         YZQ/qhx6NG+SZBA9vmKpN0skfQ1SbAVKZyEaZWwx8t+t/x4LCe1qt4ft4tdTVif1VQ6d
         eXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016681; x=1760621481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uMuw9n5pwbOi9ibO0Djym5GMms0Of0kx57oeDZ/s/s=;
        b=pkgnTGwBWtkV4s0uOXeOxIAMsbepk3iG6IG3Cbp75UpsrdYdAEjyTE5qHm1Oa097de
         SNLNmjiQ7oY8efm7cfZFEXHUmeQhEp3LuA1dUE1+Dpea5MfGIKcRNdXbrIlSCxJ0Xy8X
         JVVP20Ob4HoR4MboLINBZpuc5IucaTFR9GLzJy2ZoQiyssqCPWmcL2g03zlKHX1pLvC5
         hlCmKZwz4ktnEYBg7LvEN/xL11jCaQ5wircu0aOMoZBoyun6TBtlmtm0YBGiNBp0jAcd
         ARRFrSQYrawPODym18fpoCKqVe5AdnryFAKjtmUY4fs47V+jopcPA9QWNgmrhHjJp+/O
         7CUw==
X-Forwarded-Encrypted: i=1; AJvYcCW5zwN78mwE67zG/DFeeIiI9iYla64VzmUqoEaBNVLaU6zf9MGZW86yvgRR+Jk3UVs9dV/iFwURedXXInM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTV4r5h019/yYOZkDjru63uACP6j939sYhZiVAD2DyTQmCbwlY
	UgY7E/zqB+ccpKEO4pfET0jwp7RPO3OSpW8u9HkmQJWPbLkEAOVFx1YhtS2tpa0LdOEcPFzZmqo
	xQiD8zk8=
X-Gm-Gg: ASbGncs2PuCet0eY/k28HbvJtumSHm1+ujfKJeIqpUebdELnTb6T5ujV3nnJirXT8Mu
	rhzOH9EVDqWVsmUupqHZa5Dgm5PFRGWJZOs7EzNb2tcYLs+srfYYy0scUabSEYJtMOtV1ZL0OyM
	lBegg1R7+TcPr9ricgZT//HzeLdyP01GUNeN3tGIXRN10zNgr5RlPLdjJ0WIO2EiJUJ9jz2hHMQ
	7G/5YZNurbesXO8/rOi0z7ObOcyGhUNdeMr72+wpTfAYlK9InBcqRI/y6xzI0dVDNLo4FXjoiEz
	ffAV4K6MxUc5s+Vn17wKHL5KQXsg0NMHKo5OyXxJUBnUmr1s8SRbHnFzYRBoAJBlRND6AzBmcfT
	N1nd4eA88wZrOOYEXNW+ssfCf0ovpSFTG9nnttJEd2yfzGyE2l4VaXg==
X-Google-Smtp-Source: AGHT+IEnaDw79r99A3B3756aMdxT7SHXjMqW6rLoG3x0RAXtUbJZNUbfM/vMx/v7BA9OApMfoCnFYg==
X-Received: by 2002:a17:907:9720:b0:b4b:dd7e:65f8 with SMTP id a640c23a62f3a-b50aaa9bbe9mr879682766b.25.1760016681115;
        Thu, 09 Oct 2025 06:31:21 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm1905425766b.7.2025.10.09.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:31:20 -0700 (PDT)
Message-ID: <9d4ccadf76ccfff1a8b5f572b8aa190e2dc40c29.camel@linaro.org>
Subject: Re: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Ulf
 Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Thu, 09 Oct 2025 14:31:19 +0100
In-Reply-To: <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
	 <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
	 <5df18f42-b567-4d27-9e12-29723af40d6e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 09:13 +0900, Krzysztof Kozlowski wrote:
> On 07/10/2025 01:43, Andr=C3=A9 Draszik wrote:
> > Convert to using devm_kstrdup_const() so as to simplify cleanup during
> > error handling.
>=20
>=20
> This is either a fix (then describe the fixed issue and add Fixed tag)
> or you change the logic, not only simplify.
>=20
> Previously on of_genpd_add_provider_simple() the memory was not
> kfree_const. Now it will be.

Indeed it's a fix after all - While the driver doesn't allow unbind,
I added this patch due to the followup patches that add potential error
returns during probe, but somehow missed an already-existing error
return after this call.

Thanks Krzysztof!

