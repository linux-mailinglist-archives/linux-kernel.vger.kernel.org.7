Return-Path: <linux-kernel+bounces-751091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B167AB16530
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E750A5450CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A842DE710;
	Wed, 30 Jul 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYQ1kYKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DD2DC358
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895405; cv=none; b=BD/cK1eXFWQFLbdrxZNYH1ldRQLzuv4eQEw8qpShHR5v5lkEM5bvJmMfjbMu7dXV5xlU323bYc8v2dbP5PjlRXq6m2bXt9bEcbAbYWaw4pKdSHC8pg91PYZra577WLTANz1sHevgO3wrShv2IQwc7vE+Ik43c09Nsa5eKRHRhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895405; c=relaxed/simple;
	bh=dJly3SiaFBKzG7wiQbJ+tNgWZh5VWDYDoYyY3crXU6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sRobH2IRELlfyOb/WtbY5sNBHSAWBPeiG1vhbMgYiYK7nN0bJWAYD1zcuwBP5I/s+x61WZSMRTUXrU2Vi4/OY8zS8C76BQ0oGz73vB47SaG0L5gk2D7KJSCsgUUDhVlaAicwKnSPKJZXyFqo2vYrTrTmVob9M+g4of0niOhqYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYQ1kYKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD009C4CEE3;
	Wed, 30 Jul 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753895405;
	bh=dJly3SiaFBKzG7wiQbJ+tNgWZh5VWDYDoYyY3crXU6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QYQ1kYKwl1y4Z+wmPpJp9SZcdNl5mQwl7EGZKF0Kdz5GicuVFrkahPHoDFt55KdZj
	 prEKLFDAKLSc6G4BdJGQidowOpOVhmkr7B/X2VnahJMB+wViwo/+I/atcucRxllwIg
	 xxxijrypaZZksMPKrSLmpcjWeS1+kbc+M+T49tbNvRVW88J1A9q+YUJevO554u1BUI
	 tGNn9eYhB47IB5qjmtdijJeA2LA0z3InvnhVmtJDIWNyFgN/K3nvSJcqYDNUEi4buw
	 S1990NoYUp/6cRyRkr3b87K4VsFbV7jiA70L7vOR3oJdI3dmypikTkX4FWgswgs+E7
	 X1+xxZJb301yA==
Date: Wed, 30 Jul 2025 12:10:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730171003.GA3369524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730162321.GA22255@lst.de>

On Wed, Jul 30, 2025 at 06:23:21PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos in comments.
> 
> This created multiple rejects.  Can you resend against the current
> tree?  If you don't want to deal with the nvme tree, maybe resend
> just before/after rc1?

Sure, will do.  I'll rebase on nvme/nvme-6.17 (e97c0040215f
("nvme-auth: remove unneeded semicolon")) now, and if that's not the
right branch, let me know and I'll redo it around -rc1.

Bjorn

