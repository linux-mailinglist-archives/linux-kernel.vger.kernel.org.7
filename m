Return-Path: <linux-kernel+bounces-853626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0649BDC25B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DD53A727D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD83090FD;
	Wed, 15 Oct 2025 02:25:30 +0000 (UTC)
Received: from mail.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF8224B1F;
	Wed, 15 Oct 2025 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495129; cv=none; b=WHTCVe5yDjj+d6ovO/s5ua6Tic0Qpr0kC/y8HGh0PepdhdkG01komPQD6cB726Qb/6W/FV4Zxn1ntg4kDByF3B554bRi3k9xTwm3L3dJAO/kguswNRfEyxhvAx9ZSp8DZBKsIHWHdiqTCxRyqk6wLde27+kP7tH7dWJo0adXgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495129; c=relaxed/simple;
	bh=4N702iAdv7cIlHSjgx/LniNVYXC82B32lyLJT6SIXnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NVxoj3gsQLnFDvvxUdwREJOmEn2nrClBgmo8usm0D6xogTbLQBVvTTzzoeBsZFsC1huBg/0gcCZMNswvvU9uKCuXk0RuVJAZqu1MtZHRiemXNZGK2G4SVAdNfY0kgMZG9mkKbLh9mHhdkrmBFrxs8ZA6ccgXapgrpP+4t7HYsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Received: from vmMailSRV.fintek.com.tw ([192.168.1.1])
	by mail.fintek.com.tw with ESMTP id 59F2OuB5076593;
	Wed, 15 Oct 2025 10:24:56 +0800 (+08)
	(envelope-from peter_hong@fintek.com.tw)
Received: from [192.168.1.132] (192.168.1.132) by vmMailSRV.fintek.com.tw
 (192.168.1.1) with Microsoft SMTP Server id 14.3.498.0; Wed, 15 Oct 2025
 10:24:55 +0800
Message-ID: <8af5eb5f-0adb-4ea5-a4d5-554a7e883570@fintek.com.tw>
Date: Wed, 15 Oct 2025 10:24:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/1] USB: serial: f81232: fix incomplete serial port
 generation
To: Johan Hovold <johan@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tom_tsai@fintek.com.tw>,
        <yu_chen@fintek.com.tw>, <hpeter+linux_kernel@gmail.com>
References: <20251008023858.227740-1-peter_hong@fintek.com.tw>
 <aO5uAUknTLOWdvUY@hovoldconsulting.com>
Content-Language: en-US
From: Peter Hong <peter_hong@fintek.com.tw>
In-Reply-To: <aO5uAUknTLOWdvUY@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-12.5.0.2055-9.0.1002-27556.001
X-TM-AS-Result: No-9.738500-8.000000-10
X-TMASE-MatchedRID: zGP2F0O7j/unQM/ZDsbOZvHkpkyUphL9pPMmjQJmXyFKmuk8ocl7z7e/
	RFw+ZyQEju4W7SRKMeJIUUJ3l9gynuhM+rnwXt6cPPov5T+l6PGUO3k9AyCPTe8n6d5wLKiXGYT
	YuTvYrD7A+OjLG1jwgBWxTjMgqZh1iAzEt7NPEk4IoUOTWQl7EjFcf92WG8u/23s+ayc5uyBFmB
	b8AoJ5yj7W3Cw3ke/jmyiLZetSf8kir3kOMJmHTF1j5mhaIsibwrbXMGDYqV/5N/S1zEq4ui+I+
	AbM3aL70ri+PRVb+Sx0vmnbTp+hk2muODPbmego
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.738500-8.000000
X-TMASE-Version: SMEX-12.5.0.2055-9.0.1002-27556.001
X-TM-SNTS-SMTP:
 F4F3A7118C42B8EBCC9426BABBE10E9D6A2AE2222EAAB7E12D822586B5FF47E62000:8
X-DKIM-Results: [192.168.1.1]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail.fintek.com.tw 59F2OuB5076593

Hi Johan,

Johan Hovold 於 2025/10/14 下午 11:36 寫道:
> On Wed, Oct 08, 2025 at 10:38:58AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> The Fintek F81532A/534A/535/536 family relies on the
>> F81534A_CTRL_CMD_ENABLE_PORT (116h) register during initialization to
>> both determine serial port status and control port creation. If the
>> driver experiences fast load/unload cycles, the device state may becomes
>> unstable, resulting in the incomplete generation of serial ports.
> Do I understand correctly that you're only seeing this issue if you're
> unloading and reloading the module (or rebinding the driver through
> sysfs)?

Yes, this issue has only been observed and reported during module unload
and reload operations currently.

>> Performing a dummy read operation on the register prior to the initial
>> write command resolves the issue. This clears the device's stale internal
>> state. Subsequent write operations will correctly generate all serial
>> ports.
> Does this mean that the retry loop is no longer needed? Can it now be
> removed in either or both accessor functions perhaps?

OK, we'll test the loop removal in the accessor. If successful, we'll prepare
and send V2.


Thanks,



