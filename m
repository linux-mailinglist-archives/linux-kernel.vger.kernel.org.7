Return-Path: <linux-kernel+bounces-819417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E151EB5A069
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D117C07B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99122C21F5;
	Tue, 16 Sep 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDIA9wbh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1527E1B1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046625; cv=none; b=Im/TUQUV/qFcmVrRlfB1g76LHkK8iyW/FQDob0aZAKPQgicDUZTpEwo0AXdNw0OlVd5X86ofP/o5M7q420gAaVT/Sz943gLU7ijdt7iAN/7hVPJpEZ5+7Tn1k0ayBCarY0qSJtoFTc1AfwuNS5mXc+jnqhE+TpiyFmTIc9eIwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046625; c=relaxed/simple;
	bh=MVPzMTONaBJT5N+hHaYmRy0C3P3AER6E6H5SQzBvo3E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KjLR22Rqb7fk0Kr7YIeE3PuW7EQv4WZQf3yM+BqvRK8YXgBw216Fx16PO+vfpz3vAenbwsoC/p+q8MJ8gKq99C4471XTEHYEpHRNYKUFels2FPGoFrOEe2TIStgUj7t4XzjPexyU93JDyhyLl8EoTjssUDU1Nrr9Cs5GzRMLiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDIA9wbh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758046622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiJbWUk9iK3Va6WQUOfyxO/yZVMoTNTnNrKsRMOKeVQ=;
	b=TDIA9wbhmUVXQ0is3O66DU4Zu8JNoWxYXLKEcOKy2t55JWNpTgm4qpmu6GXNHFkgX2AUdI
	OE29hHgd5tHsvFhNELnpNA/hmGuEYICRtCFISjYmweZtaQQbW0FpjSNLqstWs7KYUOSP5X
	ycC4aF+kf2WRA3tnp/ERqEJV4nP7Eus=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-gKOPOTMCMhm4NA-iIBVFyQ-1; Tue, 16 Sep 2025 14:17:00 -0400
X-MC-Unique: gKOPOTMCMhm4NA-iIBVFyQ-1
X-Mimecast-MFC-AGG-ID: gKOPOTMCMhm4NA-iIBVFyQ_1758046619
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b07cc3f115aso143643066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046619; x=1758651419;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiJbWUk9iK3Va6WQUOfyxO/yZVMoTNTnNrKsRMOKeVQ=;
        b=aDNh9xxbqent/gU8GJnI9XmMfm9nKmEMFtCFHSkqJLNMDj1AaavlZxTUT1aheCJlgS
         CzPxERSMRPbLF216LQ3J+ELcEtTXyH//AuVTe9vcxFrxV04ewjuuCrSY4etpAXotTAdv
         p5544OU3644g78OYj0W7CLR+0N6KhkL4evfLLytBptUBxJUytvmqvb+fLiuJ2mJC861G
         IcSrxzSRgtK+3zro/k7Al3m+kyKd5L4rTPdTB+mv5zUOQoamTl/OE0yy4f2so2fBHSpt
         tqm/sVNcrpwvWtluu193bDKN2H/+LK1xWhr+TW6ryS9Ua7FKvHbhzRcQT2QffjerHWhS
         4MIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRw92lhDA2XoMo1enBvrHV5JX+j3D5sMMqF3zOghYU+Efz3uoBmFwCnign0OzvP+IXHSoW+qlWSAEBMEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeFQ+JfBP7sBvtve8s6O4ED1fh9dyiIpZabz96MswqYn+zLwa
	EI/Oz5Z4T05iPVbI3u/Pp5Eo3QaSLaUpeOF0CjGPA3RQRH7wORWvq1Xm5eTmm4P5MDYfb83WkFd
	TYM9q5vc6ebpIc1LbZ9ClaOumwOD+yb4HeLpg5PRlDRKA+qSYhwg7oztfg5zjuxeVPA==
X-Gm-Gg: ASbGnct420Sk1NqeyK9nrZkKYVeJ1k7NllXVHulsOWPebPF0Ok1vBAVRjXuv02W6haY
	HKP1JVeTO6Rov/UXpqV2EYs6F3/kTzv1pnTPSWYLia+SLRroaL3d4SXrmR0oO1Ttz24xZA3lAxG
	qDtL03a25nhKSgcUlAUByZHRrCp4gJ3SAZ0NDBFGbg+3pWbpZkaIyZc2g7FydKkM+nE4lx4mgf/
	HDw64CMbZmvOnissCaAUGL3Ydo1toq56WiqwjvKsB3nYkrhSSwwlyzGGhsLh9NeUN2hs88+PqaM
	J72hLH/D+um73rdR8pac1Abi8ckv11H1Bkj3eEVq5jqEZICJ
X-Received: by 2002:a17:906:dc91:b0:b04:37ca:77e7 with SMTP id a640c23a62f3a-b07c365da98mr1673684566b.44.1758046618709;
        Tue, 16 Sep 2025 11:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIt2e9AJy51nO/jH/HTJfy0/9Ihn7bnnuR/FCs8J9Z85sjlp5JxyE81WyYIgw5qXRrUm+sBA==
X-Received: by 2002:a17:906:dc91:b0:b04:37ca:77e7 with SMTP id a640c23a62f3a-b07c365da98mr1673681666b.44.1758046618304;
        Tue, 16 Sep 2025 11:16:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:ad04:3f07:f046:aa35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b6fsm1217873466b.111.2025.09.16.11.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 11:16:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 20:16:57 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2=5D_dpll=3A_zl3073x=3A_Allow?=
 =?US-ASCII?Q?_to_use_custom_phase_measure_averaging_factor?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250915164641.0131f7ed@kernel.org>
References: <20250911072302.527024-1-ivecera@redhat.com> <20250915164641.0131f7ed@kernel.org>
Message-ID: <FA93EFB9-954B-421E-97B2-AE9E0A0A4216@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 16, 2025 1:46:41 AM GMT+02:00, Jakub Kicinski <kuba@kernel=2E=
org> wrote:
>cc: Arkadiusz
>
>On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>=20
>>                        2^N - 1                1
>> curr_avg =3D prev_avg * --------- + new_val * -----
>>                          2^N                 2^N
>>=20
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference=2E
>>=20
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower)=2E
>>=20
>> The driver currently uses the averaging factor N=3D2 which prioritizes
>> a fast response time to track dynamic changes in the phase=2E But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate=2E
>>=20
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface=2E
>
>Is averaging phase offset normal for DPLL devices?

I don't know=2E=2E=2E I expect that DPLL chips support phase offset
measurement but probably implementation specific=2E

>If it is we should probably add this to the official API=2E

The problem in case of this Microchip DPLL devices is that this
parameter is per ASIC=2E It is common for all DPLL channels
(devices) inside the chip=2E That's why I chose devlink=2E

>If it isn't we should probably default to smallest possible history?

Do you mean the default value?

Ivan 


