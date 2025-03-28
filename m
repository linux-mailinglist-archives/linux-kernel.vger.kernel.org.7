Return-Path: <linux-kernel+bounces-579533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2EA744C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 08:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074C1168AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B2212B21;
	Fri, 28 Mar 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjgwztCl"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2C212B0E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743148143; cv=none; b=eVhFpINIyMmnxIJZXrV7lkR9Ei+tO/BPlnE76tXl9G1m1r2Kv1eBey1XrHJWfs82cIYyuqxMKy2TExEHxhOb2hmUOBfSA6b0SauR3Sk8hiTHlb3X/G7lO1WgcdQvtU/MCJ4ayYPOeHt9FZehXR7b55MpqhMOpwAoM7PnAWJei18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743148143; c=relaxed/simple;
	bh=qKnrR5bKdA5ZY0IYjXTXXtcdBWXqslK8kbHKGR2H1G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYaehnq5tV0z1PLZW57SqZ+GA/pHzT95x9JEawxupr8tbHyQvPN8TrskiNJAiMytTzMexNica0hEL1SNCapLllK07cOkdLs7/hbZd8N4zVWJsTCJCTdW92LLnULDv4SDoAXEwQla/aW1iuj1aClnnmcp9FbIB4tIAO04AcW+HKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjgwztCl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30185d00446so2536405a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743148141; x=1743752941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7ELtixWISfVyPCCwdGnm5LZ7B55xHnCnByUBGZyAU8=;
        b=PjgwztClnNPizNtgg+jZEQ1qCkhjTLE18Up55UPGxe/9eCWjD98EDYoeDzrf8wToLT
         ETj0YEv56kcCLe1zqwC0Ztz6DqWvDFcC0AGLvPhgUD6UN7375nW/u/U37MpunUdbZbVg
         PoGbWOJO51w2jWmnGClodnvi0MeRcq1g47q47zQAIxxEkdRGHmS5dh3SFV60DYJrGA3i
         rMwYB7vbrUriXyKdtxw408nkWJGje369i8w6IuqwC9l9W/16PivrZBkAqIJCj9KseKZh
         upYxQjhWI4rz0qU00wydxSPDOT7Q4RkeSOjfzSETh6BI4k8FIAiChQ1rciEKA8hwZo1A
         lhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743148141; x=1743752941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7ELtixWISfVyPCCwdGnm5LZ7B55xHnCnByUBGZyAU8=;
        b=R6stpR2VeI7MZCvWvRTVyjYpLMr/2MqXFLVMiECBm1ng9hPuv6TX4KpC+oobHEqhYi
         xY6pcU3k6gNo7/U3TVkx1Hu7Nr2z7USSORthKY+B4eMc00+2fA868C3kZEzruRAz3U7+
         RxbI+MJcGvNM4JUXt49rgoqNK010t1qAgmGt1be+bS2DlDznN/1Z9lv2nnCsCLJ4vzGx
         8YE6HgrJ0OQJEGb6C0J8l7MASZdpAiP78Xwd0Irq8NjcSu7IoeE3NkzuvaQsnrvfcu1P
         a7EK/b5qQ0aJjKqI9vRGHNUfJol0xKEcxNNrEbJlwOhbRluX+YkTJRuk9zKu6tcRGRNi
         0CTA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1E8PNO5qc/QG8evfFtkEQXlCWZ1vBsDzrmOM6eIncdkIGw8L+bLYMw9rZ6RArEuN1ics8zYaKPbEcSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjC943lXgtuT9wnONbRFLoH0u0IxKt68Q5wGBMnjg9HfYDjcXw
	YE2/N0hBX6NNSnQbqbzPg6TxKp7DFz+0M4eVmlDQL+iAn+u2PeZTrUQIGgV+MU/RuVxeYKKXcO8
	l/l8ZFhbyZ7fOv0AlkPuFVhhYWowp3a5h6vwU
X-Gm-Gg: ASbGncsDgmXIRkBl2k/v7BTUX63TC6u1dIofXRvw3FIIpm7NoEheFGm8xk2o9z3qd7T
	EZAATLpHbTdKpAkia5Vdob4HhRCD3QF157swh6I+iS6xxwSv6hO9XC3nwLZuEY04qjGhEj1LKvR
	4Ieo+2OFpI67ihXrnQV3kJfk1Q14z5kIGeK8q4j0fAdG3thGIeWyj+bNU5
X-Google-Smtp-Source: AGHT+IEbZ0qteYBHU5qhFmsOW68PoLBHHt2USrYRKQFaW1GqrElYp+1C0YMsYmQ1IWjIEbQX5zJvdTFc9EsKsjVT/4o=
X-Received: by 2002:a17:90a:dfc7:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-3051c85e607mr3062834a91.3.1743148140746; Fri, 28 Mar 2025
 00:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319005141.312805-1-quic_wcheng@quicinc.com> <20250319005141.312805-9-quic_wcheng@quicinc.com>
