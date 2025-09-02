Return-Path: <linux-kernel+bounces-795814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A0B3F837
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196917A8C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF02E6CCC;
	Tue,  2 Sep 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfcUforq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9617555;
	Tue,  2 Sep 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801394; cv=none; b=fgCQi8CJC1R/FHrv7D83YRrkayyXylMhshjnDvIiV40yZKbhEnBkwZ0TXdOQLhTviCQe3zHR2SDacuhTbUUcRwHq0F1Q1ph9Hav6CIItTw2mDDp45EYASDKbVTchkfs1XEpzyIn3ZDj35HQe91RLZhTB0mN6/PWjrYkD/dohxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801394; c=relaxed/simple;
	bh=D7Jr1RfmWxHJmGMuNJwXaBj/4RwRt61Lsyk0u4oikIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qMFkfWv92P553ptVYWpmsPX+0ZRpPFgSJbEV462Rs8OFb06I9FtClcnlre2r9zejngu5V+PljBFaf8W3EG6+cf9Wl3dzg3Z3ylH/j7SMa/zgJXAoqTZEFYyq+WjzGsEqJAad3H3dNK1Wy1d0vqNkt8SgBk6qU0QpCqlvWED/d20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfcUforq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE11C4CEED;
	Tue,  2 Sep 2025 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801393;
	bh=D7Jr1RfmWxHJmGMuNJwXaBj/4RwRt61Lsyk0u4oikIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EfcUforqFb0XtVu5hkdRIErH3maPCUeqfp75GNm55indpRWaxQKK9sSxxQ9YaI1zR
	 +xcg2WF9VN4BNM/54fFh+Q8s8n2+9LN/tCLyo3Dz40fM4fZOZ84aefheFD/0MKKuXg
	 RCeEcAeq2LDhWCb1XjZH1Jsl6cbx84W07I5Mor5OcRd4yXgszd/hRnRj7r7lphgIAH
	 FkUuPnV8iYJWfDCTgTSmLi1OqMxu8OHFrP7FeQaI4JjgwSmKjMWy3uhhGco3R7BB7d
	 FA1GtbWuSnHNeps8YSWp73Flnho6ks1GMcXPDCFQm9DNRDlzhlSurABC2WplAhqyau
	 grprVA1WjTusA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250807132909.3291770-1-robh@kernel.org>
References: <20250807132909.3291770-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: aspeed-lpc: Add missing
 "clocks" property on lpc-snoop node
Message-Id: <175680139153.2190944.6070606106067900940.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 09:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 07 Aug 2025 08:29:08 -0500, Rob Herring (Arm) wrote:
> The ASpeed lpc-snoop nodes have a "clocks" property which isn't
> documented. It looks like all the LPC child devices have the same clock
> source. Perhaps it is the parent device that should have the clock, but
> it's too late for that. The driver for lpc-snoop requires a clock to be
> present.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: aspeed-lpc: Add missing "clocks" property on lpc-snoop node
      commit: 737b9ec4514ea0423eb049a3c27d8a22d61d03b5

--
Lee Jones [李琼斯]


