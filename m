Return-Path: <linux-kernel+bounces-763817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16EB21A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4815A7AC198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB772DE6E3;
	Tue, 12 Aug 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UcIVNugy"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E928152A;
	Tue, 12 Aug 2025 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964693; cv=none; b=fN2dRZz0LSITwh9e+e0LKNB/pthgw/lsf6Vce0o9H+Woap9NcVBrXYURE+9IeyN28h961fm5jRWisTLjWo0E7X4R271AyTo9FEAoTqDwOBhR/ZMY7UE7MsWJOJ7zPXsog2n8gT1F39i9DLgiNDleRIVS2KlkNuuHVxPxDuTRdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964693; c=relaxed/simple;
	bh=IBRHhpY/z0qyZ7Z+agm/NTnXbn4mdhK0ATRZmTFbvN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrh9Te5hxJz/qrc6AH7MehPYJMkbO8giqXtYke6I22UZJI0Ceci0cQ48xRggLlEwzD79H646EAWRu7Q++TN5gvK7IDuXjpTenwZC9fPoL1fxukBnVUuNTEgwhayRxfOpIfIbXAj7HOMcyfBDwfXLUabPlL+uxddr0GC5AowNcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UcIVNugy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=iydQSy/gRoXca8M16f40kf1xXjFFM56KYb4MzSF+79o=;
	b=UcIVNugyiTmmnPlRZp0z8PVfxSAsHmGrj1D1BzO6m8039bOSyjTKMI/iKDhMYd
	eiDDUvdD/SMUUCdZXLyg6IwoDvbniXpSXhRZtxeP8+1SQSddGcb5ynEFN2nYGgFf
	6g2ei0xh46O3c/J5MRXakQoVzxMKospXuHsbmBEBYYJfw=
Received: from [127.0.0.1] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXH3bJoppoT9Z7BQ--.47419S2;
	Tue, 12 Aug 2025 10:11:22 +0800 (CST)
Message-ID: <461ae944-5fb9-4860-81c1-1ac48c3d888f@163.com>
Date: Tue, 12 Aug 2025 10:11:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
To: Markus Elfring <Markus.Elfring@web.de>, Scott Guo
 <scottzhguo@tencent.com>, Phillip Lougher <phillip@squashfs.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20250811061921.3807353-1-scott_gzh@163.com>
 <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
From: Scott Guo <scott_gzh@163.com>
In-Reply-To: <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH3bJoppoT9Z7BQ--.47419S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF17Wr48ury7KFy8tFy8Grg_yoWxKwcEvF
	93KrWkX3s7JryfZF45Cw4DtFZxWr4xXry5ZF1Fqw4S9390vwn8Grs8uF1DAw1rXFWrCFn5
	Crn0v3s2v347ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn92-UUUUUU==
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/1tbiOhGnnWianal14gABsB

Hi Markus,

在 2025/8/11 15:02, Markus Elfring 写道:
>> If sb_min_blocksize returns 0, -EINVAL was returned without freeing
>> sb->s_fs_info, causing mem leak.
> 
>                           memory?
> 
> 
> How do you think about to append parentheses to the function name (in the summary phrase)?
Sure, will do that in V2.>
> 
>> Fix it by goto failed_mount.
> 
> By the way:
> I propose to refine the goto chain by using additional labels like “e_inval” and “e_nomem”
> so that another bit of exception handling code can be shared at the end
> of this function implementation.
> https://elixir.bootlin.com/linux/v6.16/source/fs/squashfs/super.c#L434-L466
Will have a look into that, but maybe fix the current issue first.>
> Regards,
> Markus


