Return-Path: <linux-kernel+bounces-856211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C220EBE37AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C802583B79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914332D7ED;
	Thu, 16 Oct 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1jgQmlEP"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23132D7E8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618886; cv=none; b=VgFxPyh6OawIsA7wmQLrWI7hrx7tTt8Rp70HuzjRk0bpJZoblIhjkgVlwTEr4Ih6lNRsuIhIxBPpatrzrqQzWKXd/z12C0whK23SV1mlKbDYMnxswB3ImIxvJYi5TuZB1vt5+bt9R6+L6+NIfWnt9IQGgshEK12UfCI+OcCeoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618886; c=relaxed/simple;
	bh=2VGYIFhCEbg4Av7ThEIru62x0BzDYBfbXS+3ApUDDF4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=QKAngXL+1dc3gr+b1oUsIRDaQdeOyviXYoQUIqYJUNdOX3aSA6484Zo4N9r9kK9lUukCV+1NTTFe7KGXgVX3iS/HLOL3Iys1jYoosD1Joe9Q65gmKWzPSgG/muX1JjKUhRo+iIsiOYlCReBSeXszcVGUkXVPS/Gheo6brEv4cLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1jgQmlEP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A9E12C041CB;
	Thu, 16 Oct 2025 12:47:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D38F36062C;
	Thu, 16 Oct 2025 12:47:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE650102F22EF;
	Thu, 16 Oct 2025 14:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760618874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=bDlImIPnSemLL+2SLF2wFv7SSzHssDb0btu+nU/rJmU=;
	b=1jgQmlEPos1PB5Fh62MniFagobrgwHnxZS+CfVr/57V9xJEvZoIgBCyh1d1P7947xJeXlG
	YHcNYBgBcnzE+cIZurnvR/SbogHePnEq0DaRVyTjc8m/ss8BYw5sd79ylaAfyCo6mXyjnv
	FgKjoFxfKVRDvGrp63upRa/jBNhAyxA1TejJMcdxV5zkwe9uSELiRUM8IcBgmDYWI8rvhl
	n2C8HMT91RfwJ0njDQh+xYbiQ5s1yp6J9yQrwD3nevQnW6N+PxvOXxe1cCaNukvzqACSfw
	IDQHsEUuSoK+turinZkaXxTg3C+IkLOOb4gRtuFaug9cOjwCkbCWk7Udp0V7iw==
Message-ID: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
Date: Thu, 16 Oct 2025 14:47:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in ACPI
To: rafael@kernel.org
Cc: regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 sunilvl@ventanamicro.com, apatel@ventanamicro.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniele Cleri <DanieleCleri@aaeon.eu>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
noticed a regression. The driver does not probe anymore and I get the
following error:

[    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
initialize FPGA common GPIOs
[    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
failed with error -2

The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].

I did a bisect and I found the commit which introduced the regression:
e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
to support nargs_prop")

Best Regards,

Thomas

[1]
https://elixir.bootlin.com/linux/v6.17/source/drivers/mfd/upboard-fpga.c#L192
[2] https://gist.github.com/thom24/2da44ef86eacfa5d2d492ce43fa41aa4


