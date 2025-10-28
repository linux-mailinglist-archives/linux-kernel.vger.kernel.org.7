Return-Path: <linux-kernel+bounces-873006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4219C12D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E3C460792
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087227A461;
	Tue, 28 Oct 2025 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U3b+S8O6"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631328726D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623893; cv=none; b=hpXCmoly02dv95VekISABqmECFjmbpU2F4LVripQeeHe1UOt07GuptB2lQl9fw22YAJ2rLIdYUuKVCKa1G+HeWaMv7LLhvBEO7X2qj9uE93TzxiWk574KmiFf6Q8lBTW0qzMqoj0Zl4bB9NpBpc7p9P1XTyCI+X8beTdhV5C8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623893; c=relaxed/simple;
	bh=VP4T6rUdU/ddECsl/aZycZiR5lezQ2/cHMQj9C56QzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLpUbLerLDJ38TgAFLogL7m/i/FrqLbZyeND8wXYArVCpNhSfC5jpQS6qp5/9VZJwKbIji4qYmSyPHMrVx3DBlRMySHzaG6kyyEvTtEY6ob1rOGHCWpu6BWQ/V4cAcG/MQKdREhiCild/w7EIQ/H4t2FeuiG7pvdLUJSu5DY7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U3b+S8O6; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75086bc6-9747-4a10-b4ee-ebf9ffdf25ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761623889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZL1/VUO7eAG2V742XYwsgahCIY/duuttonLMJA+0L8=;
	b=U3b+S8O6KyRSZCsC9CN8qtEDQE5VagMVloKv9HsoIwk1rLt1+o3rdywLZ/eQnga+u3yGov
	uX/h3+YwSnx9RKdDpnymXZLp9kXxixifYR5F1MxgdxRiKEptSXUjQdCPyOJVtxmC3v6cne
	+j1vMNP+a1M7oBWayBqq/aSmiGSISgo=
Date: Tue, 28 Oct 2025 11:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 05/24] smb: move some duplicate definitions to
 common/smb1pdu.h
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027071316.3468472-6-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_u5+p5hjvQey+TM8w4+P7aN7zSfwDbrUKRtbwx4vtyDw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd_u5+p5hjvQey+TM8w4+P7aN7zSfwDbrUKRtbwx4vtyDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Would it be harder to maintain if only part of the definitions are moved?

Moving the related definitions together would make maintenance easier, 
that's just my personal opinion.

On 10/28/25 11:42 AM, Namjae Jeon wrote:
> On Mon, Oct 27, 2025 at 4:15 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> In order to maintain the code more easily, move duplicate definitions to
>> new common header file.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> ksmbd does not use all smb1 pdus. Instead of moving all smb1 definitions,
> move the ones ksmbd uses to smb1pdu.h.
> Thanks.

-- 
Thanks,
ChenXiaoSong.


