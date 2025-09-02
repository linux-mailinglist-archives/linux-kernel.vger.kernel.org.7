Return-Path: <linux-kernel+bounces-795658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35615B3F603
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08291206184
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52662E54CC;
	Tue,  2 Sep 2025 06:55:09 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA32DEA94;
	Tue,  2 Sep 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796109; cv=none; b=ldM/hTl4tldiK3/kU5R3iMMJ5o6dsg9TNSS69uxbt617WhiRcKodTEDt0t7dLimKwq46/NuJKnuTTSmSy1WU/zqrHYTUM4KWiUt32+RSw7x89E3swFEwNF2JNobcSG+ar5avCod4cbK0i+lTDgukqMFcNt/LDwBiJGWm9p2UcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796109; c=relaxed/simple;
	bh=R0m2L+jDzdhIbQh61c3/ZNofAoOaOFSPQDeMtqKfE6Y=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=jjTJxX3nrAnWuolE3Pjlv9IZKGVU0B103R/ZXUlgYM1CstD84LGIPMW0eNpSgTM5hq/dl30SOlGtm5CxlGJtcqZgdoQv0NjkJfDdn75yU1SBJTmenQYnF/zPiMJ/jrDR7ekBnyXwl2jqsY0q/nxyswL80mn/S/20haCbVEQqgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cGGhQ3Pc2z5PM3R;
	Tue, 02 Sep 2025 14:55:02 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 5826sjBk087698;
	Tue, 2 Sep 2025 14:54:45 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid14;
	Tue, 2 Sep 2025 14:54:48 +0800 (CST)
Date: Tue, 2 Sep 2025 14:54:48 +0800 (CST)
X-Zmail-TransId: 2b0868b694b82c8-a8b62
X-Mailer: Zmail v1.0
Message-ID: <202509021454480003xS5M8WmAIQT2F_IiSd3p@zte.com.cn>
In-Reply-To: <202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <fan.yu9@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDAvM10gdG9vbHMvZGVsYXl0b3A6IGltcGxlbWVudCByZWFsLXRpbWUga2V5Ym9hcmQgaW50ZXJhY3Rpb24gc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5826sjBk087698
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: yang.yang29@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Sep 2025 14:55:02 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B694C6.000/4cGGhQ3Pc2z5PM3R

> 2) Enhanced Usability with On-Screen Keybindings
> More intuitive interactive usage with on-screen keybindings help.
> Reduced screen clutter when only memory overview is needed.

It's more intuitive and easier to understand the patches if show the
output of new features in git log. And we notice that if PSI or
delayaccouting is off, delaytop will output zero data, I think we
should tell user why it's zero, since not all user knows kernel config
will. Else: 
Acked-by: Yang Yang <yang.yang29@zte.com.cn>

