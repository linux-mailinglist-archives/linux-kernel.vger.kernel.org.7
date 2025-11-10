Return-Path: <linux-kernel+bounces-894115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6CC494EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA193A1BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6D2F39CC;
	Mon, 10 Nov 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gv/lxDhG"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED22F39A1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807611; cv=none; b=p9E8SD1CuHgxVplZtubIjzt5Uoqs8gkAouYVMoNyhAVcYwmIP1i4nBWapIMeT7a/ZHn2m3h22C5neFGQObdwKZFPWZaEDNTUSYhdgLpF4VX2ZamRZimn8cUBbwVawWASmW5QXBl+76sz3Qps+lJJWsLQ8zly8J8blY+01clLn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807611; c=relaxed/simple;
	bh=TCOQiF7Wl6musoZt1NXg/XuNGShNJ+PlUz3atHPrYYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi5p7ttcS3/mi6sfhG/HmJRtpjppp3aF7yHZIo34irIFQkEqP1RY3vHp3fMTGGtpkMiCE8I3s6P3nvG0QAskatoBk6dUFJdFP4gNkAmhsyKBXgqLDYd9/kUpmitfx8WQJUMbTQWMV01+QZBXJbckBEk5/B1xpgfKJgar16N3r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gv/lxDhG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298145fe27eso18018035ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762807608; x=1763412408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp58ASEtK8Ln4QwD3CPLPvKo2CrxmxJzZ9RPILDGftk=;
        b=gv/lxDhGF0wWPDp3zZE83Y/Nn+XJuB4352MifhHcmaHgJedwWZEYde92GO9py+J/Eb
         4xc5ZUixLPU8LZezRniusTZmJBIWGjoUs6xDNb5+Keg1+NB0VgEGQdVr5IttW4jUbnbA
         zZiapBeu+JJEca/lXccqBNa/udg2RiGaETdYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807608; x=1763412408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qp58ASEtK8Ln4QwD3CPLPvKo2CrxmxJzZ9RPILDGftk=;
        b=mvNbokR7F+XBNqOrpfldJDo8+EnFW8gFYqyrddt7ibP8D2gZSZuu31EDHgNOPUwpyG
         j3IhYJVvtpS3xJzfXZnhHaG2AYCblxjlPHI3zfk2uRlKvoWMcOIg2xI2qzcGrI7YDt+T
         bB95sSqNDB5vES9EGDA+isvoR7EaMIr2tmcTR8k+olbEC+4glDP48vDzoa95cVEqlrJr
         M6bfM0itMTJ+RaqEccw2WqPOwC/0OjP55IF0w9M3DcSW6AQrgj//0TLmS95DdA+o7H2W
         BUvZLuishj3kIcFtIF3ztN0gpPeHdQ7JuHkQ42yt8S3IvOoB76i5wxIb8pjGY5qmGI73
         s4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWbaLgYCpZR9Dw5tjzBxZS0YWaMzi1P9dOzUvMwNOLb8gXCQf+4CZhhziOpFuKPSzMekDia0RKxY61Jp6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdoj/Wl2GUGlcJwpWMrMYx3+12hfHrPuEjbkfLyi3j2JEihX7
	SPhb0HOPWVeeIxA/dmkJS5rBNpM/qP3UHqSFvc0XYhY1syLr1vhLO/Bvb6uPpDX4lQ==
X-Gm-Gg: ASbGnct07mZjXDNdExkdNKLvTfdE2d9pXuIDMrLAmahKxJHw9SsaS5WEG37X4biusES
	Wl8Gv7Ph3p36OxxOnc2WGTHq6lXxZ0HNFcwvmE3PuzJ57jPSw+OFvIehD2x4Es1syMRJt5JM/mu
	js8FHm1gyQAFvgbVgSfbTmvUqlgOBs31VVqRRBoiAO5YKNZygsPFEvQruszmv1zC8YzJXVZInIE
	U3qAuzzYTZ3OhX4cL6qC8b84GCpPHCKs9fBl4mWqkG8+eCIOrtAgf67SluFGM6EVUCKxOI7UjM/
	4NNe4j4e8F9FenuO8koQB7IBNbL9BrzKM9DFPVpBkd5fpfxthl9CwwvbLkd8T2MY0GvFodE0QS0
	cD2HMbS+csZP5ycpRfTJfEYLgA7/F1wnL2uYj3m7eZistV56Y3gSlb2XfMkzGLtIx7nfDq/leaM
	eGpxU0i3q5L5mSBPDxFGjTuI4khKCjXwhQ2eAP9WvA2DTJwussQB67/d48YerKeIOgYyDNVw==
X-Google-Smtp-Source: AGHT+IHpNugVwhN66sp8s/fVAlqYJENh7+AbuxeoUCNsBciGIRGabou2bvWmDiCpMZvOkDMk9xeesA==
X-Received: by 2002:a17:902:cec2:b0:298:1830:6ada with SMTP id d9443c01a7336-298183faee1mr58705175ad.30.1762807607740;
        Mon, 10 Nov 2025 12:46:47 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:51a0:4f1a:8141:37d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5bdsm154992935ad.39.2025.11.10.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:46:46 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/2] checks: Allow "chosen" node under "__overlay__" for a DT fragment
Date: Mon, 10 Nov 2025 12:45:27 -0800
Message-ID: <20251110204529.2838248-2-dianders@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251110204529.2838248-1-dianders@chromium.org>
References: <20251110204529.2838248-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a `dtso` file adds to the chosen node, a false warning will be reported:
  Warning (chosen_node_is_root): /fragment@<num>/__overlay__/chosen: chosen node must be at root node

Allow the "chosen" node to be under the "__overlay__" node at the root
of a fragment.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 checks.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/checks.c b/checks.c
index 908df5b98ec5..d28e59494757 100644
--- a/checks.c
+++ b/checks.c
@@ -1371,8 +1371,17 @@ static void check_chosen_node_is_root(struct check *c, struct dt_info *dti,
 	if (!streq(node->name, "chosen"))
 		return;
 
-	if (node->parent != dti->dt)
-		FAIL(c, dti, node, "chosen node must be at root node");
+	if (dti->dtsflags & DTSF_PLUGIN) {
+		const char *frag_path = get_fragment_relative_path(node->fullpath);
+
+		if (frag_path && streq(frag_path, "/__overlay__/chosen"))
+			return;
+	} else {
+		if (node->parent == dti->dt)
+			return;
+	}
+
+	FAIL(c, dti, node, "chosen node must be at root node");
 }
 WARNING(chosen_node_is_root, check_chosen_node_is_root, NULL);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


