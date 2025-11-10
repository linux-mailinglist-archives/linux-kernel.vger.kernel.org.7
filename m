Return-Path: <linux-kernel+bounces-892421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B278C450DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FF064E7E89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6052E888A;
	Mon, 10 Nov 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PExizIuW"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91892765F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762754319; cv=none; b=PDBEXa1nO6izmp08D9ZA3c3eoDxcKjFi72JASdma9x26zneT6Hmnw1/oIdstPmbeIgvlRr3xO1on+y8R72yo1igXeEgC/T/RIgGE0j5hdFNK237D8TjtPvwBYF9cZhsPoZfNcKA3AhaV8oVx2Yr8z8HT8nD7h0R3ZZmXPNm4Ss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762754319; c=relaxed/simple;
	bh=c/iXlMg9ptx5vO3DD4aXPbLGLtFtyHUuOj7745x5ze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxb+DkV7QZd9UL6HAATElJmi1VPoyfI5AH47dae73cy234Pew09u7Fm+0pJL74QmFGMYMkHYN0rDzrA6EHxgXdSEYZoT4Ue+nShqXzxtupLcjRrivWOnILA++pkUGjmnWiAxo7LR1nnMxlY+SymrrIOGWMtLOYsJOdkF6aHVf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PExizIuW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 13:58:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762754310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11sSSfWOAtpuAaFgHtWgsP7KNvBK95JJwwjmnsVPiMY=;
	b=PExizIuWGlbwIEw/uS2cDKSj94afQnvnPnOmvsTWrn0xZQNXtFoRESoS3bH2JhP042iGLY
	jNnXaKrEscH/8SL2ne7y0FL8i+6w4C7s5iQlHtW0tJ0EF5T8QyvEsRFJshSgV5yp981qw3
	/EOIbg67QS/EYqFk/UYbijD39C7RUEE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Encrow Thorne <jyc0019@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] reset: fix BIT macro reference
Message-ID: <aRF_APEKXpkOc7z6@kernel.org>
References: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
 <1ce72e929f8f6c691faaf548a05b0eab2b9b1630.camel@pengutronix.de>
 <20251105170006.GA487100@hailin-HP-Pavilion-Laptop-14-dv0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105170006.GA487100@hailin-HP-Pavilion-Laptop-14-dv0xxx>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 06, 2025 at 01:00:06AM +0800, Encrow Thorne wrote:
> On Wed, Nov 05, 2025 at 04:51:33PM +0100, Philipp Zabel wrote:
> > On Mi, 2025-11-05 at 23:40 +0800, Encrow Thorne wrote:
> > > RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> > > include bits.h or bitops.h. This causes compilation errors when
> >                  ^^^^^^^^^^^
> > Troy suggested "or bitops.h" can be dropped.
> > 
> > > including reset.h standalone.
> > > 
> > > Include bits.h to make reset.h self-contained.
> > > 
> > > Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
> > > Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> > > Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> > > ---
> > > Changes in v2:
> > > - EDITME: describe what is new in this series revision.
> > > - EDITME: use bulletpoints and terse descriptions.
> > 
> > These should be replaced with a short description of the changes
> > relative to v1.
> > 
> > 
> Sorry for the oversight on my side regarding the “Changes in v2” placeholders.
> Do you recommend I resend a corrected v2 now, or wait and include it in a v3?
> Thanks for your guidance.
Send v3 when you are ready.

          - Troy

