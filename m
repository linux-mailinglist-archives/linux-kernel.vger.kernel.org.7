Return-Path: <linux-kernel+bounces-752297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B3B173A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BE1C256EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75011A7AE3;
	Thu, 31 Jul 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hYYEbT29"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E593154457
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974097; cv=none; b=WbQ1EezZCAHBXaSNWDB862bVxRv7WrGLKGUbaTvDt+TmKbZ4Yxj/c/B1sVr1SZwc6CHU4PkB+I8N0eYN/3c0sB35VJr/1yqpMZ0ZTpxSvbT7ibrFfAEUKY0YsVPK60pFlhTc54SWe709wxcq/xvfMUfEoMlf3F9rQg7xUC+TqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974097; c=relaxed/simple;
	bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhawV3zFi5814wdW37lbjvWY4mxhsBH6JvonuFKj4YbZTihaI00QvBgydSII46GsUJexpcHGZkSPyPM8Lawi9cZyeha26OXsLSVQayf9mZQtke3C2wmCuS1c4ycofWmhFyPJ6ioS0XubuAPwz19tFszT2q1C/8SQUm290x16iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hYYEbT29; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70740598a9dso9571736d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753974094; x=1754578894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
        b=hYYEbT29c5SRmAjQpFlscVTc85ax69ZIeuGrjNxAnobHM1xx3S6HPpDlQiLNDGTOjl
         NNuaqlbow7y7+pcU9hCc+uNzt/13Sa8jJF0Bh2T1CV1jYceOhn6FjJ4bG4L8BkzzUAfc
         ZVjBdeTi6PqPVy8d7sXdRUtsjIlq2Tw9bC8ictmvKNT8PLHhp0j7E4XmZGIOba+c9hWm
         yh8BtTZRxy55+8J3gOOL0ijaP1ylEtCZ7kqVp91A0d391NGocgWd0NQsEsRrtWlwnetR
         7lqeQvH5uW+aH8FCA/ukEz1jgKzMvk6BO7KYKCZkmFHrgYVrEDZ8fs7JEg88f58IQGbP
         yYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753974094; x=1754578894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siuBD+FpkcpteagvwXUhGcZcBy/qT4fyxc83l1gE0Ng=;
        b=FGtqazBXKsoYM/GJ17mMAMD9QUfpLi3SKPgRzec0IGimPujvSB2d2JNaXPswqBmZcV
         d+bhdvvqIyBUESmAfQXT7FLTsV2PRb5j/a7IFOk4R7CRbp2X8iVGiGyAa1uQoXjPxbrb
         u4JDn1xq6IDjYREz3D73zI3HDwCXs017Xe4kU7xjrgtsxDZ6BS26d3l4NdL28DEt/UOe
         m0TLAVJaF+3PI9eB7IQ9BYg7lEBLOZ0mnYAiZ/+z7uSgNXurr9GXrE2sbNX2b7A+mtFm
         bXdRwrc+L9YDbARv0sVTl2tw1MM+5kwosUdtP7mEMLVsqNtUMD3gfge5JVjGVr8hX2QB
         SVgA==
X-Forwarded-Encrypted: i=1; AJvYcCWPEHnwMygceRZJCTian8dG7mbxf/ubtgfj/bhOuWUdeUUQWd1WYKf2N9j/wgXsf5PbvqzHrk5pCXtrnEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPCRho3csFZZ9OvrboVeCxqCXt3HtZgJq4ih1Fytz8eQcvbOz
	JipA7ZueFP+40TqK+JX3kzqFN0pLSMtQNVlnK8SUvnNEeEGCuFPsTYypa6bA+AtcO/M=
X-Gm-Gg: ASbGncudqpHgxj95ee2CYzqZpbWLh7hpJxILCEqFPk6j1UNXbTA8nX5ZnPbNpjvhOoh
	4y9XlDqMRRLq2YDwwUcU6lN1ntHs9W8vHrUcjfMA2JZesr/AT0Mu5VROieZdCwKQDYA956696+t
	WuPtbm6GgwlQgv1yW4RQ2trvYRumQYk5ca+1lIRdtZ9ZtiBlTrFZhW01llGUc551ZIbKqvlYsXG
	zRTOeOZVoR92fN1EO5oueD/XqmPhnalvBO14lgso0VlqPiINjZjRRTe0RuWpJXc8He1K5Zbud5z
	esE5gMGjIydtopKaq+9CPf6QFUFMz48/t7T4qwKdpKUpylPQu2vb4Q7AShbG2k39vd2AZomTGRC
	Bs5jEsXT3HMqXLv8sSH/OUhpTADDStSUxzKEvSjgoQ3wHO6BAcA8Wz+w/GFPUULSOFVfm
X-Google-Smtp-Source: AGHT+IF3QfXy1mTLzNpz2l3j8n+LbRT0h59stfgYKkxbxlcga8yiKajrseiPdkpwZAVYyKpNGhDCSQ==
X-Received: by 2002:a05:6214:2021:b0:707:5633:d6f5 with SMTP id 6a1803df08f44-7076725cab3mr110105336d6.49.1753974094185;
        Thu, 31 Jul 2025 08:01:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea880csm8151756d6.92.2025.07.31.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:01:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhUmi-00000000pgD-2vq5;
	Thu, 31 Jul 2025 12:01:32 -0300
Date: Thu, 31 Jul 2025 12:01:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
Message-ID: <20250731150132.GV26511@ziepe.ca>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
 <87zfconsaw.ffs@tglx>
 <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>

On Tue, Jul 29, 2025 at 06:51:27PM -0700, Chris Li wrote:

> They follow a pattern that the original kernel needs to write to the
> device and change the device state. The liveupdate device needs to
> maintain the previous state not changed, therefore needs to prevent
> such write initialization in liveupdate case.

No, I fundamentally reject this position and your testing methodology.

The new kernel *should* be writing to config space and it *should* be
doing things like clearing and gaining control over MSI. It is fully
wrong to be blocking it like you are doing just to satify some
incorrect qemu based test checking for no config access.

Only some config accesse are bad. Each and every "bad" one needs to be
clearly explained *why* it is bad and only then mitigated.

Most mitigation are far harder than just if'ing around the config
write. My ATS/PASID/etc example for instance.

Jason

