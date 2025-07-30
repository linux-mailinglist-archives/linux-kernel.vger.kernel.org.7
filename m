Return-Path: <linux-kernel+bounces-750217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32DB158BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34EE3A283A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F961EEA3C;
	Wed, 30 Jul 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y08xlMyn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4901E51EC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855606; cv=none; b=LSmAnZdPCMpO62W0a32H1cY/xb9F1dthXTXyybmpYpVZPWB6cA71kKO4ncoiGB8/XztUF6LOMP6nS8JKb5R1WD0RFdQjd4KL5XsNZS1p4+ubQj5QJsZK9xqqfZEz/tZzkq5t8WB7THQ2mSpB0IJp0X/EP7rH860lsL87tfdfdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855606; c=relaxed/simple;
	bh=TWC5IPIIpTFv3lDPCzoPIeY3XAocImaqKEPUAwX5S6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tr3RF/kQEVfWX812AQCSZBv2TX/QmdXZtlb4Pxfn+uxv3CwGpI+PcnmbHecyokUKaVT0YGIa4NE5OiVCf0AiiPK0UCYezxR+Som6rzq1rybcgJGY4G/Ybs0q0no1DWk2oSv+qxgiR6HZ2II3dkPAtMSgf3qNZOJFAvsbYTjbGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y08xlMyn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753855603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TWC5IPIIpTFv3lDPCzoPIeY3XAocImaqKEPUAwX5S6Q=;
	b=Y08xlMyntdrZAYW1E3up1e3bUfJ4Lm/br2UwRvC9VNE/0UnyageRRMaUtVRWqvSLNS4poz
	TxLs07tMKwmhb6XRsGWCLVEFDuepqryQR33DXVfKvDUCNa0fk7RU7PqRGCBac3a5MOtyot
	syKxqaWo11mHW6PGxbWzE2azkAeChc8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-kvoXVeegPVWEykTNaL0i_A-1; Wed, 30 Jul 2025 02:06:41 -0400
X-MC-Unique: kvoXVeegPVWEykTNaL0i_A-1
X-Mimecast-MFC-AGG-ID: kvoXVeegPVWEykTNaL0i_A_1753855600
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b793f76a46so1085158f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753855600; x=1754460400;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWC5IPIIpTFv3lDPCzoPIeY3XAocImaqKEPUAwX5S6Q=;
        b=s1IUV75mI1tMO8Rdf6JndIK5IM0Un8O6hrsdo+6cpSQththeCW84093pNejEFjF7yK
         eybmlfpRcjuabHHntZUI+ZDXm4OiMmdj0DWJcI4ManwC2uZSUfHdm+HkKRQ25odj6NmL
         5iEe396pZDV0Awi97Siq31NUKOsNpGGHtPqBE76NQ+EmPKfKewJNV78PvdCHj8wihB04
         rOdfHM0sw8ajnu7cvyFrbIhPgQ1hxDy2geQpFhIXWNPfne1rHXIAkp+8YV1Ix7rQYVFD
         8OKhnSmcmeIBgrqhUzAPq+EWjP0Q3vK5OiOggRzu0CKqxKetEa75hP91CRDWyvwmGaDP
         VYqQ==
X-Gm-Message-State: AOJu0Ywrp3KmAFesUEd9jQpxzA/AFOP6m+ogrqYH8kJCiP/d3BFT1hQ+
	xvGG/BtUUe6lFjsC+CMJUk93chUOE95B0hT/W7luW2jNvA60fPV3MPvGyxb+4LcPKlm5eNiQdA4
	KXnKBTqQTrhoRjvPohvr4sV0CIseSi3pL+HOpmEJzlvZVs63p5PqxGR8RTkrtU+lVHKcfCsTfDO
	4m
X-Gm-Gg: ASbGnctGOL3GMQCwmk+ue8qSWfJeB00BqPSf1fzv68a0cROSzZKFILoJvvA3oVEUlU0
	fdvASBSklkBn5pmQcIrQUZqZjVzV+sKtY8n+RhWlPVCg/+dwtKjZ70x3U/jAF2SazBi0Y6L16V7
	cJrf/1idpv5LIJznqALV/5l5kXq/U0P/agiGJxcP1obGYUU+jROZbdZnmhMNLfeDD8gEJCxae2O
	1PTBjyPohmeBRw3ggSawb6cHMc616a8BmdfDLYH5A4nAT7Qh9lIQ8nv6iJM6asKoa3yBzI3Id+O
	r4QBD9HxtvKgKW4wkBvnYZE6PTs7BymcbjUmiYgH3Gt3/4uxDM6RSBOvihdkTCGXiQ==
