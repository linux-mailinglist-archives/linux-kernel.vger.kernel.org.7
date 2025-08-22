Return-Path: <linux-kernel+bounces-781444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1468B31285
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210DC6059B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419A2EDD43;
	Fri, 22 Aug 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oGkpWj0x"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77722219A8D;
	Fri, 22 Aug 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853525; cv=none; b=tA7OksTXxxChmrNB4d3nTkZQJxQQiy3dcIUcezSZ+/ZmA/Me5DkdDQa2sKuSWf7NyEvxrD7lb3N/vuYJvmMOYIEmWSgzUQh7T/skMrm7dLJgKWbbGQQ1WXUO2LJ+9cJMMI4PlL6iF4/0fA288/DmlEgLKfOpNS/x1qhFpcsYFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853525; c=relaxed/simple;
	bh=SUZxfsZavWkvKhoK2Hwi4h2ZWx97dpmANelxbdYGZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLiAN4J3N4L742PtQ1c5GAsOQfRwAO/S/wmPfe726VVjZumbULF5QiNU0eyuUqssu8jVqXNgm5AU4xK2fMLYqZtV7+zw8jt92SxxT3Uye4oCSNpLn1FxKkK/sEGo0EKj2V5Xi5lRpvIT1vazfkK6EYRkgQy6Xv8VPJNajInlW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oGkpWj0x; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yzHHo0UkuQZ7SXhvKcyTqd+eYSh/PHuLO27ppZ03Czg=;
	b=oGkpWj0x1Z16Y2Zv25WWOt5SEEldKTxsCPW2ZBEjCrnYwAblJIG+JfnKOW8hn9
	Qv0RqpNunLYY5XJA9+gqioYJZACOzQiwV6ykKkRuF7RS2RaXC4XDGzlwKkAWi6N3
	XuUEwr1dRFJpXcsYcdE7+tKT75IRl7sJYaSp3CagHMNPw=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAX1W66MqhoLbgVAw--.13359S3;
	Fri, 22 Aug 2025 17:04:59 +0800 (CST)
Date: Fri, 22 Aug 2025 17:04:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: ls1021a: rename rcpm as wakeup-control
 from power-control
Message-ID: <aKgyuW1M16NKEs0E@dragon>
References: <20250812061339.102616-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812061339.102616-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgAX1W66MqhoLbgVAw--.13359S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo89NUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwGxZWin7iqtXwAAsn

On Tue, Aug 12, 2025 at 08:13:38AM +0200, Alexander Stein wrote:
> Invoke power-domain.yaml if node name as 'power-control'.
> 
> Rcpm actually are not power domain controller. It just control wakeup
> capability. So rename it as wakeup-control. Implements the same change
> as commit e39f567e1c38c ("arm64: dts: layerscape: rename rcpm as
> wakeup-control from power-control") for arm64 layerscapes.
> While at it, also remove superfluous #power-domain-cells
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


