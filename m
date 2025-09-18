Return-Path: <linux-kernel+bounces-761619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E844BB1FCA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90E01897790
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE12D5C86;
	Sun, 10 Aug 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixCjjzJ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B12D29D8
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864199; cv=none; b=TYMwvtRHvyHXqB1wjd8V/izg6MJPvXMXXhZzCto/rdiGNe12oHZ1OogNMt7kE/JNOUJRxG9NJ7GarffpMAQpqPax+kgzkIpWfGd7p7JVrbdRJ0fLDZJQ/Jmu6fuzqZkyZnalGHp8rqK7tJuKM3GB8YtqfhQcMtroF5fCclDc0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864199; c=relaxed/simple;
	bh=UYgbTKNNIhZJE5F8ohj4vNnNUmG0W80FAggzMzDyciQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NuyoKLnaEm8ClxRqywBgXdJJyPOe7UaEUIvAUR7oPlG//2wrETKhm/bcyAVTJwc1agLCCVrAOTwGsaytLYdrgbyNUzxpmEgdhpBJPmxB8SSTbqN7i26RUF841ceEKsPm5SvD0dGs4n5obIGsKo2N9PxFy2xprNeNa32UJFSPXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixCjjzJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CioeoXb5/QvchbQJCxl5o+yrQjp6rhhswejt/srDq7A=;
	b=ixCjjzJ4E9bwNP4u/KLETxeLgyn7fYeAJgsZeQZWN8747quOBTLsFt49mhFRs+oHFJkz89
	3WviGbBRZ0sqy0pphFpJU8pOdAQJ4rCkJB0N/zydEHqij4kLHr6vOPiuiJApS5/HFz4Y3B
	BAiVnt0XqJNFRAkbKTSFyo/6QjZMCGs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-qSZKaH-DMtmLgkUH5FFvcg-1; Sun, 10 Aug 2025 18:16:35 -0400
X-MC-Unique: qSZKaH-DMtmLgkUH5FFvcg-1
X-Mimecast-MFC-AGG-ID: qSZKaH-DMtmLgkUH5FFvcg_1754864194
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af199d0facso122945211cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864194; x=1755468994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CioeoXb5/QvchbQJCxl5o+yrQjp6rhhswejt/srDq7A=;
        b=YXvVTv97pe77iSz6ckb7M1DdGT2kaMu4E3dJ4+XV1XqAgo3ZPGuuE6Z9BEPm3NqZRJ
         vYso4oU7B+qdnXm38zuOky77J5rwAzhuh85xQBG8fIdDZ9rPL4GqNJqvafs8x5TRFWOa
         4UKrYiOdsemWICaGZB3B7oOtug56q8Qn/KcVcGrqg9kWYIwHzM3vCwM7tev5aoX4HFNY
         ZWU8DveO8fxSUYxHVHuJsXR7f1D5Mtof6Dghh/PXJdfbiqh9Qqhba78kiBdpVccYZkle
         O3zSqtg+AKRJb0unCgiSU6Dgkgu2AozAYSlKLwRymrQnp6n6WbmPQcTg8RhA4JWQ0YlK
         W6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXOOfm22AzYwwwjvz+XU6YtDYUhGJZHWPRoL/FMVtYW2fwT7HY4EQIsbQsmdXQH3WuETyEQ/meMKgSWVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARuI64724YCy8glLz1GbqqaScgT9Iy754lq8gi5BRdUzdy7tF
	PTLx+wI9BlNv5ykHla29OSNHpSW4snkynjieCrgt37lIyLFFu2D2MKSJldKQMoyFTSpxTM3/egO
	6Lyz7qR/NlbfQjFs8xUBC0RJLeYcvBHjsQhLur4fodsY3NrXUHaCoJcPBXwULRwFN7Q==
