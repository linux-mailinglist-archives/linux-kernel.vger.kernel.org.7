Return-Path: <linux-kernel+bounces-781380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A8B311D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C358E1CE0FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD12EB876;
	Fri, 22 Aug 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7XRboeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC0216E26;
	Fri, 22 Aug 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851264; cv=none; b=pA+nx0bj0ZfKUqCGtVecJt/y4NskJZsv/7PlXe3uPfK5GHP0I93QQBUtRYd4tyLGnEuwa16esGepOKCpvzgPoE/ZVPfPXUlRwq/pfwGsrMHDqsnLk6blawb2Wg8NMNab6f+S/gIlXvKscJP9oryys4IH8fuAdJI+ARAyD8Yrdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851264; c=relaxed/simple;
	bh=xl8p5VPYvNcl+VW/XpiRhhtH4vkgSJ8RnnbcuDb5Gik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkCahicMs5GB+fggEe7pFqtqkHNszcMTeEdBuawH94dFwWR87tR0+aT7aKwsOAFLSX1MQz1JN+8NeHsiRst19oisYKYFj4nxTG+UEFm5FEXyIUmsNVWG13tkTS3TV5OZ+9USGB0koYqGKwl4In6nSDVfgBEiBBDrrtCsi44V+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7XRboeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A594EC4CEF1;
	Fri, 22 Aug 2025 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755851263;
	bh=xl8p5VPYvNcl+VW/XpiRhhtH4vkgSJ8RnnbcuDb5Gik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A7XRboeun6o5EqDLdBkKr8yPhTOoTnQsRXlszbT7p1a6YBtGIcOfBUV2rHS+Pd2ab
	 Gh94ACjFugZXOMNu/tQA+tUSuCoH99KpPcFXm1gcZFn73fmKkF8D7tF5F1nOoncqfX
	 zmsicPKChwJ9oOrMl3Anlh0Qssp2BqMf50Idnw/Gwy6cdMfH/r7ZpdFHys+ks+XK3p
	 RXqQDxEmFXuFEv44tXUU9ewHnZ5wYObgcNGc/W2ohAOyAcpQGdt9Z/f4Clmk1TiSUN
	 J8JUDKBYklt4kjUI0/dI+oWBaRoCS1aMUx7UsoZ34a+j0zQd6JgelSb2lh11hj4l65
	 x+PLRzY+4sVaA==
Date: Fri, 22 Aug 2025 10:27:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Hans Verkuil
 <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v4 4/5] docs: media: document media multi-committers
 rules and process
Message-ID: <20250822102739.7723ada1@foz.lan>
In-Reply-To: <aKcaQ7R1LTWRf3rd@valkosipuli.retiisi.eu>
References: <cover.1733218348.git.mchehab+huawei@kernel.org>
	<01acc93fd8780265ea55772ba793f3f09a43ffa7.1733218348.git.mchehab+huawei@kernel.org>
	<aKcaQ7R1LTWRf3rd@valkosipuli.retiisi.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 13:08:19 +0000
Sakari Ailus <sakari.ailus@iki.fi> escreveu:

> Hi Mauro, Hans,
> 
> On Tue, Dec 03, 2024 at 10:35:48AM +0100, Mauro Carvalho Chehab wrote:
> > As the media subsystem will experiment with a multi-committers model,
> > update the Maintainer's entry profile to the new rules, and add a file
> > documenting the process to become a committer and to maintain such
> > rights.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>  
> 
> Overall it looks like the review comments are fine tuning with probably
> little effect in practice right now. Do you think you could re-spin the
> series, taking the discussion into account?

I'll be re-sending the series now with your changes to 3/5. People
may comment on the top of it in a polite way without violating the
CoC.

Thanks,
Mauro

