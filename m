Return-Path: <linux-kernel+bounces-807024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F454B49F05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D864E0854
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33D226D1F;
	Tue,  9 Sep 2025 02:15:50 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FE199237;
	Tue,  9 Sep 2025 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384149; cv=none; b=gDBa+XLfDOq0naooD0PZFHIbKm+vnZP9pLsBzbMKs44OBaPy9sATW9fbkZofgflVMOH6YgsNJh3Hy5MlNNg+HlTjoMNo58fOvgwV7tf2jWmiC+yhBLWKEF/sAdUFtfutl4pl7R15Chfqx9kJlk0+SOb3CIducb3sx40VI4ukUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384149; c=relaxed/simple;
	bh=xNZvyDQ1n3aZqnZ6DHr0YTentZOsKBwU6+73Kz5nceo=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=qZg9ZwqBI1P1kxQc+2VVCUTJwXQZUBJo5J3OXPqHxL5y69S/ZedM/G7CXwKmCWv4HMeGB+TQeP+qr/Hl+fRwtyAa956WH8HGbGRmJlMKMqRDL3hlJ03iuAsXGqd3AiPcd1Vv/3HXfModNLJG0Q1DZWSBikz+xIBBIFMbBByn2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cLS8m2kLRz4xPSM;
	Tue, 09 Sep 2025 10:15:36 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5892FUOs033253;
	Tue, 9 Sep 2025 10:15:30 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Sep 2025 10:15:31 +0800 (CST)
Date: Tue, 9 Sep 2025 10:15:31 +0800 (CST)
X-Zmail-TransId: 2afc68bf8dc3860-8fc27
X-Mailer: Zmail v1.0
Message-ID: <202509091015317206T0YwBsiVQbhvFv-mvlcg@zte.com.cn>
In-Reply-To: <20250907001205573L3XpsQMIQnLgDqiiKYd3H@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn,20250907001205573L3XpsQMIQnLgDqiiKYd3H@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSHYyIGxpbnV4LW5leHQgMS81XSB0b29scy9kZWxheXRvcDogYWRkIGZsZXhpYmxlIHNvcnRpbmcgYnkgZGVsYXkgZmllbGQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5892FUOs033253
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 09 Sep 2025 10:15:36 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BF8DC8.000/4cLS8m2kLRz4xPSM

> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> The delaytop tool only supported sorting by CPU delay, which limited
> its usefulness when users needed to identify bottlenecks in other
> subsystems. Users had no way to sort processes by IO, IRQ, or
> other delay types to quickly pinpoint specific performance issues.
> 
> Add -s/--sort option to allow sorting by different delay types.
> Users can now quickly identify bottlenecks in specific subsystems
> by sorting processes by the relevant delay metric.
> 
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  tools/accounting/delaytop.c | 153 ++++++++++++++++++++++++++++--------
>  1 file changed, 121 insertions(+), 32 deletions(-)

Reviewed-by: xu xin <xu.xin16@zte.com.cn>

Thanks,
xu

