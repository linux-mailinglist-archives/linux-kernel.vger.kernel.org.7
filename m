Return-Path: <linux-kernel+bounces-834808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96382BA5916
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DBC16904E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE222756A;
	Sat, 27 Sep 2025 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dci7/x9+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B62221DB6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758948719; cv=none; b=ds6wipuqFuL7KWB+gIdybAy34ZPowxteDi/CbQMt1tJZbqbvtNrHNI8ilnGT//OvFL18XHXxz95/5EbmIIGEvzoIcpV2M269Ppw9V2CEWnZ5LOImolMIGtShgaUbCe5HQ0th4y5dU8z4kN8UpbP8rBo7OXzaU3KZ4Gh2fJCUQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758948719; c=relaxed/simple;
	bh=sQwY1/iU0H3EfJPkFCUsl078zcR+FJBogZeggTTXVks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO09hP8t0bfC6NSWpD5U3CbG+qr/ggTi7oAPlw4xbEgCyF9G90JgYZKOQMKp+4v+wwz8AOcN5knfB623h3FO0JQIss6FhAQG0gdM5GqV6e6+9pPtDVlRSDz23BhIiRzvaPFh3nc483WT6+vYHY6gi1aGJICJFqE7PGQEcEFTWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dci7/x9+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33067909400so2142003a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758948717; x=1759553517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wp26SQHvlyX5H1LECfdHm0FDILD7imbH4lOVBynqG4=;
        b=dci7/x9+7Jkt9HbojpWEuRGfr6nGdPSNpydvsjVbozxiKAsFtwtg4hUL6qAHKQ+GtW
         D3KBQhdCLmxfFZsRMJZmYpGWuqeipz3Sk1qb0JtuuK8+gAWlw798pbYfoUg+unZk4u4c
         zj9Bu4JelE+kSZLDq4wOyoi6bejGHC+WtC0JWfktWa5lIecFN6upg8Dczcq3+22W+jfM
         WiC+QXe4ZZ53KaGvGyfM81jtgJ2/RoLXq1yEVB+9L8451iV9on40m713pspn46VVjKKk
         QD1AXKoj8qSnQCxZ8tdabu0VnU2iynXzJWTz+5/zC8BPZLNNAxgT5q+nwih7yqhc5LW1
         XIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758948717; x=1759553517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wp26SQHvlyX5H1LECfdHm0FDILD7imbH4lOVBynqG4=;
        b=Jr0YK1aNk0i59Wr4mcDWYFc7m5PuZu2ynr/ICWCbptlAvo6S0iB4tSyl5WJNGSCKb5
         DcNSCBF9Q+TxhQ3HmLb/ivKjC8dc4K8uEBhZLosqXnSHIl0ICgwzbl55xiMFk79tPX4r
         DWqj6IompL3MsyMcPD+Cp+b0+0khkSEp5PB6uRo1EZlZqPcDpKQ0c/2Y7CYNacu/0tN7
         rS4Bhjto5moc1afY5Bf0tVunm/wDT0+cHMqfGh4gkIsjmX+5Ur63GLeLWCVO01oCBkWS
         pDunhrjlZtXWu3pOegQRzHPILQrRiizQj0EmYtgr4Jr1vND7QMRUhHK/R/t8KRMaKCf3
         zMvg==
X-Gm-Message-State: AOJu0Yzwbpd+8XzZbsycGSYF+xQjoKpU/CH2PVO1QdZQUekqhAGJHppd
	hPCypc0m2M+cFmx2l2p9KbWd1mIGnM9Tmw2qWqLsNzx+ajoOoAZPYU7mE8jUsLM/FS7ojBsnWLM
	q7rwFNnkKx/TS/osvD2aisfoJPnWnUpg=
