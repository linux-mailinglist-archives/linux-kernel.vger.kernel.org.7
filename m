Return-Path: <linux-kernel+bounces-827832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5ADB93392
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A3419059D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D431AF3B;
	Mon, 22 Sep 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY0Rf10L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5C31AF38
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572793; cv=none; b=t57WSl2IqSYUGfIib3lomyAJQ2yXXAtOhNn5XfIlXxG5Rfi/M5fh+RuHXEb4nLSOw0UvdigmMnohz3RLVC0A39cKQes7I3v1YBicxjheUw22P1T0ulMxxuAZjTVEilyyZViKYHrfnNHF1I/B6rsBPnfD8GeDVVnOiK8fYqCTOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572793; c=relaxed/simple;
	bh=8oWJdKf/4213hglSrCtvGHw3q/14fgSfvO4+9cSDfzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ1quQz1oHy6tL48nQF+jWQ+aag6JOLVjC9MyFm/IZ87bGdbuT9UzoseDl/YjrgBWt75riD9ZOzihZwnF4VsUJjDHAGVUcoI9UL0YrbMBBEeuV/095ClhDnxFelyJasjM+yfiyNbl+7eCEPibaCytanpw7ejx5JBIK/xq+K8ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY0Rf10L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A5C4CEF0;
	Mon, 22 Sep 2025 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572792;
	bh=8oWJdKf/4213hglSrCtvGHw3q/14fgSfvO4+9cSDfzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY0Rf10LOyLy9fSJ6oXAM8+AYeRzhvYk3StGONj6sjTDBst8MQjcCJT704gzAb7U0
	 A0G/nHFM2xPa8Mmh+g+MSyYa73omhh5h8KWvN6VC6zZuCmKZ3rrAtRAEyzLLQjZokv
	 GoDAhJwKz50kBADQ+XH42fZEfrBvH+mZX70dpBmQgy/pwiP5ySgTlRxnZACe6khbwj
	 po8PM8/ZF3pPVg3YEPV4WhNbuAjzyVR+qdDkhvmhWxO3B1UbJXUVNpNCwESMfF//Gy
	 /SKNXklDqLhdtbxn/79xyg02tpQ1SoHqrkbvq1VA2Iq1ohh+gYNzl/lQ1hcC6NWYBE
	 rZ3p+un10Bk4g==
Date: Mon, 22 Sep 2025 14:26:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
Message-ID: <aNGw9mXBcx1-g0ee@kbusch-mbp>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>

On Tue, Sep 02, 2025 at 01:52:11PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The NVMe Base Specification 2.1 states that:
> 
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
> 
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a non
> zero value to avoid continuous timeouts on the target.

Thanks, applied to nvme-6.18.

