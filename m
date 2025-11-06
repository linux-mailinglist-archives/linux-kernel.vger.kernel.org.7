Return-Path: <linux-kernel+bounces-889129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE53C3CCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D357C3AD871
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66034C828;
	Thu,  6 Nov 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CJdOVjO9"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D92D8364
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449419; cv=none; b=i+yXgJ2Xbjrgze+o+Okj4UyyEFQh1IPx2FLjeMQ1ZowhJunRZ5pyGh/1WUImA2qNsFuRrs2urECoKPxfJprJYbvMQ+O5jT7XJ2sIiVfIT8eOlHsBo8cGTAdXdeTQSy42fF7TaGjZ7zdQgLvvMT/GQTkokyDZ0RRY0u4zjHouOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449419; c=relaxed/simple;
	bh=dIwybaZojCu29+P9gEfB8CIvmj6Bl08p1VgiPhwpKTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOSl3c466tLcJKZt4jX/f3LzjRieS/DtQubOfNB4FzpbheK6p1yWMr6iS0Y7WA2S6+6bVh1xZxgtpr6cDjGT0EQp2IQ9CJdJDIk/qsRyq9ui/TpjlrkZgADeYSwZk6lBjaUMwBzw7BrQnFg75O2C9JICZ2iUu/+kz09DYE0WO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CJdOVjO9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed79ad2846so9089831cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762449416; x=1763054216; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyqXd6ge5y2aj27CRXRh3J8Q1q4rd+TcymckOxNEG8A=;
        b=CJdOVjO9imBTSxRyHc/n7zEODCoSd74/aaeElwF9WgjP2wdlDWZhSwPn792CK0dR4W
         KHXPtZD92yH4MNq/bVEqZdK4g4id00yTS8fILUWgJPqFAi5xbLz063ysBVToTU3HlDeg
         5TIAJQRl3M6HXnLaXOtEJHD/zngFExbf0QGK7lHYmDLLD72qjYpWELXu46D7xxR9mwTr
         jqt2Xi6xjo043WZA5Qse1KM5rLdOmUxzonwEGAn1I/1THIW25caUyC6g678B8RxqXsnN
         uHyBKKnqa8sVTi8iMMOds9OA8oo9FhPYCJgBeA9I8W4TW7Pq0eR4qWOu+uLblNW6cauz
         qCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449416; x=1763054216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyqXd6ge5y2aj27CRXRh3J8Q1q4rd+TcymckOxNEG8A=;
        b=jJM7MAh7CWC38mIX/OHGBE27Fe587xBk2KxTYR3ZUMfePrWDw328Eq1XwVFeM1jlL4
         42uPVJM2oAXccdjrADfr7swY9hEgn3sGNxtYJZ50WgQW+DKgv6+dSIqyQwK/B9s7FU9Z
         VNKaMoYbOC+wYGzrie4GbLiLLcegh0LccMn91tjlnoKUpDO4x3J7xe7N8LE5GfdtZQ6V
         Uyi7fXVmFLPHBnfKaAM9+dGIMc5L/HoN79QldmQNMvIHjHiOh9fW7hkxepYqddLyM7Go
         t25gy8cgmjBl2TmiSn8xfvIXe3N6q4w2nEsoVQJujoGHHu1xBI+bVX2BluYpWko6Od6n
         UMxw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+VocAR58g8W1602iK+SMdlxNHcsRXdiwcu4tzWy3qzB6yn6GxNy4osMn7mimjZy9MmisPP45kS1KyUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkGl9sXCgFzhh8AlaRpBWuckjaJSKvPVXDBsU//Minub1/Jno
	VWv9Q0TI2Xag3cpQdfSInegVZP+trh9UwDO2pZHt9BQPoTlKZzAC1W5QWyqFAGkzFtY=
