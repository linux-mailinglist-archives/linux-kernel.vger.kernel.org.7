Return-Path: <linux-kernel+bounces-896612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D9C50C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4E4E64D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F02DA76A;
	Wed, 12 Nov 2025 06:54:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA062D77FF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930479; cv=none; b=iBoZXG7eJSl8HY1KJoE+4jlVD0CfGsRVM6rCupZE2r8lYJ/Nr3oFkxIGFrfu7x3U2Hln/AgwSv/V19xro1fJ7wBDH27tzaQDYfG5JfE+fT1QUYWJJHVvuST1ikRHuZvnPspR5gKLxlEFC0kQ/7Lp8qxsbMSizv2BMDWP4/a8LF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930479; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzTpjSF6m/NjwhaBUOlE9AyXtrIYNPVt5CHSFV4wXjGQp1khrZBRW5fwKBnC889j+f6dU1eP0goZwjaAcoWZNdd03RZPLaT5H1mxXj4guEH9fJHwCm+8LyqAlkVA8OUNOYVzuaF+70CTan9dYYvdzeX2mlJQrhp5xqOjcN0HgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 947E4227A88; Wed, 12 Nov 2025 07:54:33 +0100 (CET)
Date: Wed, 12 Nov 2025 07:54:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 2/4] nvmet-tcp: Don't free SQ on authentication
 success
Message-ID: <20251112065433.GC4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-3-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


