Return-Path: <linux-kernel+bounces-739622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38638B0C8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09227188A046
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA282E0935;
	Mon, 21 Jul 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMJRbuK/"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF12E0924
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115092; cv=none; b=GE3yTxlHdwbW1viC3HX8E+KxI3KsI0N+1I2oHa1i5TAp7gnwForT71SZLus4ChDkvGVi+J59umpuF8n/iNd9EDAxDwvhutQ0TkHOVmzEQUpcp7N63TBPANIHqeupmHEBQ1LHTpJ0jHeR+AC0DEAMteC7ZYk57UfpLFGGSsFdVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115092; c=relaxed/simple;
	bh=nNq5fh4+3k/pfge/EewOdEvIoN/PYlIwcTyZWDDbQZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvOw5CEPG1HmmNw/JNytTwAkICKG2YivDMQfUiHUeFUIMO3ve/WNd8tUmEZjOT2VtxxvI9aUx1J4DPF2EaFih0KWG8XJ0RR4USd4+f3+L26FR/YnVwZPfjYfSJAnKakdxBW9i6eKBBVUtgd1VRbcWeb+5Uud3BEhIQhYVH8TJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMJRbuK/; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ebb72384dbso1181500fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753115090; x=1753719890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eWGrSP/wKlOyy9FKBxoza5IYmU5GaAPav4azuEf3Sc=;
        b=dMJRbuK/rVQpybkzyd5eNvNqJi8RNHOVUUf1ZaODg45NYBiuGsrCUx5cS5CYnOBfYR
         tgLF9OPeCz9TcdldZVxtsB5StkUh+UcLynr+2djFKVmQdsi8B5olKtD7ma/CODt4oIK4
         q6FgL+fk7l/zQUkR8sf62wWT/y6+J8iWbW6/pKLgJnT2jtpkqb25dHqMpkd3+EcUKo9G
         zQjkdBDWAQA6syR3M/zOCclhscLYTPbSX8TBNiHQ+zCg1JN3G2ANIdYHA6plDOuJT1T+
         A27RjNLPXR03mQPtN/wWRcVC/GURZgpeDEL/rvNQsr0QCt0NDXsupjVRUYXdN+Z0QjzX
         JTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115090; x=1753719890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eWGrSP/wKlOyy9FKBxoza5IYmU5GaAPav4azuEf3Sc=;
        b=YPL9HE4KsSpDOQ+TXUXKgMx2vVzfEOf5i9eUhDEY2i/INqjEoC/QxIrY7Kf70xCCwz
         znwJcam16RQPQgtO8FZ4Be0Dd6jYOXyl4YRW5VjGXA/4X/mJe6gkcFv457Q54CRcp/CK
         PZaS59wNFIthojvi3pwUidlFTYgvhB1javxNkutHG/WZ9gZn12tSGdZxpo5yVX9uK+Ha
         epi5H40OvJjEACeY0FszMRN2GfTY8sXXSqB5wiTJlP5V1CqIvvT8LxfsSpkTHh3H+tRx
         QztptHmzjEpRk1jJLGC0TyP3GH0/35ELZ4IA2MPwkXDW+QCB+eziqLNxlevFLCiXeniu
         HQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCU3vFi/xAdAcxcUdsXBnnbSWyBZVn6YGphCzgNuiYFsmnoMOEWyMdcZ5OiS9nJNb1v+rOUJLDwM5bZMmpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxH3U4ib5S9o6MPPrlSWEalXbe71OZNXi4lj30rtrt5+KdqPx
	USVgQr/JluIFKMKAo+yEEaDCNOxBAJSMBtXxWNoZhdM+6NvOvCWpcUiZ
X-Gm-Gg: ASbGncu/Ss907iDD7p/2sjQWT6eArklsKGKFawYQCXRLDEiqGuqEkFmp6A9WiCBrW6p
	ZECDeYCKHcPVxfh8zTqa4Cz5cZj0NbRR3ZQRXBNFdYsh0MbaVlvAYZJg282cbpbaDiNkGzi/lQW
	sFkl6ZEyzmUjr7dG739nZzM5GQDV5xzLpD4aSBQbhR4CfJHlvBFnlvht95Rd4Lpj9oKdKOplc9C
	uS1PNOrNgeup+Er9HT31owhZce47l1owHLElL3oBmy6qNLKe/g51ViXSUC3bWsWYZ0LZqOkrEHb
	f2RmTkr/KNjNuOYvS8JYenFYoedFfdD9Lc9xdh+NRaFfmBKhTv1lyiaS2vd3oRSRz2eg5gJxx2e
	A8FeOCH1qqV/GT/NjZqNWHJKhR9tpWDrdlHeOpSozy+/DBYCP0PRkLw==
X-Google-Smtp-Source: AGHT+IEoj0GVECoFAJJiWHHIL5aQYQVk5/iNCBYmvSa+HEvZ7odXYNWWXScVOPZjkXC0XA54zDtlbw==
X-Received: by 2002:a05:6871:8781:b0:2ff:b276:97f4 with SMTP id 586e51a60fabf-300e8c5ddcbmr7840325fac.8.1753115090219;
        Mon, 21 Jul 2025 09:24:50 -0700 (PDT)
Received: from fedora (181-162-150-76.baf.movistar.cl. [181.162.150.76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bca6b5sm2935120a34.59.2025.07.21.09.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:24:49 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH 3/3] checkpatch: suggest including testing evidence
Date: Mon, 21 Jul 2025 12:24:34 -0400
Message-ID: <20250721162437.6691-3-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721162437.6691-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-trivial changes, it's valuable to know how the change was
tested. Add a gentle suggestion when commit messages don't mention
any testing, verification, or validation.

This is a CHECK level notification, not a WARNING, as testing methods
vary greatly depending on the subsystem and type of change.

The check is skipped for very short commit messages (documentation
fixes, typos) where testing information would be excessive.

Link: https://docs.kernel.org/process/submitting-patches.html
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 204800232..358310e6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3319,6 +3319,16 @@ sub process {
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
+
+# Suggest including test information for non-trivial changes
+		if ($in_commit_log && !$non_utf8_charset &&
+		    $line !~ /test|verify|tried|ran|checked|confirmed/i &&
+		    $commit_log_lines > 3) {
+			if ($commit_log_long_line eq "" && $commit_log_has_diff) {
+				CHECK("NO_TEST_INFO",
+				      "Consider mentioning how this change was tested\n" . $herecurr);
+			}
+		}
 			$commit_log_long_line = 1;
 		}
 
-- 
2.50.1


