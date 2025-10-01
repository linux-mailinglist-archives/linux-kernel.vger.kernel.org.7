Return-Path: <linux-kernel+bounces-839115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC17BB0D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CCF2A696E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE88264623;
	Wed,  1 Oct 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i+WuAo1C"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291D2868B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330181; cv=none; b=WS9nCTiCH05TmASWQ4qoj7B/khrdSxKN2/Dv4FQiC2ZecrT3ZTSsIZsAT+CJcmB1zLZkyepJenSjor1BdAme3nKmuHzrEQIBJXZjaONisOKr+IODd4SWJCDF4BrE3CIphiHvng4x43SFJnytjAhP5iItXPTgaLnEOGLeIcCmwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330181; c=relaxed/simple;
	bh=+w9NjcsiicJAEUo3EzWiAH/IE+n1vDtbrhogIf/eJTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeENT32DctyH2ZNsgIkxDtGFmtPlNL/aAk5zHnWW/am9RfMfNA7dFHq6oqeC/AXvK/zr8L3MrvRaBynaxlhtinVYeDJ1Ip4njCuxK9q7jNyYNhZBLUlMP07kFATBoLFzoOx4j69aTDbhm3Xuhz1EkabV06crTlXq24JdTTBO5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i+WuAo1C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+w9NjcsiicJAEUo3EzWiAH/IE+n1vDtbrhogIf/eJTQ=;
	t=1759330179; x=1760539779; b=i+WuAo1C3NUyRrDT5woJm2uI5eOTlOTmpgSuCMfmBvJpFgY
	yYgQqJ/S3aQf0RqCwwknane7VA/mZnGCxe+2eF1FIePs+jVxLUSIK1sJKl6kXHwoKBwKKSSE1QvDb
	9CMr18X1fw2zug7WgrKAPioLtPzUMYI70SNWraJEmCH8uZB+cPXYglSFd5CSxCmj5VB9XBHhRWMZS
	V1VyFLUusK6ckRL4l16Bg7Qbs7zmF4duFsL4fKgtrXqLyVuBVwMtQdZ0vfTTeMhYGrjiBdR+N0Zp9
	UsKphVdRUXbBYWalptVqWHwOw4CHA0rxpczV/CRzKkszp+Tidz0Uw53w0BFv5W2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v3y95-00000005y4F-1TKn;
	Wed, 01 Oct 2025 16:49:31 +0200
Message-ID: <1a4ee34782868893a237ba70e518dca17147f013.camel@sipsolutions.net>
Subject: Re: [for-next][PATCH 4/4] cfg80211: Remove unused tracepoints
From: Johannes Berg <johannes@sipsolutions.net>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 01 Oct 2025 16:49:29 +0200
In-Reply-To: <20251001144625.373974129@kernel.org>
References: <20251001144605.585204794@kernel.org>
	 <20251001144625.373974129@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-10-01 at 10:46 -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> Tracepoints that are defined take up around 5K each, even if they are not
> used. If they are defined and not used, then they waste memory for unused
> code. Soon unused tracepoints will cause warnings.
>=20
> Remove the unused tracepoints of the cfg80211 subsystem. They are:
>=20
> cfg80211_chandef_dfs_required
> cfg80211_return_u32
> cfg80211_return_uint
> cfg80211_send_rx_auth

This is in net-next [1], should go to Linus's tree whenever that is
pulled [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3D58febb47b961a91d0d12ee0c1618a7843c0908ce

[2] https://lore.kernel.org/lkml/20251001131156.27805-1-pabeni@redhat.com/

johannes

