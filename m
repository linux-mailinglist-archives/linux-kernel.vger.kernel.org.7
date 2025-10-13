Return-Path: <linux-kernel+bounces-849989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23736BD18E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6C3C04F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF62E5B13;
	Mon, 13 Oct 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFuqtsX2"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2042E06ED
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334983; cv=none; b=H9duykru6VH1XO6UTMC7+o3bvoj3j6L5GfGO1bGK4WsOrROlf8P3MIJnZQU37xE0TaqUWgOvdorrVt9rGVUdHj4a4SVDVzFqmTxkSEaBzFl8n5soptiPPTWS1FQb/lHC8F711z1W0RO8j4OglEqqke6eIeG2KTe+swqEgkXi2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334983; c=relaxed/simple;
	bh=459dlBPh3LInR8NOH/R4UDIusnkt1kveYPqleYn7ivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKWI3nJJOAma530g7NIg6BQcbw8iAd8xYDIiKpURFLLg2D7uT8EOARr6BjmlmWfBTlxEDWj6JPlesQoPdFx+AXaDncryvFmBFmhwsNff2viAP9ma7JUZzxz+wMO4Ggth3OV5EmNP8Hvbh1tsCuNnqMQf34WU+Vo++seB2S7V36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFuqtsX2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b457d93c155so615541666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334980; x=1760939780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+a5/f/Fx6IMBMc0auLZUB4h0ES81R10KOuZfrxfUU8=;
        b=nFuqtsX2FK9RdhfHxvZeJckTFGPMhY0C8dOTFEeb4dGktj1/qP8LFTX/C7+Piv2g8s
         3NF3intM7xplnOrLrEOpvlcg/5H7CzYymMgpoDIT9JPp94DkFL9gTCR2PTmYqTrocZGZ
         Mj/X8lxmmwNGZtbd2199qEtdGvqvjYPQYfr628f/UIwuZW29WqA7qAu6JTMlyegQMBX0
         WGMbtjUnSYw0d/ivKb8UXhmHmwtDEA42bTGzAxxnaTWPBML5mqnY7TX6H2eNb9HpTrsH
         4tbN/F0n46JrYTAddICVoM0VrflI9uAl+aqh5yBRyM1jYJuYLGrbBSxbIOWNPTdpDsAE
         B2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334980; x=1760939780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+a5/f/Fx6IMBMc0auLZUB4h0ES81R10KOuZfrxfUU8=;
        b=cGAHdXRTARiSA5mY4nTjyrv3400aV/8wy9tVbp7/XOC6YmVeR4pWSmki/kh/h4gW68
         ry8FFdRKB7U8dmf7BH9T+Ug4jL+o0ax4ZqYPbLMIyrPSCF2M0YWp5Rspe6+FcAmKLEzS
         OCwluq6XlMWWqgDjfhNDEcrw/aZg9bBSg6S8T3rnPJ06liUJ0FWBe0O7k57x6R/ubHW7
         A8zfrwikxEJEiRTwtyHw7NV6X3HZM0AjPgJQJPp6XSf7dadD76QEmi2FeqpPnoEceBIk
         mt5INNYM+ANwCF8stizwAXDWDbafFSeun+jywClbtqBBzf+1UZ5Ho6888STJfQISJSp6
         i9BA==
X-Forwarded-Encrypted: i=1; AJvYcCW5NrHKOVY0HSmys1+1qUOtZvOB4+eNiOAfgfqcD/UCcKvBXtVLXyUXt6Cm1YhlLXV4q1gm3TtUiwaoWgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJQTgR5KYYwQRGqrK9XVUz5XoDPYnlz5XNqkcd7FsoMdSMSyN
	lXnK2uNLGz13uagSpLtwPIk3RVkw+UB96iDQIpwcqAzCFe6YqE1AQTvF
X-Gm-Gg: ASbGncszOo4djJbeF7Eoy9btfqaDQ58HUnefAN+GWE0BRvk0ufEN+nQLWPXUgdwRXh5
	3wAhp2vqkWfRuVMkXXbS1ndERlgFtKsohOsv8pKTMbwtCkNFr48cgDy2U4z971U7nuqtjggS6JB
	UJQV0hbolfLc30tWwRbK+9iwjQxaai8Q30kx4gOHVijEv4QKO70tUSddIslBm7eOafUfDzkcqYp
	Xezn7rIFfkPOwEiCG5q8yvqlOxwNcsmhvjSxVnQobNXfWR/R7NAv+7z49o4i3mSI+uH364XMSkx
	uNzyn3dDvIYxdmQQ4SIIMyNVIQr+VuIQHlK5AlyF65fuKtKsBVmapCuO8pKGrwZuVeAsnLqp2yf
	x+uSkEjKc0e50mTnPONUvdRV+unJgKFmB/N+t21AoBIM=
X-Google-Smtp-Source: AGHT+IHn6OVFq3+AsRTRv8Xh/omMJt1RsmRRGjDow+0vFNYsqUIkRvU051xfXIY6tzcAIT30syi1jA==
X-Received: by 2002:a17:906:c113:b0:b29:e717:f0b0 with SMTP id a640c23a62f3a-b50ac4d3497mr2144906166b.59.1760334979537;
        Sun, 12 Oct 2025 22:56:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d63c9a3csm860912566b.23.2025.10.12.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:56:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 6/7] dt-bindings: display: panel: document Samsung LTL106HL02 MIPI DSI panel
Date: Mon, 13 Oct 2025 08:55:41 +0300
Message-ID: <20251013055543.43185-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013055543.43185-1-clamor95@gmail.com>
References: <20251013055543.43185-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samsung LTL106HL02 is a simple DSI which requires only a power supply and
an optional reset gpio.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index f9f1e76a810c..01ac0af0e299 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -52,6 +52,8 @@ properties:
       - panasonic,vvx10f004b00
         # Panasonic 10" WUXGA TFT LCD panel
       - panasonic,vvx10f034n00
+        # Samsung ltl106hl02 10.6" Full HD TFT LCD panel
+      - samsung,ltl106hl02-001
         # Samsung s6e3fa7 1080x2220 based AMS559NK06 AMOLED panel
       - samsung,s6e3fa7-ams559nk06
         # Samsung s6e3fc2x01 1080x2340 AMOLED panel
-- 
2.48.1


