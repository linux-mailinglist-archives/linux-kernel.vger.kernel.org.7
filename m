Return-Path: <linux-kernel+bounces-747711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFECB13719
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B617448C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE49238178;
	Mon, 28 Jul 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCNf76i5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8C23814D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693149; cv=none; b=Yk+saj0lFZzPQNb1sRsegCeF0UlrlwtUOm0lDxQnFNnBbtI4lHdpudz6DR++9vTvbn4Fg76yXTU2ItsWyBVZLtYSSRivu6A1pBhEeMiuZjaWzH7GGBn2GkgPGlB+vGpXFxZKPN807pTS/xbzQfrmvPV+bVTmQGqZOZc30q534vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693149; c=relaxed/simple;
	bh=wIBGb669iROAJB0BuOaY918l/WFogfhv+RxrjAABtHM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hL2R2Wzhr7CkXz4tHRc9VwFiwweDYJcSWirSqnCsee5b3IMweyKYsx0t+PId7tzW6j//A4ftBElCIYxHPSxftDA2Sj6Np4kwOavlWPshP0Eo/a34KgyRmLXT3PIuBOHj4MZ0+k+I8/O/NkUeOiJRQ46yXRBc7dF2AomVzQkieTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCNf76i5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753693147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yrr7x9fAxuAGHE+0RbZWBm6ofiZmwJUP/auBwMym0tU=;
	b=cCNf76i5Snm5idJnp4X0zQqF7NIGACClCQGkMR/OwHR67H6x84n25VOdzhvSt/ppbO5+KH
	vZ1RJ77Wg+/gaxYKGbhbG+atNShYp4INqvW7cSEUq+OGFgWsQLagosDFpeJcRr7g4JA0NX
	bp0nTR2jYrrEehBykqA7tlJBo/6jNrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-CPb3LyTkM4a8XzxrMV2Prw-1; Mon, 28 Jul 2025 04:59:04 -0400
X-MC-Unique: CPb3LyTkM4a8XzxrMV2Prw-1
X-Mimecast-MFC-AGG-ID: CPb3LyTkM4a8XzxrMV2Prw_1753693144
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456267c79deso9998915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693144; x=1754297944;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrr7x9fAxuAGHE+0RbZWBm6ofiZmwJUP/auBwMym0tU=;
        b=j6MFjCLQoilC83j3l/gAhkyVVcOcUwZ1kvB3M99NnZ3qcgI+BfrY3PLUSyYLBiKTPc
         slUKeE08DYDaWgihS7TKNbnU4IFiX5b/h1tH8keR3zQvrjnvfXK6iGuJ7nOCO0CG0bCQ
         PFmH6sEOoSDlpRF7GVXzodvpIJxOJuhoNgs5eDOl7W6bu3FiiG9OEhuD8s8FMlP5hiEd
         kLGPWIpRdf47nV2YUKDRSTPi8OWWFHtTfRrPDizzJsimD8ujo6LF2Rg+sMR4gB5NONVA
         69kHlkYMSq04r6hdFYMjjC34XO/vRx/w/9bIc6La06V4MbQRyWgGwnm21z0C+g6cu8H4
         +lZw==
X-Forwarded-Encrypted: i=1; AJvYcCUfBXPN3NgHDczryGPBsOWxvKw0syVmFSL/Xe/Tf2N3zD9pQJ07N/8M+SkeOiWI6HSS1Zkeli+uZA2zppM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhSC0Sn8IHdeequ0b30yPaz2rwmxffWO8cP/O27X6QC/McfZ4
	2Wux4KT437niYUbHjAplXl4aqGNv7qpfFnwnZMW2J3J0UzsV5eibpIp2bIr3bnUv3bSCpnvIf+S
	AbSwzierbpdyRLAwYzb1iqw5DmlEVMUqC8D02KPUe2c/zPmeRvk6G0sqE7kYmKiFr1A==
X-Gm-Gg: ASbGncuLE1RnTr1tBQ5SAKoprr6J7PRaMHOi9hbx6tIEOAfmhJAi1d4cYUQrCM5xWsF
	z/2XyyxIxfqqIRQXIiGocU+FNfCm0rk5/qIqfy528Dtdu5wQ+S5iERfwJS00q2yLro8rhMpDYTT
	o34cXfI/zpZo6eBGLqjF090VE2/dvSyH3wKcEF5CiUkrtoLRqf8gmrHSraTdImnrTNZ/vhuJWTM
	0y5PCDb41z1jSdYInqYtS6hUPswqmIscKrEtMXLvQ999BNmZ01xKfK1CCWhl1kUFq/IUfXeUI9i
	BAMvrQoDGP0i/SB6/5R7PrskqthK1cM48s75bKo2F1paoSmQGsHtiY3kTByEQwVwYQ==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-4587654b626mr107756305e9.16.1753693143738;
        Mon, 28 Jul 2025 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6V4rBC01wlsEfxp2PWoqkhk1+LmJwURJ+0I/kuFMiJMXfQcv8SKtfyaP6HZn+rsWH0Gy7cA==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-4587654b626mr107755945e9.16.1753693143200;
        Mon, 28 Jul 2025 01:59:03 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7811b82c6sm6553721f8f.49.2025.07.28.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:59:02 -0700 (PDT)
Message-ID: <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 28 Jul 2025 10:59:01 +0200
In-Reply-To: <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
	 <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
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

On Sun, 2025-07-27 at 19:31 +0200, Nam Cao wrote:
> Argument 'p' of monitors_show() is not a pointer to struct
> rv_monitor, it is actually a pointer to the list_head inside struct
> rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.
>=20
> This wrong type cast has been there since the beginning. But it still
> worked because the list_head was the first field in struct
> rv_monitor_def. This is no longer true since commit 24cbfe18d55a
> ("rv: Merge struct rv_monitor_def into struct rv_monitor") moved the
> list_head, and this wrong type cast became a functional problem.
>=20
> Properly use container_of() instead.
>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
>=20
> @@ -458,7 +458,7 @@ static int create_monitor_dir(struct rv_monitor
> *mon, struct rv_monitor *parent)
> =C2=A0 */
> =C2=A0static int monitors_show(struct seq_file *m, void *p)
> =C2=A0{
> -	struct rv_monitor *mon =3D p;
> +	struct rv_monitor *mon =3D container_of(p, struct rv_monitor,
> list);
> =C2=A0

Good catch, thanks! The container_of is the way to go.
Do you have valid reasons not to move the list_head to the top? It's
not a big deal but it would save computing and summing the offset. It
doesn't seem name (the current first element) really needs to stay
there.

Thanks,
Gabriele

> =C2=A0	if (mon->parent)
> =C2=A0		seq_printf(m, "%s:%s\n", mon->parent->name, mon-
> >name);


