Return-Path: <linux-kernel+bounces-891094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB33C41D10
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17B254E1AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05D313549;
	Fri,  7 Nov 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9Vroep0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A331327C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554275; cv=none; b=EIh++SCIcw01xGpd9+J5zHNsKIEXz++9rDrx/NwbxeM/IAm6U30wuZtbPPc+FtjDuqeyKPYrTeGmukbO11eOmWi2/NYv3LmcAETEwfhovG+Pr1F/l1UM4mIGbl0bqk78Zb7DSR+uooKh1u4ZCkeTvQHa69MN6PhAXrrVXE5Utlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554275; c=relaxed/simple;
	bh=lx0NS/E/qPZSD31v0pm/DRx9c5hlgx+ZtrjvCPWzNgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REquErVhC+0/9rR9Nd3Qo0JWsRhhteFv6m2j1g4x3iH0tFhbYfBJceeiTVCg7hMsIx6at2eDEZ/EMVMqozCynmbbh+H39Nhj6Zu3b1M+2fOLmToUbTZ7kZ3+IExKmjmb5tVLQYN7m/RU0LbVTDZBAjnKzK8xtF7Br+7yFlffHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9Vroep0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so1318898b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762554273; x=1763159073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHTANTm1RsTB9JrdKMuaQrXECKg/gqfsbPDedt+nZd8=;
        b=E9Vroep0C/w8Yrt1BtZ1TtdVzmuGaPKwZNwCVzhttXZdZzQRLLEGVE9b0kUAc4kYbL
         3XijXKP6DaTTyWqsEYS9tW0Qh13yuIfkwXiECe19I0HjfHdce6wj91lJbCkCaqXTNEz3
         7Sl6tTLxlYZwOABBiMXLfy2b+MmlTjEwfFobZ3NR/ls0lBdJk7CuiNzLPciNuqHCh6yr
         1qbD1/E8NFTe2wh/GYGOWT3jTOj2WywyywAocalDKvuSL2Xh7RL29s5N7GzEI+QLNG2Z
         NfsXpwQt4D1vqw8Sii3UN6om1pT317m2jVe5LSbw0/2irNLljUwAdnt+8B9/rwr67u5/
         GtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762554273; x=1763159073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHTANTm1RsTB9JrdKMuaQrXECKg/gqfsbPDedt+nZd8=;
        b=O98gtdl2Ce+sRkmgw//xgNzPfVl0mXyoc029NacvuUXroHrKkZEccgMYZynZozH93y
         y0utG/pSWNcVR+oY8VD1NssEXXm283f9I0uxjBm+r4SI28yHjV13U1gLy4frSykb/at6
         0qKNDkeYveQx5bgC8qePqCmi8hg+g/dEulzOfhOD8oaLhOz8tK/dIkGyYU7QPh+UNLJ8
         XTgOMopzXKsB3xhfLqTS8GXoRT2Iovje7KGjLcPuxKiSvVcxzEaurGgq/9qXWn9f2CxP
         C1UoPyauVID8enQEefd2Lo62k5TwdItHI8JhzRf6dZXFDDhDKoQErvXn3jpvnF6N/JR0
         lCcg==
X-Forwarded-Encrypted: i=1; AJvYcCXXJ2fCrhXnoF0yxnnepiLXiF3wu33AyOLD7RrFnqtI5+HGkgfPegv+eDWtNILRQc2S23zT52TIxQW4Dkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AedY+jZmxxM07L3b2iGkiH8NIaka6wVwS5fgiAYi1eiCv9lv
	TJ1QFDvpOtiWYbz4uHdhQO++S4DQ6tgimVXEVby57PpVo4pPkaHMdc+v5/Pmo/SRUA==
X-Gm-Gg: ASbGncsq4Q5/f9YVLdiL+YG/cZFKwtVb1adqbHxGhr2K65zJ/QjwnTSlbwimUkYPx1v
	XOMpHhjloB2tBsx63vwy0Ymg2+XSs2hB6pJrP/dqGhJrPo1LyhWlQdPQean5Kc3SjeTsGYpF8T3
	Jc9pLgSBju8JF6U/dV2Reo2UkNpQX/EOLOQoww053QmxhE8uqB95tzBzlMDw2WjOTam+LasqB3d
	wSJmMYAahW0/JXDDLd8fs+N1JYWHlkJWZ5sPd5sM8/Bc7p4b2Rc5JK4O2snc8DUt4vdV4Q7nDtf
	F1PdgIxWe59ink/YdQAVPk0OEJ3dBDxQXiAaodoIfeAFm0K5PlvV0yjoNyCmBFM2vW0c9P8fgiC
	+1rg/SHXwX+jJwJ1mWbZ0tud+FO2Av45J0xn0OYSRGuUX5FBoF1vu6umjFpUpNshcTcyPDnFVwf
	Z+8Qy555TFJX787pH8ZiDizFTD6izvZNt8xwkYSN4CqQ==
X-Google-Smtp-Source: AGHT+IGJ7vPSosIOeWbbYNUyS0fjI1cnGQJX71au6Zi2Ah/itUQP/vl6gTmU5zvS7QHx5XPyRUQeXg==
X-Received: by 2002:a17:90a:da8b:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-3436cbb171cmr666287a91.25.1762554272824;
        Fri, 07 Nov 2025 14:24:32 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d1347db0sm3465853a91.4.2025.11.07.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:24:32 -0800 (PST)
Date: Fri, 7 Nov 2025 22:24:27 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <aQ5xmwPOAzG4b_vm@google.com>
References: <20251028-fix-unmap-v6-0-2542b96bcc8e@fb.com>
 <aQ1A_XQAyFqD5s77@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1A_XQAyFqD5s77@google.com>

On 2025-11-07 12:44 AM, David Matlack wrote:
> On 2025-10-28 09:14 AM, Alex Mastro wrote:
> 
> > This series spends the first couple commits making mechanical
> > preparations before the fix lands in the third commit. Selftests are
> > added in the last two commits.
> 
> The new unmap_range and unmap_all selftests are failing for me. They all fail
> when attempting to map in region at the top of the IOVA address space.
>
> #  RUN           vfio_dma_map_limit_test.iommufd.unmap_range ...
> Driver found: dsa
> tools/testing/selftests/vfio/lib/include/vfio_util.h:219: Assertion Failure
> 
>   Expression: __vfio_pci_dma_map(device, region) == 0
>   Observed: 0xffffffffffffffea == 0
>   [errno: 22 - Invalid argument]

For type1, I tracked down -EINVAL as coming from
vfio_iommu_iova_dma_valid() returning false.

The system I tested on only supports IOVAs up through
0x00ffffffffffffff.

Do you know what systems supports up to 0xffffffffffffffff? I would like
to try to make sure I am getting test coverage there when running these
tests.

In the meantime, I sent out a fix to skip this test instead of failing:

  https://lore.kernel.org/kvm/20251107222058.2009244-1-dmatlack@google.com/

