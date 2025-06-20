Return-Path: <linux-kernel+bounces-695879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE86AE1EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6245A361D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857B28B3E2;
	Fri, 20 Jun 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fUBGoJn5"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28122949E0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433869; cv=none; b=GUS2IH0BDx7HqCo5xypGJ4G4NRhWcGB7tHpXDfIzIMXkjvtWtJXkBrNlLbEexyvcxe/rJ5j/W/bNbMX8VLb0veESUDVOjj6aKouGsvihIWbexaNSevJ3VmxZkLByKulC43ij7eeUfpjMzW768uS1a9AuPO74GX8WS60hFW50g2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433869; c=relaxed/simple;
	bh=CIsPAJzik+g5vNII1coJaA1lo3YrTB/E33HIMAdVTLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dy4lQp+yI7CK28qOWSKxunT4nrAcZGNeCXlx+VSlmLkkSuw+njW5DhmSBk+WBA8Q04x/JB/CnYhkFtaElM3nlp+lT0u43tN5S/3k0PJsVe23eM1trguF6wyEbjEjwDVFJ9JfFJwlFbCm0tP3rNR+N0/E/9kWWfGXxpMtitrcXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fUBGoJn5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750433864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SVVfmqYUx9yhfo4gZ1v82Vo4mmrNajJ5NwiYyJgg5g=;
	b=fUBGoJn5T5sJJrfCMSSK0BxRrjGIVoFA06mQnflCU6H5JBoMM3w1+D1JJS4wJq9G5Djznt
	ZwlJhqPs0Q7vaJS6kFLSK0na00By3yA+GKSl1BiYwUyg8vlTUNzixMR/Ve7pcYSSYO/aGd
	FcfgfJQbxH/QbKcRHNdi4HnP12r7T2Y=
Date: Fri, 20 Jun 2025 11:37:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 Saravana Kannan <saravanak@google.com>, Leon Romanovsky <leon@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, linux-arm-kernel@lists.infradead.org,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
 <2025062004-essay-pecan-d5be@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025062004-essay-pecan-d5be@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/20/25 01:13, Greg Kroah-Hartman wrote:
> On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
>> Support creating auxiliary devices with the id included as part of the
>> name. This allows for non-decimal ids, which may be more appropriate for
>> auxiliary devices created as children of memory-mapped devices. For
>> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
>> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.
> 
> I don't see the justification for this, sorry.  An id is just an id, it
> doesn't matter what is is and nothing should be relying on it to be the
> same across reboots or anywhere else.  The only requirement is that it
> be unique at this point in time in the system.

It identifies the device in log messages. Without this you have to read
sysfs to determine what device is (for example) producing an error. This
may be inconvenient to do if the error prevents the system from booting.
This series converts a platform device with a legible ID like
"802c0000.ethernet" to an auxiliary device, and I believe descriptive
device names produce a better developer experience.

This is also shorter and simpler than auto-generated IDs.

--Sean

