Return-Path: <linux-kernel+bounces-842743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77909BBD71B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC69F4E98B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC2269811;
	Mon,  6 Oct 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S98A/rx5"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BB267B89
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742905; cv=none; b=DBG+OKLrzBSW5WnB/fLgGvDmovPuSe2ofYpJsnHajPlrORqLoYXPu7Ksj/0UTCacVP/GLhUt2d/dwaj5cQuubPIRkcWQHqGMwHjqTEAHupPI3DK5+wwjtQLYpwNQdafsMr8xlJ9G5vI0BeQ24a40sEB3s9bRv1y3/HBiyvkG/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742905; c=relaxed/simple;
	bh=6YXXysC1cWrKt1rE5lwkSbhw467QlHVJrTidJeTanWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCoV0PDPd1HLFZC9TejMfzVT7O4FPhUJwYzzwU+pBc4A6ksuSDXeYBF4frWCBPuaGtyyNTJMq5suQUiWDLacMZq4HyMJ45/lc8ZvNT4JXmiHXbmWdMyUlPUFiGHb/6DL3zkDrBwlbzFSFszCe9bVj0FrMgbdrPTwsvANjSAsw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S98A/rx5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ac2a60b911so758868a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759742902; x=1760347702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X6wezq6nwZqxfyxFAVDn2DYaLflR3W1jtoNhuxnn34=;
        b=S98A/rx5Hojvpvaok6fVkTnX5cU5/OB75So6Hq8K6NJnbnv34ffbLr9gxbB8SLRSs7
         cYEsHtK0SERc9ExB0/k2IjRUjRqT7LP3vN7iQULhxxzdwYDXkMcGHmeCxMH0ldnauxo2
         FTYEpVamLh3duP3EzHgHeix1ruLOiw6xqKikMf7dxKuHqX0A3dm/vAs3ejXR94VGx4f0
         YmKCKgSL0tICO5zgASP7dJzR3bj1LaV4vFPbqrgotBzFemYPqte/eNslzK0GKLDE1BXP
         2TLV7uuc/u3qjIC2mYEympIeG3uDrntnXxicehzrM/zgGjqWddAJHImSjjS/bLVxXI2O
         NRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742902; x=1760347702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X6wezq6nwZqxfyxFAVDn2DYaLflR3W1jtoNhuxnn34=;
        b=HIkUCsC0Ov9EtAARbDfClXk+Y6+JYNfIlJBvib55Drygk+9SQ2gq3hzO06NA9sGep9
         dz26K8UlTQml9CeQxHsPu7uw2xrrQeAJuKUoB2QMT1XEVwGSpjKU7hUMaIKB1rLr8l6q
         aWw25J0e56ULPuscC9fqeg/xAjXfmXpKKJHcqgqup19z7oKOvBsaEd6qiinEtFCoytqA
         NzMAHMlu/AmhOb3OoonTW+B1znWU9nHDWxC/9rd/CqM72a1YVD0RpzUqniJtF7AnwcYO
         MM2PiMaxtjwNicP2nq8jm9dgokoueyGAPabhxpmECWl0kZ+h1tWd76GQnS/OrsmPPl2i
         6GLA==
X-Gm-Message-State: AOJu0YxWVaV84N5mx5mBFC/ArmrSn8DFay1Ub849hnb+PBeN4Eqs0pJ3
	MWhoRrfHxPEeGNTa7f8nHnCUDG0yQcSt+3bmu7UL1LcSe0qx2k7yFYip
X-Gm-Gg: ASbGnctzRPcEu9PsEXGhGHWDG33JgJST/5wTKRU6Tl/zdxSQ0GbnA5RqaBDKL6OtUQS
	9VKBpOVZSBeztXTpblhjYZQsyIEXbQX1QjWMPsJt++vY9j+OnlWrsoCecu4/8g2DIexyBj+V8/J
	dG61dwQt5j5JCcOYRlRIEfgrmaiSmZpbvpYoNYEneXMpziZvW5+C8111e36xfv3d1Ie5r5QDJpi
	sVMePaC2YcRa9Et1BSnaYPXLbeqZ/8w9+eMKe5e2sVP+oqPJ63eKh6sEIsH1klSvfTqR+jJDgav
	5+2K6t1jf0BeXKCQ9PIEB220N2GmoirCqyT/120r6AxgonVEN6v7dtMuXY3Tjw7oaRCbf4cJZsA
	UDZFwBLqiP3VGwq3Szx4wEcWBbqf8rDTp3FzoNJnvwLaAlVWQ7D3bjERS2Z2xZzyGhmAyZy36S/
	yR1SI6EMhV1sDYPaXikw==
X-Google-Smtp-Source: AGHT+IEEYY5ntlIbRvyboFEkoT1IS8+qMFgikJsiS3VtzQDHAVRzDoM9dGZgtzv25ryEtwksTrduMw==
X-Received: by 2002:a05:6808:1823:b0:43f:4769:b0e1 with SMTP id 5614622812f47-43fc181a6b0mr2846991b6e.6.1759742902569;
        Mon, 06 Oct 2025 02:28:22 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb25d1251sm2852093b6e.28.2025.10.06.02.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:28:21 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	officialtechflashyt@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Mon,  6 Oct 2025 02:28:15 -0700
Message-ID: <20251006092815.2555733-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
References: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 06/10/2025 10:35, Adrian Hunter wrote:
>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>> buffer.  On some hardware, this is required for proper operation.  An
>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>> Wi-Fi fails to connect to any networks.
>> 
>> The bounce buffer should not make any difference, so it is likely
>> a different problem that gets hidden when the bounce buffer is not
>> used.
>> 
>>> Could you enable dynamic debug messages and show the messages
>>> for the failing case?
>>
>>Actually will also need to see the messages in the "fixed" case
>>to compare.
I'm afraid I won't be able to provide those easily, at least not with the
commands you've provided.  Since the rootfs is _also_ running from SD,
turning on full MMC logs like this produces an obscene amount of noise
from the storage, unrelated to the SDIO wireless.  It gets even worse with
my original intention, which was to save the logs to SD Card, (since my USB
Gecko serial console is rather flakey, and introduces corruption now and then),
since it's now logging the writes of it's own logs in a permanent loop.
If there's a way to narrow down the logs to specifically whatever portions
you're interested in, and filter out the noise, I would happily provide it.

(P.S. sorry about the blank message there, still working out how to deal with mailing lists)
>
>> 
>> Dynamic debug for mmc
>> ---------------------
>> 
>>     Kernel must be configured:
>> 
>>         CONFIG_DYNAMIC_DEBUG=y
>> 
>>     To enable mmc debug via sysfs:
>> 
>>         echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>>         echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
>> 
>>     To enable mmc debug via kernel command line:
>> 
>>         dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>> 
>>     To disable mmc debug:
>> 
>>         echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
>>         echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control
>> 
>>     More general information in kernel documentation in kernel tree:
>> 
>>         Documentation/admin-guide/dynamic-debug-howto.rst
>> 	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>> 
>> 
>>>
>>> Patch 1 introduces the new quirk bit.
>>> Patch 2 applies it to sdhci-of-hlwd.
>>>
>>> Michael Garofalo (2):
>>>   mmc: sdhci: add quirk to disable the bounce buffer
>>>   mmc: sdhci-of-hlwd: disable bounce buffer usage
>>>
>>>  drivers/mmc/host/sdhci-of-hlwd.c | 1 +
>>>  drivers/mmc/host/sdhci.c         | 8 +++++---
>>>  drivers/mmc/host/sdhci.h         | 4 ++++
>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>
>> 

