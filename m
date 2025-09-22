Return-Path: <linux-kernel+bounces-827426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AAB91BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0E51896495
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50007214A94;
	Mon, 22 Sep 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aacReDje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2601F4191
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551556; cv=none; b=VRa27knKFWmzDbtu6MfRgkfLbKP2mb+hTiyOs766vnVJY1ZVFxa+HutpVrqIXHB3RE6QTqXa5STrklqRvYkU1qQrxTZbi4AAw1HMOIsvP5sDyZbdbL5jjG6H5mKsvQAS5S2XBYu0FdRb36QqKGRX6pn9PuP4TlgTnzwHjS5ssfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551556; c=relaxed/simple;
	bh=Pz/d1AKtxiiydfZ2IL6Qr72ON6S3upVNRtsNpnhvunk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxRHnhZHHPjfRXBy9nOSxmhIboKCg2GE8hL/dQ0f4kct2moxmOu9h/AymOe3/vSM15J3ZjSJ79ekBHujFr1UHbHNBTN37/V5BCAPVzanU7cXiWm4BW+ty4scZWcxYaZclLamMV7M1JMVCZnlg4jY2AktC4E4EZgEYvtNlN2CcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aacReDje; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758551553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0mdXlW2PdWw/Qy9V5LGiEj48F/fReTXjEf+9IJupZk=;
	b=aacReDje/sbyGVkBrQmOXs4Hzr/3IhJgWITUCnCE4Mmbz82MEry4hz4DoSVFH0r3ieWuvb
	w3H758UuKGDuV9ReJz61DRgsxKnHsv3CmcPaEGeAIPwYJMDRtT0iRtYsxzEVF1+1Fdylj4
	PqvWf/2AjiAO8u1uJ/ScqaLW30oulf0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ckhhd-7KOBuvejh6denDkw-1; Mon, 22 Sep 2025 10:32:28 -0400
X-MC-Unique: ckhhd-7KOBuvejh6denDkw-1
X-Mimecast-MFC-AGG-ID: ckhhd-7KOBuvejh6denDkw_1758551548
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-34657fa878bso202639fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551548; x=1759156348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0mdXlW2PdWw/Qy9V5LGiEj48F/fReTXjEf+9IJupZk=;
        b=mPiyuvfNM6BECmWrvMIuhWg976slrxgiD+FpqiNLoT3fncHkWTtu1p93P50bV14q3f
         SiN4Oo+2nQrfB/wo9BgqHIZPsfwZPiT7ki9QQuqOufyekr9fKEuePWcSAv7LJ3CPMQme
         0GVZQgdtkvbYCy2t3JT7XOghskcYl8vWy9MhlcfpjqjnJC14uN3t0dG0nyvSu2bT0Bu5
         av6nlgWtLLKEbdFHXnaX5CSfupikWCwom2VU4yQ3iOgMxnt+a85j975dhN91TfIptGNA
         lSxHlXTTX4W+rCMOAMs1vlfQVBnqBJsUTarQbNCy+NcPBCbQOqmtgw3F/2ollWjy8vTn
         +CXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeiPATldPE9EBjciiVQbGkjCrNbigwiRpDyAPfL9Hhuh0t3b3iTlSaj1GdRiHF9wThrRYnW3LpYQNvP4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAeSQrcMNnVIcOQolJssgvdvurgD5tOlIQorz8+8h/r4SUplq
	CGvP0Dzs3nZPEXzBDt/dxkzOkQZPjGe9Y7KaGr8M8jhks46XDsI8fpNDHy7AiDWDG7bB+NFUOyx
	V5cXpLArTUEiO4ucJvfZAa3HyDVlcVO+wDnCbIP9x0GAEQzxm7/FmTfBmIs/7G7WhPQ==
X-Gm-Gg: ASbGncs1QtlKm+PVYy0nrsw+w7xoBWkLtNQ5eExWGeaSTeGKoBWEBeMV3WlJx70y2/7
	uPVW3/6UXceoKJW33aVWfjEenci/c5Y0PP2n17Cv0scSCocEwNKGGp18bfyYfohbODAysgwZsIp
	IwRCiI7rbOxzjR6vcSuB2vs01oDh5F1UdTjPuVquDRbwspQXiBOanZeYzLp5jOcelv3bK6UAzEg
	asRhksCu1GERkY5+NkcLAC6guB3rwE250W6YvVAXfNKH0meUI2s0PaPvpg54AJ5dHG9FHWa3FQE
	/NbZQ5lxIZpsh/5zlBFE7kzlS/wtWw5kywKWqS+3DXg=
X-Received: by 2002:a05:6830:264a:b0:782:1cd6:64bc with SMTP id 46e09a7af769-7821cd665e2mr1416053a34.7.1758551547432;
        Mon, 22 Sep 2025 07:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjly970k6GwwNFiNBlI+O+7SRtEFDU8sv3PASleb5pfQi/tEEztPimdT8lHEJXTI5/LbwF/g==
X-Received: by 2002:a05:6830:264a:b0:782:1cd6:64bc with SMTP id 46e09a7af769-7821cd665e2mr1416044a34.7.1758551547010;
        Mon, 22 Sep 2025 07:32:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692c725368sm5811989a34.41.2025.09.22.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:32:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:32:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How are iommu-mappings set up in guest-OS for
 dma_alloc_coherent
Message-ID: <20250922083221.5c6a68c0.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8WOkDvEf6DYe6w+V9PVHkqcu2-8YrKa7jwLBYRAqLVS+g@mail.gmail.com>
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
	<20250919104123.7c6ba069.alex.williamson@redhat.com>
	<CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
	<20250920083441.306d58d0.alex.williamson@redhat.com>
	<CAHP4M8WOkDvEf6DYe6w+V9PVHkqcu2-8YrKa7jwLBYRAqLVS+g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 20:27:54 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Thanks Alex for the clarification; really grateful.
> 
> When I had last tried attaching PCI-device to a VM (spawned via VFIO), the
> PCI-device vanished from host-device :)
> 
> So, as of today, if the PCIe device is PASID-capable, can it be :
> 
> a)
> Shared/visible both across a host-os and guest-os?
> 
> b)
> Shared/visible across more than one guest-os?

VFIO doesn't make PCI devices disappear from the host.  Maybe you're
referring to unbinding the host function driver, which might make your
NIC/HBA/GPU device disappear from the host as the PCI device is bound
to vfio-pci instead.

There are ways to multiplex devices between host and guest, SR-IOV is
currently the most common way to do this.  Here you'd have a physical
function (PF) with a host function driver, which can create multiple
virtual functions (VFs), each of which have a unique requester ID and
therefore a unique set of page tables allowing them to operate in
independent IOVA spaces for VMs.  You can imagine here that your PF
remains bound to the host function driver and continues to provide host
services, while the VFs can be assigned to VMs.

PASID is another way to do this and is often described in an SIOV
(Scalable IOV) framework, where we rely more on software to expose an
assignable entity which makes use of the combination of the physical
requester ID along with PASID to create a unique IOVA space through two
levels of IOMMU page tables.

In either case, having an SR-IOV or PASID capability on the device
doesn't automatically enable device multiplexing, there's software
required to enable these features, more so in the direction of SIOV
support as the scalability trade-off is to push more of the basic
device emulation into software.  Thanks,

Alex


