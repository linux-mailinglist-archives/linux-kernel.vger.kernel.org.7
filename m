Return-Path: <linux-kernel+bounces-875350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A7C18BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC34F43DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02A3112B6;
	Wed, 29 Oct 2025 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6xabFrq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF13101C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723855; cv=none; b=ltCFXY4q/oFIKjWSxXhfgZUMRgoJG9/DS6grCvVdd4h9W+Kjl6LlIFT7BgmXK52aWV/2ianZef1WwWx/CO9U5Qg6be774uCqBouah4I/qwcyFqMFhFd6Bz03PSU4sARGkhgLX+o66CnwzfmGWBZPqtz9eGuLM8sSqNGbe+kE+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723855; c=relaxed/simple;
	bh=3IoFdlCCWikmDiMq6UlyJQjQlHbAeU4jDpT1gAwPsqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uUoupBzMUVY6Kjzq+591oYY2VGC6Mq7loYvnh6/BfXqBPD//pXRIGstMu8oh5+qZBCx5LBhfpOZeiFDqfDTyqSrzbchUGhleTg6mwruyRbKLBtGdw+aHHqEagcxCo/aMDBGj6RaZGWfx1zZ2JQ6oi3OsX0/z06+t+Bb3Six5xLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b6xabFrq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42844985499so801609f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723852; x=1762328652; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8IBQ8J86W+Ho0NRPhuUdL74YHKcBwQvPsUVrTbS+Yw=;
        b=b6xabFrqHt3HUHqj0PqPtfbpeYTuIsrd8OZFYdZ6hlVMEBtScRuXRecgXrn13ss3yG
         UY5YAbX+xA6sX4FGlGlHbmjC9IderpDrzClG8bBZ5ywnlTOPfbr0OdiEWNXp5SE/x1pq
         PxhffAKN0L+sfofmXT59WNO+SoSXa/nE/wIrNMA4A3nUBkMOvb41OhzL8OJX0UB1GIUb
         OLnwv/9qd0cdWb35MyfOrW39zGaGRrjl5GeSo/pgi2wIKqbAVZceVOxteh0p3RQRg+yX
         8OR8weKDg/iRqLUlN8F76GPEc+KEGn37PePMRFqIJR6u4njC+USeQ2ste7JnGMWOzl5l
         gFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723852; x=1762328652;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8IBQ8J86W+Ho0NRPhuUdL74YHKcBwQvPsUVrTbS+Yw=;
        b=biTk7MWpTmC9XPmofCtarYDLeaWnDghPLWpYTknArZoiBCGaZVtVQ7cKe6mLBYK95H
         qqaSMJDpcsy4+bq6h7emvz20xDDzzhY9ai5yah3IxaDATLaK50Wuf1IPuiE7s5RbPpzd
         /yTMUCKwJFSh+CIjJt6Cv/C9wMNJjfk7goiwPpJi2vdYytLtaAxzx+xVJYzi9qwbrbTH
         fmEfb/0bE/1Hk5QfHcvlP2NzuEOVf5NrR4YNRF2qi8J2WlAqngZegb09WaIYh4QGwJjw
         pSMU4bCV2QGuGbxPF+z4sotpZ+uwREmbai7KfoexUU3augs7BdNylWDzInPWXXfhrhhK
         Pp/A==
X-Gm-Message-State: AOJu0Yyric88UAED1OgSudsR21+CEo6RnVk4Oo3c9oZK7km5LO48qQMq
	M2sD+f/ONkkbyblJ/ptsm5F6FFwAvKCk8d4r6NWjX7A4iIn9/B5VgfAUrWNEaiuhVI4=
X-Gm-Gg: ASbGncvClJQcusHfkWf1Sl7Q4jGhwsbV+xH86g0ryEi12qCgBg0ktUyehbmBHm9t7C8
	7Pbr7EcT7fFbWm/frHEtv4L3eQPsjkDvM3Fv+4GgHsFjpdPVMZEdEY5mddjhIYNcJlQRnUaPFFr
	qR+Mn2ZRRT94b/CKHJNBrg1y8dEGRSGIAlQ2KPLwnDpDjGm4tAx76MlxSAbrsVykE2bAag6loRy
	HhPmj97977yP8h2rJjzjCEYjyZYrO/CR1e9Pfzf/75zT+nv03Kakh8DUMKqiTVzJb7J7/MJsx8f
	eJcwb7NjuA1jmyYF5dmPnph3CycCxTuXpTabFu63ntfD0ABtY28gEhqz0jdq1UPS0/RU9LrbNZm
	yH+9khKeroWVn6NlOenttJ2n7zwOg3w1DnBNGOPTLM/8+OFbD0qskycDIRhJiuy2J2upok8u7sQ
	iDE7k/Ccuj2xQIz0SG
