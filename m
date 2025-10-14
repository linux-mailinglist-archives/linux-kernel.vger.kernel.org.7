Return-Path: <linux-kernel+bounces-852024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C84BD7F68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A65C4E2012
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8502D12E7;
	Tue, 14 Oct 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="afpyLNKt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126119CCF5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427454; cv=none; b=UTrCgPlONVeEz69WhpW9cBD5gZpgY0zpjtsIzsPX+2wlMeYAv0neJWFjzhR6Osj5iuxXQx5wQZqzD3xHGakT4oAlxYMbgF102eYbjz3TMNGP0nEXpbrxTHgf9MZE1pfbir54KbPIvnBYrmSzwvGhKBAjktsrcSj+ioR+1up4Xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427454; c=relaxed/simple;
	bh=r8DA+bEiq4YeNqzeiCGqhNVosWAVpIt4/EcRk/HaaUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh4EEUJRpVB/VIdgLxgvdJl0irNR/Ay8q4oq8GP0nXnCEOcY+ATaBoliJpUA9Ym0bz+ucfaNvhjG8KgRfWJZuFU+Mu6hurL65B7r+zXLuVC+0BH+U62UN6uuKJh/IilJYw2lILSEpV6jVgfWV8G36R8xsFcwG5ZOAzYlmWxLc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=afpyLNKt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579363a4602so5926067e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760427450; x=1761032250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6sm8UVcZLRMA4oI+f1r4FSpf8cY6fiaDo/3CXat7ck=;
        b=afpyLNKtDDBQlEoyXQ0Y9oi7NDAorraShC6YS7U30luB+QpVYsSIEIKGzZkHd1eRNa
         sufLwcj01W9DWwDJawl+eo/Z7vCPO13qR/Aw1A4hkPk6sgxknK9G+HXo+3PGF+jQrLcV
         PKwIEb+tKnnAoc6qGaQkfGt1/ZGeVVOHnB0fEGXsE/c6vvS3h9MGqA5leLEK+0gyNDZh
         H7QOgHOBXNBV7p+qXvW7TuG/vsFMeCjjHLak9iRXmYf9NzfK+mjKZc63egi9XqRg4+gd
         KiG2gD7p46D/8XyJgHaxlyOJvpY7hR0RWiHFzbwiVEbFYZBOLD1WAF/sZYhsTjTXJZ5E
         H39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427450; x=1761032250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6sm8UVcZLRMA4oI+f1r4FSpf8cY6fiaDo/3CXat7ck=;
        b=WlqFP17RHGfra5g8DNHwOrOT+Ly3kmlFauc0bYyUfV3vl8kyjSgdciqvyrMaBgipTt
         sHnRangKtUXywATwZ1VF2h0HciqQpxoCDjPj6ObXA1tNlufS9JfKd+wheV+gxjDhJqG6
         ifWWMZO7XjTwSpymEcjAnNfgHWZMKzCJ0V8SNZ+UazXYweB0dQ62753hiDddk5djMU0k
         LZ/jNc7fQvQOejtn/5BHNAcohfLl0Y/G0NlrSwI55LJncsQQ51pj3F5DoLFnjsfW+aSA
         YEvK5qzZ/RBBpecdqVi6ZODogaKA/pFEqw9YDjMFq3rKJM7w/KK5tHNVwHLsdOr9Ybdx
         CIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPkuYw2tlRDet+VfiFGbP4DEBxRiuggToX/frNVJ8Z0a10cz6VJ1BwCwwouj66Jia1TE/VpMF35vPWfsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz780OsAVwhr3C5hrIBn/GvlzVo7Uhvp579SoS3mPaE82K002UN
	etdY1t8WyPTmKk30fYQEQMzF6ayWzPyjAIbIIXKnicAdIboXDuSkzZmLciKefS+y2UaComOtAow
	BqZR9jho7aUku1WS4bkZPx5aqFjDQOTxK0I2YxgIkow==
