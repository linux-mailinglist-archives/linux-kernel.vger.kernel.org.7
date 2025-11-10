Return-Path: <linux-kernel+bounces-892657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A9C458D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220851890409
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D122FE06C;
	Mon, 10 Nov 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6nA/VSU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9292620D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766068; cv=none; b=o3SbUS2QkXrijZs/8JI+yKtFzIpDYHtbIiM1Hr9AV09xg0sXdtp5j6ncscKrvQTn8zs45Js0WgrhFvQSCJVnUQrRLz/t+XDFwy7fUOvTCKvFDGhg8yHo5Yd467gOJmRex0i7pIuXnsUkbQEpym9Ty9ppsekxwImi4rf2W/oGVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766068; c=relaxed/simple;
	bh=c402kmyLDcO1mbFCe9+0rpThqB9NWThK++CQP0JVvyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8s3+BHtjI+arXwjRsuMpK/3wWJ8B65p1hD3I8JGRZsuPNf1huTaJSmCRa6HC+HDHQKWYw2Z+lLpZmEaomBeGaGs0PmaTb2q4s1LHO5mVQTRvx10fhm1TH8AjIdNPKl6ZMOH9FjF9N4bH3BEaafdFurKAPBv7mA/IdKpv33wIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a6nA/VSU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LtzNxvFuujSl2ZQUousbc8JpVz3Ej2RbTQDavZlkAtM=; b=a6nA/VSUWs6/xzPl5l+9M9nu3D
	1t/Y2N2+dp/sNxsx8i7TF7X1aVbyMz+IqeUXAVJUMPhdhWOshJP3QBiJPYezXZjF2gUh1Q7+Y/2t1
	7R4F1BOcNALpU0b/7oj1ruEFJIZRVmcyZB9KKdsrlrDqJFaZO69rYH2Ute+AI/2WY6uUavLEHznG1
	/bARC/Z8A+74S12BFaai5aqG985GSHVmf5mXTy+4rXISR1DYROEZzrFRurzQKNdfAWrnW3Wy7ScOg
	+BQ5HDEHbvW8cTqLAlSMF3EzlVzsRnH8oe4JR2qleIUoxhNbTO8ZmvnIvu+bG+JzMHK8NO/iVM94B
	WK2F8yzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINyk-000000054Fz-0GDE;
	Mon, 10 Nov 2025 09:14:26 +0000
Date: Mon, 10 Nov 2025 01:14:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
Message-ID: <aRGs8lPjH22NqMZc@infradead.org>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Nov 08, 2025 at 05:05:35PM +0900, Hajime Tazaki wrote:
> This patchset is another spin of nommu mode addition to UML.  It would
> be nice to hear about your opinions on that.

I've not seen any explanation of the use case and/or benefits anywhere
in this cover letter or the patches.  Without that it's usually pretty
hard to get maintainers and reviewers excited.


