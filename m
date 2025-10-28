Return-Path: <linux-kernel+bounces-874782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7CC17136
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ED4188A5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08AB2DEA8C;
	Tue, 28 Oct 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="dDNBQNdq"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE62C3274
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687611; cv=none; b=n1ZAdI+DLpug9LO8Ya5WjL/giSYugU43px+5EhdELK081TluonaiiYZWa9T1BscEIvbN9d2NmWYJIoEcl2OcCaLvGB/LLveqM6nqKnVQPLQ0l83iXG+q2T5fdJ/5gM+kLvo6K9JeLS3AOgLEGYDxHh5H3JwPe9hFrHRu/oKvH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687611; c=relaxed/simple;
	bh=lEkhl1ibC9qtzM6zEurwYZgCcBzCyirCSbiIT4Vo1Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYnFj5qWO1LG5c35KRQQjP1CiIPiGJVNzYCAtk38Jmb3KvKbX87PFtYPtVcf5XwY9Nhx0E4J1o3ucyj4aJdlBsfz6S1DTLOyGYgyQT8gNeLf2cnr3vnCcAhW65QJYoJU6LXje4uXmLFHNg2y/0/4KCeXHlqKubegae3+zeQdQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=dDNBQNdq; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id BBE9A47B87
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:40:06 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id DD47A47B96
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:40:05 +0200 (EET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0346C201B87
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:40:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761687605;
	bh=tMd2ZNL4KZAoBznZnK2oqDzWh4RfeRFqT2Bv/OZVL7U=;
	h=Received:From:Subject:To;
	b=dDNBQNdqXnv0jCpnBgQALfRqJklNXVD4z3NpWjU4NyIUj4p2rIl1dTwfL068A36sv
	 c/Lo3ksDYVLbs33S7a3YliLkBeJ692uo0w+Bzs8N9zQvorr/eMi7veObV4yaxI6NLe
	 zJ05BelNQE9EMq0HgXHcA5ZJKVokhfVU0v9eI/FYBvhGtP01OIa4jvmBDlRfVXzgYn
	 T0L+ZWCqg3RlggJF85FChcjFI+JKIn+zYoc/7e1cw73/AMv0rKfFyqdgMX3VFhyqGE
	 K+AT+2DLqerXmyD49YGoJYACDDLrCVuNZOAYXC7GXKt4BZidZc1ioI2/1ca4XYIlAG
	 sDG9aTPK2ZBqw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso68918781fa.2
        for <linux-kernel@vger.kernel.org>;
 Tue, 28 Oct 2025 14:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVnHsvuzdDX91I3hF+diTVrwY04ew+5DU7AGlxtTtqX5RjiPShKb2u2OD9V4PeYBupJzi4ySdBm9iLZmG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJEIJ4SM7q9jy0r0be6+CCUzEHtcEv2SuWvkVad1nSEcddCXs
	/zw6wZ0Dt9Lh9jr94yYXW91Yf2cfYbiKfKNalCdRYNNlsB30ZenN3IL2mNNRfPRgMx9RQTF9gV5
	7oa9lCo/PsgMaGqii1SZo1RoJqDY/umw=
X-Google-Smtp-Source: 
 AGHT+IHCUZNznvGnyAeM3MsrEbUvbfYY8Ofh1rl/iKxOgrVkVgMqtD9DWJff5kDrqlsYrcDM61o/rWifYbzcQj/6jRU=
X-Received: by 2002:a05:651c:154b:b0:376:4320:e362 with SMTP id
 38308e7fff4ca-37a05308872mr3008561fa.48.1761687604498; Tue, 28 Oct 2025
 14:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <38a49942-58d3-49cf-90d7-1af570918ae5@kernel.org>
 <CAGwozwEmjms0H=GPbevuOjJfed6x69wmg8E9begBhUKbF8B2AQ@mail.gmail.com>
 <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
In-Reply-To: <000cd38e-7052-4987-b5bc-b8de176363cf@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Oct 2025 22:39:52 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnuPXV_PEyl7Lq2WqyA0vpeGeX08nQol3KVn18-zZi2hN62hENUgRjfly8
Message-ID: 
 <CAGwozwFDsn0xm_mG4ypEym=K8c81qqi=qtJL=06nP6SzdFaFoQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Mario Limonciello <superm1@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176168760530.4020210.17460419379281034936@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Oct 2025 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 10/28/25 3:34 PM, Antheas Kapenekakis wrote:
> >>> The fan speed is also lost during hibernation, but since hibernation
> >>> failures are common with this class of devices
> Why are hibernation failures more common in this class of device than
> anything else?  The hibernation flow is nearly all done in Linux driver
> code (with the exception of ACPI calls that move devices into D3 and out
> of D0).

I should correct myself here and say hibernation in general in Linux
leaves something to be desired.

Until secure boot supports hibernation, that will be the case because
not enough people use it.

I have had it break for multiple reasons, not incl. the ones below and
the ones we discussed last year where games are loaded.

For a few months I fixed some of the bugs but it is not sustainable.

> Perhaps you're seeing a manifestation of a general issue that we're
> working on a solution for here:
>
> https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
>
> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
>
> https://lore.kernel.org/linux-pm/5935682.DvuYhMxLoT@rafael.j.wysocki/T/#u
>
> Or if you're on an older kernel and using hybrid sleep we had a generic
> issue there as well which was fixed in 6.18-rc1.
>
> Nonetheless; don't make policy decisions based upon kernel bugs.  Fix
> the kernel bugs.

My problem is I cannot in good conscience restore a fan speed before
the program responsible for it is guaranteed to thaw.

The best solution I can come up with would be in freeze save if manual
control is enabled, disable it, and then on resume set a flag that
makes the first write to fan speed also set pwm to manual.

This way suspend->hibernate flows, even if hibernation hangs when
creating the image, at least have proper fan control because they are
unattended, and resume hangs work similarly.

Antheas


