Return-Path: <linux-kernel+bounces-899873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8AC58FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE99F35F9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD135A15E;
	Thu, 13 Nov 2025 16:48:25 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F1271A7C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052504; cv=none; b=awYgyWgSgkTql0/3PDd5LD17HQKEiYW+HxUCvsyEWCNKN2cX815YOEtGW69OpphUHFxSARPO6SEKes+nVfSa3aCL0YkIMY1mS2SLWLoz7KW+qg/6nP1Fxge56osd3jC2yVnvMjBB5rkS3oUF8prdTRKYp5/BZ2OfnwaQuJJAoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052504; c=relaxed/simple;
	bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA2pW8Q9KQYa20bDXyHECNEFdZ4+vnmujsHtypFib8HR0zCdhKGZdDqlplO7HMZgwCz0XiB2leyo/6ArkdxiZcNgDZHJoV5Wl0UEsxervfPK4rQa0Ca1ZW2T5z1RZ1B0ic3F4B3zj0HG+4dokH8Rj1mCus5/vpy5T+qNdHLhGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fa4808c15so160513b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052502; x=1763657302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
        b=JpJJZB9g/QZn/O+KnlbbWKhxQjodJpPjsDqpKI91+Vi2jqc3HaFGCDT/p3c+Ypg/B9
         MQ8b+AdwFRgnQA/pAev/Th/6FL0PQk0MTubmSeE2KBDMjBKVoZMP75Ju/SJoA/Jf8Vn7
         UmLpDZy9BpiI+L5yuq96096i94bHlwUgoPVCdmeNuYlwE6QwCtbOPmtmUksbR1BdoXrd
         n4y/c4PV+HCYuaCLiBzypmcSRGU0zeCW/D7quqkuJM2wHKLs5Z0XavG0TCY8io6ioaz+
         SmTjQkV/4PwVFxGglEZtmZXfMXYXH117uBJgsvsxuYLhn8MnIC5+RQ4K8nOvntWj8SWe
         MXWA==
X-Forwarded-Encrypted: i=1; AJvYcCX+kB1yH/pbPKN27I3KcB8LlUr/4oL/tV3GQPCpPwMzuQIGudAUrtTsEmfh/lbd3w+eetOTQ+nsoSssz+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5H6fjxeJA1VSkGEXkX2ncnuAIHY0lCaXFG44EZbt6Y8gDc1HC
	up9WaEMaNIrfqBdUzkKYGLZfDt1kOjU7QXKtlwrYxNz+eAXCWlvu3WAT
X-Gm-Gg: ASbGncsyBeT5WVpcuGl+/ajep0GUol+43gdND5tqawBYnqS37Vsq2o6PUY4lJeBnplY
	JB6wBSdxM+auaPtzaCjn9AyUQ9DjWJfSWd+cJNjL/Ukg/Oq/ZWBR7aiU5ghloNuIQ3x7Jj2ivWg
	KOeIu/x9jwPUUZW3nA4ts8SS9mLQ8Xb3QQKkQY6yMb4itrdxsUMYoCrsyr6LW+8VWbrtDBGRgHo
	siKSCmkn2joWZ8LPOe0JxlNpu7Eq3SJzrzuFGeBXRNlMqqyw3a6NG33XTyT0FhPMf3plBl5202P
	DZgQxg/m83ZzgEMKYo6AKzCmZAx94LmJgghnqFAuVFmpUhJrW3ozypg4t0j64nbIviZOTdjemNN
	0AbKE65FhiKuFR0qVcxA+bnwdJfR80O3EkNf45lYZye/40ckgZbN7e6jc+1WE9WculpQmsiwjlP
	2Js6q6A1eE8tV0cA==
X-Google-Smtp-Source: AGHT+IG9TDGsXXH71ZlSYsT4b04gTMVdrIDzUOCAbUC+AwdHftVnv0Uodlv7OFGiel08iPesDyqhlA==
X-Received: by 2002:a05:6808:228b:b0:44f:e7bd:274b with SMTP id 5614622812f47-450745acef7mr3902165b6e.55.1763052502220;
        Thu, 13 Nov 2025 08:48:22 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a2e4af5sm1261843b6e.0.2025.11.13.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:48:21 -0800 (PST)
Date: Thu, 13 Nov 2025 08:48:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool
 API
Message-ID: <lto3b6lf2ic6ajph74ljo2ibpmoltkgpswfbvcprx5pr3iqfoi@67u4olbyq4km>
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>

On Thu, Nov 13, 2025 at 08:46:02AM -0800, Breno Leitao wrote:
> This series migrates the mlx4 and mlx5 drivers to use the new
> .get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
> ethtool: add get_rx_ring_count callback to optimize RX ring queries").

This is "net-next" material. I will update and resend with the proper
"net-next" tag.

