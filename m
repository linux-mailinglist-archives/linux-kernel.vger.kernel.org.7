Return-Path: <linux-kernel+bounces-865835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E9BFE22B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EACB3A7C04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE7288C24;
	Wed, 22 Oct 2025 20:15:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE272617
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164146; cv=none; b=deTfjmtCNEaSoCPWpDge6QBqrcjojYdyPZYv+fa6Lkclw5Qu3BXmW4ADhOzL9KOcoIJarNOIUZ7ETlFkEgG7Wxx+we2qDMt0IJohErNK8EyYNlBz166rnV/WrCPj8RjVcPK/6wf6BHvZIsyOHBIEZhVDkwUnlLU6PXpjjworqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164146; c=relaxed/simple;
	bh=XTxCYEL77CaKv265UW2Z42LG5ScrsvlYVtgpJp7LjdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdORGxqXAbbyO4ewa6FtXnDrVJjM2nHAAEw1OSNR+5T36K/bZDsSC9xk4EfuSCdKfmu9xvRzY1G7e9CJJkPXZCQGh9LC9Zyk/FutGK4dZJs44xpH/pJmm9Xqqw4QHYLa7cZof2hjpAnI+z//Hld4cQMfHbygVN5N4b18kYseKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990901596;
	Wed, 22 Oct 2025 13:15:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043393F66E;
	Wed, 22 Oct 2025 13:15:41 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:15:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org, peng.fan@nxp.com,
	cristian.marussi@arm.com, shawnguo@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, s.hauer@pengutronix.de,
	festevam@gmail.com
Subject: Re: [PATCH] [PATCH] doc: fix =?utf-8?Q?typ?=
 =?utf-8?B?byAibWFubnVhbCIg4oaSIm1hbnVhbCJpbXg5NS5yc3Q=?=
Message-ID: <aPk7a6OuEVtP6mZe@bogus>
References: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>
 <20251022200508.72941-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022200508.72941-1-biancaa2210329@ssn.edu.in>

On Thu, Oct 23, 2025 at 01:35:08AM +0530, Biancaa Ramesh wrote:
> -- 
> ::DISCLAIMER::
> 
> ---------------------------------------------------------------------
> The 
> contents of this e-mail and any attachment(s) are confidential and
> intended 
> for the named recipient(s) only. Views or opinions, if any,
> presented in 
> this email are solely those of the author and may not
> necessarily reflect 
> the views or opinions of SSN Institutions (SSN) or its
> affiliates. Any form 
> of reproduction, dissemination, copying, disclosure,
> modification, 
> distribution and / or publication of this message without the
> prior written 
> consent of authorized representative of SSN is strictly
> prohibited. If you 
> have received this email in error please delete it and
> notify the sender 
> immediately.

Again deleted as per your disclaimer. Please find a way to get rid of it
as I need to keep deleting your emails as suggested in the disclaimer.

> ---------------------------------------------------------------------
> Header of this mail should have a valid DKIM signature for the domain 
> ssn.edu.in <http://www.ssn.edu.in/>

-- 
Regards,
Sudeep

