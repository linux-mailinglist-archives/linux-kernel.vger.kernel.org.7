Return-Path: <linux-kernel+bounces-751044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D2DB1648C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089883A6286
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A02DC32D;
	Wed, 30 Jul 2025 16:23:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBEDF71
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892607; cv=none; b=FY2C4HQuhHPvPr+v13MQ8lcGJyhU21R9755ZORlAC2vTec4O61Regs75ZrLJBjod+Wi7m0RnP8/4onN9gJFvoONJ5Ar8Q6wvywDymOWKO0xCEWK9v0/tsfn9u3KOQp1fkJBu0d9h6ciUwnj/8P2ALXkYTzL6OrIF6yigeQjrOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892607; c=relaxed/simple;
	bh=smCgZn6nWVu5/x+3olYOlH5Tcav2G9BZ8EprQS5zKSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6yPJwrt0sqnzKgtIfgBVXqCzmBc3qN+CvVCKn+KmfUIvleQ1ZpCt4HY0ZlmoKEvO9sOqCY2cYfgFkhizlMvvUTt4qeY+5lCT1RPXCOL18QztTR6PPGeIbY94Nsg3YDB+C0zWoDTPXesb6Mhb+jw2uXbYGOnVtL6OOM1VU7/CYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5180968B05; Wed, 30 Jul 2025 18:23:21 +0200 (CEST)
Date: Wed, 30 Jul 2025 18:23:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730162321.GA22255@lst.de>
References: <20250723202801.2909506-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723202801.2909506-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments.

This created multiple rejects.  Can you resend against the current
tree?  If you don't want to deal with the nvme tree, maybe resend
just before/after rc1?


