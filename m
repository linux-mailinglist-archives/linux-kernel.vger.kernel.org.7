Return-Path: <linux-kernel+bounces-821761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22ABB822D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686902A6C26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEC30F95A;
	Wed, 17 Sep 2025 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2Au4+os"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E42C0F84
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148919; cv=none; b=k/K8loPp9xB3444NiLOZmAPCUkfMG0+x4NDLqn9jnfryQllmRj39uSSt5DumET47dAD5brARnUUHDmZcadCxBHxqRxz758jpGJcKhL0L58Xi3LSFWUUbfVrNeJB1qRQnTpBOWs2FnBfVTBsTb5WEgXnTI6PgoxEtRYLzwi8OJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148919; c=relaxed/simple;
	bh=yxnAPjEaQty8rUJ/aaBVRCSdlEvqeu8iBn1RBHyIkgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC1anTB18aTvPKPcmbBfd7asijuUzdz0kOX9vT+ThtI4C4HjAHM1e/CK9AMTFe5yfBjGeM94pfxpnANitLgHfIDbJ2cTKwuZWOxF2LlO7nCoTsVO8eNAQNVInBChdlmltzAHZ48MaF+dAlSo7pGX3LwE3eJbXEXWjjahgoU3A34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2Au4+os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159B1C4CEE7;
	Wed, 17 Sep 2025 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148918;
	bh=yxnAPjEaQty8rUJ/aaBVRCSdlEvqeu8iBn1RBHyIkgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2Au4+osFdjBcoaip3nvei8rIH2wKO6KEA9NPI/SbtRsVqDa/6itwZ87llMP1IO/o
	 +G7rh+QqzjlNknLJxxgzv4bJnUrPXM1zusLzOAbFFAbgoEz9tHo04pO5Ld9iCANC7I
	 YFG+SXPzRImSMJd1nqYnnJ7jl94Z1UoHDQcmhUkTD7S3Ju52YT3myQ331Rrsh3dvg9
	 jVurSbouMczclQSe+ZtjNLbvh6BKNvPPd8DMw5BjfAgUDq+/8gw0i/qAlj+f2r+hui
	 2YIxNcNObGaYT+nmFIHjvbvaIqtWuYOuV5HGbLx/HuoJVkYllsu4uzhD+1tooT7due
	 JFCda5OlTz14g==
Date: Wed, 17 Sep 2025 16:41:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 0/2] Preclude IOCCSZ/IORCSZ validation for admin
 controller connect
Message-ID: <aMs5NJdx7I3WZ0rg@kbusch-mbp>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>

On Fri, Sep 05, 2025 at 04:25:48PM -0700, Kamaljit Singh wrote:
> During negative testing it was observed that when ioccsz and/or iorcsz 
> were cleared to zero on a Target, a new connection to an administrative 
> controller failed to establish, due to driver validation of those fields. 
> Since an administrative controller does not support I/O queues, these 
> checks should be excluded for such a controller.

Thanks, applied to nvme-6.18.

