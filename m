Return-Path: <linux-kernel+bounces-831196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA44B9BD33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40647B64FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D60322C9F;
	Wed, 24 Sep 2025 20:15:27 +0000 (UTC)
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E43322DB3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744927; cv=pass; b=N+4i4W5zkwIrWF9t+jbv479JbNjH2z3wo9p/2CjXn4m1sKwe229cI0KOscsyPIAjsBGBbzUOyHAzXn3Mr795OQPgnKASK5r4BYjrqZqUCzkOsXFJZJ7+KeRt3ThoRscgLXADAzL/RwZpMXedqu5on3yq5jczsvkmqOL53w/N/Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744927; c=relaxed/simple;
	bh=T673ykrFqtlACcdavGcdmbULKH6UMXsgZABpuBN2Mvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci8XkoqE9/vGUZlqk43yS2VZQ5yDpovOP487UQM4a+MO/QNaKIGEOpxEotZp6DsnJALrxcfeU/Qzwd13seC6d/5f8JmoGUV4AOnOCE6Z6WzC6/drLwbKJBHVHfHMvqojwhyG1m1eYK4A/qStyvzBdeypMCl0xD42W2yI3mfr+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net; spf=pass smtp.mailfrom=euphon.net; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=euphon.net
ARC-Seal: i=1; a=rsa-sha256; t=1758744872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ll96S+VDavC9To1qvEFjJGXDCrG6yT5LD8ZUPrsPNMvVnRtT9h7xg29xNUuC1Oy0Lfj2CFyM0n8OqifpADBrR86exqrGJMaHy+qxVCDEaZRB4mKf0J1takf2enxqWVV0jTeB8rFKATLqHBdb/gpDnKapIbpxFK7KCYiI4+VYw14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758744872; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id; 
	bh=T673ykrFqtlACcdavGcdmbULKH6UMXsgZABpuBN2Mvg=; 
	b=SIBsd3yScUM1NnS/dDZzFeueef43ac4L7Pzr7taUR/1tOVuDgdX5D6mj309lMGyEdRYGt6tuGGlmGRzSD6g0aDvvBrC+mtgcDiAIdTmelW10X6fSuxuG6eaNuqrctscEnsvpDdWpZsZsa87xLISzEUawtfUCYe3LQJuM13WKdzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	spf=pass  smtp.mailfrom=fam@euphon.net;
	dmarc=pass header.from=<fam@euphon.net>
Received: by mx.zohomail.com with SMTPS id 1758744869572126.64084575014147;
	Wed, 24 Sep 2025 13:14:29 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-425635acc4dso2031165ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJCu2n8OgJ4mH43JOKR8jVBeF9wrc7avVK57nVZWBdWJNKvca/8/RylMKuhQFfH+TAzTkHBTCxfxQPFis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGF1l+41rkFd/tFEZbB3DpS1egWva+IQWK4tc0+5YS0P1jJQJ4
	8+w8dp+n1PlckwsBOxrz5da2JVPKRUOdUStdv6BZJWuEJ1WqHELVGNmnHEy3oC5i9QhXaHaWuJI
	Az3UUJ5DeH1AYkbYJOOqumgR/8OdKWoc=
X-Google-Smtp-Source: AGHT+IGwHd7d456a9ObtyVhxI7FejIciTmuJiBEpGQjq4YyQsi/0fJ44ZxfgkvgUYnUi+SZBGdYY9ynxMMzTrX70vN8=
X-Received: by 2002:a05:6e02:491c:b0:424:a3e:d79 with SMTP id
 e9e14a558f8ab-4259562f4c4mr15800365ab.21.1758744869089; Wed, 24 Sep 2025
 13:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <CAG+v+KZ4bRgVNiMDhNTeiOqqbEXCBD72K5SQZCo=m0xaQ2vauQ@mail.gmail.com>
 <5490118a-7185-44fe-b816-b01c8ff75979@intel.com> <CABgc4wRgpYNARf+7MhsadfXjDJ0Vd01OoqnVdrW3m6dXMzQSaQ@mail.gmail.com>
In-Reply-To: <CABgc4wRgpYNARf+7MhsadfXjDJ0Vd01OoqnVdrW3m6dXMzQSaQ@mail.gmail.com>
Reply-To: fam@euphon.net
From: Fam Zheng <fam@euphon.net>
Date: Wed, 24 Sep 2025 21:13:53 +0100
X-Gmail-Original-Message-ID: <CABgc4wSRMW1UdtqGDEfnD4UTuLGqi3nVHZsJB_hUouAhLvidyQ@mail.gmail.com>
X-Gm-Features: AS18NWDCDybEd16y0n2a9f0a9iPoDTGd0DoIeZlkTqjZQEcTK9sxEtkJQkucQeo
Message-ID: <CABgc4wSRMW1UdtqGDEfnD4UTuLGqi3nVHZsJB_hUouAhLvidyQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fam Zheng <fam.zheng@bytedance.com>, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, liangma@bytedance.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Wed, Sep 24, 2025 at 9:05=E2=80=AFPM Fam Zheng <fam@euphon.net> wrote:
>
>
>
> On Wed, Sep 24, 2025 at 7:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>>
>> On 9/24/25 09:21, Fam Zheng wrote:
>> ...
>> > The model and motivation here is not to split the domain and give
>> > different shares to different sysadmins, it's intended for one kernel
>> > to partition itself. I agree we shouldn't have different kernels here:
>> > one old, one new, one Linux, one Windows... All partitions should run
>> > a verified parker-aware kernel. Actually, it may be a good idea to
>> > force the same buildid in kexec between the boot kernel and secondary
>> > ones.
>> Uhhh.... From the cover letter:
>>
>> > Another possible use case is for different kernel instances to have
>> > different performance tunings, CONFIG_ options, FDO/PGO according to
>> > the workload.
>>
>> Wouldn't the buildid change with CONIFG_ options and FDO/PGO?
>>
>
>
Discussing goals and non-goals is what we were looking for for this
RFC, and these were just stretchy ideas that we can decide not to go
for.

Thanks for looking at this!

Forgot to turn off email html mode in my previous message..


(outside working hours now so replying from personal email)
Thanks,
Fam

