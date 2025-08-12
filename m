Return-Path: <linux-kernel+bounces-764777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE3B22716
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57B594E3251
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B11F4CA0;
	Tue, 12 Aug 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/VkShnr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EE1A8412
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002236; cv=none; b=HMRspA7De0bHEMKodWIUBi8HwsFYpl8vh/mKKVDORg3+G5LhiIvBA0e6oJVUpvxlnr6Z8nvziQjEP5gbxGNeUfvuKDvI0xeWPqTt2qqRxsBrAO7bmBKUT6ZYOSUiNyTqeJ+xFJSmd1Pf70qok+3P8V4VtQ0hI1UwVNqZIzwk5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002236; c=relaxed/simple;
	bh=6+vPV+bK6DJ6nXeb3jB5k6SS93vCnToxb34PAPFuCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ombjy1KTjlqPo54E6JM9wVVtwhcFeF8Dqf7bynVlEmVi7zFeBazGBTf01WFChdoTb2ME5D2Iyg5PbGrJ7/ugMTc47DMdlhaWNEP7lfA3laftrr98vQUBmaSwHBDqF28IagOWOvTYUbYm2rdxCiy3cngHLMGs+zsm5xWL6LGrzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/VkShnr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so65005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755002233; x=1755607033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PtQo1+YnKpPyJJuFIk2dQE6YfNoW6wyzVP6JiM6d+x0=;
        b=I/VkShnr3w0k6l8zw/7hv23zNnpnawZ/+HPWVHhDrDMcegbpRAHRMW4ZeGn6k5u/Sb
         QJ+L728yhb5ZjGQCCYWCqProXFrcwPRRkosOpXjV25UMg/sJUTHmSC+AZU6HvuNDjmKg
         v2EbtoGYn5As7nPU4g4mFOCJNWoAdA5YLXtbPhwV6S8WbPjF4+2oMSXxsq1qU3LB7rr0
         TdQdd/xjIoH5UfnOk2X8U8DkIa/Fma10Tf4wJTkMZ/yB7pTnpaA9htapVzGoai+5tkm/
         qi0hKW4bGpsSk0aqwDL9lD904HHzatK0lHZCJmXuiHOv7wYFZoolnVxEnutvHl9YxqN2
         FmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002233; x=1755607033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtQo1+YnKpPyJJuFIk2dQE6YfNoW6wyzVP6JiM6d+x0=;
        b=oBc/nF/KA+ShNAeCeWGusYxQ0YjE12Bdd/9RgOZtB/JK6/0aIlYNvuOR3bTGzsgRdW
         kFSLuLqDD4EtTHQK5aD00ZOC15poECIsoBswdwbxfc70GI1E5KYjZsqJtDOn3EJGW+T7
         DjkpiCOadEHuhm4NhdqUIq5CumItw+9jdcTFdX3D+AHf9LK11nf+b55ge9y6KoDeuXH4
         Oad1Zjk9eDsKuPfMxa71y9MkADnjoSSo00Y46H2Gsu2n5hxkjVA/8l/Jss1fzxrwD16S
         WVzSJC025bm0aq+xyucmMRgRRK9AVsaonwWuKa6+bnlOH5AsjFatCuEOj+s6abtzf173
         2niQ==
X-Gm-Message-State: AOJu0YzETU41N5JS5ztLrQzgMdnzW8G24zCbCtchjvjYMz8LgGNboMgO
	L11AG27kz9OQ5GKPT2cB+3+JmsjSvEDvm6QJ6uV8YywBPg/8gyHM2CsFxykxaNhuyg==
X-Gm-Gg: ASbGncubKYgSbwbo0E1wce1SWR6A5C9sXfs3sc0oojdTzPaY5MkHnUft/Y2LAdEMcrA
	1L9oc3xxvLBaaDCvQ5pVaxmdyOeEHPvoQRKi4oVwuQIeDeuqYyV+ckr8IygTp9vjnflGnbzclpL
	4Ewp7/g1QMURsJPTraLYnmz0xsY/VUT7bChfTsyJFu9BUUQI4yDefVMR3x8T3YNHtRvCz1G7ezq
	m+qG0TDmIRA0sHiPtZdRuTlqE7UNbKe/+MyHia9zaH3gIwQBd69dplHkv7S4pTHYUDpghhpMgBI
	mW57pZdNe8okw6UgKb3l4IUdy8IIbvefIo/2UV6iu3l8Vmfgcsv//kCg6yOxqnV6G0oNDNLUqxj
	486rL4FiZbDUD9pFfweauvw0wlf6ABGcEXAxO2w+dZi149btkOYeNrlpRtSfkHcKBsg==
