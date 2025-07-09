Return-Path: <linux-kernel+bounces-724045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3094BAFEDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BC71C240C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B822E8E06;
	Wed,  9 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAC/lPvk"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E942DC352
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075748; cv=none; b=jREtxHCZW4wIFzu8MoN2s9baVNTlV94PgvsFsABFGXpK5cNYXelw3ikEfZi9BT8WCXxL2wD1cW0pGDCG6RwSa3VOBeL9HwaOvHqLiBoB0Q+QlQBiuv8+AIPN4TmasmLusH9/oTAouMvnh6duAkc4MdPB51bHA3dP4rGR9e+v2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075748; c=relaxed/simple;
	bh=QovcFoD8Krfi+xLDMqZWIXliDqU55FCONFA7+cA4UIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TobwAXCx2B3/jh0Eqox52hnvzw/3BZyrQj0lquR3ItC14zrZL6qkHoCREJL76vAEfoU9TF2ws6A3ptTSK7GcmdVuKEoMcHGCn3oHI3sJUINAd8Yn6qU2n7y+UPAUQzudXqOZuXEWHAwiik6bHkvaT8ID4PygJLyJsKu2RXdEAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAC/lPvk; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so276705ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752075746; x=1752680546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSU5dKke9DWZIUFmbSQUTLS3E3YudP6op3KtOW7lXs8=;
        b=cAC/lPvkR4pN0tQBsZtysBPM1gtAj2bCFYMsLGX0Xr38nae2v6eVoY2AAzk3Wqzrkz
         2ugGy0Z2VsusKuXUJr37DbDcHit/KW5jNlU5LLYuFx3s745XQWuGi+o3T0lFvNpy/CLT
         vuZndPeZQ2Q5IwB+k+QSZmEz7hjkRxfsgpHP22g+2TCnGOY7pkHF01JYFEn0MdpfSdIx
         UOp0ENnehb/BsMwzFQUDEl9YJswbasR4hxnH45kuMs2LxXzDFajrs1wSbx50muHc3vTW
         MTlIgaaTuv8GAPFqiIi89Bqb7T9LplJQUyxS3d6pXAp87t2D6n1xhyxoYrHNVGTzsSLx
         OfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075746; x=1752680546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSU5dKke9DWZIUFmbSQUTLS3E3YudP6op3KtOW7lXs8=;
        b=OQfRdSpSjCW9th9pqOO41C8sZ6gBtN1u4pVqfrGPdMCuBsyeiSwLIBlNe4r+suVTPY
         fY03GoagseOLLMeFvWex+CD6vq9WnBQzqW8G+LJtLo8qwRzwMnp9bSQgZn3FFoQoO/35
         3rhKH+AjU3nZ35P1wCrE+A03A0S61GPZ9xsPJSNfv/e11GM9aDkfJR7PeIX70KCbDamk
         9yz+ISEt77Zm9k3eqWqsbee+qx79/Es+xBZO5YXRLS7A6BCjqvN3Mw6rIYSSA4Q/3iIb
         nYN/Alh7dAnKUfBzMIu1mqNNdklxKWQU1tOvmpB8L0CFNPI6xR3Z41Yy+2TmRvGVO+4l
         ZJjQ==
X-Gm-Message-State: AOJu0Ywd69FONvwmE9e1p2ORWNYlO6M8IyXhCU9/MuAWEEF18XHgoul4
	mTIfA8Gm19aTFC5vi/HHkFQglnW3rtdcKiMrn8LKbMEYZ1YNImScIGqNtTirhHJetC5u0OR0xTy
	BB1Nu0wOYCYvXYFW22B6xWpANuj4yDv76P9kw5x6l
X-Gm-Gg: ASbGncvy4ZLrpVAuMhU9IlHtaFg9x8iSSRw5iKzOG85tSUvQrUynn/Zc/cY9D/cb1Lj
	YB9HJyVS9iiAGCy8ZWa4mif1D+/b2VvzVF01PDtkQdu6HnHMf6BdDgotb+T/ShUsh6WJhYlA2FV
	vjWQN7R5wXKVEBKlr8ysdPEiJTu5p4b3dFVPKkxjxbT3jWe/ewbEf4jBl41DQOs/mQHdLpN8Iz
X-Google-Smtp-Source: AGHT+IHQ9PIy+XOkJNK2AeN146I3YHYL5hcrX407J/wgmZ1WsclScTG1u4s0DXxAV86N/BucOJUHKJySsgYRtBjAxHA=
X-Received: by 2002:a05:6e02:2592:b0:3dd:a4b7:c737 with SMTP id
 e9e14a558f8ab-3e167228593mr4070965ab.19.1752075745880; Wed, 09 Jul 2025
 08:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709072452.1595257-1-tmricht@linux.ibm.com>
In-Reply-To: <20250709072452.1595257-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 08:42:14 -0700
X-Gm-Features: Ac12FXyiyh8qm4Co47ZF3XtMQKMC2KU6LdngoTLT_7JWPX0CgPlWYz3wnTXAFQk
Message-ID: <CAP-5=fWTc==g=DAS83Eed_Jg9EgE8QiRgM7Jf3vGhmq=8TTdVg@mail.gmail.com>
Subject: Re: [PATCH] perf list: Remove trailing A in PAI crypto event 4210
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, Ingo Franzki <ifranzki@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:25=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> According to the z16 and z17 Principle of Operation documents
> SA22-7832-13 and SA22-7832-14 the event 4210 is named
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256
> without a trailing 'A'. Adjust the json definition files
> for this event and remove the trailing 'A' character.
>    PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A
>
> Also remove a black ' ' between the dash '-' and the number:
>    xxx-AES- 192 ----> xxx-AES-192
>
> Suggested-by: Ingo Franzki <ifranzki@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z16/pai_crypto.json    | 14 +++++++-------
>  .../pmu-events/arch/s390/cf_z17/pai_crypto.json    |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json b/too=
ls/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> index cf8563d059b9..a82674f62409 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_crypto.json
> @@ -753,14 +753,14 @@
>                 "EventCode": "4203",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_TDEA_128",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED TDEA 128",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA- 128 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA-128 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4204",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_TDEA_192",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED TDEA 192",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA- 192 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-TDEA-192 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> @@ -788,21 +788,21 @@
>                 "EventCode": "4208",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_128",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 128",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 128 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-128 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4209",
>                 "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_192",
>                 "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 192",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 192 function ending with CC=3D0"
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-192 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4210",
> -               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256A",
> -               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256A",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES- 256A function ending with CC=3D0"
> +               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256",
> +               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256",
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json b/too=
ls/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> index a7176c988b8a..fd2eb536ecc7 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
> @@ -800,9 +800,9 @@
>         {
>                 "Unit": "PAI-CRYPTO",
>                 "EventCode": "4210",
> -               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256A",
> -               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256A",
> -               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256A function ending with CC=3D0"
> +               "EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED=
_AES_256",
> +               "BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING EN=
CRYPTED AES 256",
> +               "PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-E=
ncrypted-AES-256 function ending with CC=3D0"
>         },
>         {
>                 "Unit": "PAI-CRYPTO",
> --
> 2.49.0
>
>

