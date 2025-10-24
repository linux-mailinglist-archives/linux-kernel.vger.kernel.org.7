Return-Path: <linux-kernel+bounces-868405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0CFC052C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AB9405404
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B23093CA;
	Fri, 24 Oct 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7ogrkYU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F109306B0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295029; cv=none; b=rys6Ecobv+LRCl1Ur/IiIGpa1LwY5htGYjzlcHjM41tme03dj2lOeCnum6NIWGaSm/Ho0L+I6g3fsS8kxYl13FdOXgzlkyb5KgqgHkrq3WqUOEXd8k0QDqjXidmW2JqqM3Lu0f7PnV2PYXmTpsL3UVMXgEq9bS1RxemieGotEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295029; c=relaxed/simple;
	bh=7nF+zX1/zT0vgaP6R4vsmssJvlMwk6TNzjt/SjKQqOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGCdiB1mssHdN/Yqxw0AKP1b1vFpjNmZC5wv61v+fmvjaHAlB79r+UodXYZBALt4VNa/t16+eIFQQ0H/JqxuLO5aQMzt595+v/QUVKxcLtJadAKZKrNuelecIpN6Pjcg4RJA/5U60YM3IV6vrcTA3b//Nbq9xDaV4XitbaEHmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7ogrkYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761295027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
	b=R7ogrkYUZ7ATAZ6isE4FwHKZTcJi+4Tw84+GWblOQtxrLGQXN3aQkW/lM48/SDsrqNx0of
	NBkGepUtvKou8/XSu4BIOEWHFpHfnFMfoLgeHAuUgUh9/ClORFnQGUJ9HY/NeerxhknV36
	VV9Q1+PL5jmSIlCmVxoIFU0/us0U2Wk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-jVotprx2MOeW2nBVnJgp6A-1; Fri, 24 Oct 2025 04:37:05 -0400
X-MC-Unique: jVotprx2MOeW2nBVnJgp6A-1
X-Mimecast-MFC-AGG-ID: jVotprx2MOeW2nBVnJgp6A_1761295024
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42851b6a659so1435768f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295024; x=1761899824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
        b=N8IPJJfPC/KNHPOhobDzrjNrbRHx5yxavVFRJgdh7Gh2Tkx9mYPVHUgBLOuR9GvqYs
         14nA5lQmd9yjea52TUMk5CYdN5eV8e82Q1ySt42BRtr6dtb+BVqxumA0hh85QKlTEeW7
         W2Cg0nD2MyI12VTpGw0KlfzIpmXqINDkAVclIzLw79rG6pl+7XIKeS4krXTEfiGmHjqb
         kgW3Vs24MnullPTh4H6r3YMg+6senymEI2vuIHN0Hv4M7d78O7DSoJ71LAyOx3aV8zpP
         Zv1SjuRJURqHaGabiUCE5yY6gt2TiyeVxUQWXbx/PHwRRjgFQAX3xSHiHAcGkqhbCSRZ
         DHBg==
X-Gm-Message-State: AOJu0YxgAGWfeSCc4qdILZP9iv3OsQfJoDs52x9/dR/ENpg7Uyz5LGOs
	wxVE71nbF5imxpxO+MtvOQU0VpEmg1B2fQGU0ImL2ItHa4u/946DIp56JgskOYlia9W32ezwvIW
	Bcn3Rs00MbZgcwtdHzgsysGo+Ec8EnIu/y+vxdvRIRMLnwNRsakC7bP+fvAZu+ZDZF2ONyj+T25
	eEbNREdh0Fpzv2tZTRGVyEOvawQTqHKEiH8NDutttPu/2kRUT6iHrG
X-Gm-Gg: ASbGncvGGchLa9WOb8cIj80iSQ8r01PvtEHLUoNwUEJv2ijUwC4Xh6lN+zTUESEt6O5
	eh3HMe5PyUiyl8JV+1OzK8bnVWu/Gk9NwtM7tTVPnBfXZEFJ2d+dYJeaOCyvyt8GUunyjnxvriq
	R4sl1teFxBIBzrKM7q5B/kGNvLAnh0vD56s+BKIVlh4cOtcjn4crUO8LkFHzddoBe8tRw0Eu18T
	rxVMhbga3QKy8b6/BBrHExUxxb6MhVZ0dlIb6YLuRECMU8REwQEchkY2F9lWcNCuXQ9K29UtA+Z
	Y7yXtVxVpwwgKkCwcwnRHKmDxHMW6Fnp+Vq7XLWnxLSo0jhXkwPldOxqeH1ch9IMySr9MBVbBoY
	GLhN5x7mQ
X-Received: by 2002:a05:6000:2303:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-42706c4f1b6mr19064125f8f.35.1761295024195;
        Fri, 24 Oct 2025 01:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY0EKEnZ5GAWosdAx/QCF15elBSoXEsoSC6Xm4LJMLlOxu9Uh/8Q5/RbZxyR8bBwU0Ijlrsg==
X-Received: by 2002:a05:6000:2303:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-42706c4f1b6mr19064075f8f.35.1761295023651;
        Fri, 24 Oct 2025 01:37:03 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e77dasm8111636f8f.2.2025.10.24.01.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:37:03 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
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
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v6 2/4] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Fri, 24 Oct 2025 09:36:41 +0100
Message-ID: <20251024083647.475239-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024083647.475239-1-lzampier@redhat.com>
References: <20251024083647.475239-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add compatible strings for the PLIC found in UltraRISC DP1000 SoC.

The PLIC is part of the UR-CP100 core and has a hardware bug requiring
a workaround.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc24301..34591d64cca3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -74,6 +74,9 @@ properties:
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