X-Google-Smtp-Source: AGHT+IFFzsEa9cITaRrgMdyauTFUB3XSIIAjCGeM6bXsRwPoXP8edKN4pm8dt4hrGOEGeaKzytXWkQ==
X-Received: by 2002:a05:600c:1c16:b0:442:feea:622d with SMTP id 5b1f17b1804b1-45a118c8a81mr1414775e9.1.1755002232511;
        Tue, 12 Aug 2025 05:37:12 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm317915135e9.1.2025.08.12.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:37:11 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:37:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aJs1dMiomjtxVwl4@google.com>
References: <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
 <20250812121056.GB599331@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812121056.GB599331@ziepe.ca>

On Tue, Aug 12, 2025 at 09:10:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 12, 2025 at 10:29:38AM +0000, Mostafa Saleh wrote:
> > On Mon, Aug 11, 2025 at 03:55:23PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> > > > I am not sure I understand, the SMMU driver will register its IOMMU
> > > > ops to probe the devices
> > > 
> > > You couldn't do this. But why do you need the iommu subsystem to help
> > > you do probing for the pKVM driver? Today SMMU starts all devices in
> > > ABORT mode except for some it scans manually from the fw tables.
> > > 
> > > They switch to identity when the iommu subsystem attaches devices, you
> > > can continue to do that by having the paravirt driver tell pkvm when
> > > it attaches.
> > > 
> > > What is wrong with this approach?
> > > 
> > 
> > My confusion is that in this proposal we have 2 drivers:
> > - arm-smmu-v3-kvm: Register arm_smmu_ops? binds to the SMMUs
> 
> No, I don't mean two iommu subsystem drivers. You have only the
> pkvm-iommu driver. Whatever you bind to the arm-smmu does not register
> with the iommu subsystem.

I see.

> 
> > I am almost done with v4, which relies on a single driver, I don’t think
> > it’s that complicated, it adds a few impl_ops + some few re-works.
> > 
> > I think that is much simpler than having 3 drivers.
> > Also better for the current SMMUv3 driver maintainability to have the KVM driver
> > as mode, where all the KVM logic is implemented in a new file which relies on few
> > ops, similar to “tegra241-cmdqv.c”
> 
> I don't understand how you can do this, it is fundamentally not an
> iommu subsystem driver if pkvm is in control of the HW.
> 
> And I still strongly do not want to see a para virt iommu driver hidden
> inside the smmu driver. It should be its own thing.
> 
> The tegra ops were for customizing the iommu subsystem behavior of the
> arm iommu driver, not to turn it into a wrapper for a different
> paravirt driver!!

I see, but most of the code in KVM mode is exactly the same as in the
current driver, as the driver is not HW agnostic (unlike virtio-iommu).
In fact it does almost everything, and just delegates
attach_identity/blocked to the hypervisor.

IMO, having a full fledged KVM IOMMU driver + faux devices + moving
all shared SMMUv3 code, just for this driver to implement a handful
lines of code, is an over-kill, especially since most of this logic
won’t be needed in the future.

In addition, with no standard iommu-binding, this driver has to be
enlightened somehow about how to deal with device operations.

As mentioned before, when nesting is added, many of the hooks will be
removed anyway as KVM would rely on trap and emulate instead of HVCs.

Otherwise, we can skip this series and I can post nesting directly
(which would be a relatively bigger one), that probably would rely
on the same concept of the driver bootstrapping the hypervisor driver.

I am generally open to any path to move this forward, as Robin and
Will originally suggested the KVM mode in the upstream driver approach,
what do you think?

Thank,
Mostafa

> 
> Jason

