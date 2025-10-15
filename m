Return-Path: <linux-kernel+bounces-855020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9456BDFF26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B0A5462C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6178130101E;
	Wed, 15 Oct 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNsxRpdy"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD82FFDD5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550720; cv=none; b=oiZNJgtaT6r2DJxpZURjT7pMPBPO+mfut1gcglh4284HfmA/X95N20qF1miWLedZwFkXGVzPcVL6+k6uEVK5prJddcbS4jJVVN+n1WD24klk2+mLxAuOzCHY8LHaRAEPBj1VBOmR/4sS35tLUfEIPDfd767SbVoFVT/tIjiya0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550720; c=relaxed/simple;
	bh=o8PqTXOgJWd/s/ikGi+5sDegbwwIZbEWqoF+5kl66v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9ywWx2///m7ivPcNcAK7Vs9ltGTR/EzD54OXvodmjLnAvecM27Q1/gtR08kPxB+QLNotEzapwSJ9pd1nw477VKEKvNg+0/qqKCBuZMOEMmkJa9tynKdvHiZSuQbkcIuwGkfTtxv3RYlVqKJ6YqXKsNE4DW0YgwYFcgAQn59uDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNsxRpdy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93b9022d037so284481739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550718; x=1761155518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei8wrQpcijHhyCQBFmPmC4ESXYvigXWE+9ruQpjaX0I=;
        b=GNsxRpdyV2GKQNIJUWDRLqbxEyaRAN4VVe/fD7fe7aqS0RpdWuPyXDHxNlhddj6KZJ
         lOhD4F3tMaN70mE80+9ctrtQp9c8iDLpdQiqdRZ0OS22gUscBaZynpV9pmbp4Gf1Tsay
         C67LTaWbIuZAqy/m5qwezCnkOAw3rM4yKgvO1SNJso8BQgOvVB/6UgNeDPQZpRT/sGfi
         5XnVtrV77+xfk34Yr1UBNwTMrx4cbYIjkfc+CtehSPszZOTHxXqRxwqMuP3qz/b7/a6D
         DLuf4uTI3Tw529HmCyjDdgEbYcD6WunCPZZMT0OlAOr/Qr7icMoJa5w+DgrlMnciNO6R
         7wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550718; x=1761155518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei8wrQpcijHhyCQBFmPmC4ESXYvigXWE+9ruQpjaX0I=;
        b=BgebZEe1VDcl2mPADPovD1/9qVwuuvUrRWON+Bh/HDagfyKi8jsuJxP6xVGjpzx68r
         D/gxnXUPTPJC9BKWvoUigHLP6XEiR2A1NXqEiTfgD5PBF7giIln68saX/F7golUr3KQr
         tuQCLBRkDPDqsCqhEsze6iUfo87o7aRW0DKYoozNx0yQote7HsVZV8/aezKHhMBeJnIa
         2pzF1ktZH/D6OGWcodfKqpHOQvlq5TeJfGk6bcC/k+kKQ21u/FdeaxUyIK0nijf7x8kr
         U2w5ld74DO3LXVcwQK+CBj9ygNVXGt3LDH1xNeyxosbIcYqhqWqnVUchwqUMmK2EStXZ
         G77Q==
X-Gm-Message-State: AOJu0YwlUJe3/C4mpnGBGG1L/trDZPmzvjjDSVTv83eDfgKodGhwfHx4
	PWfGRH0Q771TxLJp+2EE636hqFcGzRcnXXxD1z4J6XaMw4NL13kVQzU1Rkh7kA==
X-Gm-Gg: ASbGncvc4/cROflNl3vqagPYMoBhItfh2HVBrdjg/a6IDwdXpNXmeZv3geKoLtSpHb+
	jiGudqF8HqLOh5oBVCUTeCiVf0O8bqVFUI4wXv4YR6eNgug5knGletpU9ClVKsqZr4HgcxOSTp/
	udtDCo5miwQW7tuuTk6YJNyKz995uQQ0L/qN28aRPO/hfNILu9AnDeqas03cTSo1kM+DfnrKOOg
	uzmEFc2qxD3LTRLvWJbUvccMl7NgXCUTCiHlPu94+OojZbpLF33HZH6RdwhBZnNu3qr4JSbY0CT
	qXu5uoMRGjrGORAqaZZypAqBrD+WEzP5gpCoFiVzubMbJesTIMKnsu/gC2Um37m5kaWCLMX7Nwz
	8iCDm4j697CAP6+gEYrnCkvReJ35GQTuWgtZe/QfWZOG6jhxnKhMxJ0eNHY6GjNImWdYLyfUmfe
	wOPZuIUJdShy5vZr8QaA9Udw==
X-Google-Smtp-Source: AGHT+IHHfB1pctNQwkeMCTwIAO2gi3XQr+rEka4h1CVVNHJM0Gat2jBZVlxrA3gyDHn/33vFGw4znA==
X-Received: by 2002:a05:6e02:2513:b0:42f:91ac:bd5 with SMTP id e9e14a558f8ab-42f91ac0ca9mr246872325ab.19.1760550717804;
        Wed, 15 Oct 2025 10:51:57 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-430b50b692csm1194115ab.5.2025.10.15.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:51:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 2/2] checkpatch: cosmetic-style tweak
Date: Wed, 15 Oct 2025 11:51:37 -0600
Message-ID: <20251015175137.2178263-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175137.2178263-1-jim.cromie@gmail.com>
References: <20251015175137.2178263-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

no functional change, slightly narrower on-screen, maybe clearer ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 27299f326804..4449e809ef6f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4019,11 +4019,13 @@ sub process {
 				if ($newindent ne $goodtabindent &&
 				    $newindent ne $goodspaceindent) {
 
-					if (CHK("PARENTHESIS_ALIGNMENT",
-						"Alignment should match open parenthesis\n" . $hereprev) &&
-					    $fix && $line =~ /^\+/) {
+					CHK("PARENTHESIS_ALIGNMENT",
+					    "Alignment should match open parenthesis\n" . $hereprev)
+					and do {
+					    if ($fix && $line =~ /^\+/) {
 						$fixed[$fixlinenr] =~
 						    s/^\+[ \t]*/\+$goodtabindent/;
+					    }
 					}
 				}
 			}
-- 
2.51.0


