Return-Path: <linux-kernel+bounces-804904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4ECB481B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32012167668
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72285F4F1;
	Mon,  8 Sep 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT0cJy02"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA138B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757290285; cv=none; b=lCu5OWMlc1CooT9iZe17Z8UCKCVaT8Y7JtHVyMzxUJXf4FT2PwJaI5GWt0gX3NOS68UnuYJ08DgyqvXC0mv2j+CDY27rWq6/1/grnAG7s2mZpzW1tQeizSSafYGdhb/fldpje89nIQNroB0lcrNrFO8RsyhaRtQRC+cpn/BXI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757290285; c=relaxed/simple;
	bh=KIfXbnQ0TsLHys0+NJm5CN/Z6cOqD6HcADC6soVNg0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM6eLixnJEA+gCSRE1J1qiES6j9jsWvfp3z+O3MYTyjL31o74+v5y+3Z8ar4XYNxAOlwbBmNsTThXQDAILMrr7acAcUvJ0xWf+vnQoeZ5haER5UP69RWq0isiL08nvSzAanYFEuiESliZEkqTu0CspTK+pFOxK19J8/OVXmg+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT0cJy02; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f79aa443so14903061cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757290283; x=1757895083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIfXbnQ0TsLHys0+NJm5CN/Z6cOqD6HcADC6soVNg0k=;
        b=kT0cJy02TrFnQgkM6xyyM9501sYMj69CSYjBNBXb/MRDsGUTpgQj1I+l/StX6B5bNC
         hawD67cV3hmDmP3aZqFx9sPAZqY9e7NyOlVnuxbLJGyEUMiXwcV//HwNUWSCwPPxNsmV
         OmTLpSHf3XRiCjCldK7TmJWvjPI1faOHNAlPMoaoqzyHuUNFNDDcekKjfpKN0c7Qvasn
         Mu/FpdM3L4OiCkw3VbSpFhfvfj5sjVLge5Rx5sUroWpT1GKb4PfL6XN00CW5GiLDG1e4
         bW/w5YGVQM5FuEBNs0/xnXnazQsF23He3EZ7rvBOHjgtollyWB0C91vrvFRymj2I97hT
         sIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757290283; x=1757895083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIfXbnQ0TsLHys0+NJm5CN/Z6cOqD6HcADC6soVNg0k=;
        b=BSzwq5mE0hZ3j1Rp6txxS3Anot8EIC495hHNvqjug1KvcbS5iq/FVtyjQO+xXmkNVg
         Y7u0/ZPyPHJUB2aKe2YvjgaG3gIYunK6bi3xtVGRNAAxjk/2a5dtj6jKmmTsTEnumiOw
         7ZQY2yEiTjGpsFog8/0A2031/t4Xx5TBvFDwneT2IYXtz7pC8LsmQFYzkqkQolxiOZB/
         kUEjtlKlPMC9FBhhbrVaECEyJe/c89BLfu4Jy57bcx+v+C0MlFJe8dGflGREYISSXRS/
         gk9VCUg2F5MH+cnwvOF08HYwe8yAq6Kgw3h6o8UfxjgjUVAQg533XUHXlpuhgONJE1Jv
         SKDA==
X-Forwarded-Encrypted: i=1; AJvYcCU0YMpkDA1hWYo8QS0OUg4ArF/GT4eAUjMiz39dKpQkPpM5NnXEBpckZhcBT+aDSxAUYKmusVWtUbzL5L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lhcfivnSLDudN+VLFFlt0wT25akHEe2O0bCHurPe9SVyGKvS
	bq7WIN+IDOIRf2zvpLwF/1D3ZAid/R2Qm928MV7LewcignUG5cT+YSK8kvBizIKS5dEgsdMu2tY
	VYg4MWEfTjomh/F0DjzdjGf2VIDiBo10=
X-Gm-Gg: ASbGnctbOKBHHuRmB6pa4X7a9jkxR60oQOBXygi0l2vbCD1j0CHbr69yVaU5BIsrLB7
	8QoyNMgI0m25Vbbpm3h+vaIzTAPbgPExhZXMy/nNY0D0wPjLhMuOw0evzkQV6SGCrwBNllwoRA4
	p8r6j5iaeZtuf6jX60p3Gae9SCO15Eqz5H3C1oF8fYEUgOA/ivZnXvZR3ckr4wAHLZPp6vDvpf/
	poUf/g=
X-Google-Smtp-Source: AGHT+IEAr77bv9E3qYMr72XCeV1rwW5bKa6o0t6CRiMM0ncBput0rzKkZKWmrEosGN5sE3HVuKUiS6Ux8tQayBIv6bU=
X-Received: by 2002:a05:622a:14cd:b0:4b5:dff1:89c6 with SMTP id
 d75a77b69052e-4b5f83b7676mr79765771cf.21.1757290283141; Sun, 07 Sep 2025
 17:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-10-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-10-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 8 Sep 2025 08:11:11 +0800
X-Gm-Features: Ac12FXyeA-zFeeEjbGpyPLPg-FXJrLR_YT9eEqvLz_qkJCtcR4ZLOxLX4jBFvXA
Message-ID: <CAGsJ_4xG2y5fmWrdo7Y-ALx1cx8z-q0HxD5Y9CzQae-bJ9hPVw@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] mm, swap: cleanup swap cache API and add kerneldoc
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 3:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> In preparation for replacing the swap cache backend with the swap table,
> clean up and add proper kernel doc for all swap cache APIs. Now all swap
> cache APIs are well-defined with consistent names.
>
> No feature change, only renaming and documenting.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Barry Song <baohua@kernel.org>

