Return-Path: <linux-kernel+bounces-775680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A5B2C38C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1235A722BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A33431FA;
	Tue, 19 Aug 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMJtx/vu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F33431E9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606084; cv=none; b=edMf98Y+a/VeWXNP8n+cJUsD1dbigvcbj7WT6v37rTkbfobktIJv8pUtmWsfdqIo4LG6nGnOPqytztP/ozR0frMo8sO98I0Vqio/l2XAg7IsTpc86RaUqKVCOv66REvdKYc2Z5ZcuEFVq/5d9uhfepfSy8CZTpUKEUiyfCsa8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606084; c=relaxed/simple;
	bh=du4ZhCLp6jwzz1WznFiWC20I7LWdN5CARyDoG5mPfUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTOeAMP57W9uan310W+xE87aT4WOE1pqzmRyaLhuRs/qunCaiVfq9Z6jLjnEMxHZR9BzUEIx0DHn56K4KBmlsYsAzDj/qAWG3NbZ9Qr0KTILgewmi+QapQd4hvCNu8qw/EWeJs+ZwP1Uj1ci96llqCGykynaZrtsFyI1ka/c7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMJtx/vu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-333f8f0dd71so40637391fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606081; x=1756210881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeH/5E9EduNToqMljlnTlRgquiWKLO96iiPG3OImUmQ=;
        b=CMJtx/vudOdYAc+kWgu64kHjCOQyCbb7NR2Tee/0CQrj42W1bIemk8WchLUNBgrtmo
         C96ZWVolF0kfo6UgxQrnzrfer2QF4LPXadWjhhGIHsrkbkO7l9hV3VI/cdCkKsd4srCJ
         YNyu95hgyj8ahat7avJY2pMHcAyAD3/gH0pZA69CcKx9p126DfJIteqp4nCHbzTc5umz
         5QbSRapAl6RNf/LBXQfd5aWOhxq9XbDf4Ri9HzjbcMtnJiE1VHqEtzDqEwot0gUQ46qk
         CndkyCYKAYjAF1/qLip5z3jyXvRxpB7MRQcnELUg0Ea9Rp801J2ocSSkuhubJImpmfps
         Vt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606081; x=1756210881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeH/5E9EduNToqMljlnTlRgquiWKLO96iiPG3OImUmQ=;
        b=ghW2bCNOeEy0GYE+jMaCQfSg9t1WxsAw7AUAx0HTuX3zivDFS3lbV8xoqFrp+5Act1
         tDtB1jTfrgza3k1b8jwyg8PoRfyEbkGnkvenBh2kkzAMad2fDrHACvhTGiDDXWJQoFH8
         43I3smveqlKL0M6P5mMaA3aNd/+KnHPA6DP/rK+ZMqjNWBQKulIC+8tY4EJC60Y+DLJS
         hND1I9tVRUH9hjbiYzKHNnOC+FbzErEwqM8mi0Irwj6TGtzZ6JXP7l2ysRceyQvbCCza
         W5yQFBVQ1U4Dgxx7DRQWBsSnmJB4i/L65BwRZwGS4wl/C4+baoLsKN+G84ZnTd9tw/Pd
         xLNA==
X-Gm-Message-State: AOJu0Yxand3QP+U0sTIeItv/18t9qPRir9ZS/4sZaxVF+/iOmS5TCGJ4
	cTG+PFKQB4Suxb5djRq5UsfLstrzkL2XuCe5FDyCHVNFiq5XKeCIUd+I72YR8Vg/Y5bed9EN++D
	X6V3EMj2Ei1t303JKMaVBEp+SDiT9WPC/SHsM1PxV8Q==
X-Gm-Gg: ASbGncsJRkx0Hv3LOsVTV6trCWwVVQAiu/uEDW874kF4w3Hi2crQvHM5gD+efmge98r
	hweBOISb5bOn34Oupny3+/DVCDBE+gMWM9OztlDhfTiLXLCrZZFplHJLcwCbxfiMlZW3xAhIADU
	CyEQkvq23s3Smx2TgZCv/kLW/swq8kWU7NojTWiouWEfuW4RUH+AJj06yVcPXn9Xht+BSuQQACC
	svnLCs=
X-Google-Smtp-Source: AGHT+IHeRrn6G/22XsZ1QiTrxbXODwTyBntlQVbiPlHb0TqImCDAlPIZxwjYQYw85X5R6vMRBa9HTIMznhFsXD83yrU=
X-Received: by 2002:a2e:8a8e:0:b0:32b:50c5:2593 with SMTP id
 38308e7fff4ca-335305cec84mr2984981fa.18.1755606081286; Tue, 19 Aug 2025
 05:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815022721.1650885-1-rdunlap@infradead.org>
In-Reply-To: <20250815022721.1650885-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:21:10 +0200
X-Gm-Features: Ac12FXxRmb1YwqQ6HwzM4AEiqQ6wLPibOkhxcYw04VdUzA3RJ_ksFtnMCiihScg
Message-ID: <CACRpkda2Q6UgmVjjCRkXUGPfo62SaOPwG-Bifwia-jYCrh5qCQ@mail.gmail.com>
Subject: Re: [PATCH] pintctl: STMFX: add missing HAS_IOMEM dependency
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>, 
	Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:27=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> When building on ARCH=3Dum (which does not set HAS_IOMEM), kconfig
> reports an unmet dependency caused by PINCTRL_STMFX. It selects
> MFD_STMFX, which depends on HAS_IOMEM. To stop this warning,
> PINCTRL_STMFX should also depend on HAS_IOMEM.
>
> kconfig warning:
> WARNING: unmet direct dependencies detected for MFD_STMFX
>   Depends on [n]: HAS_IOMEM [=3Dn] && I2C [=3Dy] && OF [=3Dy]
>   Selected by [y]:
>   - PINCTRL_STMFX [=3Dy] && PINCTRL [=3Dy] && I2C [=3Dy] && OF_GPIO [=3Dy=
]
>
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO drive=
r")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Patch applied for fixes!

Yours,
Linus Walleij

