Return-Path: <linux-kernel+bounces-733202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A03B0717C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93C27A7493
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E72F0C4E;
	Wed, 16 Jul 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET9rsj3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161742BFC85;
	Wed, 16 Jul 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657587; cv=none; b=qVHyPWIYlp04WxejrvUWDLc/tv1g7wpBxsF6xh+eSMD/lV7QcukSx1+XKnEtxF6l+4zBTWizg87CsPANGzsbj8DWt96KhEdh2KQgkiWWxoKvKT6FOmqNjJ1UzViuQp6iSdgwT4HGb5weAkopkIvdrJ5WKBe6YXaa+2EeKMuhJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657587; c=relaxed/simple;
	bh=ywz42kL2C3tU7sbrs2zW/PapOzfe6VM4x+3QhsLMr+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3yz4RsRS4DMdSPsXUbOxeidx+Kc4aVFOEia2K8hVXlcIrVUqur07eHc/vZY/gT72kwrT8IDgJXF5U/vetycqMeMjoMgYAyxA6vigpKTrIQXNQxHb+v+OUwouaraUcmr/2qUC0HVZewaXwLldWQd5PKnO/0U7FuxUmoKPJxA8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET9rsj3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36DDC4CEF0;
	Wed, 16 Jul 2025 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752657585;
	bh=ywz42kL2C3tU7sbrs2zW/PapOzfe6VM4x+3QhsLMr+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ET9rsj3MPPEa8nRdgx2+czjT92g/pxwIRGnDVIkITmpoRDtxkET8R1ZpEAJx3nn/L
	 F34iclUDVAtemu5DdhtEZ7VxlI9vd84RE+4OJ9B/Wv33CzmZ+riTp1aSi9qdDLnLaI
	 cy35eiG7apSUhmOHpc33QGRHS1FcXObRcLAtwTNjuYLm/sxZsHe2VBT0/3Kij+QMUO
	 kzR96jck6rmozWkx/RWLl0Uleb/q8e+EM6shYb60EyihCkrq1paDuRsPNL1NCuG/yZ
	 SQ8pc7bJYGRwUNVG9v/Qg8LwdtaF6vaOYw6mcBWwk4+3fF4swm91z4mlGa22wbfqXi
	 DENEz7XgxRh+g==
Date: Wed, 16 Jul 2025 10:19:41 +0100
From: Simon Horman <horms@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: oneukum@suse.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: Remove duplicate assignments for
 net->pcpu_stat_type
Message-ID: <20250716091941.GN721198@horms.kernel.org>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
 <20250716001524.168110-2-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716001524.168110-2-qiang.zhang@linux.dev>

On Wed, Jul 16, 2025 at 08:15:24AM +0800, Zqiang wrote:
> This commit remove duplicate assignments for net->pcpu_stat_type
> in usbnet_probe().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

This one looks good, thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

