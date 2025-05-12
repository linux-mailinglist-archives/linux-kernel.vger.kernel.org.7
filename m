Return-Path: <linux-kernel+bounces-644318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F7AB3A45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CE63A7CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE31EDA36;
	Mon, 12 May 2025 14:16:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621E1EDA11
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059375; cv=none; b=F04lOThcSXz3yI1jyGwijtFun66yZdIteJRY1wnOHca/kkgsIoB1wd7Km+2QtZK4EG2PFZrMyXktBmKiwms5NMTmrEvMC8FmFZq93D2rr0GlmiqMUI98RkcM8KDEGOoQ9aJXIlAeVKPXZqqtDWwK5xCzRJnToLLWSQZCGjABAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059375; c=relaxed/simple;
	bh=qVmQpw/swaDhfL6ew6WyZKpYm1pgJ0eIPduQCBQoXsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEB8bK03S7s5gK5Gt5gUutczg0D46GDNfNI4R0if7moBXFyT+cVyghV83PKWG3Ygl8W6nZqTryHgCJnasj3Ws2r3n42hiWwjaHbMVsDTrYElR6roeWfMhTDbjqsX9HJT6y39B1uGkPcKzsl348GG3btE/PWtCG+JqNsESfxWsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAC7B68B05; Mon, 12 May 2025 16:16:08 +0200 (CEST)
Date: Mon, 12 May 2025 16:16:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] nvmet-fcloop: track resources via reference
 counting
Message-ID: <20250512141608.GB3822@lst.de>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd like to see more reviews for this if possible, but we really need
to make progress on it, so I've queued it up in nvme-6.16 now.  More
feedback is still welcome.


