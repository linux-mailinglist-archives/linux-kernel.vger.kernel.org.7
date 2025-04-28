Return-Path: <linux-kernel+bounces-623612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C59A9F83F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 20:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5705A1A847F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD429A3CB;
	Mon, 28 Apr 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjxgaQo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05672296145;
	Mon, 28 Apr 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864063; cv=none; b=Z0XbrqNvHNF8gWqXmtRViW4Ib+aDJa/gI5go2rA22hTnU90Q94t99P7G60elscg0qCfdatB1E0dF4WKn8g9DrRdWcmUiwj5gKEFXazNvYtGUGaz/jgXC6zzo3aBcM3Qzm6+px5fmbt3uK6YhnRhysMo88QQUe9bNVWjtmk5bUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864063; c=relaxed/simple;
	bh=V/IQhGS2b9nx5FaAzRZuKyVKEnejhV3AORkajdzukH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+ov3yYhmWZjFOr0rI/fneBJxA7xX1tjAH7EqD2h7xFAoMywa7EVPbUas9rZKVc0iie2dYLiJ6ycUs9lDZpQ3AjIWnkAGyTKCGbTyoWfJpUk/+fdXjmMDuQkKawpsCnu7kj5zbI4HMEZMd/knbeOz7JkCeHr+tkscM0hT00HupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjxgaQo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B873C4CEEF;
	Mon, 28 Apr 2025 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864062;
	bh=V/IQhGS2b9nx5FaAzRZuKyVKEnejhV3AORkajdzukH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sjxgaQo4/sNAE+F9HaExsPqtrgVET36rFOg+oh+O/bbe/Z+dOHr2A1Oz/joAg9PlM
	 NPrPsbh8/q63xx8R4IfNvsw5ht7SGE/CBSgwO0CdR7tQnCHOV+TkBR96meHJoeggt6
	 pnilYg+Ox0FgfpcBsTuRSD+O4wJRMR/uFVKImKZ6+llFFKQ14aRxZagTiYngmP7Dvw
	 hyjy7eP6+ozY9YcFkEDiewZs1ifCk/kGv03lrfMd+1OEs84Xoxgj7W1SOlFZsEZsKy
	 QHdALbRz1ZmwuiltYZwNTleVu80No6wZnF241xNws3wU0Y215xmfZgTz122aSk1Ktg
	 pMs5gUjfapWeQ==
Date: Mon, 28 Apr 2025 11:14:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250428111421.399dc60d@kernel.org>
In-Reply-To: <aA80qh01gosQvPEh@pengutronix.de>
References: <20250422123902.2019685-1-o.rempel@pengutronix.de>
	<20250423184400.31425ecd@kernel.org>
	<aA80qh01gosQvPEh@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 09:56:26 +0200 Oleksij Rempel wrote:
> > Doesn't apply, presumably because of the fix that's sitting in net?  
> 
> Needed patch is already in net-next. Should i resend this patches?

Yes, you need to repost.

