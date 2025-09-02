Return-Path: <linux-kernel+bounces-795664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C8B3F617
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C413B297F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305C2E426A;
	Tue,  2 Sep 2025 07:00:31 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D320B81B;
	Tue,  2 Sep 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796431; cv=none; b=MinZ0oVeqfkME2ooHfz0zCOmFx28ctLJ+zgHxWTJsMri2rj8Q1MkutHxqQsibEYfTIA56wqIhz1ykTDa3b1vVmrxNwwA8QGhp77agY2vgjbt5kdusou/3/EdSB1FaQH4H+emWUJpXes+dAXgSgoNCuS6QqCRRto1JBpoa9ZPw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796431; c=relaxed/simple;
	bh=kn41AuD1tHC9cKxc8T65nTd7ets+m7wbkebswHfdUoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7rvLRBwVNLaIoEFdoPNOvonk1GRF0Oq4mq+dxF14tnwRLeNkW5ftrhM/df+LBscSEc6RRIv/8XVPXdW4ugDe51atX8gaI5bdndbGuvoizMaHtD/MXlgY0HIuKg0Tnr2J25JNwdW3gNh7yzOn9g8fZ3YWmz9JyxJp0jZUZOxHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2164fd079;
	Tue, 2 Sep 2025 15:00:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: xunil@tahomasoft.com
Cc: amadeus@jmu.edu.cn,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Date: Tue,  2 Sep 2025 15:00:19 +0800
Message-Id: <20250902070019.856305-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250901100639.234ba07b.xunil@tahomasoft.com>
References: <20250901100639.234ba07b.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99093a0aff03a2kunm41dc6c2c7aad6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH08aVk5CHUwaSEJLHR1CS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi,

> So what I said earlier regarding rgmii vs rgmii-id DOES NOT hold up
> under more rigorous and careful testing.

So the following question does not exist?

>> Changing this makes a huge difference in the ethernet throughput speed. With
>> rgmii-id mode specified, throughput is about 6.5 Mbs. Changing this to rgmii
>> mode increases throughput to about 960 Mbs.

If the iperf3 test does not reach Gigabit, you can run it in
multiple threads. e.g. `iperf3 -c xxx -P 4`

--
2.25.1



