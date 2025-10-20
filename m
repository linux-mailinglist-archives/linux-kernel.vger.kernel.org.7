Return-Path: <linux-kernel+bounces-860285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D9BEFBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC91C3E4EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED02E2659;
	Mon, 20 Oct 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agPN7HqP"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEA354AEA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946849; cv=none; b=FRJLYr+/YW1/E+GMEITq4hurZS+amifcarYRqYcJGgwuUipbQubetVTtnmcF7j5AONyjeVBlNgUw25wGzyDFHULqSvin+njPu/7CEB+71B4yYDnDwk7OZhxdI9Tj6B1qWsRGX2EKrIF2ZKL4W4bvvWwGdOUFn50lZREKLclsVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946849; c=relaxed/simple;
	bh=9gcsyswJoRI2xLvDA/tNbkap32wzVrEtZOWP2220J+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhclz+BH4Q6JhAcosO0MtRqy2/KWojz175SvZfoDw52PHUiWbKE9bETjnaKV22YiHSb2hbqKC79BfEbw9HXyImHkVE0GTX+lA+hnjcoarcjfUq0rMsBuJ1m+/dWo3vMR+o/XsITMNKXuQlxary9TNNu38TKbz9Fum/K7GlcrzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agPN7HqP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c290217958so247881a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760946846; x=1761551646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRhB4goZZHeAeNM4L4TzxYzSUk03jlldDvspwEzH08s=;
        b=agPN7HqPztXNkz2I0NckA1Y0pqRmSPDfDZ/JKkH0dTPjApzaVn91S2o1C5USTFrkDv
         ryxR0Z0lpH8JrHFYhyBiCfuWRkPdr93N8SP0QCxYcJxkw+wjxQTfKT0GXuWR/lCgg2LR
         PylYh2p2beXr42WkZMyWQtrhe7ox6Au6VSIEwFsDwwO/vafMF3FvZt+pjW5prvf5gs7P
         xzDVP71jvf4Vu+FJMCmwNQtM7cyPHFl5Ub/kwKuQ8tUGzUKtWgUwo9OnXyhmcpV6u4On
         w+UftghFICefEtc59hVapXM/U/OHg7Egoyu1q+vI2y5Q+wN/7dOuPxMEiDYcxa3bOGC9
         j80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946846; x=1761551646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRhB4goZZHeAeNM4L4TzxYzSUk03jlldDvspwEzH08s=;
        b=tuDhMh+tz65/PuAEloO0RAziVNfvXkko1pxkNeCuAvDtBzq39YkMGfpuaumaqt3HNs
         vlvN6Zt832c6frotAVux0nHXM0XFgCwWmyMpTrSvwaxXi7ffeGqKkeR+S27w0bqu6eOx
         zJmS95Xbrn75ueAo5VfE26bEhG0fPI/JkoX9ajtjy2O+RwbVjcP5Lc4tJ6D0iaGyG0FR
         VdxgeXCfhi3r/h0XG22eyuU4Hoazqglri4g1mDmxN3AuPEP8cCeONdSbk7NrIRTnMpMl
         RsxBLLUThgDTU8LsNQiGeU4z17QDBZQyJYaGx5EkuXlA6pPT86cmfsC551BwIGZUqFem
         ywow==
X-Gm-Message-State: AOJu0YyBkCftLCEebGKixOUicw2orTlAKXQmQR+EmkL2KEwUwIomvYfY
	/PWY8io7UJS7wV+1uEoX21qwsmFDEik4bsyjInTx1W1x3WdMkYww47jg