In-Reply-To: <20250319005141.312805-9-quic_wcheng@quicinc.com>
From: Puma Hsu <pumahsu@google.com>
Date: Fri, 28 Mar 2025 15:47:00 +0800
X-Gm-Features: AQ5f1JofWcF_GfjK5GKdSJic-DMlF-I_Ti_mbmoYNzFQEA4M7vpQFdiy9GHI5pc
Message-ID: <CAGCq0LYs5=Re74G99n3=Vbdu1Q2M5-SKZqXTgPKJZYtSHjXZPA@mail.gmail.com>
Subject: Re: [PATCH v36 08/31] ALSA: usb-audio: Export USB SND APIs for modules
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, corbet@lwn.net, 
	broonie@kernel.org, lgirdwood@gmail.com, krzk+dt@kernel.org, 
	pierre-louis.bossart@linux.intel.com, Thinh.Nguyen@synopsys.com, 
	tiwai@suse.com, robh@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:52=E2=80=AFAM Wesley Cheng <quic_wcheng@quicinc.c=
om> wrote:
>
> Some vendor modules will utilize useful parsing and endpoint management
> APIs to start audio playback/capture.
>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Tested-by: Puma Hsu <pumahsu@google.com>

> ---
>  sound/usb/card.c     |  4 +++
>  sound/usb/endpoint.c |  1 +
>  sound/usb/helper.c   |  1 +
>  sound/usb/pcm.c      | 75 +++++++++++++++++++++++++++++++-------------
>  sound/usb/pcm.h      | 11 +++++++
>  5 files changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 9c411b82a218..a0087bde684c 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -1030,6 +1030,7 @@ int snd_usb_lock_shutdown(struct snd_usb_audio *chi=
p)
>                 wake_up(&chip->shutdown_wait);
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_lock_shutdown);
>
>  /* autosuspend and unlock the shutdown */
>  void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
> @@ -1038,6 +1039,7 @@ void snd_usb_unlock_shutdown(struct snd_usb_audio *=
chip)
>         if (atomic_dec_and_test(&chip->usage_count))
>                 wake_up(&chip->shutdown_wait);
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_unlock_shutdown);
>
>  int snd_usb_autoresume(struct snd_usb_audio *chip)
>  {
> @@ -1060,6 +1062,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
>         }
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_autoresume);
>
>  void snd_usb_autosuspend(struct snd_usb_audio *chip)
>  {
> @@ -1073,6 +1076,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip=
)
>         for (i =3D 0; i < chip->num_interfaces; i++)
>                 usb_autopm_put_interface(chip->intf[i]);
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
>
>  static int usb_audio_suspend(struct usb_interface *intf, pm_message_t me=
ssage)
>  {
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index a29f28eb7d0c..1fed039b10ed 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -1524,6 +1524,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *=
chip,
>         mutex_unlock(&chip->mutex);
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
>
>  /* get the current rate set to the given clock by any endpoint */
>  int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int cloc=
k)
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index 72b671fb2c84..497d2b27fb59 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen,=
 void *after, u8 dsubtype
