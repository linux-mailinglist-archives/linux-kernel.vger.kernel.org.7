Return-Path: <linux-kernel+bounces-606220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FFA8ACA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 02:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6785E1903A65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 00:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294EC1ADC78;
	Wed, 16 Apr 2025 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I22rkLh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8534C1A08BC;
	Wed, 16 Apr 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762985; cv=none; b=bp74TFjSF65zEbFm2zukPqwpvUdPGRcau+3ZJU/k6lEb/FjjUTUY8pbBzkPEhMr/eDfZNU6mygTan4d81P8fhEhT8ywYuyZFZ1foOvEC4hy5Qr+BIpFcoejKWOfTX3SLtAALMhqi+H1ZZwJwkzCS3SLKMGWZPVmkCaFyjgZwqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762985; c=relaxed/simple;
	bh=CTthpzl61pBQ2VZZi3PvIwU4bwtbRqeibOyOUdBhm9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kli17FCkprqXDjwbtpoT3xETFcqhJwTCpUmL0gifeKppUGa9ZptJKNtRwJrf9CxMimbJ83mfJK9QE07/Y3a1GsMhilV+sJCP7y0gxNnBjXoya6+HGt5W5hrH8T3FVIDqvdpq8eXhstBY7l8oHGA9u2clAWmb6d7yfSpvexNCQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I22rkLh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D655C4CEE7;
	Wed, 16 Apr 2025 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762985;
	bh=CTthpzl61pBQ2VZZi3PvIwU4bwtbRqeibOyOUdBhm9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I22rkLh2DTCKTaKQDmCJJUMh/1rplbgonaVyfAN1U2FT0Cg0MHbnS08/75Q1H8Clh
	 RHlVbEmDXoEOOgT4inR2Xv7gMIDGlbWcHBJE5iJcBzv8RvD7VySkcKAno5KxS3dEu4
	 4A26o67/7sjQ4bLv7qmA2ujuhWiKin2qGL6gS1yI0J6Cxhc+vLYrKNtGSI7PvKVsEQ
	 QMzaS5mi26JyMtVEpqEQqXhSh8JomJftnOlW9STevsPh4rHU4nrNgVl2i9N8kRvP/B
	 hCK3JI0tSDzrFMHrncPnMbMSS3MNbWNLeP/RkINYi/vsGfzA87UiNe0nyZujILR7Wr
	 7Hb21w/YGMU5g==
Date: Tue, 15 Apr 2025 17:23:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v3] rtase: Add ndo_setup_tc support for CBS
 offload in traffic control setup
Message-ID: <20250415172303.19022025@kernel.org>
In-Reply-To: <20250414034202.7261-1-justinlai0215@realtek.com>
References: <20250414034202.7261-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 11:42:02 +0800 Justin Lai wrote:
> Add support for ndo_setup_tc to enable CBS offload functionality as
> part of traffic control configuration for network devices.

This is some semi-switch-like device right? Or am I misremembering?
Could you clarify where the limits are applied?
=46rom CPU into the switch or on the switch ports?
Should be documented in the commit msg.
--=20
pw-bot: cr

