Return-Path: <linux-kernel+bounces-772778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C164B2976A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4917EC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0C25DD0B;
	Mon, 18 Aug 2025 03:43:47 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20797253B56
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755488627; cv=none; b=AXtvA8oU3mHCYgyGQpO1ohPB0zy1+o582DCayHekiiQCICRkGzURwpsCj6SUs+L7GVkhQ0DLXbpiDk0QNFgkB7/apkzFy+xMhFoYf/+1DAOb66KHZrumphcRapa3aqwhdzahaRRtarTlkMFWnzSctsYL2yLaQxmBe4HnlQBBn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755488627; c=relaxed/simple;
	bh=k0E3ZIogSdm1MaLSCXvsC4uWazhPr3aI2FbDsFS11cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6GKKoZ/H4bHJwLqy3sGs6eQ7m8qAto1UJZnjtGB40WHxpQnvZN+/B67poU5MrAwVH1md63Q4omAjtO7h1ztH9+A9GLid+nF2JU8KVZ6PLPM6oYjSRlHyBSFlCexQ/G5z1Fnx+XCGj9OHVOLGypLDmKFK+BMehiWuLNXKcCiau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c4z9n0qPsz3TqWx;
	Mon, 18 Aug 2025 11:44:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 34E5B1A016C;
	Mon, 18 Aug 2025 11:43:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 11:43:39 +0800
Message-ID: <49395077-1af8-42c2-09bd-b87ed9d4a41b@huawei.com>
Date: Mon, 18 Aug 2025 11:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 0/8] arm64: entry: Convert to generic irq entry
To: kemal <kmal@cock.li>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
 <20250817211403.31054-1-kmal@cock.li>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250817211403.31054-1-kmal@cock.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/18 5:14, kemal wrote:
> Hello,
> 
>> Since commit a70e9f647f50 ("entry: Split generic entry into generic
>> exception and syscall entry") split the generic entry into generic irq
>> entry and generic syscall entry, it is time to convert arm64 to use
>> the generic irq entry. And ARM64 will be completely converted to generic
>> entry in the upcoming patch series.
> 
> I was trying to implement syscall user dispatch support for ARM64,
> which is simply about converting arm64 to use the generic entry, and I
> stumbled upon your patchset on Google. So I decided to write the code
> for generic syscall entry on top of this patchset, and the code seems
> to be working. (It boots, and SUD works, but I didn't test ptrace etc.)
> 
> Should I send the code here?

I have implement the generic syscall entry in v5 and will completely
convert arm64 to generic entry in the upcoming patch series.

https://lkml.org/lkml/2024/12/6/609

