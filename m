Return-Path: <linux-kernel+bounces-850465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA81BD2E49
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 852B74E9F09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8126463B;
	Mon, 13 Oct 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iF1vJsmk"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68220126A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356952; cv=none; b=hhMa3wxlwCUebcbnFAHqm9mb0S5meGlpv2hNB2s1L77uPp/8bWw3vc8/VdwwK8IVIIPAI6jOogJAYSqmWfWKjY+7N2BpyZ/ewvOssIYqE3KErl2wYp9uWdsVzHIwBwiUTnMzVIVfqHES96Qt5CL7Q1r4vCA2BeJsCLUlsrwQjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356952; c=relaxed/simple;
	bh=KHboIQv6refupr1G8jO/PDidwtSpxE+8ysLOORDABVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ol/lXyZM+0CL2VqHEyM6nUHGWDjaomOb2md0R+4topojcSuEf5+E19Pq+k5H4hdsRpRAsFBSMPiOdHxDe43inE7t3iBu3Jel0kZfBINrDanKYNSc0/56jHckNcyGhT1rRBZnOCTCWrNFOSJRx6tcmu8koryqV42DsTkaUa4KbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iF1vJsmk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760356937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHboIQv6refupr1G8jO/PDidwtSpxE+8ysLOORDABVQ=;
	b=iF1vJsmkXSUxP04f5R/FFr3Y/a8MD76OVbhONUWNa7ZNO6+0+b74fNBRuagGl3K1Pvahkr
	XTCT2IRMsqTEchHDlq4Bsd1OnOotdf18gikEaDlXqcGXTFCbDhlwNz25eG4YNOXLTsxF/L
	Pcf4TRi1LKOf14+w2ccQH+QkRmKrw5o=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251013115129.30304-2-thorsten.blum@linux.dev>
Date: Mon, 13 Oct 2025 14:02:04 +0200
Cc: linux-hardening@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48BBD43F-50F9-4521-B636-CAC71B8DE871@linux.dev>
References: <20251013115129.30304-2-thorsten.blum@linux.dev>
To: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
X-Migadu-Flow: FLOW_OUT

On 13. Oct 2025, at 13:51, Thorsten Blum wrote:
> strcpy() is deprecated; inline the read-only string instead. Fix the
> function comment and use bool instead of int while we're at it.
>=20
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

I forgot to add:

Changes in v2:
- Use an inline ternary expression and remove 'char abortstr[2]' as
suggested by J=C3=BCrgen
- Link to v1: =
https://lore.kernel.org/lkml/20251012195514.39003-2-thorsten.blum@linux.de=
v/


