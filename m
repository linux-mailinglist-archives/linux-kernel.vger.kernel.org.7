Return-Path: <linux-kernel+bounces-842021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F59BB8CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B82E34E1D4F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7226C38D;
	Sat,  4 Oct 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="q+orHalW"
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08C1553AA
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759577192; cv=none; b=HgIVlyHt2z+MmQ03yRyWopTRPFrm+uDUOJp5i4cxjGGBf0Vnd3IjuqkuvOMRNit6kT6wHHDd+T4xVHyDgp6/6Dw5EOxtywXsqRv0LJKW79xNzDpzwYq3gDshT59GZY9zGUaqJ+IEdj2kwbxdzgZzNIEN/S7O3eR1pziMXq1+pYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759577192; c=relaxed/simple;
	bh=Iwn5YQ+gxKKr8W7MSqMYv/B8lWIPv5rbzN9d2kCZq7Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oUjzP84Pk4owQF/rTWlLv484okxxVhmG/RGNir36CVNc4fi1PceufXS8EjdALXxgozQGJ3QCOJEdy5CodSBp7BpGmvB3L5KpHqog+8a5v6vrULJoDYvDStbc1bxjP3g/6jlXyywqE7ub0K2YFFz2U5RdJg/EUqCTAQxD0Lvtois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=q+orHalW; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 7A17DCB1F2C5
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759577189;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=Iwn5YQ+gxKKr8W7MSqMYv/B8lWIPv5rbzN9d2kCZq7Q=;
	b=q+orHalWcLCLTJqf7x0GLbP6wkTJeXRj4RTwmkzTvjQcBO3fWFu6O0xv3LvQG0dK
	Ch918bhPh0AFO4EUSoCa9UqMqCbaLjxTLpeJSqk0YGgP68cpu5p0C/267OxuPSzzxev
	5sLU/ULfnE+cxfEK4Zq1axbNvY0eAW/jJqYXhPFJTZlcdV6yatKndpYHhRnUDxEKB5g
	3QDrkHumymOTARWyfCERqjJHqGKBF+2+r1cCqTF6yluMiUN+Flcd1bAPFET7gvBivHo
	2T7bIoJALgfrqyf/lxUt6Phe9K/bZdqG/Qg30xCikRlCl5L3m6Xkr3/rW8N+u9tr4xx
	rrtZc+ikPA==
Date: Sat, 4 Oct 2025 13:26:29 +0200 (CEST)
From: craftfever@tutamail.com
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ntfs3 <ntfs3@lists.linux.dev>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Regressions <regressions@lists.linux.dev>,
	Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
Message-ID: <OaiyHa1----9@tutamail.com>
In-Reply-To: <d9ae2341-b385-45f4-9359-550d1118efb7@leemhuis.info>
References: <OaiQgS3--F-9@tutamail.com> <Oait04j--F-9@tutamail.com> <d9ae2341-b385-45f4-9359-550d1118efb7@leemhuis.info>
Subject: Re: [Bug] Memory allocation errors and system crashing due to
 buggy
 disk cache/inode allocations by ntfs3 kernel module.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'm posting there first time, so I through it like generic bug mailing list, but I can say, that, for example, version 6.12.50-lts a little less pron to bug, but it occurs there as well. I'm using Linux 6.16.10 for now. So, bug is present a while, but i hardly to tell, in what kernel version it appeared, cause earlier, I didn't manage that big amount of files. Again, it's okay with ntfs-3g.

Oct 4, 2025, 14:12 by regressions@leemhuis.info:

>
>
> On 10/4/25 13:03, craftfever@tutamail.com wrote:
>
>>
>> Oct 4, 2025, 11:55 by craftfever@tutamail.com:
>>
>>> I'm expecting serious bug when writing large amount of files to
>>> NTFS hard drive, shortly after memory allocation errors and system
>>> crash occurs/ Firstly, I thought, than this is bug in linux kernel
>>> itself, somewhat disk cache allocation error, but when I tested
>>> same operations on ext4 drive or using NTFS-3G module, bug is not
>>> present.
>>>
>> To reproduce a bug, try cloning two big Git repositories to an
>> external NTFS drive mounted with ntfs3 module.
>>
> Thx for the report.
>
> What kernel version are your using?
>
> You CCed the regression list, so I assume this used to work, which leads
> to two more questions: What was the last version where this works? Could
> you bisect?
>
> Ciao, Thorsten
>


