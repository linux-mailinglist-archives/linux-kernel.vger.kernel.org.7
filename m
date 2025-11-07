Return-Path: <linux-kernel+bounces-889852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894EC3EB08
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A86C4E99D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888573054EE;
	Fri,  7 Nov 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Gz/gXOQg"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BF306494
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499084; cv=none; b=RHpMXU49lVc2fm80WKVFgYTzZZgCV12lqEhcY+yJjokAX9QyKN951Cv2WAX+KD0mNDSUvdYv3Q8jrBoN+MmiNdYp8t+/yWxyfMnhjtz27Kra5hn4tCvIXhEvdB2GQScb6H9k3xT/tUr3q/2JLzKfie9cpw+WFcyhlxCyxlaipR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499084; c=relaxed/simple;
	bh=XtzOsbt2hl6xTu2IJUUbKD60Sc3xgdEK+LN2FPoMKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FycfPmBanhdv1WfxSqPyFbkZKd0hPhPO/QmsuGEN7k67r54bJ4jDxpIVAyPgnBZ7yD+4qbw9SyKxCMEcwxNTJcFnP5R2rfm4doOBV7uAQqE6RtQT4VEbY+0tCci1OnTwU9/n6BjEFZ8z1aKG5kFmcBw2H4JNtddUHWScq2Rm/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Gz/gXOQg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso3405001cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762499082; x=1763103882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYnIiKrQX8aCtjj//tDqMdxlWqP5fq15qVk6nPAkZoo=;
        b=Gz/gXOQgt+dwzIv+KSlNZ9YmsY0aUnJP6LxVbCZDaMfQiel5yb5nr8msIa3TLRFSJu
         tUQf9T/cXxxnYt9ro9XlGu0YYPoRbxA06W4rs+yDQKtKKVCW3j85YFgi71yb6kp31kme
         YuxDqNQbxjsPhRULRC4ScjuIHf2kErzsMZw5wSJor4n5G9hI2XkXtd8Iuc/Vn3YQyvGK
         4llkusVoAhduhwehwrqPBTdt2KI1U68YFh5TAXMu8toCiU8k37dWPufJG6k3oYIB4sjf
         DP+bfZBlz5cPwwZcJ4c8Zx5vGyuWehxR80ZgKaKwvYJlibs08StXOUUWfjgJcx5DgMJR
         E6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499082; x=1763103882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYnIiKrQX8aCtjj//tDqMdxlWqP5fq15qVk6nPAkZoo=;
        b=HkpGPgmWBw84d4H1LdErXLy2+S2bKSIC+cKoACoLY4ygpzJKxZOgKJQxqFWxN6fP+C
         6su3miJYfFbxrzAJgSm2SNbVRFyQPGHzdh+kpox2jBxs437evTe5x2bMGPA3CY+dIdCv
         65+44nh7H9K5Xhc8/yUX6fhHgwnbjDeeKjJw01fRm8ebl3AffOfk5MA0z2kCIvj3aovS
         h19g/NsVCkHPyW8RQGqf9Y6DUn9thAdJWgnrRPG9Aug1kq9Ec2SryEbAzWpSuDoGEJuc
         LxVXTQss5G2cmE0dLVq+3ZJSGgOzeXsFaQKBCrjhpGY5gDVmzgQ4opUctyI/29I+2bh/
         IbAQ==
X-Gm-Message-State: AOJu0YxIyZGSBk9jqaGAnchF0QbVLphDv92FjmyIBhg+Qmq19PZaNClj
	T1KyfFkMwaDYtmAh+wdKtzQGltWeSlx5554ki2vFtV8RSMIZ77YIbSEA19ZkkEI57J7/dPG56aG
	YDw7udU8=
X-Gm-Gg: ASbGncuwsAJ5BYQy9wOLW1TfB/dVTM17e7hjIc7cyRGJ9S0ZGWKtNLIzSuC2qqmKbat
	r66R9kxP5NaDe3zTq7qlIPR75zy7lWjOdHH9X4VHgH2GEkWyYxnu3rsRPMKrPEwfzTJATyF1vDl
	nKUZR6Wtt32QHQe6bk3LOn1Bc1hIZYcFgyfCdRJ9yb/tgGS3hz91HaK8XJK0ZJuUpVQNSNNMHpk
	wvJUe23GCsgNIdCFXIzYn4wnmhG+SHA0ui/mCZ89ClN/RMf+53/VY0ASFrYK9V5KerzN1aKUDst
	Ii/3xfVr2jSdwWt/fR7V1RWgTu8W8EVglnBz5mnj8QJh6SO2GOXVWwOTLb5MIGWo3IuLxmNc9JV
	vC5x+UAAWU8hDRcgyc7GpgBlfGo4RyLk9Bqp2o9h0SU+W7bx7W7jEyBfcABBqCbDVHnSaARm+Pn
	M5lGNrTeSo4uRlpfwPZeThijJ0KhgdAw==
X-Google-Smtp-Source: AGHT+IFwNzL1muZtb0IN53C7CPHVqzEIYh0SCwcsQzMl/w3PfdY3Ho9ZrT9AzNk7OQH5c7wzQoWICA==
X-Received: by 2002:a05:622a:111:b0:4eb:9c80:f6a0 with SMTP id d75a77b69052e-4ed94a4b3bfmr30924711cf.52.1762499082271;
        Thu, 06 Nov 2025 23:04:42 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88082a3ac4fsm34529256d6.57.2025.11.06.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:04:42 -0800 (PST)
Date: Fri, 7 Nov 2025 02:04:40 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-mips@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: PROBLEM: boot hang on Indy R4400SC (regression)
Message-ID: <g3scb7mfjbsohdszieqkappslj6m7qu3ou766nckt2remg3ide@izgvehzcdbsu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After a recent 6.1.y stable kernel update, my Indy (mips64 R4400SC) now
just stops booting early, just before when I would normally see the
kernel messages about mounting the root filesystem.

There are no further messages of any kind, and the boot process does not
appear to ever complete.  However, the kernel is not fully crashed, as
it does respond to sysrq commands from the keyboard (and I do get output
on the console from these).

I bisected to the following:
  
    794b679a28bb59a4533ae39a7cf945b9d5bbe336 is the first bad commit
    commit 794b679a28bb59a4533ae39a7cf945b9d5bbe336
    Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
    Date:   Sat Jun 7 13:43:56 2025 +0100
    
        MIPS: mm: tlb-r4k: Uniquify TLB entries on init
    
        commit 35ad7e181541aa5757f9f316768d3e64403ec843 upstream.

This reverts cleanly on top of 6.1.158 and the resulting kernel boots
normally.  I then reproduced this failure on 6.18-rc4.  Reverting
35ad7e181541 on top of 6.18-rc4 also results in a normal boot.

Let me know if you need any more info!

Thanks,
  Nick

