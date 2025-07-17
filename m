Return-Path: <linux-kernel+bounces-734734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B452B08581
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B9D3AC569
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE2219EA5;
	Thu, 17 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="K8wUqLUZ"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750721770A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735300; cv=none; b=dIeL0BwLRJXG8WZ6OISqPN9q3+kVDHwOUkijPF1gCcrSrRV49W2FETIHX/flI+kJtWxKQPVbHZ5juR3xyeVEy8OeO/jg7dbHd1igO7H5kVY+hKu4B5ZPL7ufINV/Xy84/Z8Hkq4pQVuIVlj8NF/NfsOIYV7p9ZOcGGu7ghgj5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735300; c=relaxed/simple;
	bh=dxlncHAvtyo7S9r9a4Bw93GIWIXwdIGumSxNnKv+9i8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V8qk9H7PQFoOlEyIrIKmVgt+9XTaVYQs0QE7m5Ct4m3KnFxz/5E8/JDrzcOJ659mPH3DeTUOlo2Sk8HunBYePPHSyVuLli26dtK5lqiaWK9L+h8KbjCx5S6taUVpWhcbPpEN6EljQHr2u31PRFPtp2M831tRLEWQ1SW0xV05wOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=K8wUqLUZ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so918034a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752735296; x=1753340096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTrMaLkKQohvWqI8MgITB/gzL3ZwR7s1HNLPElehzEg=;
        b=K8wUqLUZ8iLeK8KmcoB3ezrCrTEqzPGzfRzLkjtphiTPhb3fJ8g9Q2rt51buQdeLW/
         Sa43YXgddOt5wekxt52GzISUk/yNYEckvqaBYQyf6bK//Uf2/7XMxhsdxW9YhPggAmIk
         RjaaFqhTKjZuelnFw5sqdJlP/U4VB6zzkvxdrHsfrAr/tRmKxqPB0L7swO0xVm5wbQwT
         clShcnUI2MEttfKL4NO6ZgbURlBq99jrBDPPBYyfA8xE9o88p/OtIjaJEN3k2fref+Cp
         Dt87EiTnsP3EIXSgrt9hQX5QxOAsr5mhQ5lx4gJU1TCBg+j2h8jpitFmVgyCBO6BTHlK
         zXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735296; x=1753340096;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTrMaLkKQohvWqI8MgITB/gzL3ZwR7s1HNLPElehzEg=;
        b=H26PvjGcw9l5lFlVQMyPOo4B1jOiB6eMXD3gOvcXRXQD6wJLWQRBtNxBrJGSvMklFC
         3Lkmb2EIed72W7UvrhZDZjkpELeU1mKcLSY/t0HeV4sFWqN/LcHOsV68/rrDMX0CFrQg
         sLukoebQdPRBfsXiW4mcEfE8FrXpUtt1Q4Ijp1BH2kgcnTS7CAW3iFuc6/adCjyNqovF
         QVLXg2P3M88646GkkvgOdzTYHng89ezz3FTS8qfLggomoqzIajg6NUKUAKLvF5r+RAio
         RFC+2/jf8GDmUd7IrtMdsh/dQby/A+T4hfXzHe8ZKVIq0V7B8WzuY3ypX0rbj00cJvcZ
         ylyA==
X-Forwarded-Encrypted: i=1; AJvYcCXvvNU+byyuhxAugodUhMQ6sabuXMBNGE8EdajpZcgrcbBGrkyH43SgX6+DBV1gX2HgVIXK6BqCl15sNtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGwdPBX3UfF4OzXLwnz1bAcvcVVnqGE94gOZ1ZWsNu7zkeD8P
	iTaLLEmlwt/kcoqDIi7BffYrMYa9YFYd32i+cKcVaAz9UR38BP2i5xbLaHtki9tOj1Q=
X-Gm-Gg: ASbGnctfNkGipOjT/EbQWEOFYbSpXz/sBCTFmtejI7KVFpBovEXJd4201TU7gx3UKxa
	ByPwg8GnarhSaXyPbCnKdIcqkQYK1UF2xKb8SZrvuE8c6T8t6fO+a9UQeFnWps2RCOtDIu+2qfA
	51QBKdvQULFVeZbKbVbeGUF8e0gW5aZnJ4iIRgCyL+/XU6hKYuwin1Liot/EVWyWEC5QhCVooSC
	lGuaOnmdbHBCKHmRHjSxapysUtN6P+IeDEbd5vVymxL2KJh/j+D0s/GSPb2qq2tzPT/+jv2vE5J
	zhAKc0Kk45AMh34UAc5/UALIJEKUQEKbd06C26utm+/P6wVjS1PJVKeQ9cMYycwzCExR+KzAFp9
	xlcy2uR6ec0SUUbcFVARe0lPFgc8IDNOE/XbmxbUCbTNXqTWNzQJqEOjWJiBo4TNnG55A
X-Google-Smtp-Source: AGHT+IEPE7jcvTZWHa1uq9a7/be6YWGVsD4XhPzTsJz+8V3TnN9RduahxJ0ofrGWhTknThJCepAl8Q==
X-Received: by 2002:a05:6402:27ca:b0:608:6734:7744 with SMTP id 4fb4d7f45d1cf-61285916a89mr4839700a12.7.1752735296237;
        Wed, 16 Jul 2025 23:54:56 -0700 (PDT)
Received: from otso.local (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612477e1d2bsm4688882a12.34.2025.07.16.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:54:55 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Remove double colon from description in dt-bindings
Date: Thu, 17 Jul 2025 08:54:43 +0200
Message-Id: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOeeGgC/y2NywqDMBBFfyXMugNG8IG/UlzkMbUDOmmTWATx3
 xtrl+fCOXeHRJEpwaB2iPThxEEK6JsC9zQyEbIvDHVVN1WnO7QsnmVK6MNqZ0IX5iDYe2290U3
 vtIXiviI9ePt17+PFkd5ryedrBGvSKS8L50EJbRn/Fy2Mx/EFYecOOZgAAAA=
X-Change-ID: 20250717-bindings-double-colon-8d1bda158c1b
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Martin Botka <martin.botka@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robert.markoo@sartura.hr>, Shawn Guo <shawn.guo@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 krishna Lanka <quic_vamslank@quicinc.com>, Iskren Chernev <me@iskren.info>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, 
 Priya Kakitapalli <quic_skakitap@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752735293; l=6310;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dxlncHAvtyo7S9r9a4Bw93GIWIXwdIGumSxNnKv+9i8=;
 b=4vFdUo3rnWGztC9lQOpPPSWNfnpRHIT6umk1THV2EBX6PKhs3v0lEPSq5L+diUpMVJlkC6n3g
 Try9PArneU4Bu8kIZhL6IqpJ6AVcuIlqKrV2w2zS0mlq+42R/vcb1Lo
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

As requested by Rob[0], remove the double colons found in various
bindings with "See also:: ".

[0] https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel.org/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: clock: qcom: Remove double colon from description
      dt-bindings: interconnect: qcom: Remove double colon from description
      dt-bindings: soc: qcom,rpmh-rsc: Remove double colon from description

 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml  | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml          | 2 +-
 70 files changed, 70 insertions(+), 70 deletions(-)
---
base-commit: 4d088c49d1e49e0149aa66908c3e8722af68ed07
change-id: 20250717-bindings-double-colon-8d1bda158c1b

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


