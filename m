Return-Path: <linux-kernel+bounces-786879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68207B36D65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFA563CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E9267B12;
	Tue, 26 Aug 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="CWhIx9qI"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD32246BC6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220873; cv=none; b=kYwy8NQq4KXJXRHu8NlD44OToEDIQDu8pgCNfXCyFZeRu07njNsYt92amAPjfalfQuJv3fYJYXMYX7iH/bB2oK3+V0YFGOEvoNa7gfoH44d4vd21bLLj0B5VaMtb2M0tok9uWnvyxMv4jFobq00/D5GNvYpJdSkheDPSplm2vxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220873; c=relaxed/simple;
	bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfkA4xQE2u7NLajkTeaVVXq1V9OT5pK/CYISFG8oJqfenbgtD706ClZ5zGo9bZRmlF9gDy1K7szkua/tWVC76b7FoA664xxAoublboBaDJoLEyl9EyqpIWRcox+YQi97puXJyK1TAOvUFKXxETrD689LQdqIqsLQpL0FpQ2VHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=CWhIx9qI; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-89234591830so2581490241.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1756220870; x=1756825670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
        b=CWhIx9qImRjTmTgJcbs+9e07Xw+/tVD4fBOUzLhXKziQz7w4ibqxLa8VFSx0UgCEsO
         JwPr2KmxWz2os0RtddSDcLlvtYIsgqfxdRHFqJIl1eXMtjW536GnTFZdkqHut3NSUFmh
         PqlbF0CMKeNZgl8peINSdCmh8v3SSElqZiSYu7w5J2idmx9AIp75zcdIvWoiHmwQk6KB
         hgwRy/jaP0gq/lKEq8PxZXQStm8Xvjyb8a/DME6cqQk1ofjqQ5iy98S+h7c3Xz3c4w2U
         ZrGUYG7bykaU+cYQ6v3D3YA+60td2tPUM6kd0Rpn2syt8/GRqbpBeU6NQdkJn35ZJQUb
         cNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220870; x=1756825670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLTJBFKePavOEgfDED04jPzFKIw36QCgj2/798gfeO4=;
        b=SvKok7jKtTymgBqGJElxiCsV8id/dO6bWp4PdjeSP5OFqWg2IIknKqeO8sVX60+NMS
         0C+4zls1Tpe8bQdJZkEA7zsV+zjHKe7ec9hVU0e4y40tc9amJgXPuwEEkEtlE0t8IPiy
         8tuPX5aLcp9jcT6Ss8ZBdgZXC9O1E3hmEXgy3CuezFxWANw3Z8HzhjpKLoNI0gSt41vB
         oc9CJNx8WyR4ekDnpAcM6nAh3qchPn23Y+DKPUEATMOFL2Tyo+4aBp4Y1058OoWA3+8n
         hTdnaYlTkoLYhAQrQ+lktnieHq0ZNN5FA/fBFkxp5hPjPCuqjyIvGUZQJ8lwD5VhNvLX
         53xg==
X-Forwarded-Encrypted: i=1; AJvYcCVh2nA1nfSHCNVqjLBjODoLmZgviwnWg1+I4quZh7FWMDycjeAGyVyphQRBF6nw06vv8r5+w8dvpky5K2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnH21JwKBn9FO5cGfnNtthTZ3W6hnnLy/edxYweoX6ZyKnwco
	LdI3yfmwy3y3UlzdeQBWXQawOGljeKducUgJGK6PW5E+/DzuZCKdKCb8aXiZao2sfDWoDkeMzOp
	UHMu+y0o6VIHIyRdnAbZARJxSLP0hY61X7bhYpXu1LIK6suZbVls+BZ8=
X-Gm-Gg: ASbGncuk1yuSWwWAycDzyyooBoqbiejDcH/kcIxAA0YaSl9l3sCbyTLMK2Weg00GSBs
	okua54R4LooBp6TVw/2Hruj4vEVJH3xOyzhAaGmmY+3CaWjG1/V1KcbihUjTSsUojEEmHm62A0u
	dBkpIcCeVleNMdbG2395VTYC4pxknhacl0f/AN7KWc+KcX2eDzQGOzujbUOTfJyQkIBu9vSi2Na
	JOpAg==
X-Google-Smtp-Source: AGHT+IEBQktZsGOdqIzVGY7uzXewtRe6umCPAxdRB6LipaxI53/bpdLY1F6YKDz3jLZCa8rUwlmdCxJLMPZKOVfuKqg=
X-Received: by 2002:a05:6102:5106:b0:521:b534:1e39 with SMTP id
 ada2fe7eead31-521b53424a3mr2872957137.12.1756220869569; Tue, 26 Aug 2025
 08:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com> <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali> <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
 <20250715170637.mtplp7s73zwdbjay@pali> <CAJDH93uXuR8cWSnUgOWwi=JNuS543mHLPJb9UUac2g=K4bFMSQ@mail.gmail.com>
 <20250716181320.rhhcdymjy26kg7rq@pali> <20250811175756.kqtbnlrmzphpj2lm@pali>
In-Reply-To: <20250811175756.kqtbnlrmzphpj2lm@pali>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Tue, 26 Aug 2025 17:07:38 +0200
X-Gm-Features: Ac12FXxpk5v1_YyA7O6ssBnTjtcz9zqW_DvjbyN70OXMFOXGEu5A5aTQ0zN3UZA
Message-ID: <CAJDH93svLMPM0O_Lq=EgfH6dxXXbnq4QkM6ye_8tyvsRYs8dug@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?B?RmlsaXAgxaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hello Rostyslav, I would like to remind the previous email.
> I still do not know which bit in D18F4x044 represents the
> EnableCF8ExtCfg config.
>

Hi Pali,

Sorry for the late reply again. So in D18F4x044:
- bit 0. EnableCf8ExtCfg. Enable PCI extended configuration register
access for CFC/CF8
accesses;
- bit 1. DisPciCfgReg. Disable CFC/CF8 Accesses to IO space. When set
to 1, CFC/CF8 accesses are treated as
PCI IO space accesses and not PCI configuration accesses.

Unfortunately, I don't know if this also applies to later families.

