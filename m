Return-Path: <linux-kernel+bounces-844939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE30BC31A7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD693B11F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7628C841;
	Wed,  8 Oct 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCSVK1xQ"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2728C2BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759885847; cv=none; b=qKl78uwD/N+lzixQ/C3rR1l9zIcgWotzSrghGZ/6AKthHRHKVwN9v2q+YJvhC2D/6kV+ptgLsoZQeq3ZgTmm2LqV8TdslKINQJjqorhqOQ3zefQrmeql/tX0CILzuoXWsAoP/7zMmsLrSMfz783GNNBl/aIp8LIoM9FGasK1HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759885847; c=relaxed/simple;
	bh=soaCZwSBnYDKjhrn4guImnCKkB7r8FytIPikbYPQYEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9ao3+rLVeEFnqPuhtnYyP2TEB4OPAGzdvpovP5w8D8YvJ5R7rHJDlbY1tJbOncJloQ/vHX0krcIHgwkznvQFxrgQAuwToIx6HS20QqzasAefbi+52XT9Xz0nQKK3IaRzhtov0OGnK+2ANZ/8Xx4vJuuLn/dfs31G4maEM1dqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCSVK1xQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7bd02e9544aso535814a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759885845; x=1760490645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ40o8S0ID1LHMllf2Hdbvi9NxW5kRuVvWfmXyNXWmQ=;
        b=eCSVK1xQpC48NaJeaszE/Vx07RUrtAB9nRRdpH0qsYFix8RF5yOp8RE8lO0khgOfCK
         oMgYr1c5CaXBkRGZoVCDNE7ZrB0JQAIjXbpwk8FfzWXKlW+Jd04JaUvOClb97hFe8J1n
         Htwy1OcpoTHwuqfpKYHSA8byBODvKnROUxLVExCo1deVNrfTGE24QzSNuB/O+f8VGDgh
         UqRSvBcTddyIY6LA3lpL88bwxiDm4gikMAfvdrH4WUzX4T7yUQfVvITYQrPxyGAecrO4
         ECWdxM72c1nLao+9E1HurXWZCIupqA6iiti0zI+AXyEWK+0h5Wxa1rHwHaYaOeJ7vbL7
         /tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759885845; x=1760490645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ40o8S0ID1LHMllf2Hdbvi9NxW5kRuVvWfmXyNXWmQ=;
        b=VsCngiFDF6vhRweoTxixT43gaAOeCXFM+UOsIpo2hXOhUTIoykSaUpE6VBTjKsy68+
         Dq9DA7NyTWbslffuc8sA0B8kiee/EswekcGB7BTThFASgW47lDe8wMa9dLBUQ+l/++rF
         uUDk4Lzv1B62Np7xe/75LzDQ9S6KngBUu5g5b2CXk2yAFE/srLixP8hbf8FLRsSxHe/e
         UqDqMmuxPnFSBPggd3s0xuKzpKo9erReltBfIZDI858FBVwR2rt10DPULBRaHPwQlqTq
         lsE24F91D61O/OUf3dFN4kxDWhTZRTFXvth6ZcIwXFWwD7dAgUDHilYBMr8/cpoqKIFl
         RCPw==
X-Gm-Message-State: AOJu0Yz8XPtqHFaheftVhuzAbUSOeYQ3qyzRP8t4fQhlrlJXz3oWn0LV
	5ueG1YOgO4DFGx8c6opBCmSr6/Khc39I3qtS3J+QOfMYaC35R1OQ8nBgjVTFae21
