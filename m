Return-Path: <linux-kernel+bounces-794064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E4B3DC53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620DE3BFC07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF02F39B3;
	Mon,  1 Sep 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="d0/MdPmE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489402F4A04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715200; cv=none; b=FbgHJT1egMigaOvXuNX6ZtevCSlVRSyYJxvChXkStKwUQWN4c/Vs3W6ZjB5SVOXpwceaZ6TK0waljIShT/AQ60o22APyMzPxQM/fXR/iL3D4j9RB2OeTpBdUpm/ht24eVLceuaUC0ci/94jIoglia+43T4YOmUFK8HIS2iHw0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715200; c=relaxed/simple;
	bh=Py4aYMpGJ+Qx0hCoeF6vFBXKDSrOB/Gzs4Mv6AoSQ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5r4gsqWLPeTYCvSwAEs72pXhVZ7tTyI6F/VG1anm2H+THv9AmVkfJKPuaxl1aZFeKZ5LHs9qRVmtlmEEPyyAZ45V9w4O4psVAizmk/JXflQWSXNoHGjl5xgAJqn+ZB5f08XHQ3mfMYkQiz06M4JXv4xIxr/hWGdTLj2sBnPWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=d0/MdPmE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b040df389easo244254766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756715197; x=1757319997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py4aYMpGJ+Qx0hCoeF6vFBXKDSrOB/Gzs4Mv6AoSQ7g=;
        b=d0/MdPmER9SIMiV2+0XT5IrL/RPagvvwfAlSjcTbSc9CCmdBXW3nRnniqCnKjqqtpU
         W22Eg7j61rRr6a8ttxXad/q0yU/jh5OAkGQcgO36xCr8OU2Kw/x4KjJmA6fOsVcsfFYn
         lCPa4R1iMo5737qWraZ4k3X4ZN3O6CermZo/76v758y9wGEArOCndQshWbBs9xJb1it5
         JuWYTXFHN3S3rb84A9h3aK2o7zOQaRKXoJq4n2KYcCgrYhqcQ1/qG/nps5CVf8ZxDpX7
         sH+yB/U/m44byDYNKe/94+5bI19//AIQ7JlfJEkiD0jO++34o/KB7ZMoXdWW6NMfGI3C
         ZTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715197; x=1757319997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py4aYMpGJ+Qx0hCoeF6vFBXKDSrOB/Gzs4Mv6AoSQ7g=;
        b=msPPPahuGQ3xcAMtn7YgJdlouSpAm8w01QTKudAs97rOdX5Xroo+2bXEiKz+R3KXWe
         IwmQH1Lzuvd5Tbd/ppUH4n7fLC+Yg0M+Cuy9VjcVUIV9qPyvG9LMqS/54DsZPvwJ9SyU
         qzHYQadtvXVTFaCfISTbsdT7/ahhQZFh1hLAg42fstpC8ScbGgVbaYfr23NgZ7xDcdsj
         tlrlqD5gPSeZvI+FxonW8tnqWBUJ9mP9d3Kzb09JKEPppkC+MWq1mLefbMy6AFtpG3dW
         KOaMcQD5YZvh/9zQar4eYEWGUFjBjNp3JzJ/ooXok1w+nKYMcCTZoaB3j+DYHEmqTPBD
         tZvg==
X-Forwarded-Encrypted: i=1; AJvYcCVcJrXXf0uTWzRb7PPQQpD3hmxFt0oR7vrGceCk6LdjgGCjjo5wyKg7l5C+GSLUZs8nsl98laFWqKEZcik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU34kn3YmMGE/7f3+J0TrkmPZub5r7W1h8DvCptzj4ymmAkTu+
	savN9yydyFShgC2qXeCCkEeXN+al1o4VlJzmB5xeYsXNvHHDkrvDeUOdZIbH0oUAR05yvpvxebV
	1hWL4Gu263df/+E9WVFfMPaSGc9pK3AXKSQFGnCUgzA==
X-Gm-Gg: ASbGncuZuJx/BGNbmS1mo7PlwU2OLTlYdMjiZIGYOB6dUl1keHxAhnq2wIwdoZXNPmY
	aRCU5jH24vl8SBU+9k/U3MxUhcd1xkwkM9YfC15EMFeKPYpu35b9dyZVz1gCq4R4V//pvrNhEFh
	R4R2pjmsFW4A6XWBiPCJoGPC1un0KX268ZhIlaSykFKQ7pQwhp+z85mQK40G34LXgTx/KNrgq4a
	5JzESiDWuRuAoFWnZ5jWkIxNkB/HFxKrT3s5lIyX1eKtA==
X-Google-Smtp-Source: AGHT+IGXI2msCnx78Su15PAuWs0lHjk7inVPkR/r276bsxb/xC5chRSN2HXFSJE+JAHHxBRmUSvk6/k36E+wpO629AI=
X-Received: by 2002:a17:906:f5a2:b0:b04:3955:10e2 with SMTP id
 a640c23a62f3a-b0439551a93mr112117066b.25.1756715196549; Mon, 01 Sep 2025
 01:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com> <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
In-Reply-To: <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 10:26:24 +0200
X-Gm-Features: Ac12FXylcJi3zihZv-FAs1g-1p6_jPE5gFpeWtm5gKkpVFqz2VdwhTrMBi47B6E
Message-ID: <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:20=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 01.09.25 10:05, Max Kellermann wrote:
> > On Mon, Sep 1, 2025 at 9:33=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov=
.name> wrote:
> >>
> >> On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
> >>> For improved const-correctness.
> >>
> >> It is not a proper commit message.
> >
> > I believe it is proper for something as trivial as this. I think
> > adding more text would just be noise, only wasting the time of people
> > reading it. But that is a matter of perspective: I expect every
> > competent C developer to know the concept of const-correctness.
> >
> > Do you believe the commit message of 29cfe7556bfd ("mm: constify more
> > page/folio tests") is "proper"?
> >
>
> "Constify shmem related test functions for improved const-correctness."

Mentioning "shmem" adds no information because that is already
mentioned in the subject. "Constify" is just as redundant, it's the
same as "adding const".

The only new piece of information here is "test". If you want, I can
change the subject to "mm/shmem: add `const` to pointer parameters of
test functions" and leave the body. Would that make the commit message
"proper", or do you insist on having redundant information in the
body?

