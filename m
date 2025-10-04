Return-Path: <linux-kernel+bounces-841984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DDBB8B73
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A119C05B8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A5A2222A0;
	Sat,  4 Oct 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="o+mmHhno"
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D471C1F0C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759568123; cv=none; b=RHmdBKN1TLZhrVL4UNWe/DEm/eeBrMxscyJj+8EQ1ftbDyMdRUDXElysG//UozXCLt4KLqVTqFS1s+B5DcmJ1aiVZWlGFfu5oqmTUDxGpLkHHAbEc9K7iNpVXQjreqJjyGt5nyXtJfNq00aT/Vq89lTwKRjPo+evO1gDCSrV13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759568123; c=relaxed/simple;
	bh=NdPrNhN29SUk+sp3WiejdjpFfYVI9ZIvrbHDdEQ0S5Y=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=c/+iqnV1QkBtL4XS83QmwLoLykJpw6W/4fBVeLCKldXmjNIf+D+h8nEfe7ndzPEAy6yNyhIxhQ2IWaP2ELYPTMuL0pC5wX48ZvWxEK6LfQ53H2dbHqhf1Jl+YWU77TZwGALobkAM3yrV2bDikvfOqRFuS/prQ4kvocBH0mHdjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=o+mmHhno; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 33B4DCB14077
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759568120;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=NdPrNhN29SUk+sp3WiejdjpFfYVI9ZIvrbHDdEQ0S5Y=;
	b=o+mmHhnor/CU8uzLjUUIdsdDQhgREK+7Jh4P30D+kba+/56BFUZ2NIG/XPH+gaaV
	reQlPxp+5lpZq5T4PApWGpE2CXasJklGhTWP9rG1RfeivoivMqMlplGLXzE0jFIubTJ
	+axNo+Kwf3fn8a6ONJ3ScfNaXnTZILsPN1MR/53QrKQDG/jCRqyli53oevELLdJRjI2
	2dcbfHDpeh9mbjg27gzNc6Ld2GIMzg0M4d/XmYWoYg19rwZUkCAtRzsQBiQC/asSGJO
	C7u14SW6x2ZOg/G8ZmRRIMMIDcjS/J51IiKi2zxjbe/6UYfqTvav2qJnX87PGSc5a8S
	NW8PWIiFuw==
Date: Sat, 4 Oct 2025 10:55:20 +0200 (CEST)
From: craftfever@tutamail.com
To: Ntfs3 <ntfs3@lists.linux.dev>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Regressions <regressions@lists.linux.dev>
Message-ID: <OaiQgS3--F-9@tutamail.com>
Subject: [Bug] Memory allocation errors and system crashing due to buggy
 disk cache/inode allocations by ntfs3 kernel module.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'm expecting serious bug when writing large amount of files to NTFS hard drive, shortly after memory allocation errors and system crash occurs/ Firstly, I thought, than this is bug in linux kernel itself, somewhat disk cache allocation error, but when I tested same operations on ext4 drive or using NTFS-3G module, bug is not present.

