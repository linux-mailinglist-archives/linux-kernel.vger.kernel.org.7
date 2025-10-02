Return-Path: <linux-kernel+bounces-840203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C73BB3D21
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972CA16789E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C330FC3E;
	Thu,  2 Oct 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdovkm52"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0932F1FEC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405869; cv=none; b=sSTvC40iXWUmzPuiQCwccMIu6VtmsCS4uPyzHejUbJHoz95nNB1i7yaKyoqpJRHqnsu8H2fVOtlwNIYjUWB+dU3T+NLF4HNA5uvYCmV0zwbF50kwMrK6tU4xqR+U2O0mBWvX3n964IWjKrjbp0f7uJIievy0PtUDw8oW4c6uGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405869; c=relaxed/simple;
	bh=FGLQ2Uj+CWbIJKZzhsAmoLQqBs2S93GpxqQTJkIDe1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dw987DUJFPvZJHwfFm199tOSR2ACGj1hgrQytmjN95t9eajX1vAl5Gn6d5/lhNGk5mQ+Pk/TL+yooSyfQlXFOC4UPCl/O2V2+NbPMIDT7qhVFB4aNNILZcPg10D4xh0GYGGRGpjrnUvgKJcH1bJ3l1Gyyl7o+4pgCrwl2QA+Mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdovkm52; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O/UdOTSJuFeuz61ETEUJOhsl+GvhZM/EvZcDfUCVmxI=;
	b=Wdovkm52kKZqXRcCqnibVUjnbKEdG56JqSVgvnC4JX4hAqATc/OyjCzW0MdbZG3kxUoFrg
	IIMDbZkAN0Ov8gGzLrWiuWjv1zzoIUZNc+Yt55GnIRLUo2bnCQQ88juqJ2ugNLqbEwt12Y
	7+aDmKYxf2rT5Hb3aJuxsFzs0v/p+i8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-9rGfL69zNWqS-PURqOSEFg-1; Thu, 02 Oct 2025 07:51:05 -0400
X-MC-Unique: 9rGfL69zNWqS-PURqOSEFg-1
X-Mimecast-MFC-AGG-ID: 9rGfL69zNWqS-PURqOSEFg_1759405865
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f3787688b0so524690f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405864; x=1760010664;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/UdOTSJuFeuz61ETEUJOhsl+GvhZM/EvZcDfUCVmxI=;
        b=SsLce3DL5CFD8EwdEK+1z16kE5I8boMct+Ofn6htrCAh7t2sGaronEpKri9UPpwZpQ
         u1aQwfW4u0ueUY+x5fMIresoIdHHDw3+uSds37rxTDSZXw6yxcs1LnHPlN/Nt5Nh81pG
         MC7q/hChF2Hkq5Fp+VuJ1UtC0iWqWhdnmtXvibBHJ9mViGzyQmZygFUQVV+hy/9c/hy5
         n27NR2KGY6Vkj1qe5MjepD0LZBS3d1h35bXgoi+DrrWtqDOfMLRPqI9v4J/PD9mqpwwq
         bG49N2+bjeNzFfvDg7+QlmJ8u4nNgWLmfCI0yP+cdjdNf0hGBQfQyAlKKeD9Cq5ckrI0
         QATA==
X-Forwarded-Encrypted: i=1; AJvYcCXn9yL75IUMIaSGg7wqWLF2rB1rTmkWaspGEreG9Z3Y9sDBPF6U5l1hf99IKt1yBPWKdKhabls2EKfhXGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDh9DoTTKBxbQy+prg9QF/6hGv6jVGOmFgxac2MpsR5y3jUuuq
	TVkmzPNltNKKVCFF+2hK+cycIUq56BIidB5ZokcW0SypSYJaogAohm35Nm8Cmcs8DBHqwQ4bD6y
	lzUYprmIJWhtK6s7PTYrh7nh+nR8BhzIGu5x/ulg7s9CLydPd7hOlB0vzSmdHwXoYEg==
X-Gm-Gg: ASbGncuCezc1l4pxffzQ6hAaMYgjt4HG5YvKzCSyJ6J4bnGbk5w81tBCGpVZc/vpJnz
	CCf4G7qoexnWDcRqTUeQCboJ5+lMmM4BYj40dds9kXfamFkDAHPUz7ExGoFFj530mQk44KftUmK
	NQR5qSgkKZnL+Ure2LWgQ1sLhIe3pyXc4fe+H5Y2aqgCfmbAqzG0+7wv+aV0FasWd9hNUu8OqBW
	ManycaB73VPVRYSXQl7kZQbmCOd6bZofGmLfg7mCnYxd1KKG9cdEJfdsnk4DXf4pd59fqSmuFR5
	phJtdix3SC9+AibHaLUA7Z0TzKo6SR7ZDjUKQv0MkpDCQ2HOpN69En9waGMh3CWTs78iEns=
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097952f8f.47.1759405864535;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZ0Tp7eiBzvf0DenM28iIPgbDIMFoVMsSJWueKET191HqUB2L04iRl6mrUsuKThJQn393hA==
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097936f8f.47.1759405864120;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm3367076f8f.51.2025.10.02.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:51:03 -0700 (PDT)
Message-ID: <067420a47d3fd7d9f50e4bc97248d0b4b812f9cd.camel@redhat.com>
Subject: Re: [PATCH 2/2] rv: Make rtapp/pagefault monitor depends on
 CONFIG_MMU
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	stable@vger.kernel.org
Date: Thu, 02 Oct 2025 13:51:01 +0200
In-Reply-To: <20251002082317.973839-1-namcao@linutronix.de>
References: <20251002082317.973839-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 08:23 +0000, Nam Cao wrote:
> There is no page fault without MMU. Compiling the rtapp/pagefault monitor
> without CONFIG_MMU fails as page fault tracepoints' definitions are not
> available.
>=20
> Make rtapp/pagefault monitor depends on CONFIG_MMU.

Makes sense.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

>=20
> Fixes: 9162620eb604 ("rv: Add rtapp_pagefault monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202509260455.6Z9Vkty4-lkp@intel.com=
/
> Cc: stable@vger.kernel.org
> ---
> =C2=A0kernel/trace/rv/monitors/pagefault/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig
> b/kernel/trace/rv/monitors/pagefault/Kconfig
> index 5e16625f1653..0e013f00c33b 100644
> --- a/kernel/trace/rv/monitors/pagefault/Kconfig
> +++ b/kernel/trace/rv/monitors/pagefault/Kconfig
> @@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
> =C2=A0	select RV_LTL_MONITOR
> =C2=A0	depends on RV_MON_RTAPP
> =C2=A0	depends on X86 || RISCV
> +	depends on MMU
> =C2=A0	default y
> =C2=A0	select LTL_MON_EVENTS_ID
> =C2=A0	bool "pagefault monitor"


