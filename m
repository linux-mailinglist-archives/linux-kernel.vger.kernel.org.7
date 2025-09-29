Return-Path: <linux-kernel+bounces-836826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D220BAAAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3B2189DED8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530602561AA;
	Mon, 29 Sep 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5aopZ31";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9gMD49ud";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W5aopZ31";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9gMD49ud"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54F2236FA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759182656; cv=none; b=UoalFO32DSdMnIuPE8PeEgGCOnbn7NRgI1bvbdAPeS5ga08lcPR6OnIgLC2Yjq/jEqd5Wf0VUftvubTbpPnYTm3cKu0AXnXVyMFHQ475QQx4+VmFCPsTrbz005Wnf9phXOfYCAScPQjv2OUv9VpVnLduuZD+XWmfuiMytGpipiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759182656; c=relaxed/simple;
	bh=aNeQuTjYwgA+JwDmrzwog4+pMu474TNFlZeZbMax3kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/MGCsEG9++oSW6+A+FCGLWDkFfgHObyisdrIU89BpWKWwmzxf6Z+5bzxwVrNftFD6pqw7ogmet7sUjHnfVyuxJLk5HWGKuHC+XduTkzp/yJIcvHHEh5pdRwQdu7osUwUTioTDRCAa3oAaxMJFYNDrxNqUtFkrA7Hj6UsRyTWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5aopZ31; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9gMD49ud; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W5aopZ31; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9gMD49ud; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 545B01F7A5;
	Mon, 29 Sep 2025 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759182643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeQuTjYwgA+JwDmrzwog4+pMu474TNFlZeZbMax3kI=;
	b=W5aopZ31Vxl06oaVewEIZMeTcwaVGF2PxTgTtrVqIOwsmyvJ/jpmWnin69/dUIMDZOvz8l
	jnEvulkZyZKhqmvOzKeOaBjSAZbYoQeEr96Mqke6P+zFWAZn9thJ2JOHA5eHWsdw+1Ofr0
	et0TetZYxtOD1P6Msx0XT+pLJysLWBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759182643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeQuTjYwgA+JwDmrzwog4+pMu474TNFlZeZbMax3kI=;
	b=9gMD49ud+rRYM2mHiw7Ty6pJRMEDrNyIdhwyjCTMxHRbaolVB/SW5tiWWCePxPY5MeUK5U
	Y6yAfAcQYhVuMfCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W5aopZ31;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9gMD49ud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759182643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeQuTjYwgA+JwDmrzwog4+pMu474TNFlZeZbMax3kI=;
	b=W5aopZ31Vxl06oaVewEIZMeTcwaVGF2PxTgTtrVqIOwsmyvJ/jpmWnin69/dUIMDZOvz8l
	jnEvulkZyZKhqmvOzKeOaBjSAZbYoQeEr96Mqke6P+zFWAZn9thJ2JOHA5eHWsdw+1Ofr0
	et0TetZYxtOD1P6Msx0XT+pLJysLWBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759182643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNeQuTjYwgA+JwDmrzwog4+pMu474TNFlZeZbMax3kI=;
	b=9gMD49ud+rRYM2mHiw7Ty6pJRMEDrNyIdhwyjCTMxHRbaolVB/SW5tiWWCePxPY5MeUK5U
	Y6yAfAcQYhVuMfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF3813A21;
	Mon, 29 Sep 2025 21:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GUGQFDL/2miRMQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 29 Sep 2025 21:50:42 +0000
Message-ID: <a5bc2227-5d25-41da-9b5b-ebc2d5fc85c8@suse.de>
Date: Tue, 30 Sep 2025 00:50:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hwmon: adc: rp1: Add Raspberry Pi's RP1 ADC driver
To: Guenter Roeck <linux@roeck-us.net>, Stefan Wahren <wahrenst@gmx.net>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250925000416.2408457-1-svarbanov@suse.de>
 <20250925000416.2408457-3-svarbanov@suse.de>
 <d07158fc-678e-4ae4-8943-168146a58fe0@roeck-us.net>
 <e53865df-7566-4790-9214-0af875950742@gmx.net>
 <3f1295b0-b637-4fe0-b141-67f086960072@roeck-us.net>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <3f1295b0-b637-4fe0-b141-67f086960072@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 545B01F7A5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[roeck-us.net,gmx.net];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.net];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Hi,

On 9/25/25 5:34 PM, Guenter Roeck wrote:
> On Thu, Sep 25, 2025 at 07:26:10AM +0200, Stefan Wahren wrote:
>> Hi Guenter,
>>
>> Am 25.09.25 um 04:42 schrieb Guenter Roeck:
>>> On Thu, Sep 25, 2025 at 03:04:14AM +0300, Stanimir Varbanov wrote:
>>>> A five-input successive-approximation analogue-to-digital converter
>>>> with 12-bit (effective number of 9.5 bits) resolution at 500kSPS.
>>>> The ADC has four external inputs and one internal temperature sensor.
>>>>
>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>>>> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
>>>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>>> I just realized that there is already a hwmon driver for
>>> Rasperri Pi - drivers/hwmon/raspberrypi-hwmon.c.
>>>
>>> Please add this code to that driver.
>> could you please explain the reason for this?
>>
>> Yes, both drivers are for Raspberry Pi boards, but they don't share any code
>> base. The raspberrypi-hwmon uses a mailbox interfaces to get the sensor data
>> and works for the board generation 1 - 4. This driver works completely
>> differently ( MMIO ), doesn't depend on the mailbox interface and applies
>> only for board generation 5. Actually I don't see a benefit of merging them.

Thank you Stefan for the explanation.

>>
> Ok. Please make sure to add this explanation to the patch description.

Sure, I will extend the description in next version.

~Stan

