Return-Path: <linux-kernel+bounces-819073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9813B59AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880441BC2A69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420B341ABE;
	Tue, 16 Sep 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKla0DNO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5431352A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034225; cv=none; b=tJk/p7P8RuTPFA70sPa2cLMJW5462gtD/nFtB5RWGBHzsRsMyzU1bharjwaKORvdct7S6dibeQL/doYA7eQ0SJoUBSMXGt3JhhFCBh/8DUk5fdYF41ZoV+7YLmuKgmgh5BOf25Cz/n40UPFkop2qB18rtP8fiW7c99FjCwxfg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034225; c=relaxed/simple;
	bh=fbvwpPM3R5lMCHUi2ENLE4gQsD0b4XmRKkbrAcTMxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j87mVWTrgGFnTxlNWW4Wv71z7e2ZPyPVxcK8uTAhdzTQLjvBrUt75d4IDHow4zMV3VQcmUiDCB+ykciG3DRanEEimt0vtHtdTlGPbxKxOp1QH5xZIbSuylGTH+qSJo7mUYoXkVP0HmLPeVNv9uu8dENU3ssyPZ3MpfVhcnNx8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKla0DNO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f30011eceso60315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758034222; x=1758639022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTpmHXQDrDNu2omvxpv38G1z1jQL9k5zYwI+nHzzx2A=;
        b=xKla0DNOUroQfTm3lLc2OoQ9mvNxP6KSpk03jf8OWK8Hv9Zwqv2hK9IaqdBxUDpC5w
         kHHHvFLEOTPQ9pcH0QjTFCYbGH3xfVct9G03w3l1qbBKc++fRuNQJR81pnlDFxvOYB95
         z1DqISMJvl5xfEE53iaSQPlgr06Ecpyx50RAnzcM4K9ihm2D76LUZLnY8YQPVN8lY4Rn
         x7YelClE649yvxUjGpXXawlu6x8szI3HKLgr+jeqv7zcRZsN9RtNgr84J9DN2VvReWb5
         ElfI+hOBWTLSkoO+yD6JDpOv758lWCkNmXe+Tr2bWnb8fgRtzuoQsnXGbGDhoMovkE8x
         HMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034222; x=1758639022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTpmHXQDrDNu2omvxpv38G1z1jQL9k5zYwI+nHzzx2A=;
        b=E7DmmWwwkDMY/eGc/xsQ6MJl1Dvg65q5QxF+WE3F9Z/4xZ4IBijzMZ/CKfcFSPIIZ6
         j3qbAULLTyzQx2e5Jn1J7ikar+oervZcYeDUK4P+ZIrPtPJ+KtFoHmHHphe2TzR9hmFz
         A4aocLrcLsZUcTpuk6sgrlE2IBS+MaN8Q/AH5cdwXINW9k8dyxM+Sc7ESVPWoNPWaI5S
         bYSraggTi727FUNJm4Eb0iWh9kICLPNk6+EeUwAisKysL+LEzzMGcavwdj+5LWUI3wNC
         dx7O/jRbuyQeAFUP4erGer5sDynD9F1bD33a+nobpL8p5lV8tKNyRn2gIeHZL0XTIWVx
         kSRQ==
X-Gm-Message-State: AOJu0Yy/rrwDtidEeaL6c/CvzDr03yO4BJA7tBJHYvAqTUMhKnfC3TWN
	shi/ci394xKzF23odeauL6sXwuGH6bWaEqCUNMZQJoXm5X70OM/Czdrkd4SE5boGMg==
X-Gm-Gg: ASbGncv4WfBEUIhdKaopxFt/lb+50Tbb6Z394xhnequcEQ10e7jHNGvMLB9bLtYF4iK
	E+DpQOL6p4NFX43wMfOkSpQlZlVnYfVzY02WmWRDwLBfk/Qdz3VpobCPQnLz5BJxs+QsdJQMuOh
	IPzW/yMBJJ9FwcDf8j3z5Y2c8vEQYRED/XdqpVDFIjIAtdz4WnZFKTZ4TlLT26r6fa8EKD0++Ws
	dbwfE6bBY5CvkOral/OVyXICep++TgErPTpk56eMWeeb0b11hSc5YgHHgAMzle+uVcEFfn8na4Y
	S1N4um6fAmv9+J/+hNFkozIJrnOcXQ4rjJD4eIS6WZJj4SGdL9q/pzJtGBY5egh7P1akZdntyZe
	RWruXoofHYsYDa2xo2qrTIkIzQvreaP8/FIpPFwenzhmR3Em68iiE1yX4h07JNbFu5DiJKA==
X-Google-Smtp-Source: AGHT+IHD9Kzax0Ca9B0Mi5gbzv7latmKARYeb9YTewjapsp5wcmK8hKO8yrvBqqgUSVFMKJVQNhyag==
X-Received: by 2002:a05:600c:4689:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45f320079e2mr1999085e9.0.1758034222192;
        Tue, 16 Sep 2025 07:50:22 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2a65e1b5sm123753115e9.4.2025.09.16.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:50:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:50:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <aMl5Ku6ZbzTOuGh-@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQroI4NDu74PDGT@willie-the-truck>