X-Gm-Gg: ASbGncvIJleEHRMPhXNB3n3VuMue8iTbzc1iIZWoMtHsCk1KV+IOM8gvLmGY7RFgZQK
	DR/PhIXDsAi5flHhgVSPQSsgCwCsq2EL7KvvuUs3b7Bze0EcXmnzi2IOVfKX93b10fleaQbm7kR
	0H7BqNqlsItSMtdjy6OCVDMFlm4itZC9iTkBugbQZMIUrQ9BdFazuSnKuwis6L8EY8LTz/jvzEO
	02tuPj6vMnaP/qox0udk1vNiJBB/y1CSXmdnqW63Id8K6XMKX0t/eP5hNyg5FiIoT2NX46sNSnx
	hX+gBmll9uNfSSWriNzM8O8LcRqMnDHhRKJ+QPInLsa6O0z+mFDd0A/3WOY9Ey2PfusxKUIUque
	TcOvxVQ3A5S7OxK4aFXeGJ1c4v3p0LwrltmjyVLQfbmUvDcZs3Ci/2dX6Unep2CXrVoXDrxLfgI
	BgJEMLAus=
X-Google-Smtp-Source: AGHT+IEwTyuhS+IHJTjC0Rx9AgOwGoGW45W24PN5EngHAUV+tyx7wcSe0IDf7jJObpAZI3353qerzA==
X-Received: by 2002:a05:6830:4386:b0:7ad:31c:56cf with SMTP id 46e09a7af769-7c0df6aeb95mr597976a34.4.1759885845055;
        Tue, 07 Oct 2025 18:10:45 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdd06c7sm5378221a34.15.2025.10.07.18.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:10:44 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Tue,  7 Oct 2025 18:10:41 -0700
Message-ID: <20251008011041.3298938-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <6294fb07-31b4-4c0e-9023-7c5ab604bbf1@intel.com>
References: <6294fb07-31b4-4c0e-9023-7c5ab604bbf1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 06/10/2025 12:28, Michael Garofalo wrote:
>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>> Wi-Fi fails to connect to any networks.
>>>>
>>>> The bounce buffer should not make any difference, so it is likely
>>>> a different problem that gets hidden when the bounce buffer is not
>>>> used.
>>>>
>>>>> Could you enable dynamic debug messages and show the messages
>>>>> for the failing case?
>>>>
>>>> Actually will also need to see the messages in the "fixed" case
>>>> to compare.
>> I'm afraid I won't be able to provide those easily, at least not with the
>> commands you've provided.  Since the rootfs is _also_ running from SD,
>> turning on full MMC logs like this produces an obscene amount of noise
>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>> my original intention, which was to save the logs to SD Card, (since my USB
>> Gecko serial console is rather flakey, and introduces corruption now and then),
>> since it's now logging the writes of it's own logs in a permanent loop.
>> If there's a way to narrow down the logs to specifically whatever portions
>> you're interested in, and filter out the noise, I would happily provide it.
> 
> Are there any error messages?
If I drop the debug logs you mentioned so that I can actually see what's
going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
it takes several tries to load the firmware, and it can't authenticate to any
network.  I've tested and confirmed this effect on multiple consoles, across
multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
off, it's much more functional.

Logs with MMC bounce buffers *on* (without my patches):
[  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
[  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
[  168.508519] ssb: WARNING: Multiple ChipCommon found
[  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
[  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
[  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
[  168.719257] Broadcom 43xx driver loaded [ Features: S ]
[  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
[  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
[  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
[  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
[  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
[  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
[  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
[  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
[  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
[  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
[  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
[  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
[  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
[  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
[  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
[  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
[  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
[  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
[  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
[  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
[  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
[  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
[  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
[  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
[  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
[  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
[  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
[  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
[  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
[  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
[  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
[  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
[  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
[  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
<keeps trying and failing forever....>

Logs with MMC bounce buffers *off* (with my patches):
[  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
[  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
[  383.986645] ssb: WARNING: Multiple ChipCommon found
[  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
[  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
[  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
[  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
[  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
[  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
[  384.086571] Broadcom 43xx driver loaded [ Features: S ]
[  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
[  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
[  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
[  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
[  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
[  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
[  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
[  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  405.389013] wlan0: authenticated
[  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
[  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
[  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
[  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
[  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
[  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
[  414.351544] wlan0: authenticated
[  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
[  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
[  414.431879] wlan0: associated
[  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14

If there's anything further that would be useful here, let me know and I'd be happy to provide them.

