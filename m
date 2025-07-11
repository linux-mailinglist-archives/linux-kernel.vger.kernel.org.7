Return-Path: <linux-kernel+bounces-727314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D9B01840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4997E1718AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4727CCEB;
	Fri, 11 Jul 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIbaaZlZ"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477223535C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226827; cv=none; b=uQgi9O1x7HgKFRmTOXVNJMy4pG/XYDXO3dlzaVm7PcC+vQwx3Xlx0pmuAkZEi7iWx6ky0v9nrNU5vekK5K/ym2BXU+gkFV5+9qV90Q0CIjJ/P2EspUUcOwxgz1pFN+UUL7absLQuWD1ZJGl8sokYGtAC2+wBV62oPWPAHwdvjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226827; c=relaxed/simple;
	bh=hPqqT4/tdZjpo59sRnSJlzrkOv3hNmONJhZos3vk2rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAiDkT82aqikAT0xvQbPjSy/58cQyNjM9IJOmQfICHitrjJXDXHPOi/kdxG85jQitG78z0EDnnhzrFffor85+YMpZh+5/HmJhCkHkEebacHix7UN+20irX8OR+XXYSbRIWVJP6IvC0A7gAFbbR+qwGq2nVvffN1EB7ETrGkvf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIbaaZlZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab1abfe312so254651cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752226824; x=1752831624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EiToprrY2vSG7wDWswnp6OahCh2Aw5GevBEnK+p/NMU=;
        b=yIbaaZlZm1ESG/lmxmbJkgFqisMeie4SIoiJSaCAAkiyXPG6wqP3TEalJAFRRrjTIl
         O9d/RrbEvp0Httob9npX5zrW8jerKIJKQytdmYYVpA9fCQ3TUACaz5RmGs//lOGts444
         a0ZTPhKlpBc+3c6mSzxcgTrz5PeHppC1ktT4xSoSny7sObgpsgxuf8HQ6k7BOpU2lBEZ
         9NxZDC7vxcH9gP5gWal8b614k17oBWy2uss3xRhhbmmQ3UMOtqxAVfdMOYGMNxB20yi8
         xHtqbrqDseaG5hTxx0xuIdTau02mLQNFTfi5BtXsBbTXvLMIdneV50SP3RbtY66Cbns7
         a1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226824; x=1752831624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiToprrY2vSG7wDWswnp6OahCh2Aw5GevBEnK+p/NMU=;
        b=KybzKYn0MP4HHgnK701gP/89kk6+qLkCeBS3Jrh0VeQTkNFFy/7AQGacF+m0AV8Xlp
         rWqibZUtpMuy3/doLMZmmLOn2j720Szp6utUj6xegNSPp3x1OPDAkPVkZZ+VxtgZdbPn
         xtifLbeeIG3K6Ve2BR5KKjXgMI7rcJedCWqOsfl4hrfeaHENsAFYXvT/LqxagPf+IyCO
         IrBvCOsmR0JIcOFqvDoLeIkp11OvnLWimLKMYwBzOwNoIgO6dLo9UsTZg5r++77jCZpB
         nOJO94vMnE2tYTYbM3XRUr96GkitsDkBmYI9trdC9B7RBsVGaGzn3SYQ5iO4MXa4TNwx
         FU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXc4GNGAuX2ZC1o4iJwdh1eqytkwPLX7tEt6HP3b9m26QYUFLqtrboZNIlxbVkB0XkW0UrQdJNMpL0pTB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pNlB3HZeLAQ+GOmQPbcwVSU8ybb+BA/BtVLN+GzcYGxOxzUm
	FaMusMxZkTamIxJ4MGtIRXXi9eKMQ9U5jHdHQI4lrg4IlrQjcoL4HcuDQPXAI/4GcBLd4tZ09LR
	z4orxRSGIDrn6yw4u+8LM7izgZt5b2qQwJ/fQuZKnTw==
X-Gm-Gg: ASbGnculG0TBJE4m+Ksc7Xle93G/B82Q97dTCHv0Ewy0SfyHLD3MflRH4plJZsqOITP
	BSRAys7Tr4cQvigshcj/kmN7HcdoUa5b7ejOH/SD3z4EvcOPXj3gpazvEHH79BrQ9hxBigtUo3B
	ql7CsVFnf/aj2O3lYRO6cU8shzhO0bSa2DbhUpZKW2QgnvfQjqU7J6FVeuDt55eysllxPX8/qy8
	Pgdgg==
X-Google-Smtp-Source: AGHT+IGt7Q2UqhjAv5rvjGTqWJkmfPMxEWXDaNMoSAqadHSOVa3yKAj/RGQ5pNmYTvcFx6kGvI49Wq9aML1dz+RFIak=
X-Received: by 2002:a05:622a:d13:b0:4a9:d98b:78b0 with SMTP id
 d75a77b69052e-4a9fbebcb05mr15398421cf.7.1752226824464; Fri, 11 Jul 2025
 02:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711084708.2714436-1-arnd@kernel.org>
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 11 Jul 2025 11:40:13 +0200
X-Gm-Features: Ac12FXz2oo9QpWwn_wXugwUdwMkaTK7Q-py-EyqBK4mF-NG0Nl0JpgY506ozzxA
Message-ID: <CADYN=9KHYSQRLk00RZUygSD28CwfmbpjWa+W+P7B5xgB9vPCsQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anuj Gupta <anuj20.g@samsung.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 10:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
>
> Move the check into the blk_get_meta_cap() function itself and make
> it return -ENOIOCTLCMD for any unsupported command code, including
> those with a smaller size that previously returned -EINVAL.
>
> For consistency this also drops the check for NULL 'arg' that
> is really useless, as any invalid pointer should return -EFAULT.
>
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
> Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Tested it in qemu-aarch64, it now ran the ltp-smoke test fine.

Cheers,
Anders

> ---
> v2: add the check in blk-integrity.c instead of ioctl.c
>
> I've left out the maximum-size check this time, as there was no
> consensus on whether there should be one, or what value.
>
> We still need to come up with a better way of handling these in
> general, for now the patch just addresses the immediate regression
> that Naresh found.
>
> I have also sent a handful of patches for other drivers that have
> variations of the same bug.
> ---
>  block/blk-integrity.c | 10 ++++++----
>  block/ioctl.c         |  6 ++++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 9d9dc9c32083..61a79e19c78f 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -62,10 +62,12 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>         struct logical_block_metadata_cap meta_cap = {};
>         size_t usize = _IOC_SIZE(cmd);
>
> -       if (!argp)
> -               return -EINVAL;
> -       if (usize < LBMD_SIZE_VER0)
> -               return -EINVAL;
> +       if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
> +           _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
> +           _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
> +           _IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +               return -ENOIOCTLCMD;
> +
>         if (!bi)
>                 goto out;
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9ad403733e19..af2e22e5533c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>                                void __user *argp)
>  {
>         unsigned int max_sectors;
> +       int ret;
>
> -       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> -               return blk_get_meta_cap(bdev, cmd, argp);
> +       ret = blk_get_meta_cap(bdev, cmd, argp);
> +       if (ret != -ENOIOCTLCMD)
> +               return ret;
>
>         switch (cmd) {
>         case BLKFLSBUF:
> --
> 2.39.5
>

