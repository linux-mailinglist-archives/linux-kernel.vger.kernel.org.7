Return-Path: <linux-kernel+bounces-880309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2056C256D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D564F4F6B77
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1F23BD1B;
	Fri, 31 Oct 2025 14:03:18 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CF34D387
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919398; cv=none; b=rqLnyo7MSRHmD+D/jd48WWUvyb3S4EDItKSDnto8EeUW0DAQFPi6h6/fOBpGvcm9LtEQ3yAK+wlF/YgLDUbCUzUf1TjycXsBqg4ozt4kaSSTfEIlIEHU31LN33+ZrHCncSHSqaEbUprozxpmKX82oyQoVTnFRy26z0ERI4C6Xkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919398; c=relaxed/simple;
	bh=CPRvVaC+XXcKRB7IiGqYFCT8QQkf3KBAj6xonGXKDXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeRzcBXbIvypiMeanfOQ/Uc2uAatb6L41yd0VytnteBZHYGcQZrB7JBPzEu5dG7o90HuYkIfdWCxz2qlxtBRwfaIfCDHjNisD4OmhK7N0BHal8ExHpTCWqm1hDMoO0LWeFTaNRqcsDb+HdJwnwkp7vyP5uSXOUWfvq6GjoClNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9B23227A88; Fri, 31 Oct 2025 15:03:10 +0100 (CET)
Date: Fri, 31 Oct 2025 15:03:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
Message-ID: <20251031140310.GA17006@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-3-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 01:51:13PM +1000, alistair23@gmail.com wrote:
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> This patch ensures we don't free the TLS key on success as we might need
> it again in the future.

I initially though we'd now keep it around for the lifetime of the
queue, but I think we'll still free it from nvmet_execute_auth_send,
right?


