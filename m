Return-Path: <linux-kernel+bounces-890625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010DC407A3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CBC189EE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3D31BC96;
	Fri,  7 Nov 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5d+RdEK"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0983299AA3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527184; cv=none; b=mnG0K/lqkiB1zXGts6dufGONX+vX19GEg0OKzNC7qKfnCoIR0NzFyVyj/O46IHF37Jf06vIBN0FTX8HEP0f3WB5ZdtOn7/VTn08hZRh4C6SPVC4P6N6lZPFVf9NIQKc6jMk8awk0J+bAKba9EYARcEMOcQrf9IfH/nNm5ZRIxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527184; c=relaxed/simple;
	bh=YQkQ7XPdO4hNTkZQq7//2nUwn3fd+J33ogVkcO9JVAY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=itoa3+IkUIuMQddOG2ukauU3LMmEw7+OAkDHigGN7TE/xEgRgoeZQ2lu/eJ773+zxvY2qSfCp+FMDxqWqTj0xL+aCWspjPE8GKiarNl8ejOcKVSRa/2cUGN79DHyBvGoTcWsM0WOjKEi08GdVz7BsE1bAW8508y097MsFURosfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5d+RdEK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594270ec7f9so860589e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762527181; x=1763131981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+M09XUTMgtx+lKklusk5EampcKYqj3lhBLmvzbHNCl8=;
        b=W5d+RdEKcgfjiuKRuBQgb8O3op/WfK101UGDVR2zjnpVPm3uYctaQZZrbZpc+0LyMT
         iUUUj+YB5vDbBp9wmJr4MoWsfFHW6zBs1PllkMIhpjxN3PLUj4HvvgzBNORn2I5ukPg+
         uYyYfMhsvwq0SFN+3FQGqnBZr2+bFcgGAY/LOr2ABxBX4BCy83AgCVPRUgc2sStNtm/7
         mx/YtWHPDKAdBsBbMQ96xzuwyXgP/vhnpcK5bX2jV9Z50M8zyLtwu4AKZaWWHJX3RUWc
         otDMBNntt7jY82bOb5ysofbAz3ww6B7HeNbyl751gZNZKgFwKzrYMRAZC+dShiRFDkXA
         di9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762527181; x=1763131981;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M09XUTMgtx+lKklusk5EampcKYqj3lhBLmvzbHNCl8=;
        b=R4BpaQPkTYIGrj623vFAXDM9aDg1OBAMFsZ63PmEd76Rd1yMUKRQQFmgWui67Ry/Uo
         Mz+ziF+BeaaXTgajVCoUlLokApTIGPtli/OLhEV3AnS1qz0yHSaKKocbeZQH1aKxaDJ5
         Ebzs5BGEjcoWWDmgVkRP+ixzOwaS6FdWkb747sdS/dBHHfnRIBvpP8aZXuTovxMXpy+X
         J0nBQh65r+otWxRk14704LwonlX/KC+AtZck3YO7FWL4V3Ou7ebhFlTJ1UrqmGvVCMEr
         fr2RXKO3WgMXRwbo+/cDh8PJvT4f/1UUhu/ITEnjime3Gcs2uPJWVdoh9eE6j/Wv4+Cg
         AARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu0mh1++jFEzLdDHUDg3t+8T14t1DEvQBl8NQSnyUUzn5IZSEi8a/3ypdVCouyo4Tth5cs9pDtNsn0cTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmIsO+tD09fd86/b2/QGdQ/7cJflWu3f1jb08fszmR4hW1wIj
	fk+3WNxsnAxmz/M2iwS9lI2tr0XycdqhTDb00FBeEDkaU4dYwemwiRYBlD0qn2JW
X-Gm-Gg: ASbGnctTzuwSlBbKzCTl9+AgrvHubsZ/IW9DVWr8S3zX08KpCGjK6ZHI4ZWI2letaVa
	czrMxVdUDcro9nyrBsr9xvwTbNWzMwVeCi3FE3wUf/eeTJMR0g2M9gjEIVF4L5XQIHVDFmUveZR
	I455RMqdT7roKc6ipq5wYPELAJpknqqgIPCgVNUvGIwMfpVId7Unq8imvf4hL+Pc4ISi+4RrtLA
	KKSAAUX2RBE+g/4mOY2E6ydLtrKMpVwC0waRC5Uz4MXDnvUGj0MaIbOJkoaSt0jvEuCryk+NEva
	LYdOTCIugPCyCa4ydVcX2N1y4l2XZPJCHHTnkmfS+WhLSQKlroczHtWHJG3+Q23KieOxiwyUtAR
	5ZH2YCmWFjnRdiTq6OqjE1G8XufMmkuJ7JwNblWUs4IYgIdFuXGHugv6ox7ZRY5e0UcMpwg4a3/
	eYySj6QIkKyTILEatDDFCahei0oDEVfU/ND64=
X-Google-Smtp-Source: AGHT+IGp6UMrNwuiQMUTp+ZIbOLx2/hQ25qMledh4yK/R8fKpze1BMW2NddZDPNOXGTDoT2mcdbQxg==
X-Received: by 2002:a05:6512:2209:b0:594:2d02:85b3 with SMTP id 2adb3069b0e04-59456b71679mr1269732e87.8.1762527180511;
        Fri, 07 Nov 2025 06:53:00 -0800 (PST)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019efesm1488014e87.34.2025.11.07.06.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 06:52:59 -0800 (PST)
Message-ID: <68ad3747-a912-7644-d9c3-e6137da4e555@outbound.gmail.com>
Date: Fri, 7 Nov 2025 15:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251106163048.334400-1-marco.crivellari@suse.com>
Content-Language: en-US
In-Reply-To: <20251106163048.334400-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marco,

Thanks for this heads-up. Frankly speaking, I wasn't aware that the said 
calls to alloc_workqueue() implicitly bind the queue to a CPU, and this 
was never my intention. I agree that the better choice is an unbound 
queue, at least in this case.

This seems to be an example for why the API change of alloc_workqueue() 
is a good idea.

As for the patch itself, it perpetuates the incorrect choice, so I vote 
against. If anything, WQ_UNBOUND should be added, but since it's going 
to be the default (soon?), maybe just let it be, and let the planned 
change in the API rectify this.

Thanks,
   Eli

