Return-Path: <linux-kernel+bounces-780807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2894B3099A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00512608384
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14272E1F13;
	Thu, 21 Aug 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blv4cw1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CD2DE6FA;
	Thu, 21 Aug 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816615; cv=none; b=EgGD0gn+6eGnvSLJBTSqIGcSH0SfyQ4ZwkZdnym4LjH41i+VsBMkyvH6fMxP8ieY5B2TPJvotZ6lx0XkQSnhwLE3MZRkwH6amHSNeBwVToABLcWtN0jbeT02P/yLYRbxQpdUZ6d2Vqp25OKNeM2zRrhaHgv+pwNCFfuRsM+v+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816615; c=relaxed/simple;
	bh=AzUl8GpgQatp4y2sd/ouKR2sjkwdYepIqz7eXB3KrGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4s0ibOKPtapDLqIWzEDfDCqiH1gZS3gkDKbwOpg7kyEnIDuK1Slv7USHRVeahL7kMyXjvZPIZsQ7qq402We0vu/f3kgET4dy6hJ+Xca2z7PtF0KMOXqqdOL/RqQYOexl2Vnb6PSkxCwLicBNTumHYqqB09loaU/hkDZn8o1MVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blv4cw1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D59C4CEEB;
	Thu, 21 Aug 2025 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755816614;
	bh=AzUl8GpgQatp4y2sd/ouKR2sjkwdYepIqz7eXB3KrGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Blv4cw1R2xcENv1I1bvYGYtoH8Lxbs6sY0SNBC/uLgjG8XWo692vWJ09VjyuwVrEC
	 A43WHQa5EWzI0EeFvixE3TlxamiUlAu+apezfb2O85R3pRUgmGK4rlzLdCxWNI3WiN
	 knkZbvtcE5jjH/2n1B0+oeFtJTZYpm/w98xj3JZtBCjXwpgkiimQhgiLYwTX1Sp4TK
	 2qGW5HVAh2FkJjcgiwrC0pf4sVhLdJTCRUQFwgzLs9zqx+WnXF2WVQSCbkhURKKWxg
	 F9uV5iyvmt9+LXnAigiea/bHq0+WHgskdy7GiwZCCYj70aZe0jiKLORyQzo6jN1a/r
	 phVVMlA4KCBhA==
Date: Thu, 21 Aug 2025 15:50:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <zhang.enpei@zte.com.cn>
Cc: <chessman@tux.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethernet: tlan: Convert to use jiffies macro
Message-ID: <20250821155013.52e56218@kernel.org>
In-Reply-To: <20250819161616455E67Ux3eifLtzWBrN8i6Fr@zte.com.cn>
References: <20250819161616455E67Ux3eifLtzWBrN8i6Fr@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 16:16:16 +0800 (CST) zhang.enpei@zte.com.cn wrote:
> +                       if (time_after_eq(jiffies, priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {

Better still: time_is_after_eq_jiffies()
-- 
pw-bot: cr

