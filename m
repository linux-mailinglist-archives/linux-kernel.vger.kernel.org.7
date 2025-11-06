Return-Path: <linux-kernel+bounces-888561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5692C3B363
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4003BB43D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570232C333;
	Thu,  6 Nov 2025 13:09:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0E328629
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434573; cv=none; b=AjovJtum7mgb4n3VdFi5JogK+w8DsKpjEanaiSkJ/rqVVUHhsFThkBwVowaQegH4Wbfi1RuXnU3+45+IN66cOUrusJtaYEwpmwt7k25FHB/0WzJ6d5O4c1uzClu6eBC59QzpIaFG/O1WviiOOdmne5psLU3/igLVBmP5kQZ4jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434573; c=relaxed/simple;
	bh=4MSUvpBI5vy5tjEQd6chGWSvvJB8tbSJGCBMwPqM6Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toEJgf0IbHHaR2BZ8/s6C3sr+/qfjh5+YyVRDqOLwnQnK9ObKNbZBLTdGDeI0eUJDSVG6DvoRMekcfTq+JQeIhyBTWudJ8NXY2OXCGn1SrCFmhY7HhRzYiOJx7kQIyMOOUS8jaC0fbolHW8YKEmq8fdSOZVA2pDDABQIwB3UIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B5B3227A87; Thu,  6 Nov 2025 14:09:25 +0100 (CET)
Date: Thu, 6 Nov 2025 14:09:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251106130924.GA7528@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 06:35:48PM +0530, Martin George wrote:
> >  	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
> > +	req->sq->sc_c = le16_to_cpu(data->sc_c);
> 
> Given sc_c is an unsigned 8bit int, is there really a need to make this
> endian safe by calling le16_to_cpu()?

... calling le16_to_cpu on a u8 actually messed up the endianess (on
big endian systems anyway).  Everyone please run sparse on your
submissions to catch this.


