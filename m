Return-Path: <linux-kernel+bounces-851956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BADBD7C97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45A11896E21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA830DEA3;
	Tue, 14 Oct 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXUJKe1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCB30DD3B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424952; cv=none; b=gjwPDXRFyC0TRhptzQitx7Cy3GXBIlITd0aAcbi8uwUuCjoMxsfrjzy+aqSGjjDg1MplSMQpdxBf/PQLkUtb7v7NdYun23HQP03WpXa7VKyP40cAJaRUOgeER6qLC0YGY4CvkvSCPyI3q9CNsenZOgptH8h0kDmW/+3Fvqu4hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424952; c=relaxed/simple;
	bh=/H1EjdkWH2nxhcKPrBFzjxh3PQeM2OIVOscEY1gusfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHqHkSKpIPf4pSvaimS9BQfozCJ90UV42628row1HHWVpZ3gW3pqsM+VrzhAKp/2m/QjhdBaUhs3SamNM827moJ3zaVsi2Khf1HGQOavLbuDIol15rWsb+DNf9PqcOkgsi7m7zJR1RGdmeVXuVsQAayfQ8foZvLPyeYX5s59iWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXUJKe1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760424948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJiiSCVG4H+MF2iq6yuseKw1PPLKK214MGsS71Xr3io=;
	b=HXUJKe1w/qmLwg6MISm3jhmWGIHbh8oXymPkTLz6SbVkAigjVKWiNpIsgvYshFggn/ZdT5
	AVB8mJL+M7SqiFCMAV5amj5oDwuFPIwJ8qmFS0n1OKFzDo0/D/Gi7Jg21cdq9awSgMSgSn
	KfAupeWOt7o9HYTgXwV0wsdHfMbA/Z0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-o5ePZeeXM2GLpr-8vlXm2w-1; Tue, 14 Oct 2025 02:55:47 -0400
X-MC-Unique: o5ePZeeXM2GLpr-8vlXm2w-1
X-Mimecast-MFC-AGG-ID: o5ePZeeXM2GLpr-8vlXm2w_1760424946
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3dcb36a1so38611555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424946; x=1761029746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJiiSCVG4H+MF2iq6yuseKw1PPLKK214MGsS71Xr3io=;
        b=F0ey8b4EBecjiAkKN9F08pplnFEHhgSZ9aIHdJZZ6iXsa88nDg5L02YVcChMjqSga2
         dfUPGdMsBEMzYR5OLH/k/IGjKlGAloVr5l3KScNhcBT2c+PjtH5KVO0ka21EZVVG8ehO
         gvkXsw377Uc9s+0Y2NowB93esz42TQNf6nRdq1dF/AtlnG2JFIv37bTF5jApJTysg1vh
         gNwp9VGeiBPiMqJo+3EPDaPoJOeaYEUVVHj9CkLxpHkN5RoHiP0ZbQF8Up6xrQXevUFd
         bAHD5mkT4KIf1+lv+iJR2sd2P5zCga8iOkL4v1eRPgv69cjsmv1urnQ56GjL/7EPFOXb
         D17g==
X-Forwarded-Encrypted: i=1; AJvYcCVcK7fUk3F6ywGfHLMgdPEvXfC05QvbNSsv6CKLpkdgCq1ZU0Sr3ifUmgdGkO+li/kWlfp9Uw35dpf/Ezk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkxtJlgqfO+nMvaKURBNihzv8qB8iADcVyo3uEW3L5PLxKL+2
	cJUgSNaBmgow//7hdi/YnumQ8bVwc9Azyf48re2b1Xni8y1Gz5jRmIsQadc5t39VJ/mbd2NxLFo
	J7mtXCtqu+yz3ZSozk+IeHIXfh/C7HXKiLchkAxjw1/0I/vIzvti4jWw7tXdS7YAfWw==
X-Gm-Gg: ASbGncsO5VRRAdpbDON96RuTxl++F61pXyNKYhxKt85rGFVT+lvPBXcyeNh0NI3T+HQ
	VpiCFrhB15+Ja/rpYA2EXS0lnoi2Mt6KLk7J6DMyEan90T9n/zRJ7T2u2/8K2oYDguZQUwXqgp3
	hlIxrRtJX52ojPx6WpMDkmVp2S9ZG1RvVTXeSREyPJXuzQ2iRKumrVdi68Bqr6cnKT7+azs4An3
	Ubqxzzgdmi39+4rMUQJVLylO5k2p6CU8FJWWNcU+uoSzDhfJtTM58MzRXViuPUJGtFoo4nI5eo8
	8RYboh4JWSbNAXfwoYLlnjpcqOq1UTpfU0YfRlCGuL+VzoaYPyAuiYhoonwlZN73Pw==
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id 5b1f17b1804b1-46fb42eee4fmr122418915e9.41.1760424946175;
        Mon, 13 Oct 2025 23:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFlbUjRO9R/NpxxXldayXIglwjuXec+Uez9hxiwOvKHT+csT8ueG+UPjaUZgLVeIy5qL+RIQ==
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id 5b1f17b1804b1-46fb42eee4fmr122418765e9.41.1760424945788;
        Mon, 13 Oct 2025 23:55:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm142757855e9.5.2025.10.13.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:55:45 -0700 (PDT)
Message-ID: <1a0d9a427b36d4bcff992dfb8694436cd24d6af3.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 08:55:44 +0200
In-Reply-To: <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 07:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> Reactors can be called from any context through tracepoints.
> When developing reactors care needs to be taken to only call APIs which
> are safe. As the tracepoints used during testing may not actually be
> called from restrictive contexts lockdep may not be helpful.
>=20
> Add explicit overrides to help lockdep find invalid code patterns.
>=20
> The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
> reactor. These are indeed valid warnings but they are out of scope for
> RV and will instead be fixed by the printk subsystem.

Looks like a nice addition!
If I get it correctly, this patch does trigger a lockdep warning with the
current state of the kernel. Is there a plan of fixing the warning in print=
k?
I assume this series would need to wait for that or did you have other idea=
s?

Thanks,
Gabriele

>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index
> 8c02426bc3bd944265f809e431283d1a20d56a8c..d9d335ae9badaa320f1d35dd159a033=
c3a30
> eb1a 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -61,6 +61,7 @@
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk
> =C2=A0 */
> =C2=A0
> +#include <linux/lockdep.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0
> =C2=A0#include "rv.h"
> @@ -480,6 +481,7 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0
> =C2=A0void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> =C2=A0{
> +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> =C2=A0	va_list args;
> =C2=A0
> =C2=A0	if (!rv_reacting_on() || !monitor->react)
> @@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char =
*msg,
> ...)
> =C2=A0
> =C2=A0	va_start(args, msg);
> =C2=A0
> +	lock_map_acquire_try(&rv_react_map);
> =C2=A0	monitor->react(msg, args);
> +	lock_map_release(&rv_react_map);
> =C2=A0
> =C2=A0	va_end(args);
> =C2=A0}


