Return-Path: <linux-kernel+bounces-848267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E019ABCD111
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B90734D26D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60752EF651;
	Fri, 10 Oct 2025 13:13:33 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDC3594A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102013; cv=none; b=h5fIIDMBQP999rbltW0l6KJQtqcXJMJ/26M9CeRdZ3sZdk37HmcZcmNXkHnqcQW1f5vAh1bHTK3P1BuYMGhJGOydrA/aUTCf6VVhHtX8UISuexj9agfCX2dBIu7qu7D6Q/5i8tdpZuqkjNa3KJ6TieH4XyA0q+glPhBJhxuULrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102013; c=relaxed/simple;
	bh=2nEOD+5PfY8a3pV8dWjkubyvytfepFoxPqi7Eh8twUA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V9+zGTqLgUNG24TGUP2d2yVwwCn03z0T8VBSBWpWjEtY7m8zDXzDghYmQGKf7Eo/byUz2xtpEXgGbqZAZQsp9fqjwb7FHL6YlxKlEJfa0suozXNdPj84B6rpc7NYJP2qXZ8SorgQKAHZ4R69ON5nmtRXsbVPjsE65opE5q6jMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC6066028F35A;
	Fri, 10 Oct 2025 15:12:50 +0200 (CEST)
Message-ID: <e02b3b8b-78a3-41c7-864e-caba6f1a8c0b@molgen.mpg.de>
Date: Fri, 10 Oct 2025 15:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff: firmware
 crashed!
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 jamie@stimulussoft.com
References: <5aa2dae4-94ba-45cb-b138-bb40c89a85eb@molgen.mpg.de>
 <486e9f27-3b03-4317-a1fc-1bd92235db1c@molgen.mpg.de>
 <90a764d0-c230-43bb-b7e5-189544839f8d@quicinc.com>
 <e2e58098-4589-4ae4-bc38-6b009823b071@molgen.mpg.de>
 <82b9e966-5e12-4a13-98d4-0ffa88505f97@molgen.mpg.de>
 <d8145c41-1e61-454f-a343-be0a7239e36e@molgen.mpg.de>
 <8354f613-692e-4f6b-933c-3434a5ae90b2@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8354f613-692e-4f6b-933c-3434a5ae90b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Baochen,


Am 21.07.25 um 05:21 schrieb Baochen Qiang:

> On 7/20/2025 4:43 PM, Paul Menzel wrote:

>> Am 14.05.25 um 10:08 schrieb Paul Menzel:

[…]

>>> Were you or the firmware team able to pinpoint the problem, and
>>> come up with a fix? Is there any logging I can enable to help
>>> with debugging?
>> 
>> It also happens with a Telekom Speedport Smart 3 (Arcadyan
>> Corporation) router. The firmware crashed five more times since
>> June. A reliable Wi-Fi connection would be really appreciated.
>> Could you send me a debug firmware, so the firmware developers
>> have it easier to fix it?
> 
> Paul, we are working on getting legal approval on collecting
> necessary information, such as firmware dump etc, from community.
> Once done we will share guides to collect them to debug further.

I just wanted to know, if there was a conclusion yet.


Kind regards,

Paul


PS: I set debug_mask to 0xffffffff a while back, and it logged so much, 
that my old boot logs are gone from the systemd journal now. ;-)

     echo 0xffffffff | sudo tee 
/sys/module/ath10k_core/parameters/debug_mask

Any hint on what to set, when the crashes happen?

