Return-Path: <linux-kernel+bounces-827651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628EB92504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C57A1763
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED23311C37;
	Mon, 22 Sep 2025 16:54:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392F311941
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560044; cv=none; b=pcCLU3XiS2pelLGERCghAyTP58CmKohIPtoHwCW4zQ52Q61Acjer+m/tmwYAODGWb5wOA6tFY7Ih+CiaaMyw4I/FIrmEElzHUzsUjvwf4JLv+SQo1X1lO9zYCM7TMznr3T78Aqa7P+pGYCTF0VXphsIkrcp8U22Y469om1l8xpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560044; c=relaxed/simple;
	bh=Qg4PJoMgf7m/BZZGncsDq9DsrcE9E4ml8wm7wHSqNmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tErY9GnIPSfMt4ERcDFSIOL/OMNKo2CAeZbPJQFsxcoRJvvrHA1ZX2xtsHfgh+Z21jU9+GKE9ySRMdi541pek3GPxYJgF+UQEOD36Gcn/EOUokZr+GTqat1TPoCUxi1a8vkXByNPdlu88EExX9mSdk06WUk4L5KKnVhWSNaxkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F26C4CEF0;
	Mon, 22 Sep 2025 16:54:02 +0000 (UTC)
Date: Mon, 22 Sep 2025 17:54:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: shechenglong <shechenglong@xfusion.com>
Cc: "will@kernel.org" <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	xulei <stone.xulei@xfusion.com>,
	chenjialong <chenjialong@xfusion.com>,
	yuxiating <yuxiating@xfusion.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGNwdQ==?= =?utf-8?Q?=3A?= fix
 hard lockup triggered during stress-ng stress testing.
Message-ID: <aNF_KK9sY-a_weH5@arm.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <aMvsxd8nHb5roC0o@arm.com>
 <2eeb109f50b34e628327972d1af57f5d@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eeb109f50b34e628327972d1af57f5d@xfusion.com>

On Fri, Sep 19, 2025 at 12:05:38PM +0000, shechenglong wrote:
> Okay, understood. Thank you! May I ask when the fix/patch is expected
> to be available?

If you send one, that could be really soon ;). See Mark's suggestions
for where to add the pr_info().

-- 
Catalin

