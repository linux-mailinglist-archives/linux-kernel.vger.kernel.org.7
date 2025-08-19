Return-Path: <linux-kernel+bounces-776503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC2B2CE36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5454A587CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C002F3431E9;
	Tue, 19 Aug 2025 20:44:22 +0000 (UTC)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C44342CBF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636262; cv=none; b=GgOxMaVhPW0DnWqZVX0v0CHRZCYvHHx8ZQ0g3k82wcadFRpUDEcJQ3OqQb4bwTIXiS37nxM/pI0nz81oEbhowegXMOVXCE2dMUrGJawQ3YD8wBbuCUwM4j7jvGXWUd6WOhG/+7NspSsXSiO0cmxXed8ZzJUtywdGTDu2LOqNYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636262; c=relaxed/simple;
	bh=lWUnz3BHi7zNP53K6wbf7UIXaSjzdBqdXvbVy9/OqeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvRFOUTqsupyjAvtOUmdn0LYIz+YpevVVQKY1TJtD/Vmx58Xnis2rMPrKYRtSDaK3Ul7uzNhZNLHuZZW7XmIfH2P0fXqRX2RB5m4Cz/eyqZiflc4n0YNY1xD5ORf/+yvccSnR6Oyjdur+y/I6Idry0WL4CJ1MAEFOe95pOv+dRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 16:44:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH v5 0/5] iio: mcp9600: Features and improvements
Message-ID: <2025081916-screeching-tench-c9cefd@boujee-and-buff>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250819-ambitious-lumpy-hornet-bc1600@kuoka>
 <20250819192455.3d294562@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819192455.3d294562@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 07:24:55PM -0500, Jonathan Cameron wrote:
> On Tue, 19 Aug 2025 08:55:44 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On Mon, Aug 18, 2025 at 02:32:08PM -0400, Ben Collins wrote:
> > > From: Ben Collins <bcollins@watter.com>
> > > 
> > > ChangeLog:
> > > v5 -> v6:
> > >   - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
> > >   - Correct some constraints in dt-bindings
> > >   - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
> > >   - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
> > >   - Cleanup tabs that were converted to spaces
> > >   - Split thermocouple-type default to separate patch  
> > 
> > Please start using b4, so you will get changelogs with lore links for
> > free and ALL your patches will be properly versioned. git can do that
> > as well - git format-patch -v5 --cover-letter, if you don't want to use
> > b4.
> 
> Second that.  This is what it looks like in patchwork that I use
> for managing reviews / merges etc.
> https://patchwork.kernel.org/project/linux-iio/list/?series=992678
> 
> version number not easy to find as it gets dropped from the series title
> and is only normally listed for the patches. 

I appreciate both of you suggesting this. I've switched to b4 now and
now I don't know how anyone could not use it.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

