Return-Path: <linux-kernel+bounces-879812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35494C2423C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BFF564DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE95330305;
	Fri, 31 Oct 2025 09:10:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01732ABC4;
	Fri, 31 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901819; cv=none; b=NFMEKxTzLeK5/5XQky1o0DSJd0dbqMVBI9LpCU64MAgTUqpCNi1nsaK+2x0YSP6+Axen4GTmYH87FxRCUn0GDPRTTQXP8V4Vx9g6fjutb7GgG5WZ7SCkR1EAjMFyaee0R8QMgAYqdKZrczlKT0pq0ScffY5UlP1AI8g5u0wJkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901819; c=relaxed/simple;
	bh=D/mPPvnyLAPwluyXYtU7V3lARpwYkvyFIeIREaupNtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDA52x1W0IX/+r/8CRj1Wb5TJyKT8auQlFGjBgZV+orgH5/65v4ysnPJYiLsxbiKCLHj0VhIFnpBqt1EQ0go+SCaq7Gn/BPG8VfO1avV+fGplTBMowJUotfIM26P1s+mxu4cUuQb2uuPQADegl1QaHvy6Lu0PnUvBFw0s/gTvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9C6D227A88; Fri, 31 Oct 2025 10:10:14 +0100 (CET)
Date: Fri, 31 Oct 2025 10:10:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Llamas <cmllamas@google.com>,
	Jens Axboe <axboe@kernel.dk>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-ID: <20251031091014.GA9413@lst.de>
References: <20251030043919.2787231-1-cmllamas@google.com> <20251030060303.GA12820@lst.de> <20251030171704.GB1624@sol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030171704.GB1624@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 10:17:04AM -0700, Eric Biggers wrote:
> I'm not sure what you mean.  They already take encryption into account
> and report dio_mem_align=filesystem_block_size on encrypted files.

Oh, right - it's just hidden a few layers deep.


