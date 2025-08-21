Return-Path: <linux-kernel+bounces-779670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883FBB2F713
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299CFA0784E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF03101A8;
	Thu, 21 Aug 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="W5qsGTLF"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684F3074B4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776819; cv=none; b=LysdEmd0etyq8yLKy1r+1+avlHHMpC70gKjcIJ59cc9NLbIpzunL+56oqJgeDCztQL0a/VYYqR92lOEF4eg0epS2+5OpW/PdJyiSMODMu8+3AwurOHNhic/hR2ipMV3dLQbXDuMbtmBHlcZ2HAmY2TH3HKrVa5YXsv9vZtR7r8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776819; c=relaxed/simple;
	bh=4ghCPkutuCK2fYk1NWAXL/WCPM/HDvA0p1GJ8ZLtZiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHzYqF/i8+DHg4udKIB4ZLLCwAUOWT2rpnmPDObS5BP6uodkHvC1nZ3wKaEWQWBnCu/H21uO1sgdmpTobp+Ied6gLc31fCYXFpb9GAvs5hh1QQpe48xMGrwA5mEo9Uz1DCXgA73NdzsAh+3InBiRvmZSgdVzp4BreXqIYUwP8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=W5qsGTLF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e86faa158fso129140385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1755776816; x=1756381616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=incQm52u2R7cws2GVTot8B10CBfXRhBg5cxU8b8je2s=;
        b=W5qsGTLFfmzfHDQ49d7Oy8VTkEVDFNHtdyIIVErTnUad5lSeYiegnlYlTn/7Md/nYw
         +OKqYSHhyhmCFX7jAGKCjCi7GCoxqCGM7bPseKewMZJnx9T9+zDztqB1L1nW9dLcO/5B
         393f4UXMD6Y27C9GV2hxNWPIABl2jWknN0KyzOck1hozl7YCjNfscFM8nWjE4M2RW3bq
         g1mrQO2LCLWDV+xurmiaTiC2IDV4Sxoh7jF/dw5teHEmUXL+XSgUWGrIbqJXSXfCMofV
         xQ7zZpLje5faccm5hnHwDAQATw2Bd6RGo2FO/1QFTXaxuJ0Qsum8zfgNSqpos5dJzold
         5Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776816; x=1756381616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=incQm52u2R7cws2GVTot8B10CBfXRhBg5cxU8b8je2s=;
        b=QtdN0MXdraUv9EjF/MDuBPzAZX+U2nUl+a49dMp5VnKihiAHS9feNi8eM6tHFIF4cw
         BJI+FI3829tgmHhjIbbNUW7XhBOd/FK6jiIoZCRKolmurOOQKAj+PYaAtgyinrdnHSN5
         RtD+dqvldvbL1h3Z+UyjJHLSpheUDBVfX9tiNzDCK6X160y0mclyOoi65FJ/v7SbFkUt
         JoRlVV7DuAv86sQbV7r2AmomT/oa3ZWuc9CRKtsdtAgf3dL94R6RSfuqyN14pbxxB7ok
         h1Ce8Ca1FOfMpn6BLtHMjYf0FKg8CAipUHhSJjF5pIJ+4YRhCN5sTWsuZOIZvT5pqFt7
         D1aA==
X-Forwarded-Encrypted: i=1; AJvYcCWL9eVd5Mgo/x9KZhHYLXWreWqXu2gN0BFS1BKBvAl9Z57ImvNzEwFrIj4n1XLj6Qb4vDdUPmEAwrQ6nB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqd8OOD+gbmHnjbFh+BrTWEBGTHP9O6ZpJCP5tDecqnXtz3Ik
	7U6P9EpzFvqog/wOGplyX5jGiDuub976CDoK34caZtdXD4zPj4MKP7hsCLip3D8tjNQIMk7Eqpa
	Csn7ydLiBNPUM8x7XzHRmXai1zVGTUXPImRO6E32Q
X-Gm-Gg: ASbGncueC1ec43c0a5C/hkh/7WPm/OcIyzBgJmB0Qymgi04rsw+Yb0HKFCZO9A3NlFy
	yNscK0TjyI81ethQ4EbCAjc/uzgKFmrvFPz2dlXgJllbMjyaua0c7RJ9arSQa+bVFPis5G+UJdI
	2ZYT9eIfoKnpAR693YWQE3wBSEynZmAvPOodHdN6ZHzLajFcwRKjnZ/ECNCjFuMNKesfO09kdRL
	7PVSs9HiauricQeLgNi
X-Google-Smtp-Source: AGHT+IGcg5sCtpZTYrIqU0S3P212TEo70q3ZLTkCJTYJNMj+3zLr/OnUd+pklhVWGQLCAJARERF/BYFnDgEXBjf2les=
X-Received: by 2002:a05:620a:c55:b0:7e8:62e9:7fb5 with SMTP id
 af79cd13be357-7ea0970bf72mr183834185a.33.1755776816353; Thu, 21 Aug 2025
 04:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-8-zhao.xichao@vivo.com>
In-Reply-To: <20250821080723.525379-8-zhao.xichao@vivo.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Aug 2025 13:46:19 +0200
X-Gm-Features: Ac12FXxWSgJdG-W8UPYo7Sc_QZdPcmNoT2HwWT_Zp_zNw3zqULm1d2DtaIBBD5A
Message-ID: <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if
 error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:MELEXIS MLX90635 DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I am not sure I agree with this. It provides an error message with
reason and I understand we want as few as possible, but this would be
a valid remark inside the logs?

On Thu, 21 Aug 2025 at 10:08, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iio/temperature/mlx90635.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index f7f88498ba0e..6d386d887855 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -939,7 +939,7 @@ static int mlx90635_probe(struct i2c_client *client)
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90635));
>         if (!indio_dev)
> -               return dev_err_probe(&client->dev, -ENOMEM, "failed to allocate device\n");
> +               return -ENOMEM;
>
>         regmap = devm_regmap_init_i2c(client, &mlx90635_regmap);
>         if (IS_ERR(regmap))
> --
> 2.34.1
>

