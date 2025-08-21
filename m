Return-Path: <linux-kernel+bounces-780598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566CB305B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA7DAE7459
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C434A309;
	Thu, 21 Aug 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwCxR+eY"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5131355D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807392; cv=none; b=nMr2kXdP95XZBGkvqvU4FmccZEiVDNT1VlBbkdKw3clp1qXXtsBzN8cL9s64vbV91XyPx/F34+YXLUz51574k/LkQC+VliaZjcv34KpfzLkDwZih+oLDP2+/mHmkAIiKTii3FVRCIKvnIvWC3bneBPPtYWdmdHk1X4Rgc6PTRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807392; c=relaxed/simple;
	bh=bJLZzoLIYiPj5H2lu0ukmAuOaE1Alfz+CpFLk/6cLok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE8CiJJO7fE2t7/aHEUxm1ZfDPR++Twih+ercOtbkc9mRA3YkmFLSORfmbC2+bOfLZogoO3F3ofaaGr6VMqbWG0zisNJDZkqRMNNuRoWPGFFNGCQCiU7Vg3TGtO5tAxjzmjJhGMlo7LQYQUGgYaqcwC+iSiiejThElwmzSl91Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwCxR+eY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70d93f5799bso5567256d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755807390; x=1756412190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoMACWbm6WXIWD5RwEuc0Yk/NrCPIoJJa0nlqcxzHco=;
        b=zwCxR+eYkP3+B8K6FVjJ+jNsAO7yHVn69qIodCm33Z+SWjKIMp2c1y6qyITdRk38EP
         JDgk+0tA5LYQCUSKRN/SKlBLYtmv2y2EU2rygxMovp45QLyebRmg/YDCDhpdraLnAssI
         if2JckYRMOZ9olQuhHnK7WmAnrZBwQns2U2NEyAUswSTLSIw8iaX/SbviVYP1GEk+1Fp
         FaIbvtAvs/KLTKX9sLEOysCPi+kGh5oTLC0UcQBQVo0r4LoRV0RVlZf4fX8PkZcfFXDO
         CkyZVZ9g+r1iwvR/MLRybJN4YuT3u2CN66tmtF+sqDte2lBW5z7newcVNuiCUH5Ca8/P
         3GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807390; x=1756412190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoMACWbm6WXIWD5RwEuc0Yk/NrCPIoJJa0nlqcxzHco=;
        b=FZ+Rr/jY18l8tjZJ1YzxnQO0WZXYQtnUcnJCDfSm9WuaKk0PlWHLkzrfYNGglwfOxq
         f+woIn9vteuUC+2GUFlUrgdZmwocJmhEliFnlexFgesJl7/nzlFRxBO0CLaF/EYxMIop
         GpZXB3n8zd83T+ukU2rLt/UqR2fdYqX7bc9OujTOjhjmKiHWtNT+Emd5TLtY/QcUOYW+
         X8cR2EBBauxttIUrwCWbhkxHJ+WO0vaQhrTUVB9gBb//bEW85+emt0CEvjpAfdZ7J/u/
         vXwPNUB1hT6g4aypUsIflMp3mE4kyRUWJnrS7B5eDclgxSjVrh9Z+d831OMx8GiBPeqG
         Kw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3aWq1OFa8A1hm5IlApSXc5t1SZv7XwHTm7ywrpUKhNE7VsX8+YsUgiY+0nDXY5hMK+Ko4uUfvxc4upew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33IxVhvFhwoS8byk2YQx9v+kMmN7eNHOmkiPWOmzv6WZta+iD
	fWKQPpt7dnc+h0QLR18f0GKF3YygmRSMnBKm5shlIBeLTdqnKF3D9iUUv1n6N+qeH0+hmmIKeRF
	6sDpEE86Zt0qUdDa3XFkrpLf/YRyfiqfgFe1x8oiC
X-Gm-Gg: ASbGncuhpSU6Qm574MaC8ngfICQ7SVYezaZqQK0cDW+dCdbquHnqnpV838aPi9kOXl6
	v+9xRyM1A8r4YrCKKR9iElSMEv3IgddLQ/ivIpDkoT+5P4EZUC3Xs4IA6kf0J63qmyjsct+gJ6O
	mcOaelz9jU67Yq7YqtpvEaKiRDzWBvBYtUNj/wcKgytyIvxCJqq5qxiLGv3lWdv/iasVTxXepYU
	iiHkTPME4A=
