Return-Path: <linux-kernel+bounces-849091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA6BCF2EC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DAB4070CE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F62417C3;
	Sat, 11 Oct 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5RBkcU/Q"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB622D7B0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174648; cv=none; b=T1XGvRm564/QvJYxicjnCSOeVUkeVdbUIznnN9T3gBWfC8lTk+WXWHRZY0DJ3wy7aFxjKzrSMbvgBY1l8EUEhVYz91Twh2sX8ILKSmKe+TMGOUZlqYsiOzIhhGTLiLULKRgwVkUFOqe1hkADXmHpXejToO+kxM30VZvhKo8VioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174648; c=relaxed/simple;
	bh=theDeGjlPPB9YhwdwCqYRk1QZMWDVFgXmSGijAh4r7s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bBXg/5G4UpP+DYBhQ9dADbQP13ta9OlKXEKzteYiq/MoShqfQBaSQRwNZWcPXovnkI3uUTPA8MIHOjChY/DmEykOk/bbMXqeCvJfrQJ4xbK9MkmtOk/mg7xBVa7/yDiOE16sUd9/leIoeczOQKo5NUVUfXog+FCf39h4Bu8VaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5RBkcU/Q; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Gh7NoH74T5YktqTUgVgDG2GLtcrYJJBzP7VQdRxnn28=;
	b=5RBkcU/QQUx0bJ2KJDufRRDtWJesq8Rq4MlITiAH5edFw0pihUjScgU/O2THm8abM9CYJJqBH
	vq5ps5XWnw3Cf4CxTPpG4laKzdVxPvPithlr1Y7mgdgToorkJi60m7p5GOqE0AP5Icn1ftx7wVd
	tkR+/Gk4waRrUjfbkLLzhq8=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ckJ7F12XmznTVB;
	Sat, 11 Oct 2025 17:23:05 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F799140123;
	Sat, 11 Oct 2025 17:23:52 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 17:23:52 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 17:23:51 +0800
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
To: Lance Yang <lance.yang@linux.dev>
CC: Longlong Xia <xialonglong2025@163.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
	<xu.xin16@zte.com.cn>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	Longlong Xia <xialonglong@kylinos.cn>, <david@redhat.com>
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
Date: Sat, 11 Oct 2025 17:23:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/11 15:52, Lance Yang wrote:
> @Miaohe
> 
> I'd like to raise a concern about a potential hardware failure :)

Thanks for your thought.

> 
> My tests show that if the shared zeropage (or huge zeropage) gets marked
> with HWpoison, the kernel continues to install it for new mappings.
> Surprisingly, it does not kill the accessing process ...

Have you investigated the cause? If user space writes to shared zeropage,
it will trigger COW and a new page will be installed. After that, reading
the newly allocated page won't trigger memory error. In this scene, it does
not kill the accessing process.

> 
> The concern is, once the page is no longer zero-filled due to the hardware
> failure, what will happen? Would this lead to silent data corruption for
> applications that expect to read zeros?

IMHO, once the page is no longer zero-filled due to the hardware failure, later
any read will trigger memory error and memory_failure should handle that.

Thanks.
.

