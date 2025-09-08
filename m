Return-Path: <linux-kernel+bounces-806263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57537B49458
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E81C7A99BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D16F30ACEF;
	Mon,  8 Sep 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjkpK71S"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06962ECEAC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346903; cv=none; b=Uo0IZvJoVUZ5m6M7NeHgLRZ3W+oK/YR18u+dKZCjtmfpwoqOPTOrx7NXH+JXAUZsuFgG0E3vylWIyBgmXVs+5IrMUMoKbwiGiz63KwNRkl1ypYlTT0gQqpYjdlGKZI1/xn9WEiFuwHjMw9NjZMQqycUgdK26df/k/9XAm/1nKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346903; c=relaxed/simple;
	bh=CS00lYhJ/JI5qKzMwFjNeQzKhbAph8tswKHiCA52zAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5LEJm13bKwFtpzeYzetSWGM8FmNvwGWjNbBrBf27fSfcOSENZR+LICINvPujKh86bli0aUKxuXJZzb819n/NpNA6GIs1Hvn+V4wzb5PVQuCcBRqfDcHFMbrrJubyrqLMX4eYXEWuN3avYU6OVpzJ4W/Wa11bgzwBstCJwHbDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjkpK71S; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32d69b5d737so222326a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346901; x=1757951701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncy8rMYMPoo6qD4OwV7z755Sx/k/Cp6xU0Sc/P4F2ss=;
        b=fjkpK71S5DpGykTtYh46fZWOtKhteNpBsB/2ZbDV+am94wZv+K4a1/Vz5gi3AtPBpd
         O862qxZxrGSDKXqkS8XPIDALQVzGJ+kKyePqOeBofP9X5sAKcpDKiuDuClmvX4SglQWw
         +Bhf32QhtV8/L9XmI02RNBN1LM3xbqivCfxLxWjhD6VsXIAr8MvC4ToruMsdYY2MJ9jQ
         Gvsnj/DfCu1NkXbxDbQ8M9X3kfisVDh6gmpt68FOYcCOWQt8Qf+NknR2zpLabqyvFV+e
         OS6N/matF2P7E/OvvwQTIwa4tit0sKOyTWxGIoHWVGHzwMRqtsWOV+7yq2W1hXxcLNdk
         +ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346901; x=1757951701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncy8rMYMPoo6qD4OwV7z755Sx/k/Cp6xU0Sc/P4F2ss=;
        b=nmZOtukW4ZS3y84W2GucrplH/MEHzgBK65GVvnbhINpdCjmjRXoUsu5t70AuccBUvv
         JF8+QQSqczFAT6hHOGox8tTtoKXqdY3QVK8Nzp8vYwBgXG9BrHnGeUryUJ9vICDjs7g9
         PEedrMWeeduJKD7+KewL4RT+xOrRa/kR4dxLnLRdjvDKI9pR/HbeWODeYW0+RF/v/Shf
         +ojRPTxSE726Ewg6T7+6WPbuUP5z198lyU5dvmlxLUfGmhpcv+MBtZh7AuHiPb9KrRa+
         uTwjOOKm/X1uTgHtVI5U2O1V9sTA5n2QHsVyYwf4cMpRC85YiL+b4c0t533Gzb5l98u8
         6HwA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BCwSjd2opVAt3NwA7OfNYtAbGTGfPv+6MTJKI10zaih77LvFoaBqsXwQixdfHNWBz+/9NOFtjPOijA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFdztmZPoVyxMk7JSawsbf0FoxFxIeG0b8j7zv/XihIJTkEYK
	yXf9aLWZVD46MKIj9pUALA8H3mkzVtvSW5SglKMa5jP/tJJgbQCSG9rt4apC0u7LRX4yCXvhjeS
	5Qkl7gv2s4LbBbZklye26Y7dD4dD7yBI=
