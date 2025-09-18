Return-Path: <linux-kernel+bounces-764990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23EB229E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257821BC4381
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186A289807;
	Tue, 12 Aug 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WOFmavdt"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480A289802
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006889; cv=none; b=MfL0qZE4y9r4P90CpWsaXBQPfpUgSaDFQcMgeBCqift3swZ8WbPkF20yu7vM/YYnR82xJgFJ4wBbI0a40/ukv1EwrHCyOrtKBHMvHXfyTgxxakbq/0gl5Skq3WnRkWGR1+KbyIvdKcA7yZ6q6ZTEJ/yayy+rXg5u4HBT0I4fsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006889; c=relaxed/simple;
	bh=upbKxsQx0QpZRud8WIcDD5N4XVxgeeYJQFgMmyBLI/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXChsa6FSl6PseCQ+kk8Udua6CrHwPgkK/JLhE/vUl3N/VzIuPljWisqqwTSRRlUm8cQdBPHtkedXr3Zax0g4yahkzghwylZhJYILrr2fWDevBlrTspyc0HokGwQvP4gjGsyIxuBZpCBjDcHBnLSxWjDSUo8MI6x7L2MK7OAue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WOFmavdt; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id lnXXuS7iWuKaFlpR9ubL3X; Tue, 12 Aug 2025 13:53:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lpR8uGEzhCNkwlpR8uVAjf; Tue, 12 Aug 2025 13:53:11 +0000
X-Authority-Analysis: v=2.4 cv=QO1oRhLL c=1 sm=1 tr=0 ts=689b4747
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=R1XpmoYe2GHAZdAE2O7VqQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10
 a=5Dkndmrd0K96-EDDFPkA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tNUEls5kqSuuy6g4SOW4SUaFj+tL30sjkLiY9FumhRY=; b=WOFmavdthVNtCV3zeQ97C9GGXl
	oTXUDOOCNTA4k1JANH17X36iWvSj+tla4eykDGakfzmwZ7eQctmnCJctpzQNesABWAo3DF7WnrJux
	olQ6x3wMEOOBK05H5vpfpphZG0W5bd7M8fk0LlxhBxwaWLF/brFtPZnQ2vUjb4/GkUke5B/7AD9PI
	6DFHMer5dWSPqaYdQ/7BytIBN0zmUfAH4ASFA6v2ojH6iYMArgTnDmxeeD4yQcntAI2dqedrvyAkb
	Luk3JVGaVHG/z1joq28CaQPNmZdve5nd2C3fviiNNARxB0quvd3rOKE9bCWgkFxVNZhflmoIkRCZV
	NJuHUdfw==;
Received: from oni-27.109.98-104.oninet.ne.jp ([27.109.98.104]:57416 helo=[192.168.0.175])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ulpR7-00000002cDc-3zrY;
	Tue, 12 Aug 2025 08:53:10 -0500
Message-ID: <c7ffab41-97ed-49d8-966c-ac83d52266bf@embeddedor.com>
Date: Tue, 12 Aug 2025 22:52:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] scsi: qla2xxx: Fix memcpy field-spanning write
 issue
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chris Leech <cleech@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 Nilesh Javali <njavali@marvell.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aIqivJeq8kxRUX0N@kspp> <yq1y0s5gicq.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <yq1y0s5gicq.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 27.109.98.104
X-Source-L: No
X-Exim-ID: 1ulpR7-00000002cDc-3zrY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: oni-27.109.98-104.oninet.ne.jp ([192.168.0.175]) [27.109.98.104]:57416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHm3bE3IRumezWyLr2H8nIMu5W9EqL/dKIT/LbXxPDDJ0E+RQ/ubo5BqG8GHTk6/M/gG8GjVvct0so2Ga866Lso8DWXzE/oWG3Nppt1tyRfUZvCn8tmn
 gHekZyqMhhJ5DhCey7Xoukb1QihxmdICaaqHpV2hbNY1yuF7b/XP5XQwt1eAPkhDIxhECaYHQQBO/aQahEnK/SQMlSCx1qFu5PqXi0cmK+wUFugJdo0DVmHu

Hi Martin,

On 31/07/25 12:17, Martin K. Petersen wrote:
> 
> Gustavo,
> 
>> +
>> +	/* Must be last --ends in a flexible-array member. */
>> +	TRAILING_OVERLAP(struct purex_item, default_item, iocb,
>> +		uint8_t __default_item_iocb[QLA_DEFAULT_PAYLOAD_SIZE];
>> +	);
>>   } scsi_qla_host_t;
> 
> Looks OK to me but will have to wait for TRAILING_OVERLAP() to land.
> 

The helper is already out in -rc1. :)

Thanks!
-Gustavo