X-Gm-Gg: ASbGncv3NjFdDJUPd+w1kyMY3N+7t0que8yY1eeP3vtFhPinoLYwrLHL4T86cyGTD7J
	vLarz8wmDh5kFMf8fyFp5CrN4YlabHEBoepa5Gd3yTG6LkWcCjZJEOND3ZVPqwcOX6Zc0oJ+vll
	Uy/JT/J1RCQeSdkodxg1/3ckjb4Ilqh0h3s0BGm2xGBhfzBxCGz6nsV5hi3sdDCKBLCOZFe9myh
	YiU9/fR8il/u2jhmXvZxrMfiEcwvg6czom/iyEz6IiaOZVpbAWcBF7CR7+rryxV+RZxK5KvZJor
	gD+9iW32tOaNSBHqoYuQufqTPPh9409OXdSerQ==
X-Google-Smtp-Source: AGHT+IH00TkFkR37LoXUYTjn3I7nEp9xJlAxL8DUs+Ac6CUFD8n7YAVOhClsCt0N13Pj2V7rm4NF9N5MUVfYAHgeQ54=
X-Received: by 2002:a17:90b:4d08:b0:32b:6cf2:a2cf with SMTP id
 98e67ed59e1d1-3342a3e634dmr10652245a91.14.1758948717161; Fri, 26 Sep 2025
 21:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913105252.26886-1-opensource206@gmail.com>
In-Reply-To: <20250913105252.26886-1-opensource206@gmail.com>
From: opensource india <opensource206@gmail.com>
Date: Sat, 27 Sep 2025 10:21:45 +0530
X-Gm-Features: AS18NWAPIz4Qm4NSsV8CiHzqke_kDp_O__t3_2Y2vrCLGILRVMW5O14YMaRdA54
Message-ID: <CAKPKb882DgYB2fZXRDU_y1Xqz6GtFEErvzzET9eOAm=db0ns1g@mail.gmail.com>
Subject: Re: [PATCH v3] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
To: mchehab@kernel.org, hverkuil@kernel.org, ribalda@chromium.org, 
	laurent.pinchart@ideasonboard.com, yunkec@google.com, 
	sakari.ailus@linux.intel.com, james.cowgill@blaize.com, hansg@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 4:23=E2=80=AFPM Pavan Bobba <opensource206@gmail.co=
