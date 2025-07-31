Return-Path: <linux-kernel+bounces-751839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77236B16E19
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BA53BB95C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A627BF95;
	Thu, 31 Jul 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDKDoJBU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0383244695
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952692; cv=none; b=jp36rx1zWQbhQVXzGhfib4v2yoLspKlzezabm4oki9HBaLt8yQBecB5as1sMT4j2Me0wrtcoLCqHOQezsQ9SUpJGKwycws7VKz7IFIU3cHmBvNt5OXyg6d8+kLrKUpDXcMY+lo4fJ4bZobMVJ6PtkBrkefjY6YpYwdE7vehF/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952692; c=relaxed/simple;
	bh=sSTeRlEvbMeUZ9pKhcKV571jD7j9O7wDXVhkDNETdhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaQzrcFnO383HPLhFEEiXr+lm8XyD0Erk2z8RwWtixzoq9WV04PL8PVQIu14x+aErO1wB0CNEGVLXHQ7RrRa8k4mB7WqRFECquiQ4wQg90GCAE/UjI4SHS6kwmKKfbKJZMIgbfpXh2cuVw4qEGGB9VbH036Qt2tZkYyMAqr+5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDKDoJBU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753952689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMND2eCV1zriOEfTEYyl8gkAo+zM/ZdiGMIBLba1//A=;
	b=aDKDoJBU00j9eEcNtRNdK46nQ3gJh6YXk1hcgTo3cHxZMlhYIWB+WzWZG9V2RHFhV073GQ
	UyxRTdnKh/BfgXr0SaqmOEwJVQIu+6Em2dzmkcKfqNF+vp9HAH68x3PDVgWoHnZhZtI9v/
	FaTVCYq587wacKApsl+9oWz+vldCPZY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-AwYQa8vKPSmEtC3HKwZ-hA-1; Thu, 31 Jul 2025 05:04:47 -0400
X-MC-Unique: AwYQa8vKPSmEtC3HKwZ-hA-1
X-Mimecast-MFC-AGG-ID: AwYQa8vKPSmEtC3HKwZ-hA_1753952687
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45896cf24fbso1398645e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952686; x=1754557486;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMND2eCV1zriOEfTEYyl8gkAo+zM/ZdiGMIBLba1//A=;
        b=sKgutyTEd902Ab9fFWBlwQMvG3NrgaoJ2f2sKMNwf6zQ6Xvjk1DKbaHv/18ip5291Q
         Q2vwyKujKwYC0I0Pmd1hDCtw53naEd9VQVoziPT4HevGiLuZo0Ka6yANeG9cEq/3GS9i
         k7q0cdFPLACgSoPbJa+C/UjTj3RbIkl7XAzQEVOt5CHQKt4acneISAEZz3h4mF39H/a5
         E1kxtOtV4fNt7iF0JnifofdG+LAvYTL8ek+KE87DZhocqhaOVppT+ZW94aKJY2AoIhft
         LgDZxbUyzBqsJYaTILgZyRTf8cQvvFQ6lo/mNy5WxV0zGwVC60T8aZBDvY/k1WN9M6wH
         QMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmAx/pFrvCiskcAIlR/nkrfl9y81iH7RwcyBtmetxD1JSvumQRMjLcI7DWT29y3lw4Rmx2duXCaGvq6Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qJ4Oz7/njz1GD0sKenRM66JiN1f/ps3QU4RDAH52SOFGXxXH
	k55qJ14Ha/Rx5yhBpVVLFvKXJ8snPoy8ir/CnLpiwIMoTfRMOam02GIr+s5oyFgK1lLoL3HDmkv
	jqzn4cI/e2nAfTIA8O7Rd2HQemYfGfWcoOPNnSUmcq2zr8d8xSm1dcDscDA9LogG4TQ==
X-Gm-Gg: ASbGncuj8a60zA1bMdvbGnA+j9sxC6yv40/v9oJE3j11NBOrs9fswtbUevp79FI563R
	L4nucGcGuk3uPCJ61Bak3c+/dcQnqtgybMldsAsjNKoMQrVl60xEnixun7d5jKPlPANBp8/fAC/
	KrKoQgkVKB5W/uURT4UFlW7DF9FvMLu8rnWlTvV9Qdv7U2DU6WP1EzB1khrZIIiMNv4Q4VY/b8e
	3gAzCLiV9hdT/9p7VCSIN41d42ImrZuiROqZBSIeCJW+Keq0tG8GWbOcl++Qfk4EekzvL7EriBa
	ZgzHlfiDsxe9UiQc845U1eFHphpEMbih7jCAH2XOSyOKQNK9uvd2wg+j/gipIKLydw==
X-Received: by 2002:a05:600c:3490:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45894ca4e2bmr49609025e9.17.1753952686574;
        Thu, 31 Jul 2025 02:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcyvCOcWpMoydPfhIGcE6BmPHyVSaaAWvBnHj4Nb20j+gkWmRYUb+Jbh+3IQ2C1Hevzf9Pjg==
X-Received: by 2002:a05:600c:3490:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45894ca4e2bmr49608735e9.17.1753952686145;
        Thu, 31 Jul 2025 02:04:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm55775935e9.32.2025.07.31.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:04:45 -0700 (PDT)
Message-ID: <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>
Subject: Re: [PATCH 1/5] rv/ltl: Prepare for other monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 11:04:44 +0200
In-Reply-To: <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
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
> rv/ltl_monitor.h is the template file used by all LTL monitors. But
> only per-task monitor is supported.
>=20
> No functional change intended.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 85 +++++++++++------
> --
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.h=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A04 files changed, 55 insertions(+), 35 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..175438a22641 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -28,6 +28,7 @@ struct da_monitor {
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_LTL_MONITOR
> =C2=A0
> +#define LTL_TASK_MONITOR 0

I stole your solution to get rid of macros for the DA as well (might
post it after this merge window or with the next changes) and I'm
currently running with this:

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..6a7594080db1 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -13,6 +13,10 @@
 #define MAX_DA_NAME_LEN			32
 #define MAX_DA_RETRY_RACING_EVENTS	3
=20
+#define RV_MON_GLOBAL   0
+#define RV_MON_PER_CPU  1
+#define RV_MON_PER_TASK 2
+

The numbers don't really matter and you don't need to implement all, of
course.
I'm not sure how are our patches going to coordinate, but I think it
may make sense to share those values for all monitor types.

What do you think?

For the rest this patch looks good to me, nice use of the typedef.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele


