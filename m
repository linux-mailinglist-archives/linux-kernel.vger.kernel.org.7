Return-Path: <linux-kernel+bounces-788757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB26B389EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BE41B6549E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F103E2E9EA9;
	Wed, 27 Aug 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgsljTUm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14DB2E283B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320951; cv=none; b=u36YJaWVGFuQ6h+UAJAG+6q+mAfsGEf7rU0sgvt3SBUtiJg0xvxyZqJBrw9owzIVW6qGxqRiCV/C+djnWVToLMGuXMCwZfFFgnbVCzXqcOw574Pf5odcX2YbeMaGMwXjxezrRdiz+7Q+Bt0ZnGI8ZQ/bXAyhLY/TH0FiAc+iQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320951; c=relaxed/simple;
	bh=fm/h9kjoKAG+ylWDIGT9LVnDG68OmZkrGI+etIQZYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXdI/LCe3MoeDKjv4CKBhJ6Ab5t/rQ+GULgUnNvQPDoWllIhU3Yv9uaGt7m2AfS0a0XkWsV32Q4C1gAnBfYQ2to+iGcSgblEcdsc40FygH/Yqn0rToDXXSBiim1s26X6fuH+OwJWRMhfNJt9CPbB3/jpdhvgQB9kLbSsd+Cg+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgsljTUm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G78P2jLySbgTcoxewXgkQrFdDV/LmQT300kmZTj3Q84=;
	b=dgsljTUm4Ii2eDzrVBjvY1C/IWSs4YX+YhNlNPv5vIkDImLp9bCiZC6DZMdqGjeF9DvEL6
	V1Hhf/2sC73fwnxUSDXbMitZmdEcBk+myFMZVt/c4SBCYDNwij+IhXED7wPYsTjx57iDMF
	lNh2Foz5h8oayBfDj+eywHsGBLxOvQs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-m62ORSa0PT-3fCJvCltGig-1; Wed, 27 Aug 2025 14:55:47 -0400
X-MC-Unique: m62ORSa0PT-3fCJvCltGig-1
X-Mimecast-MFC-AGG-ID: m62ORSa0PT-3fCJvCltGig_1756320947
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ebd3ca6902so316745ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320946; x=1756925746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G78P2jLySbgTcoxewXgkQrFdDV/LmQT300kmZTj3Q84=;
        b=XXdZzXZYCFhJy+orUVYhSHuv0tdvga5urb8rPixSvT14akYnjp2f8Jo63dK2yKpydS
         C5Lqb0AVytfiroTl7RFHS8DWS02mHRMa+ejX167z3qTGIFQhtShnM1qSgqFiPHIxpNfO
         rxG9wxbxF9C5OAK5WHql4hTSeiM2SRAuQFiwwY1lTjAulL6UQBgjHG1CR8mli8isgc2C
         K3566gIv4n9QSL5u6jsXskCbsx8bvd9SPVDSeQ0MoS3nKlVKscjmqd1iXmYcoJe9XxqK
         vprlWJOsyTQv3Mr0MsdeinlIluNF7PganvptFgAuUlz8Y/H7VaXgyq/8sF3h9CB8CgmS
         XbQQ==
X-Gm-Message-State: AOJu0YxWhLH7Dk60JMMDZ+8Ex8hQo91XSak48CRG9qqtE0ZmLdZlTgbp
	1z2IGBQ3b5dtTfeq6lcvvzPlGygjnmeY9NSrwI3kwEutNiDP1lCyYRiJa3Froh9fO89u1hwpUR4
	QPcKDRXlLZy6MBkfl+BWnHB63hHCGX8MUgXLzP9CfqxPfR0H+5FQHhkjXq5K7zwLZtw==
X-Gm-Gg: ASbGnctJTZjz2Gdq5Ikwvd4twwAw7iiVVMcTo4rVVzMuOfkazYCzOwTU8mR+YCCNFwT
	X0Zg758sae2c2ZP09OOcrbUhLEVqbLZJ4IZVM6dmZ637knmOAxBv84YXNyUAo047TWy+rbp3XBH
	8Gf8moEuZrHUlsUwiBC+EBSC3i34qyxnkhK6nRKzu/BFqbB3ZJT8dlt/guQQPED8iObN8P3SqLB
	V3D3HSZbcmndxv5FRs10uwoFTKffzoBdgpOyayMITNrH3DFd8z/YPcOyrFBc4QMpdjTHD57u3yO
	dbx78nS9V/I+869UOipDMKdn5rNrawPyarHpBa0Dmg0=
X-Received: by 2002:a05:6e02:1a28:b0:3e6:7828:1e9c with SMTP id e9e14a558f8ab-3e91fc22d89mr100262765ab.1.1756320946586;
        Wed, 27 Aug 2025 11:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8WZXs1ldaE5WPtxVBCuJgwtfvCviDgiBhlB5oMfRmOE1uzeqRxAI2n1ueVCV7Kg0lvDb/yA==
X-Received: by 2002:a05:6e02:1a28:b0:3e6:7828:1e9c with SMTP id e9e14a558f8ab-3e91fc22d89mr100262515ab.1.1756320945914;
        Wed, 27 Aug 2025 11:55:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4e45c5d4sm90957965ab.27.2025.08.27.11.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:45 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Shameer Kolothum's email address
Message-ID: <20250827125543.2ba8e56e.alex.williamson@redhat.com>
In-Reply-To: <20250827143215.2311-1-skolothumtho@nvidia.com>
References: <20250827143215.2311-1-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 15:32:15 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Changed jobs and Huawei email is no longer valid.
> 
> Also, since I no longer have access to HiSilicon hardware,
> remove myself from HISILICON PCI DRIVER maintainer entry.
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
> v1 --> v2:
>  -Change from personal email to new emp. email.

Congratulations!  Applied to vfio next branch for v6.18.  Thanks,

Alex


