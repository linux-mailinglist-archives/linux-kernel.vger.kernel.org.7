Return-Path: <linux-kernel+bounces-736491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD2B09D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2A85A1940
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316F2192EA;
	Fri, 18 Jul 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H65CFXGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020719E975
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826523; cv=none; b=qOOPKysjCCcV3w5ZGP8/7xpMF9dIqfRy+J+IpuMcLE0/3RGNMmyQE/R9omAuu3yjMcdtGtnGv4MeCj/0V7fRC5FF2poq8UoOndhRBw58LFcaXDlIivskDM+o/JT1N38vZtRk/35jbfT2j3hQZrBmcAofmUS/DRW7JBDk34dPvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826523; c=relaxed/simple;
	bh=BaMNlicxw19Tn8iKcW5cgrTkMXZiKb8cGF4skENQg4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk8ZYC0/9yRV6an8m+1UVr+4e3aYEHl8Kl0Cc77gSBEc6nyCLV2SJHlYR/sFh3hWIXkxFQQZrLi/yNT6l2wHFNmtpv8MJlcA8Fw+Ya4Yh2gIMsherJW/sR/APUy2NAJ9UR6rYjLHTCToMc963Zq7baP3ilPi/jZMLPtueRF1Z8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H65CFXGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B1C4CEEB;
	Fri, 18 Jul 2025 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752826523;
	bh=BaMNlicxw19Tn8iKcW5cgrTkMXZiKb8cGF4skENQg4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H65CFXGi7SLFZxOZhXW8Sj/0xMdMxuRKbR2Oql3/dOvKbJVCsiFi5kRwLIVDkeb/p
	 L7r27AX9+WtmRXFTmvW0zhZq9wLKg+y1LtmeJxQsRtaeq2zuFJC+n7KqLhwo4UWejl
	 B25ezgwUOIyaly1v96CYt9tEtRQZ5MpizzhJvUfKN32H2aMbriUqkUs3GQzKsv9pT5
	 ZEgyWgbZM2Ws5uJOgYD3ns6wXp6pux7RmlDRdJ9D5N8KJJABEln4CdhLPoSVNWv4bP
	 O96CIqcmzfVjmGKknO1orjggxdE4klCBFRjNIXqcJ6UMllLo1cQRFqZNJrsHL/k97g
	 IfhHWs7SSIfeA==
Date: Fri, 18 Jul 2025 10:15:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <aHoClrMYgaZwzfeL@ryzen>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>

Hello Kamaljit,

I think that the patch looks good.

That said, the Suggested-by trailer should go together with all other
trailers at the end of the commit log, see e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=a4daf088a77323154514eb1f8626bbdf9329cfd4


Kind regards,
Niklas

