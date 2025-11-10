Return-Path: <linux-kernel+bounces-892655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69EC458C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05ABB4E9A38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B552FE56C;
	Mon, 10 Nov 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoC5IbCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A712620D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766018; cv=none; b=A6Ap/dXySHKBWfx6amItzgSpVAAQGNaMxB8tyjL+X/yzh9JVbhNk7MSHyidCHa6PSXDuPO77Gibsw0KyCTBH6xFlVHTe8rjXAH3p4wC2MgXD86UHoGCvDtoJn5799QssRPMj+1NCa0qQhbM8pDTvQZ1Fg/aYPr1EDpqZcLWGn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766018; c=relaxed/simple;
	bh=85HrPyg/hTWliRANeFpxubEYlHWfEwl2bNLk2ditCLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHwcE+u7VT0cceS1snNmKitzA0C4uRdBccANjVuWfGVUiZqj+64/Q+kS+CafEUlr9eK5t7CsKeZN+qnbzGQ0x18jXUsVrG7TbCnYM7RQ4TDeyUGgPqhWNYTWPP+J/FkID3EH4MTy+7a7NUE9d4aI3MauMnm4AUCS2+N/JHYbI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoC5IbCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C99CC19421;
	Mon, 10 Nov 2025 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766018;
	bh=85HrPyg/hTWliRANeFpxubEYlHWfEwl2bNLk2ditCLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoC5IbCYiqx9zytH3QW5WKyMIqXWlcHckaZ0Xuq+YECw1Qz9c3LnmAr6hSmJsO2cK
	 QlM2kIPpb35472SeXU+mmBVjEsszbopj/t4U4ipZ/9gQnlOGenDM+x86NEO4KcSeLP
	 /O/EZ614i7QmV7ZbXPwP6W+hWov9l12N+26Z8MEz/e00Nq+vkCgcY3iNQIRQte1AHz
	 rwjlUX+IEq0JFbm+wUlxBea2CzSzWFZULN2rHApnv+0xEmp8PMYoXUps0VilGXvlIG
	 aRAnsGuq+kUhhOkzMD+x3J73kvOG9e9OOMwtXInt3VhAzrnl63kwsX13KI/XeokLeq
	 mObwW4QD/oPLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vINxy-000000008FO-0TfW;
	Mon, 10 Nov 2025 10:13:38 +0100
Date: Mon, 10 Nov 2025 10:13:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] mailbox: th1520: fix clock imbalance on probe failure
Message-ID: <aRGswsgOmPGXMjMI@hovoldconsulting.com>
References: <20251017055414.7753-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017055414.7753-1-johan@kernel.org>

On Fri, Oct 17, 2025 at 07:54:14AM +0200, Johan Hovold wrote:
> The purpose of the devm_add_action_or_reset() helper is to call the
> action function in case adding an action ever fails so drop the clock
> disable from the error path to avoid disabling the clocks twice.
> 
> Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
> Cc: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.19?

Johan

