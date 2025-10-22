Return-Path: <linux-kernel+bounces-865518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA1BFD5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9A583C70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E3359FA1;
	Wed, 22 Oct 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="amfEaIVO"
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72784246763;
	Wed, 22 Oct 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150516; cv=none; b=qfIUxQOFOffZ9rjyPt9MDkaYmFJfUSd+5h41gEEdailZuzMp0y3WzVezqorgdhlxQjSC2d/hZKXjedTon7jkCmwX4JU/R+Dd28SCGhDu0euKzRIn3kDNUldCSjbDrS3ZcMk1QhbH3bgEG1RgUyHBPZVCL4tPyfQlk2lQDwO8Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150516; c=relaxed/simple;
	bh=dtqckjTvzjMKvbZnmKtPZeOTaQC1Vv5Jcaeggx2e1FQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QckuMgVYJITrKpvC5fsTPvOTvYn3xSbuaEwviOVY0xtmw4xiYTvNJOfs55VFLjCu+u0C2Vnisg2PwoMX6X0yl2rqRuVjriINFQRC9xDgK3YyeHxPBrD8fiH3EIfAdS+6wkhbtuxlhMPm3j4DtDDsq6mJK7kwxc1PmuADs36qytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=amfEaIVO; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 22 Oct 2025 18:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1761150507;
	bh=dtqckjTvzjMKvbZnmKtPZeOTaQC1Vv5Jcaeggx2e1FQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=amfEaIVOS4KQ6bYFo2NBQV3AypZXQHAkaTct0TUv0nqVj+YcqormVoM4BXbXZ0xLo
	 QMoKPLrHegCSAVAmuXI/JDycF7fKRSKjKKWXL5P3BbUs+qUH3U39IJcEB5CP4DG1x+
	 Aqo2r56jsj7Ec86ienwmlD2T1bwkG24l1nKiZk/JCgWZPDeZ/meYVQ5D4ycG0Ca9er
	 7Vsfm0lR1cCqN2hTx3tfWlUEwH3RghgPw/ehDS8KFy9XkNIsHliN/0p62JkGJ3igQE
	 YjmR9XgZAJ67GNGozbyxmhqaMl9Z2CPjZFlmwJcmQEi0Asb26os7Zpz5v9D0P7VlX9
	 C2j4siRsK2REA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
Message-ID: <20251022162826.GB3227@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022053328.623411246@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.

Hi Greg

6.17.5-rc2 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

