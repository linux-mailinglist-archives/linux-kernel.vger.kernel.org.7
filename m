Return-Path: <linux-kernel+bounces-858224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E901BE953C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520C54E6366
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39D336ED1;
	Fri, 17 Oct 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SUeToxhg"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8732C938
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712456; cv=none; b=L1TkvIgQg4keP1tVMJUjgAnmZXseUEllItA+oi95woMD1QD6EzJZJwMH6TSVx1fmEYO3Q6iueKoY0dthiT0n5CaTlLeoSpwVPk+uRHgbRLwj+HWwYycfGl/mXAFlwkpRiBV0WS9ew/RQXe7bzgCrWDp5oWQmoPEDNzDr/lvtA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712456; c=relaxed/simple;
	bh=L+SqctrKZRH5bxnDEQq/Te4HdgzDjNPlGDrY5UDIoIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgnMI4PIuhjG3TgYxGPDq+zjVZEndeZnDlkXdN/HOQJ9Wb2pn3uXHWC3lhOQg7Iq9Y0OhCINEza03WThgYMA5scer5SIkYhpylyZVV6lkFUPLOtF/BipCSH3SfkXcO5Lq5PDuN8oTZsDZDlk9S2c9GRlh9s+c7ZZmdpLq/fPx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SUeToxhg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87c0c457-de8f-48b5-81ce-b47481a66e11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760712438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SucrcXRDBeepHvtpSolu9QDInT7r4kkfWjyD7KxyHc8=;
	b=SUeToxhgTIFNPcJa5i3IdWlD90/TmRHLURHRdEuwwtbJdicg6WfRLvSaYqmpFvjcMsSQ32
	znDwkato1usVb/2Ykm+0UdKvPpBtyk4Yaj/A8LHwnZWy3oUtUhh4+VrTZgatqksYzxzBbb
	ULCbrDKUIOHhsecBuN4gc/1oqL1xTw8=
Date: Fri, 17 Oct 2025 22:47:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] smb/server: fix return values of smb2_0_server_cmds
 proc
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd_kq9T0bgUeX-dMD-OEu48tMDm5s+gRPPADkfOL+GH7vg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAKYAXd_kq9T0bgUeX-dMD-OEu48tMDm5s+gRPPADkfOL+GH7vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Namjae,

v1 has typos, and I've already sent v2:

https://lore.kernel.org/all/20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev/

Thanks.

On 10/17/25 10:02 PM, Namjae Jeon wrote:
> On Fri, Oct 17, 2025 at 5:47 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> These functions should return error code when an error occurs,
>> then __process_request() will print the error messages.
>>
>> ChenXiaoSong (6):
>>    smb/server: fix return value of smb2_read()
>>    smb/server: fix return value of smb2_notify()
>>    smb/server: fix return value of smb2_query_dir()
>>    smb/server: fix return value of smb2_ioctl()
>>    smb/server: fix return value of smb2_oplock_break()
>>    smb/server: update some misguided comment of smb2_0_server_cmds proc
> Applied them to #ksmbd-for-next-next.
> Thanks!
>>
>>   fs/smb/server/smb2pdu.c | 30 +++++++++++++++++-------------
>>   1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> --
>> 2.43.0
>>
> 


