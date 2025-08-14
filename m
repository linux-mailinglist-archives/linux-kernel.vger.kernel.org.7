Return-Path: <linux-kernel+bounces-768949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CDB26843
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076D01BC533B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B08301460;
	Thu, 14 Aug 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZM2pHbT"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21413009EE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179551; cv=none; b=Cky2I85szpDX52/CfdeZJIETxs5fUTzWb5xoAxb6GDb8Oh8iWQfEINlCYaAVyz2VYKgngRGAuG5H3l27GHkN3mJIXxpKYjMDpOlye6C6wfoizfm+tOMhtxLM5YcVQiuAsFbRGD5F1Tnngu48GdX4rHeHeTi5eAy/4fnYk0IZk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179551; c=relaxed/simple;
	bh=AuSxpcvb7DLJUWQFOJ9pI6FfZFF9U7z3dCclw46zCw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0d9VH772e7TM5Sj3m9ldSrhNG1zyu4P/b/kSrYEaZ4xPO0xt7LAeHzlpSB5fpVMecyl4BaQgUBjEfeBDH+0dIjEbzWQRat8IpQMNaPeOrfjK3qqnn3cg0gsrFUo/QMpAeTc0AmT7dkCsMm8OPqCdWAstrqQr5ZQieHPAlGEeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZM2pHbT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0bf04716aso266891cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755179549; x=1755784349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw1gbTTEoFVJTMKqMiHJHmmtmv0E4fqdZ5KeRQQuZ4M=;
        b=3ZM2pHbTgHTwwfldM0M1qDOaBa2aEOIRg+4wg65BdesJAAZUdPxFwPZ8w+Kbr6cD8N
         b/0L90hvxtk9m17Jt5UYLHuTR4jxAazlWZAFr7QxHB0QsKUrRRIyN19VkTG+VFGmthsI
         70yi1jP9ZyxoWR2tjbhOoo3ApijCSrZxQcqrSuHyRwTGT9DnYRRZWRkKQbsF6fI55O7G
         777a8bzJEQUAKNjp3+RZfO27/tP4Rbp3xG++qZbhwoFSr8JYflVTB4a+/sngmJGHdDDC
         lSoPlfFg1jxNS4G+UsrkIs8EP4l9HjENgUUxBHx9me4KJfQNUx4myj7L+QxmfZZz+eTi
         kf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179549; x=1755784349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw1gbTTEoFVJTMKqMiHJHmmtmv0E4fqdZ5KeRQQuZ4M=;
        b=JNQDxqW4OMqCWH3sNbrkyIPqOwg8i2WEt5lU7PrGf2YK2OQEuvLjdAHoKkO4zOR3fm
         hiILAQ+rniF3Ni4JvLZsVavtwnhiDI54fe/nkanpnySEpG0BiKZX1ABx9OJHRCXoB5Z9
         uTFEdCDBb5Zlgc2xJa6CTYuEKnTwEDSeFR1g8MsqrB95cBhl/R40ous5BoQ5WuS2TBsA
         9g1jbf1KBuk1PKoKWUALEED/UsABC1AoRKfwVjVHriu6yMdo9hiin2uoXw3ozbWBWEc3
         k+T3RteYGxNpYXahy6iSvaIYymrhHOts6OhLjyHRtCpNCp+llcXPqYxHyU+xDilawkU9
         /g/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQmU0eFa0G0ZePNviTlRQuPVNFVRyARxrWFt23htW1zGNmen1byETHubc5d+mUsvElOACev19K1747wi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYcB0qf+MBO+Q2d5PRo1JR/25Oobxk+tflfYt1nGahdyyTLOr
	bR5bo4ks1ijgtXw+SPmvIACgkj/AMpVbxP3quOzafPJf8gYxtt/Y5iOBy8yCsptmWGwMFpVMg1d
	g0Fvh29A3I3qqKoHU4KTwlXBwPh1hDOdMG0Ff18BW
