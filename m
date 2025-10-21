Return-Path: <linux-kernel+bounces-863056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D45BF6E57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DFC3AF7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45246339B38;
	Tue, 21 Oct 2025 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHxZknXh"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FB2F5492
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054665; cv=none; b=sThmUFoQf9l4U+572sGhw699nkb4Xn7lOuP2OWW71DUD0s3CPQZaY++N5sF/vokSrGzlHWP3c38lIz2SbWhCjhbeiRbYMQdJrnLoqZkP1e7dnlAnRiSNme3PMkvfff6aa6K7wLuwyQEG/rXR8FIx7oiZmnXicv4Yg4yqvX38VDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054665; c=relaxed/simple;
	bh=4qWmFWV6usDb2WlbnIA9nnwCzxgqGMt4OeZOHW/cja0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSYGmiRGYg2kE+p5iTLLBby63EWs+YD0PNtYXolyMH1kOfP1/mvXMCH5w0bCAFesakrN0CM6cF+2RZjfJVycrshjxf8rZzAGlFIo3jsryLLmM82CdHZ97h/Hib6/xXVxb0N0pw3UCUXaSiaAvqQNJePaZhQXNqfe9nFn5/E/EoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHxZknXh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42706c3b7cfso1931929f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054662; x=1761659462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIKAmk/sr3iPYuDq3IopdvjJm8cBIcm5+Vkp1UdclNE=;
        b=mHxZknXhD+VXL+qgE1NmR+FeUJHsGytOqC7oblPGXddMq95YJD6BG8YlH8QBYnWc++
         sUXxo2gJPLjKKJkJFFPbTUTjHAS6ZtVP+3SarVNnTtV6OFuN9dViTyYGvs/lWbNE1yXw
         CgmQ+m8JMpovU2CCggxcNuN3Ojo1pCafxnpZs6fTdA0JZB/8O4lIMIKi6j5V3PUlhPEV
         PhE+gsJfTrlU1gNX/ZV+tI/D0PVLKidk0IXBoo7ApRuFliGin7aeAmjpRCXGMnYw23fI
         w6QtTJJ8YrnGf5D03VossnzJ0+aqh0DXuhY/3QJZmmRPQUK2oADFQKXEG9MPblD1k/Bu
         hQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054662; x=1761659462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIKAmk/sr3iPYuDq3IopdvjJm8cBIcm5+Vkp1UdclNE=;
        b=enY5aa7vqSZFXIdc5zCt5h3Hcmg4zDiTe0Dha2ZjW9Vf+o/hL8Qo7pAeaopAZXpdnT
         spHob00f6Ar4mo2PBzxdK44N5QjxqvuyO+TqM0Bf4UaC3NJiR4+OqVkqEhJSbuNTxhnN
         vcbyTaWWUiYRGjwcjtRhFBKd7Qk+cmRJAY0uPiOZOZ+wABx8RkT00khK0PpWcPsOCQhX
         o8x7mT6ydLK3bZs3G2P9meP5GZMxFTZHorEEEsllRP4DC2JQiYssPIKjw9WTdVDuDwt2
         2aGLn/F2PvhmtzYZVHULEoDvi+2vXSJ1MvUoPTwSKP/bsnNUnxzbItZ6Nja+cR7zG2jv
         gXsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPYdZOdOCpdLbD9+abq1r9NCe8/DVxqpzzcUfq1TzN4S0dNlLrogdueJ5PaOPTdGGYgKwI1A0VxBdcPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0JpQSryOkX1sfRHA4WiRkxNVmDDrraZNVOnyQ94z7jiZprhl
	txIi0MCpzJmrGzTmoq40LOnj8gD14fVIGzBLzBYJRb/XPpBN2Qkjp0Lx6Lxb+nvTUNE=
