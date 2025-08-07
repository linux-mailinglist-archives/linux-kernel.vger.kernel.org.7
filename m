Return-Path: <linux-kernel+bounces-759108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CFB1D88C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F53BC60E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68480259C85;
	Thu,  7 Aug 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjBEaZ+K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E3256C89
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572009; cv=none; b=Fq7c8dmG1UYXi7MxMM244hVmT3VbvgGNTsO/GsIHkJZ8PthSXg2iOJnyrvZCxRUOSBFLhAABc/OVv3tvs1jMJMKq7PzpUuCtH9qS+s/ijeeJzBHUae0p+6MlqG8mWZLumPOlDFkwtGyTi3ied+Fyw8xFUzGj9Tg34/uBbhcXusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572009; c=relaxed/simple;
	bh=BrZoqI55gDUKYWyrbKqWx1pT/0zoSkl9l5rCcBfokHY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qz9V3kE5RBRmFdCsPBsdBIsy71Br+vPOvScAZZ6Vc58tAwwQvJkP2S3i3hSKRmA8zoT0un/aSiyx3Lx1F/ybIFe+qk/vaigWLrlCMFNbKCVNZNtNo7dBY7iXVeV6V0tZwYT2VbdzHwKTBTXByNNOkf4Ix0vhGK0bXErbGetnGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjBEaZ+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754572007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DSIPIMT9naRgReubOEbbzM4FjlFFTRK0DZ9wbkIeIeM=;
	b=FjBEaZ+KCbNaW3dqFaemhmvTzqrlRGB8D6OHKC1oNIA9Uh3rlTG7Gm3ObV046SYc4rKy2s
	X/uFcDXOHoZHVWTHvTTUn3FW1D4W0CXEsg2BzsC33dKZwszS8rJ1vZlHfNY+CGCQwXXwXa
	MYTdT5W9eV+0srdk5wOnhlOq3/HD63c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-O88bZ5erMKCBXUYvayMFWQ-1; Thu, 07 Aug 2025 09:06:42 -0400
X-MC-Unique: O88bZ5erMKCBXUYvayMFWQ-1
X-Mimecast-MFC-AGG-ID: O88bZ5erMKCBXUYvayMFWQ_1754572001
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so4231145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572000; x=1755176800;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSIPIMT9naRgReubOEbbzM4FjlFFTRK0DZ9wbkIeIeM=;
        b=rFLJHGxcTrjf4x8Hr3xGoBC1qO9RULss3fFKh6oZ9m+Ar9XR1JTh40I8PqJDcRwBNt
         bmwaQFe8cIaNx6c4sHt8ERD91vGmJ/v3LPBQjdRV/FKVLxYgwvGLuzjYM/hi/nKnZRqx
         CJVKRHi2YHz86VAYuUN9PN9rBtnf/F9mSJKbYtdHAKM0Si0m8b+QJPQxbiBhY6UEawm5
         5zUl5xKvrn1oDiIyE9hAeBFK0UZmQOymKqfSAvBths0aV5mKSo5xbltuWrpbO7bSHJ6n
         6bZ91okXFvf9iKXgVdlX1LDBVUs5jpSyEHGmeGb0wpIu3u0cXr9FFtMfARi6Z3kWjngm
         MtWA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4VybdJQWTEy06wQQGjDC35wizEISk5R3dE5Vqgb/RSnKq1yB5ioNyL0Ttz8It/XUCFBhmrGZFOqQmZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUNTLetjqDCRUgaSLDB3lBCKqiobqdESlUOd2MVrDo/v3+/j4
	itGFwZgNopi9S+EmX5Qkdna/Vq+jIKD+r4M1hTip1ITctTKH1ljLHYRgKEZRNBMmAInI7WHRVW0
	+rtm6nLur/JKRY3mjv0kJa3td40azwUewlaNbpEx0i2whsU/Mbi97vXB/OgU6HDOM2/l+38dLHJ
	ls
X-Gm-Gg: ASbGncuhOBMYnRlTRWR4orBMBpLSw99SWKp5e/KC/ObhAHYjQkJ5hL6nIbiNeK/w0fG
	NlY+4sYXkBqkq+SR2s7rK3rHRamYiz0djkXxYOyG1AANN4i3m3DvKzeMkkPFrqafkxx+GZFS9R3
	kHOHMyLkwmrUOhU4NZd0+z6m4SfZ3+3tQbPgFL5Fi0fbTsy1/uXD71V0otk7Gu/1bl1ATg50bbi
	6NrDi4S0Fz5WfRNtGdBJ6IyrMIPSeeg5Or6ZYrjspSRbod+0PXDc1+9gYuU2z6th++g6xBsAZ+t
	s/LTTaHqI1dzrCH4J4E7XUhaegNvgfSdeJPGN9DT6J7Q+57SALzMk/4jgGyzp6LPUw==
X-Received: by 2002:a05:600c:190d:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459ee85db15mr30439125e9.17.1754572000608;
        Thu, 07 Aug 2025 06:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvuQErMrs7pQQjbgiBrZj5Oe6HhNXNVcrP7y6W8RfdTgSKkAlKOOHrHkibb93XutcY29YK/Q==
X-Received: by 2002:a05:600c:190d:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459ee85db15mr30438635e9.17.1754572000105;
        Thu, 07 Aug 2025 06:06:40 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm189342675e9.22.2025.08.07.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:06:39 -0700 (PDT)
Message-ID: <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Aug 2025 15:06:38 +0200
In-Reply-To: <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
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

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add support to generate per-cpu LTL monitors. Similar to generating
> per-cpu monitors from .dot files, the "-t per_cpu" parameter can be
> used to generate per-cpu monitors from .ltl files.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: Rename "implicit" to "cpu"
> ---
> =C2=A0
> -static void ltl_atoms_init(struct task_struct *task, struct
> ltl_monitor *mon, bool task_creation)
> +static void ltl_atoms_init(%%TARGET_ARG%%, struct ltl_monitor *mon,
> bool target_creation)
> =C2=A0{
> =C2=A0	/*
> =C2=A0	 * This should initialize as many atomic propositions as
> possible.
> =C2=A0	 *
> -	 * @task_creation indicates whether the task is being
> created. This is
> -	 * false if the task is already running before the monitor
> is enabled.
> +	 * @target_creation indicates whether the monitored target
> is being
> +	 * created. This is false if the monitor target is already
> online before
> +	 * the monitor is enabled.

I get you're trying to be more type-agnostic, but I believe this
/online/ is a bit imprecise, unless you register a hotplug handler and
just initialise the online CPUs (much of an overkill I'd say).
What about something like "this is false if the monitor exists already
before the monitor is enabled"

Other than that it looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> =C2=A0	 */
> =C2=A0%%ATOMS_INIT%%
> =C2=A0}
> diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> index 49394c4b0f1c..87d3a1308926 100644
> --- a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> +++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
> @@ -6,9 +6,8 @@
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
> =C2=A0DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
> -	=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task, char *state=
s, char
> *atoms, char *next),
> -	=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task, states, atoms, next));
> +%%TRACEPOINT_ARGS_SKEL_EVENT%%);
> +
> =C2=A0DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
> -	=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *task),
> -	=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task));
> +%%TRACEPOINT_ARGS_SKEL_ERROR%%);
> =C2=A0#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */


