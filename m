Return-Path: <linux-kernel+bounces-834333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBBBA4787
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99B47A88C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8A226D14;
	Fri, 26 Sep 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGBMSQSO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F974225413
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901576; cv=none; b=Rm5SGw5SnP5dtJke32mUcVmDldHRbNJ4yOcntlCMmqFoEa060jgYU8w7hCPYHS1sh33vv/zxC14W/PWsdhqp7rXRiU3YulYrEVL0regRvF/ZuS5tM2rMXyDiY/AgYeiFAR2engmpwsel3omFXiXqfVvsESwYkLrliWBof6xfoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901576; c=relaxed/simple;
	bh=gTCVWNzZzqPVINBCtaCUF392SAVoDb/SnXht4q/0pjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwK4RmnaLCNINGUV99sTAH57N9LBZMiSMBo9Xp2Nua8PT6MKspuwv0PM/mEM64qGBDww/YQTfbFkOWNlO0RBrUg6xscw/2fSqRJbbOlvmt4IxZjfDVnPWHItX20jknF6ZuUscsq6HxCQtOe0G1J3cttWqoip2OX2CXeePR8y+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGBMSQSO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1592460f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901571; x=1759506371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEaF8vHW/fFjgdR+m9ikivvc2BgrqxtOA483ukp3KGY=;
        b=dGBMSQSOPT7ZxOZ39vv8dcpcPvrWmgIZ6CiXrjKsdY3Yuj+UAK9BMvflj6PtioCTRI
         v9VtZAGFg1sK0Zy7A6eeUhlWz8Ox8WUT5X8vZHdNh/QwegUuwMJr/6/Kmy1vluyPnnPj
         2o7zYn7sFPlqklPoI3ieqfHTrfr0JmzYqsmMnhML/3XyKrGoH6/JO03HlfvzNIvamE7V
         rT/Jp2fypugmzu5plR2Xy4DcN+YSGYTw2vo4qVQD0+pUY8QsMUYhNFR4UC1ylLBHVYat
         xismNN+gWxyhYhExJw7lvoOJL3EmPtc3PpirSuLOjIiE21YqnG0HAGR1l1o7R7FNzaB7
         YbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901571; x=1759506371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEaF8vHW/fFjgdR+m9ikivvc2BgrqxtOA483ukp3KGY=;
        b=nmMn5t6XwcUG6cKfsmvByphmGhLDusM3tfwwxXGzlUDkbr3Bap53RHMUxK2fg0GrC7
         hPmvx1sBXf/ZCKqNKong8bzlcUdPTYuknEtbjybbwHrZ10a7uZUjoKgQN9hFaQ33aV9X
         rdfgEkklK105d88t+RlvFODfGmpww3cbNQUTV3jxnvIA4RdMeb3rfwyrQ661qB7MWAQ6
         n4sZFFkv9kQjxzgX+8hw6IPKYqqlNLXfHP9suqHblYZ/2N2KagkWwMebdCoWrt3Bwial
         tCdZSfd53lOKW6JKmOtwIeJcP6XxL8NMuyeJyc/wXrT2hPZhVpxfEHRG9ObZJULUc7e/
         4hig==
X-Forwarded-Encrypted: i=1; AJvYcCXM3mdR/dwr+7Iqo8wZzVyY5KpkC9+p4RucsAB2S5dB4bSw/+alTao9l67eUEzXzzTHNEusrgk1d0c3Axs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefTb7959M4ZCI1yxW8mMzfjfRYcinyUeGPgss8hWL9Ut1enG3
	w0Pf49YHxKEZbRPm3f4s1LRzf9nmNgBsq9QJ4P4WQVrc6pD5Horf9udO
