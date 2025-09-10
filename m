Return-Path: <linux-kernel+bounces-809893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F4B51336
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE1C1C25E53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67AF30E0FE;
	Wed, 10 Sep 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLH3rhrH"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE6265609;
	Wed, 10 Sep 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497935; cv=none; b=XZBcsKCgcMirR2NOeCyER6kdXbATkKp/ANvE4yHE/9OYtsWrihVuBpjgegHQRmEEjiOAmafqm/qL2+WoeTLmlkHy4m8JBidTp0uGUvTMV+sJLp7T1NWwm+UIcm7dt1o6VwJ+QZyzGChugAIJKqwcjsm4C4KQr6c5qyDjjp2ykig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497935; c=relaxed/simple;
	bh=Dayr28Tqd2NOreKB0wNsAkvU5AyQwzcIHuITFGBIIEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EO3bz7QAbldt+85zrt1YtizxeIE1tuchKutCSklrIbkORrLTnogmSfl8ag4Iwh9CkBbXaTaNddqSD5ORme5aSec4Tc0v0lUOAcksl/wZ3HPRtslymgPHO1x+TsQ6j7vOLjTclbBn6gLkiTV31fQZdYrzUEQl0J1CFQHZnRtzIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLH3rhrH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d19699240dso264000f8f.1;
        Wed, 10 Sep 2025 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497931; x=1758102731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkwu36sIqKlccEWXHkKiOjIdmvv3IpUTfWruAp8yJD4=;
        b=hLH3rhrHAHSvCp6TPSmA3lsSxIyVUJAtYUmD6TgV/h/L9CDCeBgZZ02ijOwkYFBtpF
         /MOxnu/P1rXPAymA1wyZVf9uBEEG3yJbBIBh6z75vZB9aKEPL3LVO2UohpWejw6mxQRD
         QavIu3gE97P0Bqlc5rY0XvMmX2mRxvjUwZHGaRtCXned32UswusuLXYJ/7En6KD2gsYi
         refJ9xd1/cuE6NacJBzJCtPJBUdCK6BE/bvR8LdA8wHQu+DaBe1pNVyLEz84FJguGLvs
         r0+su40gAStMna+1YjTV4vA8oECJjBbnOoaAbXTYgjVT7J65PJOM2xllLR0BBXu1r5by
         +RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497931; x=1758102731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkwu36sIqKlccEWXHkKiOjIdmvv3IpUTfWruAp8yJD4=;
        b=RQP3zZXnhwVQOtauVzeGHfWfsWjwRjx8v3qsSKHruC2otjsE5zvlxFyucTAir/ACE5
         qbDJCF1BgvoF/LzQbVIsSke4yRm58Q9t3er5nKeuuSnr9M3m2G0FbTCBa1fJCMicxJY7
         Yj3C7+ZU3nuoUajjSMyJ8rVWnRQ+KrzDhiVXPaALzoOvSii68v/vi08XYHB7Ki4TB88x
         1ZtYzJxic6hyRsUcJ6/EU9/8Hvp1Ti7kgwECoNtuNLo9V1azXsl/pDayCOYWA5nxUEes
         KnrNzHR5zvIhLco9uxQiz4KXljuXctMlEUnQObXck45lFvwYj1t5b13fVrUjF5zlxS6y
         1puQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsjsShmXGQcb+Bx5p9L9ClMf+O/DqHTdwOMXTyLCuvzD5en46YzEf3HDF+hgyIps5ivVx2VAI1hha@vger.kernel.org, AJvYcCWrjeY/za50SAzaIydrvSF5TfbWExecRS8cblwV79CkrMwnCS8QbX8tYVlmb7pFsf2bIlbFnpsu82CrHVNB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjc5BkiKRxbm/Rq7wAPXyH6eRQK24Gu7VTP/siFP+6eohUpHB8
	V79E47MYzW4P+wBbERB4Bj0ik9GYl2vmlb3aVZnBC5/yovBD4eDyAKR5AQFJyA==
