Return-Path: <linux-kernel+bounces-752185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D5B17237
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DABD3BCDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C72D0C74;
	Thu, 31 Jul 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXXsTURE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077532D0C9B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969160; cv=none; b=eJeAHRnqIEF1gbGiZMJO0GKm2GMUcF9y+S+Dxhtt5iLNVQzNgLJq0IcjW1me0zAIrsUx7Q4+Hzp4WwISdQb7R5qkJij8Zz8oxmL1sEm+H6ySbpaKEnt63QFN8qKDGV9JFE1SV5uiu/i7q1s8E5CL63a5iBv6ornICDHQSY0ZFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969160; c=relaxed/simple;
	bh=zlKQjfqTW1wivTb2tOMm0ypIAGo5j3x47ywfdlXX/so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB9wZ74wYpbZy1DkHzZV2XQ8WxsPsW8j7M+A7DlAbxhMfmAKmBcsCF1+8wLm8lMyFbr1lfARBW2cd4jmRXeqUWsCV6J667qMKKP7eJRu2YvZhhkq/XAH7bQpKpPhLqRV/JMjN2fdy+SrhEMO/xN4BFxEgEGdI9E2u3fBZnJEWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXXsTURE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bc61152d8so908870b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753969157; x=1754573957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CiOHh4KflGVZdTHVnlzeHrBpN3cSm3EFMlJTMxrcSY=;
        b=OXXsTURENSNZl6lyFbXtx1jA6a4AKYP+4WnspxjWTMU8RqVqz6BrbPDu6Bfo549aMM
         uE1HDrVqrbrspVFUvrUKHV5Nm4X3KeZVGRPGLUJWUVcaEs8P52xgGzggL0ApzIrrisuX
         +84XCbUpIZudG/wE4cJbCTNEF1GnA3nLSmN/DJ2/MfV3Gqf2EckBtt+k7GU1njAbRM9t
         mbtTai8O3jAdAYfsHPp2FazBEPuyRZSLK8BdRIwHmmq1Qy8/XgHaSG2vniYSSM+kF8MO
         RzfU+PZnpHlYaCWaPv97IA6b5UbeDAmao+TdamYZDyAnrU59cQpffer/VpKxSZP1HWEs
         QZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969157; x=1754573957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CiOHh4KflGVZdTHVnlzeHrBpN3cSm3EFMlJTMxrcSY=;
        b=fqE3UtXW7zPIP5NJhqds/FPG1KuOXk4uwsFKHgDj1tGBA7GjS9GrML8VZK5Zr0HdxP
         sB/6ds22FqObeL8lfBaS6r7C5GbzUtc4zQJyFNjMXkIlTAwfOIHtvTDQVQINf7E4DRFf
         ahK3gZiDt17m37BKkTVHo6hbHB1txmW0I+55Z4MOcPSjRbUS1qjIs4JHZbcEvqW1YIGJ
         BetCPInw0CG1x2XN6skqxiqkcCJLD8yeWN97fsvZWbyPTmD7IhHfwoqOUftpPbH8Dffw
         2oYIeAN3704Yz8vi3K6ZjA+8LfYaYKzaQ6OQVm74RvHAq+S1jm7o1AxgYGXKSI9eSzJc
         d4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXHUX+Q+ZmdPA+mxYPLfiBROl5xvp+iy24VMfBcrJS9dkJc2b0lbkAkVf+0MXH2AWogr1JNPcVcz2JQGVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx3jEZvPk+xHY485SBZBmjqsWFKiIbfAKEgB/pVBxYcEMFPBz
	RcAOi+nLx35uJM/EsTc2P7WjGgrCiUGNmt1VE5ucEyN2c2yXjN61JpsT
X-Gm-Gg: ASbGncsrozYYGzpmMxG1yGexuc+mTSqPa4NL4S1DysCtLdvpa1AkwTNqfYTNA+yq1h3
	5Nxtxc0ET0c5QN7UZrelQsdemXdQvmHj/MqZ1E0DBjW0y2tPf94YqvV9lLB0Sws2syifWkyqCby
	frU4SYIBJ68YJx+oVlH81nCESic2d8BNOmygBA0Gep6W0Sg3+pN8fKD8K7z3JSVTtkEDW1j/zxJ
	HNx4oZ2Iwy5gvF50vcAbaKcPVBJ9SkrAs2RRv+9exQwIlxuOaaz34jnDHicnV3H+VBzTEw9AyTo
	TKh6Adb5hZSc5UiGsfSkk7Erj4e8WdogLREbS9jfTNp6XlsFO2mZU+4G47Ilp26q18Pn3tJCHl1
	txWbxhitY0ApMQuvOdK3iAvDPbQ1GG6iipIo=
X-Google-Smtp-Source: AGHT+IHq4cvuZ+j2n5KjQ0MS7/a7KnCKB+sJvliwUgyjSaB3BY+0pZEbmzZRfszkekGxlreF6BeqPg==
X-Received: by 2002:a05:6a20:3d06:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-23dc0cf7867mr11979427637.8.1753969157130;
        Thu, 31 Jul 2025 06:39:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6eesm1708679b3a.22.2025.07.31.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:39:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 06:39:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ao Sun <aosun718@gmail.com>
Cc: matthias.bgg@gmail.com, p.zabel@pengutronix.de, wim@linux-watchdog.org,
	linux-kernel@vger.kernel.org, geng.sun@transsion.com,
	Jiazi Li <jqqlijiazi@gmail.com>,
	"peixuan . qiu" <peixuan.qiu@transsion.com>
Subject: Re: [PATCH v2] watchdog: mtk_wdt: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Message-ID: <7f952385-ae89-436a-8f7f-f51582f29cc2@roeck-us.net>
References: <2bf292d6-0f51-473c-bd44-f129a0b2a7ab@roeck-us.net>
 <20250731033136.3914-1-aosun718@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731033136.3914-1-aosun718@gmail.com>

On Thu, Jul 31, 2025 at 11:31:36AM +0800, Ao Sun wrote:
> During the device resume process, an interrupt storm occurs after
> interrupts are enabled, preventing the watchdog device from being
> resumed and functioning.
> 
> To ensure that the watchdog is resumed and executed before interrupts
> are enabled, Use NOIRQ_SYSTEM_SLEEP_PM_OPS().
> 
> Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
> Signed-off-by: peixuan.qiu <peixuan.qiu@transsion.com>
> Signed-off-by: Ao Sun <aosun718@gmail.com>

Did this patch really follow this Sign-off chain ? That seems unlikely.

Guenter

> ---
> Changes in v2:
>  - remove extra space, and align multiple lines.
> ---
>  drivers/watchdog/mtk_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index d6a6393f609d..7dc53409cf99 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -327,8 +327,8 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
>  
>  static const struct dev_pm_ops mtk_wdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> -				mtk_wdt_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> +				      mtk_wdt_resume)
>  };
>  
>  static struct platform_driver mtk_wdt_driver = {
> -- 
> 2.34.1
> 

