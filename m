Return-Path: <linux-kernel+bounces-827710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15003B9277B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9072A395A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A5316189;
	Mon, 22 Sep 2025 17:44:10 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F39285CA2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563050; cv=none; b=MDTUwFvug+xiMqPQdqSCbOhIZh8AC9/oQrfTYsRmQqsmO7v1Gt+Evuzyx7Y4HTg7NdlEyigfsvtxA9Qd/GZT6RxgDt12U4hVHks/T+fm/6oqJ8+Guw3Seke/wY9VcCbFikQ/2hTHxzIC6/1Oc7AN0/MIw5/EfZApviCsTlQ6ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563050; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXP/bYjreMhz0NoEWwXUFbDCPiknOvOo5crRI9lXz4oizkI0y6cpk70o+gL2NeWK+9vHm6/L3LO7ilELszJObiSwuKMcvs7NjPMW0VWEG8INg1Vv+6cOadpShYL2EiGlYhSrtv+iv+tNJA52JdQBtWmGxJyBAH0UJOhRDaERlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B237227AAF; Mon, 22 Sep 2025 19:44:03 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:44:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
Message-ID: <20250922174403.GB14736@lst.de>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


