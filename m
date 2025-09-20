Return-Path: <linux-kernel+bounces-825718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D67B8CA5C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573E05802C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0301D61B7;
	Sat, 20 Sep 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRzEdIGQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2971186E2E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758378890; cv=none; b=D8fvBb7pWldBOYmP1DbR1AU0ap3zsNVZtAMP4uTgcbMpZFk+Q4N0JGw1eMoI6+t9pUpehW5wgbTubhzzc8xGnTXeyvh1op1iKiG6IagUoFVzdda5Vf9pRWOEfQMe7mD1x1g96rDwaiQcqy9jUuTY4g+9ot0+yfHPGmSJeuL3hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758378890; c=relaxed/simple;
	bh=m7o1JmdCtCm0ban/9JFAPVOEURfRDh7SX9QH+JTTZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu1BG8ml2LPEEmd1YAFBsV3W/Al44qr/KuEgydh/Eo/G5m8zLjGnsOVAizGKzub7dBp1n5a67yfMo3mjgFuJKZgq42Vu9x0vFNSYKyqNGUGP4AbhRk7BbZGxAZ9EEqLck2E2HZ96F/g0GOGe98gn6tjE9NhM5oDwDuWAO/24W7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRzEdIGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758378887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmW0GhFqpuOz4IYUZyTxB91HzEDm1lTR2DbWJheeJf8=;
	b=ZRzEdIGQUqOarQgpRXQAcpsRrxp7cB7FfvpuIqSy9bNgHsM0nB5wJNXuG5HdBHRWQBu3BX
	ACtgU9fSb0qtmZ+bpXeXjhjarC+OcsdXI7SyAUkq7x+n9gKBpRG64z/1e/yQHqBBj6WKnh
	LeklW9Me1GMywx7zOdYnBCruQi5l2H0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Aog0Z9avO-S-q34NVcLjpg-1; Sat, 20 Sep 2025 10:34:46 -0400
X-MC-Unique: Aog0Z9avO-S-q34NVcLjpg-1
X-Mimecast-MFC-AGG-ID: Aog0Z9avO-S-q34NVcLjpg_1758378886
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8935214d60bso81159839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758378885; x=1758983685;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmW0GhFqpuOz4IYUZyTxB91HzEDm1lTR2DbWJheeJf8=;
        b=iVgFEp6xkyEvuWcwdMVYAWUdAmld/AEAVP4QmlenLds3fWNDQa/fHnCaMomGLKR4hR
         8Cs8biFhyNrKdzspGi47aZ+2N/qzmRSj6Psazd7fBcwmbYbNYYseX/Rryu0KfdDxU8Lx
         FfGdnT16pQxyRASNCQoIhkTMqz0XBih/g4ZDOsNle5ouiPDwtzh8nehrBwDaTGrLn0Vk
         1At4mINVg8luQYeqBVzh6+uHk7CWToGMd43UeZDAxPDXGHNb/ycyViSAyvJNPXsqnQiV
         p1f18SyzDfE39u76nuGuxe4o5yYnXF34HAXmJCo9JHD7MtvtoKyZFSAMu2PJPBAfG8ft
         HQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw37wcoBy2Eufo4jhmqpoO9eipNUauM7nZanJF5OznP4upNjrfMHiCSRpUFdFVs+bd5+kHttJtSb5zFdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31d3JL9nsPF/JA9ll1eAxtM7GMRiP3hMpa0Tia17Y5oaZrCO2
	28w0GcGopSFD5tCDYgJBjHJ9v16+vlu6yj/cRVDd+jMhil4LlWsBPpuyR4Cso/sTT6umD8DRmEV
	zr0Z6RQnO6AxXhEZyl6q4kLGwgTZZl5wMdm3JmlHp/p/rupBS3qqh665HP3Y8fNbPcgkn7yVF0g
	==
