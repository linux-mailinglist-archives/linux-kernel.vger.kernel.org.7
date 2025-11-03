Return-Path: <linux-kernel+bounces-883511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22862C2DA29
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DB2189B62A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CD23B605;
	Mon,  3 Nov 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="bJTZ39Qp"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF82264C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193967; cv=none; b=o6CN5OzOw5fD72CTjJg0D19nnbrmi2lI6UMcEJ1BqMCjDzpWdgm6huvEwt0obkWtYBwCXxpfPJRqMm7HWkTSIbSjTFIdk+jNj/Od7bnAYqXaiEErZAT6PtxVdwPw1yjXhHY4nKqiBhaWKJ6dW71YgcvNaVUQI01yE59zn7vBitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193967; c=relaxed/simple;
	bh=xkq3fhSpFsbo743IPkDyvhPc+xLdeirly7xbrbNg1WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2nnUqxEloVLWMfDEfEjp0abiOV4KLwPUbmXMo7O671K7zvDt9ldglcgUZvF4yuTk2OsHDw79OV8Zvwkyug9yW3SVSaVQFuIl5WCm7vOgWKUV7SETM3r5kBR9Vw9zWFmgZKYJNlkbFyJKL1Bu94FxMrqJK4DZlYdLf8Rk2+4VHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=bJTZ39Qp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786583618d8so23625817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762193964; x=1762798764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+bzmYsLGCARLUOgmbjt1DiXQ4aCZGvMf16y2vz6rb8=;
        b=bJTZ39QpCbgXO4Ltl9oqqF3fJOOdPdAC9u/Xx+jOeNMePvGvnhd0BDOl6++92z1hV+
         EevvEAjk+7aIceDipNaQm8/jpJnYgLFucT3g9O9FC8172DqIb6C0MwcLNIerYltCLK1h
         /LT2DipuFqpIlsQhF1YUi7XjSX7nLOzzIDdTRS6QXhFnjfNpvHelrLTZhrjDVlwlgYmp
         8uG3VvdLraHitq6xHYPxqli3iTid8LcgyJT73XwKtS2x/LSqPYi4WYtNGSecLqZ8FHvH
         x4Z1CyiElLJMJwjZXdwnwQQDRdu+JKQKGBopuZUdRJQWjFbq9VjeGNKqWO0PG5C7GTZ7
         7nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193964; x=1762798764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+bzmYsLGCARLUOgmbjt1DiXQ4aCZGvMf16y2vz6rb8=;
        b=XQGAY11zgAQpmVgj0ey30eeWeixjqC1O4dtnBVfC5YJhhdkcVjShJYdZvU6Qp5wXha
         zJrAaABxoVXmSyZl8ksqx37rMIjchROF2BXk4suS6qmtVU0ivOy8WaJuzjwAVZpJPTYF
         m6Vl11m3T9RdhwAmNR+WDBROSfRr6bJ8Euhr784y9Rzxa1bTSLKyVbXgJJvCZ2ZYzVfm
         /LS+btrog1P4elD8Hk2+19N4JfUN4HVJ9B1VOpLjqCPuOi4hf7SAjW67w4J2yZSLZVfl
         Xx4l5AryoV6x4uV03MWDWpLnMQw8vQHo78nAY02j5Y6zYCnV9t4fnkCvNx+hyoU12VNa
         I/eA==
X-Forwarded-Encrypted: i=1; AJvYcCVSR5TdT9/zd9SsCEPXxnGST96UfJzpsvJL4xpZvJhACZFH897WecY/LLqDh+LAF7DuYc2fIDnUYlWVSnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+OZWeOFsbOV4YluuTBFdyw8rYzJtrBhpiFHqsqulofsiT0G7
	M0NcEf9pgVgYPmmE8m6aOATMKY11U1JYuXeTMI6MJ9v8Bdja0TR8s5jjAAs6ShUzTckCVaNTBVg
	1WnqHnk4OFROelJZQUJpv5QixPGxcVywo1830cvODzc1pQZw5T2X3Xl4=
