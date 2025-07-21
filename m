Return-Path: <linux-kernel+bounces-739191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA653B0C30B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC953AA144
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5A29E108;
	Mon, 21 Jul 2025 11:33:30 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27021D3C6;
	Mon, 21 Jul 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097609; cv=none; b=si+wkzGeh5D50ueHoAIuZeErmTlfxAIIcipO2UAJ6aGrGXpcbmm7v6dwuJrMSCRyJPWkWLnOxv3vw4rLETdaoXH2t96r/NaGe1DBkihxYpuEJLsVHW3EjbE+1NiopsyVTwpA5iaUjRy/DlfR8yOrvf+k2wQ4MhlcRQs/HU9iRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097609; c=relaxed/simple;
	bh=KKvmUmWcQY1wXgnTVdyMr9Kb3/PggkMGOQ9o8GIKMDg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=KrnAWV7xgE4HSZe6Y87dodr7UeiReAjebt8EgSRYDEFddF5O0JnhYCBUr3nwocsSzy1MhCceHHP2goEUhotpC65LtCui5K9+1wwHViy1CUAT9esbWK+Dl4qyt3RTZnBRJxDjWw+grdHrTRjerieUpvKlhCVEFgaKFYrXG685Org=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4blyvP57Qnz8Xs6r;
	Mon, 21 Jul 2025 19:33:21 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 56LBXJER045075;
	Mon, 21 Jul 2025 19:33:19 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 21 Jul 2025 19:33:22 +0800 (CST)
Date: Mon, 21 Jul 2025 19:33:22 +0800 (CST)
X-Zmail-TransId: 2afa687e2582ffffffffd92-8a91b
X-Mailer: Zmail v1.0
Message-ID: <20250721193322167TaEFleLW3vBmZqrNUDEoy@zte.com.cn>
In-Reply-To: <20250718165746013rPfwDG8PRZ2LMvX4a0Z8U@zte.com.cn>
References: 202507181649341810Ko3RM5-OgAx9p_La6NlZ@zte.com.cn,20250718165146589nw7ReAlsBvkwAr57nH5pr@zte.com.cn,20250718165327644wT54xAeByO_X1pWdScPny@zte.com.cn,20250718165448516aBqB6ZJ9DWn8e3Msmsjcg@zte.com.cn,20250718165639141feLENLI73QuSBT26qDN17@zte.com.cn,20250718165746013rPfwDG8PRZ2LMvX4a0Z8U@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <shao.mingyin@zte.com.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <dzm91@hust.edu.cn>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <shao.mingyin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA1LzVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBnZnMyLWdsb2Nrcy5yc3QgdG8gU2ltcGxpZmllZMKgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56LBXJER045075
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 21 Jul 2025 19:33:21 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687E2581.001/4blyvP57Qnz8Xs6r

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> translate the "gfs2-glocks.rst" into Simplified Chinese.
>
> Update to commit 713f8834389f("gfs2: Get rid of emote_ok
> checks")

> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Signed-off-by: yang tao <yang.tao172@zte.com.cn>

Your 5 patches of one set are not in the same thread. Please resend them like:
patch 0/5   
    patch 1/5
    patch 2/5
    ...

