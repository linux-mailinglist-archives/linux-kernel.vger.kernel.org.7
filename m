Return-Path: <linux-kernel+bounces-899207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6BC5717E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8B4D34A10E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293933AD8E;
	Thu, 13 Nov 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC/xrEOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC583385A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031798; cv=none; b=NC6Cmc2MU27+83iPNrNv0Lg4vSQQ37e0msUg0Jd0W6qLowZTNKkpfFKx0wBzaqQg4JjCFO0qNwjpQNOuah1TS55u96AP9eXaIx2rqX5RkGJY5x7P2bvqYaoPOu3ELSD6TbeGYGc0AD5eqhbYJncpoIF4S8P+zCXWvnBBZPIONww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031798; c=relaxed/simple;
	bh=ngxDsHs+gyZoiXhhi+7OCraVp2aZOKOSsKjoR4FXO3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgUzdF9r4uap/mRXOtcKjV9kXEhuktzl0R9M8CNrXGnhjtdvrp4OwlSNuIYhVA/e795pdvQprojPqLhVbf39NAAWWWnIt2WF5lxdFhVln6ZisjMxfmUIHgLIUVymQXxXC9df8aBjCaw/9R3+xRPoah3dS6Q2971beh0UgnUfUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC/xrEOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F0C4CEFB;
	Thu, 13 Nov 2025 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031797;
	bh=ngxDsHs+gyZoiXhhi+7OCraVp2aZOKOSsKjoR4FXO3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hC/xrEOea+HYoU6bwutfDObRumwzqS/afClX68ePFZoYQ6sBrmB6zy3yzKz4n5bm+
	 8eMM7OsxfjYYkAxuMkOhOa8PH+0BrY4z+9dpXIYWvIUzYJvu/JPLU6qLbUp7PhlkNj
	 woy7fAJrpIVHpkY6zfpXprqPSiasfc9d6X/iJA831Hn9+pDpek184wHVVuzfrbT6Zz
	 7jq2wx8Uh9JX+Ach9hDzQ7H/DTiWHnhja5hGf7iMneoX35+yp914YI0f4VnapzobLT
	 rZNbXhlAO6DIRJLw6H8JS6nJvrfCmYer3sWHy64+tf7YTu/R6/MBN9umQWmS2xzKxK
	 7qVqMOLa70VaQ==
Date: Thu, 13 Nov 2025 11:03:12 +0000
From: Will Deacon <will@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Marc Zyngier <maz@kernel.org>, catalin.marinas@arm.com,
	mark.rutland@arm.com, paulmck@kernel.org, mhiramat@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: arm64: pseudo NMI bootconfig question
Message-ID: <aRW68JGA4xBGxjbs@willie-the-truck>
References: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
 <86v7jftjq5.wl-maz@kernel.org>
 <sf4iq6uyq64lbrrggwssq2hxslk2qyetm3owplw5rwzqgnemrn@o4beszh5aewh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sf4iq6uyq64lbrrggwssq2hxslk2qyetm3owplw5rwzqgnemrn@o4beszh5aewh>

On Thu, Nov 13, 2025 at 01:36:48AM -0800, Breno Leitao wrote:
> Helo Marc,
> 
> On Wed, Nov 12, 2025 at 02:21:22PM +0000, Marc Zyngier wrote:
> > On Wed, 12 Nov 2025 14:05:43 +0000,
> > Breno Leitao <leitao@debian.org> wrote:
> ...
> > > Question:
> > > 
> > > Would it make sense to provide an option to enable pseudo NMI in certain
> > > kernel configuration without requiring an extra command-line parameter?
> > 
> > [I wasn't asked, but I'll give my answer anyway]
> > 
> > The short answer is no. The long answer is that there is so much
> > broken HW out there that dies a painful death when enabling pseudo-NMI
> > that is isn't practical to do so.
> 
> That’s helpful to know. I hadn’t realized there were potential issues
> with hardware implementation, which explains why it isn’t
> straightforward to enable. Thanks for the additional context.

FWIW, I've also run into platforms where the _hardware_ is fine but the
TZ integration can't handle Linux using priority masking properly.

Will

