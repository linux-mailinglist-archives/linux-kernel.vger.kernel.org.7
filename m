Return-Path: <linux-kernel+bounces-879897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00AC24587
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78D94EBD06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650552EDD76;
	Fri, 31 Oct 2025 10:03:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05242D9795
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905009; cv=none; b=XCF+qnNtOfuIdGsnBNop8P+kCGEnE2PcJGiwNAmE/eLISjupX+/XIV9PmxNnUaOl+P6aFB/1Ay9fx8Ij0OAGFe1LIdYakb4WZ/BvNLT81FclADiGRlSRjHjlwlpsv3TtOsPvWFTGJAq7nTTif0I9SLykBP2mMQLyE4eFcoCcWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905009; c=relaxed/simple;
	bh=efmd671/5Vh2uHhilmynu//lw0vEueDk+RIN6MYgw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL5Q9Ub8L4Xb3ZS8OUkOK/9IMBu5KE0sXVu9bXRLKi/A1Vw7U1UOv4FfxLpcR9IBCI5ePJfXdGwNOwbpNF1iT6l8c11rfVoA5jKw9hdd6/fey/32y45NEXDHRmKR/5u771Z+JQkwct9oAiJV//nrncA5W0N28c4UVzEjsOF4tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EE90227A88; Fri, 31 Oct 2025 11:03:21 +0100 (CET)
Date: Fri, 31 Oct 2025 11:03:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 1/3] nvmet-tcp: Don't error if TLS is enabed on a reset
Message-ID: <20251031100320.GA10569@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-2-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 01:51:12PM +1000, alistair23@gmail.com wrote:
> +				dhchap_status = nvmet_setup_auth(ctrl, req->sq, true);

Please avoid the overly long line.


