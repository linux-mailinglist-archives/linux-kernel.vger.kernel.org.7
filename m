Return-Path: <linux-kernel+bounces-740850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC82B0D9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3780C7A8EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5932E9EAC;
	Tue, 22 Jul 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGN9yf+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551D2E8E16;
	Tue, 22 Jul 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188293; cv=none; b=D8N5cArxL3pYUURvCpla3y6D5tQEPShtBggebCBOCXcJ6+36NLS0/HeI9T7tNt2q1OFu67E8eHHAIlglMiW0RSTI5TUl0AdBRmn55Bn3cycc5DrkAqFkFKCelTpgcGDTm7+qxp1GFKqik3NBZdzAwPJ+8WYRavoI24xWZHh5Ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188293; c=relaxed/simple;
	bh=LTP+X29U8OinALdzWxmJt0BbYlJ8HxjqisnVaKRqWTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC2hntqSGHNmgHiYh3Y1bgalIo34bTCv69VVsWflEWCZwhx9J+ZxWeS8fTCFv+cMlTzgh1A6nZSx26aEnLyv//YxEjdlcsWLzWN4sfuJVourksYp1rf8TKYzWBUQmS+2g6vPsokeHGm27MDKO2W2AdJY+20o15t1SF8+lin1om0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGN9yf+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A1C4CEEB;
	Tue, 22 Jul 2025 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188293;
	bh=LTP+X29U8OinALdzWxmJt0BbYlJ8HxjqisnVaKRqWTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGN9yf+gymgu/emqmM87rloRm8ydzhoczpcBLdP2O2edbSppA6iWkbBl3soJzuXWp
	 X38TS7ROSKR6KgWcQhRb9zTcIvZUEwZ0a91dCBela8lauPLSD4laxd00PIlGLcIFtu
	 4zvmRigCemk21AmWQVXv01HwFrRxWE2BH2PYW4bFnxFVI6KZR3m7qA0w4vh26kM7c+
	 NW4ZtgnHldOwzxcA+mMq75pUhppXDzNf+E8kv01z5NSpkhMx8vPQGXBPhPZbGOs6Sk
	 /W811gx8/frgvngJyeBtjVrfdV3A97IFjr6BVOAJkhizR9WFNdnBfejRTWx+QoXNdz
	 3JsNtm3SkkuYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueCMM-000000002YK-31Hj;
	Tue, 22 Jul 2025 14:44:43 +0200
Date: Tue, 22 Jul 2025 14:44:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Foxconn T99W709
Message-ID: <aH-HuqRx4VJebW3W@hovoldconsulting.com>
References: <20250721113919.28577-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113919.28577-1-slark_xiao@163.com>

On Mon, Jul 21, 2025 at 07:39:19PM +0800, Slark Xiao wrote:
> T99W709 is designed based on MTK T300(5G redcap) chip. There are
> 7 serial ports to be enumerated: AP_LOG, GNSS, AP_META, AT,
> MD_META, NPT, DBG. RSVD(5) for ADB port.

Applied, thanks.

Johan

