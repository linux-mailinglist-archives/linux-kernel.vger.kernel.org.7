Return-Path: <linux-kernel+bounces-792033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BCB3BFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762311887B93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD38326D4A;
	Fri, 29 Aug 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="EWzDwFsX"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4F314B85
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482023; cv=none; b=uUCZqSHzUhvSus3nUUl6oUHEHVT2TBIV93Ikn3hxsREpcd1ZCA9ypiUn7BwvFcmb1JRV81bZav4U5XwlGVGFdKwb2pTthb2xcYJDM3hqrdngvch0qL18xW1PO5tbg8T3po9e6JICR0a2BLTeho51QJQberEOosh4t1N4BQgMHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482023; c=relaxed/simple;
	bh=vMllst7gcBdZpXi7zdiPGvGRd+qrzm4OkoKr77sAH60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaWjVilQPLLVNanEk4mwPzz9T4Q+QrXReYkDZmCD1kattatn4HUBI4JOTzzbHIpfzi2n0pupCYlqDOsYmJ0FZVVYrRzOSk9vFkYnxsjFwfEes2WE0frr8wqyBMaNldu9jWgAyZ1Wi1ytYVSea7Q2nkJk8ja5ju5E43IV+oubkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=EWzDwFsX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7fa334351b1so235770585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756482020; x=1757086820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMllst7gcBdZpXi7zdiPGvGRd+qrzm4OkoKr77sAH60=;
        b=EWzDwFsXTR0Ju8jFb2NaQLlPheyINJnOVjxeOzH8MZUOOPKpoYEU+rUdp9AO2YYElC
         W+LWzzbDqQKIzUm53OmD2DgGl+GOAZGsY1Dqz34d5jgNbd90eK1fEH+TqJHFq7KO8MhZ
         ai6OC4LoswCrjBZMrf+ZGClZgkyojHAE79Bfpi/N4qbhgjtgjUGBqAxKXTO0bWAJBXIJ
         i/h18uJd/l2weCr5X57vOytRLD+U6po5sXUMI0eb69xg1XgEyPtaP4qDW8HNzxnEcii0
         aoMht2Y4n1XEaAPHk6zq2CfM6amDuiF1s7AvVanLyZ5ogFr+RbYC6G7YXHvpRRDPuwTN
         Go7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482020; x=1757086820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMllst7gcBdZpXi7zdiPGvGRd+qrzm4OkoKr77sAH60=;
        b=AMux6oonsaIAoF6fF1pVVd/FPeZze0WZnV83gXiVQi5hLrpSc7zPmGjYktwETx9tAN
         7ilEf8br8xoMAOF57QJzCvXwhfOTgRHiCsjJr6AnwnQE2HoJO2UBYEqpjim3Gs/yURUP
         6VmCV1R7iiZQEsH/rDGVmbs2fjVuBqh0M5zSCLywDtgqxy9s5B5aKTuUE0bUjx/HNwP/
         +X102xHSIT8z+p/qFkiXEFPWsMuku7sl1hYoTQgmYxZw4FODEkbvbqg6wVZGUN47xdc0
         NnMGeNfhj5FarUt/55Lsz+F+SKd0Co3ZKQS4xy6t8otjBzvVP3+wz3XmScbhlx1uMMUT
         /1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUqEkhFQf88v5iivM92mDInURJPlyewmMO+vb8+ytdm/4ArrDDMuXLhm4FbLlThr9NmXDNpq4taz1cSmB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEGj0hocy4f8PNX19BBX2zGEXiQqyBkMbWIX5DXU6/FPHb0Ea
	Q5RHLX9qo6UbOMsO8jz48yI0bxS+EcI9598tdm007Rg6WIN8nVQhFJpS8wEjEi9HVWyP2lPtNkM
	muhgJQi6AzYVMdZurE8bmKQ1hDUIifZp8lRIjRg2MKQ==
X-Gm-Gg: ASbGnctPeNajooZrXowZC29n4ldRzj/nGweJn6V/BIebZfELSsyWsybKEJ9tk9LWsfP
	KMQo8Vm+fuLL7clL0jtoXfFOTBjEodKt9soIDerODmCN2nOEKa937sRn0qFpG1uhqWfqOexpGVN
	5BxjminH/Gu2jAEJ9KrDhnf7MqiQHN7wKuNvc6ve9ZkWrnszTIL1x/hQVmKzfRuGew5WcptDR/7
	B+2kz0ZP9LJ4IPe
X-Google-Smtp-Source: AGHT+IE8Uc8yE6e7x+T9rqx7j4SzBv64YwjT0y2LqCPYIhx7HTc0mU0MQAVdWTXexDU/wbuTY+TnRdDvA85/7NRQ3wc=
X-Received: by 2002:a05:620a:a08c:b0:7e9:f81f:ce8a with SMTP id
 af79cd13be357-7ea11095a39mr2507020285a.76.1756482020300; Fri, 29 Aug 2025
 08:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com>
In-Reply-To: <20250825-rk3588-10bpc-v2-0-955622d16985@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:40:08 +0200
X-Gm-Features: Ac12FXwMRvICk8YV3mQ4_G0eTMWJVkBD72BsJ-WaKgZKQMAHDd1L4Y9QuXJV1oE
Message-ID: <CAPj87rNgW5-1YzurL-sFJF2SsGFmENF9JD+82cqHAYLfa67LZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] High color depth support for RK3576/RK3588 HDMI output
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cristian,

On Mon, 25 Aug 2025 at 12:08, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> Since both Rockchip RK3576 and RK3588 SoCs are capable of handling 10
> bpc color depth HDMI output and we've already landed the required HDPTX
> PHY driver changes to support the setup, let's add the missing bits and
> pieces to VOP2, DW HDMI QP encoder and bridge library.
>
> Please note this conflicts with the HDMI CEC series [1], hence I added
> that as a b4-managed dependency.

Thanks, no comments on this one, but having not read the PHY changes
at all, the series is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

