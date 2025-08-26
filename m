Return-Path: <linux-kernel+bounces-785715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A715B34FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573A91890655
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB543A1CD;
	Tue, 26 Aug 2025 00:10:15 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA41CD2C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167014; cv=none; b=q0abjkHih4nervpgzglxH7M0C+oA9MFDyNYCUtNz1Uud0LsBmO/QEjmVKwUBFkpY6LrMq3BkI1gpR1jH2jeP229mQBEvC/T7AyiQb7AulJjBcv5K3JyKJKfjjUFAqT8jR0BE2/PWtI7szoV8TAyOPjJQ5g0y1XxP3ZsxcmCo3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167014; c=relaxed/simple;
	bh=+MzvFeNJiDEBQ1mrqEG/peSy4HJ1qlP2TRscSwtRZmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpMJuXjnwuKtcHWN5J1FaUMvsl4BYhHFLnI/JPK0jiw6ISfLMNAG+0UDD6Epr2OzRafxSrzlhS4/hpL4F38sxCujJ35KB3MQLeZel01yz7YYoq4SXJktrRqG+hWo40DVwHo/nXPTK8EMUqrT5TlTRjW/gmv4/mHIw2LBb8hk9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:04 -0400
Subject: [PATCH v7 2/5] ABI: sysfs-bus-iio: Disambiguate usage for
 filter_type "none"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-2-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

When a filter_type is "none", there really is no useful information that
can be presented from sampling and frequency attributes.

This is especially true when the driver supports more than one
filter_type, since the information would be ambiguous.

Suggest returning IIO_VAL_EMPTY for this case.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7e31b8cd49b32ea5b58bd99afc2e8105314d7a39..df42a4040530ee96096b998bebc8a08b4fb2d78f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2276,7 +2276,11 @@ Description:
 		Reading returns a list with the possible filter modes. Options
 		for the attribute:
 
-		* "none" - Filter is disabled/bypassed.
+		* "none" - Filter is disabled/bypassed. When set in the
+		  filter_type attribute, a driver should return IIO_VAL_EMPTY
+		  when reading sampling and frequency related attributes of
+		  this filter, and return -EINVAL when trying to write these
+		  attributes.
 		* "sinc1" - The digital sinc1 filter. Fast 1st
 		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st

-- 
2.39.5


