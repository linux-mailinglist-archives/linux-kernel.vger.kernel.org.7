Return-Path: <linux-kernel+bounces-763819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A97B21AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3992D1A26A99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF52D3A71;
	Tue, 12 Aug 2025 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HnHzW0Ch"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715328152A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964717; cv=none; b=QMmGgHYrtB4V4dQGpWF2v/ADkCZDGEZu2NrQkkvnFeBmZGDdNAfh7jknXdKI2WFWuLh0wkCoUt4wsjj/f416YCH8eMm+JE2VRJPDFHlS1k3+Fo7plQ9TZ8FKYttSsodVPcimCJFjVXKNtV1O+dYMrbAUWX4q+/0fORexLTfIuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964717; c=relaxed/simple;
	bh=Iz/nn4JR8QQz/ds/6Spin2ipyfgcS6EeeW+Z+7mhuaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gd56nZ1pRxTVgFV6D+QZDBOxuQUYEUR1m7OfUXweUq8Cci8Jou3gObfe4hYWA3rW6Jp5fdXD5mL812lVu6OjCt+lH2vnnpBgL8OjBzJLMhDOT04UIr52kclENTkvXCHOapA4/vJCPSMBXGXH4id2QgOV1qoFtKz3n33IK+LCtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HnHzW0Ch; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=XDNdNXOmo52Q94XIReYYcRMfbXp9CyT343G38778Jxk=;
	b=HnHzW0ChvQ7wyplCanNLS9KdiMHWJ+nCSTozcROxMWgebYQ/ktJ2yV0Ga+alCZ
	1oytHvpQ5QUmTZroNIcM0vyoKBkyJ8oFTQFfJz1EBtzObni0CisoQ1g2GOmy1t6I
	/iEA9BlTab2jDmXr9Cz2kodZ3bSX+rSvwdajb3Q85Cy+c=
Received: from [127.0.0.1] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v_vgoppohntyBQ--.44019S2;
	Tue, 12 Aug 2025 10:11:44 +0800 (CST)
Message-ID: <eb18bedb-4ff8-42ee-a0dd-a3a6dccf70dc@163.com>
Date: Tue, 12 Aug 2025 10:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, Scott GUO <scottzhguo@tencent.com>
References: <20250811061921.3807353-1-scott_gzh@163.com>
 <2156fc8a-a43b-4986-8537-d1d530821dbf@squashfs.org.uk>
From: Scott Guo <scott_gzh@163.com>
In-Reply-To: <2156fc8a-a43b-4986-8537-d1d530821dbf@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v_vgoppohntyBQ--.44019S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfZFyxWrW8Jr1UCFyxuFg_yoW8WFyxpr
	yxWF1YkrWjvF1UZF1IqF95XF1v9w4v9FWUWrW8Zw13X39Ivw17JrWDtrsIg3ySkrnrGrs5
	WF1kWa4S9Fy8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcPE-UUUUU=
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/1tbiOhGnnWianal14gACsC

在 2025/8/12 6:35, Phillip Lougher 写道:
> 
> 
> On 11/08/2025 07:19, scott_gzh@163.com wrote:
>> From: Scott GUO <scottzhguo@tencent.com>
>>
>> If sb_min_blocksize returns 0, -EINVAL was returned without freeing
>> sb->s_fs_info, causing mem leak.
>>
>> Fix it by goto failed_mount.
>>
> 
> Thanks for spotting this, but, NACK to the patch.
> 
> A better fix is to call sb_min_blocksize and check the
> return result before the memory is allocated.
OK, will send v2.>
> Phillip
> 
>> Fixes: 734aa85390ea ("Squashfs: check return result of sb_min_blocksize")
>> Signed-off-by: Scott GUO <scottzhguo@tencent.com>
>> ---
>>   fs/squashfs/super.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
>> index 992ea0e37257..7d501083b2e3 100644
>> --- a/fs/squashfs/super.c
>> +++ b/fs/squashfs/super.c
>> @@ -201,10 +201,12 @@ static int squashfs_fill_super(struct 
>> super_block *sb, struct fs_context *fc)
>>       msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
>> +    err = -EINVAL;
>> +
>>       msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
>>       if (!msblk->devblksize) {
>>           errorf(fc, "squashfs: unable to set blocksize\n");
>> -        return -EINVAL;
>> +        goto failed_mount;
>>       }
>>       msblk->devblksize_log2 = ffz(~msblk->devblksize);
>> @@ -227,8 +229,6 @@ static int squashfs_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>           goto failed_mount;
>>       }
>> -    err = -EINVAL;
>> -
>>       /* Check it is a SQUASHFS superblock */
>>       sb->s_magic = le32_to_cpu(sblk->s_magic);
>>       if (sb->s_magic != SQUASHFS_MAGIC) {


