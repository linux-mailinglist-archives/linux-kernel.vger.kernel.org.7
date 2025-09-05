Return-Path: <linux-kernel+bounces-803860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B113B46676
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B893AF7C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0C2F619B;
	Fri,  5 Sep 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hlXpLbnl";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="L1iFYr1+"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE622ECD30
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110502; cv=none; b=f04N0mmEi56NzK27TRhrBjZINPSQE/EzK+eakUxUG5BVJPiZokoyFMRWQuBYNbGLE1U/DtpCH5GY5/VQ0I4EsvOU/to1ggUUBmJzLoR9D5yEBA2joHPv7G9uH+CTqcxxsv2Axv+OWpOYi2382FKmqr51x3iXu7jICNDOmxj8jW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110502; c=relaxed/simple;
	bh=F+r/RsHPqce6DBiDyKNnvYHMFIwMBLx4/IBCtIvmAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH2Hy7NAvGSXzOffZ02blMOxMwtJXl11D6SsBFR7TXBMPIzkUReZiEyWmNvfQAeGFyg0yYs8ULiz74lnoiTIE9ZJ1fsEDadFWUHnlc05mhu0uZXuof94816wJcb+UsGl8ierUuqfBzG/18hREYv3ovrn+3kyQtq4Oq2JY71rUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hlXpLbnl; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=L1iFYr1+; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757110500; x=1788646500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+r/RsHPqce6DBiDyKNnvYHMFIwMBLx4/IBCtIvmAI4=;
  b=hlXpLbnll162VEtLsP3d3lCcQGHo729qBzSfAznaaMLhXr/eMW9DdTQ3
   UtVn+VEE/BHYdA0oHR9OpmMrYyaEcV/sVwND0Dtl9dRJHu4Y2e5YF+lxX
   RDOCTXfd7x9u+yZ2C9jMyJGtYXm0dBy9y9rNgRhlzeZp3aQAGZLDSRe+q
   P6IdPuuRpAVMb7AaoVg+P7dlIA7CVa4HiH7TilhenonQFzr9OxLBwLr7Z
   1Ex0k5teIbwmypKZDZgc+YhGj0QLg5h7Zb9YW77iuOeLTFhhrahqTDL31
   rOyg5hZP1Qjxz3x8d/lKh6stHS/OjchNpShAR0yXuEd0Hp5c0/cvcifrk
   g==;
X-CSE-ConnectionGUID: q3xWAaTuQ1S5YxnR6oieqw==
X-CSE-MsgGUID: 3VgHJK4rQ/SS3ns72reFQw==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="108773846"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 06:14:59 +0800
IronPort-SDR: 68bb60e2_qcXOqewuc4CVjF/3wd65NqzycZqPRYnhGoEXihsYFGF8+9W
 KpZKiaQJSfd+nTHHbBPRjHNLAPqdKtMc5qu9oEA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 15:14:59 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 15:14:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJVyV3DTwz1SHkX
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:14:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1757110498; x=1759702499; bh=F+r/RsHPqce6DBiDyK
	NnvYHMFIwMBLx4/IBCtIvmAI4=; b=L1iFYr1+8PumSZuu3VaL5vFQuK+jPuoI6C
	2z30zKqKDGIsXEka/e6B3isBLqIay7SDxTvKGN4FaN3eoDUbp5qCPO1Om4RPZnPQ
	JTssLD+zMDCScevaVl1q6pqqqvsMOhL9VG1yG8khQwgOEP35uMihEeoKY8bhDbrH
	ELRFMwCyj3Pr8eW2RkCmjJZIHOhTyK2yn4roOtVOIxAc4ayVn4MzoVSdIzpg5243
	dWZgWCS03wTdoijjEwuFqeFFwaw1v2lMgJiHNU8Ceenj6djM3gcJPZzOfpuxBRSB
	8r3MwrTi00Eu2/tXVjpkFoxTcdPU0Z8JxtdBnPtjJWddxe/HLusg==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 24sKsgTbWTou for <linux-kernel@vger.kernel.org>;
 Fri,  5 Sep 2025 15:14:58 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJVyT4r5gz1SHkR;
	Fri,  5 Sep 2025 15:14:57 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:14:56 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin
 ctrlr
Message-ID: <aLtg4PIb1Xd6WTP0@ros-3.wdc.com>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
 <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
 <aLta40FO1Ud6TZ4T@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLta40FO1Ud6TZ4T@kbusch-mbp>

On Fri, Sep 05, 2025 at 03:49:23PM -0600, Keith Busch wrote:
> On Fri, Sep 05, 2025 at 02:10:01PM -0700, Kamaljit Singh wrote:
> > An administrative controller does not support I/O queues, hence it
> > should exclude existing checks for IOCCSZ/IORCSZ.
> > 
> > -	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
> > +	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcsz < 1) {
> 
> Excessive line length over 80 chars.
> 
> Perhaps, though, we should have a helper to indicate IO controllers
> rather than chaining conditions for everything that isn't one.
Sure, I'll add a new function nvme_is_io_controller() and make it dependent 
on nvmf_discovery_ctrl() and nvme_admin_ctrl(). How does that sound?

Thanks,
Kamaljit

