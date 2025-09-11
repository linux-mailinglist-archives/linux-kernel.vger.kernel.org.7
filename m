Return-Path: <linux-kernel+bounces-811147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B78B524F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A6B4432BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985A142E83;
	Thu, 11 Sep 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="QxvmvdCy";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="QxvmvdCy"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2E1C68F;
	Thu, 11 Sep 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757549979; cv=none; b=uN7j9r+98hpvs6rgzqmOygUfM2hRN6P89JOZPdP/dyAZf4dd7QZa44oaRwfBhZj3fdy0GiyoouZgfYPTeqjOnaYSXKGvHF5obm1d3AI7UHYByrkA0EXKWJNy90GInBjRwJJzd5rT/3PSQCjVRsiG+W8vmEDR5H+qsC+ZGA+AnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757549979; c=relaxed/simple;
	bh=rm3AkZAbKSbhIyZ5CfHZ/hYbK31V9mAjqEvngq0N62k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjmcHgPLZVNcPEdXHZwP0PT9Nq3TPOq9YOfhnm0gF5TQAH9SRPQ2t1iL169outakEahMWNriFf491cusjmOAUQnB3X1coeBFo553EvotZyLy0B9otZPlSRYdazjSbzqEwin2BZQ1wlFyY+K+fCPJUxV3hGbXEN/IkearZuhQju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=QxvmvdCy; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=QxvmvdCy; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1757549974; bh=rm3AkZAbKSbhIyZ5CfHZ/hYbK31V9mAjqEvngq0N62k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QxvmvdCynwiQmyUCEZglIXJlONCSxFKLU50Iv/+NUOLlub/WKSfFxf70fHjOMpevt
	 JKkAMlt06icmssvcOsv6yAC78b3S4Fa6kWE+2z5fUP/KwrijebRJirOMj7Sat8E2Ae
	 e+dlrOXhVv7HPsIS7bPUmTxvncRlSVxo4jBVBFNL7V7qBeNiSqm3Kr1l7SqRbaI/NE
	 6OjFsuF5o6jaYiKz9+ODdUotWik9XJR18ODIR3aKxCrgYn/Bg/FMZGVCeL9tss8vcM
	 RMGr9P2pAjjhs48t2KZf9+d8pTp1DhBSn8vSMzQAYoB3s2xNVbnt3bTI59Vr8V0/Kr
	 N6m080/JnKzhw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 3C92B3D3382;
	Thu, 11 Sep 2025 00:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1757549974; bh=rm3AkZAbKSbhIyZ5CfHZ/hYbK31V9mAjqEvngq0N62k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QxvmvdCynwiQmyUCEZglIXJlONCSxFKLU50Iv/+NUOLlub/WKSfFxf70fHjOMpevt
	 JKkAMlt06icmssvcOsv6yAC78b3S4Fa6kWE+2z5fUP/KwrijebRJirOMj7Sat8E2Ae
	 e+dlrOXhVv7HPsIS7bPUmTxvncRlSVxo4jBVBFNL7V7qBeNiSqm3Kr1l7SqRbaI/NE
	 6OjFsuF5o6jaYiKz9+ODdUotWik9XJR18ODIR3aKxCrgYn/Bg/FMZGVCeL9tss8vcM
	 RMGr9P2pAjjhs48t2KZf9+d8pTp1DhBSn8vSMzQAYoB3s2xNVbnt3bTI59Vr8V0/Kr
	 N6m080/JnKzhw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id ACC75380DFB;
	Thu, 11 Sep 2025 00:19:33 +0000 (UTC)
Message-ID: <4f4766a2-5c94-40bf-9016-2e5412796c1a@mleia.com>
Date: Thu, 11 Sep 2025 03:19:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm: dts: nxp: lpc: lpc32xx: drop 'clocks' form
 rtc
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016-lpc32xx-drop-rtc-clock-v1-1-5b271804d3e4@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20241016-lpc32xx-drop-rtc-clock-v1-1-5b271804d3e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250911_001934_307867_11B1F904 
X-CRM114-Status: GOOD (  13.67  )

Hi Javier.

On 10/16/24 20:14, Javier Carrasco wrote:
> The RTC does not provide a controllable clock signal (it uses a fixed
> 32768 Hz crystal, the input clock of the SoC). Remove the 'clocks'
> property to better describe the device and avoid errors when checking
> the dts against the nxp,lpc3220-rtc binding.
> 

This dts change as well as a counterpart documentation change won't be
applied, since it breaks dtb/Linux ABI, unfortunately.

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This patch used to belong to a series that converted the affected RTC
> into dtschema[1] (effectively moving it to trivial-rtc), and dropped
> the signal clock as it uses a fixed 32768 Hz crystal.
> 
> The rest of that series was merged, but I did not get any feedback for
> this one. I sent a little reminder ~2 months later that might have gone
> unnoticed too, and as a few more months passed since then, I opted for a
> resend with the single pending patch. It is of course not urgent, but
> still relevant.
> 
> Link: https://lore.kernel.org/all/20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com/ [1]

-- 
Best wishes,
Vladimir

