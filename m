Return-Path: <linux-kernel+bounces-800556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38059B43932
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41DB7C285B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8601C2FB609;
	Thu,  4 Sep 2025 10:48:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2854F5E0;
	Thu,  4 Sep 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982895; cv=none; b=Fhk3462tv+01GrYmTwIS1ueW8Oy5Qs+Gpfs6y55XMB9auk5B8vFmG6iUsFBmxveLMjrFTjEvujuliZWYQE1zCLFIqQidi8H8rvm9Os0Aa/Y31W73FlSJVBKfLde7dQo8u5utN1ibhuY+Yq/zSSoFfQ/gYY0mNrrYGpkPAHmZ+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982895; c=relaxed/simple;
	bh=BnffRtuAO0fHa8klUOka6fWIHzSv4Atuw1W6xeWrTwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4vvS4v97xvv5BfSbaEeLDv86wdUVJ3yrBTcx53gkp9hF8805uQDSE+IZ7wDePfgvaVsRFwCnjpI68sQQNUytdsW+jc9J+iIGs/UyhfyGTH7dMxWvBrPZt/hwVkpnGZsGY6hL5YJjsAXdCxec1P6PQ1fMGu3+BkeYQQ6FoeVWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980A51756;
	Thu,  4 Sep 2025 03:48:04 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C35A73F63F;
	Thu,  4 Sep 2025 03:48:10 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:48:07 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v28 1/1] mctp pcc: Implement MCTP over PCC
 Transport
Message-ID: <20250904-spiffy-earthworm-of-aptitude-c13fc8@sudeepholla>
References: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
 <20250904040544.598469-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904040544.598469-2-admiyo@os.amperecomputing.com>

Hi Adam,

On Thu, Sep 04, 2025 at 12:05:42AM -0400, Adam Young wrote:
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/\
> DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.  Messages are sent on a type 3 and
> received on a type 4 channel.  Communication with
> other devices use the PCC based doorbell mechanism;
> a shared memory segment with a corresponding
> interrupt and a memory register used to trigger
> remote interrupts.
> 
> This driver takes advantage of PCC mailbox buffer
> management. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox,
> already properly formatted  as a PCC message.  The driver
> is also responsible for allocating a struct sk_buff that
> is then passed to the mailbox and used to record the
> data in the shared buffer. It maintains a list of both
> outging and incoming sk_buffs to match the data buffers
> 
> If the mailbox ring buffer is full, the driver stops the
> incoming packet queues until a message has been sent,
> freeing space in the ring buffer.
> 
> When the Type 3 channel outbox receives a txdone response
> interrupt, it consumes the outgoing sk_buff, allowing
> it to be freed.
> 

Sorry for not reviewing your mailbox changes in time, but I have
comments/concerns on the changes merged. I will respond on the original
thread with questions if I manage to find it, but it doesn't look good
at all to me. So I would want these changes to be on hold(not to be
merged at all).

-- 
Regards,
Sudeep