X-Google-Smtp-Source: AGHT+IGBHPa9FWFsafhuKEepgyEqFikPWuXR6pV71zYWo/nrRIC5j5YSfmvpV/MNFmMibpTqG4Fwgw==
X-Received: by 2002:a05:6000:2501:b0:426:fff3:5d1a with SMTP id ffacd0b85a97d-429aefbc37fmr786825f8f.6.1761723851637;
        Wed, 29 Oct 2025 00:44:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/11] Bluetooth: dt-bindings: qualcomm: Split binding
Date: Wed, 29 Oct 2025 08:43:50 +0100
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbFAWkC/43NQQ7CIBCF4auYWTsGsGjrynuYLijQdpLKKGCja
 Xp3sSdw+b3F/xZIPpJPcNktEP1MiTgUqP0O7GjC4JFcMSihtBSqRpexo+AoDAmflu/YTS+fmfO
 IjekrqYU+WWmhBB7R9/Te4re2eKSUOX62r1n+1r+ys0SBWlWmOdf+aJ25ThRM5APHAdp1Xb8O+
 krdxQAAAA==
X-Change-ID: 20251028-dt-bindings-qcom-bluetooth-9af415056c1c
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3IoFdlCCWikmDiMq6UlyJQjQlHbAeU4jDpT1gAwPsqo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcW9JcAU4Jps6oHo8yAuEB6OiU62FLtEhPgRP
 y+C/MI5QDGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFvQAKCRDBN2bmhouD
 1zGeD/9qqgK7KwutWXihmzCHS66coHJAOFSOzS9UxyPLqLU7Bl3icWq10OYkLFbWLhoCkCHl1hF
 YamWAOO9frPgA5npKuxAN2CxVRFTt7Ejy3moEDcgVx8JrvQThIx2xD/j5d3JanZEcM4Z8F22Blh
 eeup/DRldPw4tj6VVO9W0E9eWE5C7YJnJUkAbAAydOGlq0r8Pgx+l+q7vC1bsdo2my20xxEv6Wr
 NJQt5MjeRvtoJU9+D6khR2wpIXdl0faLqCg4zDxx2wl6W5i+zWvASUjhQBdTFZdpT07/0aj0bQz
 HFSy3r3pw2RG0N5h1mUbLMFPEi8DrKQUpnmixC+UJethTvyq3Oe9x4uimf+vrL9E/1K9fDncf1T
 i5zNLE/wTCXbpExIBV5DOVNdm9oxZuhxrfpLLIhSr8VujHatGpOYU5baguobNYtKuoUHNKHi2LI
 fwl7CYlHE5IMmGmBAn63EoG1HSubPbh5WdI3EAKCpCpacHIVAp8mMiOL6DG5S3fK3580V2nSMhy
 yscLiIeuVpxO8bxRv4sxNsz4uT8eUHp4wP4f6k51Gx18PAlBDt46cWs4t70Eo83+pkSI5E4crIc
 xZ+k4WdkNfGEjwctaEGDwx4z7wuMaqPnpZCjEIT6vyu0yU3I9TiVNCBJWLKwyX1X5Nf66FPweJ/
 EBpIoQJJBahg+GQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Drop in few commits the properties (supplies) from
  qualcomm-bluetooth.yaml which are not used by devices left there,
  instead of removing them in final patch (qcom,wcn7850-bt).
- Fix dt_binding_check error - missing gpio.h header in the example.
- Drop maintainers update - split into separate patch.
- Add also Bartosz as maintainer of two bindings because he was working
  with these in the past.
- Link to v1: https://patch.msgid.link/20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,qca6390-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

What's more it messes up old (pre-PMU) and new (post-PMU) description in
one place adding to the total mess.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      dt-bindings: bluetooth: qcom,qca2066-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca9377-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca6390-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3950-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3990-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn6855-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6855-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn7850-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn7850-bt: Deprecate old supplies

 .../net/bluetooth/qcom,bluetooth-common.yaml       |  25 ++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    |  49 ++++
 .../bindings/net/bluetooth/qcom,qca6390-bt.yaml    |  64 +++++
 .../bindings/net/bluetooth/qcom,qca9377-bt.yaml    |  58 +++++
 .../bindings/net/bluetooth/qcom,wcn3950-bt.yaml    |  67 ++++++
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    |  66 ++++++
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |  91 ++++++++
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |  99 ++++++++
 .../bindings/net/bluetooth/qcom,wcn7850-bt.yaml    |  94 ++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 259 ---------------------
 MAINTAINERS                                        |   1 +
 11 files changed, 614 insertions(+), 259 deletions(-)
---
base-commit: c9d6ae701ace298035b6529eb10083d356cf2ae7
change-id: 20251028-dt-bindings-qcom-bluetooth-9af415056c1c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


