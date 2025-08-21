Return-Path: <linux-kernel+bounces-779614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFBCB2F656
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE83AC32B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F530EF99;
	Thu, 21 Aug 2025 11:16:00 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF830F533
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774960; cv=none; b=MzYX0DQ4zf2Um3kiOX4wvhL8QFI4DBVdOm4gXbjaizxoW2dVp36Ic3XFu0iufXTWTDtw4AQ2DaaF9+SoDU+rx2HG6rwgf0r3MPVhTygGbLFaLP4erKmilArLQq5eLGpzkeuuJhwNb5YbZxVqeO8tgtoRaCvd0fdigr/QixWI/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774960; c=relaxed/simple;
	bh=r86/3cZ1lEssYvpNeEqf3niNltUhFe5nM9753NcJQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqLtmvdejpRBCCbEfmfDpsw+VrB+OOYHf9V35MpWsdgXr3y4hdYlUPQ5R1U227xr5KABMXUpRSP3oJpYEfQ99m6qB/808gtPluIEtaL3gS5NFQfQnihqz5zE1KBkqj/gDhuxwg0VUl0DYXOf6VNQj+HrSy43GPgaXl3VwWt6iH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso1639956a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774957; x=1756379757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axTNOUTQVZZZxxYvV2Ucn/Ve6zfD/t7Lm0soOa7g4cs=;
        b=FSyO6WyHlxcKFV82uREMrK9/diWg+1j5r/m/wXo6RzjRLkerOpjzvwplatoZveItNp
         cGpsow/0o5b/AoivIMXveXjvP1J61OxfdD+FHANS50uLw/OFDXLS9PF6lmtlXIIW5tvc
         n839kLMtVWsVr84sdnASaywdhQqGvpm+6cS2wmrEkmBHupofpy1MUSWNy/KZBMlmhV1u
         CyV1dfExt9ygVALcZfKlgP48BOJnuLKDVN8QbDvgEnrSYU2wqHEYVYvFMn7yaVubQ9pH
         qcF53S84AV77U9N8GN1Hr90LP03pOgWJLA/gG3WhlfXfQ6UX+I4GvpzDtrD19ISkiF4V
         PdUw==
X-Forwarded-Encrypted: i=1; AJvYcCW8FLNH7r7AzT6/OEUUZMqthUm46hplNz8tvsJUekxpna0+8OVCNZOnD1tnr1IyPj1jjTdfByn5NWbEuHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxAzX3XzIEe/Fr8+FpQueaMY47S+HtoKxQQOrEy2woK8PFRdt
	0t9/Vd57OR1ZZhJrCBka8QTyHcKKQXxXI3/UcVjkSlnO6tCSIQ5zLTg7Vf9BdQ==
X-Gm-Gg: ASbGncuazdqfTlsA9n7PPENWyBP6ELfDSW2iMaFpq1Y2gHogPWgCsNjzroOfMLWAohc
	nUMAGTORhPKa1eoZSPeXYbzqAPUPjoost7jPfYEuJkMeaxZqBIn9V/VwfH8qn3TyPQ0dU7O9A7o
	oN9othzgFAYANq3oL8xV91uXHKAVQezxi0bJmiXg+csaB8tZZiJSTtKoFhciG26p1LZyVlapZX9
	WpzIAjjpt16EDhAhVod2sNCyZReN70VrjROTA874A1VTNVGga8ToczZqr5VgqkR7NP+/u69y56W
	qWN6o4sbGTpX47fmdV7z5PPmuom5UW3vdYAKMNuXFCGxIoG1t4rT8wP9/vPYjB5qnLqLy5OCPBV
	YYdEzD9pW86zzGyjpDV7E1j0=
X-Google-Smtp-Source: AGHT+IH7uKkB4TPA3GI29kWft+2WfvQbVTEYpnr53DPMR4wVW9z+xmrLVH5anbUFBjplHLTY2Uec5A==
X-Received: by 2002:a17:906:fe44:b0:ae0:35fb:5c83 with SMTP id a640c23a62f3a-afe079f445bmr205983166b.28.1755774956383;
        Thu, 21 Aug 2025 04:15:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2ba366sm369932366b.19.2025.08.21.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:15:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:15:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502011246.99238-2-coxu@redhat.com>

Hello Coiby,

On Fri, May 02, 2025 at 09:12:35AM +0800, Coiby Xu wrote:
> +static inline void kexec_random_range_start(unsigned long start,
> +					    unsigned long end,
> +					    struct kexec_buf *kbuf,
> +					    unsigned long *temp_start)
> +{
> +	unsigned short i;
> +
> +	if (kbuf->random) {
> +		get_random_bytes(&i, sizeof(unsigned short));
> +		*temp_start = start + (end - start) / USHRT_MAX * i;
> +	}
> +}

On arm64, I am getting the following UBSAN warning when accessing
kbuf->random:

[   32.362428] ------------[ cut here ]------------
[   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
[   32.362649] load of value 252 is not a valid value for type '_Bool'

and line 210 is your `if (kbuf->random)`.

Basically kbuf was not initialized in arm hosts, and probably has
garbage.

I am wondering if we should have something like , while the support for arm64 is
not done:

commit 2608bd8c26b62a9a7cc50106e93d3a1ffb1e1188
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Aug 21 04:11:21 2025 -0700

    Initialize the random field of kbuf to zero in the ARM64 kexec image loader

    Ads an explicit initialization for the random member of the kbuf
    structure within the image_load function in
    arch/arm64/kernel/kexec_image.c. Setting kbuf.random to zero ensures
    a deterministic and clean starting state for the buffer used during
    kernel image loading, avoiding this UBSAN issue later, when kbuf.random
    is read.

            [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
            [   32.362649] load of value 252 is not a valid value for type '_Bool'

    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee8..287b25e674d76 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
 	kbuf.buf_min = 0;
 	kbuf.buf_max = ULONG_MAX;
 	kbuf.top_down = false;
+	kbuf.random = 0;

 	kbuf.buffer = kernel;
 	kbuf.bufsz = kernel_len;



