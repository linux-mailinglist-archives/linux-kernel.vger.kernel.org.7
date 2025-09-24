Return-Path: <linux-kernel+bounces-831242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEDCB9C2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1993A3E59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937A329F11;
	Wed, 24 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIrRoIkp"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4A1F2B88
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746651; cv=none; b=d2crzcl5HDsGvI+l1mikfTsVGlfRm0hlCDWsBcGvfHq3fG+xIu1+lPIHx3d8bTtCkjAOaqh783ix6vHZqimtfP5R7TYlRu6Xlnan3/o0+T+C/8bdYfgpcKh2O4xZdYTW6cDZSa6k6Jo8gyaf0QpvnUaeNHkvpn4lNzpxGVjmKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746651; c=relaxed/simple;
	bh=hQCFRrzhsxkJHd0T/Q9S6qEGubOT9QVFnmKdp9gdvUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvv+dzNfhsDNt5y17KhCuVz05ru76AYiCQVI1w3sKV/JSyvF4AmgeVjJXlRiXGsPWXPlSXPsEpJPNiQmOiEYDrThv1oM2E3bQYTqC3ns/BdEOxb7atGaqqgIbHaS4spyE8hf3UmC/X8g8CtzCbezDZSc2Y9CB0160URxjNEs540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIrRoIkp; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42575d462cfso1431025ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758746648; x=1759351448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcrEAJWpZ6b2yow/2Ry/2Ua/hb8QLxVcxAQFim6ANQ8=;
        b=RIrRoIkpoJVXb671IIc5NYRdj9v0mZqOk9ayk1rrwF3RGWh1LQ1kTQ0wkY/LBb7VYq
         yP1g2a1cq8YMTHJ3WqfIdC025r7e3fRHknKwTYvPP/3JCRSM/MInvAZSTwfg8VCHH1+8
         onXmUnfSwrqEiP/CNW/9zlI6hAM7HuH2wGxXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746648; x=1759351448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcrEAJWpZ6b2yow/2Ry/2Ua/hb8QLxVcxAQFim6ANQ8=;
        b=Hx5VO1Sirg4wM53laagAtrnhtbV2v/4Qeb2mQfKJK/WXGEWLAFXkKa92qH27rHUjUh
         vSM74UiO845iqw9Nu/32HeHIsy8aZp6+cBNLvJJ/JE6Z3W200iZRlLWntIIEXlxjGUhr
         FWIsdQF+SfsCP/jnZyEAKVeZ4lkosQSxZFqL77qHChsgfhujtcouQwwyP/mhqsSZTqD1
         9G71EW8HQl3beKFsyLGcVA6YjnJLMs5OM1yjXWOphirrUb4e5GjfyCzT6ikAiWZSj+Or
         YAtbqAnF3We1yiM0E6N63ba1T45OlksF04e4xxJUeQMcRz/QWncrd3kMSHe/Nf+bL8aL
         U02Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5O97J3mnVvtztK100G9xla5z85CypGLgP5Z8glLpxSQDQaog49GAfYO5iBqHAFeHJVnhAGZKCPaX1Bp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BpB02dF1PvBr4vJFqgYf0qB0OCIeJJL0l4yOwjWPTkDvhmm8
	XYfdV3WGT/HgAkEWrfkMAp0BPzRQVmZ+7rfEs0ixkpqoUxIa5/l5h28Ol8i3vZMCl8o=
X-Gm-Gg: ASbGncvRysEBC7GbDYOG1Lia+NSeQiDM/iwbgkGCqFjcC/5fwofoojW5h9/i+WZSaoq
	/UjZhG8k5nO2UesQYHCnOWwFsKzRB5qs0L2rCdNUGVQAfEhCxivy/SU9uvDTgmMN6D5auWARdqS
	bVHDqZD39ljXCXY8gtlTtisMeI1mu4slsUM5sRloUmGLR5BIr9E9kH6zDxcawSxqTO2gyHWzuBc
	2LyEPsdRlwbu+cL/EKScEVCIBft81yj8owfMFAcqzFdkkh7gaNsuFo1scOeP5Ansh/1/UC7sV0Z
	tGzcO4ynnOtn01yxcokWDYWbmDWr4WzptnCGb1ZH6o2HItO07u/sc7ivFTWVUcyIggOtswcGTJ7
	eiDmEDR24qNY0jxgq/N7Q2ST82EMivw6kTR0=
X-Google-Smtp-Source: AGHT+IH6BOgqWB0moCn+1AYSvMLjM7sFyc1fdmL1yRzPltIFxLhk4VmMqY6UiuwyzQsxKt1prDWQ1w==
X-Received: by 2002:a92:da4d:0:b0:425:9531:821d with SMTP id e9e14a558f8ab-4259568ff27mr11778655ab.27.1758746648358;
        Wed, 24 Sep 2025 13:44:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6b14cf76sm74458173.80.2025.09.24.13.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 13:44:07 -0700 (PDT)
Message-ID: <eb86ebd0-71ff-4c00-a524-0046b86b3aa6@linuxfoundation.org>
Date: Wed, 24 Sep 2025 14:44:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] USB/IP VHCI driver cleanup
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 05:56, Cristian Ciocaltea wrote:
> These patches were initially part of the USB/IP VHCI suspend fix series
> [1] to address a bunch of coding style issues and make checkpatch happy
> for the entire driver.
> 
> As suggested by Greg, I'm sending this as a separate patch set now.
> 
> [1] https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Cristian Ciocaltea (17):
>        usb: vhci-hcd: Ensure lines do not end with '('
>        usb: vhci-hcd: Consistently use the braces
>        usb: vhci-hcd: Avoid unnecessary use of braces
>        usb: vhci-hcd: Consistently use blank lines
>        usb: vhci-hcd: Drop spaces after casts
>        usb: vhci-hcd: Add spaces around operators
>        usb: vhci-hcd: Drop unnecessary parentheses
>        usb: vhci-hcd: Fix open parenthesis alignment
>        usb: vhci-hcd: Simplify NULL comparison
>        usb: vhci-hcd: Simplify kzalloc usage
>        usb: vhci-hcd: Use the paranthesized form of sizeof
>        usb: vhci-hcd: Fix block comments
>        usb: vhci-hcd: Remove ftrace-like logging
>        usb: vhci-hcd: Consistently use __func__
>        usb: vhci-hcd: Do not split quoted strings

>        usb: vhci-hcd: Switch to dev_err_probe() in probe path
>        usb: vhci-hcd: Replace pr_*() with dev_*() logging

I acked the 16/17 and 17/17 - others I don't see a reason for code
churn.

thanks,
-- Shuah