X-Gm-Gg: ASbGncsFOGLtLSiNYqNGJHrni6hZFALhEXxdlwQaFZQ6hltd7xuox7YetCuAG9qMTdo
	2ppRLAb4neFQ8Y9CoCzIEu+K6zT5EcCQ7a2bNGNV0szeqLPECScnsfSG63ZUU2pzKXdNXEh51Gi
	iDpysLNbVjShTY5Ph1G0Siucw99jdOs0xCFIj1Ye//ZFEZ/aWxuGTsiEJ8q/FAu3+UStauQNzOc
	ae8rWhjlBL0pdBDG1msKY2yRzH/82+zFlZZq1te4zYRcGFvftlpfg1w2eMpYmXZwSoQVoMWmaD4
	v8NMWH4uRwzpSG1hcm+noitYPJg9kR6l102X/zsYAX6Koubeu+KGpLveFUVvylXi8FvdUxxbR26
	I7Hfhqg==
X-Received: by 2002:a05:622a:1308:b0:4b0:7775:d342 with SMTP id d75a77b69052e-4b0afddf96bmr142006401cf.12.1754864194348;
        Sun, 10 Aug 2025 15:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMgL2TfTPBpWSj0xTTh5+SfYn/Qjd/HGVOp6AsQdNWXfn2vKbskTIHSYorfqQM8Oa2g6DGMQ==
X-Received: by 2002:a05:622a:1308:b0:4b0:7775:d342 with SMTP id d75a77b69052e-4b0afddf96bmr142005961cf.12.1754864193842;
        Sun, 10 Aug 2025 15:16:33 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06a395932sm92798851cf.38.2025.08.10.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:16:32 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:16:19 -0400
Subject: [PATCH] pmdomain: mediatek: airoha: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com>
X-B4-Tracking: v=1; b=H4sIADIamWgC/x3MMQqAMAxA0atIZgNaFK1XEYfSRM1gK6mKIN7d4
 viG/x9IrMIJhuIB5UuSxJBRlwX41YWFUSgbTGXaqjMW943i5iSgxjMQqjsYPZmZbFN3vreQy11
 5lvu/jtP7fpscdbRlAAAA
X-Change-ID: 20250729-pmdomain-round-rate-cd2fd9417c89
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754864189; l=5844;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=UYgbTKNNIhZJE5F8ohj4vNnNUmG0W80FAggzMzDyciQ=;
 b=ycuKCsHxlgyIiQDQP/ZXNrrK5TwG59aDdwvTbF9fA5ZaFGS7T11u3eBjUVpg98IPZ0SR0D/LO
 HLq8JMzYEaFDHKAwnSPKYgYnuZw3tWz2CNQiFg0AsRVq8jM/iV/b3Pj
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

Note that prior to running the Coccinelle,
airoha_cpu_pmdomain_clk_round() was renamed to
airoha_cpu_pmdomain_clk_round_rate().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Coccinelle semantic patch is below. It's large and I don't want to
pollute the kernel changelog with the same code hundreds of times,
so that's why it's included under the cut. For subsystems with more
than one patch, I've included it on the cover letter.

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
---
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
index 0fd88d2f9ac29da371590ee3af92c1260e4f2f5f..3b1d202f89dc516922887cdd968c95f5147491f4 100644
--- a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
+++ b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
@@ -21,10 +21,10 @@ struct airoha_cpu_pmdomain_priv {
 	struct generic_pm_domain pd;
 };
 
-static long airoha_cpu_pmdomain_clk_round(struct clk_hw *hw, unsigned long rate,
-					  unsigned long *parent_rate)
+static int airoha_cpu_pmdomain_clk_determine_rate(struct clk_hw *hw,
+						  struct clk_rate_request *req)
 {
-	return rate;
+	return 0;
 }
 
 static unsigned long airoha_cpu_pmdomain_clk_get(struct clk_hw *hw,
@@ -48,7 +48,7 @@ static int airoha_cpu_pmdomain_clk_is_enabled(struct clk_hw *hw)
 static const struct clk_ops airoha_cpu_pmdomain_clk_ops = {
 	.recalc_rate = airoha_cpu_pmdomain_clk_get,
 	.is_enabled = airoha_cpu_pmdomain_clk_is_enabled,
-	.round_rate = airoha_cpu_pmdomain_clk_round,
+	.determine_rate = airoha_cpu_pmdomain_clk_determine_rate,
 };
 
 static int airoha_cpu_pmdomain_set_performance_state(struct generic_pm_domain *domain,

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-pmdomain-round-rate-cd2fd9417c89

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


