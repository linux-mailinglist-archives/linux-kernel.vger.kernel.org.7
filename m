Return-Path: <linux-kernel+bounces-730993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB09B04D49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9277A4B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53D1B042E;
	Tue, 15 Jul 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3sOTkBn"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2129A5;
	Tue, 15 Jul 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542434; cv=none; b=T/7NO1fNEtl3WK+kTlEoGAVzqm2lddCmyAZg543QiOzvXHzWNsutSNEOWZS4ZYH0Sah0OEEIIJaeXz6Wi2GyalfgQYAxBcsbcK5L05hASHtzjAuTBvbAGNJTwMpHfOxDmNDde3lkdVS8Zj3lKKHqZElqgJtrOn7UhoVTGd9mM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542434; c=relaxed/simple;
	bh=rYpDziYirL3ZYFK/I9Ik59aptGdN12R8VseqntbfoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GRzPPmMaRq2UgTvoHvRrInaIYTRS4buOCJQxBPxKgwogPf/pgkOlW63py1CIIkWCz5AIbPhQgowHo0+9MkF2iRAD0Ywop4wdkhwtu0lGEH6axi5wLEoxPYty0sCS97swNgUkV3j7arriW+LA7QvPJ37MwWFU+E0IWeD/Zh//xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3sOTkBn; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752542430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+85kuUpWbzYdAAt7bSvzqTfnHCqVfZ3tkov/6GvQy8=;
	b=r3sOTkBnHxT1l/OuHEmvY8Whz9QB6r7MHJ2EVUVIovpMaK0eYjkGZ88wNU9C3TtqbjgcIK
	5VioGdJdB/Jc4Z1fbb2o1z5AHNxR4y2VzGzDcKbhj0vsphxtKPbtQylFn9K3PDC5W2SfSC
	Q6Ox1rHyJspLNcZWtnBB/vElUg8hIHU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/7] hwmon: iio: Add alarm support
Date: Mon, 14 Jul 2025 21:20:16 -0400
Message-Id: <20250715012023.2050178-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add alarm support for IIO HWMONs as well as the minimum/maximum
thresholds. This involves the creation of two new in-kernel IIO APIs to
set the thresholds and be notified of events.

I think this should probably go through the iio tree given the amount of
IIO stuff it touches.


Sean Anderson (7):
  math64: Add div64_s64_rem
  iio: inkern: Add API for reading/writing events
  iio: Add in-kernel API for events
  hwmon: iio: Refactor scale calculation into helper
  hwmon: iio: Add helper function for creating attributes
  hwmon: iio: Add min/max support
  hwmon: iio: Add alarm support

 drivers/hwmon/iio_hwmon.c        | 522 ++++++++++++++++++++++++++++---
 drivers/iio/industrialio-event.c |  34 +-
 drivers/iio/inkern.c             | 198 ++++++++++++
 include/linux/iio/consumer.h     |  86 +++++
 include/linux/math64.h           |  18 ++
 lib/math/div64.c                 |  20 ++
 6 files changed, 830 insertions(+), 48 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


