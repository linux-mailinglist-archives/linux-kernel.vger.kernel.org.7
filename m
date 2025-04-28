Return-Path: <linux-kernel+bounces-622904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB930A9EE42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2D3AA828
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10CE224244;
	Mon, 28 Apr 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAtqmGmO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852D201035
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837158; cv=none; b=VgdGRXL9DQCXAM5UJ9Doi3Cr+XbUvVUvfSHu/w0lvCQ516r+PCmMbTUnJ5xJfz0Co7DZuLsEmrhaIql/so2fAl5ru7edSQle2fFQ7KBw8QWT5OPAZY6His/kKFylxCN3OfpszBdCEmQDHylGUO2TwLf4JXhOSILTtKElvxzEk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837158; c=relaxed/simple;
	bh=BfVpXOtVnMCA2Chp0FBzrJVBMyu2X/fGknG6KW71f5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6DK3xjOg2heT2Nl7KzIP/G8+mb6Ru48TBeKNKXdmURuqZpGngcMDidrYxu9C3HT8lwtsBrfacWmS6l3u458t7eRwz5XIBrp9RCp/1giZtS2d66A1XASR1SWldFpj+Hs73Of8ImuaUImHiNNj4rLkQ4o1admi1o0GAgxjmCWhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAtqmGmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745837155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMYe0308IK+Yd7YE4lCtC/FPVv4+EuXG93+Si0fR0Go=;
	b=JAtqmGmOYE0UtDpXQrUntlmE7htvrkn2ojdBmxHqHPIRM3Q7OSCbD0BBUeHmjVAmLL9TEm
	7piSdDzXBb1bTpKuCK6tbsAiKALAnKAesnyXqf/e78JU0J9m9g4cTH/tMIhY2vI8gotm1+
	DYlrH/I9NY3XQzycK/9/BkGhhCZ5GwI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-vspgBI7nPL2zWe5FISe--w-1; Mon, 28 Apr 2025 06:45:54 -0400
X-MC-Unique: vspgBI7nPL2zWe5FISe--w-1
X-Mimecast-MFC-AGG-ID: vspgBI7nPL2zWe5FISe--w_1745837153
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso336215966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 03:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837153; x=1746441953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMYe0308IK+Yd7YE4lCtC/FPVv4+EuXG93+Si0fR0Go=;
        b=rgCdC8HTzC9CuYdfxTWCsBeRbEQGua598l3C/fU2TjZMtHIGNLhgF4YCE52nTgHKMM
         W+WtSIGdVOSyUPlLegKtypOQp8GqzPWAE/+6g0OWHYAUCEplU+e9beGrsTGEByy90A/o
         gEsj0OyS+EwlFPaUSwtDsGUDjYnx9i6wox+mJ4f9HnZzDI9Na8QVnwGsPixct+ESnCFy
         bhiKkicA2j/vZ0RjQH2W/YEwp35nZ6RPMQdgpV5YvbbVYExMCJqnuS8wrxHqVOLvAvJ+
         QKYFtILyXtu6YN+g/v1aOZKPP2/+9Nm2f8lLwnDVaBRy8sx6/CRswzldpSybJqJgNytE
         Cp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6BLk0pWHoGqdViRw2TgDyu0eSwvnxDpVPtSppIOj/3IKlEbd0DoTzWdzjXIvJbaXQFmedmB7eXKVeTNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWpVBoeu8bZF6o9iWPzgRIbFI7S/e5qdYeCQEBBB2PcgfMEy8
	5qkOvloK/AM8po08RdzjvJjmIc8G078w7pV8776KmCXClqgTwlsQrpTRwroWJIDM2JTUzuFyd8A
	2mqlXAe85wmM+dIQ3ZqA9RXJrxOBfvR3jwIUr5YhS6Y3msmb3IsVDuL+sOOnP+oy63ozBEuCHOa
	aDNnXV7z+zDeZ1xtHhPHRzhB+wK8Ncslq0Y8Q4
X-Gm-Gg: ASbGnctWHO3H5ynrejU2D/DpazJSYSVsKGn824qZn9aMavT7KIRXaoK6i+Ybhrr3sD/
	+w+qGTZ57GLHDrmwFJSzGA6ThjiY3d5NkbTTo0x9aywrcBt14ls26+ErSBiYYqVtMMqzwV0Vswx
	ioqqYxpd5jHabpMUaVi/l38Mc=
