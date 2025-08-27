Return-Path: <linux-kernel+bounces-788520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F742B385BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85673ABDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7127054A;
	Wed, 27 Aug 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HE61rAd1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546B17E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307137; cv=none; b=Ac7W8ezLYfOmkph4wp0NGA3HHG9UTVu6+CkOWGqcwW+KDE6whoGCXtaqPc3khxGhAzv7cmnez0F967/i4hzjlZXSMy2XNF//uX0ltwmHe5kk048qTcNBWSmPeSCrwwCmxfH52TkMALqkZZnUhFpdthKWXYjHiFZ3NqKpBjZUyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307137; c=relaxed/simple;
	bh=FhSXA1eBN3oDPuVrp59TqMHXsvUj8E64vbrfTqno8g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8Q1DUFsdHaLdM6i38DBgyH6suLgKXLy9DTWcRotyNINafs8B71SdwgedYJ7qt2T3LjRboerV9fgI84bYNOKxUIBNFlFLg1l0lAHuW2tpOj/GGbpK6NA8KEzExrLLr8sVdiRjjFehxhZU+SkrVgWkMbD312054P2I0CHbzDT17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HE61rAd1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so1025504666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756307134; x=1756911934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhSXA1eBN3oDPuVrp59TqMHXsvUj8E64vbrfTqno8g8=;
        b=HE61rAd1lzlL1tFYu+J2bV3lzP8+UzmeOLUng4sLKIZjr68wTdWGqZuP5eR0bkHhKN
         tH97e7goc29kDQzQT8sUgtIsVWJxr+5zcqVqgdwWtWaQoK2nhvPn+44SQMVrmShSzY+j
         d42SSnYz+FoisyMYACzJ/roZ7XjbyuyLQpeou20F2S1J+lXGsSvFx6l7OdwHhgiuMHtN
         7G63j2celaeWAmX67UfvSXQPRMBwGr9eGsCBlEtcPxQ8pZQ4/v+Sk0RmyqoE+Sc28Wy6
         hwLwsiBqh8hFZewfXKC0Jyafzgy+P7mpaIrkUEB9kc1iFPh4UuWxtmbkFoVGHIZYzUgV
         MuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307134; x=1756911934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhSXA1eBN3oDPuVrp59TqMHXsvUj8E64vbrfTqno8g8=;
        b=S+GalfQOgOHJLbYG2FjJ0Kx57SyCdrc9tjRHsCS0z+A260zT1i0b3p0YL3zbNhR1Vy
         oK3wdbuYp7fiPCLYM58Pwvhk63H0pVzMFXFXB5oXJi2MSZpYqhycb4RNukECFr2/A8eX
         JdYPVKIIuMMC7Lh4olJ4Hxv2LWHlm3rr7tXjMAYK+KDzKp8mmZP+1sGjaprDrDCVGbnC
         MjrJ9zFwnkPmKyVzydAB7plproTR5T3UwfWU/3hsnWRT2Bx4/rqWY039e19urSUJZI1a
         Py36JW4PAXKKMMO2ZxZ7fk5HJqP1Ubfx/xOBkVuUci58FDrzbXCAHW1HrNj9zlit5sij
         t5/A==
X-Forwarded-Encrypted: i=1; AJvYcCVX9JpM7N/oCYcXzOkoBplbKCzse9nyzN/B7yWlJPyhQilyiz60SO1is9TxJfqzR+D6frj8yf4HzuPRBnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYM9TrVp2XXWjgS4k1tE0ue2Ltdq9k+HASgp6igFcwfFC0p95e
	n2P2pbqE2AucsnVWWRE3Zi1zT+RhcOEqjowbSXXGzTssZQOhs7oeORQ0+LPYe75u0I0Abpu9cH8
	mPwE3kaBDhnRGVvo7/qCj0FOeHH4p8mpWZCh2OGLa0A==
X-Gm-Gg: ASbGnctaAePNzbXUR1ruug55QImW/I44W1y9bvVrpY3dIH3Ftqh76tdxYkuI3f9OqRd
	HVa9iERTFsIs/wSHUhyrMW5PvZCqyLIedNvKb17xso+MYRbLp0/+rbFVEWCTsJ/AP0zQpghTE9k
	fd+F/ArtXW/uvI98Oz0ngZBV0UCkJXhC5AqAg0gJ9gmoJ72Vw/a5LLWRH+7iOT2zhj09Xr10JB/
	UrTFSHteKeySk6TuB5vnQ/Aq+p36KsW7GA=
X-Google-Smtp-Source: AGHT+IE6xzYxJ+pVDoA39WuUHLJ27/IMu9NOdCgtBLgruePT80zH4d4j5lHRG8no/rTlrdtPbbb2tg0xpEAitC+X7BA=
X-Received: by 2002:a17:906:d103:b0:afe:7027:56f9 with SMTP id
 a640c23a62f3a-afe70275e3amr1046008166b.17.1756307134403; Wed, 27 Aug 2025
 08:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
 <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com> <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
 <11a5d391-3a13-4376-98f1-34b529d3c583@redhat.com> <CAKPOu+9j5+w6ydvygdWnryZM24AFPSVJB_21VH8Odi_xdrNksg@mail.gmail.com>
 <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
In-Reply-To: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Aug 2025 17:05:23 +0200
X-Gm-Features: Ac12FXw8IqVqehkIMKejb4kYAyB8VmKAH7ycfxA8rdmI1TSZowZtPojbuiaWO8g
Message-ID: <CAKPOu+8O1GroB0KDGcwE2ByugaTm_MsoU2c5NQAbk1NpYOo8Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return false
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:34=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> VM_WARN_ON_ONCE(!folio);
>
> Should allow for catching such bugs without causing any runtime overhead
> on non-debug kernels.

Aye. I have posted v2 of this patch and I have dropped the
folios_put_refs() patch.

