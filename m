Return-Path: <linux-kernel+bounces-723153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46BAFE3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF441C28020
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB267283FFB;
	Wed,  9 Jul 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMprPfhi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D0283FC9;
	Wed,  9 Jul 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052266; cv=none; b=P3oFgsgicFX7EOW/qNXDCBvq5fETPEDvszqSNBO7uKa9A5mJx7QXC5so3uugmswvhTW+cT921tObICyMMZ1JH2IkgS5tvIwNyn4gvn7VTV7+7EwYN+DU8r7iy2efIaEV8KYsoq4CxU/AkDQv6uaatoWM898TVhelggS68jP3MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052266; c=relaxed/simple;
	bh=RJwFJnhBCkBRX2oCpEkFXcbwbETz3IhzKnPcOoJM9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZWd66MgHMzp4JEZS7lk6yBf8oZvJhV1/8YOD9AGKDReE/H9SVYKQUX2w+GizoHzXQPqCAsszg5EuUfUTsaIG2Np9j4aWArUBH7a1spy9kZl/HRBsksPTMJhnKjRd/2+yYUQvc9dg61/SVFv+MolF9tyE07B//KptN1fllOLjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMprPfhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D71AC4CEEF;
	Wed,  9 Jul 2025 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052265;
	bh=RJwFJnhBCkBRX2oCpEkFXcbwbETz3IhzKnPcOoJM9Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMprPfhi0ZgjXqW2uKja5OCGaDZ3+nfS5iqH4hY639wSmZEnZsdiTszfX7ZvsODWk
	 NnKpz753NPp3+6G3sZR19pI3iy+LyD8udCx0wpCh2jFUbqgPQwz/q6jg2Rx9auIHMp
	 aZ1zm9oq+eIxbQYbnBjzZnk/qEzFICbaCAVIACFxP1vxs6YaEX8aaII9I5I3TTvdJ6
	 JsVgIVCAPQH3FDh9eZxqbgSxPUUMUEYdaT0c7fwMr748yTyTL3if9C7ghIYBjhdbKP
	 LbaazpPgcOfWRPgEVQ7gx9A7tDx14j3fjWRtsKFELgXRgjoi5WjncZNf2zmpGclkVX
	 DkS6pgiBv/XYA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZQpO-0000000013f-1CHC;
	Wed, 09 Jul 2025 11:10:58 +0200
Date: Wed, 9 Jul 2025 11:10:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/1] USB: serial: option: add GosunCn GM800 series
Message-ID: <aG4yIioU1csCEU9f@hovoldconsulting.com>
References: <20250701100002.798372-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701100002.798372-1-amadeus@jmu.edu.cn>

On Tue, Jul 01, 2025 at 06:00:01PM +0800, Chukun Pan wrote:
> Changed from v2:
>   Only match option drivers for AT and MODEM ports
>   Add MBIM/ECM/RNDIS mode (ID is the same as GM500)
> 
> GM500 commit (ports look the same):
> https://github.com/torvalds/linux/commit/08d4ef5cc9203a113702f24725f6cf4db476c958
> 
> Chukun Pan (1):
>   USB: serial: option: add GosunCn GM800 series

Please just put the changelog and any additional comments below the
cut-off line ("---") when sending single patches (i.e. skip the cover
letter).

Johan

