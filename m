Return-Path: <linux-kernel+bounces-858241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F4BE95C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36A664E5809
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1C337100;
	Fri, 17 Oct 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWRR2Czb"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C73370EE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712979; cv=none; b=AS0s0dXxk+wgyWAUHKIKtIAOQ3eZ5e269r5FOyd1tYlcoJLulVovyAhVAaeaDEn/Y3BOnoN+2PAfUCboA10OXyxJHpkrPwAgyZoBFinkBVDgs5ZQgb9+N/dNHIj3PO39iI9wCznZxG8FjMRkdFq/HFj13NvAFxsTzGlldHMTgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712979; c=relaxed/simple;
	bh=5KdtLgRmD9xffcBvciXVRE0+6NFQ/DLhSxdEKGyb6xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EkTDUFU8LQgVqCmBQwG435I8nTqNd8GgKEHypyQZeLtyuqssoN9+1mBlR1zIVaXQHaswFvGh75OWOzqISkaSzDDOs2x0E3s3bIlAxt9HSEdwaLpeRwgtEhbeCX/Vi0xYDvEQFnO72l+0kcOoG1O+XWJLLIHpu1EBqKcZPsA8i7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWRR2Czb; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <287b5c2b-3cb2-4115-a16a-bd1ff85f5071@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760712966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqRuTsLACDDYXSd8AWirB4EvePJIoVUPqSSwBDM1YAQ=;
	b=uWRR2Czbf31+5VLMcVQ11R3g8jb1omGftHtbrALLEb4JOEeBO9ls+KDPjZ7yYXRcTk2foO
	+gCcGn2Kj8U/UYvIVtcvMwlDo8oiZySEs5B7BwamYVoKxpL10qxBNcO5EKMleGihlKMCxg
	o4bsj6+HmM26B8FDuIDknwked/b+md4=
Date: Fri, 17 Oct 2025 22:55:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/6] smb/server: fix return values of
 smb2_0_server_cmds proc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
To: sfrench@samba.org, smfrench@gmail.com, linkinjeon@kernel.org,
 linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Language: en-US
In-Reply-To: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Namjae,

v1 has typos, and I've already sent this v2.

Thanks.

On 10/17/25 6:46 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> These functions should return error code when an error occurs,
> then __process_request() will print the error messages.
> 
> v1->v2: Update patch #01 #02 due to typos.
> 
> v1: https://lore.kernel.org/all/20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev/
> 
> ChenXiaoSong (6):
>    smb/server: fix return value of smb2_read()
>    smb/server: fix return value of smb2_notify()
>    smb/server: fix return value of smb2_query_dir()
>    smb/server: fix return value of smb2_ioctl()
>    smb/server: fix return value of smb2_oplock_break()
>    smb/server: update some misguided comment of smb2_0_server_cmds proc
> 
>   fs/smb/server/smb2pdu.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 


