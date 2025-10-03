Return-Path: <linux-kernel+bounces-841795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD6BB83FE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31724347DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086222737FB;
	Fri,  3 Oct 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFrWvEH5"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0719D07E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528762; cv=none; b=Yh5lqC6rp8zU+oDgN9W2uUr4Mhq0qo3Oy2IZJH/n7GntkRFUsFU+9JLP4G/izPDg+8com1mhW0p8dCG5T/kHZraFHvAjxslpwYnTFAF7PumSUhjumbSr8wnEtdOY8pqZWszK63e6C6AABcaRnORVsFq6vN8h/LkqhXqWCaEeM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528762; c=relaxed/simple;
	bh=nib9C3/rcd02W6xZJ7LkaKrPJNvwyfF5OE8SI6ooKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo+8HcRSdmmJfZso6RqWkJlfnjmv+i3BmNHS9ugch0ed7yCsaAxfl4ZVv2rrW9w2x+rJdbfoBIvuiTOt8HMJq4klX05ZiACLH5G9s+oEn/Zrmd3VBzlDptxf8zijPgKah9WbqDBXchmh0GIf4CckMjnKO+bpz5OlqnWiXE8+4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFrWvEH5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-362acd22c78so25893881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759528759; x=1760133559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nib9C3/rcd02W6xZJ7LkaKrPJNvwyfF5OE8SI6ooKmA=;
        b=RFrWvEH5g4yPz5IA4OsyMprQs8dKvtMy0DZdFBKOQ2jv13NqFUYvn/udaY8JLbgPoC
         AAP76ik7Msw8iMuSFwmWPGFAFiuSeDTvUN93Ei64hHwa+SURnMl55mcj0ILzoXryCiGk
         CijDaRLFgPvEEOy2gNStpigrCowVIqm2t66Im1gykm4O+hFGHKxjz7q/Pk0/IQqCyDbq
         VMbRAhuFWpR5sZFv6OQTo6kR5bPUp+8OUPHlvG43IsVlbi7qRZ7nbfPZFoj8HfAoFt2x
         uHuRXHReqxpjMGQtP4NZURW1UU/i+Wbg+QdFxe0eYqPCHxFYkI11lAkRVJn7RK25U9yh
         QBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759528759; x=1760133559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nib9C3/rcd02W6xZJ7LkaKrPJNvwyfF5OE8SI6ooKmA=;
        b=u16cYxw5mXKfz5HJz5MYWe6lB/VZwr6NyQW1JWEX/XUPYFeD6XXWK/xPF9wK9aZ/9M
         91JV8ckuX6E/hlUtN4rZWFh3G1t8p0tGMX826fokwL1Njs4CB3zTEEALuqlF/V05rwcZ
         ++WvdYBfN6qx43kBirG8rw2kb8LXg+Pt0FaLTirRx7Z63PvmykrTzEulfFZ3pj5yO0Db
         s5CGlMaiQ0RgM2Awl9NRvzODsU544G2R/Okg+lQP3dafbMDX+4MNF5Q7iU5N8u+PlfCk
         2YNOtJNsmsnxuomI2mW5Ppyx/d3+SHbSB+h0fLllMNpbpnBUL05k/BUkmlb5lwlr4B8c
         S33g==
X-Forwarded-Encrypted: i=1; AJvYcCX537lKwwtD01k0Bgn/lw82HSxX16v948uBX5uSxtYpOM/4WIj7JJ4J5OS7uwM0+ZbaZ5TvN23rmp3p0S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWwnOmHvxvDNA4D0Qch8LZVx38YFkPL/LZSkClcOmRbDLbryS
	ncwNGwwcZutL5kSirOucEZ5R6yYb8/BpFOHKNHJ9SFL78O7ieJOTFe8tVQE3HTFdUQcLJUTLigx
	IVlVSh8BYWT4yvl/9NoSqczUmO+DkRE1hURdN+mFu
X-Gm-Gg: ASbGncu/zTp0zdgJ2z9rZJkiaJ7/WcZG7qbz7NJ6hcUZrG1HSIdc2Mdm1Q3PYCck9Ay
	X18hLjePecmOq9tJeMiEeIfg1sNpJOtshFOplh1A6zufz3lN74iD+UFS6Ks+FtCpHrwDpBmwnvo
	35Fpo4wgNN6Ar5Jc7wMQSvX64hQ9UFsiRKF75lbH2LKbmdhqfEU7fHwM4KpgzFLoU5jXJDuiYDB
	mnOkoXSB6u5ycAtJdnWYWqkJocojK3UUSxNKA==
X-Google-Smtp-Source: AGHT+IEMNg6CoAajvcCU0A8xtPWLVnf5HdngIn6ZHBFxx+djGz5FVdHieLvKMnvZdWuOpGYQ0d0l0Tj1+04P2Eh2PdE=
X-Received: by 2002:a05:651c:19aa:b0:373:aad7:31f2 with SMTP id
 38308e7fff4ca-374c379588amr14913971fa.23.1759528758345; Fri, 03 Oct 2025
 14:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924141018.80202-1-mngyadam@amazon.de>
In-Reply-To: <20250924141018.80202-1-mngyadam@amazon.de>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 14:58:50 -0700
X-Gm-Features: AS18NWDcr5c0NIJb9Kxt-214GkRLwoy_fzC7kFxfFFbrSmCWeHMbUT6OysE2-vw
Message-ID: <CALzav=cRjQedF_g7qkJfrAtUEZKsME5=QpC+C6B7-nB_j-jc_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: Add alias region uapi for device feature
To: Mahmoud Adam <mngyadam@amazon.de>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, jgg@ziepe.ca, 
	kbusch@kernel.org, benh@kernel.crashing.org, 
	David Woodhouse <dwmw@amazon.co.uk>, pravkmr@amazon.de, nagy@khwaternagy.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:11=E2=80=AFAM Mahmoud Adam <mngyadam@amazon.de> w=
rote:
>
> This adds two new region flags:
> - VFIO_REGION_INFO_FLAG_ALIAS: set on alias regions.
> - VFIO_REGION_INFO_FLAG_WC: indicates WC is in effect for that region.

Once you settle on a uAPI, this would be a good candidate for some
VFIO selftests coverage [1][2].

Assuming the uAPI supports setting up equivalent aliases of BARs, you
can use the VFIO selftests driver framework to drive some meaningful
usage of the aliases. For example, you could write a test that
overrides bars[n].vaddr in struct vfio_pci_device to force the drivers
to use aliased BARs that you set up and mmapped, and make sure the
device can still perform memcpys as it should afterward.

But regardless, there is still plenty of opportunity for sanity tests
that verify the new ioctls fail and succeed when they should, and that
mmap works as expected.

Meaningfully verifying that VFIO_REGION_INFO_FLAG_WC is being applied
correctly might be a challenge.

[1] https://lore.kernel.org/kvm/20250822212518.4156428-1-dmatlack@google.co=
m/
[2] https://lore.kernel.org/kvm/20250930124221.39523455.alex.williamson@red=
hat.com/

