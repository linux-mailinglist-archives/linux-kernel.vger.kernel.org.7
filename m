Return-Path: <linux-kernel+bounces-892238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB12C44AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C91E345A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FF1EF09B;
	Mon, 10 Nov 2025 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ov61ZhUn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D61D6194;
	Mon, 10 Nov 2025 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736164; cv=none; b=baZuzLi0PXtJhda+ofCfze05PUmyWbpKvsKeRdPIKpfstqQ+Cbr2+GpOZFH6NCJVRvl6sQimmLlWkOLlLZU4NExcEUSnEDp9rEa361Ctri2DLv8kRVihtM4TIAUi+qWDYP48bhJks60vsMI+qtvEV0twM5fVoM7P3cxovbxwPLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736164; c=relaxed/simple;
	bh=3WMEUAWG+aYlirWLWCoAZLiAXOn1m+HbDH7g1IW2GyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1TP0q6oOY9Yrkz0QdpTy9aadSKh8U1OFPifoILDdKJIg9s3Ceo6eWgSq/OmWaEWhHCck+DMr2mhoFkqkTYH2V+tmhwWhZTaqYIiuHl3FHsZlffK2U/O7SA02x0hSm3cJzWKFZtOuAG1bReimjihF7KQtR3r11I7vZshq3LQi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ov61ZhUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35FBC4CEF8;
	Mon, 10 Nov 2025 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762736164;
	bh=3WMEUAWG+aYlirWLWCoAZLiAXOn1m+HbDH7g1IW2GyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ov61ZhUnmeRYFtOnpDPOFh93vQp4Xh+T5yUznmWx0+p5GLyWxmzAzHOEdMzBTUVtm
	 d2wwSzpdJvYXsWnIzhcgcv75fR/Jn3oiQl2nM/Ve2qJ4bJSQKpJQ4/rnxTh32AwKUj
	 eqI6i/Ov3oSYfmRBDPbrY/DH5ETlIPmnqmOcO1AM=
Date: Mon, 10 Nov 2025 09:56:00 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: gpib: converted // to /**/ comments
Message-ID: <2025111014-arguable-antelope-1d9b@gregkh>
References: <aRDo9UtYTwcoFCFm@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDo9UtYTwcoFCFm@michalis-linux>

On Sun, Nov 09, 2025 at 09:18:13PM +0200, Michail Tatas wrote:
> This patch converts comments from // to /**/ to make them
> consistent across the file as suggested by the TODO file in
> drivers/staging/gpib/todo
> 
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>

That todo file is a bit out of date, we now allow single-line //
comments, so this really isn't needed, unless the maintainer wants me to
take it?

thanks,

greg k-h

