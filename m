Return-Path: <linux-kernel+bounces-832150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29305B9E7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2517732145A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25152EBB9B;
	Thu, 25 Sep 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ejb1ZWzK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10D2E9ECC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793425; cv=none; b=dvgor1kpCndpurguel9NDBC0s8Cwx/jJrtWTubwEmRrmUU6/IEMjSkKw+Xlu3fsONbRGT5X34wSvOfWRSLq3hYUsjOzqlePuo6ScPxPKvk6JMJhrgrmkDb1YC+Q2gOMTzShZBnCchTndzPS4WOrDP4ZTe/XOevoGhZlcWDlwois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793425; c=relaxed/simple;
	bh=Do01lFFcNDYlGWQcYjdNtP19mQ6XNKmi0AumEvwX5Ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kRxG48A0NniwZir/9XNqWlTjt+5+jEW8x3TTzaE1aZA3XVMxjXJ3qvj3fMFiV9l9+qYE1TPjtJuoAB/c6tt7IIL+Eo6vksbeSza6d0INQhKkyKidjQMyFvBvpXbq3v2/Kq9jhub38wzKmN7OKHgwp3Ayx44W3nc8+JoetmL8L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ejb1ZWzK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b30ead58e0cso128554666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758793422; x=1759398222; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCZnhATrsjVbGiYUB4fIkwGkbNdpLbfL2naMCtBsqWk=;
        b=ejb1ZWzKMQ+OA0tMn5zstNHptY7noPUmqwPqyJDNU6aDYIMvt82QRnT8xTJD1ihoBJ
         7B9vxKxH4awaIV9NdCiNG7td5miuaQwWTJ67rPZjL17tB+dGU4/nAavaqqOKayT3XInq
         T5Jw2XsDJhkD9NhyngmlA35CLrEyjiv1rWsToTy0ZIKcDv2eqTx4gLPCC/vOBquSKFHy
         FLp5lZxdg00uEZamVjC3azW2I7TZU4ulhoFrclmb3Wsw1I+dGt/O2kXLcTzgy/K5hMP9
         1PpxnH+8PGuBYRS95j71ZzV751T+29yVszYhKL1VfjQbSWT+IYt+jf5cnxGrczW5+eSW
         QcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793422; x=1759398222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCZnhATrsjVbGiYUB4fIkwGkbNdpLbfL2naMCtBsqWk=;
        b=q9KFtOU1I644r03hdbIoV80PEFXPKU4U0g2ZwCc/f6oTluHGc0BB0rD2tfwgh3kH2p
         SzGWJRXclAd027MsnmDqyjwgym1p+sLmmvRQiNO8nLEd2auvOA8fjDOvtFMrD+Y2+6Rm
         vKAfXxMrKAo9yy38gIB6oHqsJy3fpblrj1EIUm9OOymFR/W+DU88Y3Onmxg74J1XvWBY
         0RQ7MFlitTJlAre83Cx3CzeT2RMUoGmfkC58MeNc/UZnSTb5sNapJBdQU03YG9m+kMy5
         gXF0athObkNKlVdLrBZl1uiY8enKjp4tUA98cGA5xXGL42jKV40SRvpaTIdjiucsy5Eq
         Baxg==
X-Forwarded-Encrypted: i=1; AJvYcCXe5i2zYoezrUklzMM3pfy7X6thh1bmXaMwSwm+KdHxp4uR9gihZlEWGtC+ZnldahifKoqz23Ni5GVzkvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQ8tnjtvioVZWUtaKBaYfn4L558QFR/lpjSiVI8KUeugEQFav
	XoqU9uFPSob7psxjS4ekR/gONEV3983kL+LMMOi7aO+JQHNhV2/yQ/q0TV+kSSqhZg4=
X-Gm-Gg: ASbGncv+NglG4RFB/S+JjnPrKAUnKyb0tLAa6qEb394feo0QYw/jIworMFGl7DQdIYB
	4ypZhdPrPDudS0P8pM2CHR2l72d/wwQNTooo4MtdB0FHfQpHe++2H4oWx2NvBjljERQFb7P4Xkq
	p1QMlhO4puyvTFrlt+o1iHQ5pzOC6NXOWoOAwLZ7yaRNziouDSkYQGje7WsZLaAIxdB+GSO67pf
	+to4t/Fb9oeVPtXg2XdWHZ6Da9/ZvyKlLYPHCxDP+IQG251O07UghTn/xt9h+wwvExP8k2dBVTz
	kXbq2QyKXdLluFSOmtRPAmAbPEFzhxP+ckr40slVOYwRMh/VY97ttnaaj6f3szjS32pB4oyfmqF
	x9dTI0YxED3IN2WQ=
X-Google-Smtp-Source: AGHT+IHtjYY4u3ev2M33gy9xtE76ugh5Zae/dWOU8GUtMm4PBGTQ07Z0LKjhRfz3yyXn30W6EI50iw==
X-Received: by 2002:a17:907:94c2:b0:b2d:604d:acc9 with SMTP id a640c23a62f3a-b34ba93cd00mr280580766b.35.1758793421736;
        Thu, 25 Sep 2025 02:43:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f74fbsm129383166b.51.2025.09.25.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:43:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  donald.hunter@gmail.com,  andrew+netdev@lunn.ch,
  ast@kernel.org,  daniel@iogearbox.net,  hawk@kernel.org,
  john.fastabend@gmail.com,  matttbe@kernel.org,  chuck.lever@oracle.com,
  jdamato@fastly.com,  skhawaja@google.com,  dw@davidwei.uk,
  mkarsten@uwaterloo.ca,  yoong.siang.song@intel.com,
  david.hunter.linux@gmail.com,  skhan@linuxfoundation.org,
  horms@kernel.org,  sdf@fomichev.me,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com> (Mehdi Ben
	Hadj Khelifa's message of "Tue, 23 Sep 2025 22:00:11 +0100")
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Date: Thu, 25 Sep 2025 11:43:39 +0200
Message-ID: <87h5wq50l0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>  This patch series is intended to make a base for setting
>  queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>  the right index. Although that part I still didn't figure
>  out yet,I m searching for my guidance to do that as well
>  as for the correctness of the patches in this series.

What is the use case/movtivation behind this work?

