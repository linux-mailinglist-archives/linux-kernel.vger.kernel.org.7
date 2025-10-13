Return-Path: <linux-kernel+bounces-850543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FFABD323C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C54E4FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11A2EBBB5;
	Mon, 13 Oct 2025 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0bycGqzx"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25C23BD1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360966; cv=none; b=rsPVhepXsz2DsUFkcf/mThbcUvzDef+ihmLEBGi5tNJDExlqmS4HBngGKgLjy+0Z5qCbyLgWSKwSAf0g/O2d8E9tswGMRxQUmMLUfm7qjXFycaCSnwM7PehFjdV42Rca/8f1NcRCsiZcWGwCUsaMc9bRBr7QIYoMShFnMZlkl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360966; c=relaxed/simple;
	bh=DJF/UEPtiTFfQ9ks+sBeKnk+ybZTLIlvE6onlOXYICo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvAk4LNe1BJo2ebtDVLcfcZw276x3+BBJDgiZ6f88NKedOi7Hn3+0dxZuVP6NhRxiz6aTz9CZ9HsAnOWBVdxM/XOl5RVD4Gy1XfDsL6bjV4zSR+IUKRO/nWRtPo3vAivEqO9F2p9EvTlyTyZAehhksm2DlrWt2wVocuDpqhvecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0bycGqzx; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+VobbKqXywkoCcnj0oHI4uJICOpsAyXpY4P1XFIsh04=;
	b=0bycGqzxuLKKR74iLRiCMP/Phmn2LqeE71aBIx3hl6RIc1mrRbEgg5wuqoFKm+PntoUIFVEFc
	72EXxFXpqgeU/dTxjLBbgN391DKzYx6guwNR4A8nP3Y0i2+i/YZ6Jg6dTPDSlv+3aC/BNBKE5Hs
	UxTUlDIRdRyt0R7vfn2bTl0=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cld2R33H5znTW3;
	Mon, 13 Oct 2025 21:08:31 +0800 (CST)
Received: from dggpemf200005.china.huawei.com (unknown [7.185.36.191])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E02F1A0188;
	Mon, 13 Oct 2025 21:09:17 +0800 (CST)
Received: from huawei.com (10.67.175.66) by dggpemf200005.china.huawei.com
 (7.185.36.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Oct
 2025 21:09:17 +0800
From: Bowen You <youbowen2@huawei.com>
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <ldufour@linux.ibm.com>, <mpe@ellerman.id.au>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu/SMT: recover global num_threads after disable smt switch fail (Ping)
Date: Mon, 13 Oct 2025 12:54:26 +0000
Message-ID: <20251013125426.204146-1-youbowen2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf200005.china.huawei.com (7.185.36.191)

Hi Maintainers,

I wanted to kindly follow up on the patch I sent on 2025-09-30 
(Message-ID: <20250930090330.3633926-1-youbowen2@huawei.com>) regarding 
*cpu/SMT: recover global num_threads after disable smt switch fail*.

This patch addresses an issue where the global `num_threads` value is not 
properly restored if disabling SMT fails. Please let me know if there’s 
anything I can do to improve it or if further clarifications are needed.

Thanks again for your time and effort reviewing this patch. Your feedback 
is greatly appreciated!

Best regards,  
Bowen You


