Return-Path: <linux-kernel+bounces-821949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C4B82AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F0F3BBFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC55225416;
	Thu, 18 Sep 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYMIp0ty"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838B23D7C9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163514; cv=none; b=nJYcpmMPC2gA3cWkMHNK7EOvDOQ4cIFTw51WuJ9npLbasjUxXlgVdbKVy+jQEDfKcmrLDK2BQu1WgCQr1yQZPo84SiE8xrQflLhCPgPl298iPLvI1xhq0kP9IqFK/MTiGICDcLmko8KYG6dsH2gXWcglnp/1aPKfslxX4VCEW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163514; c=relaxed/simple;
	bh=J+MWoUKVfhh0snrSUTiNn9K7NIDSM7/SRpkDLL+TJX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYoAQqH6RLj3lZdej8vdCgfWyXJAul35NQY9JP95cFYo1x4Ra+sWorRemrOfILwVrb9HtKUW32O3D6dolT7MDs63rBNV2ZnaMrjv47EkvqcdHZ1+Kn3OnXfCBwpkwGGhQLPob/rHXOivGhaY471/pc68Y9WIkTZxBd1mRuLvd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYMIp0ty; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7abed161bso5701771cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758163512; x=1758768312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuZ9j3HCJ3WAla06YidRhhDL/e63d/UFWpY4b514TQs=;
        b=HYMIp0tynfaKfCYFDPp6STBICdjH96aBD6nJnjjirO8zklW746dnQEU8ufMm87D6gN
         dxT0rnX1y5CzGTWixkVLjDq9qABx2LDksva9YK9cGuTpAPdbUK4+CUMDK/IEcbYn6SNB
         w2iglbPiaDQDTzYhZ5v+wlhN9v9hHqIugsgtp39C1/pk5Prcwfpnom6HDKDPXKIA83RY
         n0C7Q5KHxPU5AaGrHD5+JQbrwm6xWMGBDc8Fn3BbTbHTfhmT2vBdZxFQk/srFYMMv+jX
         Yy+id4SXQ2bGP7a3VXZlK+MUa1wLveChTbM+OvpIn7dFW3fFyFTC2jK0B6A+uqFom+S+
         ND6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163512; x=1758768312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuZ9j3HCJ3WAla06YidRhhDL/e63d/UFWpY4b514TQs=;
        b=PppmXsPnmnd/huGRd60/aZ2RRpZrELl3NnQoAh27Jj2TCI4UsyxODb7gsslCbdFnRA
         B8S13iNOAm8P/bTbwaDox5XRlka+z89n4oDcz9D2CwRUepB9NAuS9LkgTDH9p7cwzJGY
         xN1TXzKDVN4ArdvC731S8nfZlje5M356zTYCQNl+PtUWX6vlzTk1Kv+jBSgHmsNKrYZ0
         gxL3+zgaehyND3GlFxEbrJ1i4/CZ7gXmceQ2mbRukuTx6XFRmAFzI9pXqs0izvUnGIYd
         +/UK0ZcvccbtdQoGUxOlohikjMK+tD0pSmhCHlzIFJeDo2y5J4TuaUr4UwaFwPUaggtO
         ahwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCUvaJm+iTk+oMeju3NeYIWuFvBFL1DCo5CeEP7Vm+XF6knGv678W43vG7YyRe6H4LnIQ1EthGX+TN7TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0c8A0MlQx4JS9/hNwr1XQmGaUrC5gd9H7WEKAXUvoxqGHKkD/
	oMHhcl/RtjJPVVwuiQIM/1N9DgGTdBHx2EFsxgIbnsLbH/12Vx8YAGMlqRHBB8oVNL4bIarBvzT
	/XLKCkzKnv8iytDtB/JMzdG4tXqwzvc4=
X-Gm-Gg: ASbGncvttxUnajVCfMlMm3O0oSxtjEB2ghajUyta+jHtQ3LBniCZ8RFnle21FV2qFol
	Sior3x8ukEtQQQR8LufSGINBUcteVV8GxZMIktboJ/SL3ICX1oLCnSs0bpWduwUjKyDzoDlb/+E
	JzbIZw5wnLLiv2P43Z2gCyiW/TMbeoYxlhEq0wsdJjtq+vg+7taG3VAkin5dBLpYH8ug8VPFd5w
	P4jsc8eddVU2GtXCxMzvshs3yw=
X-Google-Smtp-Source: AGHT+IEFTcSdZt1DQsLSH8OADTsF1wOtd767iT4GImK3n6wMmQ/SMPr3tSRNKQNgO9DkEQdsO9Ae0+IGNU5FqH9fwT0=
X-Received: by 2002:a05:622a:4814:b0:4b5:d932:15c2 with SMTP id
 d75a77b69052e-4ba68fbba88mr56521591cf.34.1758163512136; Wed, 17 Sep 2025
 19:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911095113.203439-1-sieberf@amazon.com> <20250916140228.452231-1-sieberf@amazon.com>
In-Reply-To: <20250916140228.452231-1-sieberf@amazon.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 18 Sep 2025 10:45:00 +0800
X-Gm-Features: AS18NWBAWJwd4iL7mK8PlM424T162DHKQTcoBeRQzdewRb2hCmxlwKPY2wU34Gw
Message-ID: <CAB8ipk-zK+T+8NTnQzYex+CFpA3vaeLuPLJ_vyJpKi4MSem+rA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Forfeit vruntime on yield
To: Fernand Sieber <sieberf@amazon.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, bsegall@google.com, 
	graf@amazon.com, jschoenh@amazon.de, dwmw@amazon.co.uk, wangtao554@huawei.com, 
	tanghui20@huawei.com, zhangqiao22@huawei.com, linux-kernel@vger.kernel.org, 
	vineethr@linux.ibm.com, Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:33=E2=80=AFPM Fernand Sieber <sieberf@amazon.com=
> wrote:
>
> If a task yields, the scheduler may decide to pick it again. The task in
> turn may decide to yield immediately or shortly after, leading to a tight
> loop of yields.
>
> If there's another runnable task as this point, the deadline will be
> increased by the slice at each loop. This can cause the deadline to runaw=
ay
> pretty quickly, and subsequent elevated run delays later on as the task
> doesn't get picked again. The reason the scheduler can pick the same task
> again and again despite its deadline increasing is because it may be the
> only eligible task at that point.
>
> Fix this by making the task forfeiting its remaining vruntime and pushing
> the deadline one slice ahead. This implements yield behavior more
> authentically.
>
> Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  p=
olicy")
> Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.co=
m
> Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.co=
m
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
>
> Changes in v2:
> - Implement vruntime forfeiting approach suggested by Peter Zijlstra
> - Updated commit name
> - Previous Reviewed-by tags removed due to algorithm change
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a14da5396fb..cc4ef7213d43 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9036,6 +9036,7 @@ static void yield_task_fair(struct rq *rq)
>          */
>         rq_clock_skip_update(rq);
>
> +       se->vruntime =3D se->deadline;
>         se->deadline +=3D calc_delta_fair(se->slice, se);

Need we update_min_vruntime here?

>  }
>
> --
> 2.34.1
>
>
>
>
> Amazon Development Centre (South Africa) (Proprietary) Limited
> 29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Afri=
ca
> Registration Number: 2004 / 034463 / 07
>
>

