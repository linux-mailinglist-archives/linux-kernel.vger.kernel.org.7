Return-Path: <linux-kernel+bounces-872810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091DC12169
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393E04E1174
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDAC2E543B;
	Mon, 27 Oct 2025 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+kXJyKI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFB4502F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608736; cv=none; b=fSLIpd0D1gKMi06ULluJTfLGdFSt8MYPn2KSJyKSJsshVedex1miFEwYEClMb9kEiPf8XeC63fJOe1J6WUVWblTlaC7E48z7kLgE0mjjjP+JSpa+pjJq5ZClPjHXh1lpfwxrznkzcUQDU3RcRq8NZpA4UCj78TMKWtpKNrSy6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608736; c=relaxed/simple;
	bh=dZQxNB5KuU1XoEbzrSnnELpukG4dptgBnBVMxRq9wMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV2+VXXFjqK6dwJ2ehE9y/ShFcryJPgJWzLfwrjlHWJf7m0JA49LdDxjsaxj5U08r+eIv1Uq2U9w4DrcXyBw3bt2jQA4GEHQE9CW5uOx6r2c/Oxo+21bmNRq9svy/l1C8lODZ2EwUGNZ7jCEA854EbfX0uy+3Ym6gOapc2dC1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+kXJyKI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so5206150a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761608734; x=1762213534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEemqZcZH9VIrEYhJ5L+BJG602q+giyBc/b7QanZLlc=;
        b=Q+kXJyKIjAzWSwD/0fp1RH688+IGauHj+ukuC8YKbCNXpgytdKYZPf6RyjhKmA98H8
         wTRvDaOsofTTyuz0GPmmiDxiqW0tvGbTpMQwLQx+csZpaoaD6+JJHz3x0cQPNkVvsc04
         P26JPd2lKbJEv2pxr6+02Wu8+0c7ImvsvEcUGXZWfSZkazpM7zmSZnqWcVCWgQnozNR7
         GPscwbCk8FaXjjcZm0TK/y9KRgtiYlSCEHHSoNGLHRQu7vlDqAL83P6Q5PEHGsXYB4/b
         6oXZlLo+vumCYBX+zJkMYfl9nqlWY1SuHm2o41AtneUyYmtzF5VtfppEY94EYyyHXbd1
         C0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761608734; x=1762213534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEemqZcZH9VIrEYhJ5L+BJG602q+giyBc/b7QanZLlc=;
        b=hYLSgKqXj5CRLH5qph57chg2QsnNuZVdWclby5OdhXzUA7SUuSUvwFo2Cq+stZK5RB
         rUDxqWaPhAPKSSRai/DBrl0j5yQ2j6904t+xSts9azQCnAqM/5a1g8mFlQ6RLxRynERO
         eCSIJGLFqkKh5XUziahZnhn5ggkvq0IGs8OHlUxqSnUrzuyf1f9ow4gLdqgj4avTwzFp
         4RHrGFwHSdHLKcOr/3pnMbq3Dg1XVI7hi3ykHjJ4jgoTKJHa84gLLzTyEwJEgipPhceH
         QBmuulib6RfeZrgBfpeHnjQEsT7Ro0a2M4T7hkVWC8OpyWWKFYCwC8JB3OZpc/Ol7Xah
         Plzg==
X-Forwarded-Encrypted: i=1; AJvYcCW8mxxepSsHo7tHeQeLm0iLaY4jXwOUBtyc9gU3Y2VJVmqoDFQd6UUUE8TGffhy3WDhoe48khhm7nE5lo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUoRxRNNmtyQCuGcE0advj9ko4ivZKZceB/RyrefbznVoj3qm
	VqyUlP1zMWJuBsDeSYVAJ998ApmHM0xsKeNoIKWqsrQPQRdPF71xWCxlSyL1FHAdr82PYh+1wSV
	UvaEhog==
X-Gm-Gg: ASbGncuLEcV6LOXBZ0b0rWJsdwWaQlHyraj9UBgDd73tysC2WIGK65SvF8b1I/Mk349
	qZkGKrqqPZBoAKm+mbziyguC/Acx0o97WqLZy8goEkYuDpgVLllT2kn2LU4Eifdh0GlpSnwU6S7
	DU0RDEOh2s+fGHd+8+mSCvkPdRI+WEEVB48hRrxh4/LZmVtFWNLVF7M8HqZpBHfC/KJs8ElHOO6
	wtjkuFAsy7uxnhC04t6k0kQwpgWHYX1j7Qg653zRdUDNJs1D3KG2SIOReAlnKvPa0TtJi6W7c0J
	jipJkm11dF0m776ZpYTPOO16aDA+QwTyHNpDrtuXpdUJoMpqyv89cKgTw/OYya5+Si8gMPNFXnd
	88e5/dY+EA9RNsUS03U+X8ZvOimF0XSYtYiwc4Ljd5Jo1iy6qT4fdMlbMIwGE2Cdh2PvlcKGSKO
	XTpkTJrj6ldFRIEQjEMITCXNv2zt3KYeBp2dVYvJW5OVufEOMKNwK9
X-Google-Smtp-Source: AGHT+IH0Lr9nFodnqzO98adK3x0S7wkfdClpnJx8lhGHPtPd/KFUnH4pAfX8+j6RSORZT40CKGzYhQ==
X-Received: by 2002:a17:903:3c4e:b0:267:8b4f:df36 with SMTP id d9443c01a7336-294cc77bf41mr12486175ad.29.1761608733609;
        Mon, 27 Oct 2025 16:45:33 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm93624045ad.93.2025.10.27.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:45:32 -0700 (PDT)
Date: Mon, 27 Oct 2025 23:45:28 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] vfio: selftests: add end of address space DMA
 map/unmap tests
Message-ID: <aQAEGNLbiCFhq-LG@google.com>
References: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
 <20251027-fix-unmap-v5-5-4f0fcf8ffb7d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-fix-unmap-v5-5-4f0fcf8ffb7d@fb.com>

On 2025-10-27 10:33 AM, Alex Mastro wrote:
> Add tests which validate dma map/unmap at the end of address space. Add
> negative test cases for checking that overflowing ioctl args fail with
> the expected errno.
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> +FIXTURE_SETUP(vfio_dma_map_limit_test)
> +{
> +	u64 region_size = getpagesize();

nit: Add a blank line after variable declarations.

> +	/*
> +	 * Over-allocate mmap by double the size to provide enough backing vaddr
> +	 * for overflow tests
> +	 */
> +	self->mmap_size = 2 * region_size;
> +	struct vfio_dma_region *region = &self->region;

nit: Declare variables at the beginning of blocks.

