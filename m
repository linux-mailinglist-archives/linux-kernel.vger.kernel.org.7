Return-Path: <linux-kernel+bounces-888325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBCAC3A80B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB31D4F80F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D012F3C31;
	Thu,  6 Nov 2025 11:15:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615982F0C6D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427737; cv=none; b=TmvrAsQOGdbFPEVsgqkHCh/QtanX+rHRFjIw2wRb8mI3U6Q0EQZ5XODKuY9AD44ro4PXeIMOK11Z4rSL9d1X2nEb1QKv1l/gZ1XElsa9lXeE0R2nVa05yQWH/CDqfrsqUBzid49gtJJZ6VPA6BGmNUiSPm6gC9JwmA7KLtfnkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427737; c=relaxed/simple;
	bh=kJNhoJuafXThiXLHhXB4usAIFL4o51vmul0fN48lYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxfZs6RYDwdE/40zEd+CWhxPNkpYnfZunqEkSEWhM4jrQ9aGi98fjewnuCdb5+raoVnSzLFP5Sa0AsqdbVMdviVQfFUCM30BD93zTPArIDJZx1Jt2OG1N3KuWaZ/lcZyrZXT1J5Y9WoiTMUb2Ec9EPb/YJPhMUtUkMXnjJizIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAEA9227A87; Thu,  6 Nov 2025 12:15:28 +0100 (CET)
Date: Thu, 6 Nov 2025 12:15:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.de, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251106111528.GB31430@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <20251105132023.GC19044@lst.de> <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 01:01:51PM +1000, Alistair Francis wrote:
> We don't actually need this memset at all, it's a mistake from my
> rebase, I'll drop it.
> 
> Do you still want me to just directly pass req->sq->sc_c in?

I think that's much cleaner.  OTOH we might as well just merge your fix
ASAP and clean this entire mess up later, so given that everything
looks correct:

Reviewed-by: Christoph Hellwig <hch@lst.de>


