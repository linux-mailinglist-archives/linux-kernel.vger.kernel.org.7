Return-Path: <linux-kernel+bounces-856573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51CBE4814
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BDC54304E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C723EA89;
	Thu, 16 Oct 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+nuBRye"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03732D0C5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631405; cv=none; b=oWRp/+UzLAT8pr8KvErVmKoSUaMET+cz/Sq4LPzNIuYx3TNq0Z8j8r8mHGq8aijg2IU/mMf3RoY0MNORw62o+e7eW3XbZ0+6EIFj8lL7CCxT6ugVQzrRpxi/Xi2GpuD4SMJOSakx22zABAb4BIDKPZjzDStpn5eNFs0UWIMI/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631405; c=relaxed/simple;
	bh=g14jRVXRif/yu2mldUqo+ZtgbpRULfrZaOhR9foeWp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M8j+3n2xN93D8IQWibtNfqDgcfJJ4H24S6lPxzZiPBVDI0Vd3qoFyvM8eGtenin38BBZd4UF0ca6tGHZ5mxaj3vQ8xQkXpcwMWVdcv8zmq8vSiTuP3FdjeAnUoMSNppXQx8gUEriKJK6r0JN2q5l3TLGB7RGJPLmBpD0RdeY5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+nuBRye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rLoW72TXy8BUJKs73yrBx0QtS/ByaYZC6LqSSduX5pU=;
	b=V+nuBRyeeux/SHBiAl1Cosz0puLknGOe5PxrfL4iET8BmPEYPqJQRVfg6ljVfQtonQ6Zq1
	PsGCsojSpAwl+CdtPKbUak3aqmogeMXj9K6AmAr/lj2knbO+DHj5t3SjPqBPo2dNcd+46L
	2iCrVwl/aA/X1gTguus+rBpXM4aTUJU=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-K5fxOnMBNg2eHVXM9sGTBQ-1; Thu, 16 Oct 2025 12:16:41 -0400
X-MC-Unique: K5fxOnMBNg2eHVXM9sGTBQ-1
X-Mimecast-MFC-AGG-ID: K5fxOnMBNg2eHVXM9sGTBQ_1760631401
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-54a86a758a9so1345560e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631401; x=1761236201;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLoW72TXy8BUJKs73yrBx0QtS/ByaYZC6LqSSduX5pU=;
        b=kWd+yhufE+Hm4Ka+ZaW6yaZNy97n9YJm1wwYuzpt3skPGUI+8YJTvIgrp6iO2sd2i9
         0Owp/2H/4iLcqOU1EH+2N4S/Ouaom91yMwMqTmAfDgV4VwTmJyiKrql36CKgJZLPZzdB
         2vHvhxcso38CBJPpIqmMAq/DmfIQujmk4vGd0VkiQHr0pgfYJs3H8bbn00WGtSzBLLJZ
         fq6WI2W9hlVoifhcgKI7lIjA4RJinW20YR9RtCLBnSsrC5vsX+Yudr7M9ioj/14Ulf+p
         FnC9yChlXgPYKEpdg2YS4Go39VJMMDNNUuH9aHqDTvpPGqCkbAQC0zaKEbQqbxm8VPmN
         oeWg==
X-Forwarded-Encrypted: i=1; AJvYcCV1I5Vzi+COooskdS3lNkv5NYkiSsVoycux5ldKXvH5j+gQGIm1EEJO3RgTyyguoERmgYRCIYO+nUjct+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5TaaJ5YR2jNhZZOGeSDt0KLQLvabodj3wchoTzpPvxJ/S5NH
	tjakfhqBrLkwfAVemxMeqF+BbNHD/WhYKP5yHRSBFrshCnCz1566vVUPk0sFfeZIZR0niv+9KeT
	1HfiSlnzz3Qs3JsaA9hzZCPWuZXkXjNBgzcrmBDLbNEtTWjSiOD7KERowf65q01+WtiYMlLH5gA
	==
X-Gm-Gg: ASbGncuOOYcsOj4Dp4MBHsZh7uva7pBA90F9KFEgfuNSRxway3jhygoJiKzEy7X7Suh
	NDioXPf/+AYVgncyWLqSjpXwohifA1RUTY1AZUmv7B3Go08Mm4pAe0KQpj9NOgZFeWJv5gnz3ME
	Cn4uQH3ja6DwL20r73Ix5nf/BFHw+Eifx5vvkndsCtKRL7gb0o8kJMcSYYramQewKBblcr7yeOO
	0immE4McVl3H5YE89ErT6a/1Zf62BD01N0K+1qC8Bk86PQ3Xeg+3o27Uy89pQkub5Ow3fOQkxle
	Qcp9TxsOzqUGSb+DDk2nBhL6LSdL4BrWQ9BTi/wz7arEfzSkoYESMjj/kiUMGJL0UqjrwLmBnBz
	nFMSv/SNkP10ns7GX6Rtq787ygp2ONrgij6DGT33oK4y9ch6sKyvpN8J96DDxudK7FicRBA==
