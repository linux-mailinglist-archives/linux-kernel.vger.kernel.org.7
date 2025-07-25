Return-Path: <linux-kernel+bounces-745269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DDB1177E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23CE1C883B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F37323C516;
	Fri, 25 Jul 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKZgQPJL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1903594E;
	Fri, 25 Jul 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418464; cv=none; b=DsXnhATZVQKioyFA+X4HbiZMwwfH+Gwi//lOb5/VlAD+SRtgYpiCvjKTCSWJ8ToM6FEJydEuCU/41L2kILAmxZbIinAKFf95TcR+WFhn93wENXwZ0V7oNcLeAQHqer4svQTMwbadC9fuWtq6cKN0QLVNknD/dKpM9MtQ3++GqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418464; c=relaxed/simple;
	bh=EZ3GroOzDlPBH3KynjSZB7L8kHxmguA45xMBmcEEBjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiLrPv4fq50PQ6WUWjDAy4Hvu+QyFNKZdF3U6MHCezWtbTaGxR2nryWydl3mGn1YTikQM2UCsAAMYMUihyz4xJoI1dia9Db3cwzSENFSw2RkbgML2+vat2NRknDLU8+Qmq6wlsNg3YAG8DSopmgBB2E9lflxIu22HF/bO7tUeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKZgQPJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEA1C4CEE7;
	Fri, 25 Jul 2025 04:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753418463;
	bh=EZ3GroOzDlPBH3KynjSZB7L8kHxmguA45xMBmcEEBjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKZgQPJLq4rHfZr0YQz7u/8TymTZ7W7ybS5aFbhzg/b5j9W2l+8Mb3hnVAgSrHseI
	 28/9pgHxZt4JdUw8QkXzehTDmLQTyw4QtQNr7SSbSTngX0aWCsP1wa+bY59TwuZAYY
	 9uzzMSbrx9fRz/nuQvAX1KHggnrtpE4RqahMtn18=
Date: Fri, 25 Jul 2025 06:40:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bruce Qin <bqn9090@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and
 line continuation in rtw_ap.c
Message-ID: <2025072552-filled-glacier-1e9d@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
 <20250724193037.23910-1-bqn9090@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724193037.23910-1-bqn9090@gmail.com>

On Thu, Jul 24, 2025 at 09:30:37PM +0200, Bruce Qin wrote:
> This patch fixes several style issues in a multiline if-statement:
> 
> - Moved '&&' to the end of the previous line to follow logical continuation style
> - Fixed indentation to align with the opening parenthesis of the expression
> - Avoided ending a line with an open parenthesis '('
> - Moved closing ')' to the end of the last expression line (as suggested by the maintainer)
> 
> These changes improve readability and conform to Linux kernel coding conventions.
> No functional changes.

Please wrap your changelog text at 72 columns, like checkpatch asks you
to.

> 
> Signed-off-by: Bruce Qin <bqn9090@gmail.com>
> ---
> Changes in v2:
> - Moved closing ')' to the previous line as suggested by Greg Kroah-Hartman.
> - Thanks for the review and feedback!

You sent 3 copies of this "v2" patch, how do I know which one is
correct?

Please fix up and send a v3.

thanks,

greg k-h

