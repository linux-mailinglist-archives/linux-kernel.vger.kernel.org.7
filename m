Return-Path: <linux-kernel+bounces-764714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1CFB22665
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E861B62DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DFB2EF671;
	Tue, 12 Aug 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fnqBO4Cc"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5132EF669
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000661; cv=none; b=Lt+1HMeXtd/3C+FC0s6C5gvJQnitLw4OquJCkOXGaiQQsfH1l2pxX/2zGwic5YKG7y5FBmk1M4WR+Gsvb8WNCmKRzMfo+YR7Z3nPkoJVSKd46P93rCqXSnANt5n1gdeAeCG0LQbSBWxxwrpT1QrZ/ok+sbEWx7aohlhZIk18bSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000661; c=relaxed/simple;
	bh=8RBunKxUBb1Vj6PE5YuHmQTGXjBTAJn/u9sUy0q/u4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+zOcDqu7zLAdZN6WITfGL8nZe7UMwSiNyYHqsw66LXoWNgjThn24YR9Cj3BTkp3Tmu0NuCrcNUp291EzOBaV+e4JgjDVP25bJDqbkmzuseBp4CiI05Yu2kVIuRC6iRF2V7o6Egnv5R52nQdI6Xs7ZCbwXOu1HyUJdyybD3p5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fnqBO4Cc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e81074ae83so580426685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755000659; x=1755605459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwzt5hp60I9xGcEL67DVrhF5ur9a/Ie7/jOy3595NAw=;
        b=fnqBO4CcO/XgeexWcq+MMXX3ICcG1QCBZU11IoS0lKn1lJCebM31ZmFwgv/PIjrYb/
         RaMjXD88D0OpP18ntGUjXWAcNmvr8QiHqUEvzoe2rDMepoRE4RDWPbCs0bJ3GP4OYV46
         J96CGN9qmZBRDzCzyquF+zcHOB2eO0JWKyo3rOfCGGVUhav2RdOgAMDCPIl2upL4HTp/
         CKM1Lg2WAZkKS/COmy2jTn+33gmkBtCFJvJAuFp2zKqMdZzAfN+h3u2XgqCwu3WhPwCj
         tmtKhlQPKbWsisf8muSYxLT1uQDxDgnixJMhTGqLgM4ycv5Lq/0b46ItCeHouK+cNwy+
         +3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000659; x=1755605459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwzt5hp60I9xGcEL67DVrhF5ur9a/Ie7/jOy3595NAw=;
        b=dakyOY0TJSbsDuhWB3QhJ/U97kkwzOK8ATRfZOexZtXNHaaQB5Ueh5YaJ4x6gBthk4
         w7Y6/w8k5STqZSAqj4ggJSP+JsKtHpItia18ix+L1aBMM5d5PLs2dhSgvANhzVIcjzC7
         u/8mJhp4NUAkuwnfvuqji1Z5RXSmd8FHKPYGl20B+mbCbAcSOtryv/4VuNiShBbOZyEp
         +C9gyzx7xcDyTjoLypkSPwH1FNkweKljy3fahg0UAbAM7Q+GL1uWgWOIrwm4XD5HlwPC
         YWR+niMrRZS0jcakIxg0GFojCFwTqqybSoBLNMLgx6KM3fbXZPjPn0N7nlov6T9kKmcw
         Mw3A==
X-Gm-Message-State: AOJu0YzF6LiiyhpV4fy9MTsGId0Gykq5U5Xk7nmmBCB6RNDvp+XVRBYM
	I5yX8A0HiP2/GiJT/hiDJl9vDCM3q6jozPEbbuVY3IKHLUCze/CLx/0a8APMjobjvYk=
X-Gm-Gg: ASbGncsKzlVhoB4Q4BMPyn3QKXRzObaUdZA+fYtApUMwdM1I7N7GvEsT45AGE1/D6G/
	gm1Gfoh3ip7AQSmDi5WX5ssNtsrAUGWec60+Sz2PURVhMMzQjUAG1+0+28K9iFliPv/JvHpVkEj
	Uepq5gn1PsTAM2hGtak79py5tcfnkqtbJygneuRdIegR0Q7YKzhTtT8D7dXDjM3OVGemtK8SH4f
	r6EhU87ADUPFygsy1auROaPaw7PSO1eO/NR+Ddc6RITMiGOY2iUhY0q9awE0wZUeyEWbbecQp/Z
	NTlbAwhAY4XHNLHCjktyo/lk6Idpdbw89hflBrqsbSmzRjjTyIl5xg1UnQaG0Wl6F5Ib6xOZxnl
	6kTUfvsr+0pFtmDiHTO9ca3ul8b+LcqiBG7ikX3pbajyBEsPuWdA8m6oPTrpkA5fctZPK
X-Google-Smtp-Source: AGHT+IHpaffqwwD2Z9E3cXc4Gk+qNtr0gNf1UVekaIiTZnryNrm4aWl3gQcM0mkfqjTsmCyn653LSw==
X-Received: by 2002:a05:620a:831b:b0:7e3:4740:3d3a with SMTP id af79cd13be357-7e8588d7a35mr401586685a.55.1755000658513;
        Tue, 12 Aug 2025 05:10:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f72f75asm1760951185a.59.2025.08.12.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:10:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulnqC-00000002c1d-3Hty;
	Tue, 12 Aug 2025 09:10:56 -0300
Date: Tue, 12 Aug 2025 09:10:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250812121056.GB599331@ziepe.ca>
References: <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJsXkidmcSl3jUJP@google.com>

On Tue, Aug 12, 2025 at 10:29:38AM +0000, Mostafa Saleh wrote:
> On Mon, Aug 11, 2025 at 03:55:23PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> > > I am not sure I understand, the SMMU driver will register its IOMMU
> > > ops to probe the devices
> > 
> > You couldn't do this. But why do you need the iommu subsystem to help
> > you do probing for the pKVM driver? Today SMMU starts all devices in
> > ABORT mode except for some it scans manually from the fw tables.
> > 
> > They switch to identity when the iommu subsystem attaches devices, you
> > can continue to do that by having the paravirt driver tell pkvm when
> > it attaches.
> > 
> > What is wrong with this approach?
> > 
> 
> My confusion is that in this proposal we have 2 drivers:
> - arm-smmu-v3-kvm: Register arm_smmu_ops? binds to the SMMUs

No, I don't mean two iommu subsystem drivers. You have only the
pkvm-iommu driver. Whatever you bind to the arm-smmu does not register
with the iommu subsystem.

> I am almost done with v4, which relies on a single driver, I don’t think
> it’s that complicated, it adds a few impl_ops + some few re-works.
> 
> I think that is much simpler than having 3 drivers.
> Also better for the current SMMUv3 driver maintainability to have the KVM driver
> as mode, where all the KVM logic is implemented in a new file which relies on few
> ops, similar to “tegra241-cmdqv.c”

I don't understand how you can do this, it is fundamentally not an
iommu subsystem driver if pkvm is in control of the HW.

And I still strongly do not want to see a para virt iommu driver hidden
inside the smmu driver. It should be its own thing.

The tegra ops were for customizing the iommu subsystem behavior of the
arm iommu driver, not to turn it into a wrapper for a different
paravirt driver!!

Jason

