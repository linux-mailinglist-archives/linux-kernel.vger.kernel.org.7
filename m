Return-Path: <linux-kernel+bounces-796402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682DB4005E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BB23A39A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE192FF14C;
	Tue,  2 Sep 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7s22P4q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1B2FDC2D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815495; cv=none; b=AZwfqSx99dWPQVreLpyXeaMZ79hFy4OQZ3dUYNd4UNLVKeH/tz4UcTeQSPJjuIcQiUn2xEB+NogdSXOVXKvrUu4x/DM/CS12R/rrqgqtwWa17pyYWofrn6e6nlnOUijFR+KjmTWkgtPBnLBpC1rIfShmpm0hIfjai898a8wH0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815495; c=relaxed/simple;
	bh=iV9OOBcP8NNsmpN1fZ74F397+PanErPMHV3l66Lj7mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOPiQdFdIqk6zMnGhwhupzuDeVMvs7KKELpgp2oo5G9wOYrZFzFHGmrSJVkpC3t+l7PjgMS6OFYsuKbK7acxCNgmnFiq8rA7GJM39Qt6nmT1F1fMTZ0Xs717T4C1WuuGW8NtMpoY6OpeMf1wLjOOnjeNBGaXs58ZIe2DulzCkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7s22P4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756815491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OYbm++mLFAP2eOBK8zrIZwtSqYqUCZncQQAHIfNeOB8=;
	b=h7s22P4q6Mqh5ELUOM0ZFIcvvMNpESHT8cAn+XNmYtuLV5ggXZ47ep83+dePzdw5X14vAt
	NRgsJhn0OrENMczSX+jA3OdXrw9djy0W11KfunvvGhCbv+VRWGUT0j7DKmJPDKe2QmPTTp
	F4VZ48qre8Rg3R7fkF0b78E9VF8PUig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-8i1AwF8gPKqI2M4Jonf5yQ-1; Tue, 02 Sep 2025 08:18:10 -0400
X-MC-Unique: 8i1AwF8gPKqI2M4Jonf5yQ-1
X-Mimecast-MFC-AGG-ID: 8i1AwF8gPKqI2M4Jonf5yQ_1756815489
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b869d3562so25284795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815489; x=1757420289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYbm++mLFAP2eOBK8zrIZwtSqYqUCZncQQAHIfNeOB8=;
        b=qo00XqVOIil5GWSL3zXWr5WxjwNibRQcMizdMaSXbvFC4Bw4MSlz3VGDe5sXfacuk1
         h9JFgKe1E7wZSlsB6u5dQJkd0LxNo3tIRj5Q8q+q/+9UGTxS2uJzHK+dQv7c+Z5TTd6n
         xz6j0LjwVQb6zH2UqNs6mgqb7NSg1zw70IFeyHmoV/Z5V0nBWtFDwGJmOEv+uS0QfGig
         M7F7Tsw4tQlBOWQ6OTK67lbT/nGCjJLEXRw9K34CF+8uSRzDKBS2RrqbciBDEnW89BGy
         wDDlNWTt4uHTyWRWMLVEkrJQOiionrwEOSVExYAIqeklRDEMBy5S1R9jEL2pxkCbKJUK
         D1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWGnWziZAL3KW+uIHgIH+ZEK+a3Sj6tFIfqka2QJ9ZK/ZxiRI33X56UWdQ3GQf0bdfkLtQK1P+/YJI5Myg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdOpdmbI1Pm0QLVt8PtrvRV5RCAEO9CsVnu624p0QmnGebLf6
	Sa9U7XO+MhDHH2D8qtKLU5QjsaUS8B5ntRp4S81IjD6Wp4hmsa/yF1tJLehT6VDH2968utcbrqP
	6THnaR+QEXMdg6u62gQxWMVKDQ3WHStKnACEt+wOI9bzYOrIIsnXkEUA5QhglHr852g==
X-Gm-Gg: ASbGnctxK+LzR50Atj+2KfNbiKbud+QJrzbZhBAf83vEKPsohVpXqm6KDORgiIUH9bW
	qdp/YuMIfzZ/DYKt7xCzvuz5VP5jiGm5qLmtT+u/VsMjHupxCXfW+s5VXANEsfjD03/rOC1J8Qg
	Heo1mCos/VmDgBQfmQa43rqsYn0a4jvlH1Tin3W63e7JleVn26jc0nqaQ210SaxnC0UV2Kpf3oL
	F89+eiRhJGUXRJ1YcWhgOCiMvAuyVs6LUEKvyzdi/RKKbViuHtX7WCNM4u/NSe81WOwesokwCd4
	dXH4Ci9a020ct3PfFu+zMWPXCmCtcpyiY2bf2AS5fOD6D6aVNYgdKkmjtFn66zbmHyHZjGp9Q8S
	FgdejnvNi4lTW
X-Received: by 2002:a05:600c:4ec9:b0:45b:7ffa:1bf8 with SMTP id 5b1f17b1804b1-45b934f6a56mr31211975e9.23.1756815488652;
        Tue, 02 Sep 2025 05:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWniM8t87MstmOKseixN3K4oxvQKmIMmSp/10Fw9hcxqnkqnioeD1dS7AiZVevFngzZ7ccg==
X-Received: by 2002:a05:600c:4ec9:b0:45b:7ffa:1bf8 with SMTP id 5b1f17b1804b1-45b934f6a56mr31211795e9.23.1756815488249;
        Tue, 02 Sep 2025 05:18:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm191441215e9.10.2025.09.02.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:18:07 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] clk: qcom: Select the intended config in QCS_DISPCC_615
Date: Tue,  2 Sep 2025 14:17:54 +0200
Message-ID: <20250902121754.277452-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock
controller driver") adds the config QCS_DISPCC_615, which selects the
non-existing config QCM_GCC_615. Probably, this is just a three-letter
abbreviation mix-up here, though. There is a config named QCS_GCC_615,
and the related config QCS_CAMCC_615 selects that config.

Fix the typo and use the intended config name in the select command.

Fixes: 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock controller driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/clk/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aeb6197d7c90..823125f48346 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -504,7 +504,7 @@ config QCM_DISPCC_2290
 
 config QCS_DISPCC_615
 	tristate "QCS615 Display Clock Controller"
-	select QCM_GCC_615
+	select QCS_GCC_615
 	help
 	  Support for the display clock controller on Qualcomm Technologies, Inc
 	  QCS615 devices.
-- 
2.51.0


