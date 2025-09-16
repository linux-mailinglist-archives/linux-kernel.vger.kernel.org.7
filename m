Return-Path: <linux-kernel+bounces-819416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6FB5A066
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380A71B25943
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EED27E1B1;
	Tue, 16 Sep 2025 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEM3F4eW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB726F44C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046615; cv=none; b=lH9LBgXMaA9tDuVoDVg8991aRd/jvCr1RJr15iGLGOzkK5oTOSERMrYTkmF/PsyXiS50M2Jcu9+2nywGGxj5u4B6E5eGhUrQkY0r0LIsjpDorrEZwc2mi5y14lZxnGQRTZP9BuXO7LNxtDnDBm6K6VSfDKy3iUOl3ThEgw/EMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046615; c=relaxed/simple;
	bh=su2izlzuG/f0xJC7Io7YPy3C/eDeylPVEWoxq6tJT4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwPj4sXggDIbwMoYG6LGvdTGCJy7T+xU4ft+Mf6ZOugeQInAHfG3D1OhjJdXqL6hUMD7gZdzkorxmI+Yv/0cVyNR4T+07y0gyv3khuycOuIH6ObSigKkIjDBXrXSVX1gVOgYa0w5XuGDBoYvTRglQdecHhVlu3fp4heH/Tf6EWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEM3F4eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334DBC4CEEB;
	Tue, 16 Sep 2025 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758046612;
	bh=su2izlzuG/f0xJC7Io7YPy3C/eDeylPVEWoxq6tJT4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEM3F4eWVRZrwsQCxAQpGMnzqD+2styv4Qrook/lNKTuyAQEMJRge/DB4ngOTDV1X
	 DLux9GAouFv6clIVp8xTmgo0n7p4ObbjIrtp6g5qGqf1xMQWc6tW2AXh2AYoVUl+b3
	 7yqNoBiwRbq8/UXiTpxPoIzHdgmvGgFVHWf8IYXuNUNN5sDdrmj7ygJdaENT/pVwI3
	 Rre0K1J2R6i4kVW9kNt2w9DCcsDt6TzsoDV8n+weX2A47uGjPeLjkrUKUCk2rrt9PT
	 HBDuqnHdUEdgUFsu1kE5xGqvng0nqNAczTdNahVhDI8NrYFqZPnGGsU7mPMkU+CF8O
	 PrrGH7UB9TiOw==
Date: Tue, 16 Sep 2025 12:16:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
Message-ID: <aMmpkm6WIwr-uzOL@kbusch-mbp>
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701205630.64031-1-wse@tuxedocomputers.com>

On Tue, Jul 01, 2025 at 10:55:49PM +0200, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
> a high power consumption in s2idle sleep (3.5 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1 watts.

Applied to nvme-6.18, thanks.

