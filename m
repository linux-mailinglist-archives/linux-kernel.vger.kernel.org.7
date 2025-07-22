Return-Path: <linux-kernel+bounces-740428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81277B0D40B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776A116885C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518328C5D9;
	Tue, 22 Jul 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PeGXh7eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB41E520D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171148; cv=none; b=UoY4Z7F6J3MbJ7bFrrdsMdH7v9CGdAx1XAEuvjIXyF2zKdm0dCsADo9n2yfbBSvHj2klGiLTCW7j9jJwqfLsw4mQU8pMkDVQUShdrO0MuOsGPmutg3lYCTnHLgT4m8ETfZC+zxu/ZRgJnq45waWLc2xsfGpFIwY/u4ZKWdQoc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171148; c=relaxed/simple;
	bh=eOHzRhTp9+rhgWF2QA91y0CsEtIY9IhU7mvUaFG1GkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBweB8P53Q3yIX8lvxwaeJhrxwlnkexqYqa7t8Ft1w+YYRdZDRFV03g9CMHDd+o9NS0BeKwEjo7qv9hHkfydMRKpg00+U6SazW0SkU9MqjNeaEUH+OH8PSpmR9mMNhBqNKc5RYWxsfeVEcvukNmJRmXevWEwtEtDdaCILHJU1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PeGXh7eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81D9C4CEF5;
	Tue, 22 Jul 2025 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753171148;
	bh=eOHzRhTp9+rhgWF2QA91y0CsEtIY9IhU7mvUaFG1GkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeGXh7eYgGcltb/0swRTBk/OfTRmw0vv5fsiTZvr3sfNMjSTYoYbmVxqr+YZ9d1xz
	 o+1eqRW3bbfJEAasZgsLwmgDXQ3RA9LWCbQrXNbbe5VYq9GoncHraBhY94s2KdRw/Q
	 3vttFpisoK9qEVST6kbjDRNrlhhCLH6ipleGWlJY=
Date: Tue, 22 Jul 2025 09:59:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] checkpatch: suggest including testing evidence
Message-ID: <2025072216-properly-chowtime-0485@gregkh>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
 <20250721162437.6691-3-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721162437.6691-3-ignacio.pena87@gmail.com>

On Mon, Jul 21, 2025 at 12:24:34PM -0400, Ignacio Peña wrote:
> For non-trivial changes, it's valuable to know how the change was
> tested. Add a gentle suggestion when commit messages don't mention
> any testing, verification, or validation.
> 
> This is a CHECK level notification, not a WARNING, as testing methods
> vary greatly depending on the subsystem and type of change.
> 
> The check is skipped for very short commit messages (documentation
> fixes, typos) where testing information would be excessive.

This will cause people to write short commit messages in order to avoid
this type of warning.

I don't think this is a necessary check at all, I can't remember the
last time any patch I wrote would pass this check :)

thanks,

greg k-h

