Return-Path: <linux-kernel+bounces-852586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB5BD9668
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693F63A2C59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F43148A9;
	Tue, 14 Oct 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNJ80/LI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82BE3148A8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445595; cv=none; b=T9yEqT1N2XLGfKYrR61kY66h14P5GDzNa+1CN+dvmjAA00O5nZ6KVxLFlereLwkxfxDmp0Loi7Yz/Bz0FfTVVfphNQoRzZ5IwQGUcpxsTG9VGq0euKmlVoog/NYt2Xrqx25UXX27R8bCEjfdGKwMW5GfrtUNV96j0wTUUIvZnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445595; c=relaxed/simple;
	bh=MdFy/rEtddPgNfs1nNoPDNK3EzZtOK6/402QnuCksD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSbYlxo5e8J80wyK/9luKyUeit/RXWNfLHouO/ZBucd2ibO+5EhRHxuXTeLQJZBUUeWQE3YNETSDBHu2gv2D3+d6I44qiUWbDVNO9C6/12pmFQkRJGnAH9Tp5jNK1//K70qlef7xFQaLQdq/F0nqka+hmXh6E929h914lzY6wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FNJ80/LI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so27539245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760445592; x=1761050392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qz/PnsLNKphGj4wu5t6w0DkX4PTYLFQZn42Nmg+SPjs=;
        b=FNJ80/LI5wdNSIel17Na7akokWn9IxQb9gxeEllyT7aSu+TLb5guXs9POJoODrt57N
         8SdKwUptxP2HcZEIGGKhrea03YStv9M9Hi4trXAtNItAqx/yB5cCjPcoLCG6yNO9gcOD
         ilDCY6wJU0VHG5IF79iKIuZXIztCQHoqDy6v3/FYevqn4IJnqbkW5JUrFchMv7SR+bip
         Omm+x1bHlyL9w6MeCMJxCXlGlgdnQpQH8XcKxzVFUVBB/1Ea6fanpIWIUoXcd04RYYFC
         Wyty6ndKmzHxBl2+mr9EQoOPlS6O+hoH1B5dGKQNgA3vnU4Q2IeF/Z4iNvhMnXBFBYlE
         tc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445592; x=1761050392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz/PnsLNKphGj4wu5t6w0DkX4PTYLFQZn42Nmg+SPjs=;
        b=t+X2f7DtEB1DPanl1ndNcGXQG6wmlvUdQnjYrzxy7vjU7PxddBch+8DjCS6zvVaYtz
         VJ5n3NDz1MzWewa+U2e4KjR6+Y4HAXNPe3hF/f2DFJ/YUvTKHXU9yuEHZ+i5YVV93+of
         bwQz5BAdSHdfPzZbFOYfJNEh3TRX7I97+EaexyLJjDvG1wODacrCxzir9kHNLvamZBA9
         Ahy1AWaIZDa3TJhT/9FlGzjy+7Os4lTjEPIJ1PvnWz4lAGTIWyGw2zSWAKEJqceR9Rxj
         dC93hYeKjKHqtBKgTYQpK+xRDdEQBgLGKIeUGdjP50H5umQlW6Dp8WJwvHZm1fkrBn4Y
         yGhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzO6wmizLFHCsI3gS4AY2UrtqmJkNpP5IWvv51ugo8H3NU479qTH2++p+mwL58PwgV1Fi1oIUXdeBA/uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFWVHUc3tCRLkevr9XtdKLh++4hA3GOs5mOUxm/itXvEWoEKl
	a3o8RoHt8y3g0moKomENmw0JNill/mZ0YCMtqSVo3B//KSXuTbgRSAtueb0T3o9OsGM=
