Return-Path: <linux-kernel+bounces-847219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E13BCA446
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD264EB2C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DA23CEF9;
	Thu,  9 Oct 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KbUa1pDY"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00922B8A9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029017; cv=none; b=ZsWzLvicUCP9q0C445V+a5emvYKJu4mQokoN7h10OSbUoL42NVnFYcPGn7bUJNGRuzQ3loWM1LCE+7Lx1OBZM7N2EFxatg2c1x/1TlglxJGDnDvzkKtfQ5mevGXqzgRmEKmcKa7E8MLd7gTGPaXKoi1a9ZwaKbkuhmW9h3FkDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029017; c=relaxed/simple;
	bh=7LeqwvthghquRc4FKiC1aJEy+UKkUTQYw9KjjVOShKA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=g0a+XTCQO+V2qcRUV3iiLgC2tyRPRNyXyamL8gPLG8q7yVDGVjOcQAZOfWiMjTj5WLJ+O7G8bWx9ibx/u9lT16eQG653ZuOPd6DZNNSlCDbE7ll/lZKDC73I4pgpCvXT+4Akaf10MNpGVdv9crSA4LmNTLUNuVRJu9WNH64OP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KbUa1pDY; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8c3414ad279so47535639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760029012; x=1760633812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dgrxHtWEHMr9Hmc1PtIDiyAxbzIwd/8rFxzt/ZgVmg=;
        b=KbUa1pDY3XbT5MArVAh9BLBJWP71y2g2HCQCEOBmnjTA7YHV3y40YcVRV0OLmTQXY6
         ifhsIWkZjpSzOpvliWdvXt3vRP0+0w7qzDaytn8mR0Hk6nBxZccJ+GL7L3D+ssLsQ3X0
         xvue3HJLF+ArK8WIF6Zj/r1Ujo/vDQmqLi//TQ/W1joGNzJpCx/bp60efBRl9cdQGoPU
         lfbaWxkm0n6bxCwLu5AubmZOTZ6iowjHWPpZ3bhubHcuHUDhTwDrLwlCT9NheZmUyrue
         Md0+7cXE520KKWzhqXv3yNEQoiZMdSt1JClKBaT9mFSPCbAomwUyq8VS+ZHFG6R2kMRG
         7ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029012; x=1760633812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dgrxHtWEHMr9Hmc1PtIDiyAxbzIwd/8rFxzt/ZgVmg=;
        b=Tqf8TDEipRKuFcIZhoV6OEgw3UjmoDopcBkPPpV7MwK+is4mMo5RlPbj+3UovFUX55
         OSgZZKmQWK40yOAFLI5sL/M93FiapYfGbpLRfO419tG08K4D2CexHHHQC+GulVRSF5Gf
         +N7kJ1Hj1Se4lxkTE6FPuAiuGl7FUeRiraGN2lPvmDh1ST3Iph9T//cyap8m+Kb8V2af
         1sx8nUxGbP9JlZ67+Mn1jirs17zN+LxBTG5deOzlqWIS/jpqoipbURDd/HUvN+VeW6W9
         9TKCsSzpgRwbjwC1OguFzXBbgI7w1X0iOQNH0ocejIowr/NC0MWrJBdxQaTePj67dWVD
         yoQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYfoD7wc1tW3r3d+Lw3N7coXe25CZcOMHWFRbSMlA+vMxMW/V54FkKMW3cIpcE+xmY+IkCM8bgp/yKuXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTD2Lf9rc33Ytl5/Ipbp0AxO0PRG7g9u91uZ1k8M1qvZKRlZD
	R4V2ogl0vePtkRXpvUgIAlxGG06BPvsCgztl7Z7Na1t+lUWRyaW3zkTU1zSf8qNq97M=
X-Gm-Gg: ASbGnctS9vAOEn0G42Yyw0FmO7QXUPR7py7tQ7YBNVB9J4auzfiLDqXzjISsgHcbutH
	9ciWUyRtedxufbtUghD8n7upo6bfkM5LdMBQ3xK+85p8hv03MmsjN78RmhBmTFVMB/dvMQO7bWA
	rhYIZmGgThftFo6SAm/3RhNnd7IOosk7gwyY1woDDDGoZzq7RJ/j8T2gou+c6DlAqVVJwB0pBHb
	KSIa/CPImJjuBKFsRF1r5NBqO+yJjaDTXAt9LNvqBYqZMfxbxS81PPckcpvxjI8iaYr+eX9ZdJO
	3wSAyJmox60fLGRMhjUfBoQsUmQpbJnrJrttUbOIBIx9bumQTOonxoFJQPgyf6iTJmdLgp/o7K8
	zBIrUL42bA7+FlXrOVyDeIdfUQkI4McsqJSmjXRuBquLXtHWOYMV+XQ==
X-Google-Smtp-Source: AGHT+IEgeZHB6dQQs+oiJlME1XwSt9GSDpkhuFy9/AtMSMVQtdVWxxf/2QEIM1orGKsmnZ+Kjd8wAQ==
X-Received: by 2002:a05:6602:13c3:b0:8a3:70e4:9abb with SMTP id ca18e2360f4ac-93bd166e931mr927048639f.0.1760029012145;
        Thu, 09 Oct 2025 09:56:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea3132fsm8352370173.26.2025.10.09.09.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 09:56:51 -0700 (PDT)
Message-ID: <b64194fe-59c3-4d61-bbf8-1f9494b91dbf@kernel.dk>
Date: Thu, 9 Oct 2025 10:56:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_waitid_wait
To: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
Content-Language: en-US
In-Reply-To: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git syztest 

-- 
Jens Axboe

