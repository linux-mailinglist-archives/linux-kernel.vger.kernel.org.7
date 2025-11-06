Return-Path: <linux-kernel+bounces-888584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76671C3B354
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E00250169E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A0329396;
	Thu,  6 Nov 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NRn3uk0Y"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F530EF98
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435416; cv=none; b=VNmTRKyQEBiH7OWgTH58w2lMH9cz3raUTCKwu4yPZfFK09w6GtwXT2r1JYDBHhhcoG/+xW+COumIAkaKQfxr+M9ykFlKHT3t92pUUeGSn5BtXBiUFaGcumDKE22VujnXPg6hwKB3DOUQKASNZbQXX0PBMHj4thw3v3jOaDU5LvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435416; c=relaxed/simple;
	bh=TTc1YZVFGADWKQiiPY6uw5gCc7UQJC9CAdmxWiCLymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxUk6ou3y4jFf/Z1l781ctomdKmF36edmTqlkFUILjOGnlo50rSuCYa+WGNZTU9Q7EAL8G2tdQ/yr3/EQ4OC2RV459ugkHRtIeJA7cTrTrlqhWNKPaa1OAQj1onQP6+aGZlvOBrODi2yy82qrYlPj2S83sLNDU4dUAsfGjEXAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NRn3uk0Y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b19f149933so92261585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762435414; x=1763040214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7wtPPBtmobTf3tpzGJgjCZN1OD+0vuddCl5gz261Lk=;
        b=NRn3uk0Y6USxq+vylDms4cLJ+rcX+ZZP6sEe44bLUpXgvZtj2B/6R8EOu4bFrpnLE1
         h8NNdXcuxQbFWSs2NTeAKBK6VhSypfGVr1KfeNG7BlfTwHdkn/e1+3cVOIpf8ixgnu80
         d8h8CAJ+O4vEqNyiRvVnnbtAKmfDksQXrhydp55oWW9nv6FgbtXAEnWGlxE4f7LpSrkc
         KFeb6zE7XRiH+hazp22IE2fu+mZP353hQpw+6jjYZGEUX6TQ3Vfzqtr8Lujuu4BHEWZj
         steQWTx5zH3gCZIFw4xNu08ZZhqjDxL7hQgBN3XT5Ku8HkXY5C6EdvPnK9aU3Wh2Yd+g
         kVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435414; x=1763040214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7wtPPBtmobTf3tpzGJgjCZN1OD+0vuddCl5gz261Lk=;
        b=EfGA4oXV4ToeMqCGmXp7fgg8Cnwrs0ocDhXxeol8Xm4RPc4tpa/m1EusFDWpkcrj9P
         t1nc1flBQgf1JCifdl8mEC/Schl+75MSyjTHJi7SBHLTcQa+HgtsvOROjNfhdX2oUr9R
         Qh+Krsw452yp27dxGxTA8VVcTFk6ww5BPvpPeOmcqwD8msFi1fbDGOXSTBFwzgtMsdNt
         6zEk7x/G4yaRBIZkm2dSP036WAEViVFm6cJaTaE4WJME8E2ONb0S3NoyzSZaPHo262Nt
         bF+/yuPH5i7H/GsnBym881NpIMwOY8L8mNSgfI27y1nDDvvuqk+kUG5Tj//pI7hdHi3t
         KiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYRkyRUP2CtK1SkMQo8cZu8G8xea0VdwUBnO96BfBPR15Q1Q1mUBG3NfXYp8uujtEY7MVO2DhNqFRoW4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybb8Ltu6nc5XXyRNX0KhEBkFYgSXhf5VLdhaIsYI8ogD3YN5FN
	NCPg05xoOua/bhoK7kVoGyzoVtvKcRGdHWEhXP2MmhKG14xwuH1SPAcKOjh2oDK6VUs=
