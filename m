Return-Path: <linux-kernel+bounces-804783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04028B47CEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C40174BE8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643DF283FCB;
	Sun,  7 Sep 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="MixN8Wji"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16E1DA23;
	Sun,  7 Sep 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757271134; cv=pass; b=C9c+rwRkFqoQ4T54C7OsNRrXH34MRcXo6YeGptyrNFuVd0vxe4B+G7n5U5vK93XNtiE6+RpQOVWQ0WCVxFZrvRXewJGBGPZPiv70wDyq4DsrV0MuZYnrIfy0m4JMIVZYNn41T1J7LwfU/DZtAQ9xf2atth7YQegseBCn6rQ63kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757271134; c=relaxed/simple;
	bh=xKu9bhdQLVvlLdhnrRh59Fzz3YKv6AL6WdbOJd6ryDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsKuQcl6H0hE566Z2/cEPP13zzf7dNmOBu6fsn4FB8Jteyuzu3V37z0O2uPUhjedB6yiRZYCfZd/8fgrlQHmLn1SkRZk4bTEyx2mNlvEl1elvTStJhhMzAwn959Pn+7DPCsXA69X8rGlXmPyQJ3XszoyRGhsrLqzpH6hxDq7dQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=MixN8Wji; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757271105; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LVWD3SHQtC7SoFVKBuDY1aLxv8HKkg0+CDoXD4XUC871+2/7VKD2LmFHPpaqSCIf/WyCxy1NGFdIvcoWP2+SD78RgWIp0kJ2Nd+EKYDx7bRBPBkQ7Ut9vTmURoZDfRgWDaT39IvQ5iyvJqxPqp8elP1U1J963ErE8MgFSxlG6Dw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757271105; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=72zMzp9EQsVogTu/OAl9/EdJSst3NLpKe0M5q7uE32E=; 
	b=PuMd8rXbS8zSUtqHwxMTyAsTwByeOGoqvHa5YcSoh8/GQUqYR0wrzkYWNwF6pyfZH7gv0HKE5f9l0HhR6IjO5cKO1FwmJerR/MUxVXv9B0pdBZsrSykDKd/G6Ueodjs9e9AVJ0++ClYYwonNJ/+3T0IETObJNj7ijvQr5ZhIYJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757271105;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=72zMzp9EQsVogTu/OAl9/EdJSst3NLpKe0M5q7uE32E=;
	b=MixN8WjiNrR9K4gGzWj3HwYdmrd1jvqQnRBQVeQbgDtl40BqhCv4myWoJb2rCLnQ
	48ZoKFPQWXO49DDELuCEtRMnc4+1WMWLWPL/623dv5bP93mwyqid+sYTqJQH+fiYNx/
	S8ta4TgRapiWvdwhI7vucEgyQJMIhRLpFZns1NNU=
Received: by mx.zohomail.com with SMTPS id 1757271103703981.538669071521;
	Sun, 7 Sep 2025 11:51:43 -0700 (PDT)
Message-ID: <c9136f3e-464a-48c8-92d5-c014dd4e9958@collabora.com>
Date: Sun, 7 Sep 2025 21:51:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Enable HDMI Receiver on NanoPC-T6
To: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/5/25 14:02, Marcin Juszkiewicz wrote:
> For quite a while I had this patch in my local tree but never made it
> work. Kernel generates the following messages all the time:
> 
> fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: signal not lock, tmds_clk_ratio:0
> fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: mu_st:0x2, scdc_st:0x0, dma_st10:0x10
> 
> "v4l2-ctrl --all" reports that HDMI In is detected, /dev/video[0-4]
> exist.
> 
> I tried two signal sources:
> - AMD Radeon WX2100 (via passive DisplayPort -> HDMI adapter)
> - AMD Radeon RX6700XT (HDMI port)
> 
> Same situation with both - kernel messages as above on RK3588 system, no
> connected monitor on host side.
> 
> Usually I used MPlayer or MPV to check v4l2 devices but here it fails
> too:
> 
> $ mpv av://v4l2:/dev/video3
> [ffmpeg/demuxer] video4linux2,v4l2: Not a video capture device.
> [lavf] avformat_open_input() failed
> Failed to recognize file format.
> Exiting... (Errors when loading file)
> 
> 
> Checked SBC schematics again and HDMIIRX_DET_L line is GPIO1_D5 like it
> my patch.
> 
> What I go wrong?

Hi, your trouble with HDMI capture sounds very similar to [1]. Make sure
you're using opensource ATF and check whether capture works using
v4l2-ctl tool, see replies to [1]. Post a full kernel driver log if
problem will persist.

[1]
https://lore.kernel.org/linux-media/c71a3f79-71f3-4fd2-a509-c42b24636a2f@timsurber.de/

-- 
Best regards,
Dmitry


