Return-Path: <linux-kernel+bounces-808393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0898B4FF32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4588617E5C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1C345734;
	Tue,  9 Sep 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaywNOKr"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95263431F0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427672; cv=none; b=M4M8YuIXgRbYzXyN5fKFLHfUiktHOAmAYPc4seWwJJO7wzwSJy7tBn3yugrc94eFjo6thGVr17UCMnEEoixm5uQ2zBamvOBRO8y/tKFavDZLGZilc8n78V+38VxmKspUy66Pd8uskxQ+9Wr7+BQBL9AVEL/6cp9GT/0PTiX8JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427672; c=relaxed/simple;
	bh=eFaz1FbjLOe0auzFVwB/pCvwCLOzZfD/UEis1KyqCNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCWkZVHNWKPR8/lWfHEDCzQ4+h2mRTh1P/xC7hqep3Mg1XqAiF33ifDp7ZjdiYoZmLq2RL8VRvDfEqDh/oRpjiMreOeiqESR/FyPQ6a88GL1vutNGGKQbmt/VSlaiVj/ZxpaAw0RlJvQWQ1iaDcfN6GM5/blIivWhl0UfgZBHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaywNOKr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b522fd4d855so1966037a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757427670; x=1758032470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TeFkN7fcGow6PeEF+7elJ3SB1YToe/OnzJcgFoo4gE=;
        b=kaywNOKrPa+njj05Jt0B53qz1ZYhuhtB+JA+tQ8wTdps17G3HDp6sTuIoQzCpc4JGz
         R84AEsrpjn49dR+q47Yg6u/i3wCfJ5uHlh8bNQEI/eUqzdu+51Q4xpir5aj44KUysKKX
         XUET7XsELXWyK1xXXHn3s/PwfxYXL3/C1rfyvPIi5jQtSvB+n7/kS+ugCtkfCZUtcCZx
         mgI7vN5loo6rcg2Z4ppikoif7KLJr6ctpZM9ZzOlQvw0YcLd1JuziPVWVl9BjpV6rAsY
         Rv3HPXAurBJjc1+LWD6cDTr4VvlgbUidhCnEfN90gUR5TGSUnK+yOfPhBac/hizwFLtF
         /LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427670; x=1758032470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TeFkN7fcGow6PeEF+7elJ3SB1YToe/OnzJcgFoo4gE=;
        b=Zjl+SCBDv0fSYCmwdbOG4kOpx/Wu+VCtLi3IR1Mm9Sigl7EwDj/CqH1MAdlB5PJ15F
         nvWtB9/+CQCNB3+CojRj/jdJdhHVvKO2RUPbXlCgGue6qgkXvD0Uoc141xbB7rYq/mub
         HmTQFgkAhiRMZN8Id3cf2wyU3cIo82j7gGGu6cH7cJW8/UY3sW72Y7ECNWnxA+wCzI5q
         YXSGdKCtmKHpu+56FM2Y+fMG1PIxoLK50Wh7msuW2twCw3CmCS9jGqXHoAXL6k0+QPZR
         9NaHi+K8R6gy9qyGrxhrENntcRD6nFLsxCbL79VbHIZ5Z5H++SOJAtIv8N3hE6fV7hE/
         0G2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjk8vBau9UxIbCNL99IgZKz67+1ZuaU/g2GLptJ8kPVX9ECmuGG5mFVNFlcDnhIDO3SpW3L6g8FQaM+HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/1P6S5CZUWNYjX20FU1ei9RTw8bXxp5gukt5QFbzZVmU3h1z
	b9XR6sBe1R4nVCR1uLJddxzcmZ5uPC5jWqtvXCChlUfSkSNL93EP2XWd+/Be1IkYJlqBMfRWw+B
	ZYJJDBf8xPneWdJxTTRob2/x6hGIV3Vdpu/E4EuvxHA==
X-Gm-Gg: ASbGncs+/LliQ2rBAFvTf/A2cdmMXrm64GgO/8Z1uqWyuUc/fl5nuo9LwyRmn0f2sP0
	cenmX67O425m8VRjVgxdFyLaNyBPmPv2WCZEGyEbUDorjkc7YS6P+2UXKysaCpj3b841Ba0Bm9l
	ZLMheu9A+AS6KuUQRsU7NBhlzevQ8ASJ3SGsSX14JSTseP7eOwu2Cd4e9Js8psh+heWU1CRf+wf
	TxFZ18F5pFQ1SSBoLC0KZFFalMsPp/hZ9UdaCXdu9YS0TsIUMcAKswBZiIeLRT2J5NYjQjw+IkB
	Vwif6Uk=
X-Google-Smtp-Source: AGHT+IHcxqQ3MwYg1e6CBranmjT3hbA3KQEdh9KM+28JVgj+Ob7LBa6ks7tZBX8uSiN8HysQ5OLuhZIp+UzO70D3LVY=
X-Received: by 2002:a17:90b:5284:b0:327:ba78:e96e with SMTP id
 98e67ed59e1d1-32d43f09a68mr14437698a91.13.1757427669481; Tue, 09 Sep 2025
 07:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195601.957051083@linuxfoundation.org> <CA+G9fYsX_CrcywkDJDYBqHijE1d5gBNV=3RF=cUVdVj9BKuFzw@mail.gmail.com>
In-Reply-To: <CA+G9fYsX_CrcywkDJDYBqHijE1d5gBNV=3RF=cUVdVj9BKuFzw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 19:50:57 +0530
X-Gm-Features: AS18NWCu9Mz3BICbrj4i65CQRhAEXwjomJBkbcBzM4Smm39VCPlu0yA5D9Oglok
Message-ID: <CA+G9fYvhLSjZ0ir66wDK2FCbdToK9=+r_9d4dfrMA6vuxJErpg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/52] 5.10.243-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, Netdev <netdev@vger.kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 23:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 8 Sept 2025 at 01:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.10.243 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.243-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> While building Linux stable-rc 5.10.243-rc1 the arm64 allyesconfig
> builds failed.
>
> * arm64, build
>   - gcc-12-allyesconfig
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
>
> Build regression: stable-rc 5.10.243-rc1 arm64 allyesconfig
> qede_main.c:204:17: error: field name not in record or union
> initializer
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ### build log
> drivers/net/ethernet/qlogic/qede/qede_main.c:204:17: error: field name
> not in record or union initializer
>   204 |                 .arfs_filter_op = qede_arfs_filter_op,
>       |                 ^
>

Please ignore this allyesconfig build failure for now on 5.15 and 5.10.
Seems like it is my local builder issue.

- Naresh

