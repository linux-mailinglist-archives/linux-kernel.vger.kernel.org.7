Return-Path: <linux-kernel+bounces-827610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1FB9235A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750C83B42EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78373115BC;
	Mon, 22 Sep 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gERRg5Kb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D8215198
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558087; cv=none; b=Ufoj0msTIbGdbsCQzRfoCQBCv73tFatEhpZzMmRKSS9EPSeI9u3/G46P6ltoWEsetQA+mh7LN0Jqhi6X85D5oJ+PI62Gwg2h6GLNYi40mIojaPU2XXqmoAYG8fxtaeC2VFNZnVKN8wgCH4Lo1TGzvPLKcf2/iO5qv4uWyYGN0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558087; c=relaxed/simple;
	bh=TsSo5v20e3QCGi81nt9NTXKtnhDrJ6hOgG/6U8OU58g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/dwrvUBaIa2rm0zH1QwfuHEeAo1RKN47R+DTKMwTB/nVw5vb+PHFUmbZJDD2NcSwGaVSy6tei//riZD0bEedpde/saWsEXb9eoE3DSEnGMUnK5Z4Em7SjUekEG3sLrll30iQmG9Pc/YSb8Js8jE5uP0Iq3OQKHfEJEw5VMKhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gERRg5Kb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36639c30bb7so24768971fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758558084; x=1759162884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0t8TkngeWBa24L4rwJYazMbCKONZc82MDv2pY9DHfo=;
        b=gERRg5KbOnkLNG+n71Z0kZxHPK2RWyEAGi9qjp/QAb4mSMlMLz8Yg33GAYQEgN8Ed2
         ceT0E48GaRX5hMOL+L4LcLPXxDBeb2QA3RAzYBIIgY+Q8riqVBoFOlM8V3MIaaGKbr8i
         VFf0vtiIh5G4OYooMrLblcZIH9y0ZW/5genuO2IFxHfMA+t/MldEs3Qdhyb+IaVjoVGj
         ylKKTP2ui+oAQYCN2w+F5Ku2T9Of9wQxYCPCXZ8l8xAkrB4gP9bQCFBZg1iocMuUaP/Q
         /mdOUUdA0g6gjBhzkE9Y6nRkWba5V924Y3fstWT7kqj2iIEPuIK6vlzfm5IWyTjrKXKz
         fRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558084; x=1759162884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0t8TkngeWBa24L4rwJYazMbCKONZc82MDv2pY9DHfo=;
        b=PQraA5V7Di21XTsBqw0Z6QEiJBQcVrv3zhbDl4rwEc7neqlMVeYGMnDbrMxtENwBzN
         G5vrEFQhDnPx2MatroYnsxeHuRXqu1ML+UeqrGQdU4Ty3JXflaicQtsBnQ0IKPBuAPFJ
         NhGGZ3pLizicVaj3NAr06QXskU5W5xKp+YbxwK0I9T4enVwtmSZCo9NCJq57rQoEWOJ3
         A3sDfR8xmafVdUUfE8+RAdseVReou31ym2oUbIvD+fKJXo20Nii8ffPSs0C5hBb60fGX
         4FfrqU/0z2jlyDFhC7cL/uaDt+3hmr49eDe6y+4r4zZRkbOmeGP2yLYFjYFZACob8oNg
         nt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhp9uUhMThqrPPwU5FhzJLUwhWGsHyB2+hwwVeO+/MjXQf0nPJLB5IntilkxYNS8xOR7D5d4q+abG6rwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHqrrPs3LJYAE/SnX0Hd8n61LYX+A/+4t1hWg7kAXFUWKJ49C
	1r1H1m7SVmp3UgDZSdSDozHA9ySUCQbmaZ6pirWrobKBE8PKoJDcsySyk6dvZ6TLvjrzz+bcGK8
	cw+phTkf9TrLDdqpjf7oY0FxysO8Xe85grw==
X-Gm-Gg: ASbGncv+gKUxj7NoT9BtS6hpoQIYtlH1wNT02jE4kIvDTqEUZbGO9gQ0lUKGUy0t0k4
	bmKXvLw6g7KwWWnyuVV1w9NVh9rSjCT8MjQzJbRYIkpL2sW9rz2F8Z5ZFtYR3SeUgtY+rIhBu+2
	EIrE1akBHavy3g6L1kn8OiJPLnh7fGRPie2ZrOrr/Q1hVAUbWNERgKQgFHM3IE8f5FJeM02nqNT
	Q/zAiRf8Q==
X-Google-Smtp-Source: AGHT+IHyflDhXEZ8d6nRs6K93Y7D5RspOmec4aU7ZWi2YQAy9LSUsWlc9YgLICF8EsksTaHkPC11zFyDPlCzZsUl2N4=
X-Received: by 2002:a05:651c:1547:b0:365:a58c:3ca with SMTP id
 38308e7fff4ca-365a58c08c2mr38832981fa.40.1758558083309; Mon, 22 Sep 2025
 09:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
 <20250919104123.7c6ba069.alex.williamson@redhat.com> <CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
 <20250920083441.306d58d0.alex.williamson@redhat.com> <CAHP4M8WOkDvEf6DYe6w+V9PVHkqcu2-8YrKa7jwLBYRAqLVS+g@mail.gmail.com>
 <20250922083221.5c6a68c0.alex.williamson@redhat.com>
In-Reply-To: <20250922083221.5c6a68c0.alex.williamson@redhat.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 22 Sep 2025 21:51:09 +0530
X-Gm-Features: AS18NWDDojf2RGP6S7lgnWI-3L1sM5khCOx-a1BaBWqJqq4H9fDzSEOwXpAUtKA
Message-ID: <CAHP4M8X89SUY=qoSO3xy8-TE0ubWGkOqP-WwP6niyn+NQLKUvQ@mail.gmail.com>
Subject: Re: How are iommu-mappings set up in guest-OS for dma_alloc_coherent
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> VFIO doesn't make PCI devices disappear from the host.  Maybe you're
> referring to unbinding the host function driver, which might make your
> NIC/HBA/GPU device disappear from the host as the PCI device is bound
> to vfio-pci instead.
>

Yep Alex, that's what I meant.
I am sorry for (unintentionally) causing ambiguity.

> There are ways to multiplex devices between host and guest, SR-IOV is
> currently the most common way to do this.  Here you'd have a physical
> function (PF) with a host function driver, which can create multiple
> virtual functions (VFs), each of which have a unique requester ID and
> therefore a unique set of page tables allowing them to operate in
> independent IOVA spaces for VMs.  You can imagine here that your PF
> remains bound to the host function driver and continues to provide host
> services, while the VFs can be assigned to VMs.

Perfect, thanks Alex ..

>
> PASID is another way to do this and is often described in an SIOV
> (Scalable IOV) framework, where we rely more on software to expose an
> assignable entity which makes use of the combination of the physical
> requester ID along with PASID to create a unique IOVA space through two
> levels of IOMMU page tables.

Perfect again, many thanks again Alex ..

>
> In either case, having an SR-IOV or PASID capability on the device
> doesn't automatically enable device multiplexing, there's software
> required to enable these features, more so in the direction of SIOV
> support as the scalability trade-off is to push more of the basic
> device emulation into software.

Thanks a ton Alex for all the help !
Thank you for always being there whenever we get stuck .. !!


Thanks and Regards,
Ajay

