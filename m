Return-Path: <linux-kernel+bounces-830874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44582B9AC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949DD161B66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483843128A4;
	Wed, 24 Sep 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ERxaZORr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61A2D9EED
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728719; cv=none; b=GI7uusFrMbvFWBoaMFkgjR8q0qW/E2SsKCPvxuINvJk/WpkITQLpvL1OHsS4PLOCs4hTXt54MEXnZBSROBVD+U+vN+pvervHYGt2AbyoRZVaVHcpa59QGlgazrQg4lkBLQViEMKeLMoU6SnPXrqqEYcUdp9H4xpliF8IX+4FLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728719; c=relaxed/simple;
	bh=wxoRaReO4bOkEJ9wqUi/JezN7CZUe2yebO48RziHfMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exOsevOmAoxqJb3hL5Sskb/zBJFoyFcvHMtwE/G8Iegds2hHCLaM/U5iNOSJYLsj13ejRfbNAWKpQ/+ooumgmg18Z7lB1ySgBmpkSPrf63oHhGCRBx3/UMc1OEm7x4f2e7e0QfuV7r+h2SHKkBGIGw96jzZwy/IdQNbiQXM9bVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ERxaZORr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46dfd711172so28820645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758728715; x=1759333515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHM+dPg5CzcBzObOI9Pf2b6r0LMdTdXtJZQ6lv1PBkc=;
        b=ERxaZORrYnw71Lp37+kNSzcbYIUefU+tY/3fOWArGMxmn6OudbkpdSRNAfuWS7kvc4
         rzmI0SPQvN4NfZMqcWvy9g8CZRekg5qeHDNQBifXQLBxhxyDfyNibSngfi2tMHspvMdV
         Qs76yC/95q0qCvoQeV9F16BvC+HhkfHSIm7CGiJoMKo8D9zmvL+751FQIzQqISwvrCkC
         I+rQobLiLivQx1qqx0SUcC4zNHUbP4HuCyXQ/zvlMZOT1GiDOrB4dm228z9139+C/I+A
         v6kZDBCM73eXBc5x62WmBpj/wxGFGTVOGBnc0HwfmTmQ/24R7R6ue2CKBslSviNzNW7O
         KTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728715; x=1759333515;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHM+dPg5CzcBzObOI9Pf2b6r0LMdTdXtJZQ6lv1PBkc=;
        b=WyszRUU2YxLwixUNJ4lZpI3N71er4zHtFT2ueQwqJTgXKWnBShkgvkuogZP/Fzc5Og
         vUjtIE6ixeG1zFPbIWhE9IbUzSIRQEL15A7lDm61Uo2GRoCrVJ4RWo66C0Y/2ToIRTeH
         NOrNNZ6SjbDgbwiLddUCN2RnDxxRyX25S9pAqzPA02bgOCCjTYlSwN3Umzv7avQudVIl
         QLsD1Sh4U3wUPUzm7lD22S/7SQ4xakgMnytVyIi3veQmUCMHZcUPkbnHom+VkOz4ujpS
         jNbNfMQ8qGui2iY8LFgAOVjULmQwzqBl6DQzeOeSJWkkwA9VivmTMcXVE2ZnCOAbdeqk
         rKBw==
X-Forwarded-Encrypted: i=1; AJvYcCXE1ToBlj8mvhmE/TtrV7+FWniwIn0qdEKzgYcw8Vvop/1C8tdN3YqCC0o5SOZHT6W4dTr2iyVjtOmVUuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaLaHpChzUncOYwQRdXgMzi41UMZbFIzwWLtbLo2juFOPDzJi
	rfpWddNt74WxNEEepxtdocr+XcGl2swDf+YLabrCw1I/fe5/LhzU+dYrjJQkYFxeX3k=
X-Gm-Gg: ASbGncvr+wfzy1v4wH6Ypan4JX7zB70Lvw2cesrKy3k9DSpTs+rxIJ7dcl5imJBLpb+
	Y1X9x/kvZkiNzZfPrsAvJP3mibvzc53O2Rxa2jBdFN+/SUThEcJpIKUU48267DtBjEtjwXijJp1
	10O1qQCT/YwgocGlVY8rZBmN7Rwg4i+vBonWnb/8B2M5UdVYULhOeKbpqwxXBGBqHC3OQyfbSIC
	+EYDM0GJ+A/Inu3TsboDUv10QqOIVatRzmxQRNOd4IAzDqzaV71lIsdstwi5N3HZYCTYMm69rAI
	iJTI1h8Tl17PG7mMpiVHUSYZIOtpTJzRzar6z+IOIy0vKjXYEEfyNSUIVZq8TyiSH84jXAnFx2z
	9CUPIQ6HLfaexpCCQiZ4YQP+ebEUZaR8=
X-Google-Smtp-Source: AGHT+IHMnyFMvGG37xHm32Yaa55kvxvWk5ho63VASQxzF/DozMTzRSP1c41ESBWFhl0MwyfSWac6UA==
X-Received: by 2002:a05:600c:4e4c:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-46e32a51741mr2647965e9.32.1758728715341;
        Wed, 24 Sep 2025 08:45:15 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07408433sm28236778f8f.20.2025.09.24.08.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:45:14 -0700 (PDT)
Message-ID: <e19b5006-c6b5-4e72-a3bf-42fa6833936a@tuxon.dev>
Date: Wed, 24 Sep 2025 18:45:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: renesas: rz-sysc: Populate
 readable_reg/writeable_reg in regmap config
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250922074101.2067014-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXKbPGqAnAcL2kFyF6K3hH9=gr8ECAFVpkgj-OL1mB4eg@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAMuHMdXKbPGqAnAcL2kFyF6K3hH9=gr8ECAFVpkgj-OL1mB4eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 9/24/25 16:44, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, 22 Sept 2025 at 09:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Not all system controller registers are accessible from Linux. Accessing
>> such registers generates synchronous external abort. Populate the
>> readable_reg and writeable_reg members of the regmap config to inform the
>> regmap core which registers can be accessed. The list will need to be
>> updated whenever new system controller functionality is exported through
>> regmap.
>>
>> Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
> How can this be triggered? 

I found this issue by reading the exported regmap debug file:

cat /sys/kernel/debug/regmap/11020000.system-controller-rz_sysc_regs/registers

Thank you,
Claudiu

> AFAIU, registers are only accessed as
> obtained from syscon_regmap_lookup_by_phandle_args(), i.e. based on the
> register offset stored in the DTB.  If the offset in the DTB is wrong,
> there is not much we can do ("garbage in, garbage out"), and the DTB
> should be fixed instead.
> 
> Is there another way the user can access these non-existing registers?
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


