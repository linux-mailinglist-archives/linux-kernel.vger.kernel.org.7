Return-Path: <linux-kernel+bounces-741896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B91B0EA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D0F5675C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C971DF270;
	Wed, 23 Jul 2025 06:11:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88B2475C7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251079; cv=none; b=KijSPNiJ4yiLskMEyO5kEjPKhV7+WoX+oZRZdSuq42MiU+qCzZEb1Cd04o0TtdJIutoCpD8ExQxuTxQ6f3aeyu55ovIBmxC6s2OiLtg1XWJEvl7A5o48JNeLJWcsN5ZW1Z/BOsTTErux/YajNkpB9/RCLZ/OmTQZl3IW5U8A1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251079; c=relaxed/simple;
	bh=75vTQ39K3m2zEuOjHg4AdtoNTOOvlU5jT6zwTjw0d5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0B8Oj2xK/utdhcCMqmdWj0r/qQOrBsPnuaiAZJVYBsHzqcr7Vfymx9XIhEZYo07tpvM4guaYpBqa9GVaeYMntrXY1ZXSFn96hlX+1b6UtjsP3Z7uQSEofIwiD8FTcTaMeplBvUsOyjJXIPUhdP8UW2kyGu58Uks0wVY4TjjO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA74667373; Wed, 23 Jul 2025 08:11:12 +0200 (CEST)
Date: Wed, 23 Jul 2025 08:11:12 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Message-ID: <20250723061112.GB18943@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-3-kamaljit.singh1@wdc.com> <20250722063015.GC15013@lst.de> <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 22, 2025 at 04:34:05PM +0000, Kamaljit Singh wrote:
> By "let's leave this in", I thought you were referring to my patch. But now that I re-read
> it, seems like by "failing a get_log page is fine" you probably meant to let the driver 
> issue a get_log for LID=2 and fail.

Yes.

> Process wise, can you ignore this 2/2 patch and we call this patch-set done?

That's what I've done.  Patch 1 is queued up in the nvme-6.17 branch.

