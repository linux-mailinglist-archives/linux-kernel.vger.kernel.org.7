Return-Path: <linux-kernel+bounces-876442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115FC1B804
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730EC188F3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156C2C234F;
	Wed, 29 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="idCc6kMJ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9652334C10
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749360; cv=none; b=ZZ5vHnx8fI9sA4HOhu6GOFECLaVlYyuF4FnJxMH+P7pWS105KQrIfOsQ6Hq88A4ucvkB2aM4aF023w035rD4oZd/Van6CAROgD3jKp6+Vi15xjMuuH0BIRTSm2Q0M4wi8C64+auUn6ZJAkAgsyedABBCWNoyE6D5yH3OnGYgrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749360; c=relaxed/simple;
	bh=LVDOSOST8u4Nfu2BG/Iq7jmE5BNR05dhwuHtLdykbwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE6U7jM8wsA47t3YUNp+aHFk/ez5uruYjYevuRxIg+hzvj9z/76DOe/CQnfsjv9ZKvoVo1Q/KzNrzn7qf2X20FPYFuzgEfagjnl2dxGOE/+RQXhwMR4EJYveDGx9YjcQ1n5FCZdkvTAoOw+mvcr1LGU/V6ltfKNolz8xOgfd2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=idCc6kMJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eba6e28d06so34074451cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761749358; x=1762354158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iISKP7x3UPKOETShrQK/0bkxS6KgyI1/wrp9P7Ly+SE=;
        b=idCc6kMJ5OX2/loi33NjmQq+oQFKDCXy2peS591P3/xWxnLGHtK9i2J6d6lW+KSqrK
         RZsz4Rs+LMwEmf3SwWFLRL4YAheXxt9wuF0Ev4J4r11OpITLaF/FvDzeVNR2eNYUxgnE
         uPBlBdQH9wiGuV6lfnIhRY4qCBGILQlOYHd4BfSKPYS8vVmzm8mtYUT7XEZpEP7VfTUO
         QhJNCLXTsLMCDhjQlcG1fL8FXEolxPeSGvR+uZvQNTvXz+u36Eejr6RHUP6OASuBt2Sn
         Ynyg1MqvJ9tiT8lJtCiYMYc6iAQQuqX2u4GLa7Nm9uI9jQmLhxg8Up5ivZydC1SQ5R8P
         BOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749358; x=1762354158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iISKP7x3UPKOETShrQK/0bkxS6KgyI1/wrp9P7Ly+SE=;
        b=o2gLJ7qslQ/7zRncJE9U5gcY0Xo0PluOItTBBob20Uq3q9+FjzWg0Dk0dnOuAkYgQx
         yAOvNz4DhWxBLr+vRfc8wkyPp2eS0OGdQazZr79bQXYTeNf42b1G7m7YU9lsHijJoHlB
         xzp/Ee3VyxZwM6asjNpDbiZ8HjZitn65Ku9XMjtAnFPrV4ESw7ZXa23dJ9zDihNwcb3t
         IvsOpAePpLXuf6/29re/nYhvmYlz59mQzV5sIuZFvBjcK3unTr6GAvnELLuO6NmQ7Z2Z
         szx4XqS/V81xmjednmPs4jDiPCwlq73SrtDWYByCt+tWGpg2VKH6Ty0svNwCKqnTNLDu
         R0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUYqcLbAJz3aO9abX+xgqYWQHo0gmfHqw4b+dkB+Hp4EsbUOVCmHof9YkpDLWIT3PabnoNb6EMBYZACELo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoloEZyTfry3g9jRNzu1wW7GQPwcs9tQCe0l8EmwVjGBnNaJP3
	90OwdQoSt4PMej02JVTR3hdfAzSw0pF4oeBN8FyZwEzo259WVqpjLafy7o8Q+drrCYg=
X-Gm-Gg: ASbGncvJ4vcovmX757erkdiiLyIezDLIlJaq2vvBCqN9ZqKOP/JsA2VbphCiq00lpyU
	GFhPRzeLok/GhRPFBlKQoPYR9L9P7DXJ6Ww0qwB/jyXWaSTN/4hr0x7Di/5LHtrLJvL62RDELT3
	+DRmT0ApLGIGEBKJ8ZCJjvOAKqvG4rWnAFQbihhD5JZqab0zl0czaDQca5bQmuPxd58mvJAIrI1
	WnCqfBkMCCWM7dRA+je2XNGo9V7jnOmNWF2VwcCrVgjxwzlarrsJcz1bZNzdo4gy8x0bgsaWN/6
	Tuks5IQ/1PjaUgkv8nP+VuJRvCaS9SmKnSxvE1XUvC/l3yCXQ5MMEfYGfq/qr0ue8/OhV/AWtWH
	PBnQXTyaZETvOmPcWfnAzijpoKQDHBJUbs6ZAuNgI9TVbCFN7DpgXVGHXEwcVWnyJd8NkgmmNdj
	ssUsvlx1a6ULDJj7bhgEZL6Y1ZumrDGcTeNtD6H0AITyCrOg==
X-Google-Smtp-Source: AGHT+IGAAbKXStPcrBPkR96V/nrI2ZGs71F29pgPwstoIUUELR36JYOQngJk/QufJryI6FDa/XMxXQ==
X-Received: by 2002:ac8:7fd3:0:b0:4eb:a0aa:28e with SMTP id d75a77b69052e-4ed15c98020mr39171771cf.64.1761749357598;
        Wed, 29 Oct 2025 07:49:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3830f16sm94694131cf.22.2025.10.29.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:49:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE7UC-00000004fDD-1zy2;
	Wed, 29 Oct 2025 11:49:16 -0300
Date: Wed, 29 Oct 2025 11:49:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in
 iommufd_ioas_map
Message-ID: <20251029144916.GO760669@ziepe.ca>
References: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
 <20251029133434.GL760669@ziepe.ca>
 <a63db6a8-e9d8-4f79-8212-8710ce2e60f4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63db6a8-e9d8-4f79-8212-8710ce2e60f4@linux.alibaba.com>

On Wed, Oct 29, 2025 at 10:44:31PM +0800, Shuai Xue wrote:

> We run different VMMs (QEMU, Kata Containers) to meet diverse business
> requirements, while our production environment deploys various evolving
> kernel versions. Additionally, we are migrating from VFIO Type 1 to
> IOMMUFD. Although IOMMUFD claims to provide compatible
> iommufd_vfio_ioctl APIs, these APIs are not fully compatible in
> practice. 

Well, it aims to, but we are not there yet. Hopefully in the coming
months the MMIO to VFIO will be supported in type 1 emulation as well.

But broadly the EFAULT return here always means the underlying VMA is
incompatible with IOMMUFD, I'm not sure there is that much value in
further determining why exactly it is incompatible.

> Aha, I see. Thank you for pointing out this issue. The check indeed
> needs to be more comprehensive. Do you mind use pin_user_pages() as a
> precheck?

I mean we already call pin_user_pages deep inside the mapping code and
propogate whatever error code it gives back up to userspace. If it
gives a more specific code then it will be returned naturally, no need
to change iommufd at all.

Jason

