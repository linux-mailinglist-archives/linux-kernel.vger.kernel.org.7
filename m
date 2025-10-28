Return-Path: <linux-kernel+bounces-874627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01975C16B93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A94344ECE29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3E29AAE3;
	Tue, 28 Oct 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtzpyKI2"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101C18626
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681938; cv=none; b=G3EQAvLq+Y4hfSmSCHsYphwavDdAk15wWt2Yd4cjbqesqGlZzLI5cRNknkNeL5qZ0icanzMn7i3rilRzAN2J7swgtvs5GiUvarlUVELjNt1xZ6jbmIElXvh4Uon77Z7d5HlJEDi/HlFojbmr06h+bX0pDM2rbQYiLmf75wcNpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681938; c=relaxed/simple;
	bh=RE8l666OslKiw8gc6zJvDdDt1fG/Po4O5Rf3gpizOQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE40j+pMb7u9sSENIBXPIJl4xPvDfuHgE9iO3JT9sRJJAqFtOYr1OrRxZ9d4FyfDr1qyRyLHuTU/N4QEZtMPEHczyjrsCySQgoyVpvERIoN1aDkvljkVIFaev23JQxBBh1FyvWAOhrjIWKpVE4vWn56rWCbAqw/UzDQdsBO/cA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtzpyKI2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8906eb94264so749704485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681936; x=1762286736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE8l666OslKiw8gc6zJvDdDt1fG/Po4O5Rf3gpizOQg=;
        b=MtzpyKI2F2JkB7xqDYbTxkGwKwyZR84o/g/GQiKf4wiXxyJOU84v+AZrA+cNf0mZSS
         1J3bevq2ZwITIfNEuUuQrBn6ZRqazZQzYkp9yTjmuJ0fmyZi0LHwcibjq87ugS1Mmo05
         WLHeUWKfX0OI7Iob/NQgb/140VbApj+82ucWiLUEtsboIEXH32jCYwCumhbzIRDOHzqb
         BzTekLD1kA3oG1k810im2HCDi8wmFgyuHGs9SOcS1Wf5JlMRGTSmds6hETDl6IouCpw+
         STb7v4CCRccXSUH8zG/w1Ql9xmhL04PHBr5OIPfGo6U3uj3qkuy0aky2T8lDnj/ApbP+
         9BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681936; x=1762286736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE8l666OslKiw8gc6zJvDdDt1fG/Po4O5Rf3gpizOQg=;
        b=YE2w9WYX3Ew8RQb55T89cBe8g/Gqrwlbh2g9GPtFBdJWWffUHPYLX9kgrX69RfNar0
         mw72J3kr99Ragc1GoGw3nT/DFwz3Ox/1E3DN9isUHurC+UiPL5IXXEHT2dLCrJkZYz4+
         /6aT4U0NEKGNkDr/iPbNL0yffzP0vzIOyKqAua4SvLLrfCt7Hnth7PKUeaMA49yUtf1H
         62z2gXxr7OJ0tvJq16N+4/AH2ptF8PozqDx8y3AjRyxvuGFhVW4BpUgHDbpgIl1RyV+o
         Bwnb3yv6BLWKREoeSoyT9+IEgL8XAMyKLKvKD2kipICp88IF8T6xgA6lc/qVOwt1IMGO
         iwyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqxPrKHpePMki3qT5NCOHXJd6fKw/vOJrWDEYCu2Qrq4KZyiY8bjWJgTr4tuPDQncZR6bNNYsu5fO4mic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDT5Mk2jeWTD78neunrVMkE+qnbPk7HmofKsMtRZ7lL1VHQ91
	epJLXzam4C7bGOzcLjzAr9bl7YqndwZ6+8u9AprScSj1kiuASa6iLnjSp1W9jQKRPIFi0uFP2IB
	uqvFFKZtMceInHLzbtV0iY8rd4cbDs5U=
X-Gm-Gg: ASbGncvvZwpIxph4sP62BYxjDkC+B13K07aLAnOjx/RPQMBSNcKP3UsKqtzZSpdrNKl
	khTkUALb8LQ/MKm6cC6jjrCvyIEtJUtkr2CvCMcYEcfj9ntdkk+i24HGIWG1zcORa8ioAPYMEck
	645RcPsXU3Rt6SGg/oia9q0SYWsBShLYArIQbBycevJXIl0u/RlMBCajVOqo4hQdBcViywxFN7d
	WW5oi8GbnDlaE7JpChCl+a03AxVC3xy+cRe/AKpn+BnuoGWzG4z5/APhui5EA1Dee/mVe+GDe5E
	OU4r0EkqPF4tk4cx
X-Google-Smtp-Source: AGHT+IEb4AQBT6FR6qX2lruHtKq4fGe1cNrxtCgHTiKv01Dk5uG0BAKLnLqi8/IKKVhh6vXCg8tl3dbcrui7sYBXNbI=
X-Received: by 2002:a05:620a:2915:b0:8a1:21a6:e059 with SMTP id
 af79cd13be357-8a8e3d938e8mr83350485a.29.1761681935801; Tue, 28 Oct 2025
 13:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028120900.2265511-1-xiaqinxin@huawei.com> <20251028120900.2265511-3-xiaqinxin@huawei.com>
In-Reply-To: <20251028120900.2265511-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 29 Oct 2025 04:05:24 +0800
X-Gm-Features: AWmQ_bmmSd-G0e1sY55QTF28PTzbBN916AZxdfjcBb41cpGFyhhKHmMjnJBSLI8
Message-ID: <CAGsJ_4wGX5TdzmCU10eVk38XfFVmkE_hJLO_iqfxyMA5zfwevQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tools/dma: move dma_map_benchmark from selftests
 to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:09=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> dma_map_benchmark is a standalone developer tool rather than an
> automated selftest. It has no pass/fail criteria, expects manual
> invocation, and is built as a normal userspace binary. Move it to
> tools/dma/ and add a minimal Makefile.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Thanks!

Acked-by: Barry Song <baohua@kernel.org>

Barry

