Return-Path: <linux-kernel+bounces-753234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F4B1805D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794AF3B2F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A421C17D;
	Fri,  1 Aug 2025 10:46:08 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1032B9A5;
	Fri,  1 Aug 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045167; cv=none; b=XTlxesu55QUmk4GG3DVQBsBkxD20JA3EvJym6HUAIYjnXeParnju/N7I7Cc769Y/FEvBchypKlxiz9BKwtG1s1CjX/FAYum2rsrLTsD2IIgriVTxadXweGPb08E+AwqaQkBipEFnJXDQ+l0QaZIdl9+gQL05Sydy5CJGOk44JKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045167; c=relaxed/simple;
	bh=wO4YLE/qyjKXyEjvQuQolcQxJAnNhE8s1QqCW8/R8rM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=qTkaBs0phMx0UZsbFAsPhb6REM66UOZ3/fuu8HBEfVqHwdPAFiGfjg5em0BlD3bV5aQqt6iZ6PzioQjE+Xh08w/v8AtKqnaOX2p19U4d+zIoGYWZpSQ2XH3aqhF4jWMACGr5hNuMNXq3YfQ9WwQS6BPPzEIzJxcCL4kS9mwuoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4btjKc4HKhz5B0m9;
	Fri, 01 Aug 2025 18:45:56 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 571AjdMq066312;
	Fri, 1 Aug 2025 18:45:39 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 1 Aug 2025 18:45:42 +0800 (CST)
Date: Fri, 1 Aug 2025 18:45:42 +0800 (CST)
X-Zmail-TransId: 2b08688c9ad65f5-397e7
X-Mailer: Zmail v1.0
Message-ID: <20250801184542180vULzMsTl45L6TbNV9yato@zte.com.cn>
In-Reply-To: <202507281628341752gMXCMN7S-Vz_LHYHum9r@zte.com.cn>
References: 202507281628341752gMXCMN7S-Vz_LHYHum9r@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <wang.yaxin@zte.com.cn>
Cc: <akpm@linux-foundation.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBkZWxheXRvcDogRW5oYW5jZSBlcnJvciBsb2dnaW5nIGFuZCBhZGQgUFNJIGZlYXR1cmUgZGVzY3JpcHRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 571AjdMq066312
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: yang.yang29@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 01 Aug 2025 18:45:56 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688C9AE4.000/4btjKc4HKhz5B0m9

> 2) PSI feature documentation:
> - Updated header comment to reflect PSI monitoring capability
> - Improved output formatting for PSI information

Acked-by: Yang Yang <yang.yang29@zte.com.cn>

Looking forward for this:
Another suggestion, we can provide a new command to control
the display of either the total memory delay for tasks or detailed
memory delays. This approach offers two benefits: first, it better
aligns with PSI results; second, it offers choices for users with
different interests (e.g., some users may not have enabled or
are not concerned about swap delay).

