Return-Path: <linux-kernel+bounces-841264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D64BB6AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04BBF34552A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EF2EDD64;
	Fri,  3 Oct 2025 12:33:02 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D52EE27C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494782; cv=none; b=cCp3D+MEbSDJgER37eWb0ukrW7lnSiUYZusRjHDO+Xy9psXrSSIyoAGmoUJ85Njtn6FGiCnOagVwx70rnnvsy1FvsKrVZO8LlduxDUpe02pR7wN/sDKsT16DUqEA3m2Aawz8VK5qT4dfKhlOUDJE4Xdd7s5eMFRrYybpHediadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494782; c=relaxed/simple;
	bh=Pj+a+ReEToqtYcpBwWNSy7UhdrI5ZzjkBVlESP7uTvg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=AkeqXMm8v1Tr6c51NfkLWx6z6UUHcNaRhcMLHt1pO6qm2PTtn2+KJkaVeIFz2S7SvwuxrCU1YpGlg68QHOC8S5xVqwiygmgqD3GKj6ByBW6YvzLs9m/RPGuksy0exQaK2dNDXVjVuqx7WGuIoYQ9G1DVh3EBX/FTNbb4sVoV5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.178.32] ([94.139.31.111]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MHWvH-1v8px23amP-000XCu for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025
 14:32:57 +0200
Message-ID: <7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com>
Date: Fri, 3 Oct 2025 14:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Issue in Kernel docs / Admin Guide / SysRq
To: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-GB
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
Disposition-Notification-To: =?UTF-8?Q?Anselm_Sch=C3=BCler?=
 <mail@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:he5RGe28pcGxFSRgc5rFHSwLCFiG/+T1ZLoHCl7XGRh78zOUeaP
 bEFLTR0ECewShDDOLwjQ8jrs7X8BtqdlGY9FZA6r3SqLaYUDMYOHnqWB1EVIHhtp5UsNJPl
 W00heRffRIf8J28aPoqKX0X93/eXXBL9CZXzDH6Z5RH731landTfL9Fv8p5Lox73xra2C2B
 RmzjBBO21gfYlBtigMt3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kkEM7p52eKg=;BkoSGgGLt3eFDVqDTy0W6g0uENS
 MvfBcl933GhO61j5UeijSVnY5+DuTMARLNDUK5WkySYXPsqwtBUTFQj4IYhzA3QQ6t+AUKroB
 4D2UrvUr2Ibbt6qdLKpkmZwyUcl4LaNGDw/p/jcMFxm65owe6L0/oh4gG3AtQWL1uN5AbH5si
 y+6XyLAXm90lqRvL6ZU3sItfLB4gA4K07XT+HxG3uejUn/1eBT3N2mZofWas+kiipVCwJ9cOe
 a8N1rDcqyszMHTLSMAokNq+CkRNMVQ6l6unVY6dkIv4ygx8f1EQKydfZDFCWMBY/hYeH53X3i
 1WccgrdPHgHTUxD5Ehk0jnPIMy2j7rrrHfhIlyumZcRvme/PBgy1Cpv2ZYxYEdr3SsLROaM6o
 i+6JptrXCFUNJvhYsIxxO1nNCayD2wXNpA+ajaCaGUlmcwDdxdF4IiDsoqohB9QzaU6fnJQWL
 u1vg2LuUZgzGFAQLNm4RhKxI8HltJip1J0bojutKbiIemi11qWrYBLkZpmMXT2DNrK+9JiO3W
 qWPDI9KQE+nEKL3k65OLogFulP4JTQEVQOxP+xLo2K+Ub0X2nwIoH14w1QDKEcX/IhQMDeOBK
 njpxvhgro0iZo6kO8PcHLqIBBRJeIuNW3Z775p0Kgiwx1f/HLYf3VV8dhmpuNQhfBoXa82/vN
 1cWYZ6uxNCupcUPv0JsnQs7Gy5pDkqzTD2mO/+ln2+1smdvsPdALmR9alVWuZEDIYWWYXkoDy
 SAjAbDtXdA3Sen+OQNX9u3d1GctvCEUxySRKDk25Myf6m605LQPP9EWXjeXGhYgyNPTXEdlbl
 g0a319O0xDnZ8bhkpLLpth//PWWhOYhhA62RiyX8xU/lxTgfx6GJai3qeaKwBh8+UOo27J4mi
 5QmIWzHU3L4RkET/aXoH9sWzp4R++4z3XMvh6YV6Std4Q1jemu6z46RVP4vUWpKIjqeL6C/HP
 c5myhzPAdrNhelYZU9z7+M5KSZ3lPzoahL/mATphu6UXggerIwG7kTRQQyDEjQ6qqxrenLGVT
 xMrH+R4p7N3hsXeJnEu+HYj2r29zJ34n1A+MlfWLN2YyBKKzh7PAarkqeayj3O4EmPsVmwL5G
 Vad8claL8LOhbPKJhuM1pZbpJkY8CGKGTC0kLBr89bZ0tgnljjQOatqbSwhmzCQaDRk3PQtX4
 ib45y0OpSgYguLut46PwgIhnzSM/JMgHzBZ8wyb4aLedn4SX45jLKjnEZxHmyF5QZizNyMdIf
 i0G/d5aHItsMvu8lOUzYpWRWuG+1WAAOPkUknmw+pM4a4a9zGWHanW3RVW9tGN75DPTbhqLUu
 eTpXK5wLD4zLiokGXTMc+LA0t8R51xyafA9DhVzuiQmq8NFGDBFBMbOutZGOcdf6UFOGyxKqE
 t3YtLl1aoSONNLN8CfcjvgfjJq1rfyK9ndL8fqvdR07P088tv/6e2wKrz3KU5aPVblKgNkIgJ
 5igTJ8Z74KYy9Vkk86Y8Vn2+jo0n3fqH3a3xPLBBUVsIjCs5hAi4ez5xkdJL91fZD/UTRlvIi
 avZXKRs9/QL4HM5/B+oYGL5gy4bEr5qr9T/K7OrMtdpsGFGsP2SbdrOhRDU6szFhiyDQvy6GX
 Xkhr8SOCOEU6G6CGEspnFV8Q0jrI2mdcYDIQB3U6RuNuq/S7yFta1iy6qpxOECs3dbBI3tsnf
 l8xpsCCAAKiHUxnDdnu7Xz

I’m writing here because I don’t know where to find Kernel docs 
(https://docs.kernel.org/) sources and submit patches.

The page “Linux Magic System Request Key Hacks” 
(https://docs.kernel.org/admin-guide/sysrq.html) says this:

“Write a single character to /proc/sysrq-trigger. Only the first 
character is processed, the rest of the string is ignored. However, it 
is not recommended to write any extra characters as the behavior is 
undefined and might change in the future versions. E.g.:
     echo t > /proc/sysrq-trigger”

I interpret the command as a suggestion of how to properly use 
/proc/sysrq-trigger, and not as an example of what not to do, and I 
believe many will share this interpretation. The command as listed will 
write TWO characters to /proc/sysrq-trigger.

Either the behaviour of ignoring \n should be codified and explicitly 
supported or this section should be changed.


