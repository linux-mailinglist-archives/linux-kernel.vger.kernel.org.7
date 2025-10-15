Return-Path: <linux-kernel+bounces-854927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC493BDFC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38364400506
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638E1E2834;
	Wed, 15 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtMWLhjd"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658E334397
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547130; cv=none; b=UZL1f5io80JUiUzQuh8cu1+zyaZ5K9qXAeLzeW1OvEPXN7j4dJweH27JBK3YxhXuc4s8rLpU7QOEMldaM7cLfsS9StppOa/2a6eFJForDZsGAHTTYV7Uytnsbyy8r3cTjvW6GUJqQ7u+1RTjRrcmnxsY4DF6xGE3GUVD5grGV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547130; c=relaxed/simple;
	bh=wbxUTvPZYOO+jnUBOwHP6vqN2Y8d3Evx6zjpDRrIqFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O73kkyPFbk4ESR0JBArx7ZUnvWUnnwYaL6wR/bWY2WkUhFraj9AowVOI7Ly1UHyCUajNBbBTwdVc2yiNVtr7+dnZ5YRLYIcSdDIlx8/PH9nbJGE4lpzzboBhgNMHK32vBH7tgSF6FT/Z9QHIMkhyskZkky/kDaQcmD6FXYYnyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtMWLhjd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b463f986f80so498381366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760547126; x=1761151926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neLd0+dDQvDA5L4vv0sP7kK28bvW/poi2lRWCeQYViM=;
        b=XtMWLhjdHBLttzyRnOCk7fT64rZUtawKBK+fiZaUyhESgZ9m6tHtmI9JH2d4POkSRS
         siVFJpZuQ3KJM2dcTkF3oakGLjiYm1dyxklbPiw4zQuAIShZj76zxGDuJ3iQIzRz+QEy
         Ov6cjUJD5xUQ7CrOSK3Tg5+CsIX8wICe8y3Z3fUbTBdcGmxCNw0qweKuvBrskgBKBMm8
         8QZEryxebdFxQhzCZcMFhwbwS7VCK0bwtNaRrTDUymXo9H1qQrRWjEnGaCzetcPLU0rn
         Dxm8V7hkg9sO+HRGrv0+g8wWJRWTwlZzXbBi0NGqgo92OoPkRXyYp/vsHaPjc5Da9G+S
         UxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547126; x=1761151926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neLd0+dDQvDA5L4vv0sP7kK28bvW/poi2lRWCeQYViM=;
        b=E3nwdlcoJAYFRlAcf5WoC+tdry1WTSXSa32QCnLpHeWzXKUFAu+LdOc4bhqHkJ/u8W
         mr3uiigrcfl+BFJW/c3lcXr+L27hIu+DM+vBx+OiHL7KpLSPbiUxxpFSNZETntRg/Juc
         u+wU6SyLwyh6eSzoZdHcHmGR/iwYNWC5nXez3hanamEF8vxA+ogRnq3YQLYn3vspTgjR
         /AQhe9CBmY2/x4qKV2bzO1A5BylADKtThMhS+oyafVe1OGoWFadsIKZZTPPxODjOW5wK
         3x4/zKoPssGVzGfbACQgJ9bw85s8YNs53NSviR7ZUQNZTktPuY/QNmc0KoqAgo/s8Gjy
         WYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJawxaBukOQdh/bS4qfRG+9MsoKYbqwej79rAPEon7LETAfU4Ylcwn+aUmv8//3Qgu2ayq/D12zdPgfyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSrnG7tfwYgPlu1BcOKLwyFs4I6N6vkTn1gJKmN65hR/kRnpi
	RX8aclaGI8HYy9VTmVutVgBb3g7odpLVsAQ+vxj3+HmBmvZ885ZfSMGufRi/7hTDjI5Q1zO0R1G
	sMD7Div8CzBiFFN3kYQMfNjhuwLeeMjc=
X-Gm-Gg: ASbGncuEkS8Iv9BaT9ciIh9phvMvwN/87jNQ8F+di3URwHa/82xLpTs+jq7NGWA1Ix4
	8VcMURkbI51YUg++MO4w3veLgo92sm3PvjN2zxPw0MLXP7f07ZbOao/cKaUAN10yJpG4HNIATHb
	xkNnBUVAaSo6x3QM/u5lZOsvoXBQ0jPl0N+fhc1VqYt1IPu0FQ+nGRQ2LpD3tVcYkr+JSIXzv+z
	E/cyQv9/omzRNVdDN5GeO03TjRXVxGDzXoq9oDcsZb/m8cWg2sZjpmtxbZ646U18KzEGZci/ZFq
	mNJwGbXQDA==
X-Google-Smtp-Source: AGHT+IGsOnSPE3hz5ZfYzWJNVjtUVgW/EHP33IR6zBRV5g9gSsqBcciCEwgcZlf2wmO5rhi1e9vsERWWoOP5SCZzdpg=
X-Received: by 2002:a17:907:7f13:b0:b45:e09c:7e66 with SMTP id
 a640c23a62f3a-b50aa8a5bfdmr2998830266b.28.1760547125501; Wed, 15 Oct 2025
 09:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com> <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
In-Reply-To: <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 15 Oct 2025 22:21:53 +0530
X-Gm-Features: AS18NWA4RJCcpLPYd5taRLYmabL4v7fT9byYpjgnUo14PKi00TibSEE5yn4bNKs
Message-ID: <CAPrAcgPs48t731neW4iLq3d+HXEQAezHj5Ad9KR8EK+TNu5wbg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
To: Khalid Aziz <khalid@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 21:25, Khalid Aziz <khalid@kernel.org> wrote:

> How did you determine this is the commit that introduced this bug?
>
>  From what I can see, commit a0db7d10b76e does not touch lan78xx_reset()
> function. This bug was introduced when devid was replaced by chipid
> (commit 87177ba6e47e "lan78xx: replace devid to chipid & chiprev") or
> even earlier when the order of calls to lan78xx_init_mac_address() and
> lan78xx_read_reg() was introduced in lan78xx_reset() depending upon if
> lan78xx_init_mac_address() at that time used devid in its call sequence
> at the time.

The commit a0db7d10b76e introduced the dependency on devid to
lan78xx_read_raw_eeprom() and
lan78xx_read_eeprom() and ultimately lan78xx_init_mac_address() and
lan78xx_reset()

In lan78xx_init_mac_address()

Only lan78xx_read_eeprom() depends on devid as

lan78xx_read_reg() and lan78xx_write_reg() do not use devid

lan78xx_read_otp() depends on lan78xx_read_raw_otp() which depends
only on lan78xx_write_reg() and lan78xx_read_reg()
and hence doesn't use devid either

is_valid_ether_addr(), random_ether_addr() and ether_addr_copy() are
net core functions and do not care about driver specific data

The devid read exists in this commit (was added in ce85e13ad6ef4)

a0db7d10b76e was supposed to move the devid read before the
lan78xx_init_mac_address() because of the newly added
dependency but it was a tricky detail that the author failed to see

Thanks,
I Viswanath