X-Gm-Gg: ASbGncveUoBppH9ZXzclikQlQJLHx02hBnLM6uKYr9suC7zB3QgzSoAPlLAUbCHTsOJ
	9Lbc+ayM09Jn6B96LcQqWdQBCTqss599ONsmwjl87//ms50jstovbJZTRcGTm5Bn/lEHQdhwtTY
	Wv0zb2lCQsHZTN0QMJ8ountyWBwcOQIkdgrm6ZXWru/GepIOdUzEoQghVDmTkoqmN6xL/+tsHYH
	HqWoqI5WLvv95MbJPGNfulWxkSvsh5U2JnBL7ByLIBzTul0oXwQQbPvkcAJ6pV0z2gUqIn9zJAt
	lhIDK2cY1CvcFIzT9M2+Q/wDxC79BXWEW2B/m0/DG8EhVptfB0E+rspsDPjk+QOlFfaEo3EqYW8
	gRk/4WtCf7Km0TrXrztoGHdN1Bq5yXyUevIEEUFRk
X-Google-Smtp-Source: AGHT+IENEMK9kpLMxQq8pmOuFGX/dY92eFwCosnaUm3Qx62oygZQfT4phIpm94oS4dQtoAcsNk3egw==
X-Received: by 2002:a05:6000:2509:b0:40d:86d8:a180 with SMTP id ffacd0b85a97d-40e4a71159emr7420745f8f.20.1758901571324;
        Fri, 26 Sep 2025 08:46:11 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32bcd016sm41680005e9.1.2025.09.26.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:46:10 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v5 0/3] i2c: pcf8584: Fix errors reported by checkpatch
Date: Fri, 26 Sep 2025 18:45:17 +0300
Message-ID: <20250926154520.40583-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aNUa-9HcQzyjZkvE@shikoro>
References: <aNUa-9HcQzyjZkvE@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series fixes 18 errors reported by checkpatch.pl on 
drivers/i2c/algos/i2c-algo-pcf.c file.

The series PATCH v1 to PATCH v4 is a response to the discussion on the
mailing list with Markus Elfring who had comments on my earlier 
submissions. 
He suggested:
 -to split my initial submission in a patch series
 -had some valid points on imperative mood usage in commit messages
 -wrapping commit message to 75 columns per line
 -change some of the commit message to point usage of checkpatch.pl
The series PATCH v4 to PATCH v5 is a response to the discussion on the
mailing list with I2C SUBSYSTEM maintainer Wolfram Sang who requested
some changes:
He requested:
 - to remove debug macros from i2c-algo-pcf.c as no code change was done
 for almost 16 years.
 - remove wrapping paranthesis from value assigned of '(0)''.
 - resolve conficts caused by debug macros removal.

Here is a brief summary and order of patches to be applied:

Patch 1/3: i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
This patch remove the define of debug macros and also their usage from
code.

Patch 2/3: i2c: pcf8584: Fix do not use assignment inside if conditional
This patch takes the assignement from if conditional and moves it by 1 line
up.

Patch 3/3: i2c: pcf8584: Fix space(s) required before or after different
           operators
This patch adds space(s) around, before or after some binary operators
and punctuation signs.

Testing:
   *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
   top of 6.17.0-rc7.
   *installed kernel and external modules generated by build on my laptop
   *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
   *when loading the .ko with i2c_debug parameter an error is seen in dmesg 
   and this is expected as the parameter was removed.
   *No success message related to i2c_algo_pcf was seen in dmesg but also no
   failures.
   *Module loading and unloading successful.
   *No PCF8584 Hardware was available.

Patch 1 shows multiple errors and warnings reported by checkpatch but they 
are solved by apllying patches 2 and 3 on top. Other errors and warnings
shown by checkpatch on file will be fixed after this patchset will be 
accepted and merged in other commit.

Cezar Chiru (3):
  i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
  i2c: pcf8584: Fix do not use assignment inside if conditional
  i2c: pcf8584: Fix space(s) required before or after different
    operators

 drivers/i2c/algos/i2c-algo-pcf.c | 105 ++++++++++++++-----------------
 1 file changed, 48 insertions(+), 57 deletions(-)

-- 
2.43.0


