Return-Path: <linux-kernel+bounces-838180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3836BAE9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756271C820F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076D29D270;
	Tue, 30 Sep 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY2uxdcY"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D564246332
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267417; cv=none; b=e8ipL8CrcN3j3YCAR0eWScdyf8VcxFDf42gtfdfddu8ynzbizMTEbNDa98UPOwSo/AsawjVXcMt/eIuYJ4/M6zuD9nlVtiyOmbwqhjCIDaaCCMx1suzhFedis6a2bpJC6JVYZByI3jcZWcRjj91WlUJTKq5nqwGqEcGh4asN7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267417; c=relaxed/simple;
	bh=UJ0qhsXY1FCMn4xw0TLSCTC+6x+RYKDjyn73bGI8LJ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oBKgHRKa88GgOKUyxCCRy/QH1KtSwouojHMU7gsbiX6Mt+1EWsUrKmmaoj5FrnARJePb42hqqF696Gkm/hHago8kmqKAmg3JH6HgJzwxzuwHsEtuvwF4qmdv4GqXzstd62kDX477fJSln0pjYDscv0j+aA9zZoVo5etnfihAlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY2uxdcY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4060b4b1200so5667491f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759267414; x=1759872214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ0qhsXY1FCMn4xw0TLSCTC+6x+RYKDjyn73bGI8LJ8=;
        b=EY2uxdcYO5n948b32QVqe21iwIKMLoARfZCX54/dTikr37DMtgcQK4Zq3hwhktFT4v
         JU3aLNzG0D4YFbdrS8fJFdeEDk7FbDiCPG0ZhCLm6L20LXQGLccA2rDPxZ7nB/1GvfIq
         nHz7qcfculcfQldf62Q0pxvdR9QdriW0aw3v5W4onkCxyj/aJajhR4T/hFvc23hkstg7
         AJHa7Fd9k9N/Ovli550n+0a61Crxm9gOAmBu8Eweg9skOa/muHlnPTU8XUIRwmesyj1j
         LrZX0TB3Opdwc1HZ2wwnEhUlneUiH0VzTxvS4OIquj/5sZTKQUyyA+zioXN77pRDUMyH
         CPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759267414; x=1759872214;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UJ0qhsXY1FCMn4xw0TLSCTC+6x+RYKDjyn73bGI8LJ8=;
        b=WGG2OxdDQIjzIsNqUx6orPCAsVEJfiRvD+LE1SrpixdS+NBS90Zdn9qe2DxQELSO9K
         sK6A7pPVQftTj/zn+U7EW2gnuMlwuphehfZCt50JWku52RXeiyIV1OMTPQ+nS+Q89Yg8
         x2RUWkwzKD05mvvpWZYzd1NmXEu9ElxF8jMy3Axi4ceXMb5T4+fCkQFjbwMUIaR6xE3C
         u32ydxnxlGfg6BF30QqaRbBKW209Id4fKhrFti5lZHdrbpCVhNOwHcLhtRstW1fTvrw+
         sSpQOvWx4DxaU+Feq9I+eDp8yhKT1nODaowTXcrWMY4jN/ZO9hfK809yQf28mhZd1zdT
         8AGQ==
X-Gm-Message-State: AOJu0Yx35u0aYh2vqJ4BKcSKoO/IsyPTvHwb5XNcdTzaw4SedBxGvB9I
	SzkBmA2x3klInFD7L79d3WKf4coyaGSPV97dLPNfs7lTYDRKNr6/7nghqfB/AVxv
X-Gm-Gg: ASbGnctOrLJqG/wrh5ism70h3oC+plhQdl6e3mSQ2S4i968+W7gzBjdtN3lFPnr71f+
	5MX8omcwpwCLBPBSi5huyYKlz+Y3Awt5xL7eCP943J+5OyXlzGHJzjDmUPqtWACvadeEuoNEEeI
	1Q7i2YfVhn3k6gzfkFlAx3eiXbkkafRpiLiyUf2/vyBm67h4ZVCFjN3aOfD6Kp5bDfqpx6MjBjV
	Wuh7Eb3yxCDw7lFzeFLKJlvGfNqG1KsK9i/VIRlHRGVNYaGPx88T6z6alF41DMA8JHA8qf2eWNB
	xVp+KiILz9Qx6WWOJfDxc+54RFTTot5SWkVMlFJnu5RoTJmKcEWogGwNUhcRKhkNF7NzM8ZiGdp
	oI76MX1uACNR8oPjbfHdtcVtF/whTAoJdBHAmAWRoC4uRRfF2kqmswUca8snQ
X-Google-Smtp-Source: AGHT+IGm9KqlaWCEmtfcvTCYEb280Bi19ayiyfpWLQ+s8WQa3dTO66HwawV404mNLijDSR1im2xP9A==
X-Received: by 2002:a05:6000:2203:b0:3d1:c805:81e with SMTP id ffacd0b85a97d-425577edc8emr736033f8f.4.1759267413616;
        Tue, 30 Sep 2025 14:23:33 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dc2sm24030865f8f.32.2025.09.30.14.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 14:23:33 -0700 (PDT)
Message-ID: <8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com>
Date: Tue, 30 Sep 2025 23:23:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Denis Benato <benato.denis96@gmail.com>
Subject: New co-maintainer for ASUS driver
To: linux-kernel@vger.kernel.org
Content-Language: en-US, it-IT, en-US-large
Cc: platform-driver-x86@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I am Denis Benato and I have been asked by my friend and person I estimate Luke to help him in his asus support effort and I gladly accepted.

As a first step I have refined his asus-armoury as requested and resent it upsteam [1].

With quite a few more work on the horizon for me, like the hid-ally driver, adding more models to the asus-armoury driver and working on the xg mobile interface I want to ask what's the best thing for me (and everybody) going forward?
Should I be added as a driver maintainer? Please, advice me on what to do next.

Thanks for your time and understanding,
Denis Benato

[1] https://lore.kernel.org/all/20250813165620.1131127-1-benato.denis96@gmail.com/


