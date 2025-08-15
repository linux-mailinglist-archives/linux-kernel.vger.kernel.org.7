Return-Path: <linux-kernel+bounces-771051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABCB2821A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3896F5A2D67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46371225A3B;
	Fri, 15 Aug 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fzhmmiex"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71991E230E;
	Fri, 15 Aug 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268818; cv=none; b=s+DDLRs7Tzawv/8vcgP9U9EmrsfGWMbLErA0iPlHRIcbX99Zdd15a2eMDI0fNjCR3lrQvz5klDWZAaZzLbcAhx5gXuTottBACLf28TJ29M8997SoOhHA02FSJKbHeq5U68C/9RZ3W9DYKuJmYJ7YDfpU6aH7iw2OcIFq6iI19Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268818; c=relaxed/simple;
	bh=nJMUqcyAVOa1cmEtpMjakS55J/nUr2eVRK3pid8724c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XjT3y9JfaNuqV0CROBIO+Man7DUdt+/p/Cp/3se2OOouDULkEaWloWP4fVOIH79e3K/oso19gx/YNPQoLYZ33Pv81Zsbtw0xzC41LrpuIiHT/6S/XJUdEHXsFsGxGxnvZ3c9mhoeBfquFhXoyTeW7/aFyFNPM0eZYaUxTwkvoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fzhmmiex; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755268813; x=1755873613; i=markus.elfring@web.de;
	bh=nJMUqcyAVOa1cmEtpMjakS55J/nUr2eVRK3pid8724c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fzhmmiex0sxwE1HAoUOyR9B6E24dSzXTtUa1YxUqGelPk6ary4FME8uaCjwwIjZV
	 +LZsxUl/UwKQ+8freQFx60NgnTRlWRSwCzQWZ0wxmLmghmQ3GsgYKQgPS92G0ZuXS
	 D4vALf+J2SmvuLhOa9lANUX2W4sk1t3GuRgeiRC9oHjrpJwEGDoReOVTNoqkFYBVm
	 EuWjpb85Q5balF6xd2b6uV5PR1zCdvFsYKSTsoI16Gjwi7t4iI9/JyNzKj48BmzZl
	 QCfgjEbwR/d0CZb9rhS++ZlMrGmtYIztRDHYspwqRb0HhfJ99Ss8PsP4bhfjwZKa5
	 2iBMJbejbqk24r/Nfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1uEkW80fGv-00jVUy; Fri, 15
 Aug 2025 16:40:13 +0200
Message-ID: <35e23690-a907-4606-a484-e3e342a14e7c@web.de>
Date: Fri, 15 Aug 2025 16:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: akhileshpatilvnit@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Itay Avraham <itayavr@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:naW6yBPCl4bWjNUMrMVxGo/+cDGjwbjFgUEOi6Oon8+wz6Nk/bd
 LNIMC8lOiKgfVXIuhx3nyFXtfzFHGOiIrd2tXwRpFnPpHGo8xnZwFQY+xOow+f6txcwQ8kP
 f8UXJWCaOraS345FhvgAHMLSdNkeCxZo60qlS5nvT4Zo+xvZzYO5iaDxEaUcNhTxtTv1SLm
 9hZkxnnnAJYTCe2xOa7Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B2UPRQJzepk=;zzEafaEMemS1epnrx2iXV2FpXAe
 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
 hrpPLl4VOYBfVtk4=

> Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> Avoid potential memory management issue by matching alloc/free routines.

Will another bit of background information become helpful
for an improved change description?

Test command example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch -D report scripts/coccinelle/api/kfree_mismatch.cocci drivers/fwctl/mlx=
5/main.c
=E2=80=A6

Regards,
Markus