X-Gm-Gg: ASbGnctdQnBx8ySToO1/b0oXF/7Qc3nApSGak/DUemDgUC1632vnlfCUmp/nvl39uXb
	OXlo68UQjcXcn8OZzeJitdzTRAi8CLe+K/2MnEIGcVhE22Bq0q/LjmAgpdMAS2nbwUS7uloc3TS
	6X5fGJCU8PWhg8sT2HZBMvJajetG0F7lKtjdtb4N8nQDeuI8ep29QrgyIGxe09w+OwuB9SLIrmx
	cSeCaltCGEKLLFqWjmtSCX9
X-Google-Smtp-Source: AGHT+IFxCDaMIGSe3pZulw+GZLKqDhTfgI0QVOHcpZbnMzUJvM2n9+s+0HZfSWxvk4YSxiK5Ve0UBALAMOQ12E7m2ls=
X-Received: by 2002:a05:622a:7ac9:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b11648166emr751351cf.15.1755179548355; Thu, 14 Aug 2025
 06:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508142105.Jb5Smjsg-lkp@intel.com> <aJ3l0Te5Q1d4g3u-@google.com>
In-Reply-To: <aJ3l0Te5Q1d4g3u-@google.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Thu, 14 Aug 2025 19:22:15 +0530
X-Gm-Features: Ac12FXyU5mWkZ0SgOCtUvtEQ_v_nO7Y8OIQ-eUV3qn2nKOwscpdgvvk2Hwf8ewQ
Message-ID: <CAN6iL-SXvgRGSmUQ2-M115_y_k=cVCH3M3UATO7SzC8vMV3T9A@mail.gmail.com>
Subject: Re: drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:
 sparse: incorrect type in assignment (different base types)
To: kernel test robot <lkp@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Alok Tiwari <alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:04=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Thu, Aug 14, 2025 at 09:21:50PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> > commit: 32b2d3a57e26804ca96d82a222667ac0fa226cb7 iommu/tegra241-cmdqv: =
Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
> > date:   5 weeks ago
> > config: arm64-randconfig-r112-20250814 (https://download.01.org/0day-ci=
/archive/20250814/202508142105.Jb5Smjsg-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 3769ce013be2879bf0b329c14a16f5cb766f26ce)
> > reproduce: (https://download.01.org/0day-ci/archive/20250814/2025081421=
05.Jb5Smjsg-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202508142105.Jb5Smjsg-l=
kp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse: spars=
e: incorrect type in assignment (different base types) @@     expected rest=
ricted __le64 @@     got unsigned long long @@
> >    drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     e=
xpected restricted __le64
> >    drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:     g=
ot unsigned long long
> >
> > vim +305 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> >
> >    297
> >    298        static void tegra241_vintf_user_handle_error(struct tegra=
241_vintf *vintf)
> >    299        {
> >    300                struct iommufd_viommu *viommu =3D &vintf->vsmmu.c=
ore;
> >    301                struct iommu_vevent_tegra241_cmdqv vevent_data;
> >    302                int i;
> >    303
> >    304                for (i =3D 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
> >  > 305                        vevent_data.lvcmdq_err_map[i] =3D
> >    306                                readq_relaxed(REG_VINTF(vintf, LV=
CMDQ_ERR_MAP_64(i)));
> >    307
> >    308                iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ=
_TYPE_TEGRA241_CMDQV,
> >    309                                            &vevent_data, sizeof(=
vevent_data));
> >    310        }
> >    311
> >
>
> I assume we'd need something like the following (untested) for this:
>
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -303,8 +303,8 @@
>
>         for (i =3D 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
>                 vevent_data.lvcmdq_err_map[i] =3D
> -                       readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(=
i)));
> +                       cpu_to_le64(readq_relaxed(REG_VINTF(vintf, LVCMDQ=
_ERR_MAP_64(i))));
>
>         iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_C=
MDQV,
>                                       &vevent_data, sizeof(vevent_data));
>

Running `make C=3D2 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o`
seems to remove the warning, I haven't tested this on HW, though.
LMK, if this needs to be sent as a separate patch?

> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki

- Praan

