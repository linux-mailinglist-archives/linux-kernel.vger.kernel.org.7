Return-Path: <linux-kernel+bounces-691332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E4ADE379
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC14189656F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA0201266;
	Wed, 18 Jun 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JdCASgnK"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5A1A2630
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227282; cv=none; b=JfrRzE7MUitiPkbVq8LIVGkqRmu7IKJJV8/FB1KW2ugfNNJw7QxJAKuCInreeIXdbIdv750BjkfO30ccU0VSWFg/fWLHleWLdQ7q28WYCcWgYXpMf186pMb6OxHAWRTfpvJ3V8ysHEZ5bQn/w1ZLhV9kh4bJ97VJOAyupKesdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227282; c=relaxed/simple;
	bh=GISdvLlhB4wq5Zikg2XZlMze4njclW/mJXKXxKeLpQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=lY4lwDTgNSmJ/MaZYapENuQUQ/IZllySwC0uTAOIKMhlJ3Tb1WpSas2GnJWCSMxFSJoVxa+9TJ3keMDsBCk+yXXIkrVLGTCKaZI+atnYz1Wi3fLg5YAUib9dkhWI8ldUTgnaJLhyDOlKvf0Tf3Pb0BTYOAocxOo7TiWLYqed3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JdCASgnK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250618061436epoutp0234880d663b92bb60337ab35a74436ef2~KDm9r8hxb2548225482epoutp02i
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:14:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250618061436epoutp0234880d663b92bb60337ab35a74436ef2~KDm9r8hxb2548225482epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750227276;
	bh=eqyhFyOn+tXYm2eBjD+rNBRRmBhCV6qEMFxuXTHI0Mo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=JdCASgnKk31/NedIFp1EmUu6maaYQiB/U2GAKN4KJnR6IxnxXhy9CpP2kljarMpc2
	 fwuFTOXT1QIAPqQATqdqS7cZveYsc9cDqVO9iVv4P2FlQi50LnxKFBPvhyQGj+T5Zl
	 MXq1yLhfh+cbM8+iA6oLS2d65FbybEEaXpEueWH4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250618061436epcas5p27bd2e571fe77d3bf1dab83faf7758c20~KDm9Wt4Fg1383113831epcas5p29;
	Wed, 18 Jun 2025 06:14:36 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.181]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bMYNp1HQxz6B9mJ; Wed, 18 Jun
	2025 06:14:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250618050409epcas5p48f60d6022d148a22fc9fd4a025cc45ca~KCpcVkUtz2632626326epcas5p42;
	Wed, 18 Jun 2025 05:04:09 +0000 (GMT)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618050408epsmtip24d9afc45a9affc3e1ce2476b6eca1905~KCpbxKp9W0227102271epsmtip2O;
	Wed, 18 Jun 2025 05:04:08 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] block: The Effectiveness of Plug Optimization?
Date: Wed, 18 Jun 2025 13:04:01 +0800
Message-ID: <20250618050401.507344-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618050409epcas5p48f60d6022d148a22fc9fd4a025cc45ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618050409epcas5p48f60d6022d148a22fc9fd4a025cc45ca
References: <CGME20250618050409epcas5p48f60d6022d148a22fc9fd4a025cc45ca@epcas5p4.samsung.com>

The plug mechanism uses the merging of block I/O (bio) to reduce the frequency of
I/O submission to improve throughput. This mechanism can greatly reduce the disk
seek overhead of the HDD and plays a key role in optimizing the speed of IO. However,
with the improvement of storage device speed, high-performance SSD combined with
asynchronous processing mechanisms such as io_uring has achieved very fast I/O
processing speed. The delay introduced by flow control and bio merging may reduced
the throughput to a certain extent.

After testing, I found that plug increases the burden of high concurrency of SSD on
random IO and 128K sequential IO. But it still has a certain optimization effect on
small block (4k) sequential IO, of course small sequential IO is the most suitable
application for merging scenarios, but the current plug does not distinguish between
different usage scenarios.

I have made aggressive modifications to the kernel code to disable the plug mechanism
during I/O submission, the following are the random performance differences after
disabling only merging and completely disabling plug (merging and flow control):

------------------------------------------------------------------------------------
PCIe Gen4 SSD 
16GB Mem
Seq 128K
Random 4K
cmd: 
taskset -c 0 ./t/io_uring -b 131072 -d128 -c32 -s32 -R0 -p1 -F1 -B1 -n1 -r5 /dev/nvme0n1
taskset -c 0 ./t/io_uring -b 4096 -d128 -c32 -s32 -R1 -p1 -F1 -B1 -n1 -r5 /dev/nvme0n1
data unit: IOPS
------------------------------------------------------------------------------------
             Enable plug          disable merge           disable plug
Seq IO       50100                50133                   50125
Random IO    821K                 824K                    836K           -1.83%
------------------------------------------------------------------------------------

I used a higher-speed device (PCIe Gen5 server and PCIe Gen5 SSD) to verify the hypothesis
and found that the gap widened further.

------------------------------------------------------------------------------------
             Enable plug          disable merge           disable plug
Seq IO       88938                89832                   89869
Random IO    1.02M                1.022M                  1.06M          -3.92%
------------------------------------------------------------------------------------

In the current kernel, there is a certain flag (REQ_NOMERGE_FLAGS) to control whether
IO operations can be merged. However, the decision for plug selection is determined
solely by whether batch submission is enabled (state->need_plug = max_ios > 2;).
I'm wondering whether this judgment mechanism is still applicable to high-speed SSDs.

So the discussion points are:
	- Will plugs gradually disappear as hardware devices develop?
	- Is it reasonable to make flow control an optional configuration? Or could
          we change the criteria for determining when to apply plug?
	- Are there other thoughts about plug that we can talk now?

Thanks,
Xue He


