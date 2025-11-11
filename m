Return-Path: <linux-kernel+bounces-895735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD6C4ECBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16A224EE670
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AB365A11;
	Tue, 11 Nov 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dShHYiQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1918365A05
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875029; cv=none; b=TaFbj3nGIV0SztYUrvory8KmyLLpgzXI5A4592oTY0NmLpYAoBRb/h1FwTBO/uTlehRVm6oS92Mzs2HD/8hwd8W44q7MS18zR3OBoQ7hDvkWsjKLaBO0VB6rmhNWMks8cas7G5mO9xX6wbmOujY3NAo8376CYH8PBJDHEQWBksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875029; c=relaxed/simple;
	bh=JkOquQXq7D/0AkSwonMEbLe8hcwxVugxIK3xFxSoQps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxMcmEpc4+KAlx4HdJzf5dxgQt3XFui57Am0/r/b5fQtHBpeMW5rzKIjJBlOcYiWVr8/Tzha7dFb4U8YACrMFgDJNJ5M0HlHg+Qs8tX5xGOvrM5Jm7whztCeQZwXGKmOtwgIveYGTTYeH5OM74Mw5Gaz+rQvhu9RSEV9oq7qRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dShHYiQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E53DC113D0;
	Tue, 11 Nov 2025 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875028;
	bh=JkOquQXq7D/0AkSwonMEbLe8hcwxVugxIK3xFxSoQps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dShHYiQtHGA+ufP4vo5h3F0Xob3mIuE7icZs/Ve89M09D9MuCRNNb+OTZUCX/U92f
	 PGaoyoj4XQ41J8b0VR7zB87qGnrC3UzrRCRX9ft2tsaFiFw6bmVrWguIkk5+XAwcBA
	 +5w0GWz8ntMQS07o7BzHQDmJOWAymQDu27hmN1IxUSkZBgH0p2lFvtyk4mpxuoCheM
	 t7D/F7g5oCcQb+HzyvfxFwglHAqy048nGtxRGiHTuzVX1HR3OnB8aOwJCABUqFJl2O
	 I0fC7CdXp+RAp4WuqUfZHET9vsXmZDtPfRvm1DO7bk4xkHJT+gZs+W81eV5Tm7gcyd
	 X0DCfZmYXXHVw==
Date: Tue, 11 Nov 2025 10:30:25 -0500
From: Keith Busch <kbusch@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, riteshh@linux.ibm.com,
	ojaswin@linux.ibm.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	hch@lst.de, martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [linux-next20251111]KASAN null-ptr-deref in bio_get_last_bvec()
 after "block: accumulate memory segment gaps per bio"
Message-ID: <aRNWkWSgsHhlPQXZ@kbusch-mbp>
References: <3349ddbd-ec27-431b-a5f3-de0137d26a4b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3349ddbd-ec27-431b-a5f3-de0137d26a4b@linux.ibm.com>

On Tue, Nov 11, 2025 at 08:54:39PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> IBM CI has reported a null pointer dereference, while running xfstests.

Thanks, this bug was also reported late yesterday and a proposed fix was
posted just earlier today:

  https://lore.kernel.org/linux-block/20251111140620.2606536-1-kbusch@meta.com/