X-Gm-Gg: ASbGnctXv7KtEAi2z0f65X86b7et5g8cnJzng/XJOljGSbvi9ZNLx/hsgymNQa99Ncg
	pOUJj8SyNRZ8+fUqBNcLgzq9+mLHcjvO7wRKi6Z1zlmNKjivzp6KHk6jB1AvVa3WHq8Ohxks0kP
	j1DbbVXledrQPJRlfTF8pRjInFZxc9tCczs5Cfv5iMy0HmdhTsTAVgO5VXUJ3MDZntkhSW6emwf
	Mb6gKWILojHWPy9CQ==
X-Google-Smtp-Source: AGHT+IGZSQ5JJVv+TntNrNjXPczNaBQa/rBlW+/B4duhLKucX8M6mTF04KFFT56z8aAM798hVCMz9iyyyiTT/FE7BWQ=
X-Received: by 2002:a17:90b:38cb:b0:32b:dcef:f65f with SMTP id
 98e67ed59e1d1-32d43f772e8mr6052003a91.3.1757346901055; Mon, 08 Sep 2025
 08:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com> <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-7-631b1080bf91@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Mon, 8 Sep 2025 11:54:49 -0400
X-Gm-Features: Ac12FXwZh4Knfa5C5jRkwC4PMADG3bi9JxMMu92KfaQYtzGrloYElebo2U4Ct24
Message-ID: <CACu1E7H_K0WbWsHDqD44YfyMvc9bfZon-Tx75LkBFqWdG2YZ=Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] drm/msm/adreno: Add fenced regwrite support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Antonino Maniscalco <antomani103@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:27=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcomm=
.com> wrote:
>
> There are some special registers which are accessible even when GX power
> domain is collapsed during an IFPC sleep. Accessing these registers
> wakes up GPU from power collapse and allow programming these registers
> without additional handshake with GMU. This patch adds support for this
> special register write sequence.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 80 +++++++++++++++++++++++++=
+++++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++----
>  3 files changed, 90 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 45dd5fd1c2bfcb0a01b71a326c7d95b0f9496d99..a63dad80ef461da45d5c41a04=
2ed4f19d8282ef5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -16,6 +16,84 @@
>
>  #define GPU_PAS_ID 13
>
> +static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 valu=
e, u32 status, u32 mask)
> +{
> +       /* Success if !writedropped0/1 */
> +       if (!(status & mask))
> +               return true;
> +
> +       udelay(10);
> +
> +       /* Try to update fenced register again */
> +       gpu_write(gpu, offset, value);
> +
> +       /* We can't do a posted write here because the power domain could=
 be
> +        * in collapse state. So use the heaviest barrier instead
> +        */
> +       mb();
> +       return false;
> +}
> +
> +static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value=
, u32 mask)
> +{
> +       struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
> +       struct msm_gpu *gpu =3D &adreno_gpu->base;
> +       struct a6xx_gmu *gmu =3D &a6xx_gpu->gmu;
> +       u32 status;
> +
> +       gpu_write(gpu, offset, value);
> +
> +       /* Nothing else to be done in the case of no-GMU */
> +       if (adreno_has_gmu_wrapper(adreno_gpu))
> +               return 0;
> +
> +       /* We can't do a posted write here because the power domain could=
 be
> +        * in collapse state. So use the heaviest barrier instead
> +        */
> +       mb();
> +
> +       if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
> +                       fence_status_check(gpu, offset, value, status, ma=
sk), 0, 1000))
> +               return 0;
> +
> +       /* Try again for another 1ms before failing */
> +       gpu_write(gpu, offset, value);
> +       mb();
> +
> +       if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
> +                       fence_status_check(gpu, offset, value, status, ma=
sk), 0, 1000)) {
> +               /*
> +                * The 'delay' warning is here because the pause to print=
 this
> +                * warning will allow gpu to move to power collapse which
> +                * defeats the purpose of continuous polling for 2 ms
> +                */
> +               dev_err_ratelimited(gmu->dev, "delay in fenced register w=
rite (0x%x)\n",
> +                               offset);
> +               return 0;
> +       }
> +
> +       dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\=
n",
> +                       offset);
> +
> +       return -ETIMEDOUT;
> +}
> +
> +int a6xx_fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u64 value, =
u32 mask, bool is_64b)
> +{
> +       int ret;
> +
> +       ret =3D fenced_write(a6xx_gpu, offset, lower_32_bits(value), mask=
);
> +       if (ret)
> +               return ret;
> +
> +       if (!is_64b)
> +               return 0;
> +
> +       ret =3D fenced_write(a6xx_gpu, offset + 1, upper_32_bits(value), =
mask);
> +
> +       return ret;
> +}
> +
>  static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -86,7 +164,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm=
_ringbuffer *ring)
>         /* Update HW if this is the current ring and we are not in preemp=
t*/
>         if (!a6xx_in_preempt(a6xx_gpu)) {
>                 if (a6xx_gpu->cur_ring =3D=3D ring)
> -                       gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
> +                       a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, =
wptr, BIT(0), false);
>                 else
>                         ring->restore_wptr =3D true;
>         } else {
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.h
> index 6e71f617fc3d0d564e51650dfed63a18f31042ac..e736c59d566b3fcf8c62a2124=
94e3b110c09caa9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -295,5 +295,6 @@ int a6xx_gpu_state_put(struct msm_gpu_state *state);
>
>  void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, =
bool gx_off);
>  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
> +int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 m=
ask, bool is_64b);

