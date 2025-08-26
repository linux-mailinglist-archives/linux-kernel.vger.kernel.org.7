Return-Path: <linux-kernel+bounces-786435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADACB359C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CDF207F28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95196334723;
	Tue, 26 Aug 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUfcoCS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C13090CA;
	Tue, 26 Aug 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202749; cv=none; b=ITBekIPBeN+isGrVeQHzSZKFcPoYZsif1ErJYziq+Sx5+nJFZ2mBGJ5tVQFMLAkHdGv/Ct1FS+Ys89CYW3POWJDwlyDG/BrN8OJ5aMixOjOT7+4xAJZCX1+aI5IPos/jFlleOVtVfyhLFasIrElP6GFdR+aVlfG/0NyIy8rk8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202749; c=relaxed/simple;
	bh=JHn3bOAyvqLaFpjqNU1rs89V1YSlKFOzoeTPti0k6aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7C7nXn5TT7mvRVcVTUu+0sAK631IqBdiRVXxq/jAcmdaZfzOxefowubThO1XHwTT8ehXB0rR0QSk1xXru3vwK+Lwc1PhlhrThOxO/Odo/2ZNniSM3GEga56gh/cunxuqKJ7x2Qb+quCyly7R/0oAox+dESYVhKawN1seyDsKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUfcoCS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666CEC4CEF1;
	Tue, 26 Aug 2025 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756202748;
	bh=JHn3bOAyvqLaFpjqNU1rs89V1YSlKFOzoeTPti0k6aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUfcoCS5ewcPcT6ejaJ/rzl0FnlhX9tKjRmoC3giDaSSLvdpwsem6u9ae/DpitM87
	 rN/RM2xLfPnojm+h5haiP+wpHFVpLfAHVIUS4HAk3o/Yel1/3hdo3miM8vxmNo0IB7
	 0x1wfvr88xl/foP1/Zso9CULS9T2vQEx26NHYB+sQm0XSBbnHeq7q9qyqKB0fb0CHP
	 KtPviyE6kIJqgX/mk3ZpBJ/9dH7MhaZxqAggZ/VzjvJW9n75kM7/X4QSNWvuvndQXx
	 ZqhewamFMQIjsUppgI/vJED1+nbAqDkJ+4SYChCYqQq+EDsMYxepp0W1pBDtt4L6Vn
	 9gVHWXgwammrQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uqqYb-000000004fb-2MTw;
	Tue, 26 Aug 2025 12:05:37 +0200
Date: Tue, 26 Aug 2025 12:05:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: remove extranenous ; after comment
Message-ID: <aK2G8YSahB6CmKnc@hovoldconsulting.com>
References: <20250826081712.1415484-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826081712.1415484-1-colin.i.king@gmail.com>

On Tue, Aug 26, 2025 at 09:17:12AM +0100, Colin Ian King wrote:
> There is a redundant semicolon after a comment, remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Next time, please include the driver name in the commit summary prefix
(i.e. "USB: serial: oti6858: ...").

I fixed it up when applying.

Johan

