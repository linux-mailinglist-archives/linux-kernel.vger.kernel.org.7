Return-Path: <linux-kernel+bounces-797489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB1B4110D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B64B5E6DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A52EAB83;
	Tue,  2 Sep 2025 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASglGDEf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEE2EAB73
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857377; cv=none; b=LphxWVsV0awKGMdw9LKYlNY/aAlGSYIgj/s9M0MTqtV8AwUmtS7M/+kQ9sX0kgDRs+1uU9ihLFnetZtwG//OndfqJtrZBaJCVNvkzvXBX4rAz+UdX2jZ5V7aTf8HDb0P7gPI32cS1ba1Es42MSFySK8Cc+kVslsWkjFbjY0751g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857377; c=relaxed/simple;
	bh=888ywDxPyUl4M6zpZ768anwPNrIvU3o92oYeraobAwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXteJWqPbgt2xCogbDtfqEnn8qS752NHWC8EcY5gdmYotceOT4t2rhYkFE71CJNkOF0+BU2luDM+mm1S9tAmnLHPY7VS6fXmtNoxCNCJheI7gaEd4t3WmX2f/mKi3pKTIKgXUo6l71vlHH+UPAEwpljjnStB6Wzg/JV1Rs25y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASglGDEf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756857374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h1ZYHDqv025lJgwhhRN8DEjjxbXljdscTG4+1iteT+E=;
	b=ASglGDEfbxdBtJv1GUBxV10CYcH3XSlkczl4Ld/7yXOxxmWG+X5eoC+XIWgfNkaAnyBy0z
	2FTEDw9T1TvkyEaEIID+E+lh+6exZ9eESCOGzSSZjNnLf3nU2VSkGK42CCijWXgnN0C25h
	5FDtf7gPwFw1x7fYAjGBxyWmrFjn3Ok=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-TVm_ZNj4M26ntUkq_YEcHw-1; Tue, 02 Sep 2025 19:56:11 -0400
X-MC-Unique: TVm_ZNj4M26ntUkq_YEcHw-1
X-Mimecast-MFC-AGG-ID: TVm_ZNj4M26ntUkq_YEcHw_1756857371
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b345aff439so37469381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857371; x=1757462171;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1ZYHDqv025lJgwhhRN8DEjjxbXljdscTG4+1iteT+E=;
        b=SyUkjbbdgFGQU3okC4JP0R7KMkpTysFE0rHzcRMuNHOmehWFj9fCGjkG8uM1iM6h3A
         /UyUfX4282WSTzZPEIuTyhfWtZNgzCi5Pk6JXFylfzSlbtF2JfZpyXaQIJwBk64ZKcTe
         gjuouRGtWc4idd3wwYsYoCgVflbhP7a3A7Fspv5WjrTedhRqQsZeRBTVnPH4XYMCZPsS
         ByKo7ed1rigg8QIPU/fMl2jKJU1upX8XnflP6c/Bv32v+NJ+CpvThJv65jzyjEx/5Jt2
         qoytL2spwO7mesK7fVn07cjJNGp2H2Z3SDtAs14Zus7KxikIY4IbJhs8oXDNof0CsaLK
         0lfw==
X-Forwarded-Encrypted: i=1; AJvYcCWgTRV1IpH8gP8Ws3lpNwFtWxV90l2UnDPQhQuiyKMQBKfO9+hlqF5OezWebsTJmddq07qBZzCPk+BHM3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75jWZCG1hfeHMjfUfeAmk5kMqAk6QMKD5lOXAznb/RQraHFMY
	Fpxad4n5nsUZVX8pd3kXb6XOSJ4lsJj02ytidJ5zX/iMckCDfxA0Kyo6ZCWQiC/2w2YHbFTE8Yf
	dFuDlx/tD/bS6BIymJ51j7dWGKccEH9yQzyJ5DqrRfrfBz/eAj0oc4hxCFut1ftCWWw==
X-Gm-Gg: ASbGnctnkdWBXESojWg0EQvL2SB3/kY6a8ZtkUb8D5Iqt5YU1zZFKUd5hXrnYVFQWNp
	ORVVk7tXIKj1t3crImt8AqPzFuMMCDNm2Cdz8DPYazXLuuIOqs+vKrpLuyMza84zTuY7q00nF19
	Ggv6DNlkhFF58m9hme1kIgH2Tw56BijVeUz79ugx49Ucwpji3m10sSnyqU2LPlyMy1g9dsrFpe8
	C6tXanGFOOfvkxUC7Uq0dyEICqANgBmjm4lCaRIFgrXbNGkWiIpenAO/SL1AeEIrc5LaYS242Ru
	m2yLMVE27zVSphrsnphaqnk6/SWIxbsPDb5dBwl1A65kNkF05eS6T2rF
