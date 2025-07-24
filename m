Return-Path: <linux-kernel+bounces-744005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC3B106BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D2D16AB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D4239E9B;
	Thu, 24 Jul 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrYfs+a0"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74B238C08
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350143; cv=none; b=H8P3inVMlYm1aWHDmKugoZbRQ7WuLCouTuNdjm7QYIgr4Ame45En144ic7I2UInclCgXJk7Voy6+KHibJ9gF+pallLqQQ/k+i4lWyHNE9WveykXA/IuzrMFwHfdTpeEWpgYll59jAgzrM7fCgbcEbcRYLmMT3slhNFQqQAlOef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350143; c=relaxed/simple;
	bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/kuAknmGHsOkeP7igsca6oS+aII4mrbMpi3gttpCrHmd2vw3KEVfhHTjdd1nIgr/P08FT93AUPRZPe5s0rj0e1WQcSnPdXYm3ok7tgzWvU4pmRWtF6li5R+8+DHmU3D/BEVmYBi7AN+71s3nxUoysXm89/3ZlUaaW78S+hFRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrYfs+a0; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5331f409ed2so250193e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753350141; x=1753954941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
        b=HrYfs+a0+Dgtnlxc3BRSq8+mvuKyZf/Z8LPndEfLWEmzdkwZyCpOYF6dlt1Fa/Uokn
         9rUh197+dqQTXrRxwXhK/3CVigzioaw4mkUZuXeI+aODZPrnXJm1I2J4iFCkKavF4o0D
         o+xmc1lFQLE+Ig6LQYBPxZTcpyTQ28z/pvFQypgpw2HdLW9+1MsOUT02BPK2Yi9I0loM
         NdUBoxLivCnYg+s99mPV/kw04bgVe8BNq24gA3zYEGn3dJnmF6j21THPQ9kiy2hw1L5o
         libS7kRsRgq537sywR8wAorl3fgl8+fgT2CRYiQM/05EWnmwpHA2tVWD+jvlj/ErIAI8
         2fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350141; x=1753954941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
        b=g42gptp/l0e3hX7k6KW2c4PlVYTXg8NXafzdSWWyDzmgXJQwUeNg9iWitcrMOwD++o
         xWqNii+4sw0IJB8yO27RhJ2b+GfhZ8mIifd2lk5mM45BTetrfMxT9ajoo4Vi4B6mxACP
         NoAEiT5rwSecorrfxl/YyMvB/AAEizsHvuATVq/232fA9doJss+CaP6GRAdvq8B4ArPo
         67vPA5UzbdMeyWTrxUeh7GgYpS5MvE1ZhG+Ox4mVTAYs7AmCC3RPt0EqxD2HCDD70KcS
         jzdararYky6aO2l9dm+iQVd/sqQ9SzaInXfDsNrdkoIVREjTvDA+TZ5PSw7ISb4Lxq2b
         En4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWRF0m5XT1BPqnBcfTKigdc35MSrSRkAKCg9mWU4BPDe+dKlq/WFerNKZV/ddwRMG3bA+kva9i+jCeKfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/17O8vrhOjo7cVH/8b1dBAHetMRdj7QupivzouDU+ma3Xij8
	REn9Go8IUMOy8CmyHMn6TAl93+8OBPbkpCCosPKuLo3KIUmdof5eh7vemUvX0LyQlnBcLmMd5w/
	AZ7e+OmedhjmSFDO1FuPobhQDLwqh06E=
X-Gm-Gg: ASbGncv0SMNXkKEk5wKh0BKJO9gzjnbSGJe6h8e+iysnHiYF9fKP3lLF2UYFdSTVlRt
	xgevU3obxVI03A8i4w5zKrlUWX5o4Wi6mCBbuoILMdWWYz7ESZHJf27PrGY1f9USwlYi5iTKbPv
	R0M/RQ5If3nc8bXOVuY++hTx6IXfBOB5CVKR9IpZ72q/GW/z0vo/QAos/rZG0pt0UOJel02qyb2
	KPxiqg=
X-Google-Smtp-Source: AGHT+IFVdAR+nALw2dfOwe/SBdedrjFoxCZWdT3hu72WG7PbkJMjT24657fyC8JNSjqGNYeNAeujPq9L90HfMwrRt4U=
X-Received: by 2002:a05:6102:3712:b0:4f9:6a91:133a with SMTP id
 ada2fe7eead31-4fa1523a607mr2737239137.27.1753350140982; Thu, 24 Jul 2025
 02:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
In-Reply-To: <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:42:03 +0800
X-Gm-Features: Ac12FXyOhPCNOJmuHWV1Cslha1U4fTMs742fhuCReMB40zYcc2mUNhkN5PvOnwU
Message-ID: <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> > On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >>
> >> The padding field in the structure was previously reserved to
> >> maintain a stable interface for potential new fields, ensuring
> >> compatibility with user-space shared data structures.
> >> However,it was accidentally removed by tiantao in a prior commit,
> >> which may lead to incompatibility between user space and the kernel.
> >>
> >> This patch reinstates the padding to restore the original structure
> >> layout and preserve compatibility.
> >>
> >> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header =
file for map_benchmark definition")
> >> Cc: stable@vger.kernel.org
> >> Acked-by: Barry Song <baohua@kernel.org>
> >> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >
> > I don=E2=80=99t think these two patches should be part of the same seri=
es. This
> > one is a bug fix and should be handled separately=E2=80=94ideally picke=
d up on
> > its own and backported to stable.
> >
> > Also, the subject should not say "Add"=E2=80=94it should be "Restore". =
I assume
> > Marek can handle it?
...
> Ok, I will send a new version to fix it.

If Marek can help fix it while picking it up into the dma-mapping tree, you
might not need to send a new version.

Honestly, I hope this gets merged soon=E2=80=94it feels like it's been
overdue for quite a while.

Thanks
Barry

