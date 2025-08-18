Return-Path: <linux-kernel+bounces-773165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA55B29C36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D9F1899D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A23002DB;
	Mon, 18 Aug 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eARKmdTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BA2FFDEC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505706; cv=none; b=i6vXV5/NxQ4mGKLg/NZClL0MLgDo+cpjVHxkBa4+CHRPT6gqKAIbaHITSlUkxgTBAnNuryZeWRF5r7K1G08Rx3FOkFDH0Es4V3PDQycDnazmdJfYVDSOR73vtWiuaigPFZAKsSJAPxdRP84ZAWAwfV1fmaomv+FY130XAkNywlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505706; c=relaxed/simple;
	bh=Icogg28ZLs91H1WXJDPU4qMKH1v2aWHOOdl1Ix8d2I4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TgufsXFhKJ9ouXvEbRlQOYuTPf5lWWp68E+lE96jQky00rZk/paPjncZq1izm44YBmXbiYUGBrTlmJbF/a9qrmXX9//qLnlWT+0WC2Cq6O2Cwxi0NX5+EZ5mgsjmfdYVqGwSloTFY2CBRiZJUa7GVlKfHH8xAFFgHOYAhezsE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eARKmdTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35468C4CEEB;
	Mon, 18 Aug 2025 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755505706;
	bh=Icogg28ZLs91H1WXJDPU4qMKH1v2aWHOOdl1Ix8d2I4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eARKmdTcKCTa1s7Bc4eoFK3Y4UKf9bn5vlz8oM6nMwIa7fhi3m1prdiM/3X2/0k0r
	 vgvJ9c6VkUmsCOMMnk5YUHl3ccV9E7U845apbUTitYEn81sAbGX7wLWuDV9e16EMiH
	 4MkgAap41+2V1cX9P0ewqoZVPdbNJr7KfT/iGPqrmL1LeRkE/4v8TEsTaNmgAga8rK
	 zzgpcPijSardkKlCpUXzaSyD2ufYOeheNtX9AYSLEGIFbDqej3MUYtKLWYw+YNyu59
	 kVpt1CLJA7VN0waIuwD5LTOi4vBVpiZAg4hV3c9ZdN199W8ik4nwySDTvo0u/214/p
	 tlTODkNSDEimw==
Message-ID: <943041c7-5eb2-4ddc-b54e-192b61de4bf7@kernel.org>
Date: Mon, 18 Aug 2025 16:28:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: fix to allow removing qf_name
To: Hongbo Li <lihongbo22@huawei.com>, jaegeuk@kernel.org
References: <20250818020939.3529802-1-chao@kernel.org>
 <20250818020939.3529802-2-chao@kernel.org>
 <f503b139-ba90-40ae-8900-db0ba7789525@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f503b139-ba90-40ae-8900-db0ba7789525@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 16:06, Hongbo Li wrote:
> Hi Chao,
> 
> On 2025/8/18 10:09, Chao Yu wrote:
>> The mount behavior changed after commit d18535132523 ("f2fs: separate the
>> options parsing and options checking"), let's fix it.
>>
>> [Scripts]
>> mkfs.f2fs -f /dev/vdb
>> mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
>> quotacheck -uc /mnt/f2fs
>> umount /mnt/f2fs
>> mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
>> mount|grep f2fs
>> mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
>> mount|grep f2fs
>> dmesg
>>
>> [Before commit]
>> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
>> mount#2: ...,quota,jqfmt=vfsold,...
>> kmsg: no output
>>
>> [After commit]
>> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
>> mount#2: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
>> kmsg: "user quota file already specified"
>>
>> [After patch]
>> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
>> mount#2: ...,quota,jqfmt=vfsold,...
>> kmsg: "remove qf_name aquota.user"
>>
>> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
>> Cc: Hongbo Li <lihongbo22@huawei.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/super.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 465604fdc5dd..07f6c8cac07a 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1219,8 +1219,11 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
>>                   goto err_jquota_change;
>>                 if (old_qname) {
>> -                if (new_qname &&
>> -                    strcmp(old_qname, new_qname) == 0) {
>> +                if (!new_qname) {
> 
> Thanks for catching this. Do we also need the patch 1/2 ? It seems this patch also solve the syzbot problems.

I prefer to split it, since it'd better to use one patch to resolve one
problem. :)

Thanks,

> 
> Thanks,
> Hongbo
> 
>> +                    f2fs_info(sbi, "remove qf_name %s",
>> +                                old_qname);
>> +                    continue;
>> +                } else if (strcmp(old_qname, new_qname) == 0) {
>>                       ctx->qname_mask &= ~(1 << i);
>>                       continue;
>>                   }


