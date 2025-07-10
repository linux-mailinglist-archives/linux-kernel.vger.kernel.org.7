Return-Path: <linux-kernel+bounces-725025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53BAFF9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E36580EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EC6286D55;
	Thu, 10 Jul 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X+0uBzm3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68F22CBC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129320; cv=none; b=DF6gUOUBCuuzDa0LSBuBe0qYKeF6mtuhhjQDtWQJtL5k2m0a9ifzfEFkP4m/58p7wTmZPOtqSOaQjnZRZ2hrbytRUSEu7LA4qCuMMoev1swdYj5eDKLL24aqBWqe3rxQu3Te8JML8qc3mhwvK+otQOidKHOPyeZYsQMD+FgDots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129320; c=relaxed/simple;
	bh=ElqAfZh2BVgxfhGm74ckQk9GyfGSk4GuN3P5xEeR6vI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Q8stPDNsdgCyeZDSa8pVQp/bIpdmpbVvV3CaKcMU4yyGUk58JueFjs+wR0wn8eY5KLb5nqMso5GIqgz+9Ofjf8LRu79i1YtN/+kPduC6bxb3wMIk721NE2FzsAxc/l3RWtcdnOUEuBvmC0apgi5fNlubrp4l3acisjgbwPfYgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=X+0uBzm3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso86264f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 23:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752129317; x=1752734117; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyhfcIGHykgvkrP2e/H7VmjAsjt0CsIijqEuhYmyjZA=;
        b=X+0uBzm3bi+AK1j8teGJm62HTgg3xswH/ObRCwbigjCBub6q31LIs/ErO+9bVytq0L
         V9UCRLl79uiw7COf3DiGJBbUvfGByyNGZPUGiaicMVFsFQ5eXV1EyTpfXUwH9WmKbSeM
         nh703dBsvxKH3lTYadSAcWn0ASS+7t3ObCUB71PlKHVTsaDw+49Syah/59cHUfUfcl2D
         uR40EpftrwRos70HsLyOA+iTOdWsNfoDmnLPzSbYLRSrNVr5j9RzeoW3OUbMVFK0u4t8
         oRq/mzhJtHedOdhZYlWanarZid56shttN2rcHTjcmfu62l9w1JzPl1B2aV4KgNRznX2m
         HUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752129317; x=1752734117;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kyhfcIGHykgvkrP2e/H7VmjAsjt0CsIijqEuhYmyjZA=;
        b=a19PKSD60LzN7PoxNH7wuRQ2EYY8t8mdwwXT4ez2bNh/6AlpvZgVuRkta0bcPj7Wcy
         HKyp+N82czgWWMMsT2gddQAoRGeg91e9XISYoP9m4kGlEjj8uyYKu671j36Kkjbsath7
         3BEfT4OjcfZVPOqEvbY3R4OTecneui7BGroot2IWaFVDbMyJCzuZR5rZMfK1z3cQ1LxA
         UmaYDCj4HDd8agFqXceR3uKP6e/E0GuhNMdv1fYaVYyolPg8rKJ94tzsAdg/F5fNmnw9
         Pfmn1nPNZrajmZZHqawESJVxJqhKuA5q2fimRm5UBXLcVxc71yliotAs7gAl5Vhm/Zj2
         YBMA==
X-Forwarded-Encrypted: i=1; AJvYcCU6MB4z9lsTdFUkwFQAsWRPd8Z0V/jRu6klnOA3GjWSjbcZZmG1q0cN1gvVAtcEzALsRsNjPPOj/mkal4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYoLbpKD8jkaqmYcAD8T+9vHFJtrQQqNZ+j+e8L3Cmp1AaFJh
	CxUn7MYIya1WtSj9Au440SZnu2QrnY11vufVgBLgtUnvl5I9lqvmqC7TMYmPERhCorU=
X-Gm-Gg: ASbGncsY9dpdJCyvYBn9A/0tQOJYzzPWgjqcZa/61RL2ISOzq007g5bWd3SvWxNFjT/
	Z4p0N//l06Eg86+UhqOaE1XHzM2H79048VLMDobhcGzFUXQo5m2E89zf8pQn03M3w7qAW5A9FOB
	GJ8BhTme8NpoNFTW4cifWF2S0NoRBeg5+o/17VgT03zzEA1iFLCGmTtQYBS47g/n8GH36KlXp3e
	Md+fgoy69MVAZsMDOmVLfYb/Nb9jsORFGacLCN3SWvRviBufSe37m+nmLMUxoZBXD9cccLs2QE0
	qMFFqKt65mfw9UvdrnrejI1YWO7uPS2FGJbjPYJbrtFpya3K0mGHfEWxIYtxZzDo7aOR9fU9+H4
	JQKbuJX7yBlkbp0Rb1VMYUA==
