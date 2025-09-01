Return-Path: <linux-kernel+bounces-793827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E78B3D8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5EC7A5A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E7223DFF;
	Mon,  1 Sep 2025 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXGEopm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6352AD14;
	Mon,  1 Sep 2025 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705075; cv=none; b=g/pncDl5ck4Qv/RnNkXi6RQ4C8irN1ZJIy0zwd0pyhBuDsC/sM7KgOp5d9xufxHjGDU+F2QxzrdaPjynLT89m+fIC85PPbjg8BQg5CAEHMJB4gmxCN2wEpwj2NfHVKS/PqbLXiC1PTnjIjMe8nT3DPB4raJm2CJiXu5dmoWjGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705075; c=relaxed/simple;
	bh=f+JiWvt9Xs0EHBmoA0hiGQioJDdBkcV9WBd//helHlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOeae7CZPnlGm8dhZxb6MvHcNZnd0WpiYc/X2f/fyuYR3bExU3X4gfZsNppEt6hFqYk/DsC4y2QiLgv+e81jOqZXymhSWW5r2vK63nSbmqHrQ7BRbhsNNsYcqlS6CDG9AGvTp0G3d+ZnEg6e9KzdqntTWrxwp3MDqjwSu/OgshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXGEopm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF973C4CEF0;
	Mon,  1 Sep 2025 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756705074;
	bh=f+JiWvt9Xs0EHBmoA0hiGQioJDdBkcV9WBd//helHlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXGEopm2uak2fe0Hbt1qKM4ppyzNQ4eu1dnbu9uNT9NxB1jH/HIB65few/XHeA1sN
	 /Spcb2uRG2JHz+6Nfw0K7KeoqM/XitzISKsffVEiP+sav9qH+tNlHwu2W1Q84xvsgc
	 ft7n7W3BSxfyycau3oaScRqYZEmkYeTAuHtC4twY=
Date: Mon, 1 Sep 2025 07:37:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: storage: sddr09: move write buffers into info
 struct
Message-ID: <2025090126-gully-tarnish-43f1@gregkh>
References: <20250831192247.1120619-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831192247.1120619-1-alex.t.tran@gmail.com>

On Sun, Aug 31, 2025 at 12:22:47PM -0700, Alex Tran wrote:
> Changelog:

No need for that line here, right?

> - Moved allocation of buffers ('blockbuffer', 'buffer') in 
>   'sddr09_write_data' into info struct and freeing into 
>   'sddr09_card_info_destructor' so that the operations are only 
>   performed once.

Trailing spaces :(

> - 'buffer' length is now size of a full block instead of being 
>   dependent on sectors.

But why are you doing any of this?

Please take a look at the kernel documentation for how to write a good
changelog text.

And do you have this device to test that your changes here work
properly?

thanks,

greg k-h

