Return-Path: <linux-kernel+bounces-805717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686DDB48C98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091263A6B85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B026E22F77E;
	Mon,  8 Sep 2025 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OnlrC1fE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A8281375
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332424; cv=none; b=EddS7IG7Y6YFkzDf28fCs2u3V9Ler/yGWeX+7d3BBwpvCW8m93yXdArF5dIXU7anHnUUyOMwn4wUCWRY51jbwHJhFVuhmb5UXVaW7taEHgkGQpcVnvMvqcD4WQSA8tkE7CxAUByAS/ovDi99WY47V3Y0dXw+u1oUT5pSQz0ma78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332424; c=relaxed/simple;
	bh=Jdj126aKR9fsJxs21nJU0/HvCgCUue2/c+CuOqmGjUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kizi8geJXCp6CVGqsEWGkeq34fcs3N4CeGE5nTIjbwdJtNBoXLcLht092pVAHZeCFM3QmELv0crppHyxO34RJnhosH/Al74v3sO5zt8rgXe/kgucvdcrPqdobCq6NJp5C6Bw1QJZVin5jLNHeYktR07KhNBM7G1IWbQecvR1BOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OnlrC1fE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445824dc27so41996475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757332421; x=1757937221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+2cYDQipD7gr3J/GGeMluFKpzUYamLaGJLFb0mPajU=;
        b=OnlrC1fEdYeFRuFVhRYSWn2y0HYesl+vQ2TTRX2Yu4ovKT2uV/Y+nl46AWePzxc9NS
         FvAssiYInSiirzYifWBxl0B7WN6J//Akiw/9/1ycODST0cBZsGd0lMuVNsQLx/Dtvdeo
         +AGBPikZCllR24JQpF4RUeTXC06ryse1iIDHPcezm9KjvwX34ldHeNIYL6leymPLhxBP
         FqnmybmuHvJISVv9/SkASM77jhsZLvRDw1731DPUMtGOQIyTkS01qr2wqECnW47E0/k0
         R09XYQcjKyKRea9a389UED5cjdkeZWSd6vnqBSInSXMQUS6GqIbDcyZMp8PXGXr9bt2r
         0xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757332421; x=1757937221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+2cYDQipD7gr3J/GGeMluFKpzUYamLaGJLFb0mPajU=;
        b=R9iOFYdRr2jRIgcXqq85hnvhjc3OFmrrHU8YP91xMC4eNwErjce7O/kd81x9hrqlgm
         7fEi0vrTVp1L7TrL1UILvvr2gqXlAyk4iKTKmcMS9zw6rTRBTP6dgTNdnVbeqPWUXHhX
         qIb+G0hCywt41KqI6TuO81fXSTvU047s8yGjX0L7vbh1g81c2NczSeFFUmDe7IhX4M9S
         ovqrNmsmcTERpzP1UFpZ9cwn/My/MPBajnRW1DKoKNzCQ4RjnpBHMEVltCKMj5X7N+XR
         64MP+VrMSXOLij283hrJ45ZSN6hI3qjPk7FWlDW3dpFa/Fcsyruk5pLh49NJt9pbuNtX
         w2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuP/8jHZDqfrMi198yfo5yRLZ/Si+sExauQ0+UQ/fwrFP8Pi28P+e5ii0ITNqkDBCQyvAlkw1xHU8M474=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7X0BPltbyNRnXpMs2YzCoR5s3evcKVs3lym2uknU5YQbCPAj
	v/zosp/1310wWheVKhzwmxphHfn+J4Eia3ysNgVKzIh3G6b/733c3PqLekq73pokn4Rsj8khFG/
	FmZZsfEetMP4TF0nn52GVCXypfcpigy0FPDDQXoSg
X-Gm-Gg: ASbGncvSeRysyM/pQoEFvwe8xVW1nySlzAu2/FbFwEVG6zmzBlo8YCS8ZD2oHtDrVTB
	ZWZ76jFbEgwqSQtMH+0VEakyHm7RdiXJP02BjIk0ez4hYGvJjOLGO/PW+m1elLRGdHnHpf4uR2C
	uHQFISNgg7uPeaCiHB7ZpgnwTt4FsZJ9uHW7Dklnh6rMVis45FbO8JL6O9qjvZFKVwA3qnRtWgM
	UwYreFO4mUBrY7/9yRMBK3A645QCISkBEYT
X-Google-Smtp-Source: AGHT+IHq7LIhFJep3kETdJ6MaNKLAdUpOxGxshgaGiagGRUOhkDpDHxNcaSP3VuSnQhWyJ1jevVUcJWHsIOBukzL524=
X-Received: by 2002:a17:902:cf04:b0:248:79d4:93ae with SMTP id
 d9443c01a7336-25172291a1dmr86644435ad.33.1757332421245; Mon, 08 Sep 2025
 04:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908095645.610336-1-ashwini@wisig.com>
In-Reply-To: <20250908095645.610336-1-ashwini@wisig.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 8 Sep 2025 19:53:28 +0800
X-Gm-Features: Ac12FXypE45y_zEFmnWWtckHb7faUOH99wxklDbaNTVptbRGgiXdw5XclOCGVLA
Message-ID: <CACycT3uti=ZtO7+ZM7k3noJcYtNTF2Np+JcD5arN+R4LRSN3Gw@mail.gmail.com>
Subject: Re: [PATCH] uapi: vduse: fix typo in comment
To: Ashwini Sahu <ashwini@wisig.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 5:57=E2=80=AFPM Ashwini Sahu <ashwini@wisig.com> wro=
te:
>
> Fix a spelling mistake in vduse.h: "regsion" =E2=86=92 "region" in the
> documentation for struct vduse_iova_info.
>
> No functional change.
> Signed-off-by: Ashwini Sahu <ashwini@wisig.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

> ---
>  include/uapi/linux/vduse.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 68a627d04afa..10ad71aa00d6 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -237,7 +237,7 @@ struct vduse_iova_umem {
>   * struct vduse_iova_info - information of one IOVA region
>   * @start: start of the IOVA region
>   * @last: last of the IOVA region
> - * @capability: capability of the IOVA regsion
> + * @capability: capability of the IOVA region
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> --
> 2.50.1
>

