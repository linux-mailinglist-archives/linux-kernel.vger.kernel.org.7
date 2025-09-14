Return-Path: <linux-kernel+bounces-815486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8FB56729
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B02189E4A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839421FF4C;
	Sun, 14 Sep 2025 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqJyDFdI"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42E1E503D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757834422; cv=none; b=QXwGGPbnvNybBjfmO02pyLoqthDGpfLx3AjOs3WIimFEtVcF5UPfuIdOgW9NGhoCywJh6xzwO+/E9lVed/Z9XlI65i0Cv7Ac3+DQ2T6tf/aLvZ40Y2FLkwuBrfOULX0McTcT7trHo7NzRSz7Ed4hMc/ndjDWciX9c58XtA672yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757834422; c=relaxed/simple;
	bh=WxHbnp3mXY85vHOyFqflPsDdFgmpqdsippjcQEzh6k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMf5F+oLTSpKXGOerTPAERQhwgOvVkIir9upaMJj0uZUggNj4fz+RPeavbwXczmuczdykHwNLrDWXXpC1WtRlNiRgL9tRy6ZJQwJPbUVChSpVko6H8Y1fQj2YXgmoR2PDHhZ/up6eTaCIDl07qqvxTodcAXH5T31U5Qd3PKBuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqJyDFdI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772301f8ae2so3030771b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757834421; x=1758439221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOgfe+9uFa1Sef9wrFS81gpUBs8pXU8gTxUAzr2W5PM=;
        b=ZqJyDFdI/HscnUlKBH4DfmknZONfXAFUmYD1blLC6PoMbehWZ8akX9AH2JC0+upWRr
         bRhQslB0byyxeTtNdiEHmSobANTMsZQ8AkDsvgrQCmYNH8QCXhdBpcoAemDFYjTV/y1y
         OEDm7137G8r0SjTPoglK/U48uzCR06hv/0opygdJAzmGo+99jq3I0E3Xg3RZejq+N/9S
         rxK3MnF6mSjjTLj0LvgpsrhYcf4x0PeKNqz8QkQGkx9V4Pjhu4aWF3qe9KXb8c19l69u
         nR1RSd2EsQ/W7KWng8YVJs0LS3dyc5CI7ssZRK/mmobebbhmkW7uEBoNfW6b2JjI4N4W
         Dw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757834421; x=1758439221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOgfe+9uFa1Sef9wrFS81gpUBs8pXU8gTxUAzr2W5PM=;
        b=IiLKBwP+3k030YO0UOn8VHhAbSCgIhoy0Qbp1OFVktAtFtrossiylT3l2GMxYZNItK
         CvzPEvOe9gm1vYrDwlCyZLAiCjQaf8egi/Sa6RGvpuNpQbGJ6087cv49WVXOj6F1Vr0l
         XVDmn46HnoVCxOde7O53Urdwu4voy6g4o3qkaNpTaHFteQ/L7sp7OlfHaasJva+0xsg1
         XUN88O26QxBzNCikZva1+GAr16m89OBggguQ7toOngMv0irOgHJPkeH6eh9iVYMtpiqU
         n0eeuzidTTRh4yM9/1Fjwj6Mx9GIh0XNDk92DOVVx18rLV4l1IUhsbCGl9MzVU2sgxIv
         K8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq8A5KFBCHlbSCyIiTypKP0UexDFGgzNrJabLd4Rkfb2J6Ewtj8fmZyKzLKE0n4HNca5GDhLKJZVfpAMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7z1sHzh5k5/hASIoSg3S5o6GxL7nqmy3WogvSh/ddm3G/2gB6
	jQ56fzrCgk1qd7irecS9Iq3PmU4M5mX4L655pChKLnjhAp2lkyX/SVTm
X-Gm-Gg: ASbGnctMyAFJ98vS8O2LCx4rxyO+ERsBSW88pOC7hjISiLtKxUKtI5yvJn9oOOv/aWB
	24NbKkfEoqCnsGTZ8ZVQnCLV5F+amC+04jYMFp4T5LGWwceX3iQj82MRMLgy7NbAAvuKsRHGmIX
	5nWBxWBtVMOMFOptupG71KiTbvP8ey7C/Q/8Gmei/t/kmLzpIAreuDpVuLNj7AHwO52Fk8gBgFn
	RMyL3XuZrnSHzKNQ10MsUrTqdy58KLNAqbaEIrrhcguSOHsjSXoVgYJ9lrxPFWy5Tku2nhRQSUs
	sZW2qrmQvAXA9ee3nM2mPWwjNOEKeFoP/wjlEtIOCK1eA8zlzE3Df7tF0kWMGCZ+QJRt7gW3ar3
	/kUiGPfaPJG3dy6swEYOcZ4k9/kaYcBYqUndfDCEhn1a3
X-Google-Smtp-Source: AGHT+IFt34+1ICBGiFFGL68L8S7MvtUKg3hTKrfZfT1RYdTndglwbOB3Hevxm6aiueGdmtq9q7ufrg==
X-Received: by 2002:a05:6a00:4405:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-776130fe348mr8620872b3a.5.1757834420608;
        Sun, 14 Sep 2025 00:20:20 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47601sm9815891b3a.28.2025.09.14.00.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 00:20:19 -0700 (PDT)
Message-ID: <b81b16da-5031-4c26-821d-e7bc564dac0d@gmail.com>
Date: Sun, 14 Sep 2025 14:20:15 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
To: Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Dante Strock <dantestrock@hotmail.com>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
 <61249b3d-3996-4d9f-814b-3794aa42c40b@infradead.org>
 <aaf3dffd-cc88-46e2-a65b-a1ff4fcc6eec@gmail.com>
 <5fcf5f4a-1bbf-458e-8aab-8c66d326fd17@infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <5fcf5f4a-1bbf-458e-8aab-8c66d326fd17@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 13:10, Randy Dunlap wrote:
> Do we use the word "supermajor" anywhere?
> $ grep ...
> Nope.
> 
> How about we call it MAJOR (like the top-level Makefile does; well, it calls it
> both VERSION and MAJOR[1]), so use
> 	m.x
> 

That's more sense (and that is indeed the term I use in the patch subject).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

