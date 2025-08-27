Return-Path: <linux-kernel+bounces-787654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01401B37932
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAFC3B3747
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2929BD82;
	Wed, 27 Aug 2025 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BMoK2Pmw"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF130CDB8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269560; cv=none; b=LCcgiWxNlskxSQjyleLTCgZq8c9vbbutQlCviQGRIwKy8+Ptx3pTCPbvtBMrSoo8s37YrUDtk+S33sV2l30k0ZI02hBiEJVuVcufAGkTNBWJ9XMJ3Xnd2D9lkMUDUPI2mmRI1GOiaMvXOD/CcdtcsGHp6vsXukVjECToMHAmpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269560; c=relaxed/simple;
	bh=w+7fBvxT47NeKRh9CQXlGiFXV2435SxFc2o8eLwIHQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYEE6NiYzDebuvVTZ+3Vdo5vzRwlRfu5uz3n73ZZUl2qE32hW9ZPBu7uUoVk/kH7S1/a8JihFdjUC65uB7z1xfcoa5Jay72RAiTvcO7buYW8QjVmFgx8+ZgCFeT3KREu+1/Lq5UKp05EbAGd+zDbE6ZbtuFJz7/+5UScpo/Ya44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BMoK2Pmw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb731caaaso945867066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756269556; x=1756874356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+7fBvxT47NeKRh9CQXlGiFXV2435SxFc2o8eLwIHQI=;
        b=BMoK2PmwcxbkVnbOJlGaU1/WOpaPu1tfym9QV3SiZK6+9dDtyIq58MXid8cWZXIcFO
         5+lEgVKdq2r3Btv5ww9fNkrlllKkCme/bN6ccpuiNA+fa8I4fI7Nbf8w0fNaY1LUWby6
         URssehiKXC0ja8azZR9K78PTUam/hrgcP1AsTWyU3/v+tdwBynVlgjru2kplxe4pfCHa
         FPy7jPOcUoTC2wnyLTI4PcvgqFrx6wI6Tter3bVRE80cruC54oo5M4OmW+vJYHX8HN/O
         MOOFu9+cL+t6U/wVolO6z8+cTQf4qGuTIEfjZrfo2vzp2XPDYSwUWPAp1OVe9ruIg+k5
         dlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756269556; x=1756874356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+7fBvxT47NeKRh9CQXlGiFXV2435SxFc2o8eLwIHQI=;
        b=Uja+PGp/GdzNra/OCyBc37AxkWiBhx2BE0AkwzANVvTaFW3QYzZPnHfbOJhz89z/Wg
         fVsFGCJ7fLaRHMsxi+5tpJFCbnZmBoLHtUjiid8UiPEoYfp4FbZEqSfuyolvLkgxAKwP
         uc5SIwggnzKXRAqnQWmQEDYKvYe7DtT9PMkgAD+2jE5yLHcH8yI2HHUI+I5HYwEAe00N
         wCijcWdZXnquiYk896EPijKXXO7qxTQawadw8jp7r8ptlvNOPnLyiMo98dUeD1HuJLYj
         piHLvuCdVjjlOrL4tDt+aDQjuSJTVQC5xUmfJwAzRtzQwCroq4YUCuwihlAj6QV9nFKX
         9vUw==
X-Forwarded-Encrypted: i=1; AJvYcCWnI26WOCbHep9fC51NPaHdz2zl7Xt8N2mz2wiF9oU5uMurciGmFUBECADJwNlU8H2dNeEld0VBNuqcnAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oqMB33ST7+O/K1SreUvbS4PZY5/cjtTdQqOnJtPO8WniEfp7
	bPMHRt95FJhVbTskTYMLpcNU8PEEFOvh/iTBBMDZc4z/vP+yJUcSlbiKvm5fudQh44I9BPLCx6z
	ni+6+XuRItFkKDQ4unsjKB8nqctqy9C4gxGplc9O6Pw==
X-Gm-Gg: ASbGncsRVDNmIs8VP0BtK7raZmMcxSGbDuKnxSlRtup5SdM4XJCBcstAji0XLVDp9+F
	P4SzDNO6/+i/uXsu1HHh3B9195fkpRNXpY5rPc8JU7ovylKF+s6L8jckY3ueEaoMFYq7mnpQbmo
	JR0QA0+D1QCAEX1U+/eiBtaQYdXl/2meeOuk0vvkZM9mxfUed5b+MbvOcB5bFa4EToDWJTaFoy6
	UyfvbXnALgX4FeCB0q32OiWjBboWSOIK1M=
X-Google-Smtp-Source: AGHT+IE97GlDZp4rNLGJI6ZTg+hYR1b7CnMyx+z2FCJCMuiNi1PioDVA62DCq6B/1u63gklsj5nH3/G9ncmoy9kc7Zo=
X-Received: by 2002:a17:907:2d13:b0:afe:808b:5c95 with SMTP id
 a640c23a62f3a-afe808b8a84mr881326866b.40.1756269556468; Tue, 26 Aug 2025
 21:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826231626.218675-1-max.kellermann@ionos.com> <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
In-Reply-To: <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Aug 2025 06:39:05 +0200
X-Gm-Features: Ac12FXzpY-u6yuFQv7iqdAnYP_mskk-96iN3wzKzIr8xkcAak2TmC4qnsdFa8e0
Message-ID: <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return false
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:55=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> Isn't it a bug to call is_huge_zero_folio() before the huge_zero_folio
> has been created?

I have no idea, but folios_put_refs() calls it and I don't see why it
shouldn't be allowed to do that. What else should folios_put_refs()
do?

(Thanks Zi Yan, I'll send v2 with your suggestions.)