X-Received: by 2002:a05:6122:e0db:b0:54a:8deb:21a7 with SMTP id 71dfb90a1353d-556401f5a2emr1266680e0c.4.1760631400701;
        Thu, 16 Oct 2025 09:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/qxbT4MGn5K5SdF7mHb4J1RwbE5sf3ZLdQeaLqWF3gk/o9djqJacUmDf3uaB2gYHOqJNprw==
X-Received: by 2002:a05:6122:e0db:b0:54a:8deb:21a7 with SMTP id 71dfb90a1353d-556401f5a2emr1266639e0c.4.1760631400331;
        Thu, 16 Oct 2025 09:16:40 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0128c9d8sm44068466d6.33.2025.10.16.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:16:39 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH RESEND 0/4] media: convert from clk round_rate() to
 determine_rate()
Date: Thu, 16 Oct 2025 12:16:25 -0400
Message-Id: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFka8WgC/x3MsQrCMBRG4Vcpd/ZCEzAtznZ10FEcQvKnXtRUb
 lSE0ndv6Ha+5cxUoIJCh2YmxU+KTLnC7BoKd59HsMRqsq3dm9Y4fiGK5/B8sE7fHFn9B6woqG3
 hkg2+61PnqB7eiiT/7X6l83AZTke6LcsKPh60hHUAAAA=
X-Change-ID: 20251016-media-clk-round-rate-resend-2e6f2ca78f76
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5312; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=g14jRVXRif/yu2mldUqo+ZtgbpRULfrZaOhR9foeWp0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDI+SqW9unN9Ss/ph+bzdNJE1FZy+H1jFr71bQ9TmHBDv
 +W9dSfCOkpZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjIyniGP3znXqvMMN11uvzk
 Wa43V/9qHSovEkre/q2y92/Dly//xM8w/BX9xpjafcDU6UVukniZbJdwjvYLJ1a7F7UfVZL9oxO
 KuAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

NOTE: This is a resend since my original posting received no feedback.
https://lore.kernel.org/linux-clk/20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com/T/

I'm hoping to get this merged so that we can remove the round_rate() clk
op from the clk core. The clk maintainer (Stephen) mentioned this work
in his last pull to Linus.

https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the media subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Coccinelle semantic patch:

    virtual patch

    // Look up the current name of the round_rate function
    @ has_round_rate @
    identifier round_rate_name =~ ".*_round_rate";
    identifier hw_param, rate_param, parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    	...
    }

    // Rename the route_rate function name to determine_rate()
    @ script:python generate_name depends on has_round_rate @
    round_rate_name << has_round_rate.round_rate_name;
    new_name;
    @@

    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")

    // Change rate to req->rate; also change occurrences of 'return XXX'.
    @ chg_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier ERR =~ "E.*";
    expression E;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    -return -ERR;
    +return -ERR;
    |
    - return rate_param;
    + return 0;
    |
    - return E;
    + req->rate = E;
    +
    + return 0;
    |
    - rate_param
    + req->rate
    )
    ...>
    }

    // Coccinelle only transforms the first occurrence of the rate parameter
    // Run a second time. FIXME: Is there a better way to do this?
    @ chg_rate2 depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    - rate_param
    + req->rate
    ...>
    }

    // Change parent_rate to req->best_parent_rate
    @ chg_parent_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    - *parent_rate_param
    + req->best_parent_rate
    |
    - parent_rate_param
    + &req->best_parent_rate
    )
    ...>
    }

    // Convert the function definition from round_rate() to determine_rate()
    @ func_definition depends on chg_rate @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier generate_name.new_name;
    @@

    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
    -               unsigned long *parent_rate_param)
    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
    {
        ...
    }

    // Update the ops from round_rate() to determine_rate()
    @ ops depends on func_definition @
    identifier has_round_rate.round_rate_name;
    identifier generate_name.new_name;
    @@

    {
        ...,
    -   .round_rate = round_rate_name,
    +   .determine_rate = new_name,
        ...,
    }

Note that I used coccinelle 1.2 instead of 1.3 since the newer version
adds unnecessary braces as described in this post.
https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (4):
      media: i2c: ds90ub953: convert from round_rate() to determine_rate()
      media: i2c: max96717: convert from round_rate() to determine_rate()
      media: i2c: tc358746: convert from round_rate() to determine_rate()
      media: platform: ti: omap3isp: isp: convert from round_rate() to determine_rate()

 drivers/media/i2c/ds90ub953.c            | 12 +++++++-----
 drivers/media/i2c/max96717.c             | 16 +++++++++-------
 drivers/media/i2c/tc358746.c             | 12 +++++++-----
 drivers/media/platform/ti/omap3isp/isp.c | 10 +++++-----
 4 files changed, 28 insertions(+), 22 deletions(-)
---
base-commit: 2433b84761658ef123ae683508bc461b07c5b0f0
change-id: 20251016-media-clk-round-rate-resend-2e6f2ca78f76

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


