Return-Path: <linux-kernel+bounces-724096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B6AFEE89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4291640455
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8DD2E9EBB;
	Wed,  9 Jul 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cydBV4O8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A51DDE9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076953; cv=none; b=HHvBgZiIsMCJ4qlmOGc5Y/YBgdZe7rGNfFU+ygnMMTUVo5ZBrPWKs2sePFvdctqEnnXOb1hZVN3VczEkmFHXBJEtB7xYB4GhkT8e9iolRjndzFLPJD4uKy7AC7jL1OQ5ggcbhnGyoUMj3xD38sO8BfpGc+XFgsgAn8tD6iLmXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076953; c=relaxed/simple;
	bh=BSuokzbXixe6q/OQ7pwwadPK8qyRDVL83e/47uJOXkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5GGVY220QZy2a56uWvLEgfEDVnyN0LvPATIQ6OKLMLPtszaf3E/zajY6IszH5o0x7YDf1551BamC2V3xVyO+u46b0i7zN2Mbiu712yxMlJC188pAsZKRBWNqpu2sP9vhiLGdCFgQMW/3AzfFExCpuXku7BKObSq4Gpqv9xAQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cydBV4O8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752076950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6MDV+jWx+iU94ZsVEjqYCAk3hcfaskhkPy0hE9SeE7Q=;
	b=cydBV4O8tCh3sTkKbvKTmAhxWJS57mgxhnVIvsL9ts1+/mQ3sruNyv0996DDTsA0aCP4YU
	BeBp5o5plE28pDMEMRIhaJrZ1tQnAdI4xznmzwza26bxKdt1qtOsrgXvZ2WfY1/jpo3q+u
	0YRR/qKzxAjy5QObS5YETD0SyjxztRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-LOi7lC6aPoya4vAwKl2xKg-1; Wed, 09 Jul 2025 12:02:29 -0400
X-MC-Unique: LOi7lC6aPoya4vAwKl2xKg-1
X-Mimecast-MFC-AGG-ID: LOi7lC6aPoya4vAwKl2xKg_1752076948
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-454c2c08d36so52435e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076948; x=1752681748;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MDV+jWx+iU94ZsVEjqYCAk3hcfaskhkPy0hE9SeE7Q=;
        b=WaRyTU5s/sZUSEKGx/wjjSqdAmPm1cTZwrn6R1klDtKr9/9GYZFzizAciwFj14rB/S
         bDHwLFPX7gNOTljmDxvbhHXBgZfq4czDa/p0Ww0m/vjxpOspXuk2WcR/9sfw9LnPdkou
         r/UG/RcVFiqQDdms9tVQN+G+KzdrVkWIktPRjaV60gBYH0/b9WhLoRUfTSHggVw3Sde6
         LOkFBOCgy6v+J3g0SJia8RMe0Ci62hswIBWidHaPRSxWb9XOfUIowON66gOAu2s3Apyz
         XG7XOXpIFVGRtYkIzv1HuMErBbtB1G3HfLDBLjRIq/0+tXYXQkE/bz7rYTG4cq0tozNK
         AGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXYRps1FOZAlM7wIzgtouZ/RphCHpgACg79Wyx1sGU2VRXbhC2bW53sYtW4V5kpZQKR+x8Qi4LNbxLXb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHqwG/Za6kIxD0ZN2F2awkOgbskNgVlXREZn3slG/PV8GQuv6
	qAXJM++5afcE5K8tVrUO4za60pqxVvJbx1dHOS1XIgNlVh+oHNVjPsDJMSIdYLmOAy2NpImX4Uq
	xQeh9x27x02qNQQHjKS0zOKXs5vHo7xjk9/CBuLOHEbU9siMnYEYesHRVxkbXANkFZjtiFucI/I
	y2