X-Gm-Gg: ASbGncsIeTDYsyovTqYNlfa5rxfBDPVr8E9ag0QyqjKOJu5cdKMVwt4LYwg6x2U9Qf9
	YyqU9rOzQLvWWYxB9Uj9D0yPe86RrZfYG/Png30Hl28OqDJR+Z20tOGJHqy+4txcuIw21Kb6oWY
	pkj6RS8NsoCnwOP4IJ9ZkijNLKg8raNiOHm1elAT81o84R1divwxE8CKrR6A2ochsY0jD89Nzkp
	T2JZpvWyrHdgpeX8FKMgiXsbQHw6GeJkpV2sUoTwcvbpMjx5Xk2oChD0Qg2kvbonN7ViPYh/XT6
	JU98pkAkUrFeNqBnz3NHoy7wF7BD+B7B1qJyXk/4jqnU821qDKHKw4X7L+yr2TPISJUBeBobDc5
	Gh58arChKx19wM/LaT9QBlqVhBxcDr7Jdza27buHibRYcKizsi2/oM9BfTUEjFLz2TrOZwdKVUC
	R6UuE6tVhNFwHTSOwlRASeD+TncSoIFNGQUXwZIyecRTRXSVQ=
X-Google-Smtp-Source: AGHT+IHNf+LHCvG3rUp+Jr6JdQPPOZYl9e4bMtKND5N9q7EtWK7YQgKv5erskbMGBL2zkKFdJWYHKQ==
X-Received: by 2002:a05:6830:6731:b0:795:f1bd:1dd8 with SMTP id 46e09a7af769-7c27c9f45fcmr2731018a34.1.1760946846011;
        Mon, 20 Oct 2025 00:54:06 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.211.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28879e84fsm2434665a34.7.2025.10.20.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:54:05 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon, 20 Oct 2025 00:53:48 -0700