X-Google-Smtp-Source: AGHT+IEqEitaMgB8tObGyqBHxc/XW6tkIZ1LssQgO+WUWZXRaXyhTeRPn6KcRlFtzKo7i/2kYbIvaw==
X-Received: by 2002:a05:600c:3584:b0:453:76e2:5b16 with SMTP id 5b1f17b1804b1-454db9090c3mr7110435e9.0.1752129316466;
        Wed, 09 Jul 2025 23:35:16 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cdb381a6sm57354855e9.1.2025.07.09.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 08:35:15 +0200
Message-Id: <DB8607ITP9UR.2LOW61O3OVJ2F@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [External] [PATCH] RISC-V: store percpu offset in CSR_SCRATCH
Cc: <masahiroy@kernel.org>, <nathan@kernel.org>, <nicolas.schier@linux.dev>,
 <dennis@kernel.org>, <tj@kernel.org>, <cl@gentwo.org>,
 <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <alex@ghiti.fr>, <andybnac@gmail.com>, <bjorn@rivosinc.com>,
 <cyrilbur@tenstorrent.com>, <rostedt@goodmis.org>, <puranjay@kernel.org>,
 <ben.dooks@codethink.co.uk>, <zhangchunyan@iscas.ac.cn>,
 <ruanjinjie@huawei.com>, <jszhang@kernel.org>, <charlie@rivosinc.com>,
 <cleger@rivosinc.com>, <antonb@tenstorrent.com>, <ajones@ventanamicro.com>,
 <debug@rivosinc.com>, <haibo1.xu@intel.com>, <samuel.holland@sifive.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>, <wangziang.ok@bytedance.com>
To: "yunhui cui" <cuiyunhui@bytedance.com>
References: <20250704084500.62688-1-cuiyunhui@bytedance.com>
 <DB5U402ARSEO.4H4PE19LGCR7@ventanamicro.com>
 <CAEEQ3w=V6-d+YSWP=0WMt6UAZexrazq0UQjdyUmS3AnMtkdoKQ@mail.gmail.com>
 <DB6MLPA3BJ75.2U5FP5JSJD2LO@ventanamicro.com>
 <CAEEQ3wkoy3Jr0vZk=X4U56KYPq3=5t7Wr4RE6uNby3MS5qzh-g@mail.gmail.com>
 <DB7L9ZHZI3AI.36SXWX2SO9OS7@ventanamicro.com>
 <CAEEQ3wnaL5X_jXEmbbWFp3jx1Aq=02Gf7kDNBS=wcPyfEq7yBw@mail.gmail.com>
In-Reply-To: <CAEEQ3wnaL5X_jXEmbbWFp3jx1Aq=02Gf7kDNBS=wcPyfEq7yBw@mail.gmail.com>

2025-07-10T11:45:06+08:00, yunhui cui <cuiyunhui@bytedance.com>:
> On Wed, Jul 9, 2025 at 10:20=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>> Is the overhead above with this patch?  And when we then use the
>> CSR_SCRATCH for percpu, does it degrade even further?
>
> We can see that the percpu optimization is around 2.5% through the
> method of fixing registers, and we can consider that the percpu
> optimization can bring a 2.5% gain. Is there no need to add the percpu
> optimization logic on the basis of the scratch patch for testing?
>
> Reference: https://lists.riscv.org/g/tech-privileged/message/2485

That is when the value is in a GPR, though, and we don't know the
performance of a CSR_SCRATCH access.
We can hope that it's not much worse than a GPR, but an implementation
might choose to be very slow with CSR_SCRATCH.

I have in mind another method where we can use the current CSR_SCRATCH
without changing CSR_TVAL, but I don't really want to spend time on it
if reading the CSR doesn't give any benefit.

It would be to store the percpu offset in CSR_SCRATCH permanently, do
the early exception register shuffling with a percpu area storage, and
load the thread pointer from there as well.
That method would also eliminate writing CSR_SCRATCH on every exception
entry+exit, so maybe it makes sense to try it even if CSRs are slow...

Thanks.

