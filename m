Return-Path: <linux-kernel+bounces-864198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619ECBFA263
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7373B6EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E3228726E;
	Wed, 22 Oct 2025 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDNe0z/J"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683021B9C1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112938; cv=none; b=PpxSe/qKhaPAmHvGVUcpxCB4WoY4pJVeWFyMNL6mJbrxu3Fg4SO0q0bgNHk/JjnzT7TmTg3IUKVsq++YzqlKPYMJJ1GhjWXqNUDjb4DARuVpig9Q8GzuKPW4tUzP4xuZR2dWcgdy2dv+Y1gT+S4WgrvFKSCXEEnUrYq2YbwHPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112938; c=relaxed/simple;
	bh=l6MO0BJTfgJDmNRJ2K6Lf4PkNVLCQ1cTMHmCI7yT0Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEr8w/MugmtQBp4veaxM7KDSC8dFK1sTDx3Tpgji/to+dX/Ex5NHFX+GFGZJghB1Kno+fO/Fjm4Lk5FvM0TMxt9a+eiIGbRFUkbjzH+RlW29rTIlEVt8Lz8V6nSbhBnv3WNCYuds6Sq7WSUX7QCyY3u3ELIkCfSygcQCWeHidZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDNe0z/J; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54e95e16-1e46-4e6b-87aa-a685ef3075e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761112935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzDGVcKweDncMNqL1iDjoY2+3MKreIN7O3zHk5EZ6IE=;
	b=vDNe0z/JSLO/hD2fzw7IUyWi5J37QIUR+l2uUv3ma8+V95UnPpG2dNs+Rd+1ikETvWA2bB
	/YQMRrpNrco4b0r9H2V+dPWPoyo7fcyvNWHLcJdH8/7OuaZvSou43oHLZugGUDdq0IQCEL
	SKm+vXFUY/GaFYGuN9PaubVrljVD8bQ=
Date: Wed, 22 Oct 2025 14:01:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 12/22] smb: move some duplicate definitions to
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
 <20251014072856.3004683-2-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd8j6LjAvzBvKh9N3nvtqacLwLQ24sHKHu2Wh3vT1NtBYg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd8j6LjAvzBvKh9N3nvtqacLwLQ24sHKHu2Wh3vT1NtBYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Namjae and Steve,

Would it be more appropriate to move these to common/cifsglob.h?

On 10/20/25 1:22 PM, Namjae Jeon wrote:
>>   #define CIFS_PROT   0
>>   #define POSIX_PROT  (CIFS_PROT+1)
>> -#define BAD_PROT 0xFFFF
> Moving just this one doesn't look good.
> Thanks.

-- 
Thanks,
ChenXiaoSong.


