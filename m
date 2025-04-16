Return-Path: <linux-kernel+bounces-603962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF624A88E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529E818968A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8461F75A9;
	Mon, 14 Apr 2025 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uluLCMIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108131F418C;
	Mon, 14 Apr 2025 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667487; cv=none; b=nCUDqSpqtfNxL37xFsa86di13blcKbWlyn22mZUyAUMXZDdG/anKlNBTBuNIyVOq78YvnLGh680R+7WgNQjfbk900NT9TmSK7GrZMLvhaoP0p54s2IPNSFtdTtawzsFNHT//h7j2bFFwqjqPjaX4TpWBHSykTGcK8vvgSjArCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667487; c=relaxed/simple;
	bh=ZnQJt8KWqoC/Bdzd0TUu785MQNxC5WK3nuj32O8nzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+qD4DC96/Ex/iWon0hQ2z49ZpuD13Y5Q2QpLTQ53/lTAkkA2adqaXjpQJ8mHFatWdZicuZwwl5WWRBEseyM++kIkkC/5IxDpPuVvL72VfNvvUDlJwCcO4OvZnmWRxr7wozgfhMXOAUDNN7pAPhoB+DU4WQV4AoF1Z+R54hoihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uluLCMIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46331C4CEE5;
	Mon, 14 Apr 2025 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744667486;
	bh=ZnQJt8KWqoC/Bdzd0TUu785MQNxC5WK3nuj32O8nzeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uluLCMIe9flp78x2qe1VmduJ6A8rPzAozqhUaIOS64uIh4uSRjQZUT0jWyDFgMgNN
	 0/peI8SA/C4TkLBB2soPkiZweaq3ONFBeEUUP/HBbLq/iN2wmOcMr1i14MUY8nmeKT
	 ZoSCL4hDiG6bgpNK+xjb8+hkaw4UoE5uRrsse8SDWZ7CTpZzzR9rsmI332MfIKY1q8
	 MnG0bnqwVdom7ZRGIpbjQB9nyPqkZaSYlbNraYVD0rNX98WEtQrlQaMEeGMORG268r
	 zVfg7AlgiFM+EAr2Q8HR/iVbxLH2VBwlZY9EiL4zUb6rfr3qiJVUa5Wk/BxcNZvfrJ
	 W/IVjY3dzE9oA==
Date: Mon, 14 Apr 2025 14:51:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 09/11] net: pktgen: fix code style (WARNING:
 braces {} are not necessary for single statement blocks)
Message-ID: <20250414145125.4db4368f@kernel.org>
In-Reply-To: <20250410071749.30505-10-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
	<20250410071749.30505-10-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 09:17:46 +0200 Peter Seiderer wrote:
> Fix checkpatch code style warnings:

The code is fine, these aren't worth addressing.

