Return-Path: <linux-kernel+bounces-627516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE6AA51C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4231C05823
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F62609CA;
	Wed, 30 Apr 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKkIitfA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834442641EE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031125; cv=none; b=Tmeb7mP0Zrv3vMXXTOAEjelI8oUyEIl8yVQi2rVXAsqUAKZj6vVXhwmrItudsmz7qG9kwLIXbfY1RcNR9TabPqnTBJtzTnko7mxH3uxHEjAHWIEieNIYnae6X1NlIygozEXMZ5U276dKG13GgCveFlIZEbmPFGnh92CwTcRmoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031125; c=relaxed/simple;
	bh=a+aS3VH0fFr3wLv+ziZGwPORQcPz6cZRwZ8j2YP4ds0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+KgoAz79Q+wqDYRSflNvo7qjeCf1+Az/0W4kGjC9Z1f8mW/VKDGtfhWeqAZYbW2AW35fW810E99WkB/US7xnGytO8QDCYvTjfSR6KF0dCKAHAVGSJk/fajF38okBNXoUgqx1NZNvPppO+bFAD6v+7vv9OB7fbW7TXuV/ispBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CKkIitfA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so70635915e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746031122; x=1746635922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImSfHGGDXmae3/biQUrc2P/URlkNlj76LbgQ/xlJH98=;
        b=CKkIitfADxBdSqGUCWMkOThE1jTrvFSJZuyRABPLGn2aS7dnws+eH3W6XLQ1qG5gjO
         Gr5IYJK5FNFHumMYGdFv0aXyPy5xPczbI/uVN3/YOn1Ea34z0SrhbMqGNnClh/vskurO
         diEbki/F5X/gj6o9T9Kzp6S3+zQsUvSg6gmqWr3P6n7YFddQACB8b2UWqSR031MphRGp
         eXVhTEXnGkI4166ayB6JWPH9dtDDBP2b3TyHNJS0Qoyl8T2/8Hfu3zdxRbbYd9XefVwn
         ZMl/pZ9f2W70BukkG0sop+BWefRIs44Ej03vfrk5JjswxqVlIGBJDghrvaM3SiBgNkdk
         kjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031122; x=1746635922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImSfHGGDXmae3/biQUrc2P/URlkNlj76LbgQ/xlJH98=;
        b=kGzOII6Ha67T5O9OwK7eAxcr+PY0oERF+6qK1gp2pT9yhc4x1NFrrZoGiKFtebXvbH
         9eDZEq22Cun2WeDvFiY8gjGMGXEgJcEh8+Xfvk8hopNKVlx6Vh9S4mZrEizAZo8eod+7
         8FYXJIRlUSgwoxgg7+3DXVLyDm9vfzGKGqXAGzrizNYBpLcor2qBhjp3xRBnww50+C4v
         PmJRo4BWmxx1cO4/E9OusAF5VTxlASuSw3HQ2NFYobLpzJAbZmEUdULSsw8DBhcawyls
         QyZce6Hw4zc9KSoS7VkwoxgmVAUjuCmSczI2+E/gm0iKu7xk54ckRXmHyaOvLlf7I6RK
         OSDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGX0afL/MPXW4aE4kYkvfoWRJSdPekg4kjQyGXVaAAf692KiO+s0d7MeBWBk7TXLFvp18Bbp5a80YiEcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRPkxckJyhRIRVHLTq/AxINH6kb1vnHWlOverClMWsra/8nvO
	jGBmhzXTtR2y/oGVTXtF2h9TIxOtYa8crqBH7Y3X3bYyawhuZyoFXQXDJ0DikTI=
X-Gm-Gg: ASbGncvvt8ZXdruXQuWNzvreLjHJD3UMr74cObPf+M7ZjR3fsT+OKMtbpt73xYmbBVB
	eETGRf1hfaA9m1v10l7gnqt4B6urrSl37lWJp1BnDbUu/8XkVjfHMM7ut2CVNndX0g+cczC9+t4
	a39sWe3ODp4Qi61xpTYf9hzG9YXS6ZQ3BGCQV7TYpm5dfGXftgzgjLJ2X1h/W8G35NgDbsTnGIH
	XjkgeK0Dw6nfqkMuwnDw58tLHZF5zIstj6ARfuaHDUwkO0p6jsx0t9s6Edzapm3hxgAeJFNFPgZ
	f9lQ70GRZzMZJM9ttFSr8yssfMf3IJglI2nKAGI5Q+MbDrnUV6em/1TwLqR0iahLvxGYLUnYnm+
	wmp8=
X-Google-Smtp-Source: AGHT+IEKy3F4uYVmzfjaV7eUGAdjznhecYK7JE8sAsW9F6Cog3MaZ4CfTM6KaWY5hOefQKaGuojVAA==
X-Received: by 2002:a05:600c:1e12:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-441b25dd779mr37480605e9.0.1746031121822;
        Wed, 30 Apr 2025 09:38:41 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a5fsm31756385e9.20.2025.04.30.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:38:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 18:38:39 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
	stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 4/5 RESEND] thermal: qcom-spmi-temp-alarm: add support
 for GEN2 rev 2 PMIC peripherals
Message-ID: <aBJSDwZg6Sr7t4bZ@mai.linaro.org>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-5-anjelique.melendez@oss.qualcomm.com>
 <aAI1JnQ2yCjtJL9u@mai.linaro.org>
 <6031624c-9c65-4df8-88db-96800d58c910@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6031624c-9c65-4df8-88db-96800d58c910@oss.qualcomm.com>

On Wed, Apr 23, 2025 at 04:31:18PM -0700, Anjelique Melendez wrote:
> 
> 
> On 4/18/2025 4:19 AM, Daniel Lezcano wrote:
> > On Thu, Mar 20, 2025 at 01:24:07PM -0700, Anjelique Melendez wrote:
> > > Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
> > > revision 2.  This revision utilizes individual temp DAC registers
> > > to set the threshold temperature for over-temperature stages 1,
> > > 2, and 3 instead of a single register to specify a set of
> > > thresholds.
> > 
> > Can you elaborate what are the different stages in the QCom semantic ?
> Stage 1: warning
> Stage 2: system shutdown
> Stage 3: emergency shutdown
> 
> This is the same as was outlined in original driver documentation:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/thermal?h=v5.4.281&id=f1599f9e4cd6f1dd0cad202853fb830854f4e944.
> Will add this info to commit.

Thanks for the pointer and the clarification

> > > Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> > > Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> > > ---
> > >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
> > >   1 file changed, 136 insertions(+)
> > > 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

