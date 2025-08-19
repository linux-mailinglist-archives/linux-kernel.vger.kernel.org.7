Return-Path: <linux-kernel+bounces-774773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91649B2B74D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4A5E8460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4929BDA3;
	Tue, 19 Aug 2025 02:49:34 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C528BAAC;
	Tue, 19 Aug 2025 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571774; cv=none; b=DDgyD0LuGHJ0Ar3RXqdHa6xBOFsmy/rqUC0P9ASWSgFC5tqJ8FKuYhmgzJXNYMFTsUYQ4Xick9FZOILqNrDmYArCktsJvYRLwg9zt1ep5jRI6phaV3KTYPpIyEOTH/qiioDpVXPKlNN8D1/zyxqee9hSPi+HBFhJEn1MeZ6nK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571774; c=relaxed/simple;
	bh=0IMok+uap6k4TA4hL/jsNVKrf7AhzoFb/agBeC2ZSxI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=SIDkNhBs+hMZjuAWZmw+smjXrRcBERJl5g2viMqyToBXjE37jrgRCE60k74eRQafsVaMpaOhE0nesyyA/ry6ZTYAEuyR68pGP8tfC+3gj82XlZxF+WOMrNKIOT16Yh9BelO3J3gXV3jhGMz5VeCcOVB/QRAxLlQ4I+gzBNKxDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c5YvS2gXYz4xNtc;
	Tue, 19 Aug 2025 10:49:24 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57J2muRc086754;
	Tue, 19 Aug 2025 10:48:56 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 19 Aug 2025 10:48:57 +0800 (CST)
Date: Tue, 19 Aug 2025 10:48:57 +0800 (CST)
X-Zmail-TransId: 2afa68a3e6194fb-6f108
X-Mailer: Zmail v1.0
Message-ID: <20250819104857534LiqtVKwdKo9YvtrWNyVx3@zte.com.cn>
In-Reply-To: <20250801184542180vULzMsTl45L6TbNV9yato@zte.com.cn>
References: 202507281628341752gMXCMN7S-Vz_LHYHum9r@zte.com.cn,20250801184542180vULzMsTl45L6TbNV9yato@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <yang.yang29@zte.com.cn>
Cc: <wang.yaxin@zte.com.cn>, <akpm@linux-foundation.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBkZWxheXRvcDogRW5oYW5jZSBlcnJvciBsb2dnaW5nIGFuZCBhZGQgUFNJIGZlYXR1cmUgZGVzY3JpcHRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57J2muRc086754
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 19 Aug 2025 10:49:24 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A3E634.002/4c5YvS2gXYz4xNtc

> Looking forward for this:
> Another suggestion, we can provide a new command to control
> the display of either the total memory delay for tasks or detailed
> memory delays. This approach offers two benefits: first, it better
> aligns with PSI results; second, it offers choices for users with
> different interests (e.g., some users may not have enabled or
> are not concerned about swap delay).

Agreed. I’ll implement this as a new interactive usage with on-screen keybindings
to toggle between a summarized total memory delay and the full breakdown.

