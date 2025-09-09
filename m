Return-Path: <linux-kernel+bounces-807037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07947B49F2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2531BC3F4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB762459DD;
	Tue,  9 Sep 2025 02:23:33 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9F2236F0;
	Tue,  9 Sep 2025 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384613; cv=none; b=eeXZ+m0hYsX93x9UOL3kiq3iX/d/caRnXfKOG6RmoBKuvXtk4jA2KFE3EvCcbsK3QiyoXAPEctP7InHwJLWdlka9LGUWBiylL2NKHjbKojgRuhDZGfn7O4BLb1fMRt/mKOx+aS/GYYbfrqkGL5V6QFRhHyS8FpW8xQqWB+3jq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384613; c=relaxed/simple;
	bh=UkWhHdd9NUv+uIyG7x3woimdUTovmLF3qGi6a3dM1hI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=TIcdiO5g8/+ML0BQYLsXg7eI7+rLYgfaDi6LOE65SgQNa/tmBE9Rz6ZuE7dn5jAr5jyc0Qv3Fr8yTXX0LR/YNiPYQ4yhs3ijam+nkBJL2SsUBFgjelcNkIVCejbopEUmxN9q6HKOcpL/LDWYUSax1NLZMDpgNErfXr5UbL++ILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cLSKk2ytPz5PM37;
	Tue, 09 Sep 2025 10:23:22 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 5892N8wD035468;
	Tue, 9 Sep 2025 10:23:08 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Sep 2025 10:23:09 +0800 (CST)
Date: Tue, 9 Sep 2025 10:23:09 +0800 (CST)
X-Zmail-TransId: 2afb68bf8f8d85e-a2c12
X-Mailer: Zmail v1.0
Message-ID: <20250909102309375p7Qo7NCj--86aJ6-hj3r1@zte.com.cn>
In-Reply-To: <20250907001417537vSx6nUsb3ILqI0iQ-WnGp@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn,20250907001417537vSx6nUsb3ILqI0iQ-WnGp@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYyIGxpbnV4LW5leHQgNC81XSB0b29scy9kZWxheXRvcDogSW1wcm92ZSBlcnJvciBoYW5kbGluZyBmb3IgbWlzc2luZyBQU0kgc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5892N8wD035468
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 09 Sep 2025 10:23:22 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BF8F9A.000/4cLSKk2ytPz5PM37

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> Enhanced display logic to conditionally show PSI information only
> when successfully read, with helpful guidance for users to enable
> PSI support (psi=1 cmdline parameter).
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  tools/accounting/delaytop.c | 182 +++++++++++++++++++++++-------------
>  1 file changed, 116 insertions(+), 66 deletions(-)

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

