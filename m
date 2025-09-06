Return-Path: <linux-kernel+bounces-804205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444A7B46CCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29BD3AFF81
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90528935C;
	Sat,  6 Sep 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSOSGTiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE43283151;
	Sat,  6 Sep 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161331; cv=none; b=DcxXsrTCUOsB9+d6E2KNpeteSxjf7nhCCMBd/ZZN7eOqtEgX7jARFr9lfEIanXJfkHOErwq1erXWx7azcasa4CLKIlLwutyjFGpHziI9zrw66s0mALGM2SisTcgyr6bFwU9HB9n7t6CUU/lZwcwqwBQnmHi9sFpDdRAgATOoPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161331; c=relaxed/simple;
	bh=QghVgoooT3vAbgN3SCdxZapnJcWvzLkPCesfCb7cHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgR/Ts+TiI0F82ry/0z40fZvxWxxvbpUti2qlwE51GtMHe2tkvCGQpA8GoNZA60wo1rt7iT1Ymq3BeaUXhTyc0T8hMhHYe9ZB64QJXd9MTs4Jix7idvCJrLS+P+CiKbh+cPK5GDs0wiD1PTIckv8wHCkJcqVY1XVi6kdxYMzpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSOSGTiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18AAC4CEE7;
	Sat,  6 Sep 2025 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757161331;
	bh=QghVgoooT3vAbgN3SCdxZapnJcWvzLkPCesfCb7cHoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSOSGTiv9lsmKqOrU8KDHLPnNfISkQ3z+tOrHO5H6JCwjr80iQ4CHg2nlQH8GVZYH
	 zTxYWPdTu3bF0mGt0osEBDlB04uR6m9seb4pAYawpvxSj+EhBZOvMtAOdb690baBxA
	 fswjwD/AYWJGVU1I0aUv9dBtVut9ZJISdoyDSOQY=
Date: Sat, 6 Sep 2025 14:22:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srikanth Chary Chennoju <srikanth.chary-chennoju@amd.com>
Cc: Thinh.Nguyen@synopsys.com, m.grzeschik@pengutronix.de,
	Chris.Wulff@biamp.com, tiwai@suse.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, punnaiah.choudary.kalluri@amd.com
Subject: Re: [PATCH v2 1/3] usb:gadget:zero: support for super speed plus
Message-ID: <2025090634-antibody-maverick-b2ee@gregkh>
References: <20250828112944.2042343-1-srikanth.chary-chennoju@amd.com>
 <20250828112944.2042343-2-srikanth.chary-chennoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828112944.2042343-2-srikanth.chary-chennoju@amd.com>

On Thu, Aug 28, 2025 at 04:59:42PM +0530, Srikanth Chary Chennoju wrote:
> This patch is applicable for Bulk as well as Isochronous transfers.

Please look at the kernel documentation for how to write a good
changelog text.  I can't really understand what you are wanting to
convey here at all, sorry.

thanks,

greg k-h

