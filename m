Return-Path: <linux-kernel+bounces-771626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA3B289A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E91C8125A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C784169AD2;
	Sat, 16 Aug 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6BCMp9f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF2C9D;
	Sat, 16 Aug 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308421; cv=none; b=SCtufpsHXLS8HRQ6NgGg8OjSoMNzAOoHo5SYaYDz65xVI7S5JRXcqbzjBQ3CQMpKYo1v4OKnK3/cWA077xCpM7ZJCSw6Q3vBGo/m7Lyt6J61D94N/XbWBsN4eSHo8YvR5Q2Fk2Vw+EFGqmwFmzfB57JhOUhKhVPuRAoD48vfSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308421; c=relaxed/simple;
	bh=mqCCGSPdoxK+LxRSF9eYSxD6rU2WTzpgNn+Foq1tSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2WVnQW6i1jCic0bvN1mpNQPT7gUVQp98WHUIHTEASDQ5ZRdrKqYYR0wQWnsNS2QcKJj5vf3tHssP0MRlB5Z+Mo9TTwN7g+byuV4/Q4mpVCLlC2gpDMfgar4k+BPeY3Vki3HIQxB7Z07USBv3J6Qkthv2DAmzWHCuLDtvyHyK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6BCMp9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F46CC4CEEB;
	Sat, 16 Aug 2025 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755308420;
	bh=mqCCGSPdoxK+LxRSF9eYSxD6rU2WTzpgNn+Foq1tSuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6BCMp9fIp0bRRgSN0ehT2JHUZAe5Okkg7oLDDItCpPa9Uumse4aGtFlsYxj+Sh3x
	 WdsK1Hq7aJCY0y40bcoahIFHe91racFFb1Ui1oDMX7rBoD8GbgPLrxFW15QLtEmiw/
	 LwYaGABiBwn5ISLZCAQMVC9+kA2NZ9Qkq56WqwFpylMyvostKjgCUoAjVRm+QbT1n2
	 B2wavyg2lvcTwgcKn5QBlbEzwFiOy3HyhxJIGzNJWFdQkMrmXJx9eEo/G3JLhQezZ8
	 LNYhdfwJOXcQ5nd9UmHhQdJgHs5A4bLRLCxshJmpk9Bql6iBYMDPrqs+i9jSWAes0N
	 xGLsOGfzA6hzg==
Date: Fri, 15 Aug 2025 18:40:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] microchip: lan865x: fix missing configuration
 for Rev.B0/B1 as per AN1760
Message-ID: <20250815184019.68116359@kernel.org>
In-Reply-To: <20250813103355.70838-3-parthiban.veerasooran@microchip.com>
References: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
	<20250813103355.70838-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 16:03:55 +0530 Parthiban Veerasooran wrote:
> +#define LAN865X_REG_FIXUP		0x00010077
> +#define LAN865X_FIXUP_VALUE		0x0028

Looks like the application note explains what this register is and what
is the meaning of the bits in it. Please break this up and name
properly. "FIXUP_REGISTER" and "FIXUP_VALUE" is about as useful
as naming it "REGSITER_AT_10077" and "VALUE_28" :/
-- 
pw-bot: cr

