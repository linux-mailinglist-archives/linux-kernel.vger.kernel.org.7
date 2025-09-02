Return-Path: <linux-kernel+bounces-796384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61CB4000F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496F8545C24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19F3093A5;
	Tue,  2 Sep 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="J+4N4aq6"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1952E8E03;
	Tue,  2 Sep 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815024; cv=none; b=hNRp49/1XLJbY4P1kcplCQlQYsa8zsg+Cni0VpAthNSwWEtDjEYf36ZFXdbFxv3ZljY8tPW6ayFjUlVbWNkBEqArCYjzgxsasf3zGDybzJ6G7KNmD3vH68JY09JgFAGbO+DtDsKDVU7viL3QfGXIl8+ZSG/+0JvzF7wNA2Fwii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815024; c=relaxed/simple;
	bh=5XjTx7iK7PHq+3BKdY0v5CJO3xIQLjdIo808+rqI8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXycQ41Gh7fkZbHEk5rRTH7Cy+Ma1ewRt3vkXP0vV1VvgI7A4Xq9SluoBdDya6lM4V7FVmkRs5GL3161rr+Gon8kEWDfX4VP7im09Z8TdTsow8sivt0bc+2rYYiCiffVWVL8nRDlzJXdYbRac83G9pANgnrxwdrAgeBsY9hmYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=J+4N4aq6; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756815015;
	bh=5XjTx7iK7PHq+3BKdY0v5CJO3xIQLjdIo808+rqI8JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J+4N4aq6ngHs+ccgv27484VTZULp5l5v/wrlliCsZwWYcCoaNPhdAW/RoqndD8J+n
	 HOIs/OyO2bVuZufZMOObfjWNTCXguJDsXEL64wszwixL10CNyyQLlTThhKW5hA5fI6
	 Qftx6w7hSZyFoUUIzNXYYSxB0HV5qUfWu5rdRow0erHV5xYhTUHBkYYIrl/c2PmmlT
	 sF4GDsBDK3lPXFGcsOlzdePwHGewdw+hFibP89j59+ah3v7La+Hy6oo9Q2E/7PnZee
	 jmXXDy0bY0A66fjWs3RPFY3HI36/Er/CM/u0QApZdKWhr/n5UKe8n3xqCgECi1Urka
	 MofjlD47NFgdQ==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:892f:ee51:308e:70d0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 1DBC827E436;
	Tue,  2 Sep 2025 12:10:15 +0000 (UTC)
Date: Tue, 2 Sep 2025 08:10:14 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andrew@lunn.ch, conor+dt@kernel.org, devicetree@vger.kernel.org,
 heiko@sntech.de, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <20250902081014.0e6eaaf2.xunil@tahomasoft.com>
In-Reply-To: <20250902070019.856305-1-amadeus@jmu.edu.cn>
References: <20250901100639.234ba07b.xunil@tahomasoft.com>
	<20250902070019.856305-1-amadeus@jmu.edu.cn>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 15:00:19 +0800
Chukun Pan <amadeus@jmu.edu.cn> wrote:

> Hi,

Greetings!

> 
> > So what I said earlier regarding rgmii vs rgmii-id DOES NOT hold up
> > under more rigorous and careful testing.  
> 
> So the following question does not exist?

Yes, that is correct. My earlier question/comment/concern about a huge speed
difference between rgmii-id mode and rmgmii doesn't seem to exist when more
careful experiments and testing methods are used. I'll elaborate some more
below. And I apologize for any inconvenience. 

> >> Changing this makes a huge difference in the ethernet throughput speed.
> >> With rgmii-id mode specified, throughput is about 6.5 Mbs. Changing this
> >> to rgmii mode increases throughput to about 960 Mbs.  
> 

I'm still a bit surprised that my first test method (web-based, like fast.com
or self-hosted internal download speeds) gave such different results from more
comprehensive and careful testing with iperf3. While certainly web-based
methods can't target a particular interface, nor do they have many other
potential adjustments or refinements (UDP vs TCP, etc), they have been and
continue to be a useful tool for me to get quick information about the status
and health of my network and its devices. 


> If the iperf3 test does not reach Gigabit, you can run it in
> multiple threads. e.g. `iperf3 -c xxx -P 4`

Thanks for the tip.

I remain keenly interested in seeing a patch for the Hinlink/LinkStar devices
make it into the mainline kernel. Please let me know how I can help your
(and others) efforts to accomplish that.

Regards,

Erik


