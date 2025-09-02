Return-Path: <linux-kernel+bounces-795591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1F3B3F4EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8840417FA29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BA1E1C36;
	Tue,  2 Sep 2025 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPm6rvjT"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320A1865FA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792903; cv=none; b=NFwTyPTPPMqWxcwLEvIsz0SWsPBMr/FhqbyfYCV07b4AhHeejHS0ojzh/BdKoMzWMcyCtriIhma2E87gj4tXc3p0gLqrlQbBZLI3PdfNq8Vv/ArrmN67TyaDfxpQxmsuvuizlNrY8OVynu/nswdzuTTnbUOJbOqNTTCktG8G3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792903; c=relaxed/simple;
	bh=RmajpQza0YEHOg1FdiINe998dJodQU9SZbCRF6sAGIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amBr0PF9LkEF/6FmaZnWh2R9xQSzew424c/LDoGdXEKUucXE1HJ/ThwNHXTa/WAQ+9XFlkxPko7ede6a8580VG1K+ct5K109dsoDq6fXtCzbDDDVU/phbQZz+C2QmE3Y0wz9FSoUbyVMpKCSaYLvJ/mjz0U9dbgmIo2k4XqtoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPm6rvjT; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8942afd0421so1482353241.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756792901; x=1757397701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAarv6/0QyEvjH7hvgc/y53SwYGeaBvM0iEhN+PX0o4=;
        b=iPm6rvjTB355a905mwANvBKalSLYCPF8Ubxsw14m70+OJv9UD/5WBVjUfTbIfRlIwF
         l4a1PDZ+kdDe3xqDhpZZdIKEJ9igdYA9ibQcMGvGXfH4B6xk+1elAFBIVDbRAuXoLpQk
         9x3rLvenMF0x6N9na7twS6mgvj0vkcMP8qzCvnQHQ/kIjgKubeU+mlBYYJjHCRVtGoM/
         JptsOyhST1q+8himCL4SesZ4xHip5Rar8MKj6dh1PlTCSBiIx5kOPiksOg6lesjrLO4U
         545lL0xSkNP3ML3dxVpmSHruulv8yOWKY5yLUINPfnmEPiGEwYwVQV9Ecty/6uEYI5MI
         vqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792901; x=1757397701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAarv6/0QyEvjH7hvgc/y53SwYGeaBvM0iEhN+PX0o4=;
        b=oDAE1qOATiJCVPx6KcpiN/pGzVVaOxgMkbLeGcIb5fNo1WggIKeB7bDS8ffuk0rKpu
         h+dp9vgUY7FHgzXA1T9133wk7OXzJFxL5ZjTQ21LgAKr9jOv21GfknpZbdH8pXjmwuJh
         9Z+dzcABBhI3zmAIQjU+nybov7FnJvtenjVsB8tfMRgRDUtoq/yoxUFjHzZie455e+X+
         9iHC2H9o535qIcIJzS7+LdLV5vs17KsZIsNItYAGkH/trtuCzMorVkjNKgJ2FIzjhYUx
         8UozJiq9kZANeBcECztNLDk5hVxH1a6jON5l0EzsG0I8QqHkJer/ymY0JgFK8j//tBI7
         fsIg==
X-Forwarded-Encrypted: i=1; AJvYcCX62CCMsSi/mTsVIkjkTc/K4lV5yoL6KHzTXWu4r5HSGJjsnPtOXY5D9rJK9Yj8TJEOIoSkOXnjZrzqQcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmt7ijneZs2x0rYWaYgqx6gsJpCYPY6eHdco4RxNAB2eBsHhIx
	iHa9Z/aQY6kl0Kuo9zewglypL3LXX3yeS/7PyVJ+So4gf378YVgn/SSfA+9pC4c0lbLPzhnWlrd
	SU8lu2updO2TR1mE9pR2wofMajNQ4Tc8=
X-Gm-Gg: ASbGnctjJpPaolqxJORtz1MxG4jjacQw9Csu9gLcLcgTCjySyftu7igiOWXZ3VeBF+8
	6RZyK7b6ftnQI0XZHzONAS+YQxVZ2j+ZyhEH9OI7E20hzgKjaMUXBHXmdPgin/JnNjrOTWYBcBb
	wWrj17BhOYMH/68Sv2Ee7RtEaGr3hknkpokRcMYaQ+r9ibavBfHIrq6InV3fGvnMwMfWqgi3k+v
	J7HaUk=
X-Google-Smtp-Source: AGHT+IF7dvUUantLmFm2kfY5hiNCCQPwaFNajDYulh+zlXf+v566lnO4MCnjDtiXtFabbKXyu9BAsQ/OhzLUud+QAQg=
X-Received: by 2002:a05:6102:598e:b0:4e6:edce:4b55 with SMTP id
 ada2fe7eead31-52b19331f18mr2871291137.4.1756792901127; Mon, 01 Sep 2025
 23:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-5-ryncsn@gmail.com>
 <aK5/1so7a0i80+dz@MiWiFi-R3L-srv> <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
In-Reply-To: <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 14:01:29 +0800
X-Gm-Features: Ac12FXz7vDJJXwXvCBE4eyLwhQ5IdBgtbVP1rFmaWrdYeCo_o0nmZuNulWnB3N0
Message-ID: <CAGsJ_4yY45pv1uGEdMMTsLR4_TmiCvzVs0Nvj9AzPXyqi5-gcg@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
To: Chris Li <chrisl@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:45=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
>
> BTW, off topic here. I really don't like the "_info" suffix. Anything
> you can put into a C struct by definition is some kind of information.
> Same to the _struct. Anything defined by a struct is a struct. Don't
> need to say that.
> The "struct swap_info_struct" gets two of the unnecessary words. It
> should be something like  "struct swap_file" or "struct swap_device".
> Renaming it is too invasive to the code base and it will mess up the
> git annotation history.

Also, `sis` and `si` are being mixed up all the time.

Thanks
Barry