>         }
>         return NULL;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
>
>  /*
>   * Wrapper for usb_control_msg().
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 08bf535ed163..18467da6fd9e 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -148,6 +148,16 @@ find_format(struct list_head *fmt_list_head, snd_pcm=
_format_t format,
>         return found;
>  }
>
> +const struct audioformat *
> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t fo=
rmat,
> +                   unsigned int rate, unsigned int channels, bool strict=
_match,
> +                   struct snd_usb_substream *subs)
> +{
> +       return find_format(fmt_list_head, format, rate, channels, strict_=
match,
> +                       subs);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_format);
> +
>  static const struct audioformat *
>  find_substream_format(struct snd_usb_substream *subs,
>                       const struct snd_pcm_hw_params *params)
> @@ -157,6 +167,14 @@ find_substream_format(struct snd_usb_substream *subs=
,
>                            true, subs);
>  }
>
> +const struct audioformat *
> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
> +                             const struct snd_pcm_hw_params *params)
> +{
> +       return find_substream_format(subs, params);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_substream_format);
> +
>  bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
>  {
>         const struct audioformat *fp;
> @@ -461,20 +479,9 @@ static void close_endpoints(struct snd_usb_audio *ch=
ip,
>         }
>  }
>
> -/*
> - * hw_params callback
> - *
> - * allocate a buffer and set the given audio format.
> - *
> - * so far we use a physically linear buffer although packetize transfer
> - * doesn't need a continuous area.
> - * if sg buffer is supported on the later version of alsa, we'll follow
> - * that.
> - */
> -static int snd_usb_hw_params(struct snd_pcm_substream *substream,
> -                            struct snd_pcm_hw_params *hw_params)
> +int snd_usb_hw_params(struct snd_usb_substream *subs,
> +                     struct snd_pcm_hw_params *hw_params)
>  {
> -       struct snd_usb_substream *subs =3D substream->runtime->private_da=
ta;
>         struct snd_usb_audio *chip =3D subs->stream->chip;
>         const struct audioformat *fmt;
>         const struct audioformat *sync_fmt;
> @@ -499,7 +506,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream=
 *substream,
>         if (fmt->implicit_fb) {
>                 sync_fmt =3D snd_usb_find_implicit_fb_sync_format(chip, f=
mt,
>                                                                 hw_params=
,
> -                                                               !substrea=
m->stream,
> +                                                               !subs->di=
rection,
>                                                                 &sync_fix=
ed_rate);
>                 if (!sync_fmt) {
>                         usb_audio_dbg(chip,
> @@ -579,15 +586,28 @@ static int snd_usb_hw_params(struct snd_pcm_substre=
am *substream,
>
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_hw_params);
>
>  /*
> - * hw_free callback
> + * hw_params callback
>   *
> - * reset the audio format and release the buffer
> + * allocate a buffer and set the given audio format.
> + *
> + * so far we use a physically linear buffer although packetize transfer
> + * doesn't need a continuous area.
> + * if sg buffer is supported on the later version of alsa, we'll follow
> + * that.
>   */
> -static int snd_usb_hw_free(struct snd_pcm_substream *substream)
> +static int snd_usb_pcm_hw_params(struct snd_pcm_substream *substream,
> +                                struct snd_pcm_hw_params *hw_params)
>  {
>         struct snd_usb_substream *subs =3D substream->runtime->private_da=
ta;
> +
> +       return snd_usb_hw_params(subs, hw_params);
> +}
> +
> +int snd_usb_hw_free(struct snd_usb_substream *subs)
> +{
>         struct snd_usb_audio *chip =3D subs->stream->chip;
>
>         snd_media_stop_pipeline(subs);
> @@ -603,6 +623,19 @@ static int snd_usb_hw_free(struct snd_pcm_substream =
*substream)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(snd_usb_hw_free);
> +
> +/*
> + * hw_free callback
> + *
> + * reset the audio format and release the buffer
> + */
> +static int snd_usb_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +       struct snd_usb_substream *subs =3D substream->runtime->private_da=
ta;
> +
> +       return snd_usb_hw_free(subs);
> +}
>
>  /* free-wheeling mode? (e.g. dmix) */
>  static int in_free_wheeling_mode(struct snd_pcm_runtime *runtime)
> @@ -1746,8 +1779,8 @@ static int snd_usb_substream_capture_trigger(struct=
 snd_pcm_substream *substream
>  static const struct snd_pcm_ops snd_usb_playback_ops =3D {
>         .open =3D         snd_usb_pcm_open,
>         .close =3D        snd_usb_pcm_close,
> -       .hw_params =3D    snd_usb_hw_params,
> -       .hw_free =3D      snd_usb_hw_free,
> +       .hw_params =3D    snd_usb_pcm_hw_params,
> +       .hw_free =3D      snd_usb_pcm_hw_free,
>         .prepare =3D      snd_usb_pcm_prepare,
>         .trigger =3D      snd_usb_substream_playback_trigger,
>         .sync_stop =3D    snd_usb_pcm_sync_stop,
> @@ -1758,8 +1791,8 @@ static const struct snd_pcm_ops snd_usb_playback_op=
s =3D {
>  static const struct snd_pcm_ops snd_usb_capture_ops =3D {
>         .open =3D         snd_usb_pcm_open,
>         .close =3D        snd_usb_pcm_close,
> -       .hw_params =3D    snd_usb_hw_params,
> -       .hw_free =3D      snd_usb_hw_free,
> +       .hw_params =3D    snd_usb_pcm_hw_params,
> +       .hw_free =3D      snd_usb_pcm_hw_free,
>         .prepare =3D      snd_usb_pcm_prepare,
>         .trigger =3D      snd_usb_substream_capture_trigger,
>         .sync_stop =3D    snd_usb_pcm_sync_stop,
> diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
> index 388fe2ba346d..c096021adb2b 100644
> --- a/sound/usb/pcm.h
> +++ b/sound/usb/pcm.h
> @@ -15,4 +15,15 @@ void snd_usb_preallocate_buffer(struct snd_usb_substre=
am *subs);
>  int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
>                                     struct audioformat *fmt);
>
> +const struct audioformat *
> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t fo=
rmat,
> +                   unsigned int rate, unsigned int channels, bool strict=
_match,
> +                   struct snd_usb_substream *subs);
> +const struct audioformat *
> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
> +                             const struct snd_pcm_hw_params *params);
> +
> +int snd_usb_hw_params(struct snd_usb_substream *subs,
> +                     struct snd_pcm_hw_params *hw_params);
> +int snd_usb_hw_free(struct snd_usb_substream *subs);
>  #endif /* __USBAUDIO_PCM_H */
>

