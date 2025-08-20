Return-Path: <linux-kernel+bounces-777834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB7B2DE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912A85A6008
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED11DE4E0;
	Wed, 20 Aug 2025 13:48:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF91DE2BD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697704; cv=none; b=GZwmYi9l5Y0vJIhZ+iE7YciuT28D7ZMEixBV9JmIY77AnWPTRDgN4VlvXZVAXlSDg4y3bG+lFr94VoLKu4Z426UguhI6qmtvvP1qTMfddbq5cIYcQAzzcjCCCwF2+GsgsG7y+Z9YAwYPht7jObEUwBqUdw/xvEpSboT6QiRBvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697704; c=relaxed/simple;
	bh=QFr1FvmtOkiiPMrIohGQ5lL450uhI/AAJiW7ycMiklg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2iBvXjT4+DG8nIg1NHSPGTJetdS8yuhamFzvvmnnFTON0msVtiPJF4j/CLBC0pN5S8nau32nRcBauZUsEKnc3qDvChqe1vg24PM0TTBxoXByQF6pitVBy5TVX0wZ/PyNjX0tUnnOOU7ujEdyg5GJzCqmKoQ0fbDpT92d3Z0rxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6SQp3wgJz6M4vG;
	Wed, 20 Aug 2025 21:46:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2230214033C;
	Wed, 20 Aug 2025 21:48:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Aug
 2025 15:48:17 +0200
Date: Wed, 20 Aug 2025 14:48:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: Brett Creeley <brett.creeley@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, "open
 list:FWCTL PDS DRIVER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pds_fwctl: Remove the use of dev_err_probe()
Message-ID: <20250820144816.00002b2a@huawei.com>
In-Reply-To: <20250820124011.474224-1-liaoyuanhong@vivo.com>
References: <20250820124011.474224-1-liaoyuanhong@vivo.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Aug 2025 20:40:11 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
> 
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
> 
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Not high priority but I'm fine with these in general.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

