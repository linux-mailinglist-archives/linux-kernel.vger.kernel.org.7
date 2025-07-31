Return-Path: <linux-kernel+bounces-751758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6BB16D12
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4821AA43F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D781A0B08;
	Thu, 31 Jul 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co/VlKfg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6135971
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948956; cv=none; b=AsgiyzVfF8xWcST0dqZaEXBEmjU1qdz61+RASRqL4nQTJlyPuZu+SPa2wynp/4k6uYYlEGNyChmhucJFh8QYcS1GU5ptYAV7g6R79In9d9hnyGSBgvYt298AzqX0CjswAfMsMupq5WpI31+uQqzwtDkyIhcqSXxjpTPLSyyNHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948956; c=relaxed/simple;
	bh=hjBwaGnLy5CWQpFZyVd4gtLmbuLVWoAb5Z6jFB8161I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9oQNSvIA96J6q1NKXlcR8wE84mnftUolwV8MVp8pH3yhVQswG9hr8ifynsVsW67YEF89VfBthYbHvMOulKLLeOpZWfahy5BwhMa77ALQ/YjWFD9+Nw1mxYlWcvReQrsfEMaQI5gMlmNzVTYQEtZrTSQPpXwl+/dmrGlghljxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co/VlKfg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753948953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lgv6U/W/hpoRUHyZFqCrSaXyDup15bzLQFsiG+oYoJU=;
	b=Co/VlKfg6p76cwx/SnxHn/8Q6tpziHtov84of9L0JNWKxwu7bOIytAX4x5tM1Ie3gsvtHo
	Oiwor0mRAHwnxD2n8UX4wI8C6MijNUmWhX5EBIi4qRFxGV//Qbsccn0NsEVnucf71hTr0V
	zvocfV8gmb6BsxwBmdAbeaZrzrqC5Jw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-pEJAAtCZMaeAs9-b-BG1jg-1; Thu, 31 Jul 2025 04:02:23 -0400
X-MC-Unique: pEJAAtCZMaeAs9-b-BG1jg-1
X-Mimecast-MFC-AGG-ID: pEJAAtCZMaeAs9-b-BG1jg_1753948942
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b79c28f8ceso334260f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948942; x=1754553742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgv6U/W/hpoRUHyZFqCrSaXyDup15bzLQFsiG+oYoJU=;
        b=IBH3OyzeGBkWb78Und+X11D7MZh3kH5LiOtbSa1SA9xUfS2rmWwp33RR65onEiDkwf
         uIlgdCHcvjyjG6yi/KeEMdfS9d6zmJMtlcpo5CMq9YIZzjO4CfXIiOHiy3mFwLqvfpCm
         d3DyXgPEMDT+rkslHbhjJTfJtRP8F1uNI5wUp3nnMN2P/xMvMYraW/bU5PkVb1qsAVAh
         GxTvor8g5Bl6IpaFmtKWWYRT0h1jlbv2kSrKjOrYmgrzZrfb+6PZsvGSIRmujWVB44Xp
         FnZ0uP2m2Z7XrFWhrWoes6GuP7IrAEUzEVrAeLceKawx7z9DmJ/5BWqi20whi7QEAOSr
         aaGw==
X-Forwarded-Encrypted: i=1; AJvYcCWctSrtU6gsDDs1aBg63PomLo0sNOuX/tI7+29z9PxrZ4WfwfFiP5eE/Q0+DTim/V5tci5IiMz54OfWNyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzPX2bMmH0d+8djVG8m02MYbhgIWkdQjnFRABLnlMLNq5Rr6Y
	pUyKxnV2Hi3glhK1sTe22zwy/grXtuT8eCihjRElTJsBeIgWS9hoZWC4D+XgvPdz096Tf98VTNc
	OTEGiJp24EkT4y+a1n2Jl5AgnsFvylRDQVy/XjLrq9B6RyPPVzbfgCj2s98QH/4jz3w==
X-Gm-Gg: ASbGncv41t6IjI7+65RmpBuazGts7WhRXKch0tAh/NKZtjO1NuB9mVIO31b6BlJ/xx6
	W/WRr/HleyIbADDYlsKX5+qrCZkzRxV3UuWEpuj9o/UNDw3jAooEx9AIVyEcGqIW7K1JcPDeeUR
	gGhDiJLoyWK7Xr3a/jPat3gDchG3jwSCH/m0knjeaLRe0j4/fChYyF8aUOohEtYdh9tR9yyzIB+
	s7KuUL38XdvDw3y2kh1dl7X6L+WBGMgxCI0xdFJIb1lR/WLqCf/Pl/ooeKWLkUJztrJJrRugOk9
	QaYcz5Oj6VVIX/SihJbDXyBiGeoGzcJzZE2Z7j0fxjxgHKIrm/IL7qSiTdNypZU7dA==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr5082559f8f.13.1753948941972;
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pG6nXG2ua5v/+0ufLTKW+zE77EAA3F4z8dCGzhgrLwSHi6vxpr0yH0anYvSH+8Di5uZR8g==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr5082530f8f.13.1753948941555;
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm1482291f8f.43.2025.07.31.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
Message-ID: <0fb442dc58bd36345b60f4bb8f6be73db74900ac.camel@redhat.com>
Subject: Re: [PATCH 2/5] rv/ltl: Support per-cpu monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 10:02:19 +0200
In-Reply-To: <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
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

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add support for per-cpu run-time verification linear temporal logic
> monitors. This is analogous to deterministic automaton per-cpu
> monitors.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>=20
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 4a6faddac614..f9e5fd044c45 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -177,6 +177,53 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
> =C2=A0#include <monitors/pagefault/pagefault_trace.h>
> =C2=A0#include <monitors/sleep/sleep_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> +
> +#ifdef CONFIG_LTL_MON_EVENTS_IMPLICIT
> +DECLARE_EVENT_CLASS(event_ltl_monitor,
> +
> +	TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +

You don't really need to follow to the ID/IMPLICIT convention here.

These LTL per-cpu monitors are, in fact, not implicit since they do
have an id (the CPU), implicit makes sense with the current
implementation of da_get_monitor that uses the current CPU (doesn't
have to stay that way, but there was no need to change so far).

If you don't want to get rid of the task's comm in the tracepoint (and
unify both with an integer id, like with DA), I'd suggest you use
different names like CONFIG_LTL_MON_EVENTS_TASK (in fact that doesn't
just have an ID) and CONFIG_LTL_MON_EVENTS_CPU (or even
CONFIG_LTL_MON_EVENTS_ID, for this it actually makes sense).

I'd prefer it as general as possible to ease new monitor types, but to
be real picky the LTLs per-task are not ID and the per-cpu are not
IMPLICIT.

The id field is what the rv userspace tool uses to differentiate
monitor types, by the way.


> +#endif /* CONFIG_LTL_MON_EVENTS_IMPLICIT */
> +
>  #endif /* CONFIG_LTL_MON_EVENTS_ID */

Also, I'm not sure if that was intended, but
CONFIG_LTL_MON_EVENTS_IMPLICIT gets compiled only with
CONFIG_LTL_MON_EVENTS_ID.

Thanks,
Gabriele


