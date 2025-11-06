Return-Path: <linux-kernel+bounces-888795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B82C3BECF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28B7501D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425BC345738;
	Thu,  6 Nov 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtAKlyu9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASHsC/KP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2F345730
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441041; cv=none; b=A9RT5zRAt5F3qe0bdP590gejv01KobwquLDIAQ7BvMaKC5f8nkGooixxRQaY2y4FtYCSdHcTL5nym5YYmaWZjIaLETdXiUhDzzJQFoNVSUfnaOkOws6I0oFwyVtvdlFrNNGXWcz6k6YdhQWjePHHkpgWhSPCh7yp5xYu2NOfmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441041; c=relaxed/simple;
	bh=RRJi4BWOSt/oUeeiLS+eVgUBIjfhPebchxQneC5M2X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMFUblcKn1YOfO4FBXZPMT00sQLnZWG5x8NcoreWYOD4ULM+kkjLfPCFEMMZXQYkoB2nQjhrFBrAIQeVIoukfdyRnuf5U5OcZ3l3H/HyUVI/RcvIC/GRE1VmSgjkKWuLlk36lsfzj4hiaHVOF7yn2x11WZmewyl0t5HjaBPx6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtAKlyu9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASHsC/KP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762441037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRJi4BWOSt/oUeeiLS+eVgUBIjfhPebchxQneC5M2X4=;
	b=KtAKlyu9JmOQe90kuogrf4+6voLZ25vCTYZzrwxq/gnTiRkP5H5jSwuIGfazPPHD7F1G/O
	9lsXoeaHHl9rKM/Or8GJXbpjaMlZ2TLnmERpYZcC0zBSmIusvrrxm5O9BixvC9cfCm0jE2
	mBsjmJnp4MeW77cdmY07AvlwTXdMhAo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179---JJrNuJMyGqSTbza_X5bA-1; Thu, 06 Nov 2025 09:57:13 -0500
X-MC-Unique: --JJrNuJMyGqSTbza_X5bA-1
X-Mimecast-MFC-AGG-ID: --JJrNuJMyGqSTbza_X5bA_1762441032
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59436279838so791791e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762441032; x=1763045832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRJi4BWOSt/oUeeiLS+eVgUBIjfhPebchxQneC5M2X4=;
        b=ASHsC/KPDgfhTXiT0CoVt2G35pSbi1UUL5NaazZqXroPhozIUmumF/2ZRjbP7kESUT
         MzMUcl9oAe8FKn/yLOPG2lMpNDWai/2rhLeh0H3y6qPveSLxenfcZ1Qa8zx8jGaDGSqJ
         LQZT4LhC9is3+6zdmB0rA6qjMW6XIEmGQHV8e5GCO8NZbvhr8KSfxG23K6IBqsiPSlI4
         qVGubdl0+uc8Oh/2+KC2uWmHWQV53+dFsucNu8SbZcEwXOUDK4Cr84krlU735Le02JBm
         +L3oCKCdvDTl1DaUAMUKAT7Z3jOW+fhk1SMX3/KlZphc7/D/8KMpGNycsH6Wb7Td7l3j
         KqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441032; x=1763045832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRJi4BWOSt/oUeeiLS+eVgUBIjfhPebchxQneC5M2X4=;
        b=U+SHNbc5qATjEH5pHZPuEZN/4fW65w03m1e4DD9XRFsoICwWYo2QWCXqefNj9HPdou
         3PR45RhwMm4qC4XL+mnPtVYsOSysfrLjI1g6qy/N0BbdnjmgSIgan0rWW2fixFytwbMz
         3iWhlYxmx5i8s4YH4Lz5HjFk/9tVYxCatIO55KSgSzaI4i+6a7t4PUfrotd8nppi8tku
         d8SPiAcr2UU9Zt+K0zXJJxRORoF5aJ5c+FEAHd/roNKcTEn91KezvGEPBd9z0FdKtixX
         KWnzxvREQyB+0SB7iQBvh0RQUGMiDgKtwKfQAjGcALRQ0BtiJpEauBA3BgP0iRc+by4Q
         cUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWENCX17l/QOtmZ9RUbJfnD/vk4HfciPYk/5aOgzwoWnbSszQJ6lwX2sbheryIokB4wmkT5ZOAi6xp/FAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+slxESDjsN0uB6U4MATDmdzlsvlD2GuuZypXHh8p+kOpB826l
	tEbNe/jHsHmYYaucA/srmAVCCF2/lATIbPVfg1cVJubiv7WMlN6kJK/BVzxa0hbTQ3hHvg9Rn0+
	lrpWVCP/bsyKonSHjLIhM5/UKjpwtHRy6ITSKowDlTXnvNZ7qcYhvu64OnP1HaPtnve4iLljH6Q
	m0yNlPndOdpKXk30G0iouwr8UDWF1pq2bzFjy/3ktP
