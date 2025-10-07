Return-Path: <linux-kernel+bounces-844469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD058BC1FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C08FD4E1B65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AFC2E62D4;
	Tue,  7 Oct 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L922AMHs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171091E834B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852592; cv=none; b=j9Wp4bXx8/lvIAHYiXNbsn+PSP1Zof9FRY9QEW6+Z5ecJsr83PN6oMqTEnm8JCqlIxoSAcvDswMZVoS6cXjRy2ExrUqBxjBiU76IzCCQWpzl6mKN/KmgFj84dQ+5Zsx5skgEX0hJ6hvQWhcnk35MYIBLN1wep1B/pj4x5IOj5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852592; c=relaxed/simple;
	bh=2PS1aw7dfUT0k1FWYcqJDnEg5AxccGVN6SkNj7bMjuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iIzxSz/QTK5zFb3ycHNR/UvdS87BTD3mo8XLaiUAHn/tJAivoFrAOmYX84RQkleIn2ENDrVTVvAvKseOia1STMjhQJ81CVwMJqgJoRvquO22IjYyYRl1SrJHi21QTe+Bu8XphyFEZNMacUU08lpB9tuauiQRvBxNVzpPP7jCKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L922AMHs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1088692966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852589; x=1760457389; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iDWqoWfueHqY1DQn3UROh93hmAu+K7Xh14JdQEHAgE=;
        b=L922AMHsQ5AJuI4epf0tAPOTsp3RJtAOWMo36afQ1pEbLGwffIShfXVmlPk+lLQQ93
         EeBXopkUAMHLZuemTVYSEJ7m6jnIOVXykOyCs3FEBC0RlVwTrxkJEke+nEDN4W+l8P0u
         aoA9rbAVUARM1+xA/n6y583bzIQ7LWOgAX0H/5SbCLYHdr5fwZYCodBd1+ZZeurkrw6A
         Q3/1Xwy02u/BVJ8rroIOgYduqg082iHUNr5enYcJeaieueNxmVgNdxEHnlVE03tLzdb7
         3TE+G3s+NmYwfC0d2WY46vBYIir3+5fizW/8OQuh3f2Xd2kH0Yt303aTmFk15RzrS437
         8bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852589; x=1760457389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iDWqoWfueHqY1DQn3UROh93hmAu+K7Xh14JdQEHAgE=;
        b=GjU1Grqhbwgjgbi+jnZepCmKvo6hnnoU5RbQzXKEqhYd/wOX6oZ7o09Ube9q+YXCax
         zvSCCBGtLZ1i9r8l8Yc1wZ7XPUY5oTlTSAOVQ742d82an6cOGeclJ5xuPMFsff4MRF1k
         cRj3BJEznVFBsd/m+NIYsfkrxXTmaDVKT+wFrdG7MunHf+KVPngqMLEVhZBNbShWQGab
         q3O3W1bZkZvtYivdMKziTES2yjpLLqFcPLInUdtpEzhCdc8Ke1fWO4dSaG6ZNo7Q5NWQ
         Z7v7JrOZMPhRdVR/GZL6//pSBwVHa/8R3ojcyPSzQ4BU8F6D3QoQQMHMQSVNuGBHd9C4
         PcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWowNnqxpimg68RYoTOGqS4e/NkYxYiMRLzpOQCZVVkrbbYS6foq/zyKlpBDzUpvRcpSQm2RpgTNCzkU9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHotXTmwDNuZQE2/jQZxSdcgi+xklEYZ3gGd+RV52Sjb/2qoMp
	ock9EBJTD8sVBstuiuouMKIwjUYtyadGX8A7A/dPc2s86/y3SoKrfOuzVFyXdHsscarGpkdmKtX
	XY9RG8+c=
X-Gm-Gg: ASbGncv1HZGXRsEdC8XWcld0og2hbE0ZK3bOFnGI8huHIwP75ZUL2ylQyNlo1UkiYuQ
	TEGGXD9dqua2LxHwDJHGwdDLaGi89v6EuOkLQUxdD0BkoP8kZH1Nq61Q6VVpOmjJIfxYsQZhzg9
	hNxptpxPkeTbeepJxHRmocdH5SGQm5Ibw3M+ns8n81Gb7DBPWc58M5CimPOEpOSgF26PP5PdtNf
	w9ogZp8hksxFWz5g2ff7qB09yLdXtNrslFA81lXqBV85G0lrc1NnGOfc3XAaef0tgfgIS2FkMEa
	AJI/0kjKqDx6OXURoLhqa8fMq7xWxOfACw9emP3snO5ZS665vmw3JovSHTX7wLLD6eLBX8yZDIT
	RMvlFOvVl/yGYezJwfiZuT9dUeU9nXltK26DbtNyURTr2shmtzbSk9EyTAYk1tLcyis6I59yAPq
	SpfFE2G6tct7MfEwsx/rZQ622bGNphxb5JJx9jIqVa
X-Google-Smtp-Source: AGHT+IE9IcJVSPedWcpAGpdnmJW4z9APNCOE9dq2vD2s6GXK/hxjPEw6IveEriVdGAIUqOpPhoFZSg==
X-Received: by 2002:a17:907:934a:b0:b48:730:dbb3 with SMTP id a640c23a62f3a-b50ac1cc3eemr13165366b.32.1759852589395;
        Tue, 07 Oct 2025 08:56:29 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a173a5dsm1428820166b.85.2025.10.07.08.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:56:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 Oct 2025 16:56:28 +0100
Subject: [PATCH] scsi: ufs: dt-bindings: exynos: add power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-power-domains-scsi-ufs-dt-bindings-exynos-v1-1-1acfa81a887a@linaro.org>
X-B4-Tracking: v=1; b=H4sIACs45WgC/x3NPQ6DMAxA4asgz7UUoBVVr4I6kNihHuqgmF8h7
 t6o47e8d4JxFjZ4VSdkXsUkaUF9qyB8Bh0ZhYqhcc2jdq7DKW2ckdJ3EDW0YIJLNKQZvSiJjoa
 8H5oMnx21HLxv491D6U2Zo+z/V/++rh/PMByuewAAAA==
X-Change-ID: 20251007-power-domains-scsi-ufs-dt-bindings-exynos-87d3ecbb3f4b
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-scsi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The UFS controller can be part of a power domain, so we need to allow
the relevant property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index b4e744ebffd10aa237e01a675039f173e29c888a..a7eb7ad85a94e588473eab896e48934cd5f72313 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -61,6 +61,9 @@ properties:
   phy-names:
     const: ufs-phy
 
+  power-domains:
+    maxItems: 1
+
   samsung,sysreg:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-scsi-ufs-dt-bindings-exynos-87d3ecbb3f4b

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


