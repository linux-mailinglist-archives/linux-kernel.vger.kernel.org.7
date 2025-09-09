Return-Path: <linux-kernel+bounces-806974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C6B49E49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904BF1BC0112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592420102C;
	Tue,  9 Sep 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/LlhzMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AC1E1DF2;
	Tue,  9 Sep 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378739; cv=none; b=LNbbo4bTb82RiyrbUwcND6kAaKeTmwFFkDUX2Q7PfRMFVLUMwOD+tQ/mWiMihkX5JkWHVL79DiAAQwy12MI3EJ6aDs56WwUVe6TWp/FYUITyfZO3drpj1QMP1Do5aummkNR+GDXK8hHXPFtpcVVtm/KdvWHF2T87NGarZKvv4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378739; c=relaxed/simple;
	bh=+Efd7Q9KK89VwesTdbeAg90d2mnJsT5Cs8SX2mRWGjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST8e3+/5pd06VeNghdv53RGJAavM1f3OAKFZfRdMcwEprdGES6X6qDI9jd1X4io0EPPvrYs0ZkRnxSCxMBd20X8lOkXnwpyd9/+4GnHudNqgIbCTOqnHVejhN7OoV3dUw3lfqIzYyuvQcZq0HyLS4/Ha5uT7dqaYBuIsh7cimt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/LlhzMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E44EC4CEF1;
	Tue,  9 Sep 2025 00:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378738;
	bh=+Efd7Q9KK89VwesTdbeAg90d2mnJsT5Cs8SX2mRWGjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/LlhzMQSpC8OXIstyUbYTXxpGgGVGvs5Mm/l6ED5bIGKNX9QPDu1LF8geOY82qai
	 Ju8dykVHqKY1jPx4mtHcbdfyPg1IR++RP++1LWmv5tfwuld4r4Y0ZP0FjtsBJ71up4
	 MtyyLoACFtA6NrmXxtXgItpD+eByRNSSLLDw5P3XXCyuI0i/ph8oQbetrwscMEHDZh
	 J7NWispQu9BL5vO5RAH1PnXu/68lPnRJVEz+HOlY2UsJhTrjv9bySVM2VA7qmrZVH7
	 ukOSnHgp2TIthj4NwIq6DFaORL3W0SZwZ3qKpOPtzd2igU9Jgek1OBh+Fxr9YQa2SW
	 3n5zEgJxsrT1w==
Date: Mon, 8 Sep 2025 17:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: netdev@vger.kernel.org, Igor Russkikh <irusskikh@marvell.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: make RX page order tunable via module
 param
Message-ID: <20250908174537.6d6af847@kernel.org>
In-Reply-To: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
References: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Sep 2025 21:54:34 +0800 Yangyu Chen wrote:
> On systems like AMD Strix Halo with Thunderbolt, RX map/unmap operations
> with IOMMU introduce significant performance overhead, making it difficult
> to achieve line rate with 10G NICs even with TCP over MTU 1500. Using
> higher order pages reduces this overhead, so this parameter is now
> configurable.

Please convert this driver to use page_pool instead

