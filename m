Return-Path: <linux-kernel+bounces-812832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52012B53D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F231685EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738542D0C7B;
	Thu, 11 Sep 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RQEE1ssg"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43322759C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623584; cv=none; b=FEqCuZgrZxC0pOyDRI0z61hEkOaRMQSLeFsZjwPniQt+lBoh6Vjniz0XUbAlZOQTktFMwUYJRobLNAE3qNypYd6oE8m4gYzUxWvWv6Topk8Vafm07gyW90qfQoZuWskWbMRmj3XGUUx9AmV0wQlLo3lhhF1zc92Au8/Jb3gwOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623584; c=relaxed/simple;
	bh=kdf/opkiaPi1wbVEP0I3N1fEYeXIFC4zRJ1yWTUzcGM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ddrj67M99Q6+36OIM3ztDkL5Jl1p8zf95t7A33uT796qrPkx05J6Q2pazmKgQy0CBAomAqQcU5/m7aR/4bxxi+ACras/HAaP0Ni9QijN521MnyUXLKmOhuqQc2pqdo9/Nm5nJKJAMpIEOHtMvQeWv+dQs1oE4VdERhverlAPrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RQEE1ssg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8072bb631daso111782085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757623582; x=1758228382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=RQEE1ssg9tNWnmRFeE7A96Fzx6pZtRPjKp1JAbXDBCswEBlUgRP7c1G2PT2ISmhAc5
         0Olmt7KzEVn7wJJh9JIFZY/0pv6158prccb4FiT68m6hkQojGReCBsd5pI/QFMYyspZb
         8eoivlZFQTcxZfnJYDBt+C9/0BgKIo7BfP0xbg1d/pB8MSIvZHjP0k/hzwjyNV6ei1fv
         +meXoOCBWb2DCUrf2hwGTN988wEINIwDqdCFqNI0mzfHj81dN6mkL5WDpn92khcVs5VN
         9sSwbQbRpJGvrlJHi3ODgitx3QBFZzgwIvzICb8uZmKFP0HJjhfoVlmLfd+B8u+TNI9p
         TViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623582; x=1758228382;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNjmDRDjq4fT2fMT3D8inrfJWhzOs4XStOtEvDIlq+k=;
        b=Nmyvcr5o4Jrb0RoU5cTDQNKP+iGpDo8pMtsAv83gqteHB+qtxeHh4B4AWCEUu0mY7d
         42tcaCbENaM0Y/fXgOitEG2t79m52QeoUCYcT1sE+rgQ4XX84EqRo2YNwC40mDtmhe+N
         kofBCU0Mnyw5mSeAIVVzmrJ4go68J2NWUJOK95UNIiDgqvP5giQzHCPMOw6HwL8zvX7r
         ayaV4zws1eC/eZmiwIlGEDLF2UXhjW+rAGRZu2eaKbH2JYWhJ/z2ADHhF4072UO/ZtM7
         7Def9b2/MszO8TJH3Wf1wylwovp5nx99r3hHQTFqCzbLkIbkdAgI00Op5tpmXC7wfmMk
         3Z/A==
X-Forwarded-Encrypted: i=1; AJvYcCXs78PulSDAFkiho/8BX8w9UXzmoXKxl5kQQvnfOimvteSQWLjPmCHeZpfjKs88LwxCFnTo5ZU8ICM4/Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdOOAryt9N5mu128lpUyQTGkPWDrJdZrJIDRxLAXvu09cmzM7
	PzhjnwGbqm0/M1IEE6Xle/K4lRESFM7qCLaCtsejNYoWHdfpNH41KiFb2xnPgM+RxA==
X-Gm-Gg: ASbGncuMHq/nQkg8IhX5ERCAYJLCT4+lbh+z1gbtNgTdgV74KKnLuwKBp8qaSgoG0d6
	Fa35eScbXBfqx4N9gdcB73CNu3XmrgG+z3J/VebQYibVgfDgyoMzOT5DsKKU5+6jsDlZsAgC7c5
	5pCa2UcsArj+EwIJx1Q4wgpptBpBB1VTHnAyJB19wQL5a2L3RtostmTxA5MPAJr2/upzf3QF9XC
	u4jDqalaUUsI5x8UM1PM5Emtp5Wosm3h+/BtEthBu5dDn1IK6A4cBVEYkkD2Kd+a8k0hqH1js3P
	AfHB0FWbRG8PloFB9brJuOXSZJdtlf88szCUr1oXL8cIy7fvMEK1IU/V51XYJP/kAKDt7AVGqZS
	sEAnTpos4XPKkjLRsVLjnddctfC9s9EjUhLMpKhjB7jvjaM/3Y2d5IjLKDElTyR679G4koKtL55
	5kwVU=
X-Google-Smtp-Source: AGHT+IFUfU1kwejubVPU2NBS3h5oB5sUNB3UbWeon4LOL5GqrQWNT7DOGhwAVGTwCEC2VfzuOogDtA==
X-Received: by 2002:a05:620a:a017:b0:816:d061:7d2d with SMTP id af79cd13be357-8240094385amr94531385a.70.1757623582083;
        Thu, 11 Sep 2025 13:46:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd7041ddsm156936985a.32.2025.09.11.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:46:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:46:20 -0400
Message-ID: <23663be0b8dc2a435bcc46a3d52e9e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net sysctl  permissions
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250910192605.16431-1-cgoettsche@seltendoof.de>

On Sep 10, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The capability check should not be audited since it is only being used
> to determine the inode permissions. A failed check does not indicate a
> violation of security policy but, when an LSM is enabled, a denial audit
> message was being generated.
> 
> The denial audit message can either lead to the capability being
> unnecessarily allowed in a security policy, or being silenced potentially
> masking a legitimate capability check at a later point in time.
> 
> Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
> determining net sysctl permissions")
> 
> Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
> CC: Christian Brauner <brauner@kernel.org>
> CC: linux-security-module@vger.kernel.org
> CC: selinux@vger.kernel.org
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

