Return-Path: <linux-kernel+bounces-736162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B3B09992
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52301C46277
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192435959;
	Fri, 18 Jul 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEWkBpxi"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA6BA27
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804167; cv=none; b=laFX7feTxKemO+x+yEX3jQnU1bKz9XmogzkhoLK8WFSMjFrg6hmAmoxmxLQ1Gn/7M2rxGygR6MgiOt7gI9qzIr3p1VLFHOPZAF0Duk8q+jIJ9Y8QIoikcwtgrxvu0K/+8hCVrXe/T2k9lOLLCdeAGKpMy3//8Ox9xu//wWgUb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804167; c=relaxed/simple;
	bh=tItl6Xkm0myXhSrQP9N9X6CM9SpkzyyAffNHX9OFsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsjwqAfm8T3qJuHHcClL/JXVt3lGosiFoYx7r+IdXQ6QTFrAfz7/6CYT40ozGFOgnPrQ/4vfQpCxzTdAaJLQxZ3e5adUWW8anPmSdYHHb0i7ezMOsFE/XWbjW7eDlAbgezxLZZ5A5Sevfxuaax40oYQcGOhyT7fcoub9/ScH3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEWkBpxi; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e810dc22dso338444a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752804165; x=1753408965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQIQyKdRFgYCxy5HSe3Ua2IVeutNacTw7X3cVK/drF8=;
        b=qEWkBpximHG68cQpgnHdGbpMPHmBCTFCh8BRX6gSffbfpU55ps/tHsZ7ft0ry9o1Hl
         IQ7Fen4ynmLzwe1ORYlUiCuup11QqSHvl4eVRP/xJNhX0RevkhsBdQltmg4oSCxgu/QY
         ooFNF7Ysz3B3gG4PNcSiRcHA3HchH8GWVFr01TDwz2up1qUq2us3WKMXkSHOUsiiFsQn
         yCeXjCiS6LVP+1fuoBs0gRctY/7Yv21XfO3slCIKXCjFfcF3Klt72vqfmHZiJBYkZzwG
         4ZovJfM6yA039RZJ9BnV/OVmreN/BOGO0AHBYDjhjCX4MSOYNdSwbizuTw4D34lRRBin
         WToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804165; x=1753408965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQIQyKdRFgYCxy5HSe3Ua2IVeutNacTw7X3cVK/drF8=;
        b=sAa6zGmZvQEEuNqswHFJfECPUxGNbb8HCKu+kv9lgSh3m5PSA4Vq4sZN/YWrUGq85c
         +DyvIbwcSldHaUhhbTi0D9gG8gQhbNa5IjP7k0BlPLhZjKB8Jh153LnS0Dyq1xUotdW8
         niuk0IVl0eiYz4Mdo6B10PM2eMWa1dKEG0KUsGjiDy535NcGmCGKtHEXT36bL7L6n6PO
         J3gFjxT3Lr5ryoCK2uZISl3u2E5lzo5DjKRB9Zt3vhrQ/kFpTsj3sPEpa3eV79hv67l5
         LQMyXMB+hFhyRJfo34rqfG/baOFKRODPMotSl2PqdDIvm0Tr8k/Ywcy9erzFtXiXSKnV
         wR/g==
X-Forwarded-Encrypted: i=1; AJvYcCVITjOUOlFpfXZ+I45XHL9WsDBY+7Gh/3bLtJ7f6LzgRoqgRrdw2RPRoAtgTfeq4OCUdxAyegCvWmkGAJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7qMCAlE4O+KkNcpaZAtDXKUWviM1V9bfry5ZWAT0nBqrPTRR
	7wJ/rNUmguXaZi3mcbTIjb7cfK7Uz9Kwf1COWJebJhTP+X+lW7Yn02R/Tw6GkU8qlbY=
X-Gm-Gg: ASbGncuuXsHLCkXCmh2FLcs4zOTUlRN7Bq0Dd7EL06RdcgEf7LmnZMGQKoiy6QWPjv6
	905MESGzfmjWNGJiz+98cJ6iZkZCYXHHEDSKoWGCS8Q4vva0/WNKv32xHEBHkjjwROqS9WTAe3P
	+KRQyLEUJ0LRn75RemJglPWoyqjJ5P+OiDCLLLqGSY+Kz//+Mrb954XR/f1NqgAuF5bLCmwNhNk
	s/UMkBRZKGtRzCvOdIfVDha+6a4pyLkO8fcruuX/c7ZHz0hDrR7ZSqReXkTcehgsIaBQUm/g/qL
	Z1jKX4WnQHGk+IDYT41CWfwsB4/eWNjQ7lguJPxa1De410+umeA8Djlm5VExlGCiUP725nnnouR
	FyHSr+PQkeQk7xLc6NnbCI8sk57R1
X-Google-Smtp-Source: AGHT+IEI8sBMyOgnw6y2eCUr5fjpT0b/Hn5vFbc1u562p9vD1WxLFCBfM5OhNgbekGnp7NVxtkJ2pQ==
X-Received: by 2002:a05:6830:8104:b0:73b:1efa:5f6d with SMTP id 46e09a7af769-73e661974a1mr5923482a34.16.1752804165130;
        Thu, 17 Jul 2025 19:02:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8367f410sm249912a34.24.2025.07.17.19.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:02:44 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:02:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8192u: Rename ChannelPlan to channel_plan
 and fix index name
Message-ID: <6c0d6a6e-4b47-48c9-acbd-b5dd33fd0001@suswa.mountain>
References: <20250718015525.162561-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718015525.162561-1-vivek.balachandhar@gmail.com>

The rtl8192u driver was removed.  Work against the current code.  (Just
use linux-next probably).

On Fri, Jul 18, 2025 at 01:55:25AM +0000, Vivek BalachandharTN wrote:
> This patch renames the global array ChannelPlan to channel_plan
> to follow Linux kernel coding style. Also renamed the index
> variable from channel_plan to chan_plan_idx to avoid
> shadowing and improve readability.
> 
> v2:
> - Fixed Cc list to include Greg and staging list
> 
> v3:
> - Removed EXTRAVERSION = -vivek from Makefile.

Heh.  No.  Still there.  Slow down, there is no rush.  Let people
review the rest and see if there is anything else to change.

> @@ -145,12 +145,12 @@ static struct CHANNEL_LIST ChannelPlan[] = {
>  	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, 14}
>  };
>  
> -static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
> +static void rtl819x_set_channel_map(u8 chan_plan_idx, struct r8192_priv *priv)

I hate the name chan_plan_idx.  Probably "chan" would have been a better
name.

>  {
>  	int i, max_chan = -1, min_chan = -1;
>  	struct ieee80211_device *ieee = priv->ieee80211;
>  
> -	switch (channel_plan) {
> +	switch (chan_plan_idx) {
> diff --git a/init/main.c b/init/main.c
> index aa21add5f..648589720 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -680,6 +680,7 @@ static void __init setup_command_line(char *command_line)
>  
>  static __initdata DECLARE_COMPLETION(kthreadd_done);
>  
> +

This change is a mistake as well.

>  noinline void __ref rest_init(void)
>  {
>  	struct task_struct *tsk;

regards,
dan carpenter