X-Gm-Gg: ASbGncvu/7NuHVc9I5d72fmXvsFbEoC3tSTI9uT/UE6DunfTwOHYUc3DNny88AUhsze
	TdQ9Z5io+BSsQGYKlO2d7GE+ffW+hCKIHIGahHvp+iWOZ3Km9O0NagLAYj/qqqUka0UOf5vswZC
	NPKoMiW5iGlFyW/B/vZqafEVSFwXgtmLMroGzE6D0KpED6H7RYHLIm8kdDzCYOK7nvxWUjYGGAD
	PBNfxqnsY39DkMfX0auu1Vw9mszpR9989NPxSrXgO8UjnOp23VQ6F/0UXeSt/eddBUha4rra/Dk
	sVDt6adD2EaM4c7C7Adlj0pAo/AmbODf1EP4DAcqTcXwzJ8OEdT8Nivbxra6Bx2QejFruv+fiTu
	Upo52Uwi9pSur4XMw6iJXLoK4jjL89zfmJ52717SCPxobhnVSxNmVFw==
X-Google-Smtp-Source: AGHT+IHzYJeuQSSdvaVBjpsWcRolFjsrBPl+V+3N9Q0foLP2Jk9xC8lRLIlq37tnavPAFSq2mfhuYA==
X-Received: by 2002:a05:600c:8288:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-46fa29e1c33mr195599705e9.12.1760445592221;
        Tue, 14 Oct 2025 05:39:52 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm245813815e9.1.2025.10.14.05.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 15:38:28 +0300
Subject: [PATCH v2 3/7] dt-bindings: display: msm: Document the Glymur
 DiplayPort controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-glymur-display-v2-3-ff935e2f88c5@linaro.org>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
In-Reply-To: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MdFy/rEtddPgNfs1nNoPDNK3EzZtOK6/402QnuCksD4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7kR/MpIlema7vtLO10UuZNhTbFIUHH3e8z84D
 RD9ZYXA9NmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO5EfwAKCRAbX0TJAJUV
 VotJD/4pqgqFjwMjWLdSHRE8WR5WgFHxPv7BKsET1/cjItFQcfJdEmvTVQM2JhaeXBC3ID8e4r8
 ZUFwza4CdlWeAu2e9AOADQaj75EC+ESZYnO5xKA66sPTWOgqqVqLBtiIYLChP+amJNT4h4asBnc
 /TbZAn3sKR9AIV/DnPYO4jd8G5ixRVlIXMdiEmO8BGtsIkZ8IfsyLR6ETj2k/qZ9MRPW6fCE+o+
 efAXMnFFUZmq5DtPsJhH3lY00BWyKSjU/yO+xdSLBqQWD3uuRJgawppPogzmvuCS9leP/+vnROX
 lEl2LQrx72CvkyZcCYnjlNHr9L1CCa0k94m6FTZZ4nDBa1DSNaX6LK6AzZBbdfoMo4UlAYzx6nw
 cGviSA5kYeFFXTVB/E2WfCGsTovozMhbZ9fbbHw4XAFgyPm1mrFlWd/7zA/1TQ4Q+Fk1xGYvVjH
 hP0ozzif5id5Yy+cs55bW+tGQ+9gJTne0IYwFEbf+7FMtxp6kOfG1v25f2QijXVxASNLFmm6Xir
 o6APPe5LfGH9KGadmGs5vjsr5UEiZNqAKMHYvwzW1QbDSeuNwdCrpXaAjAaCHGUeZR3ghxrVa7B
 zjX/ZZj2ES5hGZZ6HJD5+vA7t1o6te/0HIpJbR9n8XxjWa2xWpEpYBXedbvALc//XypGakqKz/E
 tfk3cRnRS/t4WUw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the DisplayPort controller found in the Qualcomm Glymur SoC.
There are 4 controllers and their new core revision is different when
compared to all previous platforms, therefore being incompatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044a0ff1e78ad47b867e232b21df509..26f5043748c166aa44be4e62445a63106edf9578 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -195,6 +196,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,glymur-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -239,6 +241,7 @@ allOf:
             enum:
               # these platforms support 2 streams MST on some interfaces,
               # others are SST only
+              - qcom,glymur-dp
               - qcom,sc8280xp-dp
               - qcom,x1e80100-dp
     then:

-- 
2.48.1


