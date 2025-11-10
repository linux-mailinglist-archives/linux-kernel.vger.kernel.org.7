Return-Path: <linux-kernel+bounces-892583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D6C45634
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8608C346EED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9802F5479;
	Mon, 10 Nov 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="QaEipi6q"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025B2E92A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763791; cv=none; b=iWdTXHmHB4YRnV/yyjkWx0wukeB2LmY6mnqi2MmESkIgemG4WP89ty76T/hIiH3VJeGF9PXPMNXh5Nlmyw0lyUaKowyNhJg07RMiAqhMrUdogO25xuTn7zfKme3xlUpqxAMkTT+s+1FJ69xMT0WssmyM1wGf8CF8c/6dJqKM4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763791; c=relaxed/simple;
	bh=ZuM9/lVYSErfL/ws8FIC2iRtqVZqZc7sKgCamFMxYmo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RFv7KTR0/iIDOy8Gem5U+XVzUyfr/hUwKuqRCrhlaIptGtQ7nsn/tafqa27StgY/aPrtg+OXdYTqVDWHrXDbHUiELshDvg0YrSM6GvobcGxmZkiHGjsJ56yyxQUFiLQftNrayoz5H+E5lLg629UAeZ8gjY8Zqhwt7/N0Fds23AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=QaEipi6q; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4d4jTg1j08zDqMd
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1762763271; bh=ZuM9/lVYSErfL/ws8FIC2iRtqVZqZc7sKgCamFMxYmo=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=QaEipi6qSyFOd1kaT7mdz4aG683FIc7kv+XK+rGg2OoJ8Ky+/OniqcmJn6XE1jPkL
	 eKFXtHuSx/MhVkJVtsi0ufKYgRVZNDF0QnxmakXRlDRv4NHMbzcTHbqruvFKBG0Jmv
	 FUc0L7IsJz995ekEDEFkVWFXrNzRxUuWjT6A1ICE=
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4d4jTY0M56z9vZc;
	Mon, 10 Nov 2025 08:27:45 +0000 (UTC)
X-Riseup-User-ID: A8DE5B88FDCE7E6D4B1020FF1AE95E8AA54A292A615C1D1E75D41E35F356E308
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4d4jTW46zCz1yvy;
	Mon, 10 Nov 2025 08:27:43 +0000 (UTC)
Message-ID: <5e8b265d-7a0a-406f-b165-9f03f90c12b4@riseup.net>
Date: Mon, 10 Nov 2025 01:27:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: axboe@kernel.dk
Cc: axboe@fb.com, ematsumiya@suse.de, gwml@vger.gnuweeb.org, hch@lst.de,
 kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
From: Scar <scar@riseup.net>
In-Reply-To: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Done

https://github.com/scarlion1/nvme-led-daemon