m> wrote:
>
> Complete the "TODO: PROFILES" by enforcing profile-specific and
> monochrome constraints as defined by the AV1 specification
> (Section 5.5.2, "Color config syntax").
>
> The validator now checks:
>
>  - Flags: reject any unknown bits set in sequence->flags
>  - Profile range: only profiles 0..2 are valid
>  - Profile 0: 8/10-bit only, subsampling must be 4:2:0 (sx=3D1, sy=3D1),
>    monochrome allowed
>  - Profile 1: 8/10-bit only, subsampling must be 4:4:4 (sx=3D0, sy=3D0),
>    monochrome forbidden
>  - Profile 2:
>     * 8/10-bit: only 4:2:2 allowed (sx=3D1, sy=3D0)
>     * 12-bit: 4:4:4 (sx=3D0, sy=3D0), 4:2:2 (sx=3D1, sy=3D0), or 4:2:0 (s=
x=3D1, sy=3D1)
>       allowed
>  - Monochrome path (all profiles except 1): forces subsampling_x=3D1,
>    subsampling_y=3D1, separate_uv_delta_q=3D0
>
> These checks prevent userspace from providing invalid AV1 sequence
> headers that would otherwise be accepted, leading to undefined driver
> or hardware behavior.
>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
> v1 -> v2 : Added more checks for subsampling combinations per profile.
>          : Added a TODO note in the function header for checks to be impl=
emented later.
>
> v2 -> v3 : Patch generated properly with all the changes
>
>  drivers/media/v4l2-core/v4l2-ctrls-core.c | 125 +++++++++++++++++-----
>  1 file changed, 100 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4=
l2-core/v4l2-ctrls-core.c
> index 98b960775e87..fa03341588e4 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -827,39 +827,114 @@ static int validate_av1_frame(struct v4l2_ctrl_av1=
_frame *f)
>         return 0;
>  }
>
> +/**
> + * validate_av1_sequence - validate AV1 sequence header fields
> + * @s: control struct from userspace
> + *
> + * Implements AV1 spec =C2=A75.5.2 color_config() checks that are
> + * possible with the current v4l2_ctrl_av1_sequence definition.
> + *
> + * TODO: extend validation once additional fields such as
> + *       color_primaries, transfer_characteristics,
> + *       matrix_coefficients, and chroma_sample_position
> + *       are added to the uAPI.
> + *
> + * Returns 0 if valid, -EINVAL otherwise.
> + */
>  static int validate_av1_sequence(struct v4l2_ctrl_av1_sequence *s)
>  {
> -       if (s->flags &
> -       ~(V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE |
> -        V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF |
> -        V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION |
> -        V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME |
> -        V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE |
> -        V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
> -        V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y |
> -        V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT |
> -        V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
> -               return -EINVAL;
> +       const bool mono  =3D s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROM=
E;
> +       const bool sx    =3D s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLIN=
G_X;
> +       const bool sy    =3D s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLIN=
G_Y;
> +       const bool uv_dq =3D s->flags & V4L2_AV1_SEQUENCE_FLAG_SEPARATE_U=
V_DELTA_Q;
>
> -       if (s->seq_profile =3D=3D 1 && s->flags & V4L2_AV1_SEQUENCE_FLAG_=
MONO_CHROME)
> +       /* 1. Reject unknown flags */
> +       if (s->flags &
> +           ~(V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE |
> +             V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF |
> +             V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION |
> +             V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME |
> +             V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE |
> +             V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
> +             V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y |
> +             V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT |
> +             V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
>                 return -EINVAL;
>
> -       /* reserved */
> +       /* 2. Profile range */
>         if (s->seq_profile > 2)
>                 return -EINVAL;
>
> -       /* TODO: PROFILES */
> +       /* 3. Monochrome shortcut */
> +       if (mono) {
> +               /* Profile 1 forbids monochrome */
> +               if (s->seq_profile =3D=3D 1)
> +                       return -EINVAL;
> +
> +               /* Mono =E2=86=92 subsampling must look like 4:0:0: sx=3D=
1, sy=3D1 */
> +               if (!sx || !sy)
> +                       return -EINVAL;
> +
> +               /* separate_uv_delta_q must be 0 */
> +               if (uv_dq)
> +                       return -EINVAL;
> +
> +               return 0;
> +       }
> +
> +       /* 4. Profile-specific rules */
> +       switch (s->seq_profile) {
> +       case 0:
> +               /* Profile 0: only 8/10-bit, subsampling=3D4:2:0 (sx=3D1,=
 sy=3D1) */
> +               if (s->bit_depth !=3D 8 && s->bit_depth !=3D 10)
> +                       return -EINVAL;
> +               if (!(sx && sy))
> +                       return -EINVAL;
> +               break;
> +
> +       case 1:
> +               /* Profile 1: only 8/10-bit, subsampling=3D4:4:4 (sx=3D0,=
 sy=3D0) */
> +               if (s->bit_depth !=3D 8 && s->bit_depth !=3D 10)
> +                       return -EINVAL;
> +               if (sx || sy)
> +                       return -EINVAL;
> +               break;
> +
> +       case 2:
> +               /* Profile 2: 8/10/12-bit allowed */
> +               if (s->bit_depth !=3D 8 && s->bit_depth !=3D 10 &&
> +                   s->bit_depth !=3D 12)
> +                       return -EINVAL;
> +
> +               if (s->bit_depth =3D=3D 12) {
> +                       if (!sx) {
> +                               /* 4:4:4 =E2=86=92 sy must be 0 */
> +                               if (sy)
> +                                       return -EINVAL;
> +                       } else {
> +                               /* sx=3D1 =E2=86=92 sy=3D0 (4:2:2) or sy=
=3D1 (4:2:0) */
> +                               if (sy !=3D 0 && sy !=3D 1)
> +                                       return -EINVAL;
> +                       }
> +               } else {
> +                       /* 8/10-bit =E2=86=92 only 4:2:2 allowed (sx=3D1,=
 sy=3D0) */
> +                       if (!(sx && !sy))
> +                               return -EINVAL;
> +               }
> +               break;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
Hi all,
  It has been a couple of weeks since I sent this patch. Could anyone
please review it?

