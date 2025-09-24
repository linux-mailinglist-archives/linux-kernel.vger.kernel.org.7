Return-Path: <linux-kernel+bounces-831002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D49DB9B1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D849A1B26547
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5D3191AF;
	Wed, 24 Sep 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgnCzGBT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0203164BD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736274; cv=none; b=goL8NCu+oI3YRljBW7fRErmxlJXHeDk6jclNv/29Bcp8pZsH5LG3GqMp0pb7EIQ6ozs9D6Ok4f1g67S3xmX9ZIjUNOFIcnZs5FK5J3nts0TXI+r7+T0gGR/W5sqz5DF/4CBjsLhdyDfgT7UG4BlMaeN1Da8GT3I8CD8TVLOl/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736274; c=relaxed/simple;
	bh=irDF2NGT01tFVGcKv8Aw+yXSxcZKqrHPtgX88XxrmqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M64aB0NffVfaNpg4xKw4/BdL71bV6vUyGoX+FIPLXz72ekUEX0Ytf5x1c+cfDEoEbMFfU5xWR+k1FOq6ze+C5fmgrMdVzvstr3EsC8tEqSpfvOgrBT3Z03m/WZj4zeuEieEH5tai0ce/A6EyKMHR8Fh6ndKjBzqUUZfpH2CqCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgnCzGBT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57a59124323so40466e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758736270; x=1759341070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pquafnPzR8S6cEVo4ZSJasnk4ic+4rsTQNuSE4g5qVk=;
        b=CgnCzGBTMYiRzSQuPlR/SAm+ecE/5DkRsGCNRhjv5VzXZMroiPF+xV8XhF9/Xt2utA
         Oy33mz36r66ywcpgpc/+fYQ8wNQV/8beQSDK7ahgsx8/GIMHSA0Xj7DRNMrC/jXiGGPq
         OOLmGeZW87uw9A20JrLRGU9yffNA3foBoe6AokC6okFGqoegv95dK0s09+oON5kD4nqT
         j3CxD2WEoDGNEV3dHaEDa9LwHxyVx0aA5+vX3vMGSeD5LnCsOT3gi6jOc3dCiVzzp4v8
         f1sH0GdTz//2gT7konbV3QrvIBOYmA+b5IS1a8NeZZOdwwn7mVqi/FE+V9OgWukIifkS
         miMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736270; x=1759341070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pquafnPzR8S6cEVo4ZSJasnk4ic+4rsTQNuSE4g5qVk=;
        b=Z0sZT8BvVv/SNN3eybJ3DbXMM9zMLWLVZPePCg3oJ6mw6sEpoRzCJi5ck0ERmhDAgy
         7FNVLv3yuG1Y1x1tP63Ywy0RP0+XmYSYlJDdKAHxZ/soiSXfGdSOxU2mk61d+PMHOBBC
         1WfVZ54FbRorrwWEs5gCpIyd3R8OBmpB2GMTIoGe9ZW45KdxAemetPl+rBgGaEnwJnpC
         qJSODee+0N/VevaWzQwOAg+p9ctigDsIj5IlUzIb27UExPtr/BQh9MXsyo2/jgFyWHdw
         u069Y2Fbr+VBKpsLO34SjZNp6429D6oN+V5ZZZQiK101sdx8VvWtf6rfr13vg1k8BSn5
         d2MA==
X-Forwarded-Encrypted: i=1; AJvYcCWeiQ72+NVGsGm+Fz27rwawzjXu4UpGl+LJoVFhxpESZSZUC6pHoD9urvAsuYOYEKy+dTClRId8yO6CBJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfJkWOLGGTvNKBOYryS+VA2ubSvde3jh/JXIwMKWJynBEnWg+
	vHWlMz6sS++eogYTRS6bhzuB4S9XTgDBNSY71bEsnPNP/TsNyjYWHpDn
X-Gm-Gg: ASbGncsiaC444XTURgZLPDhfjzc5XC7JEm2KzR0zBbCnH1SCem/ohJQibMnxwaBZ+GR
	5eqAMMw3oQP3yRAh9LtQoyxcgsrDhasSRJVhOzJJ1Dau2KT85UkB523ZXkcTwCSkcX5y+FEHNgA
	rgzMqJ97YbvDeLkcxeNfiSxB/LYa5l8dc4UGsFc/2vaVjNMcAxyp3tDV3QwjmOlEb9dOCt5fgS2
	yMS8YS3GP2Nb3vO0suSJFL9+0rw1EMwLrMJrqb1YGbsm/b68nQ1H6MPgldtF+qmWvfq6mYDPJvm
	ERgz4QrZOlmCjSmgtSzwUnsiW9yUQZHZORI6fipJz5DY7r4OHHeIKKnpHKqSUgRRJict8ac0Z8+
	lBEOWwKRhY3g5UVCyKRKtGScLoHyr12q6Zw4=
X-Google-Smtp-Source: AGHT+IFHPEAgajKTiH7Ls3GaEiRPS2Tkaju+/hcYdJg8P1mtwrJiU+kcknlPPPv2gncoIiP6NgFWvg==
X-Received: by 2002:a05:6512:ac5:b0:55f:6d6e:1e97 with SMTP id 2adb3069b0e04-582d4257f20mr104190e87.52.1758736270018;
        Wed, 24 Sep 2025 10:51:10 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44740sm5227645e87.14.2025.09.24.10.51.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 10:51:09 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:50:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924195055.15735499.michal.pecio@gmail.com>
In-Reply-To: <20250924135814.GC5387@cabron.k.g>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
	<20250924135814.GC5387@cabron.k.g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 16:58:14 +0300, Petko Manolov wrote:
> netif_[stop|wake]_queue() should have been removed from rtl8150_set_multicast()
> long time ago, but somehow it has slipped under the radar.  As far as i can tell
> this is the only change needed.

Hi,

Glad to see that you are still around.

Do you happen to remember what was the reason for padding all TX frames
to at least 60 bytes?

This was apparently added in version "v0.5.0 (2002/03/28)".

I'm yet to test the exact effect of this hack (will the HW really send
frames with trailing garbage?) and what happens if it's removed (maybe
nothing bad? or was there a HW bug?), but this part caught my attention
because I think nowadays some people could consider it "information
leak" ;) And it looks like a waste of bandwidth at least.

Regards,
Michal

