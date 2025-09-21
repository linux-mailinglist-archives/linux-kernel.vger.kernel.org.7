Return-Path: <linux-kernel+bounces-826022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BFB8D584
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E716D177222
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E0286D64;
	Sun, 21 Sep 2025 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxZA76sN"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392C286883
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758435270; cv=none; b=aAaq4X1rFr6da7EDxLDMVwBK4WMNExzqZ3DT8+OJIHHnX+zE+NW1rQhkWIsqspjv2G3I14dxYWh4ZPoGnNzuHVg2x9aaTTfrEv1qRzYTE0Zohl+OWunRnh1eetarUdPVL7bNCU+ddxWNt4Uf4S7Ra2qoe3C7hMcrz1hCgb2MsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758435270; c=relaxed/simple;
	bh=iN/uGjrzbfIvC2pomBrvytH2vy8anOpTsNRUKeMOgRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foyEFCsYnuD4klcnDrbD2/1REZGcnw0aByWAJ9SWwzOHh141Qi8gLmpdupCwf69zzjM8XT/r6+0ULyqmS+MhmjSxDqw0WnFcmfsIyK3fJDrcxZWD6RPwoAhj+WpbjBPoSRZFE7OaF9lQJOIp+hbMaAHz3/skef96vhCEC8T54m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxZA76sN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60150590so22869987b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758435267; x=1759040067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AojnXTuhkuopZDJGSIrifi2m6vfKyheuFT3tQ1DZFd4=;
        b=kxZA76sN/AAcoEYgYaz4Hnk2bW0eDBY73wHgVcO56mlTp4g8Dy8iTl8tjmO9ZoybXO
         wb6tK1mGldX5JNwATCJw5Hi14Yp4CX1sKF8NGd5A356FzUY4Mck6fSXRkJOb5pp5BDBS
         agv9g+4WMCjWjW0bTXfqdxI3m8cEdy6ODk/Ogz8XceA8IbRzR/eyjKznfUjmiUs7J6kh
         ArEt2Pk1zWto0pdSlPKNFTjgW+F/4Lgc9hmPe9IMDh6WgwRVZGW7YR/V/GhxZ3AgaDO7
         316wOI/yJ2nfA9akEBZVa6gO/O9vRG14+CDsCDHNksuQOjnBk6s3QmbRbuS76JREIYBa
         ohHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758435267; x=1759040067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AojnXTuhkuopZDJGSIrifi2m6vfKyheuFT3tQ1DZFd4=;
        b=l/6Y4nL8izu076cnNJR2d+Ij58kAOVeXaALlbMGDPaZ/Yx1c66yukr+b7vfJpWhnzi
         h7W5kPIrFaPbR6ava/SGa2/hCth90jFTR5HN32J3l919IHRretbah7R3/T5Fycpr+jK7
         RSJO6RCLyRtS/4Yln+4jDnPhqaD7IqEYf+ph0gxewCDUeSMGJMfVUQ3kzXh8MjcvX2YE
         YonBJWomoFJFo6t+7P4Pnf/q46vTjCpodfvS9OhDENhxkPkp01pek+l7JtwmZRrf3hXr
         HZRrxdZ/7mumQCa6LMCA5he7UNYIxKSyNy3zDZNPGvBZdI9vM/hTUCl0CMnzGJTvZPBR
         UE/Q==
X-Gm-Message-State: AOJu0YyFUpialsahDn7zzUpC0MccYa+2AQqNTdF/+gZg14q1KGAkCPgq
	PqzKvF7ydV0t4dfWHfwdlzldk00Eibqx5553PKfuiKDiACfmH8GY0y79QGAolOLYQTx+4MCd+co
	uzPy3sVbJaljeFDjoMcexW8Ce34tX2t8=
X-Gm-Gg: ASbGncu7f3bj+Ze8fvJES81cyGPhsw5v1AmxJliJLpRSnak+LkWgIpytFQ/l4Ej29b3
	VRbhewpqzn2H198KB3WvnDmRSejFUYtKajdirrzKr7iO0z/4z9pbbd6FaSSD8QKo2DbcMyTCPEF
	fCNDQ/OaJxT5FO1YwblF4E4GefG2uOVF6sU96CGKjjJwjxiXGIuk1591q0I2Z7n72BAvStgq3F3
	dUXMgY=
X-Google-Smtp-Source: AGHT+IEshwwZOaE95eNfvPs+ev8aG1Akgfm3NpGOGPxgdxXazdfE91ijPAySFiDD2wkPtUo8g45aZzylIGiDlySCImc=
X-Received: by 2002:a05:690c:6182:b0:71f:9a36:d5bd with SMTP id
 00721157ae682-73d3ef2b466mr69139097b3.43.1758435267450; Sat, 20 Sep 2025
 23:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919124217.2934718-1-jens.wiklander@linaro.org>
In-Reply-To: <20250919124217.2934718-1-jens.wiklander@linaro.org>
From: Masami Ichikawa <masami256@gmail.com>
Date: Sun, 21 Sep 2025 15:14:16 +0900
X-Gm-Features: AS18NWCiSCvSKiAJ1yM15ZzGP6XX-bMqSWPpOjNvuBcqsSil-IxTILIg5W2DemA
Message-ID: <CACOXgS9rA=tEfJ85Mw8550Yfq2XvBMLjknzOV+vnR0KTTLGHkQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix register_shm_helper()
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Sumit Garg <sumit.garg@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,


On Fri, Sep 19, 2025 at 9:42=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> In register_shm_helper(), fix incorrect error handling for a call to
> iov_iter_extract_pages(). A case is missing for when
> iov_iter_extract_pages() only got some pages and return a number larger
> than 0, but not the requested amount.
>
> This fixes a possible NULL pointer dereference following a bad input from
> ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
>
> Cc: stable@vger.kernel.org
> Reported-by: Masami Ichikawa <masami256@gmail.com>
> Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTj=
JAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer r=
egistration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..6ed7d030f4ed 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>
>         len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0,
>                                      &off);
> -       if (unlikely(len <=3D 0)) {
> +       if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
> +               if (len > 0) {
> +                       /*
> +                        * If we only got a few pages, update to release
> +                        * the correct amount below.
> +                        */
> +                       shm->num_pages =3D len / PAGE_SIZE;
> +                       ret =3D ERR_PTR(-ENOMEM);
> +                       goto err_put_shm_pages;
> +               }
>                 ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_free_shm_pages;
>         }
> --
> 2.43.0
>

Thank you for the patch. I confirmed that the patch fixes a kernel
crash caused by a NULL pointer dereference.

Tested-by: Masami Ichikawa <masami256@gmail.com>

Regrads,
--
Masami Ichikawa