X-Gm-Gg: ASbGncvNvmio+3UZ03mE76HljWjcP2kZQV8ZPd7qBlClnsd2h5igUwkVmWCc5UXp+nF
	Vei7L+77y1wOgnSVKtuMo+6vj2Uee84ZtVlTZN0P34JELoJoEErwMdDgFxUceVjpLTQ6MWpJ+57
	qu1KHDfGvE41wAdRFyMFbSAkrlOMjmQuntHEGBTBsiggb0lgZ2VKnbXja0i2Q+XqPgnN3dBLtlX
	WFVRP91Rs8MESds7faqNw1Gf3q4cBNedHvHJrfqpSEdWA==
X-Google-Smtp-Source: AGHT+IHq34YNSItovnVows3bsMiARXLvNd6BOzu5f7l3lU09pBJe/LSEkG0WHJOjzrh9jsv+lnLXQC4kAkrLgb7asKo=
X-Received: by 2002:ac2:4e15:0:b0:591:c379:69d0 with SMTP id
 2adb3069b0e04-591c3796b4fmr196177e87.5.1760427450348; Tue, 14 Oct 2025
 00:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com> <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
 <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com> <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
In-Reply-To: <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 14 Oct 2025 15:36:54 +0800
X-Gm-Features: AS18NWBwgtHhcLP0kbUd5HKwhmUQyrzTwXsVnpcaLzBMmrL5fLJbX1wcOLzAGBE
Message-ID: <CACSyD1M1AEbww_07KPd_AAv9RV--XsUOChGE5O+HM5CV+J5=WQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: David Hildenbrand <david@redhat.com>
Cc: jbohac@suse.cz, Baoquan He <bhe@redhat.com>, kas@kernel.org, riel@surriel.com, 
	vbabka@suse.cz, nphamcs@gmail.com, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, 
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.10.25 06:03, Zhongkun He wrote:
> > Hi folks,
> >
> > We=E2=80=99re encountering the same issue that this patch series aims t=
o address,
> > and we also planned to leverage CMA to solve it. However, some implemen=
tation
> > details on our side may differ, so we=E2=80=99d like to discuss our pro=
posed approach we
> > have tried in this thread.
> >
> > 1. Register a dedicated CMA area for kexec kernel use
> > Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the con=
trol
> > code page and crash segments from this area via cma_alloc. Pages for a
> > normal kexec kernel can also be allocated from this region [1].
> >
> > 2. Keep crashkernel=3Dxx unchanged (register CMA)
> > We introduced a flag in the kexec syscall to dynamically enable
> > or disable memory reuse without system reboot. For example, with
> > crashkernel=3D500M (a 500M cma region), cma_alloc may use 100M for the
> > kernel,initrd and others data. This region could then be reused for the=
 current
> > kernel if the reuse flag is set in the syscall, or left unused for dump=
ing user
> > pages in case of a crash.
> >
> > 3. Keep this CMA region inactive by default
> > The CMA region should remain inactive until kexec is enabled with the r=
euse flag
> > (or fully reused when the kdump service is not enabled). It can then
> > be activated for
> > use by the current kernel.
> >
> > 4. Introduce a new migratetype KEXEC_CMA
> > Similar to the existing CMA type, this would be used to:
> > 1)Prevent page allocation from this zone for get_user_pages (GUP).
> > 2)Handle page migration correctly when pages are pinned after allocatio=
n.
>

Hi David,

> It will be hard to get something like that in for the purpose of kdump.
> Further, I'm afraid it might open up a can of worms of "migration
> temporarily failed" -> GUP failed issues for some workloads.
>
> So I assume this might currently not be the best way to move forward.

Got it, thanks.

>
> One alternative would be using GCMA [1] in the current design. The CMA
> memory would not be exposed to the buddy, but can still be used as a
> cache for clean file pages. Pinning etc. is not a problem in that context=
.
>
> Of course, the more we limit the usage of that region, the less
> versatile it is.

Yes, I agree.  I=E2=80=99ve already noticed GCMA, and I hope it can be merg=
ed upstream
in a more lightweight manner.

>
> [1] https://lkml.kernel.org/r/20251010011951.2136980-1-surenb@google.com
>
> --
> Cheers
>
> David / dhildenb
>

