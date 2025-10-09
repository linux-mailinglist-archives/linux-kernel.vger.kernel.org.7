Return-Path: <linux-kernel+bounces-846507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482ABC8325
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338AF3E4D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A52DF719;
	Thu,  9 Oct 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qEVTNfY5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1602D7DE3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000815; cv=none; b=ndjdsWRVuX7bcGPf+vsZyNpl5RNivIrWKS1OwvwAOzGkKNzJlCWA4FUtMSEy9S3GdUmj+TNLXXI0opTMZRnGM/ZBPNwv3cZ7fcjdoPNjBUXUX/bf1xOie2A4uY8WhPH4O6KdQbAEUimzdyD2mXeC52dOslMSdwPEOOR8bb4CKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000815; c=relaxed/simple;
	bh=yLdE29W3q6fp6RFFvLxYUfrIrhtGR1wmDmW0Sr4YfZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfK5dX0K7s+ua9ULfS4i1YWUk2HF64fpVfATkZhB9cdrHAQXEL9eEsvTp3H1M0LQo2Yub8/e/mNDFkHCRkF4PSQQAhTyGzK7FzIdXRD2C6UnFIN/D8j9C5mWP5+VyQ/RjVwaB4Neskj8V35E6P6FIFS7g2vT83mAbEhHfJ4luMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qEVTNfY5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so1357050a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000810; x=1760605610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4NjgC9RkbCwMcFDlcSxR+iB4R9yIvYJSpP6iT4sVxU=;
        b=qEVTNfY5DM6LhBvMP0Bdl9LTz+/JavDr93pk0+ov8L74QYTW4RyfAch8CfL0AXIOn3
         knPmLBrjSeYjTnXZefmi7r9mi96oKbu+LK49T+diBKCOhhNa7y6BfjuIOIVkEiyO5InC
         U+ri5s7755fEnsRarkCNtXZ24VWL2Nha8c/bfKZy3FvYw4qCva3NAdgIZ1PSEyij8ZwC
         ktX5DtIOlONTr+RO0NdlFYmvAqfTv/zbW/QUMrgsO+1WTRRK2z7qiMUdqYJgAxQtVbyP
         GAqa6gxNAsvv+nC9bHen3qEPC9tRQnLruUgbSCtIWxlfyueP05JEghTEKXqEXE8qs/Wl
         ymMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000810; x=1760605610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4NjgC9RkbCwMcFDlcSxR+iB4R9yIvYJSpP6iT4sVxU=;
        b=Dyc32bbNu08uc2P813SRM8lZebdKB9UVIijfQ8XliMUmACiLeBfcsTKVGwedzmDCWh
         Je4AaYzU2+bDFWG2nZi3tLkIFnznBlRTZxwkVeK+5Wm/N24hwyOHwQQMwJfImVqPQuVP
         9QNozGXkz1aUipJzaA7VnJwu1cs4CnO/rVbyR1eLKo01lEv3W5kltRFGvKKzzfrxvA7P
         u4G/BKtDUeeZARFC0rN3vfLu+AeOnIys7lAD2wqUvejdfrgsMzkl6xzC4fD31yi4x67X
         bKLJnAKlzPYwupvjgXSFMmj42MjlyBTGVN2oLZnOPjbdk6AV2sCquXTlKMQC8IOvXaVw
         fZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYN0LjLlD+M4Uditd94xlj12V7mo53DKUjSL47lbCZah78ZgQJ2ZoRHsp8McYyg7otNp0Q88Igx7dwflw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbt0/UPpO71Fm9RchyzB2PYIDCWGCKce2CjqANbX8Ny64Z+iXf
	zbKCsYNDdt/OrDw4xSvVh0Aukde88cGTmpIgk3favQTb0dVWnXh98PV2p77ybLJ0OWM=
X-Gm-Gg: ASbGncujAavNWjLB5AlJZVqv8aZKAKAlKbyKllErB9/RSuQjHbQyYtN3RQKMHPBh4pW
	G7ryH/qEZRXmmm5/4UoGl62eHyUHJP602kZz3xDgrvyZKk8tiPx/owSa8FouZf+e7mFu3Ft4vCF
	I1n9+ukRCA1E3Fg8MPW8zuqyzLHBZ9UuvoGU2/LMW4L6ngciiDjZTh9RHYzWuI9jbr+yBO6zxzu
	3RBPqHpDvBuUxFAgtI30cFD35tuH9GVZuIbIR0ZLEL8Vf3oFIa1uCc2VHhSOieDbxepegcjqvlN
	Z9Xp10NZlICPW76SvMwTLdCZIwrBT+Pysu9HepmboPUIF20vMDaL9qWZusyNh/IOWKuYdpiP4V+
	IrXQQ+M6IDhS2sQYTYgtMY7LCzDcY9Xil6Rg5hqcokXgNtbsoIo6V7+xbxVcQPHLLJFIDCXL/io
	O+KL/5SCSYKBzH4/8Ubs21XaTdAd36
X-Google-Smtp-Source: AGHT+IEGHEsWgFTbqDlcjmaxGAtchnOTHZU+ZqbHIvrNZjcqWAofDGI4WU+100Z28ra1wVCmv9Se7w==
X-Received: by 2002:a05:6402:51c9:b0:629:e50c:b058 with SMTP id 4fb4d7f45d1cf-639d5c52cdamr6533867a12.28.1760000810172;
        Thu, 09 Oct 2025 02:06:50 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Oct 2025 11:06:36 +0200
Subject: [PATCH v2 6/6] arm64: dts: qcom: qcm6490-shift-otter: Enable venus
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-otter-further-bringup-v2-6-5bb2f4a02cea@fairphone.com>
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
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=892;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=J//KKH4NjGVxe+yIfbxvzMAr1vNzhSAP+lT8QV/hXkI=;
 b=yla1QJRbGcCv57mtvOUoDOjq/Xyu95e70upu7Js7Qn/849RcV1TZ0roEh3wf7o45VP+LpkUSt
 lXFf/kO0FWQAk5WA+lK9U8lPfA8xHwlxzsO3zlswLBccWF97J7CUicJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

Enable the venus node so that the video encoder/decoder will start
working.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index af6f7b41201d..a3e6b6a96530 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -981,6 +981,12 @@ &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
+&venus {
+	firmware-name = "qcom/qcm6490/SHIFT/otter/venus.mbn";
+
+	status = "okay";
+};
+
 &wifi {
 	qcom,calibration-variant = "SHIFTphone_8";
 

-- 
2.51.0


