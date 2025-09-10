Return-Path: <linux-kernel+bounces-811061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF0B52394
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3497C3ADD29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED009312802;
	Wed, 10 Sep 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvSBLOz9"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC26260587
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540307; cv=none; b=mwEmyXMV+alo1I9fa7p/VGyL2rDdOqXz2iST8ZHWGAQBv96g6+CVfEdSrZXSwh0fKzml+rsYlR/F/O9Krzw+jMF5rp/v836YsOMZkl6Ae0itlLGdW6cgFF6dtGqrbSB/YKc/wjomgreQK9UHeBRcQfCD+SYnVLtLYDZdK56o2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540307; c=relaxed/simple;
	bh=6DaDvL/XuSmFF6PwAZ0CdJELwsU91MrY1z2UhONW3RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3V5hHaiUjQWont0QgM+LsdMmZUQmUzWOTMH2Vpi053B9ls7aR5mGwVAv4yzgpzvt6a6TRzKjSzHGqHg3KKDrWUnRI2p7ymt4ylzpea/NuglQTsyNFlGYNuR2DSRa3b8RKGo1BvxrGPmWiEnJgKX4cI35HI3EiM+QmIu50zzUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvSBLOz9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96f401c478so9253276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757540305; x=1758145105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MaaI56U+Qkz9tt/DIJEh2ObjQBjcj5gnQOzLQceSgQ=;
        b=GvSBLOz90M1DiBrSOTZuVpHI4n5ZfjC5nbeouyNOW5QJS84CZ+ukj+QW1AAEIcncGc
         S282MNZhywa+YzDQ11YJBZwwZHGxAseEJschx4p1k0WXKRnx891PYeHogC31NZVeL4O6
         br+EUOzqLtcryzC9zMCdKs61s6ElFVUP57R4bAZ9dtpfuTDTr8t6TadhH4XJL17hWhfo
         eoSgeyqtVWxKDbjDFcJXTQLfx2J6mVXuNXK4K8Zff4f/u8hGeSnO5tF3cMsLGmbE4AGX
         EvMNuM7BxiHVCiaw2WIcBhb2zd8OcmGLES920+cqbtaxDG9qn+hfyWAQ6DR3/4QE8HuF
         vM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540305; x=1758145105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MaaI56U+Qkz9tt/DIJEh2ObjQBjcj5gnQOzLQceSgQ=;
        b=s3GyCooYau6CJLqL6rkOFLLevMYxe0+tm3g0heDEVAUZ6DlWhJLry8hVm8io4bN4ow
         ilvsjSKxphGghpyqo4TKI5/VxvmsV9E7Do3S3wYRff73ORVy5DeP1brno8uCv2d/9Iaf
         v8y2pKyqO5d5Ak7cJBjQ20Dltok9CZUda5nz6leu/brgy621tfeKeBZvLboqlINTAYxj
         stPLLbWbmA0xdjbPFOoitsnldZQga3KbYoqd+ClQ51WdBBhDy87BiXA8wORKdNS3XtXi
         CAc02qbIbUChg3n6u3fy9xB4zWyVUaHGYi85eUQrokErceyHyO17RxTgUDL0K16YJBAz
         FlcA==
X-Forwarded-Encrypted: i=1; AJvYcCVgcBgnWLyG6gGyNOQQQUms4PGIdFXem2nrTj8i6F572QAYLpTe8+ny2bK6+f0YJ2a7p0u5kj6SwVXPxlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aR04vWWtatsIfAWtD9pM05PM5Kqzomyiu+WtpxM/2n3vP449
	ozRBq++HTeN6l1jQVWQctxB/ffhG83mY1KOyJZPmGU5KnviLDqfK+LQnYCwbY0Ct+LIAEh1x4d5
	9eDPeQVyg4ZKBu6v4/ubZF+0PXST2Z7rQFvq/g9fN
X-Gm-Gg: ASbGncuuh2It+aqaUOlF99TcWjitQQKqhEPOcHPdMeqi6tf22UOaHeglpbjV/xdrF3f
	hGwfc1XNqIl8QjsnOa+BWPi5Oy1YC7nkp1k75cfHQE43PGUD7IoXpXbExFsCsGFsYylgJI1mPBa
	yGSRTIvLTbcdwxXmAZtsRmYFs5FGiLNv2IpZJxIMXS773l6smocBYdZwqd5Xiye0yUa+jEz9LKP
	Nup+BCzee7pGJ4Iog9GqxvXegmYH6ZY4YfAfS27ClgDVd2U9UOz4YA=
X-Google-Smtp-Source: AGHT+IFjiapMVAE+YWMHxZlJO4Ud1KxYzL+3ikt7jridg2d7lUNbKYZUcfty6BWQtgsD9X71GnpbV7xDUb4JUrEqk4c=
X-Received: by 2002:a05:690c:6386:b0:71c:1a46:48d5 with SMTP id
 00721157ae682-727f398b12bmr153355007b3.21.1757540304596; Wed, 10 Sep 2025
 14:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com>
In-Reply-To: <20250902111951.58315-1-kalyazin@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 10 Sep 2025 14:37:48 -0700
X-Gm-Features: Ac12FXyPcuvcdoqbML0cHm0DtbPsjIcNIYXBwB1dJH4HTbLSLgdFPsEM4rOTfOU
Message-ID: <CADrL8HVEAUdg5eJrU+RveR1+s+9ArdO6wa7EntLQZMu_iwBm-w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] KVM: guest_memfd: use write for population
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:20=E2=80=AFAM Kalyazin, Nikita <kalyazin@amazon.co=
.uk> wrote:
>
> [ based on kvm/next ]
>
> Implement guest_memfd allocation and population via the write syscall.
> This is useful in non-CoCo use cases where the host can access guest
> memory.  Even though the same can also be achieved via userspace mapping
> and memcpying from userspace, write provides a more performant option
> because it does not need to set page tables and it does not cause a page
> fault for every page like memcpy would.  Note that memcpy cannot be
> accelerated via MADV_POPULATE_WRITE as it is  not supported by
> guest_memfd and relies on GUP.
>
> Populating 512MiB of guest_memfd on a x86 machine:
>  - via memcpy: 436 ms
>  - via write:  202 ms (-54%)

Silly question: can you remind me why this speed-up is important?

Also, I think we can get the same effect as MADV_POPULATE_WRITE just
by making a second VMA for the memory file and reading the first byte
of each page. Is that a viable strategy for your use case?

Seems fine to me to allow write() for guest_memfd anyway. :)

