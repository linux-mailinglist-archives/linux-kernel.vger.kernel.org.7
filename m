Return-Path: <linux-kernel+bounces-799952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D0B43192
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEC31B24CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F923D7DA;
	Thu,  4 Sep 2025 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hS9FFr2T"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93A227B94
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963653; cv=none; b=UQYBN+6k1ax2JjXZpDVemOQjFOy7ufgVs6ENj6W/wfC5u493W0KNweqbvWNWVCx1d+fGdCcQijp61hXVgPT9e96oM0nHhz0V048HG0oM1D4Gz98GJ837mJN/Qt0TqfqKpr8wsKCWgon0wkUCUBD3aj4CrTX0jl/gsh1TD35qWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963653; c=relaxed/simple;
	bh=k/Cl0xpHXpkVh0NkQiCfWcYKbfEJ6p6jvQnYvAV2tVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3bFOLUYQg1AALsjGdevyLXv+w5BpZYycwWOj634xLmJrgZ45jM/1Mq4ZhgUYCXXWUT4zY6V/w6a7mJMhObw3vdtU3ColSipTAIwCpYizG4dSNmmFXAiAO/7xO+h7tOXJbZ3qzCeCvbhs9k+igTgWemt8Bkdg56DR+rl4Lr5aeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hS9FFr2T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61d2c26963cso109678a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756963650; x=1757568450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL6cim7lJmQ6AxtssWEC3Fz/DOLV8WOPsE/+05ZC+Rs=;
        b=hS9FFr2T40d4GuxcGRPFdHSpa/8tvzpyKcur3szu8eSPobVvjjY5pzUcpoMiqaRiMM
         8y92GGUyElHBq8cH0IBN231gkHa32VEDQrPGlNsQn4a5wa6zRLLC0QojcI6bPot5mZpL
         mqM2j6KfksKfgiIJUz8hPdxUyDgcDCS1V0YHUNe+G/m/2jRUXqK4QGvkq0kYO0Sw0hZj
         37b4xGES+x6YyS7xXZumUw138mqNT0jL65yaxsb6FKloYdhK6gQ6biABO96J7Jw2xvSC
         Z4m64vuKwc9pg03OWmR2g3O2h2PV5SfExu4reqKx2a4Nf+eZqYmQhaJO/UKQhFrFCxT3
         JknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756963650; x=1757568450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL6cim7lJmQ6AxtssWEC3Fz/DOLV8WOPsE/+05ZC+Rs=;
        b=hm4K4BPkar+cHXa0JhYIfeUywRG952hNi7TJSUkDiDDMi74nJINrtPLYZL19vPkuA3
         2eEKbz+1RiuHaAllmCGSxXxpAfDJzSnZMgzVfTbfN9+DIwsWvtlntyX0Im88oqRH+VRz
         +qndoFTMpJkaespvN7vzPY0VbQFav865NfBCDKkD/HxwMg4Y/hO8FqlC/lQEHn0s62rD
         v0EJMioD+eZR0EFh4a1YbtHwB2ZPyp04zx9nRzlOcoiFc33GT7oQ134oNwxOA6s6eCzR
         0cpbzI24Vk3/xfCdczTdF0Lp+aoIEwA+6iglbH1EtqsbQifVpKck51UiVrnQmZRUUkRa
         9nQw==
X-Forwarded-Encrypted: i=1; AJvYcCWqNdFnhAX1i93W1KPOa6u0aOsWl720NEc/5PP/6xB84+v6puIidd41AcjKutYPRaP87EjdkwBT9M6r3sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QmQ/Cb1FBbHlSyb9dhUKcTz6JSCmvfVAHVKdqkSg+zSpdDv1
	aZq//YS/N59U3jvOpWdEl/iJvDwaMv65p0jq40NhukpJcDDb41sI7OxNtVk1Hxs1nUSaXNz0spw
	vABduvs1qe3Ola+r03T4gN4By2s1YKxe1jEGgIT2lVQ==
X-Gm-Gg: ASbGncvkV3jOAoPbo/NVBLQF+K26PwwXOKaLHT5GSRpwnnKRwXd97O29X+5nXthALG5
	2y5lnyFl6mgFx+6bkr/pieZlfkQlMmWlu/sZ91mL1MP+UWQ/x9CIvjJeFvbg7EMvDS64lS0QoL/
	lH0AZpu6vRMReEBqhNFzLc4h9qECtEHNpP0UDpbHS6UcVNA5M2tiFjKXnH8Yd4l8+9wfNpdIbZw
	ARX3VHnRhSF4yJok18=
X-Google-Smtp-Source: AGHT+IEDfQsuz75secdp8RUnbsBImr6NlNozZ+P8Ogn3tTt67Al7ENn2T1IBsCum3ICV+3M4BaQv0iuqv4AzHGhSAp4=
X-Received: by 2002:a05:6402:34c5:b0:61c:bc96:7164 with SMTP id
 4fb4d7f45d1cf-61d0d5e36d2mr9471320a12.5.1756963650114; Wed, 03 Sep 2025
 22:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLiMoNzLs1_bu4eJ@kspp>
In-Reply-To: <aLiMoNzLs1_bu4eJ@kspp>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 4 Sep 2025 07:27:19 +0200
X-Gm-Features: Ac12FXwu88MhUiHzrW45DiyG81OffV4ff8_lVgIAGwt2ZAc5wUFldikSYJ2mD8s
Message-ID: <CAMGffEkaWqURTV=7mmcH=Hce_8Ra2ch7Bs3koP8+NjgGAVm9aQ@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm80xx: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:44=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Move the conflicting declarations to the end of the corresponding
> structures. Notice that `struct ssp_response_iu` is a flexible
> structure, this is a structure that contains a flexible-array member.
>
> With these changes fix the following warnings:
>
> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.h | 4 +++-
>  drivers/scsi/pm8001/pm80xx_hwi.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm800=
1_hwi.h
> index fc2127dcb58d..7dc7870a8f86 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.h
> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
> @@ -339,8 +339,10 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> -       struct ssp_response_iu  ssp_resp_iu;
>         __le32  residual_count;
> +
> +       /* Must be last --ends in a flexible-array member. */
> +       struct ssp_response_iu  ssp_resp_iu;
>  } __attribute__((packed, aligned(4)));
>
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80x=
x_hwi.h
> index eb8fd37b2066..21afc28d9875 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -558,8 +558,10 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> -       struct ssp_response_iu ssp_resp_iu;
>         __le32  residual_count;
> +
> +       /* Must be last --ends in a flexible-array member. */
> +       struct ssp_response_iu ssp_resp_iu;
>  } __attribute__((packed, aligned(4)));
>
>  #define SSP_RESCV_BIT  0x00010000
> --
> 2.43.0
>