X-Gm-Gg: ASbGncveKXmwE1JoGW2YNa83hn6yBZi8rSBFwfC++8BhJ3sqIYJG2+iS5i4MYdUxydV
	3ETclG8YZdusU0I3HCmuo2+GwZ7ie0TlcEmsW5Q+84lAwDB784GNa0OIE9kNTJLDwf55L+6CfIE
	SbONu0XK+9p124PsO8WucIaSuI7Hk3RmhqOtWuOMysFT+DWx9awGE8oIQ=
X-Received: by 2002:a05:6512:124b:b0:57b:8675:e358 with SMTP id 2adb3069b0e04-5943d7c044cmr2516340e87.21.1762441031654;
        Thu, 06 Nov 2025 06:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtNGrDwt4RbOyF6y8CtvYQa56ZITXl4wPjOUbeGGR+zBng+d1yiIB83ABcja7XIQgf5a8pDswEdEPmhr2Khi0=
X-Received: by 2002:a05:6512:124b:b0:57b:8675:e358 with SMTP id
 2adb3069b0e04-5943d7c044cmr2516334e87.21.1762441031201; Thu, 06 Nov 2025
 06:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103125757.1405796-1-linan666@huaweicloud.com>
 <20251103125757.1405796-5-linan666@huaweicloud.com> <CALTww29-7U=o=RzS=pfo-zqLYY_O2o+PXw-8PLXqFRf=wdthvQ@mail.gmail.com>
 <a660478f-b146-05ec-a3f4-f86457b096d0@huaweicloud.com> <CALTww29v7kKgDyWqUZnteNqHDEH9_KBRY+HtSMJoquMv0sTwkg@mail.gmail.com>
 <2c1ab8fc-99ac-44fd-892c-2eeedb9581f4@fnnas.com> <CALTww289ZzZP5TmD5qezaYZV0Mnb90abqMqR=OnAzRz3NkmhQQ@mail.gmail.com>
 <5396ce6f-ba67-4f5e-86dc-3c9aebb6dc20@fnnas.com> <CALTww2_MHcXCOjeOPha0+LHNiu8O_9P4jVYP=K5-ea951omfMw@mail.gmail.com>
 <c3124729-4b78-4c45-9b13-b74d59881dba@fnnas.com>
In-Reply-To: <c3124729-4b78-4c45-9b13-b74d59881dba@fnnas.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 6 Nov 2025 22:56:59 +0800
X-Gm-Features: AWmQ_bnBMF115EOOjA9vbLZ9uN5wB3kN3ss1NrGOT0tRZSVZHKdKZOidba_fN6I
Message-ID: <CALTww29X5KizukDHpNcdeHS8oQ-vejwqTYrV5RFnOesZbFhYBQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] md: add check_new_feature module parameter
To: yukuai@fnnas.com
Cc: Li Nan <linan666@huaweicloud.com>, corbet@lwn.net, song@kernel.org, hare@suse.de, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:31=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2025/11/6 21:15, Xiao Ni =E5=86=99=E9=81=93:
> > In patch05, the commit says this:
> >
> > Future mdadm should support setting LBS via metadata field during RAID
> > creation and the new sysfs. Though the kernel allows runtime LBS change=
s,
> > users should avoid modifying it after creating partitions or filesystem=
s
> > to prevent compatibility issues.
> >
> > So it only can specify logical block size when creating an array. In
> > the case you mentioned above, in step3, the array will be assembled in
> > new kernel and the sb->pad3 will not be set, right?
>
> No, lbs will be set to the value array actually use in metadata, otherwis=
e
> data loss problem will not be fixed for the array with different lbs from
> underlying disks, this is what we want to fix in the first place.

But the case you mentioned is to assemble an existing array in a new
kernel. The existing array in the old kernel doesn't set lbs. So the
sb->pad3 will be zero when assembling it in the new kernel.

And as planned, we will not support --lbs (for example) for the `mdadm
--assemble` command.

The original problem should be fixed by specifying lbs when creating
an array (https://www.spinics.net/lists/raid/msg80870.html). Maybe we
should avoid updating lbs when adding a new disk=EF=BC=9F

Regards
Xiao
>
> Thanks,
> Kuai
>


