Return-Path: <linux-kernel+bounces-798303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7BCB41C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6286849AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F42F1FE2;
	Wed,  3 Sep 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSr4pE4D"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE061E5206;
	Wed,  3 Sep 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896081; cv=none; b=kLyI54iC1tyJE3p+z+NgoEKNyplZeCSKRBsl8PLmrOSTqBJ57cca20/CCoCmWI/xeMMphcpVswmxqZKEXLOe+goYzcpV6F/jAL7UvU0yiZUqSwj3oRctO/w026afx/dHG/VRjv/aTy++7nr6Va7IsS2Qy66i6iysTq5yngVnho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896081; c=relaxed/simple;
	bh=cQ5AxTNObd/Ros3LgbI1d2H9KbaWvkEuSSK99ckKyZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=di2BFh681IjW7tqvQatHWlmizsxErX1ZsK1GgBrHYS6OxFtKxOnHh+adne22kuhDxiE9gvQ4bGzc4QMCoTggnU7+buhSRIbHi/corX5Hy2XgnPJAXYg8XmH8+6aOMrQkcDc66hBONM67GhaUFMEt1NHBVjp/u9z/R4tq3gJyXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSr4pE4D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so9676385ad.0;
        Wed, 03 Sep 2025 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756896079; x=1757500879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0EPRZe8YJObgeqfHix/soVRNAxr+rVxG0fDuUG583s=;
        b=JSr4pE4DJAelgsOFQLCl9PTMAmOEWjINBaA0MxebU4uBde2i91d3UO/11Jj9V7rJMN
         tZLVqgkiFUauJNzyX9ZGJNMETg1lwWNj4oVuy25OzpkcYvB/rbADohz7vWRi1eSse6In
         +7WfA+kVcZrBHwKLPQ+Sn3OiKKzRdgt+XuF0WO/jAgPyYCuElbXMhFW/2GM4YGcO7Rv8
         Q6FgMeDo9OJyn3UWXK/NFbcCJ3yX5umwiNBdmodXv6Vj6sVBH9h7tY+59KetT/oVq7Pq
         lStxiL4X910lIPgwYoDXSMGBDjt2iQ7vkN6kBR60m0S0X6L2yl5DLsB6gEqH5PeFDrcR
         7TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896079; x=1757500879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0EPRZe8YJObgeqfHix/soVRNAxr+rVxG0fDuUG583s=;
        b=JFrbPQcEYiqIVallhg2SKaRY/glbyLqvmUrzG/IJUOCdhLorv7e+MRavrBstr/+O9D
         JCvO4coTWBjWpmitH0o0outBE6pt3c48gNQstMUViRvNAR/lOeRDjnp+JvrwtTPdNR1h
         Tg5YDjeiGEWXHdvtJm9vaper4tFN/hVU5HaiXauZrq3CyC95LNmXN5qQ0s9IFPrel4sQ
         ABFa93QB7/lkxN66Y3Pc0I0qLf+NJto0c7CYYMiZQPH1tTSAxTUwNfd/4uNhsf3K32uA
         J0cIoBQ4ezAG8qlZqfF9oUd2APE6R19fhCuVL0fFtl5jBjx+VWg/eTvcTMJ/k0gyKvpP
         AX7w==
X-Forwarded-Encrypted: i=1; AJvYcCV8kp2iLbqc8JgmXdI0932avydv0+RMGcH8YCIbbfYuSXVzzIMsIaMm81tH/zY4y+J9tcQ76Yd1kUYlPHMc@vger.kernel.org, AJvYcCVk9JfyDD2Qhy3C/dyJ510qCBk9LL+7CcItgkiSxTxPmMT3JJHBh8My35NWEsF7pp/JgGBIWoyOXHCG6QA=@vger.kernel.org, AJvYcCXQiB1xldv9JmKjQ8Mq0Cp/Cc5eHsoYX9/KRNEC7OopVs31pXGuOUNMaQTWc0DBBcNu8m5WhVaE2Ci8@vger.kernel.org
X-Gm-Message-State: AOJu0YyqY+PJPUmEtftUTowvUP9jDA2OXxJ0eIH9PM1ozzh4dqmnkQgJ
	j0REJb1D7vAR9Qz17ciVybaRCNE/lSJGWBVnCGFcDBhFJCq71wq2IBwOMscxTkItMmdmR1+RLf8
	bkGLZI3zUfiCUQ8AK6KWTfLLW8hMPZ0M=
X-Gm-Gg: ASbGncudKiBjQhNG10u7P0nytkzKSPZhGfdAdUrBKPfFsStS6gTMXKNkmKbRbXGhMNF
	emG12IbMFNFFpOtDhi6nSoMRGx2C/aTXQah+wn9oQEuXzUUkaPGRYsXT/125MSpdAYVE7hXipMK
	O2s1Vtc+zVguKL2mFfgKnqWGjV3g5YSgyZc0sIuCE9lyUE9X+3yMgii9g3WrWcjVxrT0Uh7ogNi
	cpPf5U=
X-Google-Smtp-Source: AGHT+IFBlgHU9/9J/ynH5B/Y0lYKvN7CIRjLzFRFLjCUSdV7/phYhX05by3bq36srAY3SNogU76UhQZ1T1/Qk7whF0E=
X-Received: by 2002:a17:902:e891:b0:246:2da9:73a2 with SMTP id
 d9443c01a7336-2493eff73d7mr197893025ad.27.1756896079484; Wed, 03 Sep 2025
 03:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
 <20250821073131.2550798-5-shengjiu.wang@nxp.com> <20250901185208.394cd162@booty>
In-Reply-To: <20250901185208.394cd162@booty>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 3 Sep 2025 18:41:05 +0800
X-Gm-Features: Ac12FXx8o6RDyP5im-Wa5RK1y5nzjHR2o5AyrKxsM3tEIkvqqNNrZcDYhIoBDY8
Message-ID: <CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958()
 for iec958 format
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, victor.liu@nxp.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	devicetree@vger.kernel.org, l.stach@pengutronix.de, perex@perex.cz, 
	tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Shengjiu,
>
> On Thu, 21 Aug 2025 15:31:28 +0800
> Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > Add API dw_hdmi_set_sample_iec958() for IEC958 format because audio dev=
ice
> > driver needs IEC958 information to configure this specific setting.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Acked-by: Liu Ying <victor.liu@nxp.com>
>
> [...]
>
> > +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int iec9=
58)
> > +{
> > +     mutex_lock(&hdmi->audio_mutex);
> > +     hdmi->sample_iec958 =3D iec958;
> > +     mutex_unlock(&hdmi->audio_mutex);
> > +}
>
> Apologies for jumping in the discussion as late as in v5, but I noticed
> this patch and I was wondering whether this mutex_lock/unlock() is
> really needed, as you're copying an int.

Thanks for your comments.

Seems it is not necessary to add mutex here. I just follow the code as
other similar functions.  I will send a new version to update it.

Best regards
Shengjiu Wang

Shengjiu Wang
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

