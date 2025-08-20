Return-Path: <linux-kernel+bounces-778595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95692B2E7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFAE16790C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5B127B34A;
	Wed, 20 Aug 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNoSs+gQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B30334376
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726665; cv=none; b=dWqr7BBFrOfoi360QggZXsDnq5u/ecCOovwT0tMt3VfrN2k5bvrWw6ugTX3LsyQwo9zu1PCarrnfSC8IPn6b+1WeDn7gnBvOv0nFucRNUeEASFmtOcyTGpFaEBmJwlnY7OCx9e5oaP0kJayt7btMQyb5Ln/SzGBcQVuLofzHRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726665; c=relaxed/simple;
	bh=iNwtBYePNA83SA5pocE4fjOSvyILpdaCkYud2gMR2lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onJeXM8QM2XqdMEDumK3NdDQtiLl0dnOZ4D0sk1JNWDh6qzt/eDV+TQEnFUwpxVkwYAGktB55vRDzWH/tqkcEKL5eiOy/Kz9Fznq0ZpIKQctk5AxKLVWTx708zP03sUlCXUyTEJDUV9TZrb+FiGWa3XfJJl30MAZ9LZb8pfhG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNoSs+gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A885AC4CEED;
	Wed, 20 Aug 2025 21:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726665;
	bh=iNwtBYePNA83SA5pocE4fjOSvyILpdaCkYud2gMR2lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNoSs+gQ9tEFIzJZ8Vl1TiQSfqBduFjlvUC1EdpzqPHY3j+ANOKNJBQK9Q7g2V7ZG
	 2GPnCPbYuDdUzvCUo8/EXN0C6DTd3nKWLlBgER/Sw4/UceqZChM1x74kooLTMwxA9x
	 ok0HeWLDoknz3R6+PVfRp8v9uzg/LdwuobC4IU+NcIvNgBjc2Nm/52qVONq1Q6IYG2
	 YblDxZ+GgwR94GCedT0MzPVy7O0ITBl5tHKRqOv6AB29G9RXgCOmwg9fPiLZTFfKPs
	 Ri4JhocvjbhmB9rLECeIOor3hX6EFDAUOTswGKJTl4AbYAlinV34I8POQN0IZb6+YX
	 qVtO8f+V62ueQ==
Date: Wed, 20 Aug 2025 15:51:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <aKZDRrfUTxJoFA1m@kbusch-mbp>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150220.1923826-1-john.g.garry@oracle.com>

On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> It would be preferred to stop honouring AWUPF altogether, but this may
> needlessly disable atomic write support for many "good" devices which
> only specify AWUPF. Currently all validation of controller-related
> atomics limits is dropped.

These "good" devices that only report AWUPF, is there some set of
characteristics that generally applies to all of them? I tried to list
out conditions for when I think the value could be counted on here:

  https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/

I just don't know if you know of any devices where that criteria doesn't
git. If not, maybe we can work with that without introducing more user
knobs.

