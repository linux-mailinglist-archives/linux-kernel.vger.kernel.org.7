Return-Path: <linux-kernel+bounces-835583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FCBA782B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487E11897BED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679A29E0E7;
	Sun, 28 Sep 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnMrIEla"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60729B8D9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093881; cv=none; b=WWoOYqdVj7aBSC+kQaV6cpG+TTxy+yPvRVj4CjPuPcLGP4bSfVYFzPWthtJpefT3MmaCtqqa5EuN1j91qurcXvGOJoXNIz9r4ab+DEbPEMJ2ktiZq/IOEOzLx22juLBEhChs3TEukXLdiop9TUwAqUu/RbdBsEIjUIp0K0aA6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093881; c=relaxed/simple;
	bh=2WutnJMSjx/tlVTggiTq270RlFcGDjrZKvKJKGu3jOw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OX1heDGaf//FPXlH6UYuiXun/9ELcO9tBD38NThrhcRdJxVzGrAn4mglGzoNeY2ov9eb5DF5nRYfSw7KUEoK2JJ0eWwcE6rvndRE4r984Y1NaYr/RA/TLRGOUwN/8L/Zh8lZSBc8I+P4X6cLOrrXXzfHFRt9yM0Gpd2f7coxM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnMrIEla; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4258ac8f64dso37389645ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759093878; x=1759698678; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2CtyGjaKoFTpWcOtehpSu1UKfzRtFMQx8MVWa1Gk1A=;
        b=dnMrIElaL66HRDTkGyYnpgkwF9BHH0AaFZXcBaB1XCM18jMyPlLAg/b42WuVB21yoW
         hCNcPS9luAmll9h9Q+2cCnvsr6GjsS9+J/D/rwCzcK3ymxkBDfEK0KqHtolkhkKCA0ZY
         /IqL2w89o6n0PBT911ZAf088jpxnSK3SP/BXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759093878; x=1759698678;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2CtyGjaKoFTpWcOtehpSu1UKfzRtFMQx8MVWa1Gk1A=;
        b=nNulI5LbO1cUzj/AdHOdEP5Cc6LHskPPG+M7i8Z/LWMPQ4Tv0hZ/Sg1legzsVOZnk1
         IXhVHrUMx5mIzu2gteoTgZA5IMCzoYB1FV58vW74Ac9zdn/8QUXEF9lmC73KPhbHQR3a
         kPLwehPuXteeFbOvoHOioOmzw9O7AxesfKWPfec/XdnoL6RtFL7c0yVZ8xN0FJmUPWdG
         xfSQNjLw5EnSCNpt7Ew7A3EmBOg0tkr94dIaELCKqhyuEsRdAIVBjg0MWgS5kZNcH3BB
         V80amrbEy9tJ2MejlfEoXZAySKIllZCzF5DVm/NLtQ6j2bfviV5/bb7W0y89YFsKmvrQ
         Q7+g==
X-Forwarded-Encrypted: i=1; AJvYcCWl6gFg2bfyvJtVGlS0/bWvckF93DmuwjuYnxNKFFA7OM5CCxfZEzXYfD9YEUrD3m8kLSHZEVXtaW8jcEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbnfdM000bVAuu0r7Y0IN9itFGOS4saaEheOsut0EoGqgzyjr
	oUx/E8jm2XIgNOwxVVPPm0oSwf7hPUWAHhPLzhAFH/fsDTKnaqfdTtuGOioDfPKRZhw=
X-Gm-Gg: ASbGnculnj0S/JjPcu3q2H2p5FZYROiACuNwIJMHDLjlafvbdubbm0bCqBDz/XexPaO
	WphJlXvEFtfaz/tIKIK2rG2zxArETPf9hRF3MaeuaYIAz2R1uvJDJ33zGnpEf+hcoJ5saC1rVA5
	NvXMDJPOp1YSR+J4ZTqNpquCucctgtTFBlsTtP03TuA72vUJcSKiOeb5mbwjoO4bVQxPi2OUqnp
	uvztP97k7ZvSRaIKfrBDOjdRZ+o+P1NJ8NlpSLkESKOxKQHlXXQGprsvf+rrnubLMq0KJ7RAx5s
	1wJCHKg6y/9/VHZKwTAlyyA8epFLXk0pwBTVJ3o09et/9Yy9Evsx3YJiC8/rXl/JVx/hgDZgqyd
	WA+NDsVCguDo4PXhvesWoJuCiny7idxXqtAOsLg67hOSDiA==
X-Google-Smtp-Source: AGHT+IHqp7ALrXM+DvPJjeZMY1xmr69x803hbF1blrS69ctYlZzUIH/zHItwG4gHcHpIU/0U87BM3Q==
X-Received: by 2002:a05:6e02:3a0d:b0:425:7ab4:d61 with SMTP id e9e14a558f8ab-4259563bb2bmr235228455ab.25.1759093878404;
        Sun, 28 Sep 2025 14:11:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bff834fasm49570665ab.37.2025.09.28.14.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 14:11:17 -0700 (PDT)
Message-ID: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
Date: Sun, 28 Sep 2025 15:11:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>, johannes.berg@intel.com
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Error during building on next-20250926 - kunit.py run --alltests run
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas and David,

I am seeing the following error during "kunit.py run --alltests run"
next-20250926.

$ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=16
ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in function `devinfo_pci_ids_config':
devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
collect2: error: ld returned 1 exit status
make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Possile intearction between these two commits: Note: linux-kselftext
kunit branch is fine I am going send kunit pr to Linus later today.
Heads up that "kunit.py run --alltests run" is failing on next-20250926


commit 031cdd3bc3f369553933c1b0f4cb18000162c8ff
Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Date:   Mon Sep 8 09:03:38 2025 +0200

     kunit: Enable PCI on UML without triggering WARN()


commit 137b0bb916f1addb2ffbefd09a6e3e9d15fe6100
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Sep 15 11:34:28 2025 +0300

     wifi: iwlwifi: tests: check listed PCI IDs have configs

Note: linux-kselftext build just fine.

thanks,
-- Shuah


