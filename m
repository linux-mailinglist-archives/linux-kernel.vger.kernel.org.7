Return-Path: <linux-kernel+bounces-734758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075EB0860A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC2EA604D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D49237164;
	Thu, 17 Jul 2025 07:01:18 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125C219EA5;
	Thu, 17 Jul 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735677; cv=none; b=m4F758yVU3Henj2FzqS4gNAz1s7zZlWhCy/4WiWhTc8HbHXWQxoMRV0RMMmTuW9oFx2cxSi6SDKbhCt3DiaMXJY06j7L4nFCvTiZyx34yCYbNvtqqWeijIzRB7TXvhNPj8On8QA/Z3QsMefnc4EuyJ4m6tWILevEze1sxJfRdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735677; c=relaxed/simple;
	bh=xezK6VSpCX5KzCsjYr+3cAxbBD71MEfscv32f7luUYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YD1/ZBG1f79Y2Ed2Gx6c2astNNP+ELw8Ps4gCxg0dGN48Ahl/T8tRdjQDlYjkqOyNI44cdckN0YWwMJJpSkX6gdJNVmDfQcp3xUOc7/aE10DBCkkAk30dNn/3Pqlcs3gOgmJOh0Lsl9znQJIcadxfRNoErVgds1g7HsXPNHc9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c51d5e06;
	Thu, 17 Jul 2025 15:01:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: alchark@gmail.com,
	amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Thu, 17 Jul 2025 15:00:06 +0800
Message-Id: <20250717070006.192765-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se>
References: <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB4dVk5NSEodTkIdS0IfTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
X-HM-Tid: 0a98172fcc3d03a2kunm2d7d78618f0743
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Axw5IzE4EQMyDzVNPC4B
	LAMaCkNVSlVKTE5JTEhOTU1NTExMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFKTk9JNwY+

Hi Jonas,

> One possible difference here is that the actual CPU rate is controlled
> by a PVTPLL where TF-A will configure a osc ring-length based on the
> requested rate and Linux only configure the regulator voltage.
>
> I have no idea if the configuration made by TF-A will have any affect on
> power usage, but I suggest we keep all opp here because both TF-A and
> Linux is involved in configuring the CPU rate.
>
> The measured rate can typically be read from a PVTPLL status reg, it
> will be different depending on the ring-length, voltage and silicon
> quality for the rates >= 816 MHz.

Alexey suggested that we remove 408MHz, 600MHz and 816MHz from the
opp-table. Do you think it is acceptable to use 850mV for 1008MHz?

Thanks,
Chukun

--
2.25.1


