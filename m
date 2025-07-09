Return-Path: <linux-kernel+bounces-724419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1333AFF28D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8CB5C034B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931F7242D7B;
	Wed,  9 Jul 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+z0CUMq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114B25A2CC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091240; cv=none; b=js3xcCahDpft5LCpdqmUVyBVcmGaOS38ZjUBXytIuK5RtCL9JL+NVQOFs/nxK4j5khp6BOuKHudGJWNx1VemXR9Lv8ninPK9sV1gDyN7nDyqZ29vFF0WuHbAoncUXVUTWLeOsKn3bagW5vDZ23a5nAUp9GkkouReo66c8sTzV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091240; c=relaxed/simple;
	bh=XRgcaPUjA2xmhy8xzFx9Agw0cbTX49MkDneqWPcRbns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDIBUyltkZer5yVc19HjZMxZeXsMw/T3xRU0ZJrcmYpzIrn47jRns9jqxfqXlM6twavfY0OAyzxUkMnaa6AsRVZI1egNDVU4376Fkv517Y4TKWw0HWXUKNa9pZKc+fPUYOOatdrg4Vu9FMHXQoOjSh8MepgGgWklWiR8sIEaK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+z0CUMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752091237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KEO+y01DHcpAzZ1glkzdPAC2WZqiXMak0HQsMG2O0i0=;
	b=h+z0CUMqZkwLeJgmke2d2RmrjTr9TRaK65meoTE3H5CvCs1yBbxT5+ELCFjw77YRr3e5x3
	EZbvaN+ZbwVsv+Z9RasVXykUAPDzzrRYqdd7UzfL6vGx0FJyavcMWFac6+URQ85WIp/Ni8
	MCBoRjgy6bWqBGC1bFI0Z62ZPXhfnY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-lWP3931EM7O4_MeXEeIwYQ-1; Wed, 09 Jul 2025 16:00:33 -0400
X-MC-Unique: lWP3931EM7O4_MeXEeIwYQ-1
X-Mimecast-MFC-AGG-ID: lWP3931EM7O4_MeXEeIwYQ_1752091231
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so943075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091231; x=1752696031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEO+y01DHcpAzZ1glkzdPAC2WZqiXMak0HQsMG2O0i0=;
        b=f7IEyRWkvyZaECF2pkXSZJvUKxKlcqq1262QX5yRttdK/mZ4JERbVvvSPvLctPzo8L
         RdZVgJ07J5IZ6G/nIvSnK4hDaVA5bnHQhfVYWlyzEJ6wqda1Vd/oxJCLqVfSFaIzPZfc
         3B8GHFdhIYKUwntfR7L7eu9LG9ck8mMNJEbRb9Xzg/Zb8te+kSLhT4SNhSIkbeZN32ZM
         lK/Cxxwg2WuGztbyZhi6Qzdskx+iA2ddmmxmkVNwsMCWI0miTeYmcKYqnSM0zIVb0PRl
         S4M9xvtl1nc0mfkGkLi9UHGNOR+HWNIr2rsVGAStCeMZLonHt2vwNkwGt2Ty4Wq1pvKS
         TeHg==
X-Gm-Message-State: AOJu0Yzhn3OD7UVrrHG/z1kZgo1CHfVbEVGv1j5MSRZ4lJ6z6U61iw+0
	UIZ7oVb9Jg82zvSMlg8dU9QeWP02SFemsBiObJjJt8ZBbw1E7hhm/nhlkih/gxQUr6V8vP/wHFO
	OoJcp0NOMNsbCpLRTblQ43O5/cxHBS96q3IL9yzBIKiOW8hbKMAnS8gboC8C2XXpmpQ==
X-Gm-Gg: ASbGncsMzWoaKBhIHDpYjK9oSf5I3WUN6BdGcUPna2n3t1j88ckgbjkj0d0oa5hLQ28
	CVCNPaFoGTpZ+JR7kc7L7DJaXu8uAtltyND40sd5CIYrdraslo0exagzAXvvgJkBTae9KLa2qtF
	1n+OaTLYM7gfMcyKM69nsgFrkUPzdDHhXggO6cqFug4oOWMDLlqjoHxbqvMH+zM/BBMEHXY+PLU
	k5ykTsELa7iIgdW4zkFfiNxgLyzOdcz73EJMEPZ4ce/j9KYw+aV1AVgJgm5k5S7vhGGH06VsMJQ
	JHWWnBpvRYxea/g=
X-Received: by 2002:a05:600c:35ca:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-454db8307c1mr8031615e9.32.1752091231101;
        Wed, 09 Jul 2025 13:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6EqizbffultQ5UtCg8NuiwKwoWE+lK/p3pWMASqoLLv09C1oxwgfQ7sLGmuyt4kakXife3g==
X-Received: by 2002:a05:600c:35ca:b0:43e:bdf7:7975 with SMTP id 5b1f17b1804b1-454db8307c1mr8031375e9.32.1752091230750;
        Wed, 09 Jul 2025 13:00:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472446fddsm17151822f8f.66.2025.07.09.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:30 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:00:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20250709155616-mutt-send-email-mst@kernel.org>
References: <20250709221905.61e77ab8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709221905.61e77ab8@canb.auug.org.au>

On Wed, Jul 09, 2025 at 10:19:05PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (x86_64
> allnoconfig) failed like this:
> 
> In file included from /home/sfr/next/next/arch/x86/events/amd/ibs.c:12:
> /home/sfr/next/next/include/linux/pci.h: In function 'pci_set_disconnect_work':
> /home/sfr/next/next/include/linux/pci.h:2738:14: error: implicit declaration of function 'pci_device_is_present'; did you mean 'pci_dev_present'? [-Wimplicit-function-declaration]
>  2738 |         if (!pci_device_is_present(pdev))
>       |              ^~~~~~~~~~~~~~~~~~~~~
>       |              pci_dev_present
> 
> Caused by commit
> 
>   b7468115b604 ("pci: report surprise removal event")
> 
> I have reverted that commit and the 4 following ones (just in case).
> 
> -- 
> Cheers,
> Stephen Rothwell



Weird:
$ git grep pci_device_is_present include/linux/pci.h 
include/linux/pci.h:bool pci_device_is_present(struct pci_dev *pdev);
include/linux/pci.h:    if (!pci_device_is_present(pdev))

and of course I did build it ... which commit should I test?

-- 
MST


