Return-Path: <linux-kernel+bounces-875108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1188C183A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54893B17B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B922F5463;
	Wed, 29 Oct 2025 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCJukJFH"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A053170A11
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711515; cv=none; b=MShoWUHKXCytJUq4s8he9ug9xqAHPhIfRU6j93Jj7gozaZ40dd1WUc6QbuOAYMl9DyYKzkts0EsJCh5J2mudrJ1wBHHUzGQTD6hm8ScixVml+ZJbJ6YjYjyHLup9JPCpkktLqGFBiit0IOZ4lQnXrURA1FNn/yZG6mnbR1Xjeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711515; c=relaxed/simple;
	bh=4/nq1Yc/w8AgBD4s7gi7GCe6fvRjhQOp/cXFBKm2WTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9s7dvgeOgQVS+0VI4zpBjC82CpB12eSl6s0CeYdDPc7u1Nvgldkrucw0Bq98IXrzCiUh1fH0ATEfws2mJirtVYve1PrbCBBq3nPGTRII/PFvJL9HkD2HDgvjutTo8/gqFo4Dwhyh5FELdXVfpgvLKsqCe7lPny4bOQV6fpvrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCJukJFH; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df5f5874-e073-4096-946d-1fa43717015c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761711510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35RBDjl4MLy2XRbz/JLuZxA3xVHZDUvO4dVPTyfk/8w=;
	b=pCJukJFHHTcE1F+gBVo3R4aYv0goiNyImS8DYHjCXMWWvsn+QyKL/h9Zd0HIzvu74zMM06
	atsxldX3aen8JMLaamUAIQ6tvpoyim+GwgIkcUvIUo8D32nGTbm7c3i3zDTnKDwkl03UNA
	JTzdcMLLmu7EYbPz7BVh4fCZOxW8DwQ=
Date: Wed, 29 Oct 2025 12:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 19/24] smb/server: remove create_durable_reconn_req
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027072206.3468578-5-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd-KaTt1Y5gcsrWU9jrQNmyNcsmBy-XOht7L-xE=s8as7g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd-KaTt1Y5gcsrWU9jrQNmyNcsmBy-XOht7L-xE=s8as7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

They are:

   - SMB2_CREATE_DURABLE_HANDLE_REQUEST   in MS-SMB2 2.2.13.2.3
   - SMB2_CREATE_DURABLE_HANDLE_RECONNECT in MS-SMB2 2.2.13.2.4
   - SMB2_FILEID in MS-SMB2 2.2.14.1

We can uniformly name them create_durable:

struct create_durable {
         ...
         union {
                 __u8  Reserved[16]; // DurableRequest of 
SMB2_CREATE_DURABLE_HANDLE_REQUEST, A 16-byte field that MUST NOT be 
used and MUST be reserved. This value MUST be set to 0 by the client and 
ignored by the server.
                 struct {
                         __u64 PersistentFileId; // See 2.2.14.1 SMB2_FILEID
                         __u64 VolatileFileId;   // See 2.2.14.1 SMB2_FILEID
                 } Fid; // Data of SMB2_CREATE_DURABLE_HANDLE_RECONNECT, 
An SMB2_FILEID structure, as specified in section 2.2.14.1, for the open 
that is being reestablished.
         } Data;
} __packed;

Thanks,
ChenXiaoSong.

On 10/29/25 11:54 AM, Namjae Jeon wrote:
> On Mon, Oct 27, 2025 at 4:23 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> The fields in struct create_durable_reconn_req and struct create_durable
>> are exactly the same.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>> ---
>>   fs/smb/server/smb2pdu.c |  6 +++---
>>   fs/smb/server/smb2pdu.h | 12 ------------
>>   2 files changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
>> index 6b3503c7bfaa..3e8344fa163b 100644
>> --- a/fs/smb/server/smb2pdu.c
>> +++ b/fs/smb/server/smb2pdu.c
>> @@ -2766,7 +2766,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
>>                  }
>>                  case DURABLE_RECONN:
>>                  {
>> -                       struct create_durable_reconn_req *recon;
>> +                       struct create_durable *recon;
>>
>>                          if (dh_info->type == DURABLE_RECONN_V2 ||
>>                              dh_info->type == DURABLE_REQ_V2) {
>> @@ -2776,12 +2776,12 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
>>
>>                          if (le16_to_cpu(context->DataOffset) +
>>                                  le32_to_cpu(context->DataLength) <
>> -                           sizeof(struct create_durable_reconn_req)) {
>> +                           sizeof(struct create_durable)) {
> Please check the specification, Which structure name is correct?
> thanks.


