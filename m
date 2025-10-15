Return-Path: <linux-kernel+bounces-855258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC64BE0A68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AC46351AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625330C341;
	Wed, 15 Oct 2025 20:36:32 +0000 (UTC)
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887730498F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560592; cv=none; b=hjI85JOniGelizLrcnxsJuQ2s3+j94IzybdDp++uPBLLsVgViREftswY5GcB+OJEoCyLoqii7zDVRQal+VP8a9RHsvUVuj/RNIjKe3N/4B1g+An2OBrEEf/e47W7X2Gz2YKrvGqiHilQTY+fjGu/1quZEFHrgsLtwCRagOQGLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560592; c=relaxed/simple;
	bh=KDqs/XWoFDaou1ItPMzhIAVh9+ON6rnhbkJ/Rd88vJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUjWY6hgOMNjGHzFrwheJCHaSFMOCNLdRfjaoDaabZgdeevyLtyoy0O6SZHSHNm1hppImpEdYxG6qTkIi/9a7oD4Zttqph0E/yjdQZTmv5XwOYzpZxOAGVvR+G0HrJEiGp/GCGxmsnkWwPsv06/+qn1WiaH95l8LfIM0YIf273k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 66E9BB848D; Wed, 15 Oct 2025 16:36:29 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: Suspend regression in v6.18-rc1
In-Reply-To: <20b455f6-829a-43e8-83a8-5ee0eb9bbaf0@linux.intel.com>
References: <871pn5j6vm.fsf@vps.thesusis.net>
 <20b455f6-829a-43e8-83a8-5ee0eb9bbaf0@linux.intel.com>
Date: Wed, 15 Oct 2025 16:36:29 -0400
Message-ID: <87ms5rdhrm.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Neronin, Niklas" <niklas.neronin@linux.intel.com> writes:

>
> Hi,
>
> Thank you for reporting.
>
> I believe this might be related to the issue in this thread:
> https://lore.kernel.org/linux-usb/CABpa4MA9unucCoKtSdzJyOLjHNVy+Cwgz5AnAxPkKw6vuox1Nw@mail.gmail.com/
>
> The specific fix:
> https://lore.kernel.org/linux-usb/20251013100424.42d5b9d2.michal.pecio@gmail.com/

That fixed it, thanks.  It didn't sound related at first but after
reviewing the patch, it started to make sense.

