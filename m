Return-Path: <linux-kernel+bounces-781554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6EB31403
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FBD1D22737
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC202F3C0E;
	Fri, 22 Aug 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbuCD39A"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035712E2F17
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855569; cv=none; b=XGIKzBZmvHhEbTxMJGP4TrJgGD5w3pA9mWBZZTN5r2+TBsrOKm/BLdBf4u3bCSKFWWxEVV4IS6uSd6WRbODTsN7e66cyplRDMapxYG4r3P6fwGlPB837wAl8OBUrXqVQUAKz9Cumgcw1xpiYKa3TCvPiCS3Ze6Z/015pL5XAXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855569; c=relaxed/simple;
	bh=vz0Pb/W66QBQ9wQPylYtekNJpoGxq9q5ENvtBgP8PRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHBE4jn6MUU1INYmGsYd/fKxoEx6SdM/r8J9RXc4L0PwHwqKdeGELpMZH9cyI9XFUodoKg84CDb8vnQo0ESXoM38A5F/L8FyB78lu4W5KKPGNG14pqMregZeEv/l6Y3mtRrQqLUS809FabC/7pYUxr/ZCuNWuif7xHMbimPfchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbuCD39A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c607029266so274778f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855563; x=1756460363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsA/CLw9FJUPvXsg3qlFrQnURFnDrWqBqbRAFJut4KQ=;
        b=TbuCD39A9E48SrOl8faNT9+DuW0g2+eYmFdFGhCmLKytP4XHfYhwGguwNUaI3a/dkI
         Q/bN67XO8flBgGhQ2QhAKFk+bQbv/HZYDoVsXlWOWeKZymhJtVY3KgUWIOYvHszTj99/
         L3KbrLLQeIF71F90j9WIQiHWvL9HnHkE/1ZWDR+fXHj/6JqVVaJqP5GD+o8QbypcnBls
         bcTpdDQs69J9FotW3cscxLQl4nepBb1PBw9RcYSrlf65KBB+QAxU2/eysxsC7hWYvBva
         3bMZGczNdLkTxt9xr3ibtKLalgWmL30ehNKUknCvXZX89FdZRmlTpIvgNutfPpSF0+Wt
         bXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855563; x=1756460363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsA/CLw9FJUPvXsg3qlFrQnURFnDrWqBqbRAFJut4KQ=;
        b=rqETABETBWqtDhqEwyZ9sFT8rgvuopIEjufUHdKrbta420Y7lpBBHDnF5UuPEaoawe
         Z9ljlSBqkfw0kO8QebbouidN9oZ2TbYJVENU9nPi0xXaOcNLD9jsIE/kLiZbzmcmhXI0
         fmZK7BszgZ96U4apwAlfqzQkV+9HVnCyCfWIwgeZc26kApbhsah8tu0GQwBe4yd1mvKm
         wWzllGAMd52KpQ7xS3vFbeDTzoTQt8uFAQAZLCAm2+R/edQuYLVRVOSfek3U/uGsP3of
         CSDDkAIViPQo7iQodbBLKFhytvBbjIB1bSnm+0T1uo3O/y3NK9G+mrPD4CA8RZNbPTuS
         GuYA==
X-Forwarded-Encrypted: i=1; AJvYcCWT6cAubNZ0Jcf4WDPQk501G95nhcIWy0AV6qPJ9m4s0gyJpowhT4MSryPpb1rmHHqNa1488e0KN5QM5dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJT7NjpvRVhDnGZitYY7W+qM7uxIRvD0sz+EyZ+DPdlmy0LN6
	mY6RfmfnyhrDZSiZY6uQ3llY5zvqQ625PY9FHQ325YF2oHsrDHtK404Z4481leBbpS8=
X-Gm-Gg: ASbGncvxkLv41YvofgWNp1OSpiou60Mymo1aHM1z+Fbup1GvhS1wpkDWV/+r3h+4x/A
	zvGmOYDUVxEt72pgBEKlEpHVXGIkONZNKv9lXRx7N88Q7vEnnY4m6hqmMtYVnH+VJWMv1hkWuHS
	O+DRXTOM71oc9DJmRCRODYLdNEsuiZimcPO57tZy9kZMH/ZA8v3ozmmzqDyo2BIzkjehxQ4ETQ9
	wWvEiEiwWvK4VLj+NeQIi22Cfuaj9dijV67w0y0LhTVJhDOefPSEahC8+f+3z4XUL5BO+M0rop+
	4jyXVMK55wnT5jus7GJKS2Sm39gsHUynZ2NMS59ne1bqWZKuXd+DaGFQ3i4itd+KCLn3dTa7j9w
	8nVE9kkGpgExlSPKZ0qlEh7PV2+X8MuuU6PIc0OwHVq2w6v4I8RaSlw==
X-Google-Smtp-Source: AGHT+IFVZ10vX5nvET+3OmiTPJIQdeIM/Dr4ySQvyasM/xfdsUXQhDAxWIAViCnqjkFgkPdIZ4bWVg==
X-Received: by 2002:a05:6000:230d:b0:3b9:5002:3b4d with SMTP id ffacd0b85a97d-3c5dbf68962mr1288835f8f.19.1755855562925;
        Fri, 22 Aug 2025 02:39:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:14 +0200
Subject: [PATCH v2 02/16] arm64: dts: qcom: sm8650: allow mode-switch
 events to reach the QMP Combo PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-2-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vz0Pb/W66QBQ9wQPylYtekNJpoGxq9q5ENvtBgP8PRw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrC+OxZsJW43oaI4j2X5sDMWvQA76NvmlwbG70f
 SXR3ry6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6wgAKCRB33NvayMhJ0bp4D/
 4p3W721Ja68+AYhpulC8ezULaEKJWB4d5utzF//FWRxmxtXgouhosCuo+tjESd//oKqNFn47aJ8OUy
 o9s4jwxZHhdDZ0UnbpviXr+r1hZkOE4MiQhC+TckvuxbgrepPU2PwYvAQoTjBWX9DfU51DUnkysg4j
 t/QrwiY/530UMILYlGqBjQmfCI7FR0qYrl15NJbpN2kkRHk//IKusU1UkS0a4YpopQm4Xp3d/yilUo
 +80fDY431ch94qRVvvsFa71d+eCIhxeqU44n5pdUcrTgbV874dXp9y4tWKChab1aSrqtNU87QeYHMm
 WzDbqtRmeWjgAj19HLrXq8Cl8AQ+MDUGWtBCsq2rO320QrsrwRWPDwOlhnJv3a+0PyLnjMVffs/oWe
 NJVSStaMJ4qFcfOu7I0XIfRYxKe0fOnNE7E7SRMiVJIdciahQW4j/0587hBfsnt8yeCRWWHLkVuM+o
 sZpx89wtWn7KIlrYkOw5tOW6qo9t6WfUuhJJNhjIBNopLTsLplnhx5iNlpfYDle1F/azYMssarwTGK
 uM/joEPsqjL/o0zNzbO/0P9RsKebc+MKie8G3LfqFj0h7I+I+crrTlUNk8O6a5u/Ah6GzgqVBWJULd
 ZJxTQXJ+NE8rJ1UEqgukaJQ5IJWoBgI4UB4ofeuKeDv3OCx3ic9ETzctF3eg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow mode-switch events to reach the QMP Combo PHY to support
setting the QMP Combo PHY in DP 4Lanes Altmode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d6794901f06b50e8629afd081cb7d229ea342f84..1a750ae39232419d3b496f5a009f16ac8de40fa0 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5012,6 +5012,7 @@ usb_dp_qmpphy: phy@88e8000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";

-- 
2.34.1


