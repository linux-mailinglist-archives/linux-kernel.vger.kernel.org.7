Return-Path: <linux-kernel+bounces-856279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77009BE3BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496C5582646
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD8339B30;
	Thu, 16 Oct 2025 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bnnSEeWh"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B921F4165
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621776; cv=none; b=Av2cWeMr/Hepd17dTK1q1+drZ9mZWaolxXuvaBEEkbIBHMbTfmvyFzOmJwuWb4tHy4/jf5JTFXjT+O2ySoW693rra66hr88duV9BehoDsw+ueEtwRtYWzW1VW3x/A/BAAVgJb5h57j5FQWpPHb/RxNFLdoPNjBN7SUY6aOEZn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621776; c=relaxed/simple;
	bh=myhDTwrlDuPGYHqb1hWWIpm1yFy04723XOZCYiLG6Y4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ULSUxRQdrRJHSV/IkbnR53c7miwr+CNS5aKOR4MXi411mViktMNAZAiJD6vxDBjSamRkf6M+VenxTOe/kJcSjP3wDn1+HgJN4kneXL39ULQTqL1ynxQQpNSRNW+O6rWm/GAhi+In9hAqNFuBQDSMKS2saqb7toxU2Y+7AH4p9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bnnSEeWh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B29774E41103;
	Thu, 16 Oct 2025 13:36:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8656A6062C;
	Thu, 16 Oct 2025 13:36:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 213E4102F22EF;
	Thu, 16 Oct 2025 15:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760621771; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8hlnduBps2CCSYzZqpb5CLnowbo1EYG2ZwR0jxQsXj8=;
	b=bnnSEeWhKYEVbruz9l2dL0xE/3Ra47wG9Ly3XxMwQsX5E0GEZzTOVG6D0eVkvCDLhZyNwO
	FvW7GTPa1KqwsikenCJTxC6ii1WYsNz/kh/NwBxWrtGhtFqqxzJ5ogrw2vXzQbSNATBjCd
	P023c0dKp9XL756GfgsPT1nIO7zo7aLZSpo790eUDblWV6C2QpefCKVo8Ax2fx8njJBba9
	P7jMq13dx/jhpWiIAEZ1x7Gk2Cr/s3PZq+aA6GAmYrwptE0fLfPPE4uCQWZ8srJx0/DmfX
	QUbX7RJtQaoRupKR9vJ1oljYDIU+iTFVcmFD0/h+F1VoGzj1EsKp1Blcvdi1Cg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 15:36:00 +0200
Message-Id: <DDJSBQRQJTMZ.X1W4I5YOURPK@bootlin.com>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 <dri-devel@lists.freedesktop.org>, "open list"
 <linux-kernel@vger.kernel.org>, <lkft-triage@lists.linaro.org>, "Linux
 Regressions" <regressions@lists.linux.dev>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Simona Vetter"
 <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Dan Carpenter"
 <dan.carpenter@linaro.org>, "Anders Roxell" <anders.roxell@linaro.org>,
 "Ben Copeland" <benjamin.copeland@linaro.org>
Subject: Re: next-20251014: Internal error: Oops:
 drm_bridge_connector_hdmi_cec_init drmm_connector_hdmi_cec_register
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com> <CA+G9fYv_mGoDzFv33v7Y5+6yz6z=xp9FJRiFUBYDapvE_rrBXA@mail.gmail.com>
In-Reply-To: <CA+G9fYv_mGoDzFv33v7Y5+6yz6z=xp9FJRiFUBYDapvE_rrBXA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Naresh,

On Thu Oct 16, 2025 at 12:52 PM CEST, Naresh Kamboju wrote:
> On Thu, 16 Oct 2025 at 16:14, Naresh Kamboju <naresh.kamboju@linaro.org> =
wrote:
>>
>> While booting and loading kernel modules on dragonboard 410c board
>> with Linux next
>> kernel next-20251014 and next-20251015 the following crash noticed,
>>
>> First seen on next-20251014
>> Good: next-20251013
>> Bad:  next-20251014
>>
>> Regression Analysis:
>> - New regression? yes
>> - Reproducibility? yes
>>
>> Boot regressions: next-20251014: Internal error: Oops:
>> drm_bridge_connector_hdmi_cec_init drmm_connector_hdmi_cec_register

Thanks for the report.

This looks like the same issue reported here:
https://lore.kernel.org/all/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.co=
m/

I'm writing a fix right now, will send it today if all goes well.


> These three patches landed recently,
> $ git log --oneline  next-20251013..next-20251014
> drivers/gpu/drm/display/drm_bridge_connector.c
> 2be300f9a0b6f drm/display: bridge_connector: get/put the stored bridges

^ This is the commit introducing the bug.

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