X-Received: by 2002:a17:906:8f8a:b0:aca:cda9:3170 with SMTP id a640c23a62f3a-ace7136c8f9mr986991466b.46.1745837152848;
        Mon, 28 Apr 2025 03:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6CEEM3fpiFA011WKHygpJfI3qalmbUpfmLQ7ejG9VQsEf2vkIAuhZX4wTtg8RGsfQV/bqCOwSsENmQ/n/X8U=
X-Received: by 2002:a17:906:8f8a:b0:aca:cda9:3170 with SMTP id
 a640c23a62f3a-ace7136c8f9mr986989266b.46.1745837152471; Mon, 28 Apr 2025
 03:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
 <20250428101234.GB551819@e132581.arm.com>
In-Reply-To: <20250428101234.GB551819@e132581.arm.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 28 Apr 2025 12:45:41 +0200
X-Gm-Features: ATxdqUE6obWzOYhFcES93UpT9dGSANioAhesV3WAj6nlEAJMjJZ5qYwh3vl3kp0
Message-ID: <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt event
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Wander Costa <wcosta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 28. 4. 2025 v 12:22 odes=C3=ADlatel Leo Yan <leo.yan@arm.com> napsal:
>
> Hi Tomas,
>

Hi Leo,

> I would like to suggest a fix blow.  For overwrite mode, we need a
> fixup to remap the user page with write permission.
>
> Could you confirm if works at you side?
>

Thank you for looking at this. The initial segfault on writing to
read-only page is fixed, however, perf now segfaults in a different
place:

(gdb) r
Starting program: /home/tglozar/dev/linux/tools/perf/perf record
--overwrite -a -e intel_pt/cyc,noretcomp/k sleep 5
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 424037]
[New Thread 0x7ffff2df46c0 (LWP 424038)]
[ perf record: Woken up 1 times to write data ]
Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
intel_pt_info_fill (itr=3D0x7a1e40, session=3D0x794ef0,
auxtrace_info=3D0x7cdfd0, priv_size=3D144) at arch/x86/util/intel-pt.c:361
361             pc =3D session->evlist->mmap[0].core.base;
(gdb) bt
#0  intel_pt_info_fill (itr=3D0x7a1e40, session=3D0x794ef0,
auxtrace_info=3D0x7cdfd0, priv_size=3D144) at arch/x86/util/intel-pt.c:361
#1  0x000000000061ce76 in auxtrace_record__info_fill (itr=3D0x7a1e40,
session=3D0x794ef0, auxtrace_info=3D0x7cdfd0, priv_size=3D144)
   at util/auxtrace.c:580
#2  0x000000000061ec48 in perf_event__synthesize_auxtrace_info
(itr=3D0x7a1e40, tool=3D0x765de0 <record>, session=3D0x794ef0,
   process=3D0x41a747 <process_synthesized_event>) at util/auxtrace.c:1320
#3  0x000000000041e869 in record__synthesize (rec=3D0x765de0 <record>,
tail=3Dtrue) at builtin-record.c:2062
#4  0x0000000000420d04 in __cmd_record (rec=3D0x765de0 <record>, argc=3D2,
argv=3D0x7fffffffe0e0) at builtin-record.c:2841
#5  0x0000000000424025 in cmd_record (argc=3D2, argv=3D0x7fffffffe0e0) at
builtin-record.c:4285
#6  0x0000000000461143 in run_builtin (p=3D0x76a260 <commands+288>,
argc=3D7, argv=3D0x7fffffffe0e0) at perf.c:351
#7  0x00000000004613b2 in handle_internal_command (argc=3D7,
argv=3D0x7fffffffe0e0) at perf.c:404
#8  0x0000000000461501 in run_argv (argcp=3D0x7fffffffdecc,
argv=3D0x7fffffffdec0) at perf.c:448
#9  0x00000000004617e7 in main (argc=3D7, argv=3D0x7fffffffe0e0) at perf.c:=
556
(gdb) p session->evlist->mmap
$2 =3D (struct mmap *) 0x0

This appears to be a different bug.

Tomas


