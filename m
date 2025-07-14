Return-Path: <linux-kernel+bounces-730120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E6B04072
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF393B2EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD425484D;
	Mon, 14 Jul 2025 13:42:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C60253950
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500559; cv=none; b=kWSGMetWm4LqpkwIMvbKmfowScIZinUbunZupgnyvQkZtHbjAuu6frNnvYLSRONmMxt0HMJ/6TEwp0LNmXnkr4GdM6AT7SuH/zgQGl5hPyeSY1v0KPvCCknv+DMPiU/ZrxVajCzEnvOMzx+425i4ShP7yjmEPpfeyMkAhbbbJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500559; c=relaxed/simple;
	bh=iNMyIZJyXueqDxhMc2gAyF7Jz51P01o6d80BQGFvRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA/DTW6CVRuImR3KIqzQDCxq282hnElBxcQTl8n4TmVreXNqRPERoE5oGLYjcSMNeW5S/ZvXtWCQtp1JB4UxolbWKcni1HsouDmHPb66AXG+k7lpBqz3R8vm2rw7UkBwJDjwGMzPnppNh+gEdQE8IXEaavwhEP+cWYeh4326KOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35F10227A88; Mon, 14 Jul 2025 15:42:31 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:42:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	yi.zhang@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] nvme: clear nvme request for nonready request
Message-ID: <20250714134231.GA11132@lst.de>
References: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Are you going to resend this with the feedback from Sagi taken into
account?


