Return-Path: <linux-kernel+bounces-862225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5271BF4B72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753F8400800
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB0269D17;
	Tue, 21 Oct 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZD9xYHe"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235702673B0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028605; cv=none; b=jblieMvSBuzMq0cb2ad3DArLJ4CKJewH/0qkEYyeTBaOGHQfCksLBqh1c1HcI+uSHuV3bX3uGQ723M2YkXZzWbMOAPOea4svjLxJ2Y2iR0xgfN+oHs0bC7uqLIuL87I1BAerJGP4rJjVF3nV1BRoquVeKtO20dpAMMHLdsyMU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028605; c=relaxed/simple;
	bh=09ammgPTGOYPV4N0HtDlqzFG5Kp4YxoPIsUdniunFtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8B+yRe5m42AYqcW9AJJMfevKw1Hy4yUgZ4TT3x+B8DR0qpclSCBzU4f8SaTIPGI7O36zLee+0NeHLoAt282DmpLJn63qBLsfigDBPHMEjL3ok2SrHUb9TgbOGqXYNQQ2l/+DcQfFIUE83/nerIdYKAzDLdRnIGT+x468Xf8ccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZD9xYHe; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c1d15a0-4030-4929-bda4-4006696bd96b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761028599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JehDfC8TDuzdoor+Tx1iNgu123iWqGj+gYZMDk+5vI=;
	b=IZD9xYHefLrqwkrqIFyLWlLPUbEWBQg2DPatM1iIvovpCoDKXfkmT9uWCBDyiY7OzJGwae
	5itExXZ7HlbnLEBHO1SuR69mzKxP6KXm7G+lLW8Lwup0ul186xQ0FkJroBRqfid+5GE+x6
	IfkB+RJlI7h5bQBt8FULvD2ESeQktuA=
Date: Tue, 21 Oct 2025 14:36:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 15/22] smb: move FILE_SYSTEM_ATTRIBUTE_INFO to
 common/cifspdu.h
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stfrench@microsoft.com, metze@samba.org, pali@kernel.org,
 smfrench@gmail.com, sfrench@samba.org, senozhatsky@chromium.org,
 tom@talpey.com, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, bharathsm@microsoft.com,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251014072856.3004683-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251014072856.3004683-5-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_xwKGST7PXu9ha5wdBF_M-qoe2g52Dp9Y3-0r+aYXa-w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd_xwKGST7PXu9ha5wdBF_M-qoe2g52Dp9Y3-0r+aYXa-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for your suggestions. I’ll send v4 soon.

-- 
Thanks,
ChenXiaoSong.

On 10/20/25 1:35 PM, Namjae Jeon wrote:
> On Tue, Oct 14, 2025 at 4:30 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> Rename "struct filesystem_attribute_info" to "FILE_SYSTEM_ATTRIBUTE_INFO",
>> then move duplicate definitions to common header file.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> Please check the warnings from checkpatch.pl.
> 
> WARNING: do not add new typedefs
> #109: FILE: fs/smb/common/cifspdu.h:352:
> +typedef struct {
> 
> WARNING: Prefer __packed over __attribute__((packed))
> #114: FILE: fs/smb/common/cifspdu.h:357:
> +} __attribute__((packed)) FILE_SYSTEM_ATTRIBUTE_INFO;
> 
>> ---
>>   fs/smb/client/cifspdu.h    | 7 -------
>>   fs/smb/common/cifspdu.h    | 8 ++++++++
>>   fs/smb/server/smb2pdu.c    | 6 +++---
>>   fs/smb/server/smb_common.h | 7 -------
>>   4 files changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
>> index 07eb821654e1..a6f7e168961e 100644
>> --- a/fs/smb/client/cifspdu.h
>> +++ b/fs/smb/client/cifspdu.h
>> @@ -1937,13 +1937,6 @@ typedef struct {
>>   /* minimum includes first three fields, and empty FS Name */
>>   #define MIN_FS_ATTR_INFO_SIZE 12
>>
>> -typedef struct {
>> -       __le32 Attributes;
>> -       __le32 MaxPathNameComponentLength;
>> -       __le32 FileSystemNameLen;
>> -       char FileSystemName[52]; /* do not have to save this - get subset? */
>> -} __attribute__((packed)) FILE_SYSTEM_ATTRIBUTE_INFO;
>> -
>>   /******************************************************************************/
>>   /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer formats */
>>   /******************************************************************************/
>> diff --git a/fs/smb/common/cifspdu.h b/fs/smb/common/cifspdu.h
>> index 1109c20f7bf8..560900617be7 100644
>> --- a/fs/smb/common/cifspdu.h
>> +++ b/fs/smb/common/cifspdu.h
>> @@ -348,4 +348,12 @@ typedef struct server_negotiate_rsp {
>>   #define FILE_CASE_PRESERVED_NAMES      0x00000002
>>   #define FILE_CASE_SENSITIVE_SEARCH     0x00000001
>>
>> +/* See FS-FSCC 2.5.1 */
>> +typedef struct {
>> +       __le32 Attributes;
>> +       __le32 MaxPathNameComponentLength;
>> +       __le32 FileSystemNameLen;
>> +       __le16 FileSystemName[]; /* do not have to save this - get subset? */
>> +} __attribute__((packed)) FILE_SYSTEM_ATTRIBUTE_INFO;
>> +
>>   #endif /* _COMMON_CIFSPDU_H */
>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
>> index a46d4ddade9e..a05b04799c0d 100644
>> --- a/fs/smb/server/smb2pdu.c
>> +++ b/fs/smb/server/smb2pdu.c
>> @@ -5485,10 +5485,10 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
>>          }
>>          case FS_ATTRIBUTE_INFORMATION:
>>          {
>> -               struct filesystem_attribute_info *info;
>> +               FILE_SYSTEM_ATTRIBUTE_INFO *info;
>>                  size_t sz;
>>
>> -               info = (struct filesystem_attribute_info *)rsp->Buffer;
>> +               info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
>>                  info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
>>                                                 FILE_PERSISTENT_ACLS |
>>                                                 FILE_UNICODE_ON_DISK |
>> @@ -5507,7 +5507,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
>>                                          "NTFS", PATH_MAX, conn->local_nls, 0);
>>                  len = len * 2;
>>                  info->FileSystemNameLen = cpu_to_le32(len);
>> -               sz = sizeof(struct filesystem_attribute_info) + len;
>> +               sz = sizeof(FILE_SYSTEM_ATTRIBUTE_INFO) + len;
>>                  rsp->OutputBufferLength = cpu_to_le32(sz);
>>                  break;
>>          }
>> diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
>> index a5dd656c36f1..016ec93e6df4 100644
>> --- a/fs/smb/server/smb_common.h
>> +++ b/fs/smb/server/smb_common.h
>> @@ -56,13 +56,6 @@
>>                  FILE_EXECUTE | FILE_DELETE_CHILD | \
>>                  FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
>>
>> -struct filesystem_attribute_info {
>> -       __le32 Attributes;
>> -       __le32 MaxPathNameComponentLength;
>> -       __le32 FileSystemNameLen;
>> -       __le16 FileSystemName[]; /* do not have to save this - get subset? */
>> -} __packed;
>> -
>>   struct filesystem_device_info {
>>          __le32 DeviceType;
>>          __le32 DeviceCharacteristics;
>> --
>> 2.43.0
>>


