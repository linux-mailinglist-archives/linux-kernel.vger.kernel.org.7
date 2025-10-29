Return-Path: <linux-kernel+bounces-875542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E10C1949E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D83464092
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B131D748;
	Wed, 29 Oct 2025 08:51:35 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F931D374
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727895; cv=none; b=egBX5O7i0NZp0dkCsAPhfO3oWL0IiPXVjL4KmolGjxY0ClGwlivhMc64JYYJyB8JG346P+zIp/6UkUwPuqVnmIQk8f5ksDEDqHPEDFNPotiWUMBLThzY/1wofgHUF9YJXcIF6PdmV/v6R2EVPpNB4VKFXInIgVy9RxIatr4K7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727895; c=relaxed/simple;
	bh=4jIQ2V7Zc6PYJnu0a9K6h/pa7TDpgleDHH+rtkxiew0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4ceoXF6ALV+swKbhba77G9L6cMH/OhRzkMMCkSWuC4s/Wf+8W1+IZJPVXjE3upXt1lMQgwNbk4Q/tulRiOPjtA26b9chuzEkm0qN5b362yAQMaVx3FzeDN/739U1LQhQyYT0hNhuI8ZuZqnuEp4bKukuzRbPOpmH0v8nwQK1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2108227A88; Wed, 29 Oct 2025 09:51:27 +0100 (CET)
Date: Wed, 29 Oct 2025 09:51:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <20251029085127.GA32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 04:26:20PM +0100, Daniel Wagner wrote:
> nvme_fc_ctrl_put can acquire the rport lock when freeing the
> ctrl object:
> 
> nvme_fc_ctrl_put
>   nvme_fc_ctrl_free
>     spin_lock_irqsave(rport->lock)
> 
> Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


