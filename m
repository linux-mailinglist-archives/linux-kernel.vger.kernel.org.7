Return-Path: <linux-kernel+bounces-749261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C927B14C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D5D545087
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398A289350;
	Tue, 29 Jul 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ltAZJh8X"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2B27CCF2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784749; cv=none; b=CkRpo2C694c1VaGKc75hkBv1Q0BKJMtGOgiaoxjqmolLmjIXrnDhWnEtC7/pRc+p66qWRXucy7vbSsrT8uxAu1f1nmvyk2i7OgEYsgAZ9daZOVZfx+ekzohgaebfX/w10pPxG0clsrN0536tPsO6wlcyU+7UHxieB1Rey2AGfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784749; c=relaxed/simple;
	bh=v2/RbTx8GH+JQb5AYM47adD+b+LXW05AIiVY+yvha6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=rrpr0vYBaX31MzhmxFiwG6azBB+fzVddBbIaecmfQvooM7+wgYbNPh+2PevU2WP7UqkMRnfax5aI3WE5Jgod1d/OiYLK+OuXAw1dKtcD5dXzaDWN0UlO56cUybM/kgmw34yaPum1iNwKQV828wZJDMaA/mQ1yBU+5CfZpv/xbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ltAZJh8X; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250729102537epoutp04ed30cd6e36c80b95db9d76a29cdd4a2e~Wse1ViYd73157031570epoutp04u
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:25:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250729102537epoutp04ed30cd6e36c80b95db9d76a29cdd4a2e~Wse1ViYd73157031570epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753784737;
	bh=Lg3wPxjd/SerzBNwxTH7tFhGgsh8mMPrkCq9OZTxf+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltAZJh8X1M34rB0zS7EvOEypRhWkDniqM/3yD5eZtAxOobXDYNy9jIQt8biPGHs/7
	 MQooLIE0lo50VnJrfy8wYLSmyJoxbxIKRpjen3DJqDo6iwblnAOS3/T0hEUNHvppwQ
	 EJn1nMnOpVwe1pJP+VBr0aHjw9XIITbic8nty1EE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250729102537epcas5p214ca14d5197c5d23f2992d1876177184~Wse0240X11631216312epcas5p2J;
	Tue, 29 Jul 2025 10:25:37 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4brs1X439sz3hhT4; Tue, 29 Jul
	2025 10:25:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250729102527epcas5p165b73185cadb10d38b3213fcbf931159~WsereKcfS2666926669epcas5p19;
	Tue, 29 Jul 2025 10:25:27 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729102525epsmtip2acf59cc937e893fd98db5c3180d7ccb4~WseqNEUth0444404444epsmtip2q;
	Tue, 29 Jul 2025 10:25:25 +0000 (GMT)
Date: Tue, 29 Jul 2025 15:55:05 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Hannes
	Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, Randy Jennings
	<randyj@purestorage.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <20250729102505.lxot5ka473gh4uyh@green245.gost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-CMS-MailID: 20250729102527epcas5p165b73185cadb10d38b3213fcbf931159
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729102527epcas5p165b73185cadb10d38b3213fcbf931159
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
	<CGME20250729102527epcas5p165b73185cadb10d38b3213fcbf931159@epcas5p1.samsung.com>

------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 25/07/25 01:50PM, Mohamed Khalfella wrote:
>During nvme target initialization discovery subsystem is initialized
>before "nvmet" debugfs directory is created. This results in discovery
>subsystem debugfs directory to be created in debugfs root directory.
>
>nvmet_init() ->
>  nvmet_init_discovery() ->
>    nvmet_subsys_alloc() ->
>      nvmet_debugfs_subsys_setup()
>
>In other words, the codepath above is exeucted before nvmet_debugfs is
>created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
>instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
>Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
>
>Fixes: 649fd41420a8 ("nvmet: add debugfs support")
>Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_
Content-Type: text/plain; charset="utf-8"


------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_--

