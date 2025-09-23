Return-Path: <linux-kernel+bounces-829783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A321B97D27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602A64A8552
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC13112D2;
	Tue, 23 Sep 2025 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBTVhZMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA82F657A;
	Tue, 23 Sep 2025 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671358; cv=none; b=FuUkED/yG2YVF1H0/IYPtuSQ5p4kkvc7kqjvaG4TG0lJU81GJQ8iYYvoDyrkmc03HMsUk/TwFTPX7lOZAxm5hjYUQfeG4i2kg3sJn/F3MG6zDGNEqulz5m4en+SbPI884OtMUlPQoAfPjKWbjiLlnPanaDfTdeU5KUNUAjvlh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671358; c=relaxed/simple;
	bh=hrLsdcZp2M4mpYAZYDY8MkkOj2h89n+GgXDk4sCMadw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2Hk/jQI1gLQUVLxT6vNtSjkJOdxQYC4a/F7998XZsS7IBmUeSEJh7E5Rk2BjNqzrC+Kt44IsQCo5F297ZdS8COI4CbZS1ZlWNeopCJgrV3Z6QznsIF+OusGlsw239Jxv4N5fjaZ/BPipsU8leAI+D+u20wyxDz9U0paVDC0MfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBTVhZMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AC4C4CEF5;
	Tue, 23 Sep 2025 23:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758671358;
	bh=hrLsdcZp2M4mpYAZYDY8MkkOj2h89n+GgXDk4sCMadw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBTVhZMzD5E9fQ75vqSi4ZivOhVB0Me1GWubmq2TPY+uYB+zJyNsdyxMeI24ohyEo
	 rCL+STk8ZJw34dQCXjVQhnm+VLZ8y/EeC/kGE8YKwHbM4x2HVOFGTqmIcYxVWmO0Vs
	 pTdz2ZhbWtcy2T7y8FBVtR7bm853zjhx97G4vb9zfUDuJYqhzDDbQrqSw5qi9vgHU5
	 bd/VEAJABdNHHs00zR7y5K9yL2WVjYx7G6faRdec6+zifypAGHj/dKA2LumFfiZkkr
	 IsNEcol2u3wyjRzx533VEubRe8VEmXU2DrlroZ7wMlHJPEAxbPSunuZJSTJagOmQL2
	 F/dc8ECJci1EQ==
Date: Tue, 23 Sep 2025 16:49:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH net] net: usb: remove rtl8150 driver
Message-ID: <20250923164916.5b8c7c28@kernel.org>
In-Reply-To: <20250923022205.9075-1-viswanathiyyappan@gmail.com>
References: <20250923022205.9075-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 07:52:05 +0530 I Viswanath wrote:
> Remove the rtl8150 driver, as the most recent device ID was added
> on 2006-12-04

Thanks for sending this one.
Based on Michal's reply I guess we need to wait a bit longer.

