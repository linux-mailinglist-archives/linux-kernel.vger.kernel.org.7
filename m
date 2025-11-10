Return-Path: <linux-kernel+bounces-893496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0111C478FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25F54EFD32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D324DD15;
	Mon, 10 Nov 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Eah1SoS9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FB241C8C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788425; cv=none; b=p6585Qvinnn19r0vSzdrzls8zBz2pzRBiu9rJuFbjQ+SbVHx2+lVenv4TW7EIiRhQC2MMraNz5uvS3cHvwnOsmr7du6zwVSAdO1omKv+IIMqUffmVCS7uh1aEU5hL+q35IwKNaA27t+OovnnJdlkH7/WvDvIS0Kh3zpZ2Y0+P04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788425; c=relaxed/simple;
	bh=2+TwJQ8oA9Lyx9ApVt+VKWFMh5SdFjYczHAvYgBcGSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUSe2i4r1WO40kXuJUMvyoU3k49ffhyMoFCjuZZ4D2eJ+SqX1V3yzc7w8CmmVEwJ0iMzBXxT6Zo5UtgTpoz5cO581SjrdMGay+tSsjt4dnwFHAqT8DajKXYKSkDvY6onm/vZZqgMH7VZXz7m1/eJRmECATWOwl/xlvubNOG0NRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Eah1SoS9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso21713965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762788422; x=1763393222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sU4Vu+5Nhcr+sXRc68w+sgESrqt+otDbTB/fX8fU/W4=;
        b=Eah1SoS96coR8VnG4Wqa6NTOPARugIiuddHN51RcI8DEVg+8iy6Znbeq3m0juLUfQ4
         TXU+t2xlBk1YuQh2t9modn0swMr9n4pqFDbizNK7gj00hLE9nDQKFBMA7y70z14ANH5F
         n60DIPoIuOPDci4DFBELSwR86PvkVj+rFiL4CUCTL2hb6AOmo0VxqRM+WW/xYaUgFMXc
         amVIeKhwTU863j2JWIBZb40B0fsuiw2Mwr65uNzfGsPwfrKLc27NcjmwqwUmYMR3VWdU
         rpgi/HYd8ZTQc+siTfWlPcwZ6kH1Dje7aKHpYGex17qG6vgS9zJmGr3fBi0GZhxVAgtk
         8Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788422; x=1763393222;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU4Vu+5Nhcr+sXRc68w+sgESrqt+otDbTB/fX8fU/W4=;
        b=TOoscHZehIJzKY3VkwjRBcPpiJOochVFeQ4Kh0zZfCKmHZ+TBpyaIKYWAJrtxLz0In
         2PFmsrOy3MOYfj2ek3Swc+oiiJnG4UoEOzaKYRJn6ryfiBSyaGhJIlfCiytRdXOwn0D7
         JxIFwUjUUl3XGBu+Z9Ghd3xL0QLToL5WmaCS2+JW8Mb0Ic1dwNIxDzMkUzlRXE5Nfzby
         VqMbDEBHHUGKkzCftS5cR4wwD+kWmTZf4WvfSYlyvdSlBO8K2z/I+zyOSAu29JSbViYR
         Uaa/K85u+jNbUNMe6UT3Ilh0YrTWBFttaFrXnzPUNp2tcQivQLFwf/jIWauIlqxe0oHJ
         cW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuylKgFQu9+XzouOoEtRGrLcDrkBX3yvnzj6R18Et/uXALRo0283aK7s+aTBVq2qaKMCQ5y2/lN6dEeZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYELFSItESTIzJtQyCDdjLn30IXj312/rJMuac0LxQBDbjsuu
	qcBoIvn60bZ5882UDYOOjM0TQPbhnXCPnq+xVntu6idDuCAZExf73tEIDVXBRm2yo7k=
X-Gm-Gg: ASbGncv6Dz7vpWgQabqDTVytOcIF55xqH0OqhC8NO1ydZbAQcwmsO+FZRKNXekTvBGR
	fqkkfckQCEJeeuM/BsWd8R5xoCvGYqBJx5Tr6BfecUc1d6t5dQoLq1hMjLV6D8LwV89bUewsMYr
	rHUa2agXO46mx/dvPim8SUWHwwYQBCZOBfyx5MhE3gtT42Tia0DySejf3HNNNY9gKxHc8fC02+z
	o4M5kWXNhAhQlPwf67geukrIlVljT6b/TBVKSB6sE07o850LV4cC3FJIRT4gF/yBS3MblqS/jVy
	RrHJCrXfSpA+t/9gxIkKZXQtJ6inL6Sk7j34l9pIvc7e+Ze7QUsGEpgsJEiEYxYFDoxgYD/MfXG
	ibcC/WbO2oCS2OVzAqte9CkrjdWSBk8jk0TKNVVxVL7jJW+LD1n552C3K47Gv5BHXUttB4rbpcR
	1Dni4hVhoS
X-Google-Smtp-Source: AGHT+IGKa6znPzwKr8w/TiVXgulW73+wNboeJt9rzEOBoA6V/J1joYMMoFHr1OJr0Wko0CzJFczvYw==
X-Received: by 2002:a05:600c:45d4:b0:477:1326:7b4b with SMTP id 5b1f17b1804b1-4777326eb64mr76072995e9.19.1762788422160;
        Mon, 10 Nov 2025 07:27:02 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm329772085e9.15.2025.11.10.07.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:27:01 -0800 (PST)
Message-ID: <fecb65e5-f434-43c4-9132-cfede05eba0e@tuxon.dev>
Date: Mon, 10 Nov 2025 17:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Add initial USB support for the Renesas RZ/G3S SoC
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/23/25 16:58, Claudiu wrote:
> Christophe JAILLET (1):
>   phy: renesas: rcar-gen3-usb2: Fix an error handling path in
>     rcar_gen3_phy_usb2_probe()
> 
> Claudiu Beznea (6):
>   dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Gentle ping on these patches.

Thank you,
Claudiu