X-Gm-Gg: ASbGncuNDwP/JzzRxiDnVfiLeYUsFpfHi+WfLe6G6rsbwD/CpR+6MSjwtXp85b1gyUj
	cddyhE2PXiNPKraN7MqEHyDxaGmbAMp27/iQF7VOQqXgwHuc/YbmQY43FqBa7b8w6dCpTotgM2E
	evCtcKveRsReqOsMAgszht3JDUX2MF1/sB+2xrALBbNPg1Ix0ItG9E7al6puSyHs4+JiayzVtN0
	kx2YpXHsuJo5GTiSGXxPbN2QfJcXpx03PqNSISRAGGTedwDRKwYdLfEfjRj/GxD0Eu6Kt3ZK1dV
	+Ltk+duxaLZQm9+uKlLrz5e+KQ7Ts2y8ACTDoGkn9HRDdmHbOg+7cnjL5Uwn7D+3/Mf1QdC+RRa
	bAnCfLXKZAnhrZokZ/FF0iHDlcwE5Juby9gtbZnu1TaujrW7JatYIZ3Zz2AxhoDZBsRCrCHKz8k
	1s+cqOvlU=
X-Google-Smtp-Source: AGHT+IHm66PjMPCOgJddrhyW/UFJ502yp0yYCzeOV7xdKQ14Xo/bl1MIKxHU3kUumA8xFUXACR4S1Q==
X-Received: by 2002:a5d:64e6:0:b0:3e1:ca94:3199 with SMTP id ffacd0b85a97d-3e629b44341mr14421484f8f.14.1757497931132;
        Wed, 10 Sep 2025 02:52:11 -0700 (PDT)
Received: from [192.168.0.24] (static-39-127-60-95.ipcom.comunitel.net. [95.60.127.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238760sm6091362f8f.34.2025.09.10.02.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:52:10 -0700 (PDT)
Message-ID: <0730bb06-46fe-4451-af50-fe79daa44f28@gmail.com>
Date: Wed, 10 Sep 2025 11:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for Grinn GenioSBC-510/700 boards
To: Mateusz Koza <mateusz.koza@grinn-global.com>,
 angelogioacchino.delregno@collabora.com, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, marcin.czarnecki@grinn-global.com,
 b.bilas@grinn-global.com, andrew@lunn.ch
References: <20250908130620.2309399-1-mateusz.koza@grinn-global.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250908130620.2309399-1-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Patch 2 and 4 queued, thanks

Matthias

On 08/09/2025 15:05, Mateusz Koza wrote:
> This patch series adds support for Grinn GenioSBC-510 and GenioSBC-700
> boards based on MediaTek MT8370 and MT8390 SoCs, respectively. It
> includes device tree files for both boards, updates to the device tree
> bindings, and necessary modifications to the Makefile.
> 
> As far as I know, <angelogioacchino.delregno@collabora.com> has access
> to the schematics for these boards, as we've shared them under NDA with
> Collabora.
> 
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
> ---
> v2:	Fixed the subject prefixes,
> 	Fixed alignment in dts files,
> 	Added missing SPDX-License-Identifier,
> 	Fixed the ordering in dt-bindings,
> 	Dropped redundant info from commit messages,
> 	Run checkpatch.pl on the patchset and fixed the issues,
> 	as suggested by Krzysztof Kozlowski <krzk@kernel.org>.
> 
> v3:	Changed eth phy-mode to 'rgmii-id',
> 	Changed eth mediatek,tx-delay-ps to 30,
> 	as suggested by Andrew Lunn <andrew@lunn.ch>.
> 
> v4:	Removed the nodes that are not present in upstream,
> 	as suggested by Louis-Alexis <angelogioacchino.delregno@collabora.com>.
> 
> 	Added default pinctrl to ssusb0,
> 	Enabled the scp_cluster node,
> 	as suggested by Bartosz Biłas <b.bilas@grinn-global.com>.
> ---
> 
> Bartosz Bilas (1):
>    arm64: dts: mediatek: mt8370-grinn-genio-510-sbc: Add Grinn
>      GenioSBC-510
> 
> Mateusz Koza (3):
>    arm64: dts: mediatek: mt8390-genio-700-evk: Add Grinn GenioSBC-700
>    dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
>    dt-bindings: arm: mediatek: Add grinn,genio-510-sbc
> 
>   .../devicetree/bindings/arm/mediatek.yaml     |   2 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../mediatek/mt8370-grinn-genio-510-sbc.dts   |  19 +
>   .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  19 +
>   .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 538 ++++++++++++++++++
>   .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 209 +++++++
>   6 files changed, 789 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
> 


