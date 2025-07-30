Return-Path: <linux-kernel+bounces-751002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B94B163EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EE217A221
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930302DCBF4;
	Wed, 30 Jul 2025 15:53:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346D2D9EDF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890839; cv=none; b=a8/4D2SCgNvN/h5VzbOI9Yd+a6q1NYGQ5uQWAgZpJgXIIaWogdEjgbJA+j2rm1wPMdB+Bv3AzXLNGCJ6WN7Uz1ojNzYEEfZ2AmAOufT/RfF28VmPEJZstdBkKSv2pDQ7zS6jDwS8vKqaz7ajPVXdQOyo1JRY3wGlA7WKHu3bQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890839; c=relaxed/simple;
	bh=2E4q/VTewWdAiwGBze8dCv3IXOy5Ea14A1k3uP8YBWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKjrPGZtLWE4iRjF+D6MKkt85hmd50yR7lP1Kkfg4yj0tJt2Kkb9sNmellzC7XsVo753N17HoI3r1Art74XTcsTdtpw0jy7OXf4pbZSH62GCykifJGn18YNZbbFUby65X18SRIZB/evIum/rqWKPyRJNdtr4oDTkYJYRqkyuJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2934168BFE; Wed, 30 Jul 2025 17:53:52 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:53:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <20250730155351.GC19799@lst.de>
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied to nvme-6.17.


