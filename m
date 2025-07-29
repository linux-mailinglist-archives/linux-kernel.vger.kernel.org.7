Return-Path: <linux-kernel+bounces-749120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDAEB14A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D90A3B0EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC04276048;
	Tue, 29 Jul 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+UhqLXb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978D2853EA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778822; cv=none; b=FPKKosV7MiWw3Kg+aZTIubEbhKocwrxle+NFhj9dpLjo3PhXVWuIfbsosDNT9XfpG3kivTbjsblTSAKDQxFAthvdmdJ2aZpA9DodlmHkVYBhY+8nsTj3+tWoyTj8QDFh+LmqdZKdinwIDA4UhOky26OrrxKstptRFTTjNP84/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778822; c=relaxed/simple;
	bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXI4dXxBzkfnmRh3BqDpdV4+rW3jO9DQD+g2Bh8ksDsffS6MagXLiqVuQO7OtnTvwRh9XJqCTIvOo4cbu78zgeYWC0FPqmF2Q0ju28OjsP4K4ah4ZqTwGZeTulzqsO0pI92S54Yr19yQTn8NHBsVO3UFjD+TBoLtuu7urvevlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+UhqLXb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753778819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
	b=c+UhqLXbo9/EwYeLSVZvdmizQK1WUnWy5ldLBD2uA6dQYvOxXWPUfVuM0eMyr6C2+SyQ9i
	7wE1M1FiFD/OdE8f4WgbNRfWQtoYgiJ4d6/o6VpEwtc68OuNa1Ovng+xvJesXFUWeT2Zkk
	7Dq0K5Z+K53tazh8QUCEC3zyll2G8UE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-q4gbc2HtOgGFyo9U0ddPSw-1; Tue, 29 Jul 2025 04:46:56 -0400
X-MC-Unique: q4gbc2HtOgGFyo9U0ddPSw-1
X-Mimecast-MFC-AGG-ID: q4gbc2HtOgGFyo9U0ddPSw_1753778815
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso26754445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753778815; x=1754383615;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeklVPatKGQJK226Ipf8izovC/a1rB5bC+YlMlow3Zk=;
        b=eCMEUUQ2h0sZTr32rAq77ZO8qjC/2dM6gALwsXqbAcJlGi2MSCba2LPgLomjeY9aQe
         czq6rL+O0H0h3D/ew3FadNFo6+Foz+fOc6LMxld7WgWDt+d2RK0rWforKUovIh3zAcNK
         L6k2eYh5xEs2pGbHuThJmlrixXBr4FVT+uF5FzRE2G7Z99iAlJ7zQruSBPR5yLGBRH2/
         Yd7mTItNmwQ/wCXmPyP80UVgH4tiwibFMpSCPpRcRCuhdHKtmvLxM3SxEwC6f4CtRZ9Z
         rPhfoJTlqghcd71X+3nMl0aX0DRs532nCcQfLxin0DtuZcBJxbl68UsTB7mnSau2TTmA
         W1ZA==
X-Gm-Message-State: AOJu0Yy7UfNIkCz2W4PoUSw0aRmhYVGdmITVO8/MuRQ1c7yk3MFAxD9w
	mJJc5M+Hnzz9ZPbiplz0N7OkkOdRuV3fuyOU7W45iS8bdsB1HbZcdvVc8D3K6yzIOTkI7ZDqPHv
	YjMnv3oYOgsUAtgBUOxfc4TfH1H2v/W37jexQ+pFMhcSWFDotfrhjZLsgIeWnUO5wLA==
X-Gm-Gg: ASbGncvk5tgKX76NmgVJH0FCY9OuR0RXVYr3DSiZjPFA6C+rRL4jfI/pjmK2CW4IfYt
	j8++ghx+Vz9+ALmueazez93gmDctDt7Y7nQsTZ5GpqMKCgD6oWyzlbWVgFfiYmeTCvlJXC1EGq4
	kvyr/HT/Hev5h4sBlvwnA0HL8Sx8KHVEWLC7v9qs6fXMtR17VHXDsrgLah0uEtKDdkdJUon0WtI
	u7HnAEzEmHkWXGxNkNGEWe4vX3EN+X8faqo+0kBLOWv0KlMIu6rbNjq0thB7me6lTXRcU/j+KJc
	YMELBf6bIo5K2hRsER4TNcI+LQPyPERcXmg8zppM2tg/oeVtVqzJfriuCm4cUwbZuA==
X-Received: by 2002:a05:600c:a088:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4588adc3677mr39809995e9.26.1753778814868;
        Tue, 29 Jul 2025 01:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENm4rGB9QH5ZR2b+CQxX8IopxI/UqZi4w2Zrp9xW5q/tHuwjGtN0qFNHlnuI29FnnDzuK6cw==
X-Received: by 2002:a05:600c:a088:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4588adc3677mr39809655e9.26.1753778814422;
        Tue, 29 Jul 2025 01:46:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78dd6cb0fsm2299807f8f.29.2025.07.29.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:46:53 -0700 (PDT)
Message-ID: <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 29 Jul 2025 10:46:51 +0200
In-Reply-To: <20250728155332.sbkepHj7@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
	 <20250728135022.255578-8-gmonaco@redhat.com>
	 <20250728155332.sbkepHj7@linutronix.de>
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

On Mon, 2025-07-28 at 17:53 +0200, Nam Cao wrote:
> I gave this a try on riscv64 and observed some errors:
>=20
> [=C2=A0 620.696055] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
> [=C2=A0 621.047705] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
> [=C2=A0 642.440209] rv: monitor sts does not allow event sched_switch on
> state enable_to_exit
>=20
> I tested with two user programs:
>=20
> =C2=A0=C2=A0=C2=A0 int main() { asm ("unimp"); }
> =C2=A0=C2=A0=C2=A0 int main() { asm ("ebreak"); }
>=20
> The two programs are repeatedly executed:
>=20
> =C2=A0=C2=A0=C2=A0 #!/bin/bash
> =C2=A0=C2=A0=C2=A0 ./test1 &
> =C2=A0=C2=A0=C2=A0 ./test2 &
> =C2=A0=C2=A0=C2=A0 # ... repeat lots of time
>=20
> Any idea?

Mmh I see what you're doing here..
Those instructions are supposed to raise some sort of exception in the
CPU which apparently disables and enables interrupts without raising an
interrupt handler tracepoint (the discriminator for this monitor).
This lets the monitor believe we passed the time a switch is possible
and complain when it actually sees one.

I still couldn't reproduce it on my VM, yet I find the timing a bit
strange: it's alright we handle the illegal instruction like this, but
do we really end up doing that while scheduling although it doesn't
look like an interrupt?!

Could you share a bit more about your riscv setup? It might some
configuration/hardware specific thing.

Thanks for finding this,
Gabriele


