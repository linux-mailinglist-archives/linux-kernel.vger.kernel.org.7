Return-Path: <linux-kernel+bounces-857038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D6BE5B93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3B502D32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F02E6100;
	Thu, 16 Oct 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgWntrFf"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BEC2E03FE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655081; cv=none; b=aoyR/x1DcmUD09izF8MfDorrGIjz4TN/+rdzMnN1tSgUyP1tOJVUd+CqkbrmwMab3qmEGohVWuqvM/H5JBOybKHfuCmmgy6KX3yAHtYt0QBdyQRlQ952tfzRkDaeWuXQt9HvroPiCBZhk4Dkrkrs1j3O9kQAc6k6n4XTe9bibqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655081; c=relaxed/simple;
	bh=kmEYRnE9eYaFqXKORkJ+PIJAmcGX5bvGN7hsJdgH+6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvbqxz7a0mxlqrdpika/FLqUECi4uTUVYRxm4SF8HZ3y0zMVm79vQ5xmiKKUT2CdKTqJt9oBieN91y2hfILvpH9Ae9U7ce/WOt+7uYgysTVuZirgXQOP/b5+rffmCEqQhwNPxq/5hZA70739PtlsXNRb018vAFZA3C5OZo4QUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgWntrFf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3696f1d5102so10570791fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760655077; x=1761259877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmEYRnE9eYaFqXKORkJ+PIJAmcGX5bvGN7hsJdgH+6A=;
        b=kgWntrFfAfzS4ndV/cr7cLNh88RSLBL19wsltxNBmjtPMXK3QCKbPWcu2wUtsLhz2w
         8CHZ/MQuSCIIG+VtRngZolwKCLnxdob+5bUFvLbj3KAbLNYJhc8b8PWkUKE5xqQLHMKL
         JvHiwWkMO6cgddjkkTGFUJ0DNRCuoLifbH1t78CMQSfQDNLLR14HjDVY4U0vs9DApyVt
         WLWRff6ws2uEH/YzG7Svp2ZT5HJGd8x44D20ZFECG/AOtyZj/dpBM8LUWl2FTJ3MJIYo
         B3m6bf8Nt5kpaxz0x75hvXJp8iqhgsxxDHhh22h0lJyOg5zmksqtcnym+rTjGeHg9Shb
         xhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760655077; x=1761259877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmEYRnE9eYaFqXKORkJ+PIJAmcGX5bvGN7hsJdgH+6A=;
        b=itti3UTfyqNd4Kx3EwLFv9wPiIibs77O9zSjtDdwxnDQ6VXjjtn6e9wpZR7AhN33NG
         TaVR630jph/AkGnfOhN3jLR4qDddmuT6Br6IJkS7CUMzz3phy97cwDxiljW5+wHs0ro/
         WRa0jsGsYNXZs5Q6WMW7ZLiXOkpDzo3iJn5w/mu60bczy3/P/J7p2BI85K6ypGfkMmEQ
         llbP+gEHzfsSbZZiX+uQMWmRgnmV1ksNT4yK6SgypubdCURsOTLRoUdFn8tC+VKX4/DN
         7TpE7fV6hqImufQ65IRDZDO1cST62aOUcKVhnhK0SioODNZSHIee5gPx+AR0bi/OJPL4
         +InQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVMkMzc82KV5Ww7tMH+wWd8jBLe6ygxwfXp4BNphYyjBGnvPMoL3UEA1MCIF9kDEWu521wXe51YOvN7fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WUaJgNIKYgm9j+fckvVxVbhPCgWD9wort35iDVrj1puMGanR
	yFq6j9Mj/mB4bb82rtk4sCYsGI+8w/nbxITM8NZ4DnhSsYoGR0fnjvT8WFk4zBDSvpDbfxKOn2l
	j8FWxaqVJVi4fxmhCVot+aHIExfWBEuDGen0fqadh3g==
X-Gm-Gg: ASbGncttFU/QiLW4fuz2bVBmb2gW0VvyuuYPqgyEHv2ORnOwtIZhvtHwfzcfargHE3P
	BkIMEwbZdX7VBWzzGURxQ9sXGOiFT2bEQxga/0voSxw4V3wybixMtqC/h5wFzfV4fwhtevejXtt
	Lt9uTZL1OaUFw5Bjf0fAfSlqd1b60C8NZgtm9LMHXSWaLTsWEBHsWW9n7Ah1FS1opnMOMhRw+D6
	upkCZvCMhkLPpvhRmEGtaRq6JqJ27Iu9LsMa4okaTMU+Np785WRNE1UwazM
X-Google-Smtp-Source: AGHT+IF2PsArzf82nnnIcXMKJafhbORBWTmQjtEV2MVSW4tFFx2e5kaE7Rul4euIEnksQA36PN7ysUqEvFRBOXSjgk0=
X-Received: by 2002:a2e:bc85:0:b0:351:8d16:d0bd with SMTP id
 38308e7fff4ca-3779791150fmr6358721fa.19.1760655077092; Thu, 16 Oct 2025
 15:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015712.2922237-1-gary.yang@cixtech.com>
 <20251014015712.2922237-3-gary.yang@cixtech.com> <CACRpkdaXW-BFM=HvqLiSY-Mkmhso2ETmkZzOX328aSadUEBdSQ@mail.gmail.com>
 <PUZPR06MB5887BE1631D6D6959067FDA5EFE9A@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB5887BE1631D6D6959067FDA5EFE9A@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Oct 2025 00:51:06 +0200
X-Gm-Features: AS18NWAn7wwy003ztU4tRuoGojKRToh6fuepHCkeLH2yGuI4i-eeI2-SuJ4p_pg
Message-ID: <CACRpkdaOuih=CVuGVgpfwP921g5KSd1Dm5v8oyyYq0pJdrzgHw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: cix: Add pin-controller support for sky1
To: Gary Yang <gary.yang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 7:41=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:

> GPIO IP on Sky1 is Cadence, not Synopsys designware. We wants to do
> it when upstream GPIO driver in the future.
> Are you agree?

Yes no problem. (I misremembered that it was Cadence, not Synopsys...)

When I look at the Cadence driver I see it needs some modifications
if it should work properly with GPIO ranges and interoperate with
pin controllers. It needs to call gpiochip_generic_request() and
gpiochip_generic_free() from its request/free functions, and
preferably also gpiochip_generic_config() which will extend
the gpiolib to call down to the pin controller and take control
over line properties.

But let's do that in a separate patch!

Yours,
Linus Walleij

