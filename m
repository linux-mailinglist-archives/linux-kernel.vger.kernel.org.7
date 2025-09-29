Return-Path: <linux-kernel+bounces-836322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83408BA9521
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E95F3AB162
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DB30749A;
	Mon, 29 Sep 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNACg5sF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A82571C2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152253; cv=none; b=fH6IHHE+edaJ3WurOrrZyDvoHie//dkcbvzzLVPvkONvSq+jkQA/NJHiVeyQ8YkFYo5dtG9750raI0ATizOoI7zRL5vgE1LBiLbNGhu8FUHlcp1xPoYaxItuoFsqVcmaWdr45nRIdIlUKdpd74ZWA0KhT5OJskm3Wk/hVNyXA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152253; c=relaxed/simple;
	bh=ywHwz1pH6qvpqhZ11wp0ypOnf//M6bqVv2hQrLVeP0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzEi+uEsbTzzbSsztiKPgG6E01TlUMfJpgDTdqoLd5ZA/AApDU+xW7t3g8+h9et5+142N+Mox2EsliCVUhPQErtkPb84zJCUWax6VVurhpMPCqYtLenMCeDSJ3oDMuWWLMkAcAJhHeO6UWOJiabdp3l+90AteqOZOf1pxwdFYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNACg5sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A57EC4CEF4;
	Mon, 29 Sep 2025 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759152252;
	bh=ywHwz1pH6qvpqhZ11wp0ypOnf//M6bqVv2hQrLVeP0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xNACg5sF0/qxnSED7MjoLtSwfSWT3ZAuosv0AuJMGIAyUygwWJQWPvHsmFtveoLLf
	 XssrtUxZmpNgy+PGWrq8IaeoAVjXAwRwtPQM4nQW/4ws7xAU4L7TE5hqb7KYpso2+v
	 cdKaa2ugDmCUxCLBrOTlmL5vRV6nKyTPZSJHS71I=
Date: Mon, 29 Sep 2025 15:24:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 5.15 2/3] NFSv4: Clear NFS_CAP_OPEN_XOR and
 NFS_CAP_DELEGTIME if not supported
Message-ID: <2025092903-plentiful-banister-9ad0@gregkh>
References: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
 <2e811427a30b62898f63bab33ec07d9253061a33.1758805195.git.siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e811427a30b62898f63bab33ec07d9253061a33.1758805195.git.siddh.raman.pant@oracle.com>

On Thu, Sep 25, 2025 at 06:31:45PM +0530, Siddh Raman Pant wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> _nfs4_server_capabilities() should clear capabilities that are not
> supported by the server.
> 
> Fixes: d2a00cceb93a ("NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> (cherry picked from commit b3ac33436030bce37ecb3dcae581ecfaad28078c)
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  fs/nfs/nfs4proc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 3d854e2537bc..91b95310e107 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3906,7 +3906,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
>  		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
>  		server->caps &=
>  			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
> -			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
> +			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
> +			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
>  		server->fattr_valid = NFS_ATTR_FATTR_V4;
>  		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
>  				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
> -- 
> 2.51.0
> 

This breaks the build :(

