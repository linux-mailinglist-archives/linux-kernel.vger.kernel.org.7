Return-Path: <linux-kernel+bounces-775545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D6B2C071
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787D8179E78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A93218DE;
	Tue, 19 Aug 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2NIRV1Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891D317701
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602923; cv=none; b=SapxwArcG3GpAWArHKbfkHrPJm1H7EY8R89shzDQ1xK6gkERWoqLTp8Bkw0aO+gY5PuOofNbO4jE0Uf6q6JdLQDbb1lxuEdaLoVNYqtfOKcNY4dyxCJVef++n+yie0vn3UA7oJiBig8yyTHTUSOZ5AksrTJdxSRyJpobRBQhVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602923; c=relaxed/simple;
	bh=oYwMfvfoBRK27LmOjhT73WQQgZ4RZ/VSfLiWlThMOiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZemFS1b3U5fCJSbrF0OfevpadFUsQXCkGUDhRuccOZKPWSvKc14RfXnLLZQFbDww+YwLld/P5bHCtDGbwx8hFiYDs2mk1oZyhrOpzryqYFQniTHLknA+uj8dSQr588Fp/eSpfBhIJdCJinxWHRW9RpHOpo3aOI2QqC+gKQwOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2NIRV1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C727C4CEF1;
	Tue, 19 Aug 2025 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602923;
	bh=oYwMfvfoBRK27LmOjhT73WQQgZ4RZ/VSfLiWlThMOiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2NIRV1YLLLEuk5Jyfji6rC19oMW2nQDFFsv/avg2DFDtUtKpHF35mzm1H9JG2mCg
	 awz9XrVlwZdPlWUdQjMgudZ30P9sMTFfB8AzcQHp5yR07nW9gDcWup8SChdX75DJ3P
	 Gqf5DZ0zCKAMyvxPB8Hm/Ouqa/jk8M20ISFRFgKU=
Date: Tue, 19 Aug 2025 13:28:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] sysfs: attribute_group: enable const variants of
 is_visible()
Message-ID: <2025081957-promotion-shrivel-32cc@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-4-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-4-0d973ff46afc@weissschuh.net>

On Mon, Aug 11, 2025 at 11:14:30AM +0200, Thomas Weißschuh wrote:
> When constifying instances of struct attribute, for consistency the
> corresponding .is_visible() callback should be adapted, too.
> Introduce a temporary transition mechanism until all callbacks are
> converted.

I count about 600+ users of is_visible() now, how is that going to be
converted?  It feels like a lot of churn/work, what's the plan here?

These changes seem a lot more intrusive than the bin_attr ones :(

thanks,

greg k-h