X-Received: by 2002:a05:6214:403:b0:70d:ff3a:f96b with SMTP id 6a1803df08f44-70fac89e1acmr152518576d6.44.1756857371114;
        Tue, 02 Sep 2025 16:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB9u8oxnT7u5IixuDLd0JsqQC/w6ZeQd7EFEgifkIuiCwykZelS8Lp+UAMgPRJm62ZRJZeJA==
X-Received: by 2002:a05:6214:403:b0:70d:ff3a:f96b with SMTP id 6a1803df08f44-70fac89e1acmr152518396d6.44.1756857370724;
        Tue, 02 Sep 2025 16:56:10 -0700 (PDT)
Received: from x1 ([2600:382:8106:c00:522a:3619:4560:3aa])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4666156sm19976446d6.39.2025.09.02.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:56:10 -0700 (PDT)
Date: Tue, 2 Sep 2025 19:56:07 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <aLeEFzXkPog_dt2B@x1>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-clk-ssc-version1-v2-2-1d0a486dffe6@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Peng,

On Mon, Sep 01, 2025 at 11:51:46AM +0800, Peng Fan wrote:
> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
> them before using the clock.
> 
> Each SSC is three u32 elements which means '<modfreq spreaddepth
> modmethod>', so assigned-clock-sscs is an array of multiple three u32
> elements.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Stephen has also been asking for kunit tests to be added for new
functionality in the clk core. There's already one kunit test that
calls of_clk_set_defaults(). I attached a very rough draft of a patch
showing that it'd be possible to mock this up in a test with what's
already there. I set a log statement with the configuration from
device tree:

test_assigned_rate0: Spread Sprectrum Configuration: modfreq_hz=10000 spread_bp=3 method=1

You can run the kunit tests with:

./tools/testing/kunit/kunit.py run \
	--kunitconfig drivers/clk/.kunitconfig \
	--raw_output=all

Additionally, what do you think about making a dt-bindings include file
for CLK_SSC_CENTER_SPREAD + friends? Right now, the test illustrates
that we need to hardcode the number from the clk-provider.h file inside
the DTS.

Here's the patch and feel free to make it your own as you see fit.

Brian



diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a268d7b5d4cb..6cc3ad883b35 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -28,6 +28,7 @@ static const struct clk_ops empty_clk_ops = { };
 struct clk_dummy_context {
 	struct clk_hw hw;
 	unsigned long rate;
+	struct clk_spread_spectrum sscs;
 };
 
 static unsigned long clk_dummy_recalc_rate(struct clk_hw *hw,
@@ -83,6 +84,17 @@ static int clk_dummy_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
+					 struct clk_spread_spectrum *conf)
+{
+	struct clk_dummy_context *ctx =
+		container_of(hw, struct clk_dummy_context, hw);
+
+	ctx->sscs = *conf;
+
+	return 0;
+}
+
 static int clk_dummy_single_set_parent(struct clk_hw *hw, u8 index)
 {
 	if (index >= clk_hw_get_num_parents(hw))
@@ -100,18 +112,21 @@ static const struct clk_ops clk_dummy_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_determine_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_maximize_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_maximize_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_minimize_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_minimize_rate,
 	.set_rate = clk_dummy_set_rate,
+	.set_spread_spectrum = clk_dummy_set_spread_spectrum,
 };
 
 static const struct clk_ops clk_dummy_single_parent_ops = {
@@ -3192,7 +3207,13 @@ static int clk_assigned_rates_test_init(struct kunit *test)
 			consumer = of_find_compatible_node(NULL, NULL, "test,clk-consumer"));
 		of_node_put_kunit(test, consumer);
 
+		// Here's an example of a test that shows where
+		// of_clk_set_defaults() is called for the consumer.
 		KUNIT_ASSERT_EQ(test, 0, of_clk_set_defaults(consumer, false));
+		pr_crit("%s: Spread Sprectrum Configuration: modfreq_hz=%u spread_bp=%u method=%u\n",
+			clk_hw_get_name(&ctx->clk0.hw), ctx->clk0.sscs.modfreq_hz,
+			ctx->clk0.sscs.spread_bp, ctx->clk0.sscs.method);
+
 	}
 
 	return 0;
diff --git a/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso b/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
index a41dca806318..a157a316a10d 100644
--- a/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
+++ b/drivers/clk/kunit_clk_assigned_rates_one_consumer.dtso
@@ -14,5 +14,6 @@ kunit-clock-consumer {
 		compatible = "test,clk-consumer";
 		assigned-clocks = <&clk>;
 		assigned-clock-rates = <ASSIGNED_RATES_0_RATE>;
+		assigned-clock-sscs = <10000 3 1>;
 	};
 };


