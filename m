Return-Path: <linux-kernel+bounces-880298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9319AC255EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3B364ECE32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524434B185;
	Fri, 31 Oct 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngo7cMjc"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5F341AD8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918962; cv=none; b=D0BSwifp8PtdynaeIDCaug5/y+QI6ca+rxKpcpa91NbtZEspaBICpSm4uVRyjskeHIvA60KQqh32A2tfMDhWEe8V+ludla5k9Rc+8vEbaVKlATrjTaJfhBblZw3kGXe0PpUVLDv5dOz2fd4XYDdEQ60NMC2IFWgp0nWl7xIR42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918962; c=relaxed/simple;
	bh=rv1lakdnapd6shhm6W5A6hAx9wRV9T1vgsYATRaDRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMMVD+ZuwR6HbfaTnDfDLo/k5d0vYD545dLN6jqbj0Y7T9YnBs4Nvaad09CrFQX7mVyrSXeOYoUzpUR8yfGOioHvh+lRXBpJMAq9PdPHytbbWgikRhExPDMRafE5/rjBdJtVr5gGgQm+sm4jJTWAjm910c22M+dvMDkRNgYCPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngo7cMjc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781206cce18so2675775b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761918960; x=1762523760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXy44YBpbFQ7ccTa0IVPqx57mQ389VTun+ngC3PqvuM=;
        b=Ngo7cMjcJTEvXJfB6Y+GPqQvaCcm4ZJwuykkefHlNxqrTBIDjA26jR4JlXE16EhoPm
         6mTCMQkvtK/1N5hmxSIMbrStNI3DF0VpLmg7S+97H822TuxIpvwJplJqjIKamaT7Oak0
         EAoAcG4e0JyCxdBHJHfSa9phYGy5ALd6KUhG54mkBkASxwrEURmzfSkmixapwiN1/inN
         yEiGPlkYyyr+keJqv0cu2DTPhdDzK0Ets0GgpLe9NbHu/7PQbNWNL/fXzO4oMdExi+R/
         p09tTz7bf+vdtszbE7I6387fWNys4K2YOZ32QAlJ8foTe4zVgkzephO6WhyrkPVYJoC3
         EWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918960; x=1762523760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXy44YBpbFQ7ccTa0IVPqx57mQ389VTun+ngC3PqvuM=;
        b=gV8xKmEPy1Ca1RZxpkZ1BT1QnGojL2mWIzRqEHjQNtTA7DF8+et+XKmutjmtzG0IwM
         PixUtceiGs3/W71FLuRxalnkb4GazWCjcRqlx0pbS+jZQnhkZVoGvc+BVKP41EJmpCSR
         oeth9ssbFH/idHwWQG2MbQlzs/PgdIlKAVVSj5ovLUrnna7QYTEvIPpD4HUgdfK9Hh5b
         uqiZA41OlcfArMdn3L7OpFVbOnLyxalBCYrDLTwBFmizAkPE0lXBkN2kMhyXhkpCYsBg
         nk3tOgL8VT7NA0kBsB2HQf+pHSWabJyafWOzkywF5oDKVEEnkxr7KXgv/PkstsPb/A8k
         N1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7LEVk8YbSWRsEBo9VSo30NGi+UtwR6+ZHUwXARjRedOIMPFVLtg3GW6d6VebD5y+zt+2BIaIMHmy85sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/DEr9T92JXk6Q+D8dgb4pnRKFNFrZDasQAg9/j/Y/UPFIzNR
	yih5AWLGbx+PbG1jpCIU9SOpPXax+XtnnFJfDyVu1hc9IYBbS4zsl7n/
X-Gm-Gg: ASbGncsdO1avat7gwGztMWpB7ws0RvOuXgtpWDOYUDn5JMwab5kMOh52nJLfQDf9qJq
	La45zqlm/TdVFkAifcNQa5RVapLmq5k9uMZAH9vKAcZHL46+YgC8vwMWfX5+nvdGUluxYnQ05RJ
	SvPNJgqcGTI7lU/ncykL9d7Y667cyuaCVz+v8SI1YDEvrXv8M/evxZS4sgltA1wIDL3HD4+OGsK
	uMGu23Mr0tfYJ1pJujbslqXRirfYOt6T+Tr/YIwLSlgWfhhxq4O2WqFjF8wl5oJnxONeu/deV/O
	l1GW1vv+/7Wi55yVIRwd3DrsDRxiV4mn07Yu0oLC2pM2zuIvxC0pTl3vbdzbEIwtu0HZbccQf9U
	UavAncVQ7XA6F5ZrvYl44rkKpmt3+kcXSOYCc1w7Y0D4NsNaGnhX6i3Z7IQ4pwJd+uW6bnMkGyN
	n5CNBdusg=
X-Google-Smtp-Source: AGHT+IFa+KtYs1Qd2wH4XD0ttk5HSiq6KyawmAxwbjG3Kjo7lM6fGlhfsK3Z/0aCWFdV/RCWUZ3TRg==
X-Received: by 2002:a05:6a00:14ca:b0:7a6:9f96:966 with SMTP id d2e1a72fcca58-7a756473a05mr5078674b3a.4.1761918960283;
        Fri, 31 Oct 2025 06:56:00 -0700 (PDT)
Received: from archlinux ([103.189.130.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d72c5fsm2302271b3a.18.2025.10.31.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:55:59 -0700 (PDT)
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Raihan Ahamed <raihan1999ahamed@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Lenovo P2
Date: Fri, 31 Oct 2025 19:21:20 +0530
Message-ID: <20251031135506.214025-1-raihan1999ahamed@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the MSM8953-based Lenovo P2

smartphone released in 2016

Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
---
version 4
- rebased on linux-next
- enabled accelerometer sensor
- enabled gpu and add gpu_zap_shader
- add homescreen and one-key-low-power gpio-keys
- enabled pinctrl for gpio-keys
- removed explicily added tag

version 3
- sorry for explicitly adding tags
linked-to v3: https://yhbt.net/lore/linux-devicetree/20240226195516.174737-1-raihan1999ahamed@gmail.com/

version 2
- document device compatible
linked-to v2: https://yhbt.net/lore/linux-devicetree/20240226094256.5736-1-raihan1999ahamed@gmail.com/

version 1
- add initial device tree support
linked-to v1: https://yhbt.net/lore/linux-devicetree/20240226055615.79195-1-raihan1999ahamed@gmail.com/

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca2010..cea9698fa4d8b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -200,6 +200,7 @@ properties:
       - items:
           - enum:
               - flipkart,rimob
+              - lenovo,kuntao
               - motorola,potter
               - xiaomi,daisy
               - xiaomi,mido
-- 
2.51.2


