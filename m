Return-Path: <linux-kernel+bounces-732117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61943B06238
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0E1881A40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944813AD1C;
	Tue, 15 Jul 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbN/F0/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32C1E832A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591496; cv=none; b=UPzgtf4KhcYuh1F7lfiTRKv48KzYg8rnYMqas8W2d8TXNZpMTvdL67yaE5hN76o22SosCZj1GgeZdWQFU0BRd4J+oZvAoN+N5jAGg3UlQWiqhlvkQIYvVWCrJqX8PyB9TQCm29sMol2l97dY2d0HN562WD2RxapPWXzuCGVP4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591496; c=relaxed/simple;
	bh=M8+MSuTAKSrCgCVtMy/iUPaoVEAQznYtaWQLPB0t2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3CWbSNbnJpVdnRQbZm+VrG0GBy/iQB+C9E5QH/lZvZwVPgvp0OhsvTdNMye/peatsMa8uXTFU69mKQ9UpaGU59ewAddnaa8zeSMGRVOQraBLPBHm7PqzC/lFo9lM6N2uDZrk41vPXhUAqEvBKXyzbzglqV+FOVgMNhAiS6odBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbN/F0/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8229CC4CEE3;
	Tue, 15 Jul 2025 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591496;
	bh=M8+MSuTAKSrCgCVtMy/iUPaoVEAQznYtaWQLPB0t2Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbN/F0/Pqumr8sUD4Sgs6iDjiBGLpx6+InkYoibQ1Xjk1kQDqVCzIH4x6LtLvsW/7
	 uPOr+mQoTAUS8ctQeLMifJNy63G/leF4fhpN3Hl+vxQ+uDlMLryK0sl8BM8/Avv4U7
	 gwmeScnXtnO/mFBm7u+5m1yosjoBhb0NFPMLrN+85avZOftDCal/LzpKmINjixYdzB
	 5jbqE+EMGaqD57fBF3e4cRADtmZ4y966WXCmwz3vnUmo5p0aVodZ0LU/0XzZyogJAR
	 aZeQbmeHZzwQMo/dAUHlzGh1iupSjPUt37KHqGVXVhOSf5wZ2lVgbDm3PeDQlwSXQz
	 ctHZXgvimQGGw==
Date: Tue, 15 Jul 2025 15:58:11 +0100
From: Will Deacon <will@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	sami.mujawar@arm.com, aneesh.kumar@kernel.org, steven.price@arm.com,
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com
Subject: Re: [PATCH 3/3] arm64: acpi: Enable ACPI CCEL support
Message-ID: <aHZsgzNYwfCljX-G@willie-the-truck>
References: <20250613111153.1548928-1-suzuki.poulose@arm.com>
 <20250613111153.1548928-4-suzuki.poulose@arm.com>
 <aHZeCKNyDeZEsuCt@willie-the-truck>
 <bf56dab4-8a11-4e91-b330-2a8126c94acc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf56dab4-8a11-4e91-b330-2a8126c94acc@arm.com>

On Tue, Jul 15, 2025 at 03:38:41PM +0100, Suzuki K Poulose wrote:
> On 15/07/2025 14:56, Will Deacon wrote:
> > On Fri, Jun 13, 2025 at 12:11:53PM +0100, Suzuki K Poulose wrote:
> > > ACPI CCEL memory area is reported as Non-Volatile storage area. Map it as
> > > PAGE_KERNEL.
> > 
> > It would be helpful to have a citation for that. I've tried digging it
> > out of the ACPI spec, but that pointed me to the Intel TDX site and I
> > got lost in whitepapers :/
> > 
> 
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table

Thanks, but I still can't spot where it specifies the memory attributes.
I think we should be able to refer to that as justification for ignoring
the attributes specified by EFI.

> > > Cc: Sami Mujawar <sami.mujawar@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > > Cc: Steven Price <steven.price@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   arch/arm64/kernel/acpi.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > index b9a66fc146c9..f52439d411a0 100644
> > > --- a/arch/arm64/kernel/acpi.c
> > > +++ b/arch/arm64/kernel/acpi.c
> > > @@ -356,6 +356,11 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > >   			prot = PAGE_KERNEL_RO;
> > >   			break;
> > > +		case EFI_ACPI_MEMORY_NVS:
> > > +			/* Non-volatile storage, required for CCEL */
> > > +			prot = PAGE_KERNEL;
> > 
> > By "storage" you just mean memory, right?
> 
> Yep, it is just memory. I will drop the "NV storage" and simply mention,
> CCEL.

Thanks. Also, why don't we check against memblock_is_map_memory() for
this, like we do for all the other types apart from
EFI_RUNTIME_SERVICES_CODE?

Will

