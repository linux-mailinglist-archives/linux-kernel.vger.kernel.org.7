Return-Path: <linux-kernel+bounces-822031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7DB82E62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312377209CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B66274641;
	Thu, 18 Sep 2025 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PNBi5cJd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136192727EB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170611; cv=none; b=QLuTdcLQ9ojhqfPCkrlqhDTjQ5TZ8RrmRk74cFWayyqITL2qQF6wLgbvQg502ZTbT06JHiocdm1HPIPe4U36jMD9BE0EEYU88Pfn8blrTSFHeE1drR8ATf4ajCg0D3hP0ieuzuPvbY66OTwnRySzvGJCU8LcIy73OuAjP/a1lR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170611; c=relaxed/simple;
	bh=bvQKqbZUHSmC9Cgyqlv2yW20y6m1kbKZ+PzcmlxuJdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLQLDc1ii6RAEOf2bvrAETAv3vCGahZrPojTvMSiBNaQWbLI+gv1IUjbHtF/QUp10MtCwLow3EN166gF1VQv0IqAOMi6V+XSB/SCY3To5zMuMkAsQPSYhQM5m/8HOh8bfMLg1qb6BzU4rEIv2qEAdCd07T/i+ll/juV8WKsrdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PNBi5cJd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso67200166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758170607; x=1758775407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=PNBi5cJdKb61AR69OvOnVOEoyrnSW+Jt3k9rfHifyaHDfqLk3ptS1BvpdF7s9Awy9F
         LYiAS9VDemdh4t0hw+LfbNvUgY2qs8iqsBlZOBQg1UvMHpeFuldby4a9vhaWZpii0PQh
         2F+hg/AVVZ53AiT+o+/XelJr35ZQECe/OM0sxGaXVxiVzGdn9QYzqhefC6pmCGEB8dXF
         KjpJr0Xz5SPKJMMVrqVGdfZ+4yFgyPdDLNP0RQXdi6oJumbGczqIEM2WgZfN148p0Xpk
         GLpu5lYnraC+JB4opqDja1lDF97artNDYpERNrjlEvCZ5T12gn6wrHXGP+BjEJzocwlV
         ODnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758170607; x=1758775407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF2mZRwJKtzsGK7DJVHcrnEuIs9i65jp/kWrZEcj7/k=;
        b=rckr71Uem5aJistwcPmPZNKZbXFj+rzU+D67w1lLpg3WXy5wUZGaCGzTfeRKD9Y3Qi
         jStvKSZm2OOzEMBYNjHxSlnt4nkCqBr032kA1yQ8n1GMoz2L8aLyeUJAvL/QsCxEVnVT
         DIm3rzft8y2Ta+L0hVjJJmkTAWtFf/nnuXf+QFFHnp7cD2u2pWqIBj0T8e2DG25dRheB
         25LEhR8L0pSXKznz5IEwJGNBTb9GweY8YplE7+wfoVYyiGVkUSDYmbn7GCh5UPjuoiNm
         Qto3dBBrLFPdUJWz0HRfBEd0eddAgfiu9RZmEXinSKWoACBb99v3WA9ZuSnLNdvf1m5p
         U4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV7dj/+mYqMIZrr1Oy3CHV8e/kP7XIKQOvdyy3GUjJFoSMxxYUKX18aQtTDIFzDfe6w8qmTfXHrzSY2Y78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0uGzqW0+5IlkDBnmx3V9NZShdoNOMQAJatCoogc5tohdgJBb
	IKn9nBFeuTvdgJ2dr6hXlvXw6FMfXN1+8YYyTW0Cy7ls4nPBeWQUIN48AarUG1ayoqDu1IOSyeD
	LMc+rqJNTBxSDZqCn2EUNY8jrchFL9Fn/Rn7XcIY7rQ==
X-Gm-Gg: ASbGncuWCEn9FbASUrqr9BGLc6/0LpemvOlE4sTr1gOcTzdhE1mDdQtrCuaWuctnMMd
	c8RH/f0fdhQrmN/fU4fua8IejSVmQ9pf73Y2WVFgT8L0R1TQOan2VTWDHyGJvOxAl3t5TK8/B6/
	fm2/ih8KSe0hI0yxbnMRZ02FwYH7E/bnYklhXsvcJPXLjb7Z4rEdAksQVQLGHRO0oWzwnJ+p/Zu
	20DxcV8Ar08jyoLTvsB0WATDPvJTanWSsJgX5o2qMXwjKtSAyrS0jI=
X-Google-Smtp-Source: AGHT+IFdanVNfWfNv8HWsgTltRUqGbgVYdYb/7YWgH/k9KVu04DfDvwoBsaR56HasWl+Vm1bcuV82HMzZ0TGHEI2ctM=
X-Received: by 2002:a17:906:4fca:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b1bb17c9028mr565217566b.12.1758170607385; Wed, 17 Sep 2025
 21:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:43:15 +0200
X-Gm-Features: AS18NWC_NdTi_yqxzEjcc4DGgSbWqBjqdGn8xuCbd_fnQdBXhfAk81_WXjHssKE
Message-ID: <CAKPOu+9io3n=PzwFPPgmGSE0moe3KDbyp7MXmwx=xU=Hsvqrvw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.

No, it is necessary to have a minimal fix that is eligible for stable backp=
orts.

Of course, my patch is a kludge; this problem is much larger and a
general, global solution should be preferred. But my patch is minimal,
easy to understand, doesn't add overhead and piggybacks on an existing
Ceph feature (per-inode work) that is considered mature and stable.
It can be backported easily to 6.12 and 6.6 (with minor conflicts due
to renamed netfs functions in adjacent lines).

