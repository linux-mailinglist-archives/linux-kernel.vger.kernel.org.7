Return-Path: <linux-kernel+bounces-788755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE837B389E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786283669C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1ED2EC55E;
	Wed, 27 Aug 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzbc9/zz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337B262FDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320913; cv=none; b=Gsdsh07uOqMlXmp6KExC0q5Le2poFdk56IjwQ4BSP0lHepPmOWjmOhGt9rHfUJXPL80W+867PaWg1z/PVJhJDjXtCm7HmC9trgKuQTKC479mmYoNBSOlFMClV45vxCILe6z43J73VUzYAAaTDTX4n3QzpmD6jcsNGI81/LE7XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320913; c=relaxed/simple;
	bh=agtBMNUn3Gwl9m7m+4izGb2+GjZI8T1IegpTOKuGGoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH/uiORxA5vgrpwGf3KhYXamwG+PxM+5plHv06psgR/jwsiWbEtqUkqdJ2kTXSInwqrUziezLRXC4vTFLDyqrZcl8zYJfO3i4sq74l29uUDgrgOaZrxDZxJqTYK1GK0o+ktfrpmlWxkLH97J9SCWtuy2YykA60OrYNyZNFnw0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzbc9/zz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8++aFhGainNDYwExZONwqjK/iJ18+hnmhdbGOzB7HmU=;
	b=Yzbc9/zzQ4oPZOq5P/gDHb6VbWQtd71LLKA/SrBYR2sZIz4P58l3tfv6eP4N9HxSxzE7+C
	UXe+gXd0bXudfR5WFSmIsZtJreSiHr3sxLKZUmMDMNXsROkbqbL73R8Dum9p38i45s86Y4
	QCFFR3Psamosn9EuIvszdIXLPPfkTfg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-nbpv0IfQM3KqMUTvqw04-A-1; Wed, 27 Aug 2025 14:55:09 -0400
X-MC-Unique: nbpv0IfQM3KqMUTvqw04-A-1
X-Mimecast-MFC-AGG-ID: nbpv0IfQM3KqMUTvqw04-A_1756320909
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ea4d2f503cso393865ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320909; x=1756925709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8++aFhGainNDYwExZONwqjK/iJ18+hnmhdbGOzB7HmU=;
        b=IyO/fe6np63CUjVQP66c/qFGZVP1N8JOIejdpPavyIDMTWIaDXJCzUdXvkIZeFfvnW
         3Iwq6Ub2bk6tgXUMrgAUW9nasoqS6LTZ2bRoR3Ho93J6uNnXBpmHHuVaYU5Fy2BWOKrb
         SLc6IV9qDYh15Iu8TeWPiBLR/z8hjNIIb9JFdje81iFR/qhRWWXDNv/uB7BvT7IywPgl
         v35cYQhhhk/YrS2jDyCrvKJA3eBNQ5I4hsISPerVMKDvDvFIyVZpmr1M69vh02mjcHPh
         CUwrKMmLnb55pPHZiCK4/KinPSLtCPh6luB6zQsHdL8StUuJrkSzgST0DL/qVyO26E54
         fkxg==
X-Forwarded-Encrypted: i=1; AJvYcCVdORTudHhymhaDhpYaIplE5+WoUW4XUld6KrGHo4FbI9WeFmEopn7lGUGmZOFLDKZD/3z5PuBuAzjHwww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeHyVAgj+hcNBnALifEFJsIMhwoF/12aonrO5jUYqCWqog3tB
	uuR2iG/sjyt4GfwnPBvFELilpx1F1vgdk/89tEXi5fTSvCflYIYIO7II/FBf3bkLQ8qzy2mZ4x8
	Mny3p1QiVuCoEduxUOzhmxQ085bZyEGlk2m7bc09prru3wRPFnMX/+mbS+o7HuaDLlg==
X-Gm-Gg: ASbGnctZSh/6PdE2D+rYs4qcgBPEqQPK48hHaV+ypiGJ1LFq/teCWWL/5UurvtDheDq
	6ndVxd96CQQhc8sv/ZLDfTm/IJ74zigJo96RVffvIfV3PF/1V17zIkumA4KwUS6Ca3KPiG9uqZP
	4HCCztMnx4wsnRfkB2hWAvpNgvoDSqf/uy3Kb4LZS2cwqwW8nzc7NSdSuWAQAeATtxmZ3FKldb0
	xsOmJ3ym6vdbJJ5uNaP6GdPiP0ZCdP0Y5Lth0izZpZMgppKcdKSERv87CUoelNE3XdLsYSl66iA
	5/3/AmZBMpLEaa1iCI4VBrga5MjpgScz0qgq298HNWw=
X-Received: by 2002:a05:6602:6d89:b0:875:ba6c:f77f with SMTP id ca18e2360f4ac-886bd12f6e0mr1153120039f.2.1756320909011;
        Wed, 27 Aug 2025 11:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdDKGxdN7lZTrjF1t/hR5pLOxm848azGffRUtAGXsrM4Y7GHBpN6/GovIW0l1YT0aBTs9CgA==
X-Received: by 2002:a05:6602:6d89:b0:875:ba6c:f77f with SMTP id ca18e2360f4ac-886bd12f6e0mr1153118739f.2.1756320908616;
        Wed, 27 Aug 2025 11:55:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8fa63casm825799639f.17.2025.08.27.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:07 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: drop redundant conversion to bool
Message-ID: <20250827125506.5e41e8c5.alex.williamson@redhat.com>
In-Reply-To: <20250818085201.510206-1-zhao.xichao@vivo.com>
References: <20250818085201.510206-1-zhao.xichao@vivo.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 16:52:01 +0800
Xichao Zhao <zhao.xichao@vivo.com> wrote:

> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.
> 
> No functional impact.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to vfio next branch for v6.18.  Thanks,

Alex


