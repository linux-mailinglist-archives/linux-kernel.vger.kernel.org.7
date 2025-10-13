Return-Path: <linux-kernel+bounces-850424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278EBD2C00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F142C4ED1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18E25A343;
	Mon, 13 Oct 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3Z01au+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4A257AD3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354164; cv=none; b=qxXey5vEEy8bxyJZzWhk+JamG5f+BviEf4xGYrEpdYkczRThBR9PqcWtFMbZ6ko6cmVpswdQ42jaqxZmI09cZKHfiY5S9mjvKP1zx0p/7n7ykEn59ctnvyJ61ZVexFGDBoer4Fufh9HOF8aT6va0mI/6dhxVld60YPNocMrSryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354164; c=relaxed/simple;
	bh=mh4KQfHpTRyfwbrzSn7QR9HBsuPqnWl2zeRlyQz9EUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6MVJEDXGWPlPyvI+jmTpRwmOxk8vuB5l5tOaOz1gBrJpeayhja/uraIMblE9UFwaMuO4cJ7gmuH3P1Dlp3JzV2vspHcKUhrbLAUlQ1wcGXshYvXZYH3tbXca7vJkPCMRsVqKdn3jlhxCsDrTichjluJ8QDkakRasB9sPpK4nrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3Z01au+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760354162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXbaRxtuztYp/s40WDhl1rowOsrsCdyuZCaCXhLX8Gw=;
	b=D3Z01au+KMVnsfGdtm0bDAxVGujjbsrPgNxeAFiF3k0DNTAwoE/lr44HoCIKGVZbD4ffaR
	39WENXoJVpkUz9lxmu0FGepo6AK19J+4Bgh8MYr2xEbLwzZtEbULcEXkruBEtJz9k/YkrG
	5cuMFI6qdc+zLgc6IsyynVXKqeCjsVE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-FPm5TaCiMR-WZJ84pGsyOw-1; Mon, 13 Oct 2025 07:16:01 -0400
X-MC-Unique: FPm5TaCiMR-WZJ84pGsyOw-1
X-Mimecast-MFC-AGG-ID: FPm5TaCiMR-WZJ84pGsyOw_1760354160
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b2f989de76eso682932866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760354160; x=1760958960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXbaRxtuztYp/s40WDhl1rowOsrsCdyuZCaCXhLX8Gw=;
        b=NXcqMh5NV/fNypwex6e9Ia67phYS/w4jM9921PEQivxVdz+YqCmHjNqoi/9pb4bd/1
         qZSI3mfAglQuMjbEV9fEOxwW9AbyqvOrmN4VmfivcrgdjYLMSp7YyoJTFnRuuqewW7U9
         uXgeiihNaVVBizqh7ooE1frouT1py7wePZ7vC36qfCbWrXNhJTTM3lt1e5YB3eeKQYZe
         JhJUaujbmb9fTRk4rIKWPMVF7vph03taLAOtSgAiE5mV2EDmKfs2XAxeZG0dnhtVPcxo
         /Pp8QmEeTH79R3sLBZnIOVQV41WcXAkkRPUyHD+ygsBn3RUEHslo4quovYI9jvyPrw7x
         UIYw==
X-Forwarded-Encrypted: i=1; AJvYcCXcQ9sYhzNEW3nkHNTWcihc7C8RQRVRx78Y42denu1+xYltTs0lzHtGkMnBMWsK69pbopgVwcQv1rYIGjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtRI02yBAfvIb+USGyiXGi1nMbjv8wz++xEnVFG7PIaVzS/37
	ekYqP+chowpZBOwGu/yOtDnDwy039cqOOhagVnFAQYa9RSjprnx0YoLpaKQxVf2Pi1zJa0Oif3Z
	ArIroxfTySsfa2dikm4sWJzCVQ49jmC1K6FpcvI8lTuYIAaUpCdF3ynQ+CFREQ9lMQQ==
X-Gm-Gg: ASbGnctXyUHrMl2YIQqMoAM46DQqli46T7DwaIaCGe0uRKoWHo8oK0tgEpSVLI2hBH2
	obhH2H16aQvC6tZAwExTFeSqBfR5GlpGfk2Xgh/r7uoqP3wD/mm0KlPNQNHXSG36OcftPwOcrSu
	DNZuVABVcj22tkX/TbnGO3hLqzFVFWLxwOLnq8oTWE7oahvHiDpjSJXGAfqomv690i+j6kPd4Fi
	lsSU0TEGbZV3sN3xApPNpSK3LTN1ukXhnA34d8a/wzzOyy7ZAGGpFma9JCUs7MUtIuh+pjIn4pW
	MdrhEz5in14XznzoD5DoGx+X37gchb9puCKqBoC68q2J
X-Received: by 2002:a17:907:3e14:b0:b0e:83e7:f6e1 with SMTP id a640c23a62f3a-b50bedbf399mr141598666b.15.1760354159918;
        Mon, 13 Oct 2025 04:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuUdQXqYYYnB0IxjzxM4QXupFhWiFIY6GmjbzKu7BcvIGOI8cjNpSplnLC3KbMobuV7VWnOg==
X-Received: by 2002:a17:907:3e14:b0:b0e:83e7:f6e1 with SMTP id a640c23a62f3a-b50bedbf399mr141594866b.15.1760354159482;
        Mon, 13 Oct 2025 04:15:59 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm917336966b.7.2025.10.13.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:15:59 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: devicetree@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v2 2/3] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Mon, 13 Oct 2025 12:15:37 +0100
Message-ID: <20251013111539.2206477-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013111539.2206477-1-lzampier@redhat.com>
References: <20251013111539.2206477-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add a new compatible string for UltraRISC DP1000 PLIC.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc24301..a419de50f5a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -74,6 +74,8 @@ properties:
               - sophgo,sg2044-plic
               - thead,th1520-plic
           - const: thead,c900-plic
+      - items:
+          - const: ultrarisc,dp1000-plic
+          - const: ultrarisc,cp100-plic
       - items:
           - const: sifive,plic-1.0.0
           - const: riscv,plic0
--
2.51.0