X-Gm-Gg: ASbGncv+kDzLnY3YoaTG1dyyzQ/QNH9XbQ4IeijjmoKkL4EqxGhWFUHPvISqQksPV5n
	upmEkBe0zIYP9+f8HO9siwkU2a8CVAA5wKpliDaFKAmyO3cDrjOF4zbWYUYmZ/BNRib6lohoAHp
	URYmchrGab6V8vFQQTOt/0qFoZa6MdSWM3hkwA8ZaGGrhI8+ztiSEBBwAWRyhyCHadu2MfELo7Z
	T2Q88SRIrHVfD83aiwBSoemBIr8xssaTEuKp2qMcJyOp2REWOyoqgGJDpUgkApcHyMAPwGOA4+a
	Ux4dI6hd/D+rfg+G2/YsrBvpA8pAg0sCWB2TB4qr2M4XXGtv2JT/bWT2lPhvlD9WrW1ixCXVITF
	6L7SfDq7bLCvTLtYeQORRl0jcYMWGbPEWw0t3Z8nqIx7Cqzlf/0wRUtdCLyUu1fBD0u201SdLKu
	o5L/4h3NPrrlgu2K1WbjJhIteu8aC3NSqiSbnmHFl8e0iCcw==
X-Google-Smtp-Source: AGHT+IGm7rjI4btGT0uAp5U2+RTOpSSDx/JneJwxU99rel9EmV7Mer/iD0OJK3RWNsxIkY3fdHP+mA==
X-Received: by 2002:a05:622a:410d:b0:4e8:ac66:ee44 with SMTP id d75a77b69052e-4ed725e06eemr111576881cf.39.1762449415840;
        Thu, 06 Nov 2025 09:16:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed813b7ce2sm21908131cf.24.2025.11.06.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:16:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vH3bS-00000007OJk-2iYD;
	Thu, 06 Nov 2025 13:16:54 -0400
Date: Thu, 6 Nov 2025 13:16:54 -0400
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
Message-ID: <20251106171654.GV1204670@ziepe.ca>
References: <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
 <aQyBIohAuxNHV-XI@google.com>
 <20251106132331.GU1204670@ziepe.ca>
 <aQzSzhcndQ3Ry0a2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQzSzhcndQ3Ry0a2@google.com>

On Thu, Nov 06, 2025 at 04:54:38PM +0000, Mostafa Saleh wrote:
> Maybe I am misunderstanding this, but that looks really intrusive to me,
> at the moment arm-smmuv-3.c is a platform driver, and rely on the
> platform bus to understand the device (platform_get_resource...)
>
> You are suggesting to change that so it can also bind to AUX devices, then
> change the “arm_smmu_device_probe” function to understand that and possibly
> parse info from the parent device?

Yes, it is probably only a couple lines I think. You still have a
platform device, it just comes from a different spot.

I didn't it audit it closely, but basically it starts like this:

-static int arm_smmu_device_probe(struct platform_device *pdev)
+/*
+ * dev is the device that the driver is bound to
+ * pdev is the device that has the physical resources describing the smmu
+ */
+static int arm_smmu_device_probe_impl(struct device *dev,
+                                     struct platform_device *pdev)
 {
        int irq, ret;
        struct resource *res;
        resource_size_t ioaddr;
        struct arm_smmu_device *smmu;
-       struct device *dev = &pdev->dev;
 
        smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
        if (!smmu)

Probably needs some adjustments to switch places between pdev/dev, but
the ones I looked at were all OK already..

In the aux case dev is the aux dev, otherwise dev and pdev are the
same thing. devm related stuff has to dev.

> One of the main benefits from choosing trap and emulate was that it
> looks transparent from the kernel of point view, so doing such radical
> changes to adapt to KVM doesn't look right to me, I think the driver
> should remain as is (a platform driver that thinks it's directly
> talking to the HW).

I'm not so fixed on this idea, this kvm stuff makes enough meaningful
changes I don't think we need to sweep it all under the rug completely
fully transparently. If you need a couple of edits to the probe
function that's fine in my book.

Jason

