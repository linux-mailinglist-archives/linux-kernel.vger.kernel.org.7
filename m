Return-Path: <linux-kernel+bounces-813377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9EB54453
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32151480ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F292D3EDD;
	Fri, 12 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qRgUXTkC"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E702BD031
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663937; cv=none; b=h5YYQSSatTa0/LTVhFsm4+JzBxmFGVAKpWUwgcjALgYEXInPLB/WkQu+1DA79wvXVZlTT7HF7YPkBbGmXu16ams92gUxDuL2G8u/l1hWGNgkUEXua6Y+vV8wD63K748sk8dQiP9vnW/fXxfy3oTwVMm6m4cjvSE8uXaVhkiKlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663937; c=relaxed/simple;
	bh=j03RuNT7+4gCtGue33+Zbji2ovGTMqcwJmLO6kcquqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/EI27PF5ufzbEckti7uDCpobmV8FgkOaEj3FzM7DcBgSBNeySjvQakrfJF+qKmSMAcC8d+HfC10idqKaEyTAsYG9TL2VCK0frqj+Z4fy8T45F2pyhS5kCH5WOr3QPcBQI1ndVRongnTFsVIyCGXu9GAD6pX195WLMw8cXMTM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qRgUXTkC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j03RuNT7+4gCtGue33+Zbji2ovGTMqcwJmLO6kcquqI=;
	t=1757663936; x=1758873536; b=qRgUXTkCMkjxAyRNOBnH9yXR5VpTX4azRVeB4X08Qv5kHNz
	oEYrNtCah63U7SRrLLrqV5Da2E8kE0OcvSe/qybd/kxlOH0mDRNU0bxDTJhMmNqDd2axPIEA9kflW
	mVtwhRZm+CR28IdIi1uG0pL+SuVUwOm38oTj6HzRGxoD+Y/8fF6h54ZWFm4l47nZapX/JsglrWZ+c
	3JdJHcBTDwDbJpPdhi3iOOkosxpQzkGOafdpg4XxkuWGRyyItHbd7Lvo2uGQryxz8xW6c2TEiOFA5
	SjNNzfSR3sXy9UbYVck5S7OYT8vYzqKeF+DmEjeTBr9uM6CrFYs34wYp7pteJ5tQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwyg6-0000000GtkT-28wT;
	Fri, 12 Sep 2025 09:58:42 +0200
Message-ID: <d8b8e87871f847473d4e2ca91fce00b7b12b8f19.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Fri, 12 Sep 2025 09:58:41 +0200
In-Reply-To: <20250912004501.2565976-1-tiwei.bie@linux.dev> (sfid-20250912_024557_736137_0C9523E1)
References: 
	<03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
	 <20250912004501.2565976-1-tiwei.bie@linux.dev>
	 (sfid-20250912_024557_736137_0C9523E1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-12 at 08:45 +0800, Tiwei Bie wrote:
> >=20
> > Another thing that isn't covered is anything relating to interrupt
> > affinity, I guess? Is that automatically not working, or will it look
> > like you can change things but that not do anything?
> >=20
> > I don't think it's important now (though eventually I would actually
> > like to have it for our simulations), but was just thinking about it.
>=20
> Currently, our irq_chips haven't implemented the irq_set_affinity
> method, so setting IRQ affinity is not supported at the moment, e.g.,
> attempting to set affinity through /proc/irq/IRQ#/smp_affinity will
> fail with EPERM. And yeah, we should support it eventually. :)

OK cool, thanks for taking a look!

johannes

