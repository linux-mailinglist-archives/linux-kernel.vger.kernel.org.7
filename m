Return-Path: <linux-kernel+bounces-842332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7894BB9852
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79BC04E483F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342E28B3E7;
	Sun,  5 Oct 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlDwNLpc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14E39FD9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759674959; cv=none; b=JFOHaYXhgiS6tGydSwRyb39DAuEdpSiCDXc1TgUKMl2GkahdLLaJ+xXyClDy93atnXjDz9asuYwTCbrfV/E+ebqEyz7wLj8AzJs5fee6ZpcQFymOznwKMySFp2pmVDXn0Zpw5alTHW2Otor3GNovKoha38eBQ083v2VrGl6LWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759674959; c=relaxed/simple;
	bh=zDe67UY7NpeGg/wbQ9zGu4W3ffeY42m5n/D61+76cXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQZs/qAqmq6IVThLAAZf5mpay9+YR4oTI6rof1YxHrWV3U4zj4cJApkLhnzlxMtuQB2uxtyWzF/pMQXQfaWhDED2qE5Z8HycKmssOGaY7X8PqFETLMCOD4YRWbpaei5zj7nSpEAPUXGM9uTCEbj64HRRx3WQ4f/O9BoKngtWgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlDwNLpc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e44310dbeso4495935e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759674956; x=1760279756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDe67UY7NpeGg/wbQ9zGu4W3ffeY42m5n/D61+76cXE=;
        b=XlDwNLpcQudxnTo6AzOoDZoVRnzpE5YDjo/Q5AloOvlZlxhHnmSol4kV5NJ2nEA+CJ
         GaQxtoyVZ4M9aow8EmYdLSl3xyQo0ewzsIZoRpODwGb4C86dr1lcTbyc6pSl91GfYWCm
         15LDiZ/sQP2R8BxC3/HRuq/37ElgifH+4ofjL9yI9Fco9nX6rYPcarAfYuzmPFRuKFcv
         Zf1fiu+wCloYIXpfVvozbB7yhGkj+8Kv9Jyrym95/kfiz5goV2cJGCmuc0WnScLPyPNN
         wGAQxFKFyvU3NmF1d+KaoS57/0wppz3BrUjIs4xVnMsuYX70Tgcis/8+L6iljQnFQa28
         qsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759674956; x=1760279756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDe67UY7NpeGg/wbQ9zGu4W3ffeY42m5n/D61+76cXE=;
        b=kIWFpIcELTsQ6ODJH+DeAie85PldezCckbNSHZfFyqyhc4LSY+QUxLIspjea1U97C6
         UITDlgSqcLn77+JCSBHtRKQdofy6nal7RGiGN6PjKs5fXyDPO8Ony6ABZFsQSJ4NiH6f
         LSfQGa20CFPkEr+dYFkMuK+PIYWEDGJExcRMP5PjCpsqJ7qb17U9/yQPSF87gVX8Qiko
         P62taCd1BdliKyiRpzzqhP1GPK5Ej3MO/Rt/LxxGT7yH1PQdG71SIig2Zr1yVoSqAx7W
         NK1sjxruEdk/YR+BqFUJbBTSejd0YZ/jH2grNBBGBEb+FNWXAIpinisN7qJwOZd+gKrF
         sSVw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZocSKKvZWe7mRFKaDXumVkXl1+0wrFB1tobUx0tzyauBkiDEWXF7JhHbtt2AmD73Wl1tbwA2zqt7FX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiST4IbHzpaV0V4BJkpK8qlfraVu58XqY9HIetU8tTVzB653C
	oIQ6B7hYbxcdVT8vUHHfM1vefDPAZpUkF82I53jxrKnMW0Hku3IDiZU=
X-Gm-Gg: ASbGncvgbvmDzRo9gBWSynCCChIizF7expHNvcxq68tQS7v3eBbWmFkkbQ+Om8ZwTKj
	3/lQjgTinm5YIBkhK/f0Hj2D+0wnB4l0SP/bYiDjpKDELyhckGgCWPOAxyNs7gLNKawyICtL8gI
	iLJRrcsDaAwiRdGmxiuSJsvxsjZCIROlFtvjam4WSehOJfuRFWwEwQJjhtO0wFRY/iWT6gZYoPa
	lYkegVIyDSnlGeL5KDwq5p21xFjMfzb3nu69jGq2nhPD8pMQDkAeKLp4Mwtc/0LPRvTYiTPg4ql
	IDYLk14AgDrGX5Xr2tug70q864gfI6lmU8p/2H/nfY59Gvyl4ZyFK0pSm03Zk26diX8uqMzqBBr
	eAfzc5+n72ufyrbttPnWct9CPVBDoDJ7xTfd0Olc4MyH2qqKzvEx/kRFJpBT2MJrIFqEkHaj7P/
	TlzAR/fWg3juCftmk=
X-Google-Smtp-Source: AGHT+IFF/tcphPQaFl9WxbUX5nK/UfwlNAnh4Seu8uadrvAi+Z5E3ElkD60UrxjzsausRc7k00GIKw==
X-Received: by 2002:a05:600c:1993:b0:45f:2d07:7bb with SMTP id 5b1f17b1804b1-46e711436f1mr32591605e9.4.1759674955514;
        Sun, 05 Oct 2025 07:35:55 -0700 (PDT)
Received: from localhost (120.red-80-39-141.dynamicip.rima-tde.net. [80.39.141.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e58asm114549945e9.7.2025.10.05.07.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 07:35:55 -0700 (PDT)
Message-ID: <22502d77-81eb-4374-b8b8-d8a954daf859@gmail.com>
Date: Sun, 5 Oct 2025 16:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] x86/microcode/intel: Refresh the revisions that
 determine old_microcode to 20250812 (Aug 2025)
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86-ML <x86@kernel.org>,
 KERNEL-ML <linux-kernel@vger.kernel.org>
References: <20251004222528.119977-1-xose.vazquez@gmail.com>
 <8F0DE1AD-5532-4581-9716-581FB2777404@alien8.de>
 <8826a146-ba01-4f97-9fc5-7bf42c1e768d@intel.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <8826a146-ba01-4f97-9fc5-7bf42c1e768d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/25 5:58 AM, Dave Hansen wrote:

> Xose, do you have any specific, practical reasons this should be
> applied? Honestly, I don't hold the "HIGH" Intel SA rating in super high
> regard.

> In short, why do you care?

It does not seem relevant that the kernel displays obsolete information.
It's that simple.

