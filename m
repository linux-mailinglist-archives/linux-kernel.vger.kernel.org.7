Return-Path: <linux-kernel+bounces-736955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED116B0A5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65F0A461F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2332417F0;
	Fri, 18 Jul 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RNa5fV1F"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A52D9ECB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847144; cv=none; b=lfBFf9tux4v3oZDHeGtrcixUkoaS5ccu7yxpD6Uc1wSF9V1Kyg/TCllCnvK6XlUZct7UJ3xtcS4nPMHsF9x6hclYB3WB7oDRuSLWb/dM2i8qnKL/77Z/TzkewG/rBdB37S+KUVUcA0zyNIUn5JWPGj5k4uFfAFfigt2wAySBXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847144; c=relaxed/simple;
	bh=dBAySTjZLDSr5IuXrPz25bJ1X/90AQ9ByyWDnzZ80rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7ugTxMRYYLs8RNzFdi5Y5id4jWrDiGwBd0USOuxbY9dKMn4fx2bXA3s6vX4GrkVs4LU5WWl53ZmC3ItYadTE99MNYhyD6/7zWSmQOntzPxFGpTeZex3lH2x+DevE+14kT73PWpRVn+/ldBwI/0Q1JWVABZ9jKiFHfIV+mgdwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RNa5fV1F; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so349828066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752847141; x=1753451941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBAySTjZLDSr5IuXrPz25bJ1X/90AQ9ByyWDnzZ80rk=;
        b=RNa5fV1FleX/9xFN6NOgEtOQWtl7cCr+mwBNSV43QMl+O0YyvGLdDocyLoFM4so9Qx
         FwXF8WwqBTIxI65aOSCjeyhU5acr+FO+YPSnoQt1v/Gi+FYvr6ZrWgaMYdI16IM36o9f
         p4MGkdmIpwyIwIEioVT7ZjXMoueya46GTK+flnBCe/IgdMKTWOch4eg5houdD4QMAUlw
         sM+1J96HEdA1seOA1HBqbsokkh0DURSgKlQ5lvHfPZBvCqqSOTiubaKkRNMvcu6/ITUT
         KNxb7CR92H+fWqUE9VtoDapLcIKa0HeNrR4StVF06AQmpWgn69v0E+oNUMTQBh20LGSV
         kbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847141; x=1753451941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBAySTjZLDSr5IuXrPz25bJ1X/90AQ9ByyWDnzZ80rk=;
        b=M/zPv4OzFCSOYBW0XW4L4V/2CZOYi+avGZwW4uAoCiRjdtUOqCCi705IUFFZj6sZRZ
         rPmUwJBRqnPJ78vCv0dYQRQQuK//M6RWhPl19T6ENRiRRM/bwLyuKjG5NWrNEZWJhQiE
         DKQpN06zfNdfpaYuURBp6l+TkM8CVzIs6B5ECoE6cboVi1DA2MbIctuL0IkveX5ZcX+w
         fNSpgyvYbqPQsVQ3p270+JnMdYn2/P/RYsF7+wE3mhHM6yezwQ2Tc9GLKPuIhHRgDd36
         dpWATClO16N8YeQ6K7WIKfrbHdRuFaSZ8Ao1AIpbn0sGn6rhziNKLhpZEjRtlpaj5jQf
         Iy8g==
X-Forwarded-Encrypted: i=1; AJvYcCVMVgfxcny8K8iEZZivxXIficBsybFBCBN1BhxVGKil9DzgiZKqK0HM1nzfyVaUjr/kc1XIIbXLkmVWheI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7I8EHIdRYn4QSisu4YfYZ1x20G24zeyYovC/E8d4oggBBxrBF
	iX2x+BgN5FILknYzE333bqyaAPlq4045Y5y4oLsC3DJ17H/smfC/LVsSEY+MaYUUm0U=
X-Gm-Gg: ASbGncuBKx/vEL2cwdW6w2S1UVDzLA/IwGyoHjLRGN59K2Ox9bBzVcKbOCX2Iad02ES
	y7vrhn+Ezgbc9DNxXLNnfUBPhVSbHE/gBMn1feoHjJBQwIpYeFsp+2RUM7vsEf02TsE6shI53o6
	5vLhGyKjwRCe418xqW5e/f4Leh3lMQoCxsEzwjiIrpfHY1ePEmb90TD957fQGh9X+KGMSj1+chS
	prnSwvgoeITEcqgAAXAopi7JhyRsfHTHBealkgnW5bssaIMvf2Mcc+Xg3mZCzsv6XTvDZ90OK0T
	FzpWDsgCEM7JVbMVSRHJncgEWB6CXYAii8ns+DYT/lyDty0G+8gfB4pKYd/rIfHMRxslpbpmEyF
	6IzG5tmStUoES2ccINoW37zjMbhRemED8o3iQUzedJigA5TE8WMZq
X-Google-Smtp-Source: AGHT+IH+sgJFyUyQKgY2XKEhVrbznW4wwWr0AO9ynVBplbDQ+J/igjMzNMWoDYMl7tWlzO6whvyMQw==
X-Received: by 2002:a17:907:f1ea:b0:add:fe17:e970 with SMTP id a640c23a62f3a-ae9cddfe2e8mr1062342266b.14.1752847140692;
        Fri, 18 Jul 2025 06:59:00 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7e090sm128196066b.115.2025.07.18.06.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:59:00 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:58:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Tiffany Yang <ynaffit@google.com>, 
	linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2] cgroup:
 Track time in cgroup v2 freezer)
Message-ID: <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcvygoatcygfglbi"
Content-Disposition: inline
In-Reply-To: <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>


--pcvygoatcygfglbi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2] cgroup:
 Track time in cgroup v2 freezer)
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 05:26:54PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> With the recent merge of the series "cgroup: separate rstat trees," the rstat are not bound to CPU
> system. This makes me wonder: should we consider moving the cpu.stat and cpu.stat.local interfaces
> to the CPU subsystem?

Note that fields printed in cpu.stat are combination of "core" and cpu
controller values.

> The CPU subsystem could then align more closely with other resource controllers like memory or I/O
> subsystems. By decoupling these CPU-specific statistics from the cgroup core, it could help keep
> both cgroup and rstat implementations more focused.

In my eyes, cpu controller is stuff encapsulated by cpu_cgrp_subsys. I'm
not sure I understand what you refer to as the CPU subsystem.

One thing is how it is presented to users (filenames and content)
another one is how it is implemented. The latter surely can be
refactored but it's not obvious to me from the short description, sorry.

> Is there any particular reason why the CPU subsystem must remain bound
> to the cgroup core?

The stuff that's bound to the core is essentially not "control" but only
accounting, so with this association, the accounting can have fine
granularity while control (which incurs higher overhead in principle)
may remain coarse. I find it thus quite fitting that CPU stats build on
top of rstat.
(Naturally, my previous claim about overhead is only rough and it's the
reason for existence of adjustments like in the commit 34f26a15611af
("sched/psi: Per-cgroup PSI accounting disable/re-enable interface").)

Thats how I see it, happy to discuss possible problems you see with
this.

Michal

--pcvygoatcygfglbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHpTHwAKCRB+PQLnlNv4
COgNAQDrEy0E9hAGbZwxjNSPxRuYduBTsT6UA7HhF5QZiq6d+QEAxP7kauFGRgUt
42uZq96E29hzx+xTrawPXSvIvUmjIAk=
=cdEY
-----END PGP SIGNATURE-----

--pcvygoatcygfglbi--

