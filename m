Return-Path: <linux-kernel+bounces-818775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C129B59654
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6031BC349E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B4130BF65;
	Tue, 16 Sep 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="FNr29e9h"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7C30594E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026218; cv=none; b=gtHhB1wTTQ9qzcy3xoMccE1Ae0jfWdEqdxZv4pyWFa9jkD0SnqlhNZ/gVNvdwTnckulgfRR0qc90SISjChyA8QFK5PgY+6xOnrsbuh5LsP2q1Rf8cYB945VHvssf+qqC3rI/5qprb+bocEKCvVcrb88PBMH+C0BDIqRZK9W4DgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026218; c=relaxed/simple;
	bh=qBcDWRTbQauNXsE/wZ44NxU6pH7G3nulvWkW+ZL0RAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+EZ4wuyQzGdo2HzO8kQ7QC9mHfOUUAPreMbqiRpNMsXHf75fu8Ep3jPbHZf6UO8P/VKe7DvGKWAGYyWBSZOgLMiYugVBGhBCr6rnHyvR7lNZk2DhKHeOUp0fZAcfXI9u60bA0Vy+iapQs+aiTtjlCeCGfR7LXnletLQ346eylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=FNr29e9h; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=0kGUCXBj8dH15jWtuYRrGjjZPzL1qmMxypXxdQKuCes=;
	b=FNr29e9hOoT4VcZZRWrrkGXNb4FtXH1EL0mTazXwAJQcFsO542bCyMRmuSfj/qqAuXqs7yAVA
	ZdSA459EojSMail2td9th97xrqNsypmnTd6BAWBTU8DbQLlVOZjAn1UaY2oJ8CTuSOhFSntY2O9
	9Delkr6pZkElyp9inOuAYEo=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cR1c04B1KzYl4ZT;
	Tue, 16 Sep 2025 20:36:32 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 20:36:52 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 20:36:51 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Tue, 16 Sep 2025 20:36:51 +0800
Message-ID: <20250916123651.257804-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1f80bc3f-845f-49f4-93d7-cc1be8a781f5@kernel.org>
References: <1f80bc3f-845f-49f4-93d7-cc1be8a781f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

>On 9/15/25 11:52, wangzijie wrote:
>> When we get wrong extent info data, and look up extent_node in rb tree,
>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>> return NULL.
>> 
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> ---
>>  fs/f2fs/extent_cache.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 199c1e7a8..6ed6f3d1d 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>  			leftmost = false;
>>  		} else {
>
>Need to print some messages here as Jaegeuk suggested, IIUC.
>
>Thanks,

OK, I will update it in next version.

>>  			f2fs_bug_on(sbi, 1);
>> +			return NULL;
>>  		}
>>  	}
>>  

