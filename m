Return-Path: <linux-kernel+bounces-757260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA5B1BFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904933BBEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A051F2B8D;
	Wed,  6 Aug 2025 05:41:07 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161661805A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458867; cv=none; b=YpW14g+EuCT1bj1Huz8IDiF25v2jRwz66exAkBLItjZRkguVdc6kJjB8JlLeU2Xd6ze7yuoS+uVCzlAos3HmVhskDjveQYDIxM9bgDSraryOx7OiSCdzn+yRDEIBwBU+47E9Th97ahWut6eCnvoIIj767pRp2qlFzobcdAF6yIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458867; c=relaxed/simple;
	bh=SveaGViykbY3TYtVxfiM5Y577lLYy08kFwPXresyiSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P49IZalWrQ8RjvrkWDcJJ0Gp8DnxQ/LVL90MvZm4bjO8S3MKR+TX7X9XE+PzVbKRnmocYvUe1xlJ22lb0etuRZjExc0eMsnPljvbIvk60ed5I2Sz0380+vEd2CfuCNW+1DTwsZ6CsQg6FUdcInma42DNPId/lMxk8H5TjDXbcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec780c02728711f0b29709d653e92f7d-20250806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fe23d0c5-1d92-4def-99d8-9d1f4cb7171a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:690d50016041c7436034199a39a039aa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ec780c02728711f0b29709d653e92f7d-20250806
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1259630706; Wed, 06 Aug 2025 13:40:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D6217E008FA3;
	Wed,  6 Aug 2025 13:40:55 +0800 (CST)
X-ns-mid: postfix-6892EAE7-70206937
Received: from localhost.localdomain (unknown [10.42.12.14])
	by mail.kylinos.cn (NSMail) with ESMTPA id 90841E008FA2;
	Wed,  6 Aug 2025 13:40:54 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Subject: Re: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions
Date: Wed,  6 Aug 2025 13:40:53 +0800
Message-Id: <20250806054053.1507456-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a4491b54-4e08-4bcc-bcd3-3bae20a490b2@suse.cz>
References: <a4491b54-4e08-4bcc-bcd3-3bae20a490b2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8/5/25 13:15 PM, Vlastimil Babka wrote:
> Is the before/after swapped here? This output suggests some functions
> became NOT inlined.
>=20
> If I'm right the output binary becomes slightly larger. But it doesn't
> matter.

Thank you for your careful review. You're absolutely right - the=20
before/after columns in my previous data table were accidentally=20
reversed. I've corrected this in the updated measurements below:

[root@localhost linux_old1]# ./scripts/bloat-o-meter  befor.vmlinux after=
.vmlinux=20
add/remove: 0/6 grow/shrink: 1/0 up/down: 4747/-4569 (178)
Function                                     old     new   delta
unmap_page_range                            1018    5765   +4747
__pfx_zap_pte_range                           16       -     -16
__pfx_zap_present_ptes.constprop              16       -     -16
__pfx_zap_pmd_range.isra                      16       -     -16
zap_pmd_range.isra                           589       -    -589
zap_pte_range                               1236       -   -1236
zap_present_ptes.constprop                  2696       -   -2696
Total: Before=3D35379608, After=3D35379786, chg +0.00%
[root@localhost linux_old1]#=20