Message-ID: <20251020075348.266824-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
References: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 11/10/2025 00:16, Michael Garofalo wrote:
>>> On 08/10/2025 04:10, Michael Garofalo wrote:
>>>>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>>>>> Wi-Fi fails to connect to any networks.
>>>>>>>>
>>>>>>>> The bounce buffer should not make any difference, so it is likely
>>>>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>>>>> used.
>>>>>>>>
>>>>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>>>>> for the failing case?
>>>>>>>>
>>>>>>>> Actually will also need to see the messages in the "fixed" case
>>>>>>>> to compare.
>>>>>> I'm afraid I won't be able to provide those easily, at least not with the
>>>>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>>>>> turning on full MMC logs like this produces an obscene amount of noise
>>>>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>>>>> my original intention, which was to save the logs to SD Card, (since my USB
>>>>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>>>>> since it's now logging the writes of it's own logs in a permanent loop.
>>>>>> If there's a way to narrow down the logs to specifically whatever portions
>>>>>> you're interested in, and filter out the noise, I would happily provide it.
>>>>>
>>>>> Are there any error messages?
>>>> If I drop the debug logs you mentioned so that I can actually see what's
>>>> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
>>>> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
>>>> it takes several tries to load the firmware, and it can't authenticate to any
>>>> network.  I've tested and confirmed this effect on multiple consoles, across
>>>> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
>>>> off, it's much more functional.
>>>>
>>>> Logs with MMC bounce buffers *on* (without my patches):
>>>> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
>>>> [  168.508519] ssb: WARNING: Multiple ChipCommon found
>>>> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
>>>> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
>>>> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>> <keeps trying and failing forever....>
>>>>
>>>> Logs with MMC bounce buffers *off* (with my patches):
>>>> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
>>>> [  383.986645] ssb: WARNING: Multiple ChipCommon found
>>>> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
>>>> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>>>> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
>>>> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  405.389013] wlan0: authenticated
>>>> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
>>>> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
>>>> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
>>>> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>> [  414.351544] wlan0: authenticated
>>>> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
>>>> [  414.431879] wlan0: associated
>>>> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
>>>>
>>>> If there's anything further that would be useful here, let me know and I'd be happy to provide them.
>>>
>>> Seems the SDIO function driver b43-sdio does not print any error
>>> messages.  All the error paths in drivers/ssb/sdio.c print debug
>>> messages instead.
>>>
>>> I would suggest the following, which would limit messages to
>>> host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
>>> Chip ID 14e4:4318"
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 860378bea557..2719b21783ad 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>>  	 * - The card was removed (...so just complete everything no matter
>>>  	 *   if there are errors or retries)
>>>  	 */
>>> -	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
>>> +	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>>>  		mmc_should_fail_request(host, mrq);
>>>  
>>>  		if (!host->ongoing_mrq)
>>>  			led_trigger_event(host->led, LED_OFF);
>>>  
>>>  		if (mrq->sbc) {
>>> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>> +			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>>  				mmc_hostname(host), mrq->sbc->opcode,
>>>  				mrq->sbc->error,
>>>  				mrq->sbc->resp[0], mrq->sbc->resp[1],
>>>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>>>  		}
>>>  
>>> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>> +		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>>  			mmc_hostname(host), cmd->opcode, err,
>>>  			cmd->resp[0], cmd->resp[1],
>>>  			cmd->resp[2], cmd->resp[3]);
>>>  
>>>  		if (mrq->data) {
>>> -			pr_debug("%s:     %d bytes transferred: %d\n",
>>> +			pr_info("%s:     %d bytes transferred: %d\n",
>>>  				mmc_hostname(host),
>>>  				mrq->data->bytes_xfered, mrq->data->error);
>>>  		}
>>>  
>>>  		if (mrq->stop) {
>>> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>> +			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>>  				mmc_hostname(host), mrq->stop->opcode,
>>>  				mrq->stop->error,
>>>  				mrq->stop->resp[0], mrq->stop->resp[1],
>> 
>> With these patches, I still get copious amounts of spam, but at least relevant
>> to the wifi card now.
>> Here's a hopefully useful snippet (it's just a lot of these, from what I could see),
>> from with my patches:
>> 
>> [  154.177276] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  154.177297] mmc1:     4 bytes transferred: 0
>> <...>
>> [  186.707195] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707217] mmc1:     20 bytes transferred: 0
>> [  186.707358] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707382] mmc1:     384 bytes transferred: 0
>> [  186.707477] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [  186.707498] mmc1:     24 bytes transferred: 0
>> 
>> And the one from without is very similar, except I noticed this pattern:
>> [   85.942269] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.942299] mmc1:     4 bytes transferred: 0
>> [   85.942523] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.942555] mmc1:     4 bytes transferred: 0
>> [   85.944548] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.944581] mmc1:     2 bytes transferred: 0
>> [   85.944777] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.945160] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>> [   85.945187] mmc1:     2 bytes transferred: 0
>> ... occasionally, some of the requests don't have an "[x] bytes transferred: 0".
>> 
>> Hopefully these help.  I can get a capture of the entire log spam and
>> put it on on pastebin or something, if that would be more useful.
> 
> Need to know if there are any errors.  In "[x] bytes transferred: 0"
> messages, the "0" is the error code i.e. no error.  So you might be able
> to find errors like:
> 
> 	dmesg | grep 'bytes transferred' | grep -v 'bytes transferred: 0'
> 
> Also the debug patch could be tweaked to show errors only:
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2719b21783ad..7b18fe6d5738 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -169,7 +169,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	 * - The card was removed (...so just complete everything no matter
>  	 *   if there are errors or retries)
>  	 */
> -	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
> +	if (host->index == 1 && (err || (mrq->data && mrq->data->error))) {
>  		mmc_should_fail_request(host, mrq);
>  
>  		if (!host->ongoing_mrq)
These patches were mildly revealing, I see this near the start of the logs:
[   32.222988] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
[   32.224789] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
[   32.227574] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.227834] mmc1:     0 bytes transferred: -84
[   32.229615] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.229876] mmc1:     0 bytes transferred: -84
[   32.230400] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.230659] mmc1:     0 bytes transferred: -84
[   32.231173] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[   32.231476] mmc1:     0 bytes transferred: -84
[   32.233287] ssb: WARNING: Multiple ChipCommon found
[   32.234489] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
[   32.238533] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
[   32.264908] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[   32.272565] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0

This occurs either with, or without, my patches.  However, no further
errors were logged.  Despite the lack of reported errors, the
functional behavior remained the same as I described earlier.

