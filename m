Return-Path: <linux-kernel+bounces-813567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E68B547BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCE83BD8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EA9288537;
	Fri, 12 Sep 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNNi5qfK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7928541A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669245; cv=none; b=rw0IW8ESz0ahmQdDRL0Y3Yx3IdcrrHSM1HpPVywnY295/OKN5EhCeAONRpGGx+k7LLU86m0ePzcGZisMr4yjUQ+BHuFmizFN/2r8So74y+LOhYqHl/i36GQ2DXccakw1colUtRAElbvIkM5l4lRRL0w2y6f6ugSUbbu7E0AIjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669245; c=relaxed/simple;
	bh=yJJv2gjhRQfuHF9Gh02OKGyHVT4ciENi2NSMHDOldJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p/opHBnKCRJfozQiT2AURLKaEoi6NHxPdumISy/T0ZhVRFKGJiqjxcvhJ4yKzQQnaoGWch98ekDF/WHvroO15KddZTP1X9rQd0et8yFRTtfcpSDJuL6vNpqg5NMw+raj9/DjE0TXDdTxVARd1KpSRAZOqXufY7oojxkGf1I55xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNNi5qfK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1711008b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757669243; x=1758274043; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZB/EENzQ9cknRI92mO2zkQd2VPyMtef2mDXzKHOG7A=;
        b=lNNi5qfKFf5sKGba01fJO9omJsse1xLX+fvDFKAdfUgfy9E0842oQIFZkTSNdTUReH
         PiJ6Bb0N9JABw9DuSLWfBYjALx4EbRHTrTFvHUO+XyrjF2XbjR+pktIrgj8Wi4+joxI9
         UJxp0R6BIbpEBxpIDoNA2gZsHSNlhFSVJkp3uvaaHJTnPUReND5ikhV3h217mOEmIB4c
         SL4IRwStmqCgdAv88WpfDP5C8yqkqnGnaOPME8ckilYezrGNa++t6hn3dWb/hGlttF4P
         QOJOnu03VVpZRI6TLBevyNDvIJQySEynQCd4Ws+djCEV8nEkmdrkVDkhyJk3RmPEJBYG
         supQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669243; x=1758274043;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ZB/EENzQ9cknRI92mO2zkQd2VPyMtef2mDXzKHOG7A=;
        b=l63uX8/p2+wS4uQF1HGoHC1v+nJojqY2lL1j1QvHCkVrjN2zSO7Eax+RZE/XVLVSO7
         +xs6jIwa4dibBtkxCYTp2KJtWFkM7vUzXz0usUK0cKqsU3DCTlgHmvzjt7hSrCbScRoh
         4iC7GXvQEEfiizHTH4AsyCU188geez7a9t5iXr9Bk7N3FOB2aTTkihAw9SopMs3ysz4p
         G3T5HBepXses4PnGlulE0VEvhBZWziQCXFkMvVTJF3XpWjEutAAqN5nG8FpdWUXWRdVP
         aGXn7glR6RWolo7DFi2MfYcPcMpIU+dKee4WlYxFvd46+C8LuyQ2xXJVAFFLCtsm/bLA
         WfMg==
X-Forwarded-Encrypted: i=1; AJvYcCU6CKVUk0An0Xsj3XLP9PYzWDxjMM1CdxU4gJOyYDKetfyD5dbWSTwHAK+XHl1i6veB55AoP0HoZzq+uig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5StIM7ROPnX/XWKqGkPRe26jbwvFqvWZ+XoFzY1H8o2eTto0e
	cnZUG4eXz+z+m8tmOLyzv61dhKuFQ3XccPC9WyrwVIrhkrecvsyj8F72
X-Gm-Gg: ASbGncuVFju6y2bu4mjs5a3NlHBNz08PHQm5n98KlutxpuKKsGa9qfs4e076Dn25JOb
	LXivHaEHd9Roe01sDcAOd+e3DhMqLWsZv/rNSQWvwUp+l65ug8+RmbbQz1qvN+febYj6QRenucp
	huZy5cXy0tggXst6Ig0fXPxMvxSDT5kzPoTkHtxKGEfEAF9Yc0i7ivPZXIJXb+ko0uIdChX4nhw
	b0WoD8oDpdgis6VyOAUm3Hw7aWxehL53tIP8GeyB+MYb2qXBjt3J5Ilpp16+4xwEDWZ/l4gn1xG
	s5zvXiTQQTv2Sdkr+pjytedRg2YEQYviltOwNO41h+C2uczI08BeNSH09bzTvVdhnRlUq1H8axU
	Kk/N/zyAJ4h1hFKuTpoJkz8oqc7EEAWTPHm0sx0W8ql0UTGIZu1hoVKGkiSrH5AM=
X-Google-Smtp-Source: AGHT+IGzZmv4BSLblDExiYIqYLLacdpezaosRNfT06DqWMAt9pAoCpyMABpeGs31Zcum/QN6x1pLbg==
X-Received: by 2002:a05:6a00:3e02:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-77603319615mr6443572b3a.12.1757669243294;
        Fri, 12 Sep 2025 02:27:23 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6d3sm4819370b3a.11.2025.09.12.02.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 18:27:19 +0900
Message-Id: <DCQPQTBY5SVC.1FKEWQBMY4WZS@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250910054836.6599-2-yyyynoom@gmail.com>
 <20250911170232.GP30363@horms.kernel.org>
In-Reply-To: <20250911170232.GP30363@horms.kernel.org>

On Fri Sep 12, 2025 at 2:02 AM KST, Simon Horman wrote:
> Although new users of dev->stats are discoraged (see ndetdevice.h).
> That is not the case here, as the driver already uses dev-stats.
> So I believe this is change is good.

Thank you for pointing that out! I also plan to rework statistics code
to rtnl-based statistics. However, that change affects a large amount
of code, so I'd like to introduce it gradually and gracefully.

>
>>  				printk (KERN_INFO
>>  					"%s: receive_packet: "
>>  					"Unable to re-allocate Rx skbuff.#%d\n",
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thank you again for reviewing my patch, Simon :)

	Yeounsu Moon


