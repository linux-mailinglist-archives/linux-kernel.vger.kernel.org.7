Return-Path: <linux-kernel+bounces-885663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2ACC339F1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB1D18C58A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507023AB90;
	Wed,  5 Nov 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQllY391"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A81C01
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305434; cv=none; b=el+pM7oZNhNBVeb7p1bdSjpuj1GTgrQykKRSKHbrNiZLdL+//VDf1lvV20JvOJNYw5bb0YqfypVkUF8wg91TPDWlaNBB++4Abcp5eLhar8fqq8cpdf+PeOH6WfqwRhtbRioNPara1yk7p9JwI8NVXiRsLFO3sU7El9bQGYrK2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305434; c=relaxed/simple;
	bh=otQJ5yMPZnoASOKC1J81k6B1oYB7Vl0UomFswCPjByI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPv+BVmF0Yx0zOFZZDop7/5e0+pnO49srojYT+VNmoE65NPd0TC2oFZ1fGfLyHlEwmiegW/5L9dvj+lYnuWor4r7UMDcgm2JgFjYpRMDkiTDDL0qG7CkJTBBzsilOm0Dq8k7BHv7+0uEj0gjH0HBAfSCDvN/X6dq/o0kTFGarEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQllY391; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso3759313b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305432; x=1762910232; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmwaG142GAyLGy8hrUjFdJw0h9ZhJSd97NfM3z0OiJc=;
        b=BQllY391LSEMdgLvhMEa1UdB9CW80BIoyDVaCdEWuyt27wXnkBsNb+Vmw6iL5jXCqp
         lf+Oml31eMa8M7C1lsUw2lcY07rLTqPlgnWJHl9EH32h2PndbczUW8tQgJyxfT49Yc16
         YOChbSJ7v5606dQ4j/EMYYVcooomOQ1lzZ16yNPQn7CzqYMJBCRfch5wOmOHUE4CXxcR
         vcWWnuOp4jWShQ9c01+cxtJ3HNobxJZ3I341spOonIGgz5t3sB5g2ax/JMT+ld0396P0
         9Y91cCG0didi/pdGiX/aC8iWwLCIWxqaX8tTCbgLmYqiOhqUlTz2E4kzL+RJdi+fbDac
         5AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305432; x=1762910232;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmwaG142GAyLGy8hrUjFdJw0h9ZhJSd97NfM3z0OiJc=;
        b=ViYbqxJd1Cv30NVn07RrQgbB3/gCy+N7VRCdeI/ifoSk8vFdsLgexC2q8YneCMBJgn
         7HV7K0Ak2DaGIfyJKuYXrHtC0//w9404CONF80JUa7GNlkO/fyiqsqqEjVsM98+xn55X
         XCV5XQIumsO9EYZV3PAi7UpmXpI6xcjkLFTuTNNbsoiqvtKpZ9+A6bgw6kqPZbOT44Ro
         xEnJZksyDKlqGd0/zThMf9d3/ywtziD5FNzQzwVtKI44qJJapJK3Q4CSnxh8UFCGmNit
         btVLi3UBhKHGTN1iXG04famYwQHKQM5Bl2VBcLYTHCNRB5Va2YAOoLUrJwcFST08OWbY
         6wlw==
X-Forwarded-Encrypted: i=1; AJvYcCXRQZnkFDdkfak4EwYXzWm6ITM06GTfr8n5yttS2BqGZXH3U/W4ZHjjS5bQG+B9J8bPAY/01Nk23oWuD1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7KedF+hQWYcGePdd+VEuYEz4R0fmsolYkIsPVC2e13cuqaeZ
	K6ZXngAnQeQ5jHjcP0pwPBf7eeDpqy9Ah74XxBfBOyed6NfPJX/lym2/
X-Gm-Gg: ASbGncvR17/zDEUnO4aAuk1cKk2rIKyljqpEGzBBmGV7kT4JPiUzspavZdZVkNOsj7W
	VV0NpvXlkncPE9mkql9/Mo7BeHPuvF8Il4bDWl5p4gBPjMkG7SRZRa5xLmAoUIG6MF3TeCriMJQ
	xSAO8LTD04XvjYS2PvHSD63l+cX+S5bEH7kfcmMFiNiALe7wrkq2yqaN0+QhAH6dN74yqFfgPgF
	ZGKM9C0nm/rjh6IcBlZ3GqxW9nD71Mh+uMQ3K7kabyDvsVkIy9EPaBNjTivEAjtd3JOasa4GknA
	xcOws7HiWLwAiR5XtBPOQ6JgKEM/A/9KjOQUD9/KaNNZO5QcqabF79amIKC52PVOAr0PKSNzmi7
	jW4kfNTYaC67ecRwgFyVJarMMZkD68YICUmrSW7thI1+tJ4Pj4LzMGhbz3hspZnfNPa3W9nI932
	0R+nY6IGO39tGNJzy4++xC8qY=
X-Google-Smtp-Source: AGHT+IFRprAUGju1jNoCrThKfphIxtj9XBDktxmL9JibwH4lMh7Pp0howRHX8Hmib3n060SdiXW8xQ==
X-Received: by 2002:a05:6a00:1304:b0:7aa:d9e2:8175 with SMTP id d2e1a72fcca58-7ae1cd57d31mr1641380b3a.2.1762305431932;
        Tue, 04 Nov 2025 17:17:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586ccfcsm4425329b3a.41.2025.11.04.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:17:11 -0800 (PST)
Message-ID: <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 17:17:10 -0800
In-Reply-To: <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
	 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
	 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf,=
 __u32 type_id)
> > > >         return type_id;
> > > >  }
> > > >
> > > > -__s32 btf__find_by_name(const struct btf *btf, const char *type_na=
me)
> > > > +/*
> > > > + * Find BTF types with matching names within the [left, right] ind=
ex range.
> > > > + * On success, updates *left and *right to the boundaries of the m=
atching range
> > > > + * and returns the leftmost matching index.
> > > > + */
> > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, =
const char *name,
> > > > +                                               __s32 *left, __s32 =
*right)
> > >
> > > I thought we discussed this, why do you need "right"? Two binary
> > > searches where one would do just fine.
> >
> > I think the idea is that there would be less strcmp's if there is a
> > long sequence of items with identical names.
>
> Sure, it's a tradeoff. But how long is the set of duplicate name
> entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> with high likelihood will take more comparisons.

$ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sort | un=
iq -c | sort -k1nr | head
  51737 '(anon)'
    277 'bpf_kfunc'
      4 'long
      3 'perf_aux_event'
      3 'workspace'
      2 'ata_acpi_gtm'
      2 'avc_cache_stats'
      2 'bh_accounting'
      2 'bp_cpuinfo'
      2 'bpf_fastcall'

'bpf_kfunc' is probably for decl_tags.
So I agree with you regarding the second binary search, it is not
necessary.  But skipping all anonymous types (and thus having to
maintain nr_sorted_types) might be useful, on each search two
iterations would be wasted to skip those.

