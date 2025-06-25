Return-Path: <linux-kernel+bounces-702037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF8AE7D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3A01765C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397112EE964;
	Wed, 25 Jun 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LvydARHx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760222E11BB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843404; cv=none; b=A2eA8H1exEs4npFIWFKdykiNlNDJJWA0aF0l1/3CnPiYap7JHpqw+RW68KEPEGMsHGCpjd1VYNXIZ6E12xig/uoGMfUaftTGnnwBWk9W0xviaqGDB7O+awshtoazLy4gd7b2QpvehByN5Yzk6SEeM6h5FW81mw2FoT8OraNecoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843404; c=relaxed/simple;
	bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nC3CcI9glEkXiKXadg1+spxvG5QU6bgSMp+/iaHs2n6xVs02SzUqZi108OdeoXahhZQBn60jJTpt85WBd5G1ECg4Bi+4mnd8QRXH+kV8j2UpSJbgJpcw5BnDjxdRmqDpKuXa++GabMN47yBuOETXowXCq66OPy1RWMZQNzrVhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LvydARHx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so682867a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843395; x=1751448195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=LvydARHxuzFxtCfYscyeGvnu/FsA34ENHBLug4havR/GAfJjtcgjud1oswyXYJEGy/
         18UVrovKSP7pci7iUFXIBsoy7o297dX//je7PPKjyGig3UQLEiXTAKzM94dvClfXnKf/
         eNAK9I6SOsIKRVnDXQ2qByOHUGY7tkhoEw2QBjIj8xH7u2y+T4vAelk4B0bTp3ZQTYGR
         oUNxVEexRMVH20ICaBFC/TsJ1eEMZzFU72nIXwPnYstPl7+aqLvx1Lyanu3MU8gY/acD
         8h2Ili+bwlMoAQjEDVMcnB2H4J5nnsyfbvXTIMnWk4VISDwG3x7W+Cv2qKPetmsCXpu1
         8Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843395; x=1751448195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbAxlNGNMBjPB368qsF4KlT8ElPeOLO2pW0abGoJlYE=;
        b=b1lugdjyM8KXy4ObUaWb3zxbkq69SCwA2kpkODvpNlMOQlhNAFWufJdEfY7FxOvwZD
         T33A/QM+u7LWCXzpK73alfvTtdeuUnJe3biiTtzYinxcVDtGHysdrYMksZduUT47zt87
         TF4RNHK5Wkk9tNTsmAIm6d7GTfiS4o5H8JB9CPPNv4f8cKNQWwXl8Sth6QM+v4HWwnSc
         XcD5p8187Q5lfQHdWxbTiqMis+O6b7Nkp97zUnXbw67SheJvTRVdyfzWTROUv+P2OqKc
         TPBK3wPYzUuSlB1LFG1PaDMftROWCl/tsbDKN08kSbksJXoTG/wGvr7OqMTRc0E9E+dM
         fg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMn/verYLxiIo7TGneLGpW1w+yYA0Q6vGAc1W/NFRybuTe2Hw0IIMVFXeyJvx00tZfz1KGXYFch7hkJwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExha0sPcB1wwAMsqQa1Y0oVAYS4TyfpEJd0/252tLdgkur8n8
	sh9EpHpkoQl43Avsgpx74hQxFmeq0mTgrDZiytW2ET5qX4NkeG3gSTrcsemowxi2/uc=
X-Gm-Gg: ASbGncvzazAe8rHNU8YwJMLGUhFv/uDKyMU3UCp51AuwX8cJdGr874Bors6hGpV7mU0
	ugX/ltL8d4xb86eR7bcSHL8BYW86QFbWBmDwI1sa8nZXg4XtyHR2b+KmxahgLkGeCiqneNlY9k6
	aJi3hS8l0vWHknIjJmArxvsM4BpTE0x2YR4/myR3LAY8UAj//DB3YwQ6dPyPvfourzzN7U1mULx
	KqeALoq2YVROuopsiaUFROkwBi5JVw8/eeJhF6wCwAWrhvN4Zv66J9LjohUfM43niZEWFvdH2hd
	/QhUJSy8aaH7f4NxGC874P2YRmcCZp350RREJKhMDKSSy22KZeagqoVX1iHPCNAFkgPXr6mxlNa
	ztqHJtmSM8ZYohtdynDuNsXLoiV2k07Wb
X-Google-Smtp-Source: AGHT+IH5Ea6Oe8g4N7kGjKPuq2Ehn1sdorRYiGI7t0sOOA/sE5jzxQrPTZnHeS3tOTzbYiDpRieahA==
X-Received: by 2002:a17:907:6d0b:b0:ae0:c539:b89a with SMTP id a640c23a62f3a-ae0c539bd16mr168789366b.19.1750843395300;
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:02 +0200
Subject: [PATCH 07/14] dt-bindings: soc: qcom,aoss-qmp: document the SM7635
 Always-On Subsystem side channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-7-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=902;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C2JtTvyb4AXtbDuTYKqVJriQ2UbwtZ/ycgN9VosRmWY=;
 b=NfoI5zbKRHbMeTR2sEabxYna1BsVoqMJWG6yk0k36XGqnYtuT0/2sUxemlmo/hi6+elMefc19
 3axPadbKyacADeOKyW5Iv0bjZ9mnmTelUfPVfAa3dsIc/MTy+uREFd/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Always-On Subsystem side channel on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 41fbbe059d80cebb214317df8ae15b86573546bc..24f7536ffc5ab7489d252359f3061c8619f1eee5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,sdx75-aoss-qmp
           - qcom,sdm845-aoss-qmp
           - qcom,sm6350-aoss-qmp
+          - qcom,sm7635-aoss-qmp
           - qcom,sm8150-aoss-qmp
           - qcom,sm8250-aoss-qmp
           - qcom,sm8350-aoss-qmp

-- 
2.50.0