On Fri, Sep 12, 2025 at 03:18:08PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:50PM +0000, Mostafa Saleh wrote:
> > Don’t allow access to the command queue from the host:
> > - ARM_SMMU_CMDQ_BASE: Only allowed to be written when CMDQ is disabled, we
> >   use it to keep track of the host command queue base.
> >   Reads return the saved value.
> > - ARM_SMMU_CMDQ_PROD: Writes trigger command queue emulation which sanitises
> >   and filters the whole range. Reads returns the host copy.
> > - ARM_SMMU_CMDQ_CONS: Writes move the sw copy of the cons, but the host can’t
> >   skip commands once submitted. Reads return the emulated value and the error
> >   bits in the actual cons.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 108 +++++++++++++++++-
> >  1 file changed, 105 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > index 554229e466f3..10c6461bbf12 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > @@ -325,6 +325,88 @@ static bool is_cmdq_enabled(struct hyp_arm_smmu_v3_device *smmu)
> >  	return FIELD_GET(CR0_CMDQEN, smmu->cr0);
> >  }
> >  
> > +static bool smmu_filter_command(struct hyp_arm_smmu_v3_device *smmu, u64 *command)
> > +{
> > +	u64 type = FIELD_GET(CMDQ_0_OP, command[0]);
> > +
> > +	switch (type) {
> > +	case CMDQ_OP_CFGI_STE:
> > +		/* TBD: SHADOW_STE*/
> > +		break;
> > +	case CMDQ_OP_CFGI_ALL:
> > +	{
> > +		/*
> > +		 * Linux doesn't use range STE invalidation, and only use this
> > +		 * for CFGI_ALL, which is done on reset and not on an new STE
> > +		 * being used.
> > +		 * Although, this is not architectural we rely on the current Linux
> > +		 * implementation.
> > +		 */
> > +		WARN_ON((FIELD_GET(CMDQ_CFGI_1_RANGE, command[1]) != 31));
> > +		break;
> > +	}
> > +	case CMDQ_OP_TLBI_NH_ASID:
> > +	case CMDQ_OP_TLBI_NH_VA:
> > +	case 0x13: /* CMD_TLBI_NH_VAA: Not used by Linux */
> > +	{
> > +		/* Only allow VMID = 0*/
> > +		if (FIELD_GET(CMDQ_TLBI_0_VMID, command[0]) == 0)
> > +			break;
> > +		break;
> > +	}
> > +	case 0x10: /* CMD_TLBI_NH_ALL: Not used by Linux */
> > +	case CMDQ_OP_TLBI_EL2_ALL:
> > +	case CMDQ_OP_TLBI_EL2_VA:
> > +	case CMDQ_OP_TLBI_EL2_ASID:
> > +	case CMDQ_OP_TLBI_S12_VMALL:
> > +	case 0x23: /* CMD_TLBI_EL2_VAA: Not used by Linux */
> > +		/* Malicous host */
> > +		return WARN_ON(true);
> > +	case CMDQ_OP_CMD_SYNC:
> > +		if (FIELD_GET(CMDQ_SYNC_0_CS, command[0]) == CMDQ_SYNC_0_CS_IRQ) {
> > +			/* Allow it, but let the host timeout, as this should never happen. */
> > +			command[0] &= ~CMDQ_SYNC_0_CS;
> > +			command[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > +			command[1] &= ~CMDQ_SYNC_1_MSIADDR_MASK;
> > +		}
> > +		break;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static void smmu_emulate_cmdq_insert(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	u64 *host_cmdq = hyp_phys_to_virt(smmu->cmdq_host.q_base & Q_BASE_ADDR_MASK);
> > +	int idx;
> > +	u64 cmd[CMDQ_ENT_DWORDS];
> > +	bool skip;
> > +
> > +	if (!is_cmdq_enabled(smmu))
> > +		return;
> > +
> > +	while (!queue_empty(&smmu->cmdq_host.llq)) {
> > +		/* Wait for the command queue to have some space. */
> > +		WARN_ON(smmu_wait_event(smmu, !smmu_cmdq_full(&smmu->cmdq)));
> > +
> > +		idx = Q_IDX(&smmu->cmdq_host.llq, smmu->cmdq_host.llq.cons);
> > +		/* Avoid TOCTOU */
> > +		memcpy(cmd, &host_cmdq[idx * CMDQ_ENT_DWORDS], CMDQ_ENT_DWORDS << 3);
> > +		skip = smmu_filter_command(smmu, cmd);
> > +		if (!skip)
> > +			smmu_add_cmd_raw(smmu, cmd);
> > +		queue_inc_cons(&smmu->cmdq_host.llq);
> > +	}
> 
> Hmmm. There's something I'd not considered before here.
> 
> Ideally, the data structures that are shadowed by the hypervisor would
> be mapped as normal-WB cacheable in both the host and the hypervisor so
> we don't have to worry about coherency and we get the performance
> benefits from the caches. Indeed, I think that's how you've mapped
> 'host_cmdq' above _however_ I sadly don't think we can do that if the
> actual SMMU hardware isn't coherent.
> 
> We don't have a way to say things like "The STEs and CMDQ are coherent
> but the CDs and Stage-1 page-tables aren't" so that means we have to
> treat the shadowed structures populated by the host in the same way as
> the host-owned structures that are consumed directly by the hardware.
> Consequently, we should either be using non-cacheable mappings at EL2
> for these structures or doing CMOs around the accesses.

Thanks for catching that, I missed it, I think we can keep the host shared
as cacheable, and use CMOs when accessing it, I will have a closer look.

Thanks,
Mostafa


> 
> Will

