Return-Path: <linux-kernel+bounces-896781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC661C51302
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 572C034CDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07732FD675;
	Wed, 12 Nov 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AYISAMQH"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE502FD677
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937423; cv=none; b=OdmGPUF5XyGDdqggVth8YHbVQeaLa2OfbHmegBlM9DAAKQNqpraEiKRIhuy9vhriFWRfivH+HvbB4k+xKZSh0/hwgjrD47swsbDgPIpMWktTpv8i0dKtWsowLiYoE9Wfb19v0NLkQ45/FdWC10pbb44y8TknPC4PBeQx4rUZkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937423; c=relaxed/simple;
	bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwkx1oosu2tKAEsVuA9buxB4EQzpvW0ADRqr+HWxM7lgFwlmn0WpYlBHCdz0JsRk3z7la+IVacj+oBNcic1Prj7BsNzKFyj1Phm/eOm0uGf0BvyjwES03vYKDlv4g7tuksWQbgUc3SSmiyp+G2D5JAPFZL1AJjh8KJd7e6i7mYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AYISAMQH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957d40e02fso28612e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762937419; x=1763542219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
        b=AYISAMQHJptwYpNDmLTvQ0d12KHT9puLlFVUSD27jqSrfbp9Jk18LZCnIlbC5y2iID
         u1fq2X7O3iIp+xkexEvNAsJrfnW0RI59PnJHiLbvbvgdaEClUTkbL7dgWCMJtJDlJeta
         1JR12Ff5eBMHpStf2uoO068j8EorFjm8uMIVeTbrx/FiAl1m3KJ5HykO/UrmS3y4wsmv
         vAftNW19IfLeURBrs+4SkNEVfIUPR1JdDRNYWmrBvyGK/zK10ySdybz34CxRGNaZsD3k
         2JTHkjDiuWW6n3uoYK5sZLNFfRyxeUa1tVCfHVmnc52FdaMt1TL3nE7PEUN80+UrBLs4
         xuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937419; x=1763542219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
        b=WsHmzcuHnGth2rt9jFQ4GMQ9pnhP095gWR6LgLE9tSq7hIBq2VgFJr1DqzpERdWDms
         y4KJiD5xPdlW4x+AXZ+EzfImbjdxYmVLR61QzOAVA1EMM1mLDVjup7pEiP5X9G+gMhiF
         3qyafLYxIAd74tS8xhm9gHagsGDSM/lkNHwYncEsVLuIiHCYSVoyXWEV44cfuC766isF
         atsrx8Eoirb2dLPCsF78SGPeiFdWNMh7iclWtyWH6yNvulln3tn9tjKmZilnLWMdlIno
         olmD0Rr/zh0gQLyLO5Bmg6ChyTqYjK3K6T4A4rj5YxWittt1QuybxL8pLFnQqtT/L4pS
         nZ9w==
X-Gm-Message-State: AOJu0YzLbuPgTtbAzGryh+nY/IFrA4Y08tVvzyZsjyx6yn6azVcENQiT
	n+9EioW8j2eh0jyTONFuWGo/agbjrzo6YTEgZiyjggx3TmlhKvsgas5pjfCqYRY/hC8qrmH154s
	i/eIzx4LUO8iwGCvH6oWU+ANa1tSdW90H+MRgKhDuTQ==
X-Gm-Gg: ASbGncuKim3xK9jqSKdZQj9NjKUYELz5JnY7LQZO5whdquketIRolVfSYgjk6VGA3EQ
	ADcUmAVMCEZ/rkibT+X9RZxKYacFISpImyDrIYWlKK1ykHqMzjyaVzyL0cZHtlJq69Z0e3k1Ha6
	4SbxzqXmxkr3LFNOtAID9pDIpm1CIqUiBOGiCNrOnjvxPkUMqEe/GHEmwhpGG+c0VPWL6JgsBdW
	rqjcAcrb1nn9rywe0TO5w7awbzAXzp0r5ERhydjI0P0ZI3bG2xP5nc0I5IKFWaQJklaEjrnDUY2
	50i0oFhxJyiQpSEhqw==
X-Google-Smtp-Source: AGHT+IEHNK5povoEOlSKstlSmdaONyaokIQjzvKfkQZcWTAT6dqm/dGcMdLDdwfQXgcunxTTDe/Pm+/naHGGXjffp3E=
X-Received: by 2002:a05:6512:10c2:b0:594:35d5:f837 with SMTP id
 2adb3069b0e04-59576df6c92mr609466e87.19.1762937419287; Wed, 12 Nov 2025
 00:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141907.229119-1-marco.crivellari@suse.com> <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
In-Reply-To: <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 09:50:08 +0100
X-Gm-Features: AWmQ_bnLU4W1RGKwfC6lAOJz6bOKPsLL4ZN-hxDK-KkR_0_v7NSwMnNMX7Q48II
Message-ID: <CAAofZF5WTAZJw5FmtTkB_FGNfee8myVksZGhcMQHj906RGOzYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> [...]
> Applied for next, thanks!

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