"mask" makes it sound like it's the mask for a masked write, which it
isn't. At least in the public API I'd name it something more explicit
like "fence_status_mask". Also it would be nice to add defines like
GMU_FENCE_STATUS_WPTR/CONTEXT_SWITCH to make the parameter values in
callsites less magical. Finally, this might be personal preference,
but it's not immediately obvious what the "true"/"false" in callsites
mean, so it would make users clearer to add a separate
"a6xx_fenced_write64" and make 64-bit reg writes use that instead of
is_64b.

Connor

>
>  #endif /* __A6XX_GPU_H__ */
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/=
msm/adreno/a6xx_preempt.c
> index 6a12a35dabff1e64aae8440c2a8c88f5feb4803e..10625ffbc4cfc26edc36efcf1=
1dbb4efd55ab3e0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -41,7 +41,7 @@ static inline void set_preempt_state(struct a6xx_gpu *g=
pu,
>  }
>
>  /* Write the most recent wptr for the given ring into the hardware */
> -static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffe=
r *ring)
> +static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_rin=
gbuffer *ring)
>  {
>         unsigned long flags;
>         uint32_t wptr;
> @@ -51,7 +51,7 @@ static inline void update_wptr(struct msm_gpu *gpu, str=
uct msm_ringbuffer *ring)
>         if (ring->restore_wptr) {
>                 wptr =3D get_wptr(ring);
>
> -               gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
> +               a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BI=
T(0), false);
>
>                 ring->restore_wptr =3D false;
>         }
> @@ -172,7 +172,7 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
>
>         set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
>
> -       update_wptr(gpu, a6xx_gpu->cur_ring);
> +       update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
>
>         set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>
> @@ -268,7 +268,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>          */
>         if (!ring || (a6xx_gpu->cur_ring =3D=3D ring)) {
>                 set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
> -               update_wptr(gpu, a6xx_gpu->cur_ring);
> +               update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
>                 set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>                 spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
>                 return;
> @@ -302,13 +302,13 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>
>         spin_unlock_irqrestore(&ring->preempt_lock, flags);
>
> -       gpu_write64(gpu,
> -               REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO,
> -               a6xx_gpu->preempt_smmu_iova[ring->id]);
> +       a6xx_fenced_write(a6xx_gpu,
> +               REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_s=
mmu_iova[ring->id],
> +               BIT(1), true);
>
> -       gpu_write64(gpu,
> +       a6xx_fenced_write(a6xx_gpu,
>                 REG_A6XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
> -               a6xx_gpu->preempt_iova[ring->id]);
> +               a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
>
>         a6xx_gpu->next_ring =3D ring;
>
> @@ -328,7 +328,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
>         set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
>
>         /* Trigger the preemption */
> -       gpu_write(gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl);
> +       a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl=
, BIT(1), false);
>  }
>
>  static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,
>
> --
> 2.50.1
>