X-Gm-Gg: ASbGncvlzLmzQuZLcXBrGMMA53GjOmgn4/kf8v8qU+BlCB0dCHBMfK7SBCbuUuY2+oy
	qp3OYvRVak+6jBiWhOlnb0CdHtZ4NG4hrLJpz3XaVu+rTJaQ31OkmHG5QJrHzYRZKrpTXkfNX/w
	uO7Qx8MN1CdCxe5x2yPudoViJ1X1SuBMyOMU2VOh4qD2V56a3oBT4dlWbeT4EXGrGTvpoZDOVX7
	vKxShnSrkptj9cXNo5vuV5UWEDIQ155L55BdScYt0L+2+GGaUOBlNPIvS8lyv4Ini0NmWe4vIsO
	wLt8GYn4MOnRvVMB0wgF3a4XIYLoBdG9R9Zrq0xcfNg=
X-Received: by 2002:a05:6e02:2301:b0:40f:407b:f276 with SMTP id e9e14a558f8ab-4248197e364mr38881865ab.4.1758378885061;
        Sat, 20 Sep 2025 07:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/sU+69zKpMjjxvM7+FqZPhR1nEz46uEcfbGd5xDRY/strRZMysIf+Q/QIhqN6+Ha09OCGw==
X-Received: by 2002:a05:6e02:2301:b0:40f:407b:f276 with SMTP id e9e14a558f8ab-4248197e364mr38881785ab.4.1758378884673;
        Sat, 20 Sep 2025 07:34:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3f7570c6sm3458457173.31.2025.09.20.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:34:44 -0700 (PDT)
Date: Sat, 20 Sep 2025 08:34:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How are iommu-mappings set up in guest-OS for
 dma_alloc_coherent
Message-ID: <20250920083441.306d58d0.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
	<20250919104123.7c6ba069.alex.williamson@redhat.com>
	<CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 08:34:41 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> > If the VM is configured without a vIOMMU or the vIOMMU is inactive in
> > the guest, all of the guest physical memory is pinned and mapped
> > through the physical IOMMU when the guest is started.  Nothing happens
> > regarding the IOMMU when a coherent mapping is created in the guest,
> > it's already setup.
> >  
> 
> Thanks Alex.
> 
> Another doubt pops up for this scenario.
> 
> Let's take a host-OS, with two guess-OSes spawned up (we can take
> everything to be x86_64 for simplicity).
> Guest G1 has PCI-device-1 attached to it; Guest G2 has PCI-device-2
> attached to it.
> 
> a)
> We do "dma_alloc_coherent" in G1, which returns GVA1 (CPU
> virtual-address) and GIOVA1 (Device-bus virtual-address).
> Since vIOMMU is not exposed in guest, so GIOVA1 will/can be equal to
> GPA1 (physical-address).
> 
> This GIOVA1 (== GPA1) will be programmed to the PCI-device-1's
> BAR-register to set up DMA.
> 
> b)
> Similarly, we do "dma_alloc_coherent" in G2, and program GIOVA2 (==
> GPA2) to PCI-device-2's BAR-register to set up DMA.
> 
> c)
> At this point, the physical/host IOMMU will contain mappings for :
> 
>     GIOVA1 => HPA1
>     GIOVA2 => HPA2
> 
> We take "sufficiently" multi-core systems, so that both guests could
> be running concurrently, and HPA1 != HPA2 generally.
> However, since both guests are running independently, we could very
> well land in the situation where
> 
>     GIOVA1 == GIOVA2 (== GPA1 == GPA2).
> 
> How do we handle such conflicts?
> Does x86-IOMMU-PASID come to the rescue here (implicitly meaning that
> PCI-device-1 and PCI-device-2 """"must"""" be PASID capable)?

No, each device has a unique Requester ID (RID).  The IOMMU page tables
are first indexed by the RID, therefore two devices making use of the
same IOVA will use separate page tables resulting in unique HPAs.
PASID provides another level of page table lookup that is not necessary
in the scenario described.  Thanks,

Alex