X-Gm-Gg: ASbGncuN914qag8GFEJCjxVEipiBJXBBkryyQpD0h70bnnWxNM5rLqCjkZIURa3J/+O
	PsJyrjKL26/iqG6OPpYZidDk0oXMvUifs+ULnkWuI6MXtdrZ5T2ZfWpZ/ZD7lUHzodFk6LLewsw
	1frOrUHwl+mg4UtaCvxaUhU3k4xlB9qAVAuNu2CunZyQBvHKkvMvKirJnS1oOx1vgp0F6MqYa2Y
	ZSQD6SITeiVULEQGfW1FMb1WnDoR/U8rGVMd6YvOLwZg3ED8nxI0vNciluZZgRQ3DUmEWDJAuL3
	e4dxhoictsw8ofgZ
X-Google-Smtp-Source: AGHT+IFYEcVRZ8Vp/nBZVlCxk0dTBlD25PQ4RLWPQN64T3kSW7BOSZMhPUuKdc+YhyRkIQHbcQ84biOR9TP9h+2A3ak=
X-Received: by 2002:a05:690c:6d07:b0:786:5b30:7760 with SMTP id
 00721157ae682-7865b307cadmr81378617b3.23.1762193964170; Mon, 03 Nov 2025
 10:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031114835.113026-1-tarang.raval@siliconsignals.io> <20251031114835.113026-3-tarang.raval@siliconsignals.io>
In-Reply-To: <20251031114835.113026-3-tarang.raval@siliconsignals.io>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 3 Nov 2025 18:19:04 +0000
X-Gm-Features: AWmQ_blx2gMGL2UsqCcStrzwij5tXg4E1ntRGMYX5pT_bX8awn1r-Qs8gNy6n9A
Message-ID: <CAPY8ntDAjyUF4gMO7a2HEcW8cnFaXe0bABtRA7bzWwrt1utp3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] media: i2c: imx219: Replace exposure magic value
 with named constant
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: sakari.ailus@linux.intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tarang

On Fri, 31 Oct 2025 at 11:49, Tarang Raval
<tarang.raval@siliconsignals.io> wrote:
>
> Introduce IMX219_EXPOSURE_OFFSET (4) and use it instead of the literal
> '4' when computing the maximum coarse exposure. The IMX219 datasheet
> specifies the maximum storage time as frame_length_lines - 4.
> (Ref: Datasheet section 5-7-1)
>
> Also fix one indentation issue for consistency.
>
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/imx219.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 40693635c0c3..e87d5a18fe87 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -68,6 +68,7 @@
>  #define IMX219_EXPOSURE_STEP           1
>  #define IMX219_EXPOSURE_DEFAULT                0x640
>  #define IMX219_EXPOSURE_MAX            65535
> +#define IMX219_EXPOSURE_OFFSET                 4
>
>  /* V_TIMING internal */
>  #define IMX219_REG_FRM_LENGTH_A                CCI_REG16(0x0160)
> @@ -450,9 +451,9 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
>                 int exposure_max, exposure_def;
>
>                 /* Update max exposure while meeting expected vblanking */
> -               exposure_max = format->height + ctrl->val - 4;
> +               exposure_max = format->height + ctrl->val - IMX219_EXPOSURE_OFFSET;
>                 exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> -                       exposure_max : IMX219_EXPOSURE_DEFAULT;
> +                               exposure_max : IMX219_EXPOSURE_DEFAULT;
>                 ret = __v4l2_ctrl_modify_range(imx219->exposure,
>                                                imx219->exposure->minimum,
>                                                exposure_max,
> @@ -579,9 +580,9 @@ static int imx219_init_controls(struct imx219 *imx219)
>                                            IMX219_LLP_MIN - mode->width,
>                                            IMX219_LLP_MAX - mode->width, 1,
>                                            IMX219_LLP_MIN - mode->width);
> -       exposure_max = mode->fll_def - 4;
> +       exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
>         exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> -               exposure_max : IMX219_EXPOSURE_DEFAULT;
> +                       exposure_max : IMX219_EXPOSURE_DEFAULT;
>         imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
>                                              V4L2_CID_EXPOSURE,
>                                              IMX219_EXPOSURE_MIN, exposure_max,
> @@ -900,9 +901,9 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
>                         return ret;
>
>                 /* Update max exposure while meeting expected vblanking */
> -               exposure_max = mode->fll_def - 4;
> +               exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
>                 exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> -                       exposure_max : IMX219_EXPOSURE_DEFAULT;
> +                               exposure_max : IMX219_EXPOSURE_DEFAULT;
>                 ret = __v4l2_ctrl_modify_range(imx219->exposure,
>                                                imx219->exposure->minimum,
>                                                exposure_max,
> --
> 2.34.1
>

