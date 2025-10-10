Return-Path: <linux-kernel+bounces-847680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED9BCB677
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C33C80A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF11EF0B0;
	Fri, 10 Oct 2025 02:19:55 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B253F9FB;
	Fri, 10 Oct 2025 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760062794; cv=none; b=Oh3C1AnQz5YIfiRXFFDOn/n8Hf3/QCVDTQfbRb/PNsgu2gzZxKi0+Sh392sx1raZEaUBtw3xkZ6GoxQ+Ukfwnio5JM1TcHKdiXs81gIqCitcAKR9m/pLWOoDfvl1rRB/+kQOwSjXmNyRLeEjpD9EoWc5G3W5bDqW8kzpYTrX8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760062794; c=relaxed/simple;
	bh=H4rwtwxheMrKspUo4FRhc7L8mv59sXRKgQUg7DBSzXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2TeOl2YD5Vm/2zqL8LNGPwU+A1AfDtTdCugAUXiPy5Mo44DrFJz599kHE/IeYSnxiAqUTi9kzc7zLV8EtMdjwq85+zXXW7r4umgILxbii+w+J0QSwRTV7pjA7KgGLSuf1eDTJKkWPvnKMxROh8dU2XiM/ZmHhJVNnOyOVFIaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cjVmd6tYCzKHMQX;
	Fri, 10 Oct 2025 10:19:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9E1561A0EF8;
	Fri, 10 Oct 2025 10:19:43 +0800 (CST)
Received: from [10.174.176.236] (unknown [10.174.176.236])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mE8behoAzCTCQ--.54861S3;
	Fri, 10 Oct 2025 10:19:41 +0800 (CST)
Message-ID: <54b0b560-493b-4f08-859c-8c1c41cf4c27@huaweicloud.com>
Date: Fri, 10 Oct 2025 10:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2022-50455: nfs: fix possible null-ptr-deref when parsing
 param
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@kernel.org>
References: <2025100118-CVE-2022-50455-24fb@gregkh>
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
In-Reply-To: <2025100118-CVE-2022-50455-24fb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3+mE8behoAzCTCQ--.54861S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWDWF1xuFW7Xw4UKw17KFg_yoW3Zrb_u3
	4vgFWUKw13Xr4Iga18KrZ5Zry2qry3XrykAr42qFy0kr9xurs8AFZ3GFZay3Z3Krn2krs5
	JFn5Zw4kKr1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/





> From: Greg Kroah-Hartman <gregkh@kernel.org>
> 
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> nfs: fix possible null-ptr-deref when parsing param
> 
> According to commit "vfs: parse: deal with zero length string value",
> kernel will set the param->string to null pointer in vfs_parse_fs_string()
> if fs string has zero length.
> 

Hi Greg,

The patch "vfs: parse: deal with zero length string value", which introduced
this issue, was never merged into mainline.

It only exists in the mailing list:
https://lists.openwall.net/linux-kernel/2022/06/28/18

Since the problematic behavior never existed in any released kernel,
CVE-2022-50455 cannot be valid.

Please consider rejecting this CVE.

Best regards,
Wang Zhaolong


