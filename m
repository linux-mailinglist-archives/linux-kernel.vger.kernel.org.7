Return-Path: <linux-kernel+bounces-724462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72BAFF33A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D7174F33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02180233152;
	Wed,  9 Jul 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIcONQj+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E52248BE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094229; cv=none; b=OeS/nVgUeT6NHarxgoMAQjVKbpsRcpM7R4EFNvEHetTkaElm0AE+PVCBcdZ1aHIK2awg+X2kqiXzuQK+acPvKwdM/RIUi+SZXNo3F5G4kXQA9qrLEpXAOpuIEdJOsJNQ9tASCXqBTOa5UzUcibHdDcV2BtG3euW5wfgFTAjdP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094229; c=relaxed/simple;
	bh=dXsy1nwJMil3V5ibAunbBr3IEBBjhhxGSOUdoapYhO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s221P0NfQliCj33I7jFHID8QurCOeW4ddKFSyQAxN02rcFSfRQQdvBZ5PJRA1YD5cGdBJDmFB19x+DPhKPiN12wb/WVUATHaGpNNPj4k1x1yEhIO3tlIRSWN0yRMzXKS6TN6mg064uJ3MBzYThmc7yPA99TSrjjaMzLI7Dz08lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIcONQj+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GYRHoCEf/DQzfmb/qJcWsLMdU5DARjayganG71lR7g=;
	b=SIcONQj+m+kghC1uva0s2k7smzswlhWuXn5f0XLWlBijx53//B4/xDB2ViuX7yLxYJmMqY
	vXfTUOzqe5QmRv6mSx8pmSm0yKMuAU/MjG/2S6Km1s1cvq/ErqtXhdNuABk1jHQW92FV6w
	sl4rYrVI6tO2ySXrSH7iTEhNdd+tNI8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-kuQD907wP0qLS998FhR1sg-1; Wed, 09 Jul 2025 16:50:25 -0400
X-MC-Unique: kuQD907wP0qLS998FhR1sg-1
X-Mimecast-MFC-AGG-ID: kuQD907wP0qLS998FhR1sg_1752094224
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so119144f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094223; x=1752699023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GYRHoCEf/DQzfmb/qJcWsLMdU5DARjayganG71lR7g=;
        b=OPqHQiRObzL4zMZEKOlL3O1gkpxxbbWSHNCtSVXJ/C/M8Mv7B4X0ZV75ix9aADX1E0
         X9r8LyhNl+GfnOzBAuuxLShRKnhn8lfNvNRQb87dkwgMpNmGNvtqA0zjHbvfzhIALgsy
         y3Pz7AD1gGPXdtDlQVIGXjSZ+/HufymXPiYnyp+0ijfGeHEUmgW9RCfbKI1PNwfA/PEt
         FfOMziwno/66BrrMbvYLUIWd0YKjS1O/ZiCinD34PSprKQM03w9YkvKxtCNtAbxqkvno
         OJI1LTFNZzp2zLFZu34mMjz0OqploUAFqg9TbvFt2aWkhr94w58OtJeucOxOyapLEUrL
         R/yg==
X-Gm-Message-State: AOJu0Yxt/UWbQ9Vx5GnXeeHCne+xEFATxD/ygY+q7kUFggnWnOzGtKyv
	Vq6ONtl/Y+LxKl7IGyDB6PGnC7yTK6nxaHJ8vH6SUpwdyNE/AolTWGhXkDmvh+bb2Un4zfeAgOd
	0q9KklW0dfSf3mRo9hGHerzZUw7HakJ5d+e6TMcVnp5dkM1UIHP7ZW3gSuy3Ku8fJnmv9n2WcPg
	==
X-Gm-Gg: ASbGnct2B1FXvJAT1QXISyr6vzT6dCsXSVbykYd8ihMD9M0fi1mpJFnk6KSs9WM0/WA
	9AUganmEBV+cyLwZfHBYAuUQOT39hhBgJAcjm+EjoTyz8FI7uPWqQGLoa0ZDpHzQL2IAARvTcDc
	YFrU8toNTTJW0DQvfJuBBtQ1u3p8P3tckD33txziWzvAXCXNQNcJAeXEB358h4qP2I1UNmsx765
	zDbZj8tfkE7tUS3YTwLSxNJVHPperp0N8my+XqsGCEz/HhD9vSqRfJ0o7km3mvJc4f9h/TejI1F
	Cr1TffocOnXbDrY=
X-Received: by 2002:a05:6000:2a85:b0:3b4:9b82:d44c with SMTP id ffacd0b85a97d-3b5e7895ab4mr891750f8f.22.1752094223651;
        Wed, 09 Jul 2025 13:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1w3J00YPL8I55yK8bWSN+SXYfjvI3DXscGYJTRL4cPf1Ou6B7lHV1yBOavQwWmOlOuh6yQ==
X-Received: by 2002:a05:6000:2a85:b0:3b4:9b82:d44c with SMTP id ffacd0b85a97d-3b5e7895ab4mr891741f8f.22.1752094223234;
        Wed, 09 Jul 2025 13:50:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50503c4sm39872225e9.11.2025.07.09.13.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:50:22 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20250709164820-mutt-send-email-mst@kernel.org>
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

got it, the issue is !CONFIG_PCI. Fixing up. Thanks!


