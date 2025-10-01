Return-Path: <linux-kernel+bounces-838760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B43BB015F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5509F4A2E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6C2C3266;
	Wed,  1 Oct 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akor9YPt"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D019DF4F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316772; cv=none; b=s+RKY6w1qkwswEBmziphwF3o7NhUsaeU1HRsLWY0h8QFeBmLTjJXSvwQAtPBo5Ny0y0McRP4l6Z9pY4EhCg56fLpgQwKU8T4PYpULX79i/6miFd7I24jAEhdY/GjFuu6dA107bVDCI0BAc6rXHLK/N8yIX+f87pWy6ZWuHA/zDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316772; c=relaxed/simple;
	bh=H2FvDp5EcW5NNwgMTtH+nhDevA4wTd/GB7ppsb/tDGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFiJpEY5xmw4AMAzgSrtIh8iS4Xyu99vbxl2sKkb2m3cqmc5txU1FZV0OLDSQ7gI7eqjCjhb+3tRp9WTGMxQU0zhlx/mCNjKJ1EAVMuBo4IDsSvHc56mea+tJkeD0n41AgYY2IyLYrJNBlrt1HhuGJCAfm9S8K5yviPpQ7QTIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akor9YPt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so772265b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759316771; x=1759921571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUTO1WZObRKjcF69kojRq6rqV5jRn37FuLlY5Jot1Vo=;
        b=Akor9YPtCbnFgIpY+2/lC+Fi5SbPMPnQl/Dzrz1D6kgFgK6ahwjzsw7Nm79T5J01q6
         MhBAUvOi4aYmhJ4ltNkfqDBnqAqZY4l8ZFKpjoZMuBoNx+N14DC5zf/MrvyLnj4qGH6g
         vOcWSPAlb9uP7XszURDmyvABQzr7wjzvxwPiBYWD0XDqchxanudwVdhU61u+0T7/0EnC
         DBhbi1X2lv0ijHqJ4bVE3mRDXWfKTVXgv2om/DcxbxvAwnCeP5POE9378iB2BB+fRlEg
         UR10WOf5tz93pBedy/8JHUlA1WTr8ERPFhSj88W2hQReYbGI8/yJeKk5XFGP5U47Gk8I
         GHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759316771; x=1759921571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUTO1WZObRKjcF69kojRq6rqV5jRn37FuLlY5Jot1Vo=;
        b=SXeJHlQJrdSBNNLJrQ4SQSy3iIixyHVc74PQeWx55y7xItysuH6Q+JJRtLJtmiiCir
         X85nqX6jg6n2TRGSZ7asPvayU3blLczMAtlTzPQSnQrfKPx1S83qQP1ulc7POl6IQf7z
         MIPs7gBhV98aNydy1KcBgLNokABNC2C9tcwaAJhHa8pgWKLU6KZj1MFHdnltZz/g5KwT
         EGpO5yjHKVwf/cw/5TyjgR8pLcoD7OQVklT6VIGSK1U9Zm4hzxAxViTu01Lz0U2wY2U6
         wZTmg/UyrJCd78ndDdZ/rtry82V04D0i7ehoYtYtQtNqFcRQLSniPyf5mGSBfXrGrPCm
         1X1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPz7mB+Jgqe0Ahzn9t/nPkOB4T+G5HN0Gp8zxlf40zmGuNJKXhXhOP2ep+SJdmB9a7u4+WYhtRPGTWFJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkS3O1QIo16aoTuGVOHJDHXQxFgqd8Own2K94xNpFPzFPagnc
	QVS7AlgFd1VIGbnUCbnSvMbiLfxBgK8kbhV5SDeKmEzBWFRP/t+/De1G
X-Gm-Gg: ASbGncttebq1oFMXzXyUnlq1WFFZZDSSzhYiDZBlGDO84Rkp8Y0mgtB10dhwODDe8AD
	rs9j6TR2FmL7HN20lh05GT3pU9k8zhWQ6Cm0KN0r+d5/dFRn9oADAbuCvJI8kMCn4okpFCYOxc+
	PfTaTovrr1eLRARPM6Lt4jzPzod3W533tGrc/d/dRaMtawXDEDGPhrPGO5cQIL3JDrGqxmSv20T
	/BoncIWVJ7l+MAWxDb1Bvo2gwLqXGNqDAUHBZR0QazG7wWQ/OdnFwykQZ6BBAe1ehXZPwTEqxXL
	MlwS8DPmzQIeBofwEJFIkOJixDguDftgF4iwxN4+iFkiQB/MMoGzuiKIm0p02iyPYwRZmPHoKck
	Fd77ICKhKDgWgFFavswDqE1sksT75HP1CLDvK5UJAmW+gme3XWXmAfP0kzMyqdcxPla0aeg==
X-Google-Smtp-Source: AGHT+IG1IDj8iyRkR3Qp/J2mbmh1w//edaVdXzT4iefYbJRU8w1dPyNhwk4JZHL6+GK7spNE7nI9Yg==
X-Received: by 2002:a17:903:1904:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-28d170e948amr95641775ad.18.1759316770491;
        Wed, 01 Oct 2025 04:06:10 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm181403015ad.138.2025.10.01.04.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 04:06:10 -0700 (PDT)
Message-ID: <20f92e3d-dd20-4f37-854b-17d96efe92e4@gmail.com>
Date: Wed, 1 Oct 2025 16:35:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: doc: Fix typos in docs
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Maloy <jmaloy@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251001064102.42296-1-bhanuseshukumar@gmail.com>
 <GV1P189MB198840D92F47A423791FF803C6E6A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <GV1P189MB198840D92F47A423791FF803C6E6A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 15:58, Tung Quang Nguyen wrote:
>>  * @server: pointer to connected server
>> - * @sub_list: lsit to all pertaing subscriptions
>> + * @sub_list: list to all pertaing subscriptions
> Replace "pertaing" with "pertaining"
> 
v2 patch is sent fixing the "pertaing" spelling.

Thanks.
>>  * @sub_lock: lock protecting the subscription list
>>  * @rwork: receive work item
>>  * @outqueue: pointer to first outbound message in queue
>> --
>> 2.34.1
>>
> 