X-Gm-Gg: ASbGncs4PJxGX7pFSXofZGZCd6pbF2NSYDlP76vepwadc/CNnwjcbBfIc1p9YSJn9wc
	U2PRnVZf2raIaqc3EDcw+iJq3p01pSGc+5zDxiIWEhylFQFhrHEzI/4mCthOT9xdeXVPbx6IZtR
	EgwrWO4eIheNBp9X1Pij2B+PGwc6z0FnnJ3aUj2JX6AReJo7SBF1IxWcnqsKeRTJrluCsOnQvlX
	GEWR8jHK9EX6VEsr+HJzZn7U6OznGcAFGy5ZAHWJ2f7AKBYo/A+Huqer/LKJEObirBb4Q9nA7vE
	3s1eVbZ4Fpmq8eyIUyrcOlVvbFneUB1mpmVn1bcs9Mox+ODs+/jtCtVgpKZojKK7psB70HP4gy9
	ZqJO3uWx0TX5gefqwPowl1iJxS3my81IRh0v/UYr00PyHlxhoLV3LIrxy6kjaWdXLBJY09OqMbb
	JIJxxvcdgsYTf5jQtM2cJ4X/Y3Fe4bMKtl8z2tHTKYLJquow==
X-Google-Smtp-Source: AGHT+IF7ECca/wRqtLDQUCBhDGbisYdGUoI40f4LwZi2mrfI2AA/kkhA/v5r6hx61UdEeG1jvFSALQ==
X-Received: by 2002:ac8:7d82:0:b0:4ec:f09a:4faa with SMTP id d75a77b69052e-4ed7234f780mr81238951cf.19.1762435413664;
        Thu, 06 Nov 2025 05:23:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed8131b8d7sm18568161cf.2.2025.11.06.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:23:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGzxb-00000007LoB-2m3P;
	Thu, 06 Nov 2025 09:23:31 -0400
Date: Thu, 6 Nov 2025 09:23:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20251106132331.GU1204670@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
 <aQyBIohAuxNHV-XI@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQyBIohAuxNHV-XI@google.com>

On Thu, Nov 06, 2025 at 11:06:11AM +0000, Mostafa Saleh wrote:
> Thanks for the explanation, I had a closer look, and indeed I was
> confused, iommu_init_device() was failing because of .probe_device().
> Because of device_set_node(), now both devices have the same fwnode,
> so bus_find_device_by_fwnode() from arm_smmu_get_by_fwnode() was returning
> the wrong device.
> 
> driver_find_device_by_fwnode() seems to work, but that makes me question
> the reliability of this approach.

Yeah, this stuff is nasty. See the discussion here.

https://lore.kernel.org/linux-iommu/0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com/

riscv doesn't search, so maybe ARM should follow it's technique:

static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
{
        struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
        struct riscv_iommu_device *iommu;
        struct riscv_iommu_info *info;
        struct riscv_iommu_dc *dc;
        u64 tc;
        int i;

        if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
                return ERR_PTR(-ENODEV);

        iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
        if (!iommu)
                return ERR_PTR(-ENODEV);

It would make it reliable..

> > > 2- Check if KVM is initialised from the SMMUv3 driver,
> > >    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
> > >    KVM driver macro and cmdline to enable protected mode.
> > 
> > SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
> > actual working driver? Do this by not creating the struct device until
> > it is ready.
> > 
> > Also Greg will not like if you use platform devices here, use an aux
> > device..
> 
> But I am not sure if it is possible with built-in drivers to delay
> the binding.

You should never be delaying binding, you should be delaying creating
the device that will be bound.

pkvm claims the platform device.

pkvm completes its initialization and then creates an aux device

smmu driver binds the aux device and grabs the real platform_device

smmu driver grabs the resources it needs from the parent, including
the of node. No duplication.

Seems straightforward to me.

> Also, I had to use platform devices for this, as the KVM driver binds
> to the actual SMMUv3 nodes, and then duplicates them so the SMMUv3
> driver can bind to the duplicate nodes, where the KVM devices are the
> parent, but this approach seems complicated, besides the problems
> mentioned above.

I don't think you need to do this this, you can use aux device and the
fwspec things all search the iommu_devices_list to find the
iommu_driver. You don't need to duplicate anything.

Create the aux driver when the emulated smmu is ready to go.

> That works for me. And if we want to back the KVM driver with device I was
> thinking we can rely on impl_ops, that has 2 benefits:

> 1- The SMMUv3 devices can be the parent instead of KVM.
> 2- The KVM devices can be faux/aux as they are not coming from FW and
>    don't need to be on the platform bus.

IMHO this is backwards. The kvm driver should be probing first, the
smmu driver should come later once kvm is ready to go.
 
> Besides this approach and the one in this patch, I don't see a simple way
> of achieving this without adding extra support in the driver model/platform
> bus to express such dependency.

You shouldn't need anything like this.

Jason

