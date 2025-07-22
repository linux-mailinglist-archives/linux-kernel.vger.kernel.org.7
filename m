Return-Path: <linux-kernel+bounces-740286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECDB0D24A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A63BE055
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE928A407;
	Tue, 22 Jul 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af9HBqiN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E41DB122
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167822; cv=none; b=n6cALbwfZaBIApQKmgh51IsS3qNs8a4qOagUja7hmQwrnd/r6MaKWLNADLxxINmGSKTYAv4JHAiNhL3PuWOrAVgN52YwiyblwqA9/GLQpkum1hNbjb7V8ax3PFgZcVU6Cd+ce8SUm8PWydRDKGs2ZE23TgkE9I07L+ThgRm+fa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167822; c=relaxed/simple;
	bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5zQIbuzXjukf2RIU8obMAb3TE/+pZh93bhA03zZjFayyNa1JZNLcN/9Yn6QB83Brnx5aeBirG/ZHgxR5nnwsiVbEo2hpGpbLS9R14Z2YOn3Rp4TdTVEsCId7oeyAB295j4PRqrxDC39AAZdFZkEAwkTzjADR/J/9I1nvJ65iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af9HBqiN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753167819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
	b=Af9HBqiN7Gb29VlD8LpiwphXIZ91zAHX05f7cPANINO3cCc+TifQ0ezWCrPhij1q+ajAcJ
	IVL4Q4B/sDaUdOV1LfPVcb0OIvdACjvOYqTYleHoh4QY9Mu1RhX8GwhyutukPLfXcU+vKQ
	grsuWhwRtDM5dAk493pHjq5dtNp++M4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-59vKCXo2NwyFYmy_lZCRSw-1; Tue, 22 Jul 2025 03:03:38 -0400
X-MC-Unique: 59vKCXo2NwyFYmy_lZCRSw-1
X-Mimecast-MFC-AGG-ID: 59vKCXo2NwyFYmy_lZCRSw_1753167817
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0d76b4f84so451357666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167816; x=1753772616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94YH95Kqg56L0NGAhzRVzTprjMBr1gaZFjXLE1bEm7Y=;
        b=GpFz6tYr5baikY7Hg6BbZv6hXPdV++tAl2XdlqvriILzr2Z7YNmyfdw2YANvfpxabG
         hCgxGWbYK7nn5lMnGYsIlloToncrfRaY98lmiuLByu8o3IJKXd1CoD34OvUVDxf0/5tP
         1o/UPuH4KY0CxPKWw9Tajk9z/M04tZrQOcrUelWl+fB4/GDzENonJYLBZM1zVzGtFww4
         Bp9l/FFA2nwSJa1CZQgqGZwE2/lqf9hZ5IuTgaZqDgryjaVVG+IRfdxFKIv/Otkj8MIq
         P6ASazuYTcY/IA5as8OrbxCFKWKI+JTxuGWVgHpnuVK9Aj0NkN3vsAwXTGBJjeQ5/Jca
         pvOw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbwwOXBukMPed2jKn7n6d/BhE13RUVWxW5+3YJ5Ta8/vfmYup/mhnOpR2Lc6IwE7D71pZnvBIlZWUSP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGIn7I32JtrEBM8dyCPLOrxi1OOgd9l86WDshaNrSr+j02rJY
	v4HjJIWEvbw2hlYgcIKtIe8yfPzTWD1YjHEoyK6gMD7b5N/r4+OfOjAky6wLMt4F/t9TGWnMM74
	18PreGed+F55TDuAhApWv+RJf/9aZWkn0MXewJDuBuaxAimUMg79Us/DViOtmUCnft6/wJaipyP
	BdqSfHUN/2sKwWOWyDZRvKTSePgYwtulZ4CdiiZR7YBdNqs/UY
X-Gm-Gg: ASbGnctVltZIX007l51Iw0trjhsAJzMzK4mRTy3vCU15zO/1l5wqmGjJjVgrCVmIwro
	M4v7aVW0rEEmllDVCQxOOYnkgGYm/43wX9ezeABLrUc9Qsl94Qcc0ruWqXN2TRhYUT9dMti52oc
	8FJar5QrjVnjDB0wPeTcM=
X-Received: by 2002:a17:907:724c:b0:ae3:6744:3677 with SMTP id a640c23a62f3a-aec6a5fa9f8mr1431815266b.32.1753167816587;
        Tue, 22 Jul 2025 00:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUS1C4M+sqJMBlVVOE3zFSmnosEzS/DCoJtMWBdNIwIY9r/Y+OIaF5oI+nbiWF7pf7JaO7/YLTOiG/Al9Kfl0=
X-Received: by 2002:a17:907:724c:b0:ae3:6744:3677 with SMTP id
 a640c23a62f3a-aec6a5fa9f8mr1431810666b.32.1753167816060; Tue, 22 Jul 2025
 00:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626123405.1496931-1-tglozar@redhat.com> <20250626123405.1496931-10-tglozar@redhat.com>
 <20250721183606.0489b1cd@gandalf.local.home>
In-Reply-To: <20250721183606.0489b1cd@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Jul 2025 09:03:24 +0200
X-Gm-Features: Ac12FXwIQm1h_qa8RXimPv2lpTVEqVoAuExH-2hEnAe5PwJDJ8uOLrUDIYGzoxI
Message-ID: <CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 7. 2025 v 0:35 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> I'm curious to what is looked for for triggering an action. We can poll o=
n
> events and get woken when they are triggered. It may be possible to add
> even more ways to wake a task waiting for something to happen.
>

Threshold actions are triggered immediately after a sample over the
set threshold is detected by rtla. For BPF mode, this happens almost
right after the sample is processed in the BPF program and the
scheduler gets to waking up rtla following a BPF ringbuffer write.
There is only a short delay (up to tens of microseconds) because the
BPF helper defers the wake-up into irq_work.

For non-BPF mode, rtla periodically pulls samples from tracefs, when
it does that, it also checks whether tracing has been turned off. If
yes, that means there was a threshold overflow, and actions are
triggered. Since the period for that is currently set to 1 second, the
action might be delayed up to one second from the threshold occurring,
That delay might be a problem if you need to collect a lot of data
from a ringbuffer in the action, e.g. global Intel PT data collection
for precise troubleshooting of difficult latencies.

Of course, this is just an implementational limitation of the timerlat
tracer. If timerlat had an event (like osnoise's "sample_threshold")
triggered on threshold overflow and if it is possible to wait on it
even without BPF, rtla could wait on that for both BPF and non-BPF
mode instead of what it is currently doing.

Tomas


