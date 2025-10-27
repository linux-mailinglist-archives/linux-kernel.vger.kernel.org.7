Return-Path: <linux-kernel+bounces-872278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BEC0FCE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 424184F42D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A73164A4;
	Mon, 27 Oct 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW7Ys6fu"
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D33164B6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587671; cv=none; b=jnAWePrR/SBjVovrwwYGnZzJcExo/aJAICPNhiawqJKwQdMX5pl6bmVUi96wBC5jIS6OwKeW5tSH4ZQCNNaUkQ44/+2h4thF6Z0Z8BPurLEJPMCw7JlEshL5ugBpK6UXk3FKQuMsndoipL4+vn/f8gV1He0ViKrcTnFxHL0rU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587671; c=relaxed/simple;
	bh=NzZdOY46K/cXCbuZL5mOuRF4mEX+BvP5cuWOMDVMv1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq+Xrc3efenm1JR/2H30A6eeZZsG+BGRYKY4FZRQiZ06vCHmB9fBpubYmk7tsK6csRm+m9wKNN7kmbz7OWfOfwkU5BHiytNIUAp0/bx5/QTQPR2LCBlntWybe/VFkFbOWXOLbveaudAyKr2IZPT0OL0t9HrIviRzCJqswAxyIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW7Ys6fu; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e35e48a27so4972223d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587669; x=1762192469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzZdOY46K/cXCbuZL5mOuRF4mEX+BvP5cuWOMDVMv1E=;
        b=dW7Ys6fuQJ/OfgxrAhGCzTzWb4JnoT/k27bXZtdYc5ORqZrBRH7HQl5vfKxr1U8SIf
         hjL+9BzWEumy9jCScHpXPpGhxWea4+NUvSBB1RwIp8Qaf5sX42DYDgA15xxn3WCYSP3D
         d3UT2OrHEd4OmYJ6RoI/7ThvvEK4DSUDxV3Olmbrtw7lJs3OZPKiHQivyZtGwfuVyomj
         Y/Gs5qNj4Jk/IK2skQXJDOhj0E+VnfYKjEaSKWRkOjLKOQHGXORqIy5nH92j1iDGKQVp
         2ARhW1rHDbAR1voBuv2csYh4qLL1j7cXNCOLOcTcQTHCVdMpFYorzEcR3CLdwb8WKUTy
         TBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587669; x=1762192469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzZdOY46K/cXCbuZL5mOuRF4mEX+BvP5cuWOMDVMv1E=;
        b=p4NZAtVkt5E9N+/G47k+1N1GN5px01CTKKkjhxhxCpXQ7q2qISgSsWnEcIx2XR7Y7H
         xYjEFaqXSUN5qrgK9/tKFuifSXhgmAzNnj2SK9J0euLqfsoYSHkSKkYmS81yz4wIrHl7
         MhGLvUQl6neVcL+M3rm8NVBqvgVHwa2oGYJyR3AAZ//JxLvmm8PoTosv36ffLRH0Rj7w
         /zUnLiQFE8cRQRU//jpVlmq1uhazD11QcOzC0slliJukGmmrs1PkcSGHiHQwh3mhyP4Q
         R9+to12CZGZEGA77kmymQbGsyPFP/rLw9BkgGFEs6om6teM5RveekAxPJu66aL88de9a
         PMMA==
X-Forwarded-Encrypted: i=1; AJvYcCWSbCq3xzohEp1hvUBkQsP0btJ7RDfuqmGXb7+Eux3lfwJtDjgENsVQYjfIZeo+etK1k7HOTeyqcZWMmvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsoEmL3DmMfUz82XOG4dwTMD2xj/BXDjgPSRo8GwD4mxbc31G
	E3+gojM3qz+mSN/Cm7emcF2s7shLefO/qCj7GFCdQuH+91TsFFSh2p4byjtLqZ4gJA3L1I1WoS2
	PGatyr27AorQ3cVeiLuOSEHQWDNmHCBs=
X-Gm-Gg: ASbGncsmNO8TWHEdz3V2WW+Bqm3/8jmr5SXNMd+uA/QANSbEDO3pFRfFpmSZ+gVHeqi
	UE9IMUciCEfMDLXOnfpirJBZpiAG1dWTeZkFSkcgibQEIBOCLsURrFCsSztxmqXeG91VTxCuwRn
	FKO+s89pHPsWnK5hH8ja7XzPlQgRgbZo4X004bLq6jO9rH+RmwiVEQ73RpZCOHKF7lXpjXVs+Sk
	vE3vK7nYd+HFnocZCWCGPsChkPdP0VrauzBHJKW/Owtw7eFawUNQIs+JLAf
X-Google-Smtp-Source: AGHT+IE2jhHjqCkGDdKGqsiX9am1QsRUA/JalOQk0LiJJJ2IdryQKnnXMaj865zQeSCHfV+PSlsAcghri//T5UAHYaA=
X-Received: by 2002:a53:bf0d:0:b0:63e:2605:ebba with SMTP id
 956f58d0204a3-63f6b95cdcfmr540955d50.24.1761587669045; Mon, 27 Oct 2025
 10:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-tegra186-icc-p2-v3-0-1a50b526dd40@gmail.com> <c6eb8ad7-acb4-4218-9293-7ee532be56e9@kernel.org>
In-Reply-To: <c6eb8ad7-acb4-4218-9293-7ee532be56e9@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 27 Oct 2025 12:54:15 -0500
X-Gm-Features: AWmQ_bllUkrPIxLdGkz4quqxBqkw0vRHPN7XriNb1cvYmJGSw_0yDSZvh-TXVqI
Message-ID: <CALHNRZ-6Wp1k9zWg=B5xSt7n_9Fj9XchBq7qniKZtKHkHVouZg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] memory: tegra: Support EMC dfs on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:49=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/10/2025 03:09, Aaron Kling via B4 Relay wrote:
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>
>
> Does not apply, please check, rebase and resend.
>
> Patch failed at 0003 memory: tegra186-emc: Support non-bpmp icc scaling
> error: patch failed: drivers/memory/tegra/tegra186-emc.c:217
> error: drivers/memory/tegra/tegra186-emc.c: patch does not apply

It applies on v6.18-rc3, but not next. Your cleanup series caused the
conflict. I'll rebase on next-20251027 and resend.

Aaron

