Return-Path: <linux-kernel+bounces-722145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E3AFD5CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F342176919
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1F2E6D0D;
	Tue,  8 Jul 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="PaAQDhTo"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B02DECA7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997408; cv=none; b=YbhxMNsPJfI3KncFaiTJvUSgGfZKWtjz9Wcr8nTpS0F3XZ2iOecgu/+jevtpIcxVzFPCafOmjSkBksreZMC3uaOvu/252e+/fBDPPA1IrJM55Xi/U8TSdhExiGQkM0CZJ02kgNPXuGNHClPTWL4+mGgiK5gjCZGlBycfRDR3v6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997408; c=relaxed/simple;
	bh=POdUrRfmEqSV9wiDLteLAYXMg3BT7qxYRo45/FLOitY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=gWubVCLchJ7YpmyYVweit+mDDYI8Ek8zl0aY4R3bh8yDqDQ1Q5snRJDhDfbnM7DE9rfveKIiISyeWAlB0WD8BmRe6FhgMdR074yTExTh5WkG2cOK+FQeIplQha1nwS6kCmEnRMWmCgEgjR8a8qa3qmosmYnRZGpqhJ8aUV3brmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=PaAQDhTo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so3833318a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1751997405; x=1752602205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+o8LqvaZ6CvfMSgYZPXGDVqAB0BYYQNmg6xijiaWbU=;
        b=PaAQDhToM+ozC8DfHA1i/1vuEVGlnsgHMh39J3tn1OSZMeQUeAGFqv33gqHtqqGao0
         RuP+/f9IlhKxgWGYVhDFiz2uvKbdFqj4yWfBfv0yBJtapYOVzf5q45xkfZh6QV3VlhWV
         1nq9Q/CIQNxdhnUug/IdxAnQwo2GU7fW0cC5w6Iv7f5GGCT2ysUfgxOINiY3S4gpTpyB
         xWDDG8qqfOAfOZD3ZkNnZlIhm6BMgvLUW0pzlW2CH+5FbRoDs0IfIdR/eHWcn0MXcJBy
         WguVYEnoSA/AV+pAr8IXdFNwwM9sXfXBbIkhTUr0OVxQgJ/VHyZnBvdviLnYowg7aN9T
         Jcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997405; x=1752602205;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+o8LqvaZ6CvfMSgYZPXGDVqAB0BYYQNmg6xijiaWbU=;
        b=Y3FCsxvjHraenyzDZ8ox96K4haJKLDzyYpJ01k5bhjek1Bb8fpJ9j1q2MWIdzmc2m8
         T+2ptu5t4xPxchgSJynmu+c21q9g8PtVWpvxsOzD6VC0RcC3vlw4hBgrKYuOzdiu+e6i
         7KVMBHctO1se2YlIbYT0PMIvas9UKNQdhUUrs7LtA3vHDl5E7aFcFy0c52VCfV2+adUP
         bVn8ZTOyzN04uE2nWhVIr+BALL5d0KLoh/e+kHPMpoaKt0C2Hl3XGmCJKchLOzsKHA6J
         F43Maiv99BhkEo83VyCEdzNIOEQB2cD2Q7WdQEgM7lnVaY4MuMzxwvpiIhx7XPS4ByzQ
         VVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcj+qVxSW50IiNSf+fBuXGkYkBPFS5F7m2usSLuYCDNyAQiOC8VRE4P89kxgwECUa/BoQnNSfdDLWhzNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTX6kxqiSa5oTBSiVvvC+ewIeMEoO32JdIO378xR7F1t65CyX2
	+3wpIIw13NVDILiSWplQCNPjgRA8qGr7ckLx+2NSkbyUbYRBAKusa5jhUcsHbtHWTQo=
X-Gm-Gg: ASbGncu25/gl5nWphT1oSvEv3Y0ROF85eh3w4IRDJVhBG7bQZpQztIRPGnfwa1r1qB/
	sQ5NZ5A06TOcoHA2PYwZE7CxBUREbDjx8vaHlLGPQMGT233XhGOMAAkUngGO3IchSSZ/x5CpdLR
	4fB/qkTdQqCafRfKklDrVf/rtEsPpmxAFHNgR1T3Ee5njjiNDck8khCHRSRKUfTaDES01z+jYLX
	w4laDc30/DUK48eKGJArXa4tED9mCaLQ3YDaaey2uiTPJavf/xXiFOd/VibgJ0Je5FH8zTi7dRO
	L+pqaqr5NQZiq3MshxKHhptYbVT9Z3LH1yQxwRr8hJMHvMFrSsIVwahCt1nJW4O1aNhjw3I=
X-Google-Smtp-Source: AGHT+IEU0OGusFweO0Bn3dONzwFwwEsX3SLeg726DSpXWtqxvbUi12Aqjr5gGs+m1NJ8BybtUxeI3w==
X-Received: by 2002:a05:6a00:10c2:b0:748:6a1f:6d3b with SMTP id d2e1a72fcca58-74ea49591a2mr1758b3a.19.1751997405070;
        Tue, 08 Jul 2025 10:56:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:a219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce359e9a3sm12499347b3a.35.2025.07.08.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:56:44 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:56:44 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Jul 2025 10:56:42 PDT (-0700)
Subject:     Re: [PATCH] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
In-Reply-To: <20250708-jubilant-abruptly-8ff77f7986ca@spud>
CC: broonie@kernel.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
  perex@perex.cz, tiwai@suse.com, hal.feng@starfivetech.com, xingyu.wu@starfivetech.com,
  walker.chen@starfivetech.com, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, geert+renesas@glider.be, Conor Dooley <conor@kernel.org>,
  Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-CB566446-2A1F-4269-B064-9B2ECC847DAF@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 09:48:27 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On Tue, 08 Jul 2025 17:36:48 +0200, Geert Uytterhoeven wrote:
>> The SND_SOC_STARFIVE Kconfig symbol was removed, but it is still enabled
>> in the RISC-V defconfig.  Just remove it, as it is no longer needed.
>>
>>
>
> As I mentioned to Palmer a few mins ago, I'll grab this along with a
> couple other soc-related defconfig patches I have. (Apologies if this
> goes out twice, I got a warning last time about a timeout, so ending again)
>
> [1/1] riscv: defconfig: Remove CONFIG_SND_SOC_STARFIVE=m
>       https://git.kernel.org/conor/c/493e9b085299
>
> Thanks,
> Conor.

Ya, I think it's easiest to just keep these together.  So

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

in case anyone cares (I don't really care if it makes it to the commit).

Thanks!

