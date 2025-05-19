Return-Path: <linux-kernel+bounces-654681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B95BABCB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D643BED47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9252B21E0AF;
	Mon, 19 May 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJoeUOoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE1BA3D;
	Mon, 19 May 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695371; cv=none; b=Av/0OR+ZUFXhnEefK0zsk22nznCsX+uJ587waRCJn9s0BC9PQg3P3lQXWqXSwrvycA4u/6GY0QfWEnuCufIqqRckq6BhL7ez8XDwbTa8bSk1spREvrYUNuq6nrXxbJGKPljcSudwYWgVhJ1cg6JGdRoluZSi1Xi8XUf5JWiDnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695371; c=relaxed/simple;
	bh=RZurwyAtv0WfgKZ2F0HdGluuP0IOcLwe+hDseJm0m/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrNenGCqML8Yi8i0QXa/rZ09rmsj9DZ6UEPqWLyMC/sUvdRZdvwNlvkAT5XOEnKHkB8xvnyBHskMheZtR/l3ttosh5UDrvd/vdnj1b8FGD+gfHPhMAFp7maydT6Ceq98evk/cllZ8rilIUssz3IpHaAVQhxN8n3xwYuYAfj7hWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJoeUOoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A810C4CEE4;
	Mon, 19 May 2025 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747695370;
	bh=RZurwyAtv0WfgKZ2F0HdGluuP0IOcLwe+hDseJm0m/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJoeUOoiOdzrkp/wvp3WDXC+m8qryIiFjF6GjE4UrE4eH3hfZReWap/OvdwRZzTOQ
	 ajYMqaHWTQLBMWs2jl9Cldw86TJkgIJYYit/P5PcPDI/VG8FdWA/DaBa972ZPFkWkk
	 RtpDMZLjIPBam0My4F08COMf0MJP2nVN9fZ+b4gihC1k1dCNvRcs803TVzelcEt9V5
	 kD69QTRwPJurdKjjODlASgbYV9KL/3FwAdaQ80d+7IAX906cFHisC5kVt7Y+gUhDa6
	 tCuYCHqNnvjsW3ZE0YoOsu/IC3YuBL2Vw0Hs8GJlM/5G/aGbx+txwH9nqGPl49USmr
	 G4qaqu3YQw+Cw==
Date: Mon, 19 May 2025 15:56:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Thangaraj.S@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <Bryan.Whitehead@microchip.com>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net] net: lan743x: Restore SGMII CTRL register on
 resume
Message-ID: <20250519155609.469e767b@kernel.org>
In-Reply-To: <067713e1ebaf303fe4aefb9c29cc7e1b70cd722a.camel@microchip.com>
References: <20250516035719.117960-1-thangaraj.s@microchip.com>
	<20250516164010.49dd5e8b@kernel.org>
	<067713e1ebaf303fe4aefb9c29cc7e1b70cd722a.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 09:23:56 +0000 Thangaraj.S@microchip.com wrote:
> Raju Lakkaraju is no longer with the company, and as I am
> currentlymanaging this driver, I have not included him in the CC.

Understood, let me add their address to the ignore list.

