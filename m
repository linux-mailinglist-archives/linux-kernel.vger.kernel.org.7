Return-Path: <linux-kernel+bounces-724472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EEFAFF350
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F743B7DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D92580E1;
	Wed,  9 Jul 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asuZQm3m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A3238C2C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094550; cv=none; b=camV4qMLbCgwA85Ns9wGFfJPN+7Eeoa6jty87wm6R2TLkvPUSnFtbngDWjOUGouoTXexcGLAy97H1288suFBQB45hdmibMxH2t5UuBzIefJLJ3ezwKfi13YGT4vwaaiu0b0ZPjACegD8m3i1aK3oDYFCMLc2FrgdIns/rCk3t/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094550; c=relaxed/simple;
	bh=XzDzRk1vGfiNCPslKWqmbDqIYuYeqD89trWJuumtsro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGyNOixCpp2o347BJKVrD9sDr1PMtfjIgdOR5E+rsHwQQdjUtHPvcnnyid3P+z40dFZv/7Mm6jEs++MjcPEEnAzHPoyQ95kq6g+wl23xZyelg0LzZBoVEIpP/Vo8hWxl/JxdGa/q8Y9nkf43x/eXx0nOZUKdqT4emGbeeQN+z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asuZQm3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIp9/NRPhy2+LTOMOMLpJCUzNZlMcoIeNR8roytz2o4=;
	b=asuZQm3mVDiWGpug/Dn5JipGlZOmNHwSTClOjV9gr8QkRtFgPNIkeCeSNjuytoO0WsDC5n
	/Gc2XCBDh1ifmG8YaA+bpXFJoAf3c+O0IPN0bz62e5BQOB+wpe8dG21fBkjOoICt0nadMO
	2W8qoPAhEjSFExhTW0CE9d9Wc6JkQUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-NwBkgGxMPumDK3tZfIC9Lw-1; Wed, 09 Jul 2025 16:55:47 -0400
X-MC-Unique: NwBkgGxMPumDK3tZfIC9Lw-1
X-Mimecast-MFC-AGG-ID: NwBkgGxMPumDK3tZfIC9Lw_1752094546
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso1333555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094546; x=1752699346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIp9/NRPhy2+LTOMOMLpJCUzNZlMcoIeNR8roytz2o4=;
        b=bQJM9g9aOLa4hYcFaSinFXAZlqa4zQR9F7WKV4iF5AIj5pyDF4jQleZ9GVld9yLJfF
         U7rzeP4B4jylpD5Y8t6Fhk8CoaRbhEUzlqpJwH4jZzqZ6bRTYaByFDI6IE9ZxPR4Ad5S
         eVqmSVLZcLDd5YhBj//ROxrOVdYXHBtJtw+3t33dMMsSH5TR5WfdpnJKiG4VM+RWqRo3
         EQ15mwBrb0JKU8OZpD5BgfHssukvFKawGjSAFqX5DGeY8K5J0JNgA1PgINjqiuTfXpLf
         Addo+w4ExMNIIWLaekKHQi+qPcKwP+dOH9g+6joVHZIcKzUoS+yRHHtqf0u4xUdjaOzi
         7jrg==
X-Forwarded-Encrypted: i=1; AJvYcCWb0YkWvCKPGRQHZM1AdTu77RpdD+ZO9WN8oqUn8x5hWEViWXUzuJX0liaNO0V08mLRbX41IIX5cd+8ZRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kjZrtQja39vI7xHIXBtaoV3n+s8R7N+lHwV5yhWodkpABRlX
	mkbPpDbTyndMI6M2icRxpLnJDWFmNjocBif1kp3VI2rMBCTWXhzI/ZTmW1p7AyXKWU7EAC7J9gk
	do9/QAarFrmNa2D0iRbYYcEUSg6DdoBffUikJSOmRTA818MXbBhfzgK++dxz9AUtNjg==
X-Gm-Gg: ASbGnctINf6QtsHpquJxbQTb/SceiFuk1sPJ06JcCrdUv6SyWFTjNmCSMAz/XiZrF40
	G9tz3IcVtXZ/64Phtt1tkplD3hOwSoHtnRl5iSHgQG2vvhiSnZq9usyoilns/aQx/QXZZwnzi8q
	8z0xITtLsaxj0L/sjn/jSeCwPDotAme1065v0GLslklr0JL/Elurbf4BqMTzYwhDb08HHmLyq5S
	0w+yHK2P+70Sg8ERNt0PqhRiq23L7A5YPtpDpfsxeadOCk3zPyNBGDxw5ulEEo2MyRMsKC9eC8f
	dYXPHA65tDyK68g=
X-Received: by 2002:a05:600d:3:b0:445:49e:796b with SMTP id 5b1f17b1804b1-454dba8d8a4mr8203705e9.17.1752094545941;
        Wed, 09 Jul 2025 13:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0EX5mCNSFaO3IMjRPLIrDmEC4QNJB9NGJ5evjYUf2XMKmpq4NVz9GiJiOeP0QPX4EYOFeA==
X-Received: by 2002:a05:600d:3:b0:445:49e:796b with SMTP id 5b1f17b1804b1-454dba8d8a4mr8203565e9.17.1752094545563;
        Wed, 09 Jul 2025 13:55:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d512c2bfsm36939635e9.39.2025.07.09.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:45 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20250709165533-mutt-send-email-mst@kernel.org>
References: <20250709221905.61e77ab8@canb.auug.org.au>
 <20250709155616-mutt-send-email-mst@kernel.org>
 <fdfc2aa4-09d6-4e5c-ae24-8d99b8bbe207@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfc2aa4-09d6-4e5c-ae24-8d99b8bbe207@infradead.org>

On Wed, Jul 09, 2025 at 01:51:53PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/9/25 1:00 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 09, 2025 at 10:19:05PM +1000, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> After merging the vhost tree, today's linux-next build (x86_64
> >> allnoconfig) failed like this:
> >>
> >> In file included from /home/sfr/next/next/arch/x86/events/amd/ibs.c:12:
> >> /home/sfr/next/next/include/linux/pci.h: In function 'pci_set_disconnect_work':
> >> /home/sfr/next/next/include/linux/pci.h:2738:14: error: implicit declaration of function 'pci_device_is_present'; did you mean 'pci_dev_present'? [-Wimplicit-function-declaration]
> >>  2738 |         if (!pci_device_is_present(pdev))
> >>       |              ^~~~~~~~~~~~~~~~~~~~~
> >>       |              pci_dev_present
> >>
> >> Caused by commit
> >>
> >>   b7468115b604 ("pci: report surprise removal event")
> >>
> >> I have reverted that commit and the 4 following ones (just in case).
> >>
> >> -- 
> >> Cheers,
> >> Stephen Rothwell
> > 
> > 
> > 
> > Weird:
> > $ git grep pci_device_is_present include/linux/pci.h 
> > include/linux/pci.h:bool pci_device_is_present(struct pci_dev *pdev);
> > include/linux/pci.h:    if (!pci_device_is_present(pdev))
> > 
> 
> in x86_64 allnoconfig, CONFIG_PCI is not enabled.
> 
> The function is only defined when CONFIG_PCI is enabled.
> 
> 
> > and of course I did build it ... which commit should I test?
> > 
> 
> The one that Stephen listed above?
> 
> -- 
> ~Randy

Fixed now, thanks!


