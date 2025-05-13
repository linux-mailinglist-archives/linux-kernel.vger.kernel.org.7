Return-Path: <linux-kernel+bounces-645324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210FCAB4BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FFC3B6F79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAFB1E7C2D;
	Tue, 13 May 2025 06:07:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30178F44;
	Tue, 13 May 2025 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116460; cv=none; b=b0ljlBahLvjJscLLlcw5B61+JH5H5jhXbu01076jOIZRJpgmeT+X2n91V8do2fdOA6f1Hn9aZ+L5/JLiFFoVkaV5hvKYXRlVhvR55jKIwhktlfinEnmCwxabkGcIn7Q3pSkhQCsyePiQ+XVQw5v2jyI7V/fTSAMJ1VouvoD55nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116460; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEN7Uew0luJxC1vz3+kL1+x22fjIQaTcKVFfH8OgvAZTe7stymsRU7YsB1U//qU/Amq7blZrNwskgIqvMW5Z1/gbBSyJ+G+r1OtUt/O96APmO3m/FCganZ3ilx9uphIAwD8t96ReKv9Qvy+ID+VhCMBXi9lcZE5AQYaxDM1sdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89F9A68C7B; Tue, 13 May 2025 08:07:32 +0200 (CEST)
Date: Tue, 13 May 2025 08:07:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RESEND] Documentation: fix typo in root= kernel
 parameter description
Message-ID: <20250513060731.GA396@lst.de>
References: <20250512110827.32530-1-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512110827.32530-1-arkamar@atlas.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


