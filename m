Return-Path: <linux-kernel+bounces-816900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D48DB57A39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1253A597F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4C2AD11;
	Mon, 15 Sep 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shoo21/C"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B323D280
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938659; cv=none; b=reOhIQDA/TFvZy4hzramK9lvUnDoURoHXC5ihV3bs9+sjB8U5sddcmusU3Q1izOJ988Z00w8Yh0f4LJn9hTUYvKVZM9S91u8ak6jc4ECa2nxrntXOtcNRSqeI0SOqPdmy5q7oal8IGEBohdNludbAhjYSutsNi07FSuRZypOT5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938659; c=relaxed/simple;
	bh=vTLY/21KPKlTWPAD5gfcdBg7MT1YysP3BJSATyYyJPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Avtnn4Gyws0GVZlzx/1CEGm7EmGS3bsknYADEGaK7SyKUZo7VglHNv27hh6FR4ALK0h5ievAGcvPn8d5rT1V0pJ7CF5tSvI2S/vUmzR4HWZVWHqWVHd8ltrLei2/lrsmIhhjLkqK/3dxbHoRM9Jzam05r7Yx15d0YOQh7G/zxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Shoo21/C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso2897047a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938656; x=1758543456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF2MabtIceX0PKe2O4HP1OmT2y0v4LJriqMYtWhP9Mc=;
        b=Shoo21/Co4gLsxGp880VwIlWZetrOhvgpiB3gDJAsxT2jFIBd6nOyngUQJ/lDEl1pD
         5dJeeVE4cTdvm8YakUNo2+noLFqP0yxg9XaKvZ7XG0/9XMAAyTPMbmXD1lqlm1HeMYEJ
         GnXgfHNUnFu8qzdfFMpzo/lRN2YUjO1rtA/P319x/DvBIKZbMcTuxhbrwThYlBo2vkMr
         WNwBNB++t/KVWggjLvLy6cIdbJ47FNkzRFfquGfQKjhZ4eN1Q9ZJ5qOqTcp5a7IhofmG
         fPfrqpzDatQ0+RHrKFnL50bJv8jQCsn2ru1su4wyHxYn55d25PsXpR8ElUgXlP0tNTdk
         IaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938656; x=1758543456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF2MabtIceX0PKe2O4HP1OmT2y0v4LJriqMYtWhP9Mc=;
        b=Os9J/OmectSzL5fXaK/I+avgj+HYICx0MOCKMEmIDYE/xqlMu7K5NaQ8swRfX5AriC
         X4wSUinJ/VATZyvMCk1gn/atWnpVm9oxoffTZHlvThhkRyZoB1d971yzriYtX50XzgCH
         B8exAUPho1pVmUHVS3Q0mtGlxjm3R786Vd8jFwnsOIVkflyz4/s3A2a1WKfWPTtrqtT4
         E72syBsNld8Mb86uYkMWiCF0B1vdOlstrs7ut9EFdCKaI5/vJ6mctc4WQQ0OuSBvfoHH
         S3cAlmnlTXF4OXOkkS6Szu9Pf+VZczy+4BjEqUbrvC4+8Pmz8lhMzhEaCjEEe7CSh0k7
         btMw==
X-Forwarded-Encrypted: i=1; AJvYcCWAneFRSVYQVp6F058Ixwqe6Xnpxa+YzBPs+ovxaXwIqkEqvGQ30lk2MDWFwY8r4ftwjTYQlMbzedXGykM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwekHRdK0YBY4bYWia8JDFkJmE17RQqW+KfK2ZmsBRD4VpOGgww
	+zNwK4yLEKhsSiUVdWoLP0ckd/kV7nzfp2xkkoIC5TQrKAlBli3N0CM6ElqZ2DKvm1Y9StakIPV
	xt+Rnt5S893oQymJdVORymxIYIRNRJaa1Rhe7
X-Gm-Gg: ASbGncsZcuX1Q6+eFhflnMn8RE0+yiaI5Y4ZuZ2x6gJB8QIDNZN9LX+xFiYyANS/vxD
	P0qdyZZ0wSiyql1A4ZqqYTe57j6IGoxSJ6NP3+VMgjNFD/RxS333/wl6S/h6e7B5PWK7zAKhmo3
	1d/xRXBXd8zVbT/QHWyPyHi8zzcM6/uljU3ec9u7txfOSNtW1P68IBENzOvpIGYORfq92eHgnVM
	Jzcl9E7v89NnX11opr4gE4r5rbXtTDxXaphYcOVmzTs5HMWhA==
X-Google-Smtp-Source: AGHT+IG5xrdxO/W8ElP3T6Xw+0vP/8CTbp2X82/kP8TGYP5K6VDKrtLCkzSag5c5yvs/Syp7shqY0LnRicbQe5+Aj8g=
X-Received: by 2002:a05:6402:23d2:b0:628:f23f:1cd7 with SMTP id
 4fb4d7f45d1cf-62ed8303e65mr11090261a12.23.1757938655556; Mon, 15 Sep 2025
 05:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909082613.1296550-1-mjguzik@gmail.com> <20250915-meilenstein-simulation-7e220d91b339@brauner>
In-Reply-To: <20250915-meilenstein-simulation-7e220d91b339@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 15 Sep 2025 14:17:22 +0200
X-Gm-Features: AS18NWB-alz312y68Hp4M073nO5ml7ESYyZb4lNT6gaRESssrCSO3hBRzvla3AM
Message-ID: <CAGudoHF5xc0KYsV6H0S8tDt9=ipV5EB7RZzGzxVfkpbgVuF0Rw@mail.gmail.com>
Subject: Re: [PATCH] fs: expand dump_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:15=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Sep 09, 2025 at 10:26:13AM +0200, Mateusz Guzik wrote:
> > This adds fs name and few fields from struct inode: i_mode, i_opflags,
> > i_flags and i_state.
> >
> > All values printed raw, no attempt to pretty-print anything.
> >
> > Compile tested on for i386 and runtime tested on amd64.
> >
> > Sample output:
> > [   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10=
837a3240
> >                fs sockfs mode 140777 opflags c flags 0 state 100
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
> Applied to vfs-6.18.misc.

I posted a v2: https://lore.kernel.org/linux-fsdevel/20250911065641.1564625=
-1-mjguzik@gmail.com/

