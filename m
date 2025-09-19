Return-Path: <linux-kernel+bounces-824355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D5B88C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64CA174E20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00E2D23BD;
	Fri, 19 Sep 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NANjgOm7"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19815E90
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276445; cv=none; b=iT7Ld1XINCfnZTqwoO9w3UYDyqCDljciX+5PzHDJNslj8Gl9J+vUUs7/+Tvx5azI+EJs7qhZQPUUSBzunr5Q6J2K96dU38TPbLsIotaeQ9rrdTMmaMijNQXAwl9ipGNbJGUE0J2oqUDuztpHCOEmktiMx9bewm4G0Li8q99jgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276445; c=relaxed/simple;
	bh=Ae0wD7ANE5oz0H8FDiFN1P3fUIuF+XwE6dQJtIXVKaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNZle5f8HEynl6tusvUp8iJ76/B1gLbDqPyiMwC8JxnFlBgAvJDf9f2ACvk7rYuyO+4tOljBnZld5BUE0lXnX7zNZ6w6nJ3usa/iR3/iP6IV32pYHOfj3cV1PZpO8oAlbBcCcYJJp+HNN7XFvkfhqhVDoiY0w7A8jsl9jWOxHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NANjgOm7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4a3f39cso601677eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758276442; x=1758881242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYhfjUK1x5CaHU+bBQpIf5Hfve0v31gXpshuVItW08o=;
        b=NANjgOm7UkPnf+o3AGgXU1Sw+KEk9fNRytfegKLchPDqUMDdjcaGwaYiPoB+iDqUqv
         5bFM4GI33jdJWT0ik6t29R0SJcUITpBtDPxK93uDFI5JI5HvlhUo8VIg+IvUIIOQ7r3r
         yfo29DrX/MHabNXM0gc6NiPZuj7FHcKRkUyOp9T8EQkMb90U7ZyZ/gbe7nCAnCR4EWvu
         gcvtqDud0WB1YDqd8KMrvBq9dRv5B0s8UmSYrROq55tDdRwUtqx885IyyihTcaFlMOPc
         1vhxblDdVh7vsActZDR0KpAYVN30ak7VVFnXSxrCZkq4ij00+EzSAfQnNhXskArriS1/
         aGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276442; x=1758881242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYhfjUK1x5CaHU+bBQpIf5Hfve0v31gXpshuVItW08o=;
        b=Cp3yjFGec+Ik3CZfRkLQHmAUi74+G/MOcBhWyAGW5lIaLODY2bJlCGRTwgc13LTXgt
         bU0KYzkuS3NCXNofLrmAix27QtVlmvKTxtv1cKyzzEjz8/nBn/fmJcoMjsn+6q412C8/
         aOsnkJx51AdcnnhNPv2ERr8ZzqwGhoDEKwb7u9qK5cpqExeUBISLQxUPJ2snKv+QaoJt
         GuHvaWW3px6T4a90MMZH5NWKAQah+pJtbA3YXzaKikN/mLHvUA6bBrEt8q5bhO/cGKRp
         mMRlD6FEXkQBqPodgesDa40MVsFdJYisDqiMK9vo7MwFKIKh2S6d0EYRLnTvxI7lwg9R
         TLkw==
X-Forwarded-Encrypted: i=1; AJvYcCUdfuSiwQzXC6QXcrxwaFBRWjcBXVAoFxCArTXrfU0QpzLSBRAHrRuQZJbXrIJOJOO7mSGUD1GWCaSdxBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/wKswc4JB/pvU0sgSnHEauf7SLGZnj7NNM+5sbScQEaVBZ2V
	p2iAyFM3CgOFjLeYnZqD9GXqwEhndaR/nT5aoWMTyGnxhU90cuMo0W95masgLNOWMb1h9qIdkis
	hu7+IMzt7Zf6GQTiNk3FsqQnmvyITBUk=
X-Gm-Gg: ASbGnctCjwWYeIKqdnuGQzIGJVmEJ6GFZ7ADcd/glWrAdOlfDVbEVBNIIM0P1kTCjtz
	V6zNUDB0ElzeKUu7eKX6EClAcvdki2YTFtHeadRtcbMEAvqdtxVlcfa4f9LJxWltD5/di1U/F7J
	hIAj6I32rrBcF4ZHw/+kFo0+wt7Q3ajtRJxYzcDwwTsyjv0+cjRmecFchG8Eg4PS/PgEtebfR36
	XyJOxLx1RbZ8EBE
X-Google-Smtp-Source: AGHT+IG3pwAX0P0OmWvDUSHxsTDML+xUqsup0/py7274z3KYl9bT+8g9kp4A/IHN1kyclBFzjgxxAh2Ui20Z69c/0xI=
X-Received: by 2002:a05:6808:1382:b0:439:adcd:9ea8 with SMTP id
 5614622812f47-43d6c194b5amr939850b6e.18.1758276442388; Fri, 19 Sep 2025
 03:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918150703.2562604-1-n.zabelin@mt-integration.ru>
In-Reply-To: <20250918150703.2562604-1-n.zabelin@mt-integration.ru>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 19 Sep 2025 12:07:11 +0200
X-Gm-Features: AS18NWDg_NlMhQXUpLYoGp9dgBPIiIu4R6ec8UuM0Fv8JoBCIBvXXeRAngP3GPU
Message-ID: <CAMeQTsb1dBpd+87DDpNS5uyM8sTAhzZmxNvE_RLZFAC2dD2Lxg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Fix null dereference in hdmi teardown
To: Zabelin Nikita <n.zabelin@mt-integration.ru>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	Alan Cox <alan@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 5:08=E2=80=AFPM Zabelin Nikita
<n.zabelin@mt-integration.ru> wrote:
>
> pci_set_drvdata sets the value of pdev->driver_data to NULL,
> after which the driver_data obtained from the same dev is
> dereferenced in oaktrail_hdmi_i2c_exit, and the i2c_dev is
> extracted from it. To prevent this, swap these calls.
>
> Fixes: 1b082cc ("gma500: Add Oaktrail support")
>
> Found by Linux Verification Center (linuxtesting.org) with Svacer.
>
> Signed-off-by: Zabelin Nikita <n.zabelin@mt-integration.ru>

Thanks for the patch.

I fixed the following DIM warning before applying:
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+
chars of sha1> ("<title line>")' - ie: 'Fixes: 1b082ccf5901 ("gma500:
Add Oaktrail support")'

Pushed to drm-misc-fixes
-Patrik

> ---
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma=
500/oaktrail_hdmi.c
> index 95b7cb099e63..9c7d9584aac7 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> @@ -724,8 +724,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
>
>         if (hdmi_dev) {
>                 pdev =3D hdmi_dev->dev;
> -               pci_set_drvdata(pdev, NULL);
>                 oaktrail_hdmi_i2c_exit(pdev);
> +               pci_set_drvdata(pdev, NULL);
>                 iounmap(hdmi_dev->regs);
>                 kfree(hdmi_dev);
>                 pci_dev_put(pdev);
> --
> 2.43.0
>

