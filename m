Return-Path: <linux-kernel+bounces-730134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A514B04096
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A40116B0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8824E4BD;
	Mon, 14 Jul 2025 13:52:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DE131E2D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501160; cv=none; b=uBRB6ytd1uUJnwMH38Sr+Q4ayOCeCV7Ac3UbKEKHPmGloqOHsvZgRwXBf96tITf0PLMMzz1DmjY9LWtNSXGvmDm3Kb8GIyw+EVLAGuBFk0ZKNMMuh2CbTjpU3Gr2ug743VrJkSzxWbWTkfKAdGittq7UvU9RtqfnAQkm6sOUXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501160; c=relaxed/simple;
	bh=BH/BFS4DBD/MyEOZSB2vsiZjeO/geaFzg1v7t3pZn2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV3indrfzvvTz7ExV9vM7YgZZOTDq4VZgpbvrTrvBEI+s6xXun3LyeDuvY8sekR44GBnN+zk/R+VQhi6nuc1RhzhGrWdumOyGuj0VtyoSgsoxztFzPDbyu6E4d7WoftNmgCnQlxRl0YmZmkLoGDpDB7f8177mpqFUjCxhAfuD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6D9B227A88; Mon, 14 Jul 2025 15:52:32 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:52:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH] nvme: fix inconsistent RCU list manipulation in
 nvme_ns_add_to_ctrl_list()
Message-ID: <20250714135232.GB11944@lst.de>
References: <20250701071717.2619384-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701071717.2619384-1-zhengqixing@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied to nvme-6.16.


