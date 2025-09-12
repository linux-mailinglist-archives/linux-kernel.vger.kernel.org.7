Return-Path: <linux-kernel+bounces-813713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A4B549D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF63580E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18382EA73C;
	Fri, 12 Sep 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q6mEK53x"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691F2E8DF5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672914; cv=none; b=jPBEtE4ja1Gq/tMn5L4itiyqZE6tYXZLrAeYpeO+wbpTqROtXS8BluwNt17+DUXbEYoI5UX18KW6cFADbGr+fCgfdfkhN35ghDo908xLADoLaDZNHxR/aLG4c2AlkGnPlXAl1I9sZ1SNKPkCfLqPRWXBWcOk1vXDrYNEfmL91CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672914; c=relaxed/simple;
	bh=JlNBqkR95u1oCvMt5SocwNJNpvXkKxNmSI8wA2LlQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoMWLPNhrTtL4cwGRLcEjPJ0fJ5aYYoyQQTCaQjJspkmbxhxowUHRy0vjUAqjeolHoIfSqtJ4hEteEuS2MBhLXtjDmW7QOMkoPep1Sm54dvIawlNAIh7W6L1FN1dEBrn6Os5H3xh38LAv2GRzCOVm8mRTHIijkzGffNtF7srx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q6mEK53x; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-623720201fdso3408284a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757672911; x=1758277711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA8TiqZsvv98o7LtXfWptxl7WYZx7XAp0BJZZi2XoJU=;
        b=Q6mEK53x6tzwT6hLQwOE6NfeGncBqMlPs2Opmf1y/00toAdvk4C8zcwXBEq5UEFHC1
         GHvqvG1x3sHtbflkoQWnDtW+L1nOPHH0ht/9kaRKe2Zy/R4aCFIV01j4ofq8RMcQ+mkW
         hXs2Xz65rdRp88XCJmcshjQbjVhkiS2F4JdxAr4rCck7K/O7DiFSTQxAG0nn6WVyje9w
         0KUBBhqWLO2P++blQE8B2xMYKSVp/8jk+w50OJDDXoEQnmshRvt6yVDyrQeo1LTMhaPS
         /HG4J8ZeQiM6N34JTjXEh+a12TRkh3QrmBex3T9TJMZG2S19jwGfRevUZqdE3lN6uaES
         TTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672911; x=1758277711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA8TiqZsvv98o7LtXfWptxl7WYZx7XAp0BJZZi2XoJU=;
        b=qoNcv/H7FTWmFZsRueiO35aLvPGo7++yE0/hDoY3l5vkad6ihIbCf+eIOkdBQrGvM1
         hrT0qQe3ptXH3Yh7l3fmJtmTvS86gwIG0mMkWocZrypSXcNyHtINciGFt4c/0BOaxuBN
         v7Dm/rXwSL3gVfaININlCVXlmVs0+s9TyqvMyH+uR7yW889CpNYYf6PO4yoCdsbwjaKj
         D7nUKpU8FySQ0LphXhzHRjU+tKcuVDmW1JCM74OubCpRcigxuoEqK9zQklDRtzkxjTbU
         yjTNkizbSVOqsU8Cm0vtZmmJd799l8HfPww8eVTdic84pW9v/1DayMKVKS8tpUz3SEdz
         YuuA==
X-Gm-Message-State: AOJu0YxvBRmtNCSloAiXS5ZtzC4O8oePERtVV7DD7Uf/sNmhNB/DqLRf
	lPCjkXKaD6SJ4qR3V8SgdjxOKoKTFNqiqoXMBknEoG6aFrtCMpNg+x/x9gHdU57UY7phlMgaNZ6
	zgMu5
X-Gm-Gg: ASbGncsdzxTrkAGvfKnYw+eSjBVwARVYiOFkSf3CwPMZO08Ym11caCSoZapE81PePOT
	T1LqnQUNNB2BgV+Hk4VRWxe9fY9O7+rrGa8Ogn7gmG/gBVumTstK++AwKtdcxXC1GtZF6R1Sixj
	er3e9/srVVEklA88ZJagn9k4e+T76BTUjwfjWQ/2KQV1Kf7ouMaMbIZers4GOoCamW3MXpjJl+r
	xRM3TcrQUY9e6dzwDkuMpkn5TklYyanHYCd8QSxn2Bb0d2YD6DXjpr5OdoaSp/YQ4l5aILPR9y3
	UVzRsRRmtsTusHtrJOfS6OKQzkCzghv+vluHR4UlnS8pMR0G6R+nOI5/vuMQmW4KzLzXrka5tk1
	31f0A4UQP0Nq8H7bsPOffes7i7Fwitg7AByVAwPFueS4F1iu619cCXB85OLyrwMAMMBXqKnFPvw
	E=
X-Google-Smtp-Source: AGHT+IEdUC7Jj8fmhLukwDzk9JH8n0YEt7shcZ7rD+rTkHTWzbJyb0OFFqaO+CfpCNjI1qx9fCLLyw==
X-Received: by 2002:a17:907:2d86:b0:b04:3888:5a5b with SMTP id a640c23a62f3a-b07c37dc4e9mr236044566b.42.1757672910914;
        Fri, 12 Sep 2025 03:28:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da302sm339998766b.16.2025.09.12.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:28:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] stddef: Stop using FAM parameter of TRAILING_OVERLAP()
Date: Fri, 12 Sep 2025 12:28:02 +0200
Message-ID:  <0c66d2f3dc875664bf0eba7707044e48bb029dc6.1757672423.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
References: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JlNBqkR95u1oCvMt5SocwNJNpvXkKxNmSI8wA2LlQXc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBow/W5vFWMpy4IWZ5hVWTR1aIy/+EE1iwVXDnUz dmmrP3uDQyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaMP1uQAKCRCPgPtYfRL+ TrNfB/494xFW1k/WGKDPu+TTShv0O4XtSyhfpQWoxTWGrN4MYnULetabADN2t/Pr4CyAalRlvtL VmQiW04X7L0gyv2Q5H9OSymQw9/xY/cOV/CAL3jeac6vFpmx85EzrzpCxIIaHbz4VbcXOZTPwGn V3urWuzz2F2Dd+RUY5HtSUahLefrNrbFcK5XC6dx7ldZjYZLkUXtMssZMXFa6Nl/f/QAbMeSnqN EK6m5LO3e3N3fnUOx3A88SaG4jm/hiB+R4sQy5/tT/5ymngYyLH+d5uaEmTFnMyV2U2rKKRpcZI pW5DCVucVZTA0SiCXX2kPtAUHR+61xbkdCEqprOr9B53gOXy
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

According to my understanding of flexible array members and the c99 docs
("In most situations, the flexible array member is ignored. In
particular, the size of the structure is as if the flexible array member
were omitted except that it may have more trailing padding than the
omission would imply.") sizeof(TYPE) yields the same value as
offsetof(TYPE, FAM). To make FAM unused rename the padding struct member
to use NAME instead of FAM. This makes the macro easier to use and thus
less prone to error.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
--
Hello,

This allows in a followup change to drop the parameter. As this has to
happen in sync with all users of the macro, I delay this change until
after this patch was accepted and hits Linus' tree and then coordinate a
tree-wide change with him before the next -rc1.

Best regards
Uwe
---
 include/linux/stddef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index a748efcd626f..305e25a67271 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -118,7 +118,7 @@ enum {
 	union {									\
 		TYPE NAME;							\
 		struct {							\
-			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
+			unsigned char __offset_to_end_of_##NAME[sizeof(TYPE)];	\
 			MEMBERS							\
 		};								\
 	}
-- 
2.50.1


