Return-Path: <linux-kernel+bounces-841685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D9BB7FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A58419E4AB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE21F78E6;
	Fri,  3 Oct 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcPlmJX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4D35965;
	Fri,  3 Oct 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520744; cv=none; b=d817466AHU7nW2NPXuiuqKg3rKM/ukqzDK2nQIzhS2yKBXca9yo9DXOLVqEaxUUtzLhZ2l7QyIRoQtQs10gikHWFSor2liu1NZsz3+BdbD9Ad5RhZgJ/WG9KLVjzlX6gOL/Y8H4AvqW8Fwfr8Tp95UWmsOpf/d1KBRwoY7r2zIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520744; c=relaxed/simple;
	bh=QpRq4pZF3Ac0f5IRd4ZuXiSeD3Zs67hn7hh2pF7Bnbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvD4ctNmTMvXLW2E/9RlxfVRf/slChbXCL0X8fw8KWurMEBF7gXuC0IaETACVkZ3SbNYgswto7F3IjF+pWiz0JWiXeVse3LdGECl0saswYw5kyoOPYjwWbX5yLdYvmQQhwy7wKzSnG4eqe+X9GlKf4mTQiEGBPDnS2ajj8rUGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcPlmJX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16BBC4CEF5;
	Fri,  3 Oct 2025 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759520743;
	bh=QpRq4pZF3Ac0f5IRd4ZuXiSeD3Zs67hn7hh2pF7Bnbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WcPlmJX8ZTIndb1Uc6CLSkNPL8Ki5yFptQjQ7QJT5yoCaZzBeCJ1XJPx38fFScxnO
	 i9QdBjbOwxPRRSWJ7jxJhc6zTPr7fSpxbpt21yxkkkrLfjZqlDISTYHf+LJ+644S05
	 Es/13ibZCzJ6YiETgfN3zUZ6Bo7Uy5vMDwQfwCbUOQbh+3LD8yul4tc40XOYACdIfW
	 86zDJruw/KK5MIfF8c+vJTSusA8Oe7fCcNHZUtU5qwOi81PDTw9gChQqyqNIXTMMa7
	 pG567zztNH9kzXjds6fcO8LBdKmETl8wV3/rWnxxLyIJYrbnYSHkCkMtEp2G4x/0cg
	 cRWSR6w+89GUQ==
Message-ID: <36720829-6ba3-4178-952c-4236622edfa2@kernel.org>
Date: Fri, 3 Oct 2025 14:45:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
To: Hans de Goede <hansg@kernel.org>, Denis Benato
 <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org,
 "Luke D. Jones" <luke@ljones.dev>
Cc: platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
 <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <46762a7e-e8cb-45fb-8d62-062915133463@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 1:58 PM, Hans de Goede wrote:
> Hi,
> 
> On 3-Oct-25 8:49 PM, Denis Benato wrote:
>> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
>> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>> Link: https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> 
> Regards,
> 
> Hans

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Luke,

You are planning to step down from maintainer too, right?  Can you send 
a last patch doing that too?  Or let Denis send one and Ack that?

> 
> 
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 156fa8eefa69..81bcb934748d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3841,6 +3841,7 @@ F:	drivers/hwmon/asus-ec-sensors.c
>>   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>   M:	Corentin Chary <corentin.chary@gmail.com>
>>   M:	Luke D. Jones <luke@ljones.dev>
>> +M:	Denis Benato <benato.denis96@gmail.com>
>>   L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>>   W:	https://asus-linux.org/
> 
> 


