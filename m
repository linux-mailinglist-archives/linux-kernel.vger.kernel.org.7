Return-Path: <linux-kernel+bounces-822212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC67FB834DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F634A047B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39002EAB73;
	Thu, 18 Sep 2025 07:22:10 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5222E974E;
	Thu, 18 Sep 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180130; cv=none; b=j+eQabCzGmL4feh30mal5KZ2/b+dtNfZ3XFRKPhp1RP9WLhsjyfNpONMhInyE3Vx6Pxm99RF7Le0dk5+IrFpIJAzwEO7oHs/Ft5Xg8ETtC31TqbmVfV/BKdZcyfUoLCs8HpIMxhXocqEkwJGwBjUejXI0C34oo8nKaJTjRR74Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180130; c=relaxed/simple;
	bh=swlBV67SOWk+AZFhclNy1dzncI5mZeQTGBj+RcNPs+w=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Cy7beojCWj7FQ/+rSXbVJw8Y5ZOF4n7XMovlV5/CQ6fAZV7QiIt0uAtD3k7Zhic9EqCPzBqkoGqVHt8RVfRWd3LBylVJKYHOz85S411lPWq0ziyxWDk8BVaJebmwIsae6D80c3Rw/69dCFznnVuLhdQRm/Yk+5I23N9kYdXXg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cS6X841thz8Xs7Q;
	Thu, 18 Sep 2025 15:22:00 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 58I7LfUo062707;
	Thu, 18 Sep 2025 15:21:41 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 18 Sep 2025 15:21:43 +0800 (CST)
Date: Thu, 18 Sep 2025 15:21:43 +0800 (CST)
X-Zmail-TransId: 2af968cbb307f5c-9fc47
X-Mailer: Zmail v1.0
Message-ID: <20250918152143722pZYckCXYuV4VGxDU6Rds_@zte.com.cn>
In-Reply-To: <a6e58245-15cb-42f6-852c-c9db4d43ed66@hust.edu.cn>
References: 20250918144305326x9mQuLPvqgyLm4WTJvZ9I@zte.com.cn,a6e58245-15cb-42f6-852c-c9db4d43ed66@hust.edu.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dzm91@hust.edu.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gRG9jcy96aF9DTjogYWRkIGZpeGVkIGZvcm1hdCBmb3IgdGhlIGhlYWRlciBvZiBnZnMyLWdsb2Nrcy5yc3Q=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58I7LfUo062707
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 18 Sep 2025 15:22:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CBB318.001/4cS6X841thz8Xs7Q

>On 9/18/25 2:43 PM, shao.mingyin@zte.com.cn wrote:
>> From: shaomingyin <shao.mingyin@zte.com.cn>
>>
>> add fixed format for the header of gfs2-glocks.rst
>>
>> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>> ---
>>   .../translations/zh_CN/filesystems/gfs2-glocks.rst   | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>> index 7f094c5781ad..a9c5f8810d20 100644
>> --- a/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>> +++ b/Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst
>> @@ -1,5 +1,17 @@
>>   .. SPDX-License-Identifier: GPL-2.0
>>
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/filesystems/gfs2-glocks.rst
>> +
>> +:翻译:
>> +
>> + 邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
>> +
>> +:校译:
>> +
>> + - 杨涛 yang tao <yang.tao172@zte.com.cn>
>
>
>Only one proofreader, remove the "-"?
>
>Dongliang Mu
OK, I have sent v2.

https://lore.kernel.org/all/20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.com.cn/

Also I found the same issue with the other 4 documents, and I will
send a patch to fix them.

Mingyin
>
>
>> +
>>   ==================
>>   Glock 内部加锁规则
>>   ==================

