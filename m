Return-Path: <linux-kernel+bounces-731390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB678B053A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A1456079D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA4272801;
	Tue, 15 Jul 2025 07:49:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABD27381A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565779; cv=none; b=pBXu6OWrkGPCWkeK2Trl+NcmmX3bi2jxXzcIQCsmmBqx6cVlR8Yjh8xVLQeznhiCgFIbDRB+8D9hoi378hpfCAFOYzX5dPhMHNlWo3AnWCQ1LTFgVA6YQCPmNUXvkdy5yZUFNo1WB76lJjwYK3NhrlCB1jBgfnAFGeoaO5OY6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565779; c=relaxed/simple;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb1v3vLnfqyLBsXnZoNN+IFbgpORhjYhYMdvkY1PAw1/tcKI6/OqukddQLpKNGBc5DTBDINucwgqfZGHJU1Q/pwXRtjocKmZ0rIi+0t3eoHAdVM4/p2PX2U21CShuXhEixgTK9X4Pst6R9Zv2pzfQE6f2Mstb4YHe0bMhQ3IQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0D5968AA6; Tue, 15 Jul 2025 09:49:32 +0200 (CEST)
Date: Tue, 15 Jul 2025 09:49:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	lengchao@huawei.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] nvme: fix misaccounting of nvme-mpath inflight IO
Message-ID: <20250715074932.GA20468@lst.de>
References: <20250715012812.1135331-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012812.1135331-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to nvme-6.16.


