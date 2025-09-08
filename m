Return-Path: <linux-kernel+bounces-806788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE13B49BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE033BFFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577F223DF1;
	Mon,  8 Sep 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWL9lVu6"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13513A86C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367037; cv=none; b=cCkw1glzFlfDHXyCy2G5tl5sTOP/7Phx48BVyxHC4EWmO7bqCRBcZYNdsGvwE5qj1OU8iCPA5WL14q8HWk6K2ySVmcgUS5V0dnSUJHIxFKBYv3gU7pThMmJFfYhblZRCvfApSF0732DNISh7fAR0qseFI5mnKKJ9+DiYhOH6Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367037; c=relaxed/simple;
	bh=YIsuixUQYpyOebSRVoXF1fjr0s5UCtK78T9mHKm9oYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtxFnnyIUmFbANE3iIM2Tk620sBqar7e2PI4ZVJ2+32InhOI7tbin6R4eIn4pU1fjVFLGMTK0gr+XaVaQbFeSg2+Dv5Iu/V/9SCgI4j2BUBndL0i0Xlb/jTYecA6hs+XR/llBLjcoZT83g3H2PB7/kf4pQebw6EXVh7GAb8kWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWL9lVu6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-816ac9f9507so163134885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757367035; x=1757971835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIsuixUQYpyOebSRVoXF1fjr0s5UCtK78T9mHKm9oYw=;
        b=dWL9lVu6I2/0LbFNC0k0gyAOvITm4stQpzk4CuTdHi7pIxeTqiSIAAj/vdIwiNurwr
         eAW/qIPT56Q5fK42c8CMC8mYcAXAF7L3J+Zzub2nFU6V0tgkEyyHpUKYIFDKFekkosz2
         pU/EWcG8SV93sFfggS5XTYLDKDJwg8SAvjI8m32L/4S02+5hYZqVaozeqnzKfnH7xQYk
         pgaPrURRLxOPQnv7EhIru0qy3DgM0pb3zYAcqNj6BFMDxmKgAf0p2X/LTrdC3qI6fFEf
         8yCJcD8WFHY7w4wpwJkDtfLjo/HK5MwgO9A6nq7lgjAlTkPLiyPqKKqTdmOpMLX1dVHK
         Ixag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757367035; x=1757971835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIsuixUQYpyOebSRVoXF1fjr0s5UCtK78T9mHKm9oYw=;
        b=xCoFRo82reI6yi2m6gXc6CJfDYcIk9uCEyIVW86RmaNtai8Gp0TBxHScxDiy1q0JDn
         dLkB8xbmDjR43gzBlAmt/TU5V9l8qJUTz5i3GaUBIPpsc31GOYCN35wQhUXBQHxjqmrn
         3MDbsuIcWU945090vyd4JE1yaUHSSgTjtA+cHz4LlzBDJuLUJxEjGe/tfbHXM03vuwIt
         dJJXQYsf91+XxaieHsE7UNSu1yjrTIunj5CAZK9cLaiONb48ywat6ghOAPURj2xX5+j5
         sECp6I2hlmbH2jZd0uKgGLYoOmM6q8a39yj2oHRPNbg7B0z+UbnTkcimm0f3IL98H+zU
         rClg==
X-Forwarded-Encrypted: i=1; AJvYcCUVowynBALy+AHOjD0QzMdIw5QNgG1r4AoeEppHewU5WcF+rwMkp/Zg9udO+CxboVvEF40mm8kQEicijUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhx30iHxbszmZe7eG+1+TccV2zo4HSbDTdvD2L95r+xHYgwoWd
	1f6tVTb8Rjs8wagCr20daj6BpspNLwLrANnZeic+IIylkCsAhTvwKbGv4gC7h4hDxVo8lr3rPIf
	JlEzPQrMwm4bbnEv+iUh31Xa9V516X7U=
X-Gm-Gg: ASbGnctRTYOFi1prtBZcV96nI6zQuHQm8J2PPFjpcLGPyAYZFFeAGlnYfoFiWVRqraL
	SH3p/MNMlkFMw2sj34gr2+MDZgrdFJ2GGGSkbtuGCVYnxapUhHJyPsFp8MCLdDh15UGF2cW6pUg
	chseit5udAIlQ805sVW+N0Utpq/Z3j9vcrkIpGdhz2nfsEv4nEFB1m6VAkbA0dgVjGChulNHDgV
	9XVOak=
X-Google-Smtp-Source: AGHT+IE3qFQ+jcA7Fw/zKIK8rz2XFClNQqefDhcPjIdRitlp2ylBPSfG243LlbR/K1tmst4GJ4ipgmMVnTsKIqJe9ds=
X-Received: by 2002:a05:620a:3950:b0:7e7:fba9:4a79 with SMTP id
 af79cd13be357-8109d369836mr1721981485a.29.1757367034719; Mon, 08 Sep 2025
 14:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908104857.35397-1-lance.yang@linux.dev>
In-Reply-To: <20250908104857.35397-1-lance.yang@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 9 Sep 2025 05:30:23 +0800
X-Gm-Features: Ac12FXxiURkC-2ZfWhli8wgPruWdOZkry_woCBzVXTMqWQFnpcG4tnfJe2thABE
Message-ID: <CAGsJ_4yU_uWvOXPovEhe9O0bbA2TmM9vKgWYTqaVz=m7vb-Qag@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Lance Yang as a THP reviewer
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:49=E2=80=AFPM Lance Yang <lance.yang@linux.dev> wr=
ote:
>
> From: Lance Yang <lance.yang@linux.dev>
>
> I've been actively digging into the MM/THP subsystem for over a year now,
> and there's a real interest in contributing more and getting further
> involved.
>
> Well, missing out on any more cool THP things is really a pain ;)
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Welcome aboard, Lance!

Acked-by: Barry Song <baohua@kernel.org>

Thanks
Barry