X-Google-Smtp-Source: AGHT+IFPvW5VGS5Pdq/t1Dq8/2FXw+EPJboiflOqeuNZwXL76s53ZkPMkBshyZ8dQC8VObHNnRC8wee0tzHwxyfcQv4=
X-Received: by 2002:a05:6214:29c9:b0:706:de4c:fddf with SMTP id
 6a1803df08f44-70d970b2b8emr9982006d6.9.1755807389454; Thu, 21 Aug 2025
 13:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821135447.1618942-1-davidgow@google.com>
In-Reply-To: <20250821135447.1618942-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 21 Aug 2025 15:16:18 -0500
X-Gm-Features: Ac12FXy1vcheJ7TDTrz-6MLLUWsqJPUTbd8XnGF9dgHRXhhIGEMrrGoiOssdCO8
Message-ID: <CA+GJov6UarLu3pEULCVqDLg1aatduASBsdR6d=wApfqdHJ-bCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/xe/tests: Fix some additional gen_params signatures
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	intel-xe@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:54=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> In 444be9072fca ("kunit: Pass parameterized test context to generate_para=
ms()")
> prototype used for gen_params functions was changed to add a struct
> kunit parameter. However, a few of these used in xe were not updated.
>
> Update these so that the xe_pci tests build and run again.
>
> Fixes: 444be9072fca ("kunit: Pass parameterized test context to generate_=
params()")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Sorry, the last fix here caused a warning (thanks to the test robot for
> finding it).
>
> I'm still happy to sqash and re-send the whole original series if that's
> preferred.
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20250819073434.1411114-1-davidgow=
@google.com/
> - Add the missing <kunit/test.h> include for struct kunit
>

Hello!

Thanks for this change! It looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c      | 12 ++++++------
>  drivers/gpu/drm/xe/tests/xe_pci_test.h |  9 +++++----
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests=
/xe_pci.c
> index a65705814b9a..f707e0a54295 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -44,9 +44,9 @@ KUNIT_ARRAY_PARAM(pci_id, pciidlist, xe_pci_id_kunit_de=
sc);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc)
> +const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void =
*prev, char *desc)
>  {
> -       return graphics_ip_gen_params(prev, desc);
> +       return graphics_ip_gen_params(test, prev, desc);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>
> @@ -61,9 +61,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_media_ip_gen_param(const void *prev, char *desc)
> +const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *pr=
ev, char *desc)
>  {
> -       return media_ip_gen_params(prev, desc);
> +       return media_ip_gen_params(test, prev, desc);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>
> @@ -78,9 +78,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>   *
>   * Return: pointer to the next parameter or NULL if no more parameters
>   */
> -const void *xe_pci_id_gen_param(const void *prev, char *desc)
> +const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, ch=
ar *desc)
>  {
> -       const struct pci_device_id *pci =3D pci_id_gen_params(prev, desc)=
;
> +       const struct pci_device_id *pci =3D pci_id_gen_params(test, prev,=
 desc);
>
>         return pci->driver_data ? pci : NULL;
>  }
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.h b/drivers/gpu/drm/xe/=
tests/xe_pci_test.h
> index ce4d2b86b778..6d8bc56f7bde 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
> +++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
> @@ -7,6 +7,7 @@
>  #define _XE_PCI_TEST_H_
>
>  #include <linux/types.h>
> +#include <kunit/test.h>
>
>  #include "xe_platform_types.h"
>  #include "xe_sriov_types.h"
> @@ -25,9 +26,9 @@ struct xe_pci_fake_data {
>
>  int xe_pci_fake_device_init(struct xe_device *xe);
>
> -const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc);
> -const void *xe_pci_media_ip_gen_param(const void *prev, char *desc);
> -const void *xe_pci_id_gen_param(const void *prev, char *desc);
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc);
> +const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void =
*prev, char *desc);
> +const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *pr=
ev, char *desc);
> +const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, ch=
ar *desc);
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void =
*prev, char *desc);
>
>  #endif
> --
> 2.51.0.rc2.233.g662b1ed5c5-goog
>

