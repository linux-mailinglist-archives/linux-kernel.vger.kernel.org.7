Return-Path: <linux-kernel+bounces-844467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE823BC1FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5965434FBA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD12DECC6;
	Tue,  7 Oct 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWm2hSDM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF812DE200
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852511; cv=none; b=M6twXLPALPYqDRENOvnuP0cT9vOt7Dusx2yn3Kxk5OP/CdSXL+yim1fetTDE0ew+H1LbhdY+aTLTVZ/g6hOxw11ICrH9tmC2tU/2OAn95gr7Wulli+3UJSjK25crA4Asmz9Z41nblwxOWgvElCSDjgnDvP1mlnBvIkgeTHEIlfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852511; c=relaxed/simple;
	bh=SrQ0izSJThSrT/IpzfFEkCObODKK/0BzDV6aFd4HJRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=grFY7qqyVoLcRT8vZI7l3j72JOtJi+38qCon9u64fH1jy4h4etwrzG1r2q6NC/tJS6JoGmckqo0T88Q6/sNSxMG8sEk1X2YZ+st1z47HenWNrlDA3Df2uT0fMUSzqaYiDJ02gQevrm2YQ/Jr1WiIJB1vNl38TQTcO7Bl2mUP3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWm2hSDM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4539dddd99so963098966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852507; x=1760457307; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwn4iJ0kBXeAlbYIX5lfnaPGY5x3TCgAKgWBsfGbbTA=;
        b=CWm2hSDM3JRTPGemHdI8shDXDd03ugwh1jEHL2MqtQEWXEQzV5KuGBvyEazeT9DFul
         OxwK/FgIryZajV16jRWeQrn7/InnYkrb1qsEqeYZUwnMnXijm4caVnitDE0gQHhVMv7f
         d8njaVOelVhtxlhjTKsjk+9zI+CLDjZRxuuS8oeEnwY2+BQVE8F3Oy8Z2Kw/xxkyzRG0
         Tcz61JumUMFVM+14yoL8Scg6aLM7aqIZPyPl3cbD+44wlga3eaTVST1uU/FFNIGAWCQ1
         hCnaM3sD0vEZMVeIb0Kuvhk94rYS9knOnvbFXm5oTaOKZZfxEe6xqERWhm13IwEm55BF
         sxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852507; x=1760457307;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwn4iJ0kBXeAlbYIX5lfnaPGY5x3TCgAKgWBsfGbbTA=;
        b=gpx6vkNmb0YpjGDBIpWDWf2bUe4XtyATAji0s7oGaJaVciXufCwnobPljCiYsEHzL2
         u9LzWywPprvfoKCIOi8YEQgMsSAw+g7x7H5XqSkGmw6u8see2P4zFD8YJ3jt4ezgf6Hd
         5I7vQT6paTeP/osNbMwbe5rRBGeL6OYvGArECdryHCvA8oxmf4mGdC7Ol5G8VoJ1lK9C
         CrWPSZhZkkqaS16e424PjMOEZpziug6PMXitdkVkkbSMLc5KoHy0XFzQoHiwA053A14o
         4IG6QgCT2J2xe88Q1IGCd2BHyH87Nt0mOwvyaD2gFZlTY8Jq8pcAfd7k185kb+KCqSHO
         FNig==
X-Forwarded-Encrypted: i=1; AJvYcCX6Mo3ExON4doYUasGKQ+izKSggXk3W05Epi2gC564UxbtS5LuYb8WLdY4VTJP6fn+y5otmRm4+mmiPPOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKYX4ADVk/FRFrr2bXCkzkOozvLJw0SE+pruURZMvg4ufTMpI
	N7xLxUjDzRwJWmNS28cD2BRIEtIr1GQxja9xFpsm3E+sIGgBrlpa4KbOKZz3E1FEvxw=
X-Gm-Gg: ASbGncusF9VapdIXQbaw1oPwKzDMplri1ngMZlk44Ks48bD1Qg4JFK8P2QVIvsnkz/P
	ck/WtsjeODrnMulQIzIQXlwjkEbNyqPUjY0jQqFUxS7S1x5J5l5pMqEzdlbGBTDHEXHd61ojDPh
	FfWMDJ5b98OYuYpNCiXUNDhT9EvuDV0yt3hgFErP2/wGuS8W8ytUFVC/CmWWAFhKi4cO9VgnQsD
	pq5K4kbFAvJpT4TK7AYlWEmlupMONlh9+glpJEiRRr+mRrFPeaQRPmeS9PZLMp+qWPEWBzFb7DA
	/dVhoV0nNh1MDOeEU1XiIGVOwa2hgMvFyBWkmvNTxxxCWnqPon1RFb1TjAP3S0CQE0cD3CXVL+d
	OAA08YEN4rDHQSy81Yd89LBA9x0ZvkYKcwaBQKfyP9E0rDTDHDMi0bzsd3kOo4LEIe3XjzovRGW
	BDY027m2KGsg2kQvPy1FhN6CRdthkQhnWpBtrApDXdtmhtnYWW+fA=
X-Google-Smtp-Source: AGHT+IFMkqhgkZjYTFJJlsb6ohBZEtxooSZT5I4ro08N0+thklTNSC1wFRUbLDiJOSsfJFdfZDi8ng==
X-Received: by 2002:a17:906:7312:b0:b48:44bc:44e7 with SMTP id a640c23a62f3a-b50abfd68b2mr14143566b.48.1759852506937;
        Tue, 07 Oct 2025 08:55:06 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f7eacdfe6sm225312766b.27.2025.10.07.08.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:55:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 Oct 2025 16:55:04 +0100
Subject: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: add power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-power-domains-dt-bindings-usb-samsung-exynos-dwc3-v1-1-b63bacad2b42@linaro.org>
X-B4-Tracking: v=1; b=H4sIANg35WgC/x2NywqDMBAAf0X23IVoDSn9ldJDHtt0D24kW6tF/
 PcGj8PAzA5KlUnh3u1Q6cvKRRr0lw7i20sm5NQYBjPY3hiHc1mpYiqTZ1FMHwwsiSUrLhpQ/aS
 LZKTtJ6XpNV7RmjGYaJ13twCtO1d68XY+H8/j+APzX4i2gwAAAA==
X-Change-ID: 20251007-power-domains-dt-bindings-usb-samsung-exynos-dwc3-504b0c57a78b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The DWC3 can be part of a power domain, so we need to allow the
relevant property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 6d39e50669447917a2cd94dacee5822467eeb36e..3098845a90f342dc29f4343fc0ff5cec009d9629 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -36,6 +36,9 @@ properties:
     minItems: 1
     maxItems: 4
 
+  power-domains:
+    maxItems: 1
+
   ranges: true
 
   '#size-cells':

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-dt-bindings-usb-samsung-exynos-dwc3-504b0c57a78b

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


