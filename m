Return-Path: <linux-kernel+bounces-763311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764FB2130D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA20A7A2BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832122C21FF;
	Mon, 11 Aug 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MWyn8JCm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92F296BA4;
	Mon, 11 Aug 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932959; cv=none; b=nW/HN/vnYYpIOAxo9/3F2dXSUH+Wn5HGG/vuvXQwz9tlaHGvBuHmpArsuEM6Gf/Cex4MLQn2z+LUa5CCxUkm0mh6vYEb8GqSFls2cRlrGZvZPQhaTybQSlxpSICJjNKySr0n5OWpLoGeuIT8HfABoIrYKZBVCmEvNgJV8moALDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932959; c=relaxed/simple;
	bh=+JtSPNKPdWFKznBm8lfK05IFYI8HI9LO8vyxvDGoPag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJltcCUKW0Hd0GrCTguH6RqQtSizyV8me6QUkSYPGeSk9IN6NRGahAfiqWW8jqoNPQ9rP0gLXuqmXkqiu6H69138YD72WUm/mCLpF242cktgv4KSNFVn+ka4n66Onc8l5xUejkM1bhxOimKyORcYsw42+inMvb2k4HSXAYqJWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MWyn8JCm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CADD140AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754932957; bh=GB4ri+sJUuLNf52T2beXVRvzEOZZwVUhyjpbGbpS3ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MWyn8JCm9gaR8hu1GdbQhzyg2ZTFj0Fdst7pwfaVJYsVAzlaYmFi4GOFt9sUHxiyS
	 gkqN9Bmh5pdoZ4aP9AWiHoKnJ9KAeJRWHxDEakkKODU2aeLOAf1/XM3DsjSa74/u5G
	 XR8iSZcwVwwq8p2/zxZgWWpth6n1wLjJBC1i4cGNAhs5qps8Qz4jiSPhXO9LRZh0Vf
	 a4WN8owgS0J+olwZ4mCCSc3HqMWvuJfpg8ax/Gvbz1dZj88L5jMX3iZjUtb/wrAtAZ
	 zdwWj8Gcx/r/H4wiSg1Z7hFZF4Zl6PSAks55yey5lb68QYR0CusSHe0xFxCfuvEA1s
	 cJy4Qjv+X2dEA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CADD140AD9;
	Mon, 11 Aug 2025 17:22:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] Documentation: Fix typos
In-Reply-To: <20250723203250.2909894-1-helgaas@kernel.org>
References: <20250723203250.2909894-1-helgaas@kernel.org>
Date: Mon, 11 Aug 2025 11:22:36 -0600
Message-ID: <87v7mtdb8j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix typos.  Based on v6.16-rc1, split into ABI and other.

Shockingly, such a massive, tree-wide patch fails to apply at this
point.  There would be value in splitting it up a bit.

I *did* just successfully apply patch 2 (Documentation/ABI), though.

Thanks,

jon

