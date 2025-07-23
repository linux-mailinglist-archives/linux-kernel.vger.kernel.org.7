Return-Path: <linux-kernel+bounces-741894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41361B0EA58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A07F1C23EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED2E248F67;
	Wed, 23 Jul 2025 06:10:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D1448E3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251017; cv=none; b=pE/yg1r3I+YNc2Zt1YMYPg2UKJZFaHV8oHKiogxjfBgvEiafJ4wAVQpdtqH5P9/K4sk64nGnZ+4lTaA6jSNFqGThvEYu3R/LPEw/QGaTGvfvm7bbGsV/inxwj7m9JyPgGUacdUnudBMbQom9SKLrtYaQrl9naz+lxZHwZGVKjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251017; c=relaxed/simple;
	bh=HoQV9Lw01ta6q+Y3BYFWboco+MVYD2Zmpvl3r9meszE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5/9sMpmDmfyAQJDCn5HeDL3qyn0ShWOwxAaEoQgqprWTp5ueDxiZuLq/7u4NVU2yoB3JTbVix3AUOWu0IqTIjv3tdjAo4OL+ACVsjAuO8ldRnLqnRr3INk9bElQjhG2GJo4JMoQaCUw3OM34g/Y3PWMuflk7gC9N6cIWqGK8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CAB1D67373; Wed, 23 Jul 2025 08:10:09 +0200 (CEST)
Date: Wed, 23 Jul 2025 08:10:09 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <20250723061009.GA18943@lst.de>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com> <20250718001415.3774178-2-kamaljit.singh1@wdc.com> <845e9caa-093c-466b-9a9b-905359517568@suse.de> <BY5PR04MB6849799468BC4F5118343015BC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6849799468BC4F5118343015BC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 22, 2025 at 05:34:56PM +0000, Kamaljit Singh wrote:
> >One wonders why this is done for admin controllers only; surely
> >discovery controllers also don't support I/O queues, and should
> >therefore have the same setting?
> I agree. That was my patch-3 in v2, which I retracted in v3 based on
> your comment below. Is someone taking that action item to discuss at FMDS?
> I haven't attended it in a while.
> 
> If everyone agrees, I can add patch-3 back in and create v5 or since v4
> patch-1 was accepted, I can issue a standalone patch just for this change.
> Please let me know.

While forcing it won't hurt, we had things working for almost 10 years
by relying on userspace to request zero queues for discovery controllers.
So I don't think it really matters.

