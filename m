Return-Path: <linux-kernel+bounces-846502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2ABC82F2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0075E189FE02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FB2D9487;
	Thu,  9 Oct 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="RYYTk8nx"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637132D781E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000810; cv=none; b=OFtbkXAXWMq98wsNTW6VMPAzPEnOWSoqnSt9XdAO0MlpG9zPJc8WeZN6C95beQ+24hPguKjhcsT5fxNuQoTJ4lJquPFCwfZbge6BEMpuzkq01DKQ/al8wOGbbutk6f+f0cN9U/RyQHigwFv9nVsJu8av9OlqXVuoQXGYyu5I7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000810; c=relaxed/simple;
	bh=SqYp6oMGQfRwN2qH98jj6JyAPPXL3u1jMwQvHYWacq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oD7KkpXg6YASnFuB3wat3LZjm7c8MOHMwxXQWj2cycmxhDGDyXV4OwxN2XqB4Rju0HEo6S9DpUO7johSf+8xYW3KqDd3QxO8jK3zZobkCA1ZLSEyPOWCUj2rsMuJBVA8ShtXy/RvfIuKEjvmwQKX7ucN+n5hBqszZndnbjtlB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=RYYTk8nx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso1471375a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000807; x=1760605607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNMFRDKf+PR9ZifP7PovpqPBrj6t9cvi/yjDK0cLJZg=;
        b=RYYTk8nxGInV6JK+Ti9BAS9o1eWxsoLGpJSrpBOpTCyN7VDU+HwJTNnznx3hoWNlCm
         7Rt66NEwCSc/Ir4uYKqcf+uUtAt6uQ4qGoBVyygOGhYerpPYWjzZhDq7O2Eg/we33Cqg
         6wkTs5rf8Jdy8ClQVViFSaknu2VDtTXl1oVaNnM0biNsWMXPRneev7U/6yoquWg1hmE0
         miILVMxuowQAXuoYtkbkFJGQ/z1UKP7ltuu4V8+1j6sSdguBNxTdWQW2TkrjOqBJOFzj
         ISqCk2cl+FY5WsoakwgIQiNzitGdOgvWiilRcaNkrdsAXHINYT11vwx2ONCUJctNdQLe
         X6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000807; x=1760605607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNMFRDKf+PR9ZifP7PovpqPBrj6t9cvi/yjDK0cLJZg=;
        b=MTXpJoIkBSLRtGWYX4F91kGB/ickxXAHtTlWeYT8R2XJ8m5XCExU44OhIwRq16dCil
         8CvXP4o/vPVB7uD38kmdNgyAwzAtQqyKP9VRgCSJxY1BdflPslVhG3Jd6QEjt9GLZ9rG
         DCCyQkRSOXCxYa7b25GwtEIOC2dDYT1bDOSc9NmwubISx9GHcpTUIqsjzqia1VokVCEa
         QSArFd7Mc8gzqXoU+Jrb93YR22u++5cykIg4rrWOqLODYquUz7wCZMdrsBBugETahIFj
         Js/YtcrwtLyY01kxP7lKwxtth09UKfKS7ZrCwBQLdbI+FBWOPMwugSUeJkVKxWJO6/12
         LL8g==
X-Forwarded-Encrypted: i=1; AJvYcCUqZsTyn40ZOKMWrgqHFnaGjwl4KLR2nUSsWdkUBd9d9KhvDQTkfEzjrAupipxudjKgmSX4fSpZ9DWKEGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8a4Op2x9aWbao45uyHmhrXJOJM/LUgxLUGhq7iockgczqiRCi
	6cpQK3nWN4ZZDCp5KI8GTiiurHsn9L9LPMIUQC92oR7X+m1iQKVVSirbu+DC0cvcUTo=
X-Gm-Gg: ASbGncu1HyekS+jWFvRK56jp8DmDWQmb3mWwNtj4XspnTY0/0xFHp9q9v25U2tslW51
	5+ZgboyNq4aLOs3270zfb+p1TlX3fv12aMoTDw6ias9IUc3e7olFjPH/s0ygldEwXe6aUT5DlUI
	RKT1wVgi3OWHwFKoNfbSHWUWSe0PBxnzKqTvZ+40I13wMbtp0oZnDpIXZSl6cpu425hOnp+97wu
	dLWVELppejbbpQTOQBq8KjM4wdhm0yfTN8/78m/DjTYeqzDEo5kKCJLC9X9isnRZq3Er4PyQu9X
	6kbFA1jPT7OmEuKUR39DRZYWqpiRmpkQHbcdEYLeKHmpLLktxpfuDNx8t5yEsoD208vfRo17To2
	coyhxj2lEWV5vafCfIMhTBNYvCPG2tt2yCIbRBgznnS7T69/mEL8wmHMKoXVP8XaMthdOjWYLTL
	YLKXfQ7NbBxXMkK/483exUZ2ohKqf8
X-Google-Smtp-Source: AGHT+IGm/Mg20wT52Yz18adAEnK19Y7RIb9c4hj+CZ1l8vH2jZ1AG0rITrk09L/xcZA5AmW7s2lOKQ==
X-Received: by 2002:a05:6402:26d3:b0:639:fc76:a1c5 with SMTP id 4fb4d7f45d1cf-639fc76a9b7mr1504552a12.0.1760000806651;
        Thu, 09 Oct 2025 02:06:46 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Oct 2025 11:06:32 +0200
Subject: [PATCH v2 2/6] arm64: dts: qcom: qcm6490-shift-otter: Remove
 thermal zone polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-otter-further-bringup-v2-2-5bb2f4a02cea@fairphone.com>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
In-Reply-To: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=2070;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Xc4H+R3mMQrdOpE68XhI6JWcRws9SKVfGYWA9EyPAUY=;
 b=7CsE0YfsD2z9CLqNOuY/vXXLfkngSXvRXnGRSw0zBuQ5jQZ0VOMBU+u6MslQvP2csPjlDDrbT
 xcjwltMQFI5C8Thh8ymLmP2AGKLvF9kHo3q6JTSjrIhHnK3oUbr8TF/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

As with all other devices in commit 7747a49db7e5 ("arm64: dts: qcom:
sc7280-*: Remove thermal zone polling delays"), apply the same change to
this device as the delays are assumed to be equal to "0" if not set.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 8d45e6ac0e44..0d331bda4a82 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -130,8 +130,6 @@ rmtfs_mem: rmtfs@f8500000 {
 
 	thermal-zones {
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 2>;
 
 			trips {
@@ -144,8 +142,6 @@ active-config0 {
 		};
 
 		chg-skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
@@ -158,8 +154,6 @@ active-config0 {
 		};
 
 		conn-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm7250b_adc_tm 1>;
 
 			trips {
@@ -172,8 +166,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 1>;
 
 			trips {
@@ -186,8 +178,6 @@ active-config0 {
 		};
 
 		rear-cam-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 4>;
 
 			trips {
@@ -200,8 +190,6 @@ active-config0 {
 		};
 
 		sdm-skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 3>;
 
 			trips {
@@ -214,8 +202,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
 			trips {

-- 
2.51.0


