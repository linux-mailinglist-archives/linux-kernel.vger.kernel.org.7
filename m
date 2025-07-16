Return-Path: <linux-kernel+bounces-733498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16DB07578
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E43ACF26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9B2F431F;
	Wed, 16 Jul 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMZ5Wxv4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0CD23ABB0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668465; cv=none; b=dDjY1mWk4b0SmHhwUZPo246j+4xPLInxVX30+0/xMPmY+U2C3lJzbhNDBLSC40d4b7tB5rUMNpSz4rZgo+hBFKc8ydb7HzkUSxw7wakf6hmJs3bEu/sUCIChYAplaufL/AbA48B1iE94PCdO0YOrHEhFJ+/LA1jVCwB4wsFEnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668465; c=relaxed/simple;
	bh=bFoTQzwQnUjW00bYnVId+h23Z3NJbt6Ftu4tGgP/etg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fW516svbgJWTZLMWvFCGL9DdL6QmiqNcTY4DP4hVInISrHCAMbc8C+yOjUptmTfEYf1PtvDWN03jIUhnvHp9qlPWmXUqXPuk8+/JqoUIzN5rLMhqcfr37iB5UNdJN8cae8bwlTSUmLXKSgttWBPUgh9BfWcKEHJG/vViQaFN/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMZ5Wxv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752668460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bFoTQzwQnUjW00bYnVId+h23Z3NJbt6Ftu4tGgP/etg=;
	b=dMZ5Wxv4Qm+LJ0obnPTYZpvvHvHUdkwO711zscbNdhXSDEd0P9vOjCGo4tNHB+n77dDcWH
	HTlm06yM0JCbR/LCYQWMfNaCl04C9+irJ9WD1WRgI2JAfnpRmHIov40FfO/mdeUiDeL/gr
	awZYtGDSr4H2q4B+WQv3XADWA4Cm/W4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-cBCm50uFMj-6dD60XaM8ig-1; Wed, 16 Jul 2025 08:20:57 -0400
X-MC-Unique: cBCm50uFMj-6dD60XaM8ig-1
X-Mimecast-MFC-AGG-ID: cBCm50uFMj-6dD60XaM8ig_1752668456
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456175dba68so26446265e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668456; x=1753273256;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFoTQzwQnUjW00bYnVId+h23Z3NJbt6Ftu4tGgP/etg=;
        b=wvVOyRT6GYU9f9IO4AOaQAw7cFKlV2s8nr+/gWRK+ENZv6Jzzd5rC4HeYnqwoBPJXi
         p85jXS9K2tg19f8wcaxnrFgycjxRAA8wA5QzIfU+0q02FDiwCy0uMLQ+M5q4D/XBBjEO
         v5Qcu1eIadi9HFiaAWvqIZo8d3mPvdKH4IBNDmazFNmmOsvk+CJo/AelNDB9d5PSLJJZ
         emDwRiKC0iSyxjcjhG4v+fIo+9TYJrMBq5pbmoHhLfYMcNewnr3dJg5nmlqOK4eLagdf
         Fm0vuibQfxEcGsUzSPLIW9/BlM+LjK/WA8oUJ8n44K1abfbkb6mSypdh60hdCZvW62Pa
         o66A==
X-Gm-Message-State: AOJu0Yytzk6F8VCG8J/or3Pb3vkepaNqUufHRKSqaa/gssucVKRTAZkw
	udr2DZ2hncHJrT8MAaNIPTUHGP5wHf71824SaeSwz1z1DLt7+hGhoFUGK9AGlgl1Zy7Sl+C9qR6
	4Pu7v3dv9JuKyKP3ScVQpSpOHuS2qihaPF/xjgIu4nxcIJHc8CmDvHDlcSDYk/PpvIXe9OD/GJQ
	t4
X-Gm-Gg: ASbGncujxZdqpQQQP6O/Qn5oXHNM37TDnGBbW7UQcvC4FwFbYVzkKd51QNWy6XpbAqW
	STkiC348zpO97yXTl0lsU3q/cSHM7lNfIthLFdMkE5P1BqmLoGQgluCORobQ7PfwlJGyWXa7Soj
	kAUkr/QKRDfOHe5ZEh0ImLbrT5g+gFE3GjtMqn2tOUAWhbvN99n1yiJtsLhve4skUhOH9jPcf84
	q2jXq1N1ya5SD3/erZ/3dHRAFqWsvFK/O0VYbyuMxh6ZTFHuwmtQ92bX2b5Htm2FoUKCO3zFsiW
	ycvM/q+OvK2Ct8YnNJV7O7MHxFthaNLL02O6a8nFSHql5H4rQle+tCljoaTXOXiWSA==
X-Received: by 2002:a05:600c:1d20:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-4562e36c7a6mr29775565e9.17.1752668455791;
        Wed, 16 Jul 2025 05:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu53t/x66hzQPBgP81KXl1tQoB8G6GO0gUFNKjmd215ZLGy8coiMJno5NGq9SYUvNKI/xVgw==
X-Received: by 2002:a05:600c:1d20:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-4562e36c7a6mr29775245e9.17.1752668455376;
        Wed, 16 Jul 2025 05:20:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e836f84sm19898755e9.32.2025.07.16.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:20:55 -0700 (PDT)
Message-ID: <51c78495cef7f2f3c47862a5bc335fe91b49e1c9.camel@redhat.com>
Subject: Re: [PATCH v3 00/17] rv: Add monitors to validate task switch
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>,  John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 14:20:53 +0200
In-Reply-To: <20250716094255.G8jDFxdw@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250716094255.G8jDFxdw@linutronix.de>
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



On Wed, 2025-07-16 at 11:42 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:17AM +0200, Gabriele Monaco wrote:
> > This series adds three monitors to the sched collection, extends
> > and
> > replaces previously existing monitors:
>=20
> I looked at the patches that I understand. For the others, I lack the
> background knowledge to review them, sorry.
>=20
> I gave the series a test run, and beside the opid's errors,
> everything else
> looks fine.
>=20
> Looking forward to v4.
>=20

Thanks for the testing and review, was very helpful!

Cheers,
Gabriele


