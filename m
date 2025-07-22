Return-Path: <linux-kernel+bounces-741076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A778B0DFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5021893AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E322EBDD9;
	Tue, 22 Jul 2025 14:56:32 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2B2BF010
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196191; cv=none; b=NpGRaG+b0ikWtRNF9LMg3B9f53fRRSIg6682F4IO2aXFwzNKkHdy24mIygGqk7HNlogdjhLqv00iW7URt7E9ASnBY2Pl+iBYQzYQXuZ8GzXyokOahhyU+E32qBst+0kfvnWgKNuCMK+9zV6a+lMjN9CW+JAYIuU6IKbCYiGfeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196191; c=relaxed/simple;
	bh=9E9NiM4J7eOwpyi1IrtDfZYpDhCjuN4hB6VjhVlUwo4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=QBQSrlVUSr8Um7IZm1EPiv+8O02U6FFB5LMoj8ftVkeW0P2oG6Et/sHTV/i9ba8WXmkGOxb4TVNY4Eo+LwZcVNBPkQjVh5ltxtzhVlGWs/+0Mu1nvWmlMezok+eljymTBfz9/w29dk6TD/SfOLw24ergPiGnRcGJO89IDzRDvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bmgM70SvMz59trK;
	Tue, 22 Jul 2025 22:56:19 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 56MEuDZ4051863;
	Tue, 22 Jul 2025 22:56:13 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid14;
	Tue, 22 Jul 2025 22:56:17 +0800 (CST)
Date: Tue, 22 Jul 2025 22:56:17 +0800 (CST)
X-Zmail-TransId: 2b04687fa691ffffffffecb-246be
X-Mailer: Zmail v1.0
Message-ID: <20250722225617123Fj3T0Py6UEGIXmSx1VH7s@zte.com.cn>
In-Reply-To: <20250722165841838ou4ZoIujZCCgIG2HAu1T8@zte.com.cn>
References: 20250721094049958ImB8XG_imntcPqpQn1KfG@zte.com.cn,20250722165841838ou4ZoIujZCCgIG2HAu1T8@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>
Cc: <krzk@kernel.org>, <jiang.kun2@zte.com.cn>, <akpm@linux-foundation.org>,
        <xu.xin16@zte.com.cn>, <bbonev@devuan.org>,
        <linux-kernel@vger.kernel.org>, <bsingharora@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eCBuZXh0XSBNQUlOVEFJTkVSUzogYWRkIG1haW50YWluZXJzIGZvciBkZWxheXRvcA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56MEuDZ4051863
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: yang.yang29@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 22 Jul 2025 22:56:19 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687FA693.000/4bmgM70SvMz59trK

> which is highly beneficial for improving system performance. Wang Yaxin
> and her colleague Fan Yu focus on locating system delay issues. To promote
> the thriving development of delaytop, we hope to serve as maintainers to
> continuously improve it, aiming to provide a more effective solution for
> system latency issues in the future.
I'm pleased to see young colleagues contributing multiple patches in the field of
delay observation and aspiring to become maintainers of new tools. With more
and more latency-sensitive devices running Linux, such as communication
equipment and intelligent vehicles, I believe delay observation is a promising
area, and thus delaytop has good potential for application. On the other hand,
the tool is still somewhat simple, and I have already replied with some suggestions
—I would feel happy if you adopt them. I thingk becoming a maintainer means
passion and responsibility, hope you will keep moving forward. Best of luck!

Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>

