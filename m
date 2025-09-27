Return-Path: <linux-kernel+bounces-835103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E587EBA6444
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1264E0643
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0623B605;
	Sat, 27 Sep 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRFKiv/J"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E318DB1E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012453; cv=none; b=sMFmDYe4kr/agoYD9eUaBtJI0b8VO71gnGYRfQMreDVvPtqYLrMqyNiGHtfuHUFvkcifeasTbk+WZTGdC+kWjXO7woHLcu+CttYr3IvyWT6PQapi8e65ZwAx+hBSIqQuau/5rAAsxG+8YDrOhiSiyFc7g7ugikcpOlU5aVV2Ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012453; c=relaxed/simple;
	bh=3ykp3PJQEhX+5JnJkdMV+50B1GBtcUenqCvNZ45iXrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qFDBxxCYN71NVdNCR8MlCaxDmc0TrZ7R7nN9mMxanciimnuwcXQ/fvEF3EY08PFi/3+H1mCzUi5vP1HgwmNyx4/pABuMKnV5l5UrQu6dtYW6ynUc2M3HnJX0dj4WB2AhoszdmvQrnVeSB5io7XuvzsgFX1SrVkADh35I8sieGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRFKiv/J; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso2919119f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759012448; x=1759617248; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP95bXIdfAP4ieU56Vps/fSmHsDIQFQq65FLLrfhp+Y=;
        b=CRFKiv/Jj0y10lZcw+xiLxUMX3M4Ww8loyqRnoSv6GjpoB6QuAnI6OnzE4TO7D3MT8
         tIm+VMXiJ2oPGj8z/IEPgrV4q0JMbqgRAT3iwpnXCpB8vtd4dalBpjAO3kXF265YC47K
         3twtJXSYNZH8xX2urTmY9rddc7bTBn9vnWv5iCTfKNzLyJ4nq8kkTQX6nHXGrLwwyfZJ
         IjqiqsMrlqh4XsoNPIqTF/OtB7SOBufR9CgiRGuXXvZoOACzKIFRvRXbUxRUYNgF6r9e
         +F8EzlbcpB0EAZHF3jjvo+lBXOXLj7LLQAea3pHjV2i3kSYuf39c4tr5MNle9mmr5R6j
         ArKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012448; x=1759617248;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LP95bXIdfAP4ieU56Vps/fSmHsDIQFQq65FLLrfhp+Y=;
        b=Olh3krRtGB3vMNpKE+koOUJpIgVCXEBpL6JMIL7j84eeuN/ZISLfEqPlO44kNXbGMH
         tk0pHbwc2eB0ua5OGiV5lY6EhgiX2bSJB638X+azmyINL2wN11NwUA673EIVDzgCyjVI
         r1MzQ1hCnF86YydCovVGtNPIJ+ANc6cRHR3Gm/GDoqJbnycsZ/D/A003R23GTOZrtvxl
         L6I9VrZ7zt6ejKHRIaLMLAe7JHQGmb/H23GF965xCV3s6hLy5ABgG6ChTcJdnzU173z2
         h8A/ob8SS8+k5EiIjpvWc2tRq2mziaBrq0wsUTBVKsQbsb7LXvxQCggMS4JJKLFusNB5
         BQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXEV+1WOG/bnEHUbKeNm6ArARJV5RCbfKnCm3Vqbs23spnG00vXbl2jibZavglWQpOjOyJYbZvdpUF92RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZzEyEiM14NxM6ERmgTcVxbLUXOvA5sZIXcMXvK8PVJhIyrpz
	eR1JB5suD1fnPgEKERF375O8ddWOPjl86UaZ3o3dWCgphT+c4PqB6lK6gNywjv4lhCk=
X-Gm-Gg: ASbGncuhYMbpEKE3LrV8MO6tP6C0ypB9t7CuBwV0AqCCa2Uahdm5RYV5PTdAsUTCpmJ
	mJ5YXnJ9g03RFyxzenbcMAiyIUprqmpWnH6Aj04UNqPat9UEYu/juFLsM8feqEJjAkgzGBWk+JH
	a29iqNgellK4v3dQD1kBDGcp5ot23LmSs3tDVabMNRVOfW0G73Lvq5d/a29FztC/bQT4QFys6NO
	U2lG2VSMGZ27Vi+JxNp1xgb0U33ZcjZxko5+l8YXUr//3QOVRVT1QV7dGT9Iwm+WnMacYhn/tT9
	9bNs4YOsvzE4ThleutsosR2p/2AlGJghW5Uwb0Wb/HuMdf/TRz3tnq5A2T/rgOWk6oEs8/T/D0V
	Av99F7KFd8nGL3HRhwKMK9zHXAtQv1kzlIlauaQ+gr3eaVlczmWfV/xYnJYyIDn3XDMKYKaLxiK
	+ZKPlWJ8zDnil8
X-Google-Smtp-Source: AGHT+IEWocz3ojMq+fkp2gZ4P2lO2/bYXWtv4z7dcVb3cIz6dF2JdMUp2ihd8oeyteTrF91YJrtuQQ==
X-Received: by 2002:a5d:5cce:0:b0:414:6fe6:8fbd with SMTP id ffacd0b85a97d-4146fe69211mr5053786f8f.54.1759012448337;
        Sat, 27 Sep 2025 15:34:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm12641310f8f.37.2025.09.27.15.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 15:34:07 -0700 (PDT)
Message-ID: <40c2a6fc-8dd9-4f6c-9ebb-2f74f7d0b795@linaro.org>
Date: Sun, 28 Sep 2025 00:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
 "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal driver for v6.18-rc1 #2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

after an error reported by kbuild test, it appears a file missed when 
importing the RZ/G3E new driver which stayed locally after a conflict 
resolution. This change is on top of the previous tag. Alternatively, if 
you wish to drop the previous PR, I can emit a new PR with this 
offending change fixed, IOW this fix folded with initial patch (which 
sounds cleaner to me BTW).

The following changes since commit 79428e60897916401c9ed326f6ada4d7c7c997a3:

   dt-bindings: thermal: qcom-tsens: Document the Glymur temperature 
Sensor (2025-09-26 13:27:44 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.18-rc1-2

for you to fetch changes up to dc67521c20b701b5237ff486ae078829dc1f8fea:

   thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas 
RZ/G3E SoC (2025-09-28 00:19:53 +0200)

----------------------------------------------------------------
- Add missing file when importing conflicting change for the Renesas
   RZ/G3E thermal driver (Daniel Lezcano)

----------------------------------------------------------------
John Madieu (1):
       thermal/drivers/renesas/rzg3e: Fix add thermal driver for the 
Renesas RZ/G3E SoC

  drivers/thermal/renesas/rzg3e_thermal.c | 547 
++++++++++++++++++++++++++++++++
  1 file changed, 547 insertions(+)
  create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


