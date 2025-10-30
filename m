Return-Path: <linux-kernel+bounces-877697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DCC1ECC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582B73BE746
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A5337BAD;
	Thu, 30 Oct 2025 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="H4Okw2St"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB31B87C9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809811; cv=none; b=oM2wjfTot2L3p7SIdS2rmF1Q9QpEcy6iLLFsWmcswF1CsydW9/GTDsfpgTmKn5p/+rA0mW2teWm4sVXcuuWqJ9oQ2VOFEvplGOeMh/Gv0iA6eulmVbLIkY9ACXxTtmDesXW4qlxmBIaATTCE7AOQu5r2gpqfl287nFiReumf6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809811; c=relaxed/simple;
	bh=0nwjhJNWbwlIcPN68DSZrcBXBZ3tJxA0l++53zeOtt8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hUwj/fxwAuIa029I+erPWYVa14K/JmBm4FWrJ8TBP0m4oiQ5SrLZsbcaRq2KXbJC8vhZyQy+GKswzRWlkMw2hDV12JCe3/QW6pRm6m6KdrvKLNyTip+fRClhE9Rl47ShyqzFQrDhsWJdI/sGoCU6tcyfk4OTbp/teV2QmxaQHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=H4Okw2St; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0nwjhJNWbwlIcPN68DSZrcBXBZ3tJxA0l++53zeOtt8=;
  b=H4Okw2St185GINJ0lVvSHswFF3gvFONkmmKZhFRGY39hCdFbxSqdghse
   Soo9Kx0dkkfxVBdLlH3a5fa+aK1abTfws/3akCE66We6BSoRuZJZmF8OV
   PMlo7KAqRdiToOeABkBikGBG1yx6AcAnZbiE1FBu3Pm89jdP1kclsSAxn
   w=;
X-CSE-ConnectionGUID: vOzFx7ONTbq6nOAV4XO8ag==
X-CSE-MsgGUID: QcG6g733QMqvTst1Zl/apQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246784657"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 08:36:46 +0100
Date: Thu, 30 Oct 2025 08:36:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johan Hovold <johan@kernel.org>
cc: Gal Pressman <gal@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
    Simon Horman <horms@kernel.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Message-ID: <d0ce33-bb70-17d6-b8d1-7f4b5d3390fb@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org> <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com> <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

I told the 0-day people to ignore this script, which they agreed to do.
We can see how it goes for a bit and reevaluate if needed.

julia

