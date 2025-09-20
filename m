Return-Path: <linux-kernel+bounces-825445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59CB8BD12
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764081C059AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35AC1E522;
	Sat, 20 Sep 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRNBWyEu"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DB219301
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332840; cv=none; b=L+Lx+qvbtyxMiVBKcfVvsKPvunQ33MOkiDPL4QeIvHvqqk7cUf154AwQNLLinmpvwLq57zZLmTYrpOqKMnJ0oO4mId6C0tuaQkXUWV1sOkXntXGg520NENlSwxnttHhpK1Pl1GCgvDoSluRHqPAjgQajE8+IimMjfBvshADYG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332840; c=relaxed/simple;
	bh=vb0BTK2Rk5uuPvvLLg1eCaDr5BF/IiFelvHr+G7OHfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoV7mpf6bP0yDFredQ/fnbz+aMiU3TuJpWRew8SpFoo3dG49uh3Qis0rGchNjtZbFNBTy3bfKwRD9Pqt57GljOZUNCKvHF9efPCByi2ZXNMHTUQJdQYEkdf/ETvRt4956+NpFKc2frgItvnWrSI+8d97sIWdqHkcSlsUq0epPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRNBWyEu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54a74f9150so2123538a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332837; x=1758937637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDANVNLAXNlGDsrc5CGt536N9WLG4foln19BmJ4pqwQ=;
        b=TRNBWyEuHV+HlY98pe+oZ2vZvYVUN8rkvOagtMUYHWrymYPX53Pza+taS3Hz9mLs8V
         Opsg4XK2uHTEhMoRTYyT7miFc6UOzRbCWIvN5NGWrzOq5NHNNz2DybZ6rR1mOf/J2P/J
         LxRh5My6vAc7U5Bsn5prlv6Sgj5LPsgd5OPdlEkbhZ/yohmd9xUCdN1yG0ON4iEonWJ3
         AYPIbV/2KqF7bsINDRIepqGyeyHrw6WWmVXvDu+s7T4MpkYUM/PiuxZU6XtV/PqGOGj8
         GzAgo3pe9eidoD7v74VgpMwt625sBYtwpXUl/MBuo0USZDVoNJdX/PNG4k8jhSs86Gk0
         FsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332837; x=1758937637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDANVNLAXNlGDsrc5CGt536N9WLG4foln19BmJ4pqwQ=;
        b=Aml/BO/OuEkwsPUQTOiQpuT02xuK/1+preZx4Z7JA0LYwCG0OXh/Iz1QTfC+X/Dv80
         pMIyq3Ks5J93RDbS+lSJSZ/ZcK7lNOPhy3K5XFF81auHGdiaRDF1fs9Xfb88gpxk4KDU
         SVbgm2TVtaB4p9ZSMl76ZsucDqNdgNghCpAafIBRFpzK8VfHEWJcCN03tCuar7tF/UlB
         TYoABrb/LcKu2RcprheicOxcKFgeNAmFa15qrQuDeWV54CSpV7+xa7qeFQ4xOk5+WTdU
         gqCjAQfJyjePavRUdJidff2iMAyUCPVRq0aY6C6Magv728kVuyrTaiu4peSIAZdTHixx
         Ot4g==
X-Forwarded-Encrypted: i=1; AJvYcCUmhKtvG+a+sG/O77PRZA+8fZAVUGgU/PXf4Tgy7JZXCbIl5FjW8afuc30RyXg0TN5AlUZ48zpmzoJuoC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IrT4gDe1uDGpJ1osBFpjcxKxpvkdzlZVmc8YQf+06suHU95I
	ZFlZU/B8wuoe7vEpjMWlMuB+2/iyy38yRfrNiHNK79xLFJCc5nsvLNby
X-Gm-Gg: ASbGnct6snXbrWYxag6m8pgmNQRt7jFcujPzCWTe+vti/HysfwPBsn8cji8tGfNSTpe
	K2XLLLtqjtN1FQga78snS5B6DO8xSZ/4x20qQhMEdgW11EATYRrsFpiodktM0cjlv4QOffgRRSC
	plRJ3XPKmtx9mBRlqHMZtvfZ3biTLzfCEp18cxyRMdbAaMtB6PUirGN87YdExIU8fIbW1QEa/uC
	YTE8ywqbP0FScqprxQkSLomI2rVx1oehW4w+m44se80Lx6hz6XNvhf1RZ3tsWX/mZp7kqGfSl8Y
	Omi/7j+3exk2SB5Cjl7hAe7a2jM/CyII1sdmkHc07etheWlD+IPht5sSCgCIblfkjQjWEY0Tps8
	yBntBlj+nehQQJXWKzPSv
X-Google-Smtp-Source: AGHT+IF8Qv7XXWFPUXzrHtj8oUR7XmANyCLJf1PLQPpKbnLGaW+uYuJ1GuJzs4v8GW8udB3N0U4Iug==
X-Received: by 2002:a17:903:2a8f:b0:271:479d:3de2 with SMTP id d9443c01a7336-271479d4e0emr7643705ad.13.1758332836972;
        Fri, 19 Sep 2025 18:47:16 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm65709455ad.131.2025.09.19.18.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:47:16 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: qcom: r0q: enable hardware clocks
Date: Sat, 20 Sep 2025 01:46:36 +0000
Message-ID: <20250920014637.38175-5-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014637.38175-1-ghatto404@gmail.com>
References: <20250920014637.38175-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the real-time clocks found in R0Q board.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index c1b0b21c0ec5..c088f1acf6ea 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -225,6 +225,21 @@ vol_up_n: vol-up-n-state {
 	};
 };
 
+&pmk8350_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+
+	status = "okay";
+};
+
+&pmk8350_sdam_2 {
+	status = "okay";
+
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
-- 
2.51.0


