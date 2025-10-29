Return-Path: <linux-kernel+bounces-875544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC101C194B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C40420148
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96062320CBE;
	Wed, 29 Oct 2025 08:51:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504831D754
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727916; cv=none; b=c9UbjcrS4LjgLgTPEaDTXJeHxMp8aQ/FenN35mZNEmMB9LV8fLL6e7yGBjTGna6pi86byYjFOrFpJxlZGV7yA/S/srQOP0tBd9+NAlsTa29nlaVmFtvOD87B8YojPWte4xl6NcKIhxYZ/NfRdGKjd0a7W8bAHLGK5eoOf5BEUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727916; c=relaxed/simple;
	bh=Oz5ba9JtwkK/YbIiMy/THeujBsPnGoBRBH147DuvOSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNiXwyOMxzBPOJXdcyDSLLVrh63DhRxn5ekAOLqik1UhoeZiYviQeHOgLIREDkOjhNo4YnatiIDkGUMWL3Z7Iaq4QoOXAfSlTDMbet19IIWUYFpFW0+p9fqemrketoHQDI48QVEpyS/0dNGCxklKdDM93aNvXf2l/N1lI9Trfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D802227A88; Wed, 29 Oct 2025 09:51:50 +0100 (CET)
Date: Wed, 29 Oct 2025 09:51:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
Message-ID: <20251029085149.GB32307@lst.de>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org> <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 04:26:21PM +0100, Daniel Wagner wrote:
> When the rport is removed there shouldn't be any in flight request or
> responses.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


