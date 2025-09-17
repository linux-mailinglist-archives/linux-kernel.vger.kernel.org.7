Return-Path: <linux-kernel+bounces-820520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89FFB7D326
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9321C02679
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62F29B8DB;
	Wed, 17 Sep 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REFQ9J/t"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D0253956
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106830; cv=none; b=mrwIgf+/OMX1mS+25fxrpcuzUoLI6+iLMspBXqMLN5jAT2wYTaLonuQbFhvK4yRlJ4VyckMMTkHG62aX9tnjPzuo30ulHKHg/Kmu3rxV0YxPNrFTA0Tu+1ihxitAZGRd3M+sCLVjwPzIkMfrhT2EzbPcoNZli1QBzNdBG5N6jiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106830; c=relaxed/simple;
	bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMmyaofm4x+y7rF6LT9hruzp9A/Akf2Y7GwyW0D28YYeWQYK6FYejT0yeMzX6PV0QujxwsTP5uQHwhPcnpuvg5G1mSjgKGxFYgg5MQei6lIZn/wCbdw/9FTArWmVoQ0ZAXY00MSeN2ZeEcNdQvzkljg7K78gGYlFCJdGGh2WfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REFQ9J/t; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea473582bcaso911213276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758106828; x=1758711628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
        b=REFQ9J/ti1q0ctWu3QtcK7nHBvfNDnbSJ+rRT+BI9KKorSnWIlqEUZDSjs+5RDWa2Z
         cZYIHVUFJ+bwb8/unvb26fwaUd88qkypbmWBMXx0FgJGP1dd5eLXiMIRj1iv1Od4uhpg
         l5HtUUGHK8N4AE1t1oiWN3FZP3e4495ZSLO+sMDe+l6eSZ40NqQyUbUd9LQW1B+YghkD
         mrxJ6JaJApqHXgjgRu5uVXwPkXkaJwDWJgR+glyVmWw/1GNkglW8vMI66u5n3kieplQP
         dzywh88U3RCkmspLuFyXcJx/MW0dFVtUi8mcNffjrHdbBnNo0SbagevI57sc3w0y2lJR
         ZSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106828; x=1758711628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOpYV/CrvsvUnku/0QkvP3IDl3KIs1iAJKOOZesxXbs=;
        b=TLE01RMT1WkJpX5FfDLlw/Xxk+5d3v+7a1aDezNLEz4I7ezOi12gXMe6Nh/qAksrqV
         0TXmtp63Z4NN3r4QIt3J5jA2nHg1T/FLNuMcPwl0NVeijLfbG5EnFrknftAJdqNp/r7p
         mO/acuyELhAc6XcvikLXB4SXxcbGCIOqsww37QggaCaRwNA6rkCxxCBye8cjl6mAOcDu
         Q7dJYWGVVCheOJTAuPjdrEDWLorVwCbSdUx7xiVGzE9zfQKwEVp6+Mzvw4icljzJVucZ
         euZwccRwOVMGCiFpMFVzqn0QwYCPP/jGHyvtJP33acTHkkafu2vMxG59u11yV8J7XGxn
         8J8A==
X-Forwarded-Encrypted: i=1; AJvYcCXByhl3gcBumv+jlHbVENMiYkw3A/fQqgPtsNojOm6DYElERjidLnWvvnJ8ENfjIhLlBwGKckDF6R9bfmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFz56mDWH5uq1WlY/LEA6GhFAKsJbqrGxrur1N4GijLG6m29Nq
	0fxOoxAB9HyXYdptt2ikvT1JQ7DQAKqSQ04ZghwX7vRYcwOJgbTQvmbHrQiYmaY4yORWt/tRtnH
	B1yfQCWONQ/23Jnqv5P6M521HuDbiHwDxQ90+T4o=
X-Gm-Gg: ASbGncvHPj/qEIxkKsM5J4HSea2+dX3j3Rsic3szXwsZEIWYYuVFLMCfBc9Zm5PTaIU
	zD3+TcLerIRCRcUUrWL22qXrnbLHLNn3wIIswN2futr32vuk1lU9ZQB5seTs9Mv4AdTwceXiYpN
	7tz7tBSVS+qa9QY/Z6qmG3qtGtDcb61f2eIlC+Km0IbXRnDQIqDvM9L9KUlSruHlF0cx1vnqN+t
	qyVs6U6/30IJahj/N6bHvmLtGhsoGXJz3VxMZ19VZAoULq49xI=
X-Google-Smtp-Source: AGHT+IGfnuwSEGf3ha0nSdQ2bBtn723dyi/fioLa2ryAVJS390NdpOSQEFlC22tsMhWb9EgeYLp9ZMfDh/dzPGnq+7Q=
X-Received: by 2002:a05:690e:159c:20b0:62a:c4a6:bfea with SMTP id
 956f58d0204a3-633b126d5edmr1034403d50.17.1758106828070; Wed, 17 Sep 2025
 04:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912095928.1532113-1-dqfext@gmail.com> <20250915181015.67588ec2@kernel.org>
 <CALW65jYgDYxXfWFmwYBjXfNtqWqZ7VDWPYsbzAH_EzcRtyn0DQ@mail.gmail.com> <20250916075721.273ea979@kernel.org>
In-Reply-To: <20250916075721.273ea979@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 17 Sep 2025 19:00:16 +0800
X-Gm-Features: AS18NWB_hpDqfpIABkrd-Pvpolw7w2H4ujFI3yYvFt7f0E3V1zdjLMakXthxI2E
Message-ID: <CALW65jZaDtchy1FFttNH9jMo--YSoZMsb8=HE72i=ZdnNP-akw@mail.gmail.com>
Subject: Re: [PATCH net-next] ppp: enable TX scatter-gather
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 16 Sep 2025 10:57:49 +0800 Qingfang Deng wrote:
> > Can I modify dev->features directly under the spin lock (without
> > .ndo_fix_features) ?
>
> Hm, I'm not aware of a reason not to. You definitely need to hold
> rtnl_lock, and call netdev_update_features() after.

Will the modification race against __netdev_update_features(), where
dev->features is assigned a new value?

