Return-Path: <linux-kernel+bounces-579751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78C0A748FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 12:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CE61709E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BED218E92;
	Fri, 28 Mar 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kapvXhVP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A88211712;
	Fri, 28 Mar 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160154; cv=none; b=AzhzYlxvuKwK2z0SaqlQp3mY5qyKXgUzEKIsVNF9gvFWjOcymoLLj8SlNbia9GLYjXUs8HgvlZ/Pa93HaE7A4eGsbOXMoy4f3v+H+xfNNhZiHMbaJppykghs9cxXejGAlT0dOYUMaz+5CuCc4MDuFcMg5JwL+JliDCM3XwOC2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160154; c=relaxed/simple;
	bh=D6N9qzKUT9BZh+ogJLR5ASaK3FHRy/BmXp/4ya31Koo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iPprKBwrRZks1diuftnlgyKF+fbsOVr0iqTW/H7YUI85CKc0noZ5sPskMkJFIfT/AngItuum+V8Ofnn8AnU2Gf11gEjsqsWQTGEX7Blivo+VP2NYkUozVl61sce6FGaVC+ClbEORKV7MajLWO0d12x7fu5f4xadAVYm8ytzxrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kapvXhVP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=E1CZGD1pidzZgn48GAT1Mcecb/t9aAcKt3ERnV/HmUA=; b=kapvXhVPCuEr6PvbdopbxRbdZJ
	BQfj9gASltro+1hTUIr7Y1ANg3CYSQ9xx+0FhST4rYrI7nbDSFQ3/yhRo6pLwAVzbk8sECa68zkB/
	uimOCzMhwQTwDNlheUAgTusdI83xeE0a9Urs6sV/2EvVZYwDyyP6fSTsvzFdNtLHW8rsn5uXhEN58
	q1bk3HNm4Z6FgM29UR7NNW6D6q/BIYXM/NJw2DaK6hMXBxNdHKk/qEYxTOSLOiOHobv3Mf/4PsIlD
	BjWvBEGnH/sKD1qog7MU+6SUOt9RqhhILVOfLXXYWwabkNGxliHvV9fBaD4+0InWkpO5vC18SCbnk
	huIzXc4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7aJ-0000000DD4H-49YO;
	Fri, 28 Mar 2025 11:09:11 +0000
Date: Fri, 28 Mar 2025 04:09:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Message-ID: <Z-aDV4ae3p8_C6k7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-configfs-maintainer-v1-1-b175189fa27b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 26, 2025 at 05:45:30PM +0100, Andreas Hindborg wrote:
> As recommended in plenary session at LSF/MM plenary session on March 25 2025.
> Joel is no longer active in the community.

I'm not sure who decided that, but that's an exceptionally offensive move.

Joel has helped actually reviewing configfs patches even when I as running
the tree, and I explicitly confirmed with him that he is willing to
maintain it alone when I dropped the maintainership.  You've not even
Ced him to tell him about how you force him out of the subsystem he
created.


