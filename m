Return-Path: <linux-kernel+bounces-845823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C8BC63A1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053824EA626
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804F2BEFF0;
	Wed,  8 Oct 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpLahZtw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB219E7F7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946383; cv=none; b=Fi5sZVW2IGeW138ygr1gre97ZaKNEw7CmjfIyBrKgfHwZqFeYKIH3C2bwftfuS7647MD7dqXrZq9tq8JmEMWfm7mgWFupLTem8g+43xoX8X2KvG5+E85XMoyB0xdei1dn5aTreddDcX58SxYCaE34IumYc9H0RGOdt+nq1jUhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946383; c=relaxed/simple;
	bh=mbw4U7o0gDjZYLKWaZi8mJbKFXHtZWAeG2KA8oeIdn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i21bHvEN4NIjYnBsCLHqssf6n8KEpvw6reXA+9/cQE8lWp9WrViqNxtfy8MXnBKo3tFNImkzY1ZFzUVsYJw5xuStN/rq6lvKzcEz+Mc84UVboz6naOInU+ED162JPBYGV2/g2mDDW7foJI17QYh+gSIXHVq4i4mWdFljkd5/a3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpLahZtw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so860355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759946380; x=1760551180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4KMzvetLm4Fr+s7TfComD4+hPnzZgOsbtBlAc/YQSE=;
        b=MpLahZtwdWr8q8ZuZrGZJlzvhYny3NEU1asX37dn6+sB77vH+KZWfUXYFd58Pl2vib
         zsnX9LMr2DuVbh0h7cJ6rvE+pPJQ/qookNlzdFqq4PKPI2qubuBwUcSeQyJC0qZ3KkQC
         OU2AGIC6GxiXXIZcweBU8MXbbY1023oOrvzoUuWyVau2VP98pW7FPsBzNrqrcc0dvHYy
         sYf/63PCRcSHPyy5ph1vxASVA7qBmNmbczTOZGqGdJL8iGuIe2pPXyh3KkU0lStCXgMV
         mYhlffM8yTiFu36oK2yo0xAa/AAtTLRPFcV+MRfxS6KpqQEqPQ5grPoZvhd9BikJiod+
         wA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946380; x=1760551180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4KMzvetLm4Fr+s7TfComD4+hPnzZgOsbtBlAc/YQSE=;
        b=n8befz6BNjp8faUYZ1xdIMk8Ft8yB2X/AmI/yONMGY+9NioDkvgqByLICRsNCsz4ie
         YDznI2vY34xY+lSCoqClVy47tUSg85OTa/DslrFd4R3UATcNohQWa2G6rdAaiNmgTIXA
         72EpJ3Ap1JS78XqHwsUogk1hcRj+WmuQWmHgFsU8mgB/nK5GIq7vUAGzXrl9G5QQtuao
         geN2wW9SgRcAS9bx4xDlrE/YHKETZU5eAGJcHo1XoUJastOa67qSNHinR0xg++lNitDa
         lvvt8AP7wE0x6RWQqeX2V6gwTEEn7ShH7G1wk0BlS3q7TDQhk2FFKKY1lOsLcaKkfFGY
         Wfew==
X-Forwarded-Encrypted: i=1; AJvYcCVq4QTdeJOAuJSJEAh32Z9j5MZdV9loXT/w/6SEHYfH8qCxfdOd3yl1kf8eAEkyjDfJscsDr/aOL9WtOZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+DZIW6uP95eIEpd39R3vV1CojLCq0GDyed9Ct4LJGT6C67Kl
	ty7LDasJZ2CNv3NiMERwFQ93ikQcUO1cAoxgBPjfjU8459PQwuIP9M/JD+XkvZvK0vpzxgSq7Pj
	AGBDXdELdWoQC0M9QFhww5Poql4bk7Fc=
X-Gm-Gg: ASbGncuhFZlBVrhcatutCsMtj0vKcQ/PCMMEdbGoRUutJKlUUYigqFRHL81vhDjzLol
	L8MBwV0T+uwP+sJ5s32ENulxjAtsSnTlj4VKn2r0Q4wKkb45EptbSPj9Ea6kXp4P+qXWEjm1X2U
	KkWRWOjqHGiD31rj2Jsde4Dgj4u77NiZzkJ7DXQhPL0xIEiQ0zFPraVY2l8/1WRo57c80k80aHK
	twpA+aHTyqn5ZIoSc2cQWWAf+Bb1ZDd0vxZ3QfczA==
X-Google-Smtp-Source: AGHT+IHtL0KOVOKNLlIeSlInpWJTE/TPrTabMwA574I5VxH1lyBXgMOecBg0iKJOGtptnGSTnD9bSOmqK3DPheF4dX8=
X-Received: by 2002:a05:6000:2681:b0:425:7153:80af with SMTP id
 ffacd0b85a97d-4266e8dab65mr2663968f8f.49.1759946379883; Wed, 08 Oct 2025
 10:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910144653.212066-1-bharata@amd.com> <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F> <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
In-Reply-To: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Wed, 8 Oct 2025 10:59:01 -0700
X-Gm-Features: AS18NWANBul6dbj_HkmY5fIi05_D6Oecvga0iBOa6pPxhI_sCfcpoYxSf9FgW9E
Message-ID: <CAEZ6=UOXG2Ju9P4-gYKnzZeyV2PAQoCA70QtmxEBJ-Dqc=0tdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
To: David Rientjes <rientjes@google.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>, 
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jonathan.Cameron@huawei.com, dave.hansen@intel.com, hannes@cmpxchg.org, 
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org, 
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org, weixugc@google.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Sep 16, 2025 at 1:28=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> I've been pretty focused on the promotion story here rather than demotion
> because of how responsive it needs to be.  Harvesting the page table
> accessed bits or waiting on a sliding window through NUMA Balancing (even
> NUMAB=3D2) is not as responsive as needed for very fast promotion to top
> tier memory, hence things like the CHMU (or PEBS or IBS etc).

First, thanks for sharing your thoughts on the promotion
responsiveness challenges, definitely a critical aspect for tiering
strategies.

We recently put together a preliminary report using our experimental
HW that I believe could be relevant to the ongoing discussions:
A Limits Study of Memory-side Tiering Telemetry:
https://arxiv.org/abs/2508.09351

It's essentially an initial step toward quantifying the benefits of
HMU on the memory side, aiming to compare promotion quality (e.g.,
hotness coverage and accuracy) across HMU, PEBS-based promotion, and
NUMA balancing (promotion path).
Hopefully, this kind of work can help us better understand some of the
trade-offs being discussed, support more data-driven comparisons, and
spark more fruitful discussions...

Best,
Vinicius

