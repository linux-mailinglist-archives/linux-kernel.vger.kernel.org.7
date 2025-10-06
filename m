Return-Path: <linux-kernel+bounces-842923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5DBBDFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 493EC4EB75D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC327A935;
	Mon,  6 Oct 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy/9D40I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDE226CF0;
	Mon,  6 Oct 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752760; cv=none; b=gHvfJDrPUj5T4rmr8x7arD7GFfdqBVk7ClynVNWZhipCmqir8d4KGqPoS7fkjkDPkqTIXriEGU1QvpghhzmB0rI9b565LXqNOakeS20aqWNBvp4EPyaRjEHHqVzVZyCzp6frlJAlOTOO9lmjvPeMtDmybZqotarOMS3bIwCp4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752760; c=relaxed/simple;
	bh=bkaPCawlkArbo/98aDuVKLC15SGhorii+T74N2c5hFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXWUbvL/r/cNp7tB7tApLV53c/0HR11A8gMdDVe/CSOIX1EWLNvx5fxfVr4p5Iz6gmBmyTbsjIuh2iXlYDxBg3zGhvd0VMHWLTAInl94FsWdt/KjLWEW8P6Bo+E4w8xK+jZUWd1CdUeSr6h+IBzKs8nVX+4oQlcyI2xuNtHePGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy/9D40I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ABCC4CEF5;
	Mon,  6 Oct 2025 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759752760;
	bh=bkaPCawlkArbo/98aDuVKLC15SGhorii+T74N2c5hFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dy/9D40IsdsXDMMy2+Z1O0oFkpUumCp3T5lqw2txx6gSqhUV0nZYTBJHjRozkP955
	 FClwKrPX/DGCR1hKDpoyNH9A1J9E64bGjAn5Reeal8TnMCQ8Ik+7KspiFUK7MqA0j4
	 7bBbHIhCalkeJVXPGwRKPCnh9cW66hhJaCtMXZ8sJy3jLVj3KhFrFGbcPpkhdfOzTq
	 wMWEORXHYCfl5c3zab6UMjnsJcqHXJwzNvmXkll0R81WmkpzNTmTvQJuUjsQtCQYKT
	 A+jYem+IzkomV+dCiLC9ozO1dcAxD6zQjccBMWuTlkQsp0IW/9QI0xHagvdlMKcUiQ
	 WatAlTiQvQGTw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v5k50-000000000gp-2CsY;
	Mon, 06 Oct 2025 14:12:38 +0200
Date: Mon, 6 Oct 2025 14:12:38 +0200
From: Johan Hovold <johan@kernel.org>
To: vivekyadav1207731111@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Subject: Re: [PATCH] usb: serial: fix: space prohibited before comma separator
Message-ID: <aOOyNpNL3YCrLIgq@hovoldconsulting.com>
References: <20251004065618.70151-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004065618.70151-1-vivekyadav1207731111@gmail.com>

On Sat, Oct 04, 2025 at 12:26:18PM +0530, vivekyadav1207731111@gmail.com wrote:
> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> 
> Run `checkpatch.pl` script on path `drivers/usb/serial/*`.

Yeah, don't do that, that is, don't run checkpatch on code that's
already in the tree. Use it on your on patches before submitting them to
catch potential issues, but always use your own judgement when
considering its output.

If you just want to practise sending patches, changes like these are
accepted for drivers/staging for that purpose.

Johan

