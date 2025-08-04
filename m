Return-Path: <linux-kernel+bounces-755123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4994B1A18D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D601895A03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419925A631;
	Mon,  4 Aug 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="I7+SAhko"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04B25A350
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311147; cv=none; b=D1wQf0R9pl2ae7a7Mn8KS9SQa53UQI1rY5w1Lvo8agohMc+cIbzZircG9o+zF4Z5TCEb55lD0mIFKc8ehzGwIAF+XJgW6ooevHBFLvz0TSGizEVcy1KrdNaSQHYBRlXqNwxjU1sZtaD5AnmuNE7YU/Km/Q+/5rCYeBPJEYHqK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311147; c=relaxed/simple;
	bh=EBa3LJDotoq7e64FNgS2F6Sc5LW3ILO1eZ5TiKEqHeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewm6WfkGKF6CgL2qAorrOAzwUwtad9hVB7S3LMLih+VKhpvPN/+bD5vFt2cChPcYbm4x7gCl3oCy7+BrY7WwBemJx/48zPo6q1aFloGbO8pQ97Lzl13fTaYZ2IS2IjZux0qnhzt9jMh335OeMs91fBxw075/FQWoHfosZr29QrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=I7+SAhko; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso4091657a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1754311143; x=1754915943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKCj6FOnfKnqynF1p18ufhjCbVSDwmBzNnZjJrqA/Zs=;
        b=I7+SAhkoRETkKjCHkuhA+TVrAXZ4ic/BAN/TPXJNmSQIhce0uvleHhjkodyslRcQi2
         n2o4/aQGwzyjUEn+Zu7xVYcIFCq0RP3CaCKYxSU65+IM8luR73o8/VYd/C1w9+a+VFhT
         tuwQ6lhxmRYikETFVP7Y9H3QJiK8PhXFEGyNDUSygj/cPvptgFVxjAvUzlZA2ZsYSqUs
         GXz4MOPxcr5ZbsSU1K/e98CmyEhw2RZRZphstOroh1npdB2vGdJ5p8ao3wrAF6qMBAKn
         xSkpvOWTDZH6BQiBxn45Zr2UJPk0GC4cgQAeGqKCwLa/lChoLcvVr3TMsGNxtUKj1wXi
         PiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311143; x=1754915943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKCj6FOnfKnqynF1p18ufhjCbVSDwmBzNnZjJrqA/Zs=;
        b=eGwWQTK0xBx1DckbbbYovWRcXCVDw4wvuB5KRcPalJtEEREb7+1hSYs3jfGOdQH08C
         m51PENjkzawLj6r+Ep/JWxKrncoLP1zkanwkVKi6+oiy9X0uWBr3fuoedJDw4LdbRlNq
         N1JRdQ6ZRLAZKgLrZsRhvO3SLSok/93iOUAEts1gyoLkt+vS1Sjw2RKjHPu85AEifvIN
         LW1Ov8hdb2Ng0+5uo7gPGIjLVJHoV4hhmlU8L4l/F5/qYLsiJdx5fZKn6SqWm5ZfMIS+
         c1H8V/0aRNEvFemsd0356cN4tG5xzG1dntNYrR0BmZn3JMs352CBeGhtM90EpGY4C8VF
         0qXg==
X-Forwarded-Encrypted: i=1; AJvYcCVNJTrPdQjgIJlKLJBApMn4U48LBqZDoPkCwlESXGm9TJnujR4hI4xH5FTurJQZ0yKm0NEJR4JQSk9Dwqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCLsbdi4/wxTjAjX8A9PHOMs+abvW7ORz14b9mi6/CoHgJlvW
	KN2iPrvMiJOUCtkOo1RHKvA7hMVRPmqY+6E7YOxPj+SB3wTEZOXwkBIcwY9/yk7hfNamnEnyi1q
	7XJqp7I9S7ODCP5aLYXkR+4/zArKYLF2ZVbn/JFmk8TWHfDHa/TEKKW3cFyg=
X-Gm-Gg: ASbGncsMwgAEof2Vb4nJ16HdPDo7f1jMCObq1wqC9GDP44bYbMJMsmSnvEJp1556th2
	98J+8lBTe15WxOsCwHt8bPWjMNy4iXQrnlBkoztT1h9ufeHSAg1+McZBkRfmZHnw+ikvg4HEcgb
	MrWJ01BOur6LF9zyZBWg8PwWBlWpzocsfYgRnxfsxli8BLVwKqhXBQu3HKXSxJroqeeOmMqBTdD
	tbjPgVMPa+Yg18ise8c61YMeTn9eAH5J2im14GWUxcKEw/K1tIVOcvXQX2mTYh242WSKO8DJANl
	VfxZQSEXyY9Y0dfKJbBG+kAWOHpYf/8Dz5vtlkLN/xkp4YbupHV2lbg5K3PYwsffXnFmzuix8bw
	C1iJKyC1c/0IzNh6lqZqNFCTodHdIqnWiUkMUUP3S1omf3V8v9YGcmwML7MeObe2YQBCatgw=
X-Google-Smtp-Source: AGHT+IFzfwXuQNe+jvCRtHRgBNrc6qR/ahRDyVponjDa59epA2QL+D64gAB3pXkW9DcRv6GRw24e4g==
X-Received: by 2002:a17:90b:1d8a:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-321161ec88fmr13406605a91.9.1754311143029;
        Mon, 04 Aug 2025 05:39:03 -0700 (PDT)
Received: from zenbook (1-162-100-196.dynamic-ip.hinet.net. [1.162.100.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49e0sm14418422a91.24.2025.08.04.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:39:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 20:41:35 +0800
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Sebastian Ene <sebastianene@google.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
Message-ID: <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>
References: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
 <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi Anshuman,

On Sun, Aug 03, 2025 at 07:33:04PM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/08/25 4:10 PM, Wei-Lin Chang wrote:
> > Currently the guest stage-2 page table dump has the executable attribute
> > printed in reverse, showing "X" for a non-executable region and showing
> > " " for an executable one. This is caused by misjudgement of which
> > string gets printed for the executable and non-executable case. Fix it
> > by swapping the two strings.
> > 
> > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> > ---
> >  arch/arm64/kvm/ptdump.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > index 098416d7e5c25..99fc13f1c11fb 100644
> > --- a/arch/arm64/kvm/ptdump.c
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
> >  	}, {
> >  		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> >  		.val	= PTE_VALID,
> > -		.set	= " ",
> > -		.clear	= "X",
> > +		.set	= "X",
> > +		.clear	= " ",
> >  	}, {
> >  		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> >  		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> 
> Is not KVM_PTE_LEAF_ATTR_HI_S2_XN already in the reverse semantics aka
> XN (Execute Never). Hence when KVM_PTE_LEAF_ATTR_HI_S2_XN macro is set
> that means the entry is not executable and vice versa.

Yes you are correct. However in dump_prot() we have:

if ((st->current_prot & bits->mask) == bits->val)
	s = bits->set;
else
	s = bits->clear;

Analysis:

1. region is executable:
    - st->current_prot == PTE_VALID (ignore other bits)
    - st->current_prot & bits->mask gets PTE_VALID
    - if condition is true (.val is PTE_VALID)
    - prints bits->set

2. region is not executable:
    - st->current_prot == KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID
    - st->current_prot & bits->mask gets (KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID)
    - if condition is false
    - prints bits->clear

Therefore we want .set = "X", and .clear = " ".

Thanks,
Wei-Lin Chang

