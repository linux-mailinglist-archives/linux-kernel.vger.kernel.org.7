Return-Path: <linux-kernel+bounces-879176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F244C22730
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4A34EEA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0931196C;
	Thu, 30 Oct 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5GZizP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACE26ED57
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860658; cv=none; b=BQdEPDM5RwJwl0tHDopkfKw9kL1S8KcY3zjy6EHOwu4nCrCY9Gwra/pGXOu2KJ4auV//r81Lpl58RLgD+zxHR+4nkKPV37p3ugKMPrVFYBaslyyUii28BtU6iwAGe04x6HPhd23o5ShC57eLUnCQ+ct3IIArPY/QgTzhmUSw+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860658; c=relaxed/simple;
	bh=XSGGtCutJQgfXLVeOpND5f2BW8ou/h+v9Q9XCI+psPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQu8XnpoPQTftAeac6hr8EJ4ES6U0WfkNmG0NM1AP5o96uDF1yKhiaTzsFud7LPOcgPMkmdANFqf0gxaTxNOOA3w+6/cK7daj7gPhAUonXqJxjtZH4UeFlHw8bYnk1AZaU8gnzG0kahssLwKixB6SQdjwTGhSXQ4MR8xSHcmwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5GZizP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49DAC4CEF1;
	Thu, 30 Oct 2025 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761860658;
	bh=XSGGtCutJQgfXLVeOpND5f2BW8ou/h+v9Q9XCI+psPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5GZizP3k2xcfbCN0f3PXGjxbVjtF9alIG9R3YfXS08AkVls74hJ4NJzlWNyux+w/
	 AzW0dyNDN8Errr2YkFsl/1bTQBSabZL/DSMUIKBZQfEMGDeEdJA4lRynF/D7iLhVVw
	 PP4LeX2zb/BNaT/GyrPjb5agnq5hN40gqVanli6aXOkZHNZ2C1n4WzYJiy5OHomWcl
	 dVWN3h1hmoEokD13Cqo7op8ldeG6rFndCyid3Q8a8n3zUFvcZwHKM3Fi19/6oOnTf2
	 721wZDsAKWo181AlwCnXQnUjDic52MpY+FgDik8aqpA3qWdR8Uy+uUswP7M3k+o20I
	 aNn5GgfX/5Blg==
Date: Thu, 30 Oct 2025 15:44:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme-fc: misc small improvents
Message-ID: <aQPcMGH4FtqzWlhw@kbusch-mbp>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>

On Thu, Oct 30, 2025 at 11:05:44AM +0100, Daniel Wagner wrote:
> Updated the first patch to use the safe iterator variant as suggested by Justin.
> 
> orig cover text:
> 
> I've collected a bunch of patches from the last debugging session. I think it's
> worth documenting which conditions are expected in the cleanup path by adding a
> bunch of WARNs.
> 
> Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Thanks applied to nvme-6.19.