X-Received: by 2002:a05:6000:2212:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b794ff3599mr1411180f8f.22.1753855599574;
        Tue, 29 Jul 2025 23:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAy/Cbi93wlKH8neNgb/jLCRitRF73VIUIph5jAf5AZyLpzNvICJGXdScQtgMFkBoRoDH9MA==
X-Received: by 2002:a05:6000:2212:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b794ff3599mr1411151f8f.22.1753855599008;
        Tue, 29 Jul 2025 23:06:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba147sm14598144f8f.27.2025.07.29.23.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:06:38 -0700 (PDT)
Message-ID: <56b088cb60e55778132dc0cffcee7d8fa75b2115.camel@redhat.com>
Subject: Re: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 30 Jul 2025 08:06:37 +0200
In-Reply-To: <20250729171808.505c67c2@gandalf.local.home>
References: <20250723161240.194860-1-gmonaco@redhat.com>
	 <20250729171808.505c67c2@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 17:18 -0400, Steven Rostedt wrote:
>=20
> BTW, please make sure that the cover letter is Cc'd to
> linux-trace-kernel@vger.kernel.org=C2=A0along with the patches. I use
> patchwork to see the cover letter, but it's not present when it's not
> Cc'd.
>=20

Uh, right, will do!

Thanks,
Gabriele

> Thanks,
>=20
> -- Steve
>=20
>=20
> On Wed, 23 Jul 2025 18:12:35 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > This series introduces various improvements to the rv/rvgen tools
> > as
> > first posted in [1]. It also adapts generated kernel files
> > accordingly.
> >=20
> > Specifically:
> >=20
> > Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.
> >=20
> > Patch 2 allows the rv tool to gracefully terminate with SIGTERM
> >=20
> > Patch 3 adjusts dot2c not to create lines over 100 columns
> >=20
> > Patch 4 properly orders nested monitors in the RV Kconfig file
> >=20
> > Patch 5 returns the registration error in all DA monitor instead of
> > 0
> >=20
> > This series is based on the linux-next tree.
> >=20
> > Changes since [1]:
> > * Cleanup python code to improve PEP8 compliance
> > * Fix condition for long line in dot2c
> >=20
> > [1] -
> > https://lore.kernel.org/lkml/20250721082325.71554-1-gmonaco@redhat.com
> >=20
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Nam Cao <namcao@linutronix.de>
> > Cc: Tomas Glozar <tglozar@redhat.com>
> > Cc: Juri Lelli <jlelli@redhat.com>
> > Cc: Clark Williams <williams@redhat.com>
> > Cc: John Kacur <jkacur@redhat.com>
> >=20
> > Gabriele Monaco (5):
> > =C2=A0 tools/rv: Do not skip idle in trace
> > =C2=A0 tools/rv: Stop gracefully also on SIGTERM
> > =C2=A0 tools/dot2c: Fix generated files going over 100 column limit
> > =C2=A0 verification/rvgen: Organise Kconfig entries for nested monitors
> > =C2=A0 rv: Return init error when registering monitors
> >=20
> > =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > =C2=A0kernel/trace/rv/monitors/sched/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/sco/sco.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/scpd/scpd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/sncid/sncid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/snep/snep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/snep/snep.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++++++--
> > =C2=A0kernel/trace/rv/monitors/snroc/snroc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/tss/tss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/wip/wip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0kernel/trace/rv/monitors/wwnr/wwnr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A0tools/verification/rv/src/in_kernel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0tools/verification/rv/src/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0tools/verification/rvgen/rvgen/container.py=C2=A0=C2=A0 | 10 ++++=
++++++
> > =C2=A0tools/verification/rvgen/rvgen/dot2c.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 ++++++++++-----
> > ----
> > =C2=A0tools/verification/rvgen/rvgen/generator.py=C2=A0=C2=A0 | 16 ++++=
++++++-----
> > =C2=A0.../rvgen/rvgen/templates/container/main.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +--
> > =C2=A0.../rvgen/rvgen/templates/dot2k/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +--
> > =C2=A018 files changed, 63 insertions(+), 40 deletions(-)
> >=20
> >=20
> > base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a


