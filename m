Return-Path: <linux-kernel+bounces-875553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AAC19409
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951241896A69
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162732BF25;
	Wed, 29 Oct 2025 08:52:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C832A3C1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727959; cv=none; b=CYkV8ACkfas7hAKmGF3qp/malCMl2syicwMUXD6SutiK7LdoeCCYcI32HJR6aYmWwyi2TK4+q8IADyGIbva1CkbvfJIIUNSgquNE5aLv3qFsvOUF5htRbk/sdZYIOamfo3wKZdNGNNPCXzSExv6Umxcnw1wd8xCG1IIBMhj1710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727959; c=relaxed/simple;
	bh=w2MvZejhlIq1jdZ7HGnbSko1tS+zfvV35QA/IQAfaaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D88VGK9dFBtxFyY3Xuxoiadj6PYPWzWhyujALjBiLDZY/0dgeqyKp3DYwRl74QY+f+4HTrwgNf3GpOCElztvAAU1TNHryWaM8T9tOFRsoMmWbbl8TQY71CYR5Dt9Ay6ip56XxWo7d5MCW0PjJKOnWh2VTTI6Cb5RhUGxx7sV7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8734227A88; Wed, 29 Oct 2025 09:52:32 +0100 (CET)
Date: Wed, 29 Oct 2025 09:52:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
Message-ID: <20251029085232.GD32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 04:26:23PM +0100, Daniel Wagner wrote:
> Nothing is using lsdir member in struct fcloop_lsreq.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


