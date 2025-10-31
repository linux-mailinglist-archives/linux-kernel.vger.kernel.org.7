Return-Path: <linux-kernel+bounces-880332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CBC2586D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8317B58168E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9125784B;
	Fri, 31 Oct 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7xchXRP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746822A4D6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919834; cv=none; b=b73HZ74GU6j62E3jKgYMyQu54DVpwEnnRZxDJn+irSJ6bQdG7r8VyslDc8bNj/yWWr4G4kG2WZnyKdXO9WnxyTxmyJd4bhocrXugbrlq4EqkWGVeQe+tA+PrBQins+JSXuFN/TYFGvaCwc2djJKLIkufjHWqdIbkBqJkFllbLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919834; c=relaxed/simple;
	bh=0B0L8Lq+i3gAWgbniEZql6RTQ0bjsRjHlxIl+KdSv88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnIjnxdAPNaaIGZ9Tjp48f70ijre1fyp9dE5QGWM6djpnHz/2JjTMskKAycyQlcNMOr9rIJKI/tQ5mFJ4Is35/qqCrdYQ/kGRJHDGGo2ApvKUevXJ6AJCawKn7RNhBkr8ZYVab7+/db0MHAHbGlZSSjy0VQskokITjp/X+AGng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7xchXRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EE0C4CEE7;
	Fri, 31 Oct 2025 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919834;
	bh=0B0L8Lq+i3gAWgbniEZql6RTQ0bjsRjHlxIl+KdSv88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7xchXRPtpFVO6T5D1JkSCcM8nKEjLjXwzEU4leQME3MsMInJJw6zd6fOCErOKUsG
	 YfermksGty5JVvBmJZmaL2xNFYRjtqkzdhgXU738RA1/sv1zFMguePq66wiDa/xPha
	 xsgriSUfZu4RP7srKln19T5tVvg8gYKqjTZ60cMKLjA206r32Ck8uZxSve+n8w4PIX
	 sfjlPeON1/LDLClqAGDkPjHP/lIT8BPfvd3cqwUmQ9//4/RjniZHPOcxY6cD8yptuq
	 z4QdDVLdttG4S520vKc+kYKj0DD1k5K1lPd7PMfiIqCmD59Ef69YzQpvH4y5+Btwyq
	 vYRJSy1Nk1V3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEppz-000000007uC-1bOJ;
	Fri, 31 Oct 2025 15:10:43 +0100
Date: Fri, 31 Oct 2025 15:10:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Message-ID: <aQTDY6m6xuDpNSAH@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
 <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
 <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c32fa45-2b8f-4005-94cd-a9755981cff5@nvidia.com>

On Thu, Oct 30, 2025 at 04:36:46PM +0200, Gal Pressman wrote:
> On 30/10/2025 16:06, Johan Hovold wrote:

> > It still generates noise and extra work for already overworked
> > maintainers that would need to explain over and over again why they are
> > rejecting patches that appears to fix "warnings". Some will just take
> > the patches, which leads to inconsistencies (as only a handful of
> > printks will be converted) and a push for a style which again only some
> > people prefer.
> 
> There's the subsystem maintainer "rules" documentation in
> Documentation/process/maintainer-*.rst which can document these kinds of
> stuff.

There's already too many rules in there and I guess not many people
actually read it so that doesn't really scale.

Johan

