Return-Path: <linux-kernel+bounces-742104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169FB0ED3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933123A9C07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BB26A0D5;
	Wed, 23 Jul 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxlUda9r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18982701CE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259435; cv=none; b=pgOmbxVSjQv8uXQluqBHL250YYzF0yblefagq7xr+jIlEeU1iB+4vnrTkPob6m7OrQf5d9MXzeP4XKt/zwVdvwP6U73lp/m+RqD8a6bFaDeuA6CaL9VtNUdcvEYKj7py2FGmsbGy48cvfAE/wpr4IN7QQjqE2EmdB9hTmLOrx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259435; c=relaxed/simple;
	bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/lH9UnIS73KuJ3JrZpaU8IfC41PlwDSegmnLzEnQpHmRTzbvp2tPPzFr7MY1CCqr6yK9UpW/YaDE3Jq/A2RQad96iFTgGYvzwebKoZ8mrWv2L+WYhgtFnwKwgMKdyEu1dQtROX1BdE8s8OG2AJXKyhzg0zttp4vHYWfICEQNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxlUda9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753259432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
	b=CxlUda9rOXHZWAYdMHrhpKKhzCcY2NPqbOVu7EAasH08hRlVtNmz78DgepGLOoSQYzftb9
	efd36w9Sf9qt5jG6OYmto/sqUviK62Osxh0ae/poOSSb6UG4GZpK77IQFuIZFchl1dSHNF
	+ytxThgvyc92YExBlEOfZvScOyhtDIM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-QbMac7-GNuKDjYZVcF7KFw-1; Wed, 23 Jul 2025 04:30:30 -0400
X-MC-Unique: QbMac7-GNuKDjYZVcF7KFw-1
X-Mimecast-MFC-AGG-ID: QbMac7-GNuKDjYZVcF7KFw_1753259429
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aef68ca533aso257128766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259429; x=1753864229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4W6SPsUh4DcT7b0s9/kXJTZM49hFaqVvpxsrmcAGv8=;
        b=JDLCXXXxFZhwQs+HIqZRfBsZbhz7eLL6VhM25kvWqjr4hc6RvN0UxV3tDgrdGoec06
         6x6089uv1VnA6u2XitP9pln4Z0Y5GajNRONj5aqD+M40XYygK3ehIVC//gaWgnVdo55R
         6js47KmmEXrWg8kHGppYH21IKXCvYN4D49cCQrpl6wK//Zs/f+G4xCQhNJuw7aoEbzbZ
         LNvQtbX3cDTP4OyW5GuR88oXvO+lyvL3UzEdR0MgmXARV5njDXrM/uR8ZClmqLLozLPg
         RImW9Ge8dXMv8vJzeeLLoC4JBYc2W5eKTuou+wxo6VwSoM0toMG1ylJK5CYCCmoVXmIf
         +F2w==
X-Forwarded-Encrypted: i=1; AJvYcCX6dm3elGVVd20/Lwvw43JBT1Oo1VritprCc0DWgQj6Q0VRVsIpVSP1aVlAjsZrhH0t2IXT7uB2h3/nCOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypua7f1GPsad4pewkGcbwhqlhxwnApy8fes7CqU1NrlTVjkuxs
	bKYRBtH2Fjcwf3NX7kpzsGkhIksfTFe1uW6fj5UJujz1JNj63j+MAYrq5PWPSazH96ea4x/LD0p
	tTTBXUAQ/r87bKq732lneKzGIGZUwQerK9M1V4aECsZ7kE/gp+zjicFf7dy1dI22gTpwYYb+6PJ
	a5h/lDcdX/VFkXaEjWDjrnLOD+CGwR8fz7kDy15BhB
X-Gm-Gg: ASbGnctyOnYjLHkNOQdIEso2sWagZuEd5upVeHBXOrYwvicEcf5l8ewwro9IMIuUgHI
	qWpx337l7mr7Lb3mku2wHbU5iNI/FmZKPPD05oI+lfyV5rgLL1gighNI/KkL8ElYRUL6YqGGY4n
	/Xd/G85nBhf4Siya9LMbE97a5wtRUE7+eQR49HBTUascs6ldBKSXo=
X-Received: by 2002:a17:906:ef06:b0:ae9:928d:f285 with SMTP id a640c23a62f3a-af2f9271a76mr224162266b.55.1753259429012;
        Wed, 23 Jul 2025 01:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUCquKYM95lpkzero+gW1DdskdXIxo41fmMVrdQBzGb5qc4sMw0+zowOnuFoncN8TnYaRK99BiJIikjg//U7c=
X-Received: by 2002:a17:906:ef06:b0:ae9:928d:f285 with SMTP id
 a640c23a62f3a-af2f9271a76mr224158666b.55.1753259428491; Wed, 23 Jul 2025
 01:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626123405.1496931-1-tglozar@redhat.com> <20250626123405.1496931-10-tglozar@redhat.com>
 <20250721183606.0489b1cd@gandalf.local.home> <CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
 <20250722112926.17ea1c65@batman.local.home>
In-Reply-To: <20250722112926.17ea1c65@batman.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 23 Jul 2025 10:30:15 +0200
X-Gm-Features: Ac12FXw8iPQlEJ-1WcTi2Z6NqstzZt9bHeBzd7CgP_VNoJSCQXpxfgXMkZKZ1ss
Message-ID: <CAP4=nvTSycYMGmbJ7nd1Bkp9Rrjn1ojH7VvRo1GCKO5FKm8GZQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 22. 7. 2025 v 17:30 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Tue, 22 Jul 2025 09:03:24 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > Of course, this is just an implementational limitation of the timerlat
> > tracer. If timerlat had an event (like osnoise's "sample_threshold")
> > triggered on threshold overflow and if it is possible to wait on it
> > even without BPF, rtla could wait on that for both BPF and non-BPF
> > mode instead of what it is currently doing.
>
> Right. Is this something you may want?
>

I don't think it is that important. Non-BPF mode is mostly as a
fallback for users of rtla on older kernels which don't have the
osnoise:timerlat_sample trace event. Those are (I assume) mostly users
of LTS distributions who run newer rtla from a container. Adding a new
event wouldn't help in their case.

The only users who would benefit from that are those who don't have
BPF or libbpf. If there is interest from using low-latency actions on
threshold in such settings, I'm not against implementing a threshold
overflow tracepoint and supporting it in rtla for triggering actions
on threshold.

Tomas