X-Gm-Gg: ASbGncs/nIVTXBIJ2At3pbbQJd6B1R7syperujqxFapk5Cid0pvv9QkR7e1XfThsJ9M
	JJtVyqKQ94ztpXj7vVQ4XnlW5bGepK9uYquYzwL5LEzaLUuwWNChsO56xVkAQmfZnVMjqMz7P0h
	swXMGKMizIg6OahZnivugjuTqYnnJaKRJuZJ8hwlcjbATyHjeiCT0dJNAk4izBD+j13TK5vwM7Q
	2lL7Mj/qWlD3ehqIjt4xXaMSeM+5oytfR56MBNWSTk7tmSIABVq7P2bN46N4yEVjw8hJokyN/Cf
	o7MvdQmexs/Wiy66eo1Goy43Du+QF/3lU1pEn5lZf81rWDw8T8pXFIVvI6mJNNQu1S1xW2TA7UC
	IUC6sEkZ+OA6cbrVYz3dH+VNBWm0ZwNAiqeQ8ysh7oHn7l8ocUfe7KM9MYgBWxPUDE4LQ+uTaLw
	==
X-Google-Smtp-Source: AGHT+IHNP+f8E91/1pOZh8cHUEUpGtLiB8NKRXERNLSH594KfBNTZxiqvP7VkzGge4eOg5d1BGU9/w==
X-Received: by 2002:a5d:5d0a:0:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-42704d98e81mr11781943f8f.35.1761054661868;
        Tue, 21 Oct 2025 06:51:01 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm20124378f8f.36.2025.10.21.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:51:01 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 21 Oct 2025 16:50:44 +0300
Subject: [PATCH RFC 1/3] ASoC: dt-bindings: qcom,sm8250: Add Dell XPS13
 9345 sound card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dell-xps13-9345-enable-audio-v1-1-6f3f6bbd977b@linaro.org>
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4qWmFWV6usDb2WlbnIA9nnwCzxgqGMt4OeZOHW/cja0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo94++xan16D0H5OsxYqfa71JS3sbzr6bLQ2e+v
 api1hS//j+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaPePvgAKCRAbX0TJAJUV
 VgQ9D/0aM9A9YNTlPu4PveLAsEJG2wE5g3OTHxFvLCruh4g0O8emfw976SwMNA5xbFWxJl+2271
 Rpmese605PkKOkEkUhlmjU5QR4Flp/jV51vE3O4sZAqqzO05uUtZgDTfNADiVWGhsYwfLAmBgYx
 J1tIf5bimXnX/OnyvA+7V9oP/fRBlb/JtK0aBv2Ons2C9fSXY9lTL65KKPrJsCfKnl4NrKO0S7T
 vAZs+0LsQzC7UxqDU6E2y4Lczmmt9Jc89PlAK0By7kK0QEPcQ2rWkKypn5Y5zIMoS9yCwz4Ei1o
 gTUSj6rBmnl4gL+ieubpCz/k5IWPrH5lhOgLuVe5+uVtqtz5Ls2UjHlzUNmkJl6bSSSNUTK5YBa
 c1PbdfvUAezF92c80t1BTN948AOlHRsmtCmLBzh6Y7ZevmyO3y6YjB8z1+OUzBaDDtVep8RAaZt
 T17FQNkASovjBqbzR29N1aO0ofV2APkbiDbrKpNEmmEGl1bSbMcf+21Ru8UhIDUbn9llqQFCwDq
 QCKRypfhTKbX+MJnCw0XdGtlrpTIYnNigf4hwnTwu34pUIHisio/o+g/GAi3LnvaDvDttJRW3K/
 Fa26D6cjcuv+xWW6BTa+Da5ly1R7s8P9P8rcXBH0+e4yo7Fzoa6XTCBKDqDlOZ2K4N0C9TZ5Xy/
 m1xfF7sg+a24oBg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Dell XPS13 9345 maps the speakers and tweeters starting from
the right side instead of left, which means we need to handle it
differently then the rest of the X Elite platforms.

So document its new compatible.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 868acc077046596120ea7f427e802282ed03c853..20566224d2e42574ab96f93c11924bbeae22f0bc 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sm8750-sndcard
           - const: qcom,sm8450-sndcard
       - enum:
+          - dell,xps13-9345-sndcard
           - fairphone,fp4-sndcard
           - fairphone,fp5-sndcard
           - qcom,apq8096-sndcard

-- 
2.48.1


