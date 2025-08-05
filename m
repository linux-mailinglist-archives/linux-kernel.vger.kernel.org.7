Return-Path: <linux-kernel+bounces-756914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8290B1BAFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9718A3902
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A257221FBC;
	Tue,  5 Aug 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nLHJMKVq"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B719F11F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422738; cv=none; b=otZaYfohxVf0uGwbnXop2lZ0spv8CKRQtQMST/MpnoQf8iPnnUABNUIpR6G3Q/T3gpFvDzGvNZWPWcF70SZpbcY0vDJ0TNuT9P0X905EGTSFYTb+sDAG7YDt+IEms6WVOjlZG0XgeOBaxI1vmBx1IgwEm27tNnWz75VSVMQ0D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422738; c=relaxed/simple;
	bh=d55My0lJH7EW7U+QyZ/8kq2QwJb2wcxt82jheLEtpaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp4i7RLNYaYA84N7bTZkmqQc4j4cFGAkdYEGDjUYpCgpY9ab1IN3Oml0Bq/RaRaxcTmmtB0Q5tMJMWkl8JXWyWk7tRPOatv9Jg+xbGoiJ0Y3S0kyiV8Q9iadV44zzGpgRKL8kjuPG/JIs5Sg9Zq0c7L5/c7nOiB8EnJQyjH7EpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nLHJMKVq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8053d3382so27086685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754422736; x=1755027536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfLvHR5VGzBySOq4iOqpMOpGA+jfUgtajL+0K128VgY=;
        b=nLHJMKVq23NQ2Xh7hl/W209rYNVkqugfAC1Ai7Rb3coaeQ7ViMoLBMOCqiezoPx4MW
         HJ2+etlzdpCv9g02Gt+HJR45WlwM/Dq2LoqPd0gI5Azx7bWMMiUGU7EO5vxy4MGahjg5
         KOMS/Cz5dbFzBSaz7gHaNiV3iAfjUbVfP9L3AQe4ZFEUfk2+Tm4almoA/wRZm3dLQIL/
         pJEP+i4Dwnp/PXP04JHI5Gv7oB3Yw5V2i6CKXyx4DtLK860vM5Fu55HRT/93Wuf4W+9p
         cuh+H63G0U3ji1PI+COqZdGdfHq2B6Fb/pztaB0sZjnRvEj7gywPXO1dWLirQZlniJt8
         4fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422736; x=1755027536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfLvHR5VGzBySOq4iOqpMOpGA+jfUgtajL+0K128VgY=;
        b=am7OYLxQfaoj+2EpltB3sh0Cjerp1KABOMV1+jZjptfiWfDFIOUx8Rm6vzkv3fSbqr
         5eXKjToeWyR392R6FV5cyoaxhmQO4gi/jvireDLwMlx83vZSNZXzPLRvNPJ+LL9P4nY7
         MY9qFj+DpgRKwlF34HNQaLruh1h+Us8U7F2uGgUZJi5FEUz3666pYCv6b6Eq0UAPnoMk
         ybDGX8Jvn/giZmxcVdWc0cZzbdqf28u/R0+ngxykrrb0hRdyhmXpbgfWxH6wdDBQo5ll
         u+1GLae0/KRPP8/+vDomVDS1s6FkcMmTFWWPEC6DF5CFOxmOf9q/vO0Y317ah4afaVmT
         a05A==
X-Forwarded-Encrypted: i=1; AJvYcCUSboLILCDEvMu6cYbAbGSVso+cDFP2Sv71JYVaAVHf3IC/N93qK6hPjgCnXTo57UAYphZv89WOpmiUH6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp17GYgpzaMp6KRq5VgHvmGw9KTtb/JWSrnBZi1yC1phbrXw8q
	/PLXvnqMT0KTQpw5If6+ewj21ZXlIeIkQ3+UdFcryTl3kZlQh/RjC4Tgznk+K+LgMPQ=
X-Gm-Gg: ASbGncvwFJrCCfkmsKVOnJYcXNXU3JxIbXNv3gUqHG9FGNniXTog/nb2LiVNbrp2T2/
	BPKqXclHdkYeiAdf2TBQ/peTy3PAJTDWGsu1YWbaNrKGJBe7vtUJeAwKNQG41+wSYCgU6zw0gik
	QlCLaAmx2/vdlf0emktEYsFL5TRMAK3nbkwhcm+grYvK3Iv6FhAzlOAO97aYKMyer+6FF5XcoWn
	UBfXLuZRaEi7CsGZAhWM+AOmvjYuBo/15MTZzqaC1922Xd8JTW5GhQAf4A6xalMvbPNFBvmouVj
	Bi4lwFS5IA3u52R7L5l+QeJTsAnuQCmP49N0iQRgTm3U98ByQ6oU6Cy8BhtxkqspI57op005DvA
	KHrMzSlkx12Ol6BXjgsImPir3ZfiT46/ECpHijvsHRjoI8sWtWmZwTdSFC3zJCNgCQBTGz1RHTC
	oNnjg=
X-Google-Smtp-Source: AGHT+IHKL5erm4l2X0vMQA58xzXa6BvQRyAOGPl1hFFlslB9qavE3XT0GkQjfse/P0NHo2ZevfOtfQ==
X-Received: by 2002:a05:620a:45a4:b0:7e3:3001:47b5 with SMTP id af79cd13be357-7e8156a5942mr24897785a.1.1754422735775;
        Tue, 05 Aug 2025 12:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717749885a.54.2025.08.05.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujNUs-00000001abD-2dVJ;
	Tue, 05 Aug 2025 16:38:54 -0300
Date: Tue, 5 Aug 2025 16:38:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250805193854.GA377696@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
 <20250805172741.GX26511@ziepe.ca>
 <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>
 <20250805184219.GZ26511@ziepe.ca>
 <6892562356e53_55f0910010@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6892562356e53_55f0910010@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Aug 05, 2025 at 12:06:11PM -0700, dan.j.williams@intel.com wrote:

> > So unbinding vfio should leave the device in the RUN state just fine.
> 
> Perhaps my vfio inexperience is showing, but at the point where the VMM
> is unbinding vfio it is committed to destroying the guest's assigned
> device context, no? So should that not be the point where continuing to
> maintain the RUN state ends?

Oh, sorry it gets so confusing..

VFIO *in the guest* should behave as above, like any other driver
unbind leaves it in RUN.

VFIO *in the host* should leave the RUN state at the soonest of:

 - cVM's KVM is destroyed
 - iommufd vdevice is destroyed
 - vfio device is closed

And maybe more cases I didn't think of.. BME should happen strictly
after all of the above and should not be the trigger that drops it out
of RUN.

> > Yes, and probably not necessary, more of a defence against bugs in
> > depth kind of request. For Linux we would like it if the device can be
> > in RUN and have DMA blocked off during all times when no driver is
> > attached.
> 
> Ok, defense in depth, but in the meantime rely on unbound driver == DMA
> unmapped and device should be quiescent. Combine that with the fact that
> userspace PCI drivers should be disabled in cVMs should mean that guest
> can expect that an unbound TDI in the RUN state will remain quiet.

"userspace PCI drivers" is VFIO in the guest which means you get
FLRs to fence the DMA.

If we end up where I suggested earlier for RAS that a FLR can check
the attestation and if exactly matching reaccept it automatically then
it would maintain the 'once accepted we stay in T=1 RUN state' idea.

Jason

