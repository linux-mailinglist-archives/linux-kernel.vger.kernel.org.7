Return-Path: <linux-kernel+bounces-759770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E463FB1E234
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA9F18C7347
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C42222C0;
	Fri,  8 Aug 2025 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq3Gh4pr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25681F1921
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634071; cv=none; b=MQ507s0SHaiYEcNwQ5MyFKeGDGI0jsZU6YWDapArpfyDEmI6JmUgScyV/PoxG7up2h7iXO/lIo+zae4Hczto2Dxywiuz/G7owi2duE4iEt1dJtUDw7QtLfcVzNpOF8x99Ee4O6Yh4lGRg0vEytRUnLcJ0ZNNLaUc6FYVfbjjUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634071; c=relaxed/simple;
	bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVDiVhE1ANzU5rWjx+0eRX/wywPFtOrcXhlZK1fb6i7MvuSzGBWSGvji+Ux9n9qmfxCX5tHeJpWJESxkWbO1FLyj9anKK3re8U03tCfcI+JbTTAxuRVXHdwYdBkIeN7KNsQIxqZhdVqoRjGnI95KmjiGNLYW+99/vrcLv+OEKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq3Gh4pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754634067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
	b=Vq3Gh4proZxmKaeFnrB/6VStIadGNPiOeRMnXS/Z+qpwZQt4qSgPpjk05An/thmkc3/Qdr
	TKNlgOFjLn4kkpLQ2MEn1IdGLoOtL2dWupO7FAWOMHtI+FldAiisk5cGAxNg5KClQfPHBF
	L/KhQihZ0Z1QEIANlBmBWJSPM6TdWHQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-E48A_oMrP8KhKSyt7skuxw-1; Fri, 08 Aug 2025 02:21:06 -0400
X-MC-Unique: E48A_oMrP8KhKSyt7skuxw-1
X-Mimecast-MFC-AGG-ID: E48A_oMrP8KhKSyt7skuxw_1754634066
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b065932d0bso50474771cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754634066; x=1755238866;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hp4Cjmcoe79izr5L+9qpIMr5y6CLxIzjk1zpH1QlIM=;
        b=uqROlW5E9Max8LS+4aIN8tEkz7LQWd+bwPnEHHXNoqKhN9O/3l+wLjLyj1CDtRFMwq
         fBhHUgQPnPlqfxHPvAtF75xtESQtxgRMK+YN5Z2F2A0H/9lJkaooTSED8CnS5H/CMQYD
         DK4dbFt//X6F0RsKR8l5G7sqnDVd3SFuCHuG1d2jIsEv0s2C69mq3odNnHZnW8vYRzIA
         qUc6WQm8lILsyHhM6k/IHhY+6IiH6UW1cLtwd2J5/0h6AZy8+8wb9ovfSxuMNaOitQ4K
         q3NZd7NS5IJvJZIhYFtJw8D1aAUQtdnFbhq+UaT8ZxXlgxo4hpA77M65DS8qXyevOGP0
         kAhg==
X-Forwarded-Encrypted: i=1; AJvYcCWVvlE/9zWDK7Uf5HBL9C6bEXRQ08KNplrHtqS2KSUDg3sr+WQp1cIt2kNx6WauN0JV5R0sB0qNxlt5GK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6ZHvfNpp3MSuMomGV+aaZNXtjf3RJ/iSDZpeB1EAbgzt9F+l
	cJjSs0PcecA+2EsK3VJeUoOTt4FzOBPrRMCw7DMjqOiUWEwr+eon8lSI1qA46jNw8Df1+HDTMOf
	bbfe3BT2mxJBlJ04t2WX6WHg6WHYY7Iu5UWm5TUlApAYuWvAkDpaDhRw1FneFEu9PZQ==
X-Gm-Gg: ASbGncth4oOVbIimfSR3TCHbfq/G71ngAdqyu+kyMl8yW+uXEBWO7q4bEGrJ5aJ4y1m
	vyzYaQ1jjaILsUxicmC0RdOZTEmozTbP2bply87V+PkEFyPTKFXZZjf9H94J8AaRixU2GDxFsbv
	Pq7mbKyz3914xZfI+aLBTILdtMpIu+QffeR/oeErvRICRSr2us/KlwO/nSyeF7AnA93b+P83/p5
	GvZBag7ZHwYhfIUC9Q8E7b5U5tOvXU0Cr+rU90XFlFo2JjhCc+ft4Z00oO4CjuLxrg+t5JaWBzR
	/GpU8lYm7u3GHFJRprjrCyJnJToFJMNjJXtvydzbBiVQiYHtHldvq56zYOjWb496vA==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr29222561cf.31.1754634065747;
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn23V/fOnbpdI0/TPKTgI2uF4FeN2SOw7oOfkOZP16j9bR+mqT2PCGlqrhSZ8tf/3teGaa9Q==
X-Received: by 2002:a05:622a:4c06:b0:4b0:9c0c:f62c with SMTP id d75a77b69052e-4b0aedd616emr29222381cf.31.1754634065413;
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b076710ff1sm53950591cf.52.2025.08.07.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:21:05 -0700 (PDT)
Message-ID: <0d29da11a78f8c4b67f3a590bc015ba1ff4bfcf4.camel@redhat.com>
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 08:21:02 +0200
In-Reply-To: <87o6sqpfbj.fsf@yellow.woof>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
	 <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
	 <87o6sqpfbj.fsf@yellow.woof>
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

On Fri, 2025-08-08 at 07:12 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > I get you're trying to be more type-agnostic, but I believe this
> > /online/ is a bit imprecise, unless you register a hotplug handler
> > and just initialise the online CPUs (much of an overkill I'd say).
> > What about something like "this is false if the monitor exists
> > already before the monitor is enabled"
>=20
> Sorry, after re-reading this one day later, I am still not sure why
> you says "online" is imprecise. Due to hotplug, CPUs can become
> online and offline.
>=20
> The current implementation ignore hotplug and initialize all possible
> CPUs as if they are all oneline. But if hotplug becomes important in
> the future, I may add a CPU hotplug handler.

Alright, I was probably a bit unclear with that, I don't mean the
implementation needs changes, only the wording.

> This is false if the monitor target is already online before the
> monitor is enabled.

becomes

> This is false if the CPU is already online before the monitor is
> enabled.

which is not always true, when starting the monitor, you initialise all
possible CPUs, also offline ones, which are still initialised with
@target_creation as false.

Mind I don't say you should change the value passed to ltl_target_init
nor change your logic, I only mean /online/ isn't the right word here.

Does this make more sense?

Thanks,
Gabriele