X-Gm-Gg: ASbGncsCLfCT1Ipy0RxKBjF/htd1xceMISlfV040HRVH2GA8C3UWKuDg94YX+L00vWp
	AmK0vdhh77rfLdsncXVph8d44bC5L/4ft0uYMvGDfSzhC22REZuvQmbbLeCV8WbYbDA4I+9Ivyz
	PCXNwkoidx0ecT/EYpoZd2SRbBqaBHMBnJRP+++tUZ6YOpW6ZaJJd2BhPW4v2zR0bS3CRX4TlEP
	uLP5lVmz1x3h6KUWqUnvva5oMIFB1UE9+zjVBDzubpjKJ4JxAg1QoctQjXlqpIUZ67sm+CVS56A
	Eg/GTd4fKYmNllKLXViS/Kr5o+19olt6DBiWSOUMeCWRpAKy
X-Received: by 2002:a05:600c:444c:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-454d53fec78mr29710095e9.32.1752076946291;
        Wed, 09 Jul 2025 09:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJdb51k7SVr8Zh7SvHc5+UDRIZH2uJc6ylYrhVlJe0wToVLnEzM9gYXOOUm8CZV5p5CNnDfQ==
X-Received: by 2002:a05:600c:444c:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-454d53fec78mr29709435e9.32.1752076945624;
        Wed, 09 Jul 2025 09:02:25 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d508cbdesm29617235e9.33.2025.07.09.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:02:25 -0700 (PDT)
Message-ID: <eacbe956f6815bccd4110cf3f82ffe76c0c4e09b.camel@redhat.com>
Subject: Re: [PATCH v11 02/21] printk: Make vprintk_deferred() public
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 09 Jul 2025 18:02:23 +0200
In-Reply-To: <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
	 <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
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

On Fri, 2025-07-04 at 15:19 +0200, Nam Cao wrote:
> vprintk_deferred() is useful for implementing runtime verification
> reactors. Make it public.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
> =C2=A0include/linux/printk.h=C2=A0=C2=A0 | 5 +++++
> =C2=A0kernel/printk/internal.h | 1 -
> =C2=A02 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 5b462029d03c..08f1775c60fd 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
> =C2=A0
> =C2=A0asmlinkage __printf(1, 0)
> =C2=A0int vprintk(const char *fmt, va_list args);
> +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0asmlinkage __printf(1, 2) __cold
> =C2=A0int _printk(const char *fmt, ...);
> @@ -214,6 +215,10 @@ int vprintk(const char *s, va_list args)
> =C2=A0{
> =C2=A0	return 0;
> =C2=A0}
> +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
> +{
> +	return 0;
> +}

Was just running tests after rebasing and I received a kernel bot
warning from an unlikely build without CONFIG_PRINTK [1].

>> include/linux/printk.h:218:20: warning: no previous prototype for
function 'vprintk_deferred' [-Wmissing-prototypes]
     218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
args)
         |                    ^
   include/linux/printk.h:218:16: note: declare 'static' if the
function is not intended to be used outside of this translation unit
     218 | __printf(1, 0) int vprintk_deferred(const char *fmt, va_list
args)
         |                ^
         |                static
   1 warning generated.


I believe this ought to be static:

+static inline __printf(1, 0) int vprintk_deferred(const char *fmt,
+						   va_list args)
+{
+	return 0;
+}

Cheers,
Gabriele

[1] -
https://download.01.org/0day-ci/archive/20250709/202507092300.Isx1ydMp-lkp@=
intel.com/

> =C2=A0static inline __printf(1, 2) __cold
> =C2=A0int _printk(const char *s, ...)
> =C2=A0{
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309d..bbed41ad29cf 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -72,7 +72,6 @@ int vprintk_store(int facility, int level,
> =C2=A0		=C2=A0 const char *fmt, va_list args);
> =C2=A0
> =C2=A0__printf(1, 0) int vprintk_default(const char *fmt, va_list args);
> -__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
> =C2=A0
> =C2=A0void __printk_safe_enter(void);
> =C2=A0void __printk_safe_exit(void);


