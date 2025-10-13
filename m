Return-Path: <linux-kernel+bounces-851147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F007CBD5A79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A374240816A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B32D29CF;
	Mon, 13 Oct 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrGtBEGN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F12D29C7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378857; cv=none; b=rZ1WGUBuqTIRqaxiBMMGzdXgAdB8z94IsW6YTAvQCTv8vmcjqCe84glcZ6j0LBRKNoC/2FW06e7SxYCM9yW6oy/dIuV+4v+rNSAWHfnwCzQZRAGWwMaXOGJ288f+cdfXK7ARnHqxRTynfF7j3zrWf0L5/Cawzj/eZYEZqO4essM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378857; c=relaxed/simple;
	bh=SRcEE8YV5HY2pFR30/wTx++ndvKQEjZlTLtkK+heSDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adhhf2RdT/YsOTOhV+9cLFUACEqNnIemk4i6KplBaZ9mGTITl46l9xg+M+WMx+QwHG6nz++rmEHZSp1W1LwyANwjbU+1QVIsEaWIKZStum3vi3Pg3jU26IiZnRN9UuuKAWq2bohHY8DRK8sN/NOmIZvSVJsfqs8bfxVuOy2i14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrGtBEGN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27c369f8986so41335725ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378855; x=1760983655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZVtd+3iFQaa5U7x6mzDDU8bWv6e1dDHCquo2ZcGTC0=;
        b=HrGtBEGN/4qvQZhx07+8LWsyYIRWFLMT9iRX4NrEiqcqlRwJ6/hGrJxa6x9cmvoYiI
         q63tzguqTf8/LKoNSPMv8zKMbuLULNb4cnZZYoOhtO+Pv24l278nZiPLq1ZooXrUDcxB
         W6kGd80V52PjNXM8YxRXTJx9Fv3/HgHHC39ki3S+kCBzH3R+lyO3BKG7MPk5wd6BSf4e
         nLanb83BSHi7vOe/ioquc50Vl2KjrwPxCetODDBZLPI3fdqnUyGzTe4setZJISVesZdp
         8gshEvawYukXr9nkGt5dWe6R4PJBr/wqpWZaGgkmBjg0NB7CJ0Ph2Tge73sd7C9Q2Emz
         bFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378855; x=1760983655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZVtd+3iFQaa5U7x6mzDDU8bWv6e1dDHCquo2ZcGTC0=;
        b=MCWzueJv6WEYceE+7eQTL5i8pH9YIon4K/azLIEIHHkSy6ZtXYWEsbaLRwy2FwqZhY
         TBCjEwbHuDWXfbiX425RqdMMbladioSbiDCF3ZvDT4wlE52QSbnXFtNDfCLMGRKYsWHh
         JKcDBOPyTi3GLQhC4d8LsNwa+Mhxbct5ZNDkI+Lbyq+wEdTKuzuqptX64laUTRpU/gpl
         XicKFMKwkdlkw0kgK3072MiPgtQDhhdNdVir0utRGTXyR1OKppFHwsSzpkc4M0i5Vlhx
         97xdEOM4hYfxfYwSMm5FRj9xPeqYZDLWh3N8nqXcMCma4zWrEn/5vnLqWP8KhJHPOuEN
         69Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV+vI7Qr+3Wk6ucvTV/W6dCnRZaFcdgUel5VRPy9F7AWJByAy4hY3IDH/xAGSXVdWZ8xsuQSyUn+QGsVGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyx2RM2NdiztZ4Ujocuo1YqpN1WncV7CXWph8UcAjZCmO3reH
	LGFYbn6qTVC31XVWW2hplT7egpWlj3s4wMsMOyx1HWi+pjBZFEJgxyfV
X-Gm-Gg: ASbGncvSexR4ZLJEfjKlULHHAK93cO3YEoUP284JR5v+haL/v1islRtdO/IDfMGQoA6
	YKDkYAus1+bgwxmw9PFLK7kkVjY3W7jbplNdKK1rV1uzhwnrXvSfOxAE6ikkMoCdolq3c1TgVXR
	kk1HEm11LvBMyVQ7Yg708+7KSNEP09gcf2KJ/8xLl9zxkVyUKL1JljI5YgjAIexTFC5ZACipEyZ
	5quBlNPmZdq4x+EAsRIgUzBft4wBfdL+Sqn7mzoC6+OIArG7bOb6vyXY+hBvwzcr3reNWAQqifH
	Yfz1PmmqGF0n0HfPwsDdoWDI98ym8gKFYN0nEu5QhVWqhlxp6TvWPny39PduErG1lnsGsZjswmU
	mvrejA5wuDRz8sBVhZgBCpLlGUi+qGAu9bdpThb9jpor8PCloUMK97g==
X-Google-Smtp-Source: AGHT+IF5A7W5iglqkFaWR2GaobapUU63kWWiX/eVkJjMFSGgRqOgtD7ZdUd9FH8FlDqrG6ZJvOpaCQ==
X-Received: by 2002:a17:903:1447:b0:275:3ff9:ab88 with SMTP id d9443c01a7336-290273ffcc7mr316143845ad.49.1760378854738;
        Mon, 13 Oct 2025 11:07:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e47341sm139032795ad.57.2025.10.13.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:07:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 11:07:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <df266709-a9b3-4fd8-af3a-c22eb3c9523a@roeck-us.net>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>

Hi,

On Wed, Sep 24, 2025 at 04:42:27PM +0300, Ilpo Järvinen wrote:
> Bridge windows are read twice from PCI Config Space, the first read is
> made from pci_read_bridge_windows() which does not setup the device's
> resources. It causes problems down the road as child resources of the
> bridge cannot check whether they reside within the bridge window or
> not.
> 
> Setup the bridge windows already in pci_read_bridge_windows().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

This patch causes some boot test failures for me. Specifically, booting
alpha images from PCI through a PCI bridge fails. Reverting it fixes
the problem.

Bisect log attached for reference.

Guenter

---
# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
# bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
# bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
# bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/controller/qcom'
git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
# bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resource'
git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
# good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pdma'
git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
# good: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_window_for_type() during IO window sizing
git bisect good ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
# good: [15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5] PCI: Don't print stale information about resource
git bisect good 15c5867b0ae6a47914b45daf3b64e2d2aceb4ee5
# good: [dc32e9346b26ba33e84ec3034a1e53a9733700f9] PCI/pwrctrl: Fix device leak at device stop
git bisect good dc32e9346b26ba33e84ec3034a1e53a9733700f9
# good: [4c5cd8d64172de3730056366dc61392a3f2f003a] Merge branch 'pci/pm'
git bisect good 4c5cd8d64172de3730056366dc61392a3f2f003a
# bad: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set up bridge resources earlier
git bisect bad a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd
# first bad commit: [a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd] PCI: Set up bridge resources earlier

