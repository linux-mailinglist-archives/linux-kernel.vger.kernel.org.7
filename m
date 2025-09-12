Return-Path: <linux-kernel+bounces-813642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746AB548A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2987B3AD20E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B452DF13B;
	Fri, 12 Sep 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdH4pN4H"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52028E59E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671432; cv=none; b=Ju+6E7FV2C5qRoAfAvLPCUEZwASZ5zpsvq8XZvAqEmjT6z2SU5P7VRIgaE5hnBmt7MDmKjtDjZlcQarBfYoy737DcW8dVihlCOkGMOsEKZ4Nmf9b2j2Tj2ncixm08WDR2f38SC7+mi/yoriHugl/j9o/UuNHeNrs5GCnvNtT6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671432; c=relaxed/simple;
	bh=S5r8u/+o4m++Q7OEjk59HHq1b4rZX/yEUTiAFIbXwtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SDQRzyLNyH+71bInS2MzxRVAzjOjM8YbqELUWCVNLjIOJieD0mpCifd+R2YdUVMtPG6hYN7VZdVXN4zVfb/415WAMo38EVXARsMLUF0kNBvjWIsHN1lG6AfgQwOLefu6yA2r669kX3nsn7MIK2Cc1yVz4BB1+9DQLRONLTdNHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdH4pN4H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77264a94031so1343063b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671430; x=1758276230; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CCmS4zZEAAR6mzSAhpJN9WktstQgURUjEZz2NHTbYc=;
        b=TdH4pN4HLHRdYTcAyI7qSNadrGtioBb72o88qmerkTqH4VRlweSnk1XT4swu7nhV+C
         OqpE0OQMLReIFpkuDYewfS4TKuLeMPOb4ZMImeQEbGKLBpxhAXdsnzBFIFTLhc21/ExF
         vWH3ewOc+8pJKYPhJ3fghMtMI6OlB4tu++l0XPdVm4CpcTbgPyDL1bnREWHDzrOkAaIe
         H1+b2403pKF0zBkP+Q42EBmCrnOEaejhT6ZhOSRN2RY75U8oopAVfR16R8jYhO4VwBM6
         j6qce/OzVpUystp0uTl/EIr+HTs0TOqMcQ5UjuhmdOWsr+ZTGFnbH5X2ByklLNRSEvDC
         d9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671430; x=1758276230;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9CCmS4zZEAAR6mzSAhpJN9WktstQgURUjEZz2NHTbYc=;
        b=gZWCtrn2MkUHmx8BdBN5mUZjPRvXEHRFiDoCtxSQROOzPXRkidTArIjIA/bTiYDEAv
         9BwGfoUPnw+rc7rrJjXJXphTJ4Y2feTLyZmCGwqyFgloMIpEB9elJAa7osAnMbL8ziis
         KtF/Ir0V1r0kh18YrzSGKSe2tWeXmZUodg2p2XDiKszMEed5EuS+WQ1tDr9Fwk4GWqn9
         aicDncsvyQmmvpXAhKB9M4XZBEW8lb6ZCp/LQC5ruViEsBzvQ7NjOQlczkFYyOwDg+3H
         Bw8uT0vIC9PYa6zxge+B6hdpkflC4apu7b24PZu8kJ6u50vPZrGm3ORlSQh3GisDAS10
         +0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVkgQbonYKCGu0GDhiyN3cRfT5iNoBx7+K3SUEDpC7/Izb73xsOGCWjVYP2Mt3WjHsGPspgbtM296YNa5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8kQoHNnOXrAfkGBSS/5tgqCC10t2bcdTGYF0b0MnInAGasJV
	Wp6mPifqkJi9lElJIandD48eBLoTYGgnBG/QsORz8S/s+yGFWHKbEVL9
X-Gm-Gg: ASbGncvP+Ckyha032lSEu3ykTC+ySBMgmBkGFPu5LDvLBp/hECLBjzz59IaBRydW2o2
	5LpiS8JOMkijFuaxz+xYs2i9fpIO/sM1GDoPfw9Obi9VqNSqPijIqBKZncTGVWfRyNjSVEYy0qI
	ujCd98L3F8puMmzHxUCOGwI7eD5aOBiJlnyXM7No/GQ7C846tP9dxS8IjTZqCDBlnMB1unBhWBf
	WRhZIsJ/Apm6HKg9Xq7nThxp2I5+Czp+3mg6IpFrgOcvnjkgdEWmTd84SoFd7EDSFwVRb23XwbX
	4IVogVhcrXxoqsLck0EMUEdNwKkUkWIIl9FPqAwcvWPDGxc2wOmNcyyU8muTw09t7KW98ruVpr4
	fAkKLpXnna0xf9u5oaWeyBuCdHrf6q2Xu9DXWS70+BpqLGa6ahLBcqyiaT4Rsis8=
X-Google-Smtp-Source: AGHT+IGiDcPhc+jzEsuNi+XDjydRqe0OGFAXmfMB6wQuzhQmuVEOLHZQI8X2MDw0RSlQcQ/piEBtkA==
X-Received: by 2002:a05:6a21:99a7:b0:249:84dc:e0cb with SMTP id adf61e73a8af0-2602aa89c49mr2775188637.18.1757671429966;
        Fri, 12 Sep 2025 03:03:49 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c473b9sm5010393b3a.93.2025.09.12.03.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 19:03:46 +0900
Message-Id: <DCQQIQ5STYSJ.1X531TK8K9OTS@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250910054836.6599-2-yyyynoom@gmail.com>
 <20250911170815.006b3a31@kernel.org>
In-Reply-To: <20250911170815.006b3a31@kernel.org>

On Fri Sep 12, 2025 at 9:08 AM KST, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 14:48:37 +0900 Yeounsu Moon wrote:
>> Track dropped packet statistics when skb allocation fails
>> in the receive path.
>
> I'm not sure that failing to allocate a buffer results in dropping
> one packet in this driver. The statistics have specific meaning, if
> you're just trying to use dropped to mean "buffer allocation failures"
> that's not allowed. If I'm misreading the code please explain in more
> detail in the commit message and repost.
>

I think you understand the code better than I do.
Your insights are always surprising to me.

I believed that when `netdev_alloc_skb()` fails, it leads to dropping packe=
ts.
I also found many cases where `rx_dropped` was incremented when
`netdev_alloc_skb()` failed.

However, I'm not entirely sure whether such a failure actually results
in a misisng packet. I'll resend the patch after verifying whether the pack=
et
is really dropped.

Thank you for reviewing!

	Yeounsu Moon

