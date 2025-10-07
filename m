Return-Path: <linux-kernel+bounces-844505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA6BC219B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F874F527F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773E2E88B6;
	Tue,  7 Oct 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gYtJcW2m"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D352E7BDE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854075; cv=none; b=GhILQCYURBvBSgea6z5OJnNnUs3dt90G8nUzf8NAryOz/gfch8MY3w+ON3XieUicAC1gbOor1Ey6a+FUnFSgm5D9cE+r8KGQSKECBW12P4H5o7zk/V2bpGnDUy/eUZ3LWJHGsfH2UXqDI8TkE9yg+TvpDvualkZZlcAcjhmJ9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854075; c=relaxed/simple;
	bh=rUj4e7mW96AJXx7tHHanond6R8M9cTYxkixXGkn/ZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEa7xJeEoPEl7LEug3aCyVzWVHk4s9ipJodfxQfwCx2oJe2n5V3UqFa4UUVeVEDl8La00g9OxlI5kLnWlNBWWozG2iakT4mANDJI+lkQy61kVoFgcHinu/1jnXyQ7iJ0MMdBgiRWtsgWVJyKe/K3FsOVszv8viYV6zZZbmG0Olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gYtJcW2m; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-854585036e8so668617285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759854073; x=1760458873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=gYtJcW2mx3N37KZa7zBTQNLno+q9ti46KzWNXwNLcmj90jHk6WIDmBEELERQGJ/Dk8
         e1Xtf6UFxXjkO92uGPc6l/1u/NJlK7sQbWwxhnhBFSGXz1hhR9mQEovkfGufJq8FyBn2
         BCuRF+gLqLEruO8xKMBJuwe9jEblze6wr8szxPK7lX33G3OOL6+KIeozdfUGULYJnGtI
         fI+F6Au4dpfa0KfKUaVhjFegApmp+V4k8L4j85J3UVtmyokprrsjl0mh1vh1vgE0VKQC
         fYFt6MIicyOm3vqpT28dl6xP69UiHpHADpOrdmIP85f9jwl0Fj6FGnvEGLxqB4U4kOUO
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854073; x=1760458873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=gTJZh+KrWmUDxqOWfzr52ERK89MOmxav87a+XEg4WnHVWYNT/DQrYPtQ4j9Q5Wj4I/
         Tc1X79fdIq/EebyYJ/AmHSvurssT/EdO9tH0xKoyHnRKP7fIw17gOep+bzrsXXUCqXUW
         DlMW/QKIeITAE1CVfhL4uHEpDgMUOMDiCJc9lvAuSvcqBnPqlEYfMkJQOlRlsD+QsecA
         Ez7i4jjHeoUgi+F4RpfcUJPefuKK9doTo82K7E6MYPGH/tRzUPTF/UfjXoioMzVxmDjK
         xfqopY4CCUhnwQbnFRaiMoxQOqIWdrl48rKU6qNI8A4H28fvJ9+plwOmyL/gs6757vRm
         z1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUPogl4snODgK1yj+jA2XhmB83ptzap0KFk9RyhNkLdrptx4aWbdX8tjDOPB4F4KQE3vBvjWXrXtUp1G7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqNvDmy/bqLXmv1wcWwYVXBRGGsow+9nk38qyAr3ZfrzKqqd7
	xj8bUGvNs3dQBhfnMjLuVEys56Zlt5fwLAhpkTJOXh/OvZHlwv+UNNZ8FUnwdTm1KWU=
X-Gm-Gg: ASbGncuchzXSTCsNwCsbUBjiWvY3Eo2v/AzZwfd4wMih/oni+PPzB3+o0g8H2pIbvMP
	OCfohmXgaW4wD//pLhikKwpkFz0rxM5paMM/Q4wbtUsHU/1QjUzrnWkfG/+jjH+u/3Vrpe87WIM
	kAhXIhiNewV6UpWt+EHj5DUXyTwm6K0kDCYTgnfmcDDibaYiT18gYKmUsm6/EQX6LGjU3dbsrN8
	UH1QNI78fk9gKZcY5gdtq82KybJdT5/pj32DuHyUxYRq/cCBcy2DJX2U6FxzTQB05CfqHtmB2ro
	tyg/z7pEoto8T8X5IjPh0Zja5TEGu92LtszDbUP3rI2PpIHNJMwCJzv5ZHVxqNO91UJdE2hGS+U
	ZkJdQ7JeBXRruOz7UQ/CCbmfcBF74SDpWEM32ICTg3rU4lqDwNZZLgeqjt8ZTwq1x/Q+nZSqeO2
	m83ExFphmPMqBP9CNl
X-Google-Smtp-Source: AGHT+IGIL2y2zEPuHipwkl4TUjLIYPddwo9T+ngD6WTBuoJAHtLmSJLiAwgUmeLquPIwJcA51YE2Rw==
X-Received: by 2002:a05:620a:7085:b0:858:f75a:c922 with SMTP id af79cd13be357-883502b7b36mr60557285a.6.1759854072907;
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e02e7sm1561434385a.62.2025.10.07.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6AR5-0000000Feae-1YWw;
	Tue, 07 Oct 2025 13:21:11 -0300
Date: Tue, 7 Oct 2025 13:21:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Shay Drori <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Vesker <valex@mellanox.com>,
	Feras Daoud <ferasda@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: Avoid deadlock between PCI error
 recovery and health reporter
Message-ID: <20251007162111.GA3604844@ziepe.ca>
References: <20251007144826.2825134-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007144826.2825134-1-gbayer@linux.ibm.com>

On Tue, Oct 07, 2025 at 04:48:26PM +0200, Gerd Bayer wrote:
> - task: kmcheck
>   mlx5_unload_one() tries to acquire devlink lock while the PCI error
>   recovery code has set pdev->block_cfg_access by way of
>   pci_cfg_access_lock()

This seems wrong, arch code shouldn't invoke the driver's error
handler while hodling pci_dev_lock().

Or at least if we do want to do this the locking should be documented
and some lockdep map should be added to pci_cfg_access_lock() and the
normal AER path..

Jason

