Return-Path: <linux-kernel+bounces-607537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001DA907A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C603AFEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0935204C07;
	Wed, 16 Apr 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYef4Q95"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08113B7A3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817119; cv=none; b=gEkkctKXgsuuw5ix3RPDIqbXMxwLCSjLg9AcXhMS6qGgXlAH87jbwMgXOeLGJPIqYSnbx0Ach0j05l0uL/FMwxnlelHYATRN1iA/8RQBbMGdnu0BF1gWnECKQMDay8RX9HDeJ1qcTBnWoHzH6V79lF1jfoMFsAtwg2shX4Xl3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817119; c=relaxed/simple;
	bh=t3KWLvp71uDPZ1KX3NJETFxAT9M1lopmzOl4eKzyLg0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kqY6FS1bj2wJhynzLEkXweM3qbDbHI+eIGfifZL0gPavSrft8ZG2nj8r3vsDKNKnFqriinzkPZb5uTDkSbPqav+VyFbielCjcM9gonLKVw8lGNjSla7KR9aVl3hrjUl7lY+l2TW5HX7tqnluoxzfk+cGfGlgJrGTBTJrXsTsfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYef4Q95; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744817114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSHBYjNBy77pH+d+njSJhBrbalqBTYpC8jqWG0u26xA=;
	b=GYef4Q95bwrLRDfhyzZuZzHRzvckzwN5NIefpluKN2P+mamHWWLDrIQ/C+SW15BljO/yZz
	+PmZSRhcvOVLZot+yGtoG6krsTOuk5KYehJZnhEIRTxRueCFaqUuJ9P8+0xe/LIy681jyC
	L8kWIe44BHkuH7gsagYFINSHCqTjqcs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] MIPS: Remove unnecessary zero-length struct member
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <alpine.DEB.2.21.2504160321210.23090@angie.orcam.me.uk>
Date: Wed, 16 Apr 2025 17:25:00 +0200
Cc: Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D91D318D-83C0-46FC-B16A-CDD45FA57B2D@linux.dev>
References: <20250411090032.7844-1-thorsten.blum@linux.dev>
 <alpine.DEB.2.21.2504160321210.23090@angie.orcam.me.uk>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Migadu-Flow: FLOW_OUT

On 16. Apr 2025, at 04:33, Maciej W. Rozycki wrote:
> On Fri, 11 Apr 2025, Thorsten Blum wrote:
> 
>> Remove the zero-length struct member '__last' and use sizeof() to
>> calculate the value for MAX_REG_OFFSET.
>> 
>> No functional changes intended.
> 
> Have you verified that there's no change except for timestamp data in 
> (non-debug) `vmlinux' produced with and w/o the patch applied?

Just did - and yes, the binaries are identical.

Thanks,
Thorsten


