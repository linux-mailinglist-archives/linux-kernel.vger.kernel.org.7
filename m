Return-Path: <linux-kernel+bounces-827713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A5B927B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566C62A4CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC02253B52;
	Mon, 22 Sep 2025 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O+3Sqe3C"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D93126BF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563484; cv=none; b=K81ayTWxnn4GCMZAT/ANJ9LHIp6oF5hBeEJ/hB1LsbTzE0cApc9Rho2T4wRre8/mVy/HOwoQirHkoPmal1UB2+1Yw+l4ffIt9eipCyPN0Yega/lre/wcN3ibGDj7ZVHHg0qXHfDL/d6sXjhXpMrtdfspRBs8BopCvJ76MGttxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563484; c=relaxed/simple;
	bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYsngU54hPhsSXeTAYiHSbMtUPl7jOpdbxcGShd8aXlHLGMDfGD49aoJQYTBSjM1is2w1IO7Ip3ye3gyYvVmD3BVhFVMiTTL9XpSBZo2BzgKeMoiZPcxX3zY2888oEWZbQtAt4osw/DsL+3lU2i8lrsDX/imJVy9lHhHsCqhldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O+3Sqe3C; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-750c5378b96so2693757a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758563482; x=1759168282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
        b=O+3Sqe3CXuot+9uODJjyfKBTy9kYDZmGibSFPkMWjZOi5v/tm3dDMDcp113RgqGklB
         uf7vCDy/XOS6pHoT0XwUC2/gLMp2MbxPKtVBq85Q+kpUfOOtqBcrDZG6vFwdKf5/LJHg
         v62gAwgGz0gZfWG/HkcJG8/PVC5TQ7gGk5BgQlMq8IKgmOzI1kHVdwvI24/abFqluAsl
         sGtA/qUt+mfn4YQgOw86yAXv5EPoixNv0neavDoZ9bYhZJHz6blQkeqmAW/lqrRRZe/i
         mx9W3fy6tu3OfwJi8zhxtjbinQ9E10lsGUheE0jOAw4fSOmHEP6BO1CqRxM95qk4rEu7
         wx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563482; x=1759168282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
        b=pZ7YoRKJ3MXLWeq87tQcSL+UWplbj5AgPN6VBdBB0WxJidlpwRqf4+9n54IgIaCwKK
         pb/Aq8VeTQ7eKQ+ROhuOHo6zJQc/m+8a7BKhMhYVms05jrwcnI7JoRo6PszqYm6Wuaqf
         5qrNSx81/pr4XT3UzR7ymKj17JHlXXE+RF7mhnsPp4RFdbZvqeOhibhJuBaciHDdqi25
         DgXDetTcOjP+y6KVnUT+tA0wtELFJeZnWsiYlSgtRux03Dx9F54Wp3WFx5/1jKEp9W58
         cfCOIsVIJ20z51ImPrS594NU62Ywnp9otjxF9nMddK51AaJy5VWxJZPf/GHMJbAD7r1d
         GrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaRpu2qK0ZNbd98ZVXpNRBfJgnO3P8/rO7cA2QsE8htUQoMgVEsU3hDTlR3HZTjly1+tZSIL1XNxEDU0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yVQAksQGoMyJtml6q0TjeQTFoRKdy6ZjrR/HED8EGWkrQ42E
	WLwA411AlosHdobn0vqSjHzXJBBkV7wdvx+oJeejJ32TR1ptvRKNiS/NwdcH2H/ewv8=
X-Gm-Gg: ASbGncti6aJpulfLLlz7iqPK1AwzurWoU9MCAVqF5lJ6yH77j2xKzgYWmzntFY3kIV9
	82RfikEPUXDhuWpgBn7OeTrJZcrMR2w2qbjnLw8cqquMzWrVg3WP1Y+CnhSZnIGEioMRMa7HTdp
	5QcGh/4KxfinhAEBO+fC5BpxjxpTQukP9ld88AQq9KrsOrVFMS2EpGixQqgso+YY3zAyVaYHgd8
	93lDz2qm1Ojd5DG0IL1NZGDjBcjXU+YwDZHNtTRmL+djkFqF6zULOtBxcUNma7mnBWxh3XkTzCp
	oxIXQZEt7Fwqicfcq2LI7b7EkFx3PkrCHoScdI8sS8UFyYnO81wbncz4q6Cud0+jLms3McNq
X-Google-Smtp-Source: AGHT+IHoHwbeHyipS7ya2jIOwlHRG1IiqAe3uqF6PSNYBEMqz7YnlEdpM+nslTojj0nGh1U+2X+yyQ==
X-Received: by 2002:a05:6830:82d4:b0:746:d682:c986 with SMTP id 46e09a7af769-76f7b5e0cd4mr7967212a34.17.1758563482035;
        Mon, 22 Sep 2025 10:51:22 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-77ee58e54c3sm2020597a34.2.2025.09.22.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:51:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0kh6-0000000AlpO-2Gtc;
	Mon, 22 Sep 2025 14:51:20 -0300
Date: Mon, 22 Sep 2025 14:51:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250922175120.GA2547959@ziepe.ca>
References: <aNETcPELm72zlkwR@google.com>
 <20250922174630.3123741-1-amastro@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922174630.3123741-1-amastro@fb.com>

On Mon, Sep 22, 2025 at 10:46:23AM -0700, Alex Mastro wrote:

> Following a dma_buf_ops.mmap, I suppose that revocation would mean:

I'd investigate adding some ioctl to the dmabuf fd to permanently
revoke it. The zapping/etc already has to be done just to get mmap in
the first place. The vending process would retain a FD on the dmabuf
and when it is time to revoke it then it can call the ioctl directly
on the fd to revoke.

Jason

