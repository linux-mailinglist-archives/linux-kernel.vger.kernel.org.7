Return-Path: <linux-kernel+bounces-870582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA144C0B2EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE34B3BE232
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC552FFDE6;
	Sun, 26 Oct 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQyF9gCl"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6842FFDE1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510118; cv=none; b=oG9rzjkub2bNyG/jCLgxYknrFJ5L7YA3FM0oIy566WRXAtjfyTl2VUq9xii8FElYdJM8GwiP8wrEjx+RjT7LckFh1QnR0FEZpv8eKjnHX8FYjVl0PcEoukXxZp/0GM96RCz7dscvNVgba+pAZ56/dpEC+pfwoZhLGGInqHA8QaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510118; c=relaxed/simple;
	bh=upl7fbQN1RFY3FhbbuHcVOz37bzBtiaRqQPwxJw0fGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkq2y8VfVwvmTuCKg1bvRe/AdnQoFHi8vytE4kkVbECj/yB+49tHMn4Ee5YdXN1psEoQ6ssgGAn7qB2iTXlcbAhM/HPSi8PLbIYcuxVH4khRBo+5mtAv184WoJi75aVJZ5BarITvjcBtfbhSnsERBhWn6H64BNV0nx5sDcYUQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQyF9gCl; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430d098121cso17547505ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510116; x=1762114916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnM2FO6bs6nA8HkBT9t6fSJTACUjGcFINKCS1dnQUH8=;
        b=jQyF9gClYU9Zx5qxfmXR6XX+DQx92tMEQ/qMoC3im+zwgw3C7o9JDdSU0ppKqzyHPI
         ZIg3PXye21RSbBNKRGeDnMdjYuzy7TZXTg+mo0qT2XC9/zW6WQxkyIBCPFWo4CLDA2x7
         h/58nAWWuRCOwS/mkpLkokrpvFcP6XJqmvHthOYvmScMkZWqV5rPZGDC/CMr99+1pH6D
         nnSDsnFFtnMfcQU0BR7rNIgyCKw3Z2lu/DvcpUFcJDxOfwpDRd9Jp9ZEms2cJe032xGG
         x0jCQ0edRO2jt5Vglz6jeyoVhAi+UDzPScovPg0FFQr6yv/PSPIPj/A6qK7kdutfhFgF
         P9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510116; x=1762114916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnM2FO6bs6nA8HkBT9t6fSJTACUjGcFINKCS1dnQUH8=;
        b=kGC6FQXeStW78aRo5DVUCDeT3KiNrnMmQ5FaN9Go9+ET2O9IEYPwRHKG1RgVoJIqZE
         Bb9wmIlBEeagrtRTV113ldobKtqTuIt3iK3dQSmw1aGVgz7Xp7VTxKcp5P71dfh0Qcc9
         933XtO814cP8ygCeUI0mi2gnwW/lJN4ExifiZNbrQau2HaYpn4MoabraBYqDyCevyjsi
         Temky8WeaEKgQg3S9uDTrXaLYoXzs4v1WCCX+XzB86/sHuWv1TtVnVHKnE4eAAFs0Z4u
         8JfIJtJq/8asp6EMOo5xduDUPci72WPFW07wBkZQTao4VI/6/Q96u5WusPy0MT+TTz3/
         M+Jg==
X-Gm-Message-State: AOJu0YyJYJtUDiv0Y0psv5PMr+Ltm7MJGcmem6PIzfgmNUCslLEw8FeL
	yBpFlfc7Jq8m5UCBTsIs5dNq8ESf5kLVKxYjfmQ+PZHoLS4gDJwhA9casKRIrA==
X-Gm-Gg: ASbGncsEXWm16d/cf+/1q9IvwExfxk+axTXOnVR0znEYO3I3tB0zxjAAQik9d6yt8OV
	sVPvHBOIYYjikZsXiIHTE4y+m7/irVV5XXsQFMVCnBWbILb6lVPIteg6P0hPz15cOwTfFfZ6vCO
	oLs+yxvnRt96FI8ndTkCPyAVhZIlBQ7hT3hlwu/97t9EuIwaNSlV2ibJ3Unjh1gAt0asDe48ON3
	a3sg9bF7aIX/1XEcJghzTdsEnOJaW65LmeHCU2m/VyPsGmZDmF1hNplvWUk7pSt99UnRt7fHVH7
	bVe9bMTXoDuwoVnJcOTqjU2nQc0ULOQrb+gyL1yXPH8EcoShvRd6W4+kWz8or/MlEO6McoZJQTC
	W1VEuIdpZfsUkSKdPn8E6vs5ODhtJY/D+tm2kZd4hKkj9bH9GzyoGinw2zQSQVvcwHQlsQazpLj
	v25D7nYOg3/yjuOGUSWi/AW5y7qzwnSxyiOliQucrbn/9ldQNvofq43NQxGJ5X7SrqwKg=
X-Google-Smtp-Source: AGHT+IFUbhGRxVkbZmJh/TnMaKNgGja86L8G0I6BD7hPOi7ozKcgu0IgftmX/NRo7b3RCU0Id1h2gA==
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id e9e14a558f8ab-430c525f520mr296178395ab.10.1761510115663;
        Sun, 26 Oct 2025 13:21:55 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea995e766sm2278412173.51.2025.10.26.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:21:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 0/2] checkpatch --debug rx=1 facility
Date: Sun, 26 Oct 2025 14:21:39 -0600
Message-ID: <20251026202142.1622060-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch uses a lot of s/// and s///g heuristics to cleanup
code-chunks, before inspecting for problems with more heurisitics.

add a drx_print("reason") helper, for use like:

  s/$patt//;	-> s/$patt/drx_print("does this")/e;
  s/$patt//g;	-> s/$patt/drx_print("does that")/ge;

(note the 'e' modifier)

To activate, pass --debug rx=1 or --debug rx="this"

Jim Cromie (2):
  checkpatch: add --debug rx=1|foo option and drx_print() helper
  checkpatch: 3 use-cases for --debug rx=1 option

 scripts/checkpatch.pl | 48 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

-- 
2.51.0


