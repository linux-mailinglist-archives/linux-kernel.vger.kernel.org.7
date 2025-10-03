Return-Path: <linux-kernel+bounces-841369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D8BB71D2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D891889F39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7C1FCFEF;
	Fri,  3 Oct 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e7f+Yh/4"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC7081C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500303; cv=none; b=uK5LrbR8lYHWexLJi23TgiQzYZ42MHVzdm2uACvkCgeWorOqkMcDJzONgz5Wf6A33E4Zu/SruhuIdHh6jD4IPUCF8fDvz3SrDkQFO8xZFpLH2Rb61X8bklX7kgRmNLouhPGlcgHmeWUIVIhhGCYgmaGCaYhDSXuIuGZ0HFjQF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500303; c=relaxed/simple;
	bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcmVu8jbpwgMrbuWk3iEorVochjG12MOKBQnbaz/PO9MlnQfijz4oAWluUaWlzENTX7Wfxa79/JhvzDq1xzU6FPudJI082WBnEtg4nKVNh45IAsU7OFBxCF1orotifk32+zYTfiv9vzQCZ44rIRbPqmzWaOTtfhiRyTuHIfB+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e7f+Yh/4; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6354af028c6so2209859d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759500300; x=1760105100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=e7f+Yh/4xI08TH+ZaCFnzp0ODA8+QoY5uzzxWJ2DR03ctir5oPxfKL94XcXPLep951
         r9MFGcUUY/AYii/LrxcA24Jkmtc1xPgSzf9OPNOxpP+hAiZ8QSvLpzt/ZqzkHlUjjhOc
         9H+Nau8YvLK3pXjIyGVWG4kW9rHCb6UrmW4xotnIAW+pqoXv5ik+CmpGbHdlO1grMyap
         wDofKCXhs8vatpU0YqW/iy94DXDODFZrOMzH5jGwcFZ/iHkVeboCihgXe+LR7wfCtYzS
         f7jvr6/2rAIcV8AfEnGR2eYpvr71plCXdrdKR9a+dgA3i7M6K5g+yPdYl9h6N/uxsfN6
         HXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500300; x=1760105100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=ejYYS4ZvXr+Hr5dlRJVOsnsB7418W+uOmv1yCCXvhWcA8E4LTCxGkkSM4KFi/SOcj7
         uKdpZSKgQU+8G/owPOw5DoZFcQvDNywh0YRqu3/0+dlGTTm3kWbhf494xiPuHb1PywdX
         f0gY4dkv5VhfLfkbauNVpuoRCz2I048cHs0rRt+mTEX9Oaj84AeGWtzIgcfBUVgOw82g
         3rvqS1NkkGX0Gf/Yo2ZtJ8+bSejCC3D3gTxzA8ykcvB+xnb7oYsJ+MakgdA5XRjuAqx2
         MY9GP7NPM8yuk25GoCM3GSkXBQ6QWNukklVwY7qJK62SBWiEazfsx87029evBpOLB4Wk
         gBOg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQNXwiaOK/dr2YdO2vWVpJL9dtuQeL37nEQdN7Y5B+vdWFwq61eXng/b6U5t9qKV+qfeBJ08Vi7gZQT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVXPp+5ViTeGY4kM/iFxJndgivbnqPCpd0I9k/kCw/K1Wk3Qx
	K1w77ugC/W1K6QK/JEbs7oo7cah13dIRzn+ArquPjPbtK6bwGXlaagZneuIQJVtyXC0=
X-Gm-Gg: ASbGncv3tMKgf+I5dG320czt+Dl+F+lTU28cBNqzvUmukC55e3ul79+dwLViPuX8oRr
	7G0jg8nzlwbQbN3R5miugo4/AeWD8rtDxEmEFDPDrG9uR2Ljreqs1NNCE7F3hBRiaiarSltRVVY
	Wh6ddZblGjMF6aZi8pTot8m2pwj2ssgzblOXaNKpvPtz0lTGmYwCJLcEVBYjIpQExQWRnaQDugC
	wNhIRO0w2h8xLzKqfDEWpcrOs263RPDLJKc60kLgJvXt3MLZ7SMOKvO/bBFK6nN2/yURx+haJDX
	K+YWDmTBfRWvMHiM3lkscMSUhzh/geWb6RkC4auHxtgSKn2quKAY47+R/ghkKQmEPUR7M4Cit4l
	JaGZWYlteA4DpVAdfRZl+G8hKIlM+TYoLJXIJ3MDgJYKjY9lSOYibgeMTjFTfc1ggulkiJfTPFZ
	aqM8Wfq0/t8or4HHTkxoXS5oTz72s=
X-Google-Smtp-Source: AGHT+IH54YOvJZyYdYQGXmSE3qP2IlgeXBlXhYdTBxgZJrUQNZBBNqv/BfQI4aqzb9AsdFrQGB3Mxw==
X-Received: by 2002:a53:ba42:0:b0:611:ecfe:3655 with SMTP id 956f58d0204a3-63b9a0f0194mr2116314d50.30.1759500300024;
        Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877786508c0sm437278485a.43.2025.10.03.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:04:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4gP3-0000000E5yT-3Q5L;
	Fri, 03 Oct 2025 11:04:57 -0300
Date: Fri, 3 Oct 2025 11:04:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20251003140457.GO3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
 <20250929174627.GI2695987@ziepe.ca>
 <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:33:20PM -0700, Chris Li wrote:
> The consideration is that some non vfio device like IDPF is preserved
> as well. Does the iommufd encapsulate all the PCI device hierarchy? I
> was thinking the PCI layer knows about the PCI device hierarchy,
> therefore using pci_dev->dev.lu.flags to indicate the participation of
> the PCI liveupdate. Not sure how to drive that from iommufd. Can you
> explain a bit more?

I think you need to start from here and explain what is minimally
needed and identify what gets put in the luo session and what has to
be luo global.

Jason

