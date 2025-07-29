Return-Path: <linux-kernel+bounces-749225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895EB14BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1027A46E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190C1288C0D;
	Tue, 29 Jul 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Si5zKBPB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6582882D0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782676; cv=none; b=SAp0RLXw6vHWOyxjGEho0fEmiGecXohjv37bDWIWb00sNpmhBDj0jn2RFX2WaUyvWYnIX4ahAomyyW+8gPWracZ8gMeKAWmYSWNqy1uXsdBGiO7McgzbTPs/O2qGi6w0VZ6fJAYQ7OC+lZ431OVZ4OkYJ8MATe+Kp5dqejSg8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782676; c=relaxed/simple;
	bh=PPTY3EBWf/otaI/DRQ2USIoaVvA+G2t6tbNhqLyGWpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKqUHxn1CGuEkwMG8w391AkW6OxI8UTiUJMfohKuOLVF8rYpCMu1Y3YTCdnb6kZInMGsxln3nMKdYOa6OEDRQttC1jmlIPbv+KiakSqgTwyRaz/s9LJYZZJJEWGx9heZ7AGHpuwrcIVWFg32UdwesNy0rzp4WtehCDxgLmxF+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Si5zKBPB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-749068b9b63so3639012b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753782673; x=1754387473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhMEhDHuJe50c0Y9oEddnTStIZgEJGL8EToCa0MeNLo=;
        b=Si5zKBPBWkv3QYgz6sM+faPpFEXW7WEzHa8RnsnQ1Z19ByqgKHvUGp+jMwkwwQFSAt
         hk+LaoB5PIxJ19Uweakx/bB8Z6tQxAULt9Q1K42jDJ6pR5ak4MQeWyNrURNtPQixtR6f
         ORLxuMbBDUUn+iyNkdW0q4WYEjUljQaL3AhXC9wt3huWwiknbLdE2+eJrXuk41O507/R
         swA3k71486od3OFt7rO5JgQvyAJhP+IxfQTOQ1scbWvr3C6YLlpIPxYN1IOxVag880NV
         CscnfqV+zg457XXKmSQgC8V7iWpxV4WyRo6QOnO1ZjpMMnQ0q4Z6FGV2WRhZ2d3diTMk
         qJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782673; x=1754387473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhMEhDHuJe50c0Y9oEddnTStIZgEJGL8EToCa0MeNLo=;
        b=FX2XZKi/LG/7EhA46C70pq52axXBNgLZDfEibV5KU9g9HicvkcZ46Q2A6fRZecqD4+
         uOKvb2tee5dxMeiI0ZLm5fKVzo1ppUBpMtkS9+5Tc8wOtxiyQ/FQYy8XB1Z8F23mh3/5
         wVSlJX+XQsLxQ2D5y0814YNxaKyFeNcrOUTRbbVuL6coBjshohgURKbgU2EfjkSiYiuZ
         nMLMxSzs0WQqWLT5xPfKafAN8QDolvAbBWBfUgn+SrrISiNPsnguZ+mbh1Ipz6JgTVB0
         rt2AqZo7trnEBK/LZlOPn4EUHtl37+NwOaKKvydALVT0ertQL8Mta/uXt7C/8nzbqnee
         L7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUcUoJHlB0K0hMQJkULFILx3JrbtwofiThPPw0rKd3tGbZNkM+n/7l0Jr288Me2gcUMeVQpVbj3gYSsyMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7AJ7lvPoaEIO56mJhy0amA9vDWhstyrkaLeJDWjm5CvXwm4QP
	EbuVW9Qy7P6crSXGXxCZnTEGF2lS7lTmmkzGGjj+VE3HsELQi1CeShVRWIIr7+0+Kw==
X-Gm-Gg: ASbGncvyqSNprgwS/29nbRjxcdG2z3oo6kMQqTdRrFJyL7CmxSrr71lxXBh3luzW7NM
	QPQukFSPEQlGlPhmBmSQ3qjIfAp+Rz87X0Z3WRE49vsBsWbApmX8pOnXSp4JPWFXeveBBEJt1PZ
	s86AaZYpX/5M0zTPXvHcWAkMcxKusq9Vr1UovFqI39tFvw4Zf65PjcFFk3IVvU9O4j7OWlMGxf0
	HoPqTu4hLDw+piiENgZpfmioeU1fvlstgcFFoZKGgZoRa5WHAbkbD6KVY+gm1b7v/Jp+hchGaD4
	gJkFhQiaf6BKkS0i5zXW2uU+PeQ2iOkHZ7ZnKeULrj+fNwWJ3cGsVO/3Z9x7QxxogB0RJnb09wE
	0uklGHF3WegZ0XWmduIJ/pzScKL/eqlA=
X-Google-Smtp-Source: AGHT+IGRuN4bMTuKrqYVdmJqVFT+qoKQgtcZpI2ah8oemY7i1w0uPXl3QS2dGd9gd7nItemsFz9mgw==
X-Received: by 2002:a05:6a20:9389:b0:229:1130:7411 with SMTP id adf61e73a8af0-23d701be41bmr27749974637.31.1753782673040;
        Tue, 29 Jul 2025 02:51:13 -0700 (PDT)
Received: from [192.168.1.6] ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm7614498b3a.117.2025.07.29.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:51:12 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 29 Jul 2025 15:21:00 +0530
Subject: [PATCH 1/4] spi: Follow spi-parent when retrieving a controller
 from node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-spi-bus-extension-v1-1-b20c73f2161a@beagleboard.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
In-Reply-To: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, herve.codina@bootlin.com, 
 luca.ceresoli@bootlin.com, conor+dt@kernel.org, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>, 
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=PPTY3EBWf/otaI/DRQ2USIoaVvA+G2t6tbNhqLyGWpk=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBoiJmG5oK1u3pxCYpL6Jz9P9NBiai5vv4OQcoKS
 bZqdgUe5LiJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaIiZhgAKCRAFzvXHieVa
 dBMxD/9iSM1YQUhhkrVc5EJX+S0biAoTFOAqBhj3SPxY6UyIhsMbskjA9OdK0Nhc9ZgGTSjW6MI
 LnogxUC1yOqUnn7B5R3ZW9NFIoahwD6ySrunNRFSHs857hFlJ+ruMvZjVcZncQG7y3Uz5kpVZn7
 3B3gWpd/xTcGjF6liaZ/QNF6WicZnkekDp+NtIR7t7FQdf5KEQEuESSiXKR0cDF2GbvdGgUnrNa
 UlFvSf8N6iCHQJqlvyX7NIBmBlHDBzcYfV6kJY/NU6k5V1USzv5S7lY2gJdxTERIC93fr0pedP2
 oGJS2tmkOiGgpqGdX6aHUTBotGWknshtgKh1pUFLvbN9Y0efCkj+WrHMZmWrVsLJVp2p/efcnEZ
 VUEk3C0ZaBWS6WhFfdKnl/JSBj5cjZ4zY1yqA2GfB7M4c3hrMKA6W5y5ER9EXJvB1Rrn5pjl4UZ
 uuu4fUpzTf7Htd9pQBzPvKsr/31tNIhQkFvVd3lBmpqVinvlGOUWYzg3aOWlC+vq7BmpmgWT5w6
 T/v2YNDd+FftndKZ7eFHH2PBvSbdTCkkftLOv2btA94VhpDC725xzI4fpijPIeOUuWFq4cTmZ7x
 Q9IPS8UuriWMsfH0oGNJdQvTQ2x9nzrRdWOUOSniqC/OoHeagnojcFM1YTtIxFnNgd1I7wjyy4P
 kkHtdQUxvOIejvA==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

spi bus extension were introduced to decouple spi busses when they are
wired to connectors. Combined with devicetree overlays, they introduce
an additional level of indirection, which is needed to decouple the
overlay (describing the hardware available on addon baord) and the base
tree (describing resources provided to the addon board).

For instance, the following devicetree fragment, available once
overlays are applied, is legit:

```
spi1: spi@abcd0000 {
    compatible = "xyz,spi-ctrl";
    spi-bus-extension@0 {
        reg = <0>;
        spi-bus = <&spi-ctrl>;
    };
    ...
};

connector {
    spi-ctrl {
        spi-parent = <&spi1>;
        #address-cells = <1>;
        #size-cells = <0>;

        spi-bus-extension@0 {
            reg = <0>;
            spi-bus = <&spi-other-connector>;
        };

        device@1 {
            compatible = "xyz,foo";
            reg = <1>;
        };
    };

    devices {
        other-connector {
            spi-at-other-connector {
                spi-parent = <&spi-ctrl>;
                #address-cells = <1>;
                #size-cells = <0>;

                device@2 {
                   compatible = "xyz,bar";
                   reg = <2>;
                };
            };
        };
    };
};
```

Current implementation of of_find_spi_controller_by_node() supposes that
the node parameter correspond to the adapter.

This assumption is no more valid with spi bus extensions. Indeed, the
node parameter can reference an spi bus extension node and not the
related adapter.

In the example, spi-ctrl and spi-at-other-connector nodes are chained
bus extensions and those node can be passed to
of_find_spi_controller_by_node() in order to get the related adapter (i.e
the adapter handling the bus and its extensions: spi@abcd0000).

Extend of_find_spi_controller_by_node() to perform the walking from the
given node through spi-parent references up to the adapter.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a388f372b27a7f29d18f1dd5e862902811016fc6..0030e0be0d9b2f9e2b0c4a1d806b42bdb4ecb5d2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4776,11 +4776,18 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 /* The spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
+	struct device_node *ctlr_node = node;
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(&spi_controller_class, node);
+	while (of_property_present(ctlr_node, "spi-parent")) {
+		ctlr_node = of_parse_phandle(ctlr_node, "spi-parent", 0);
+		if (!ctlr_node)
+			return NULL;
+	}
+
+	dev = class_find_device_by_of_node(&spi_controller_class, ctlr_node);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_target_class, node);
+		dev = class_find_device_by_of_node(&spi_target_class, ctlr_node);
 	if (!dev)
 		return NULL;
 

-- 
2.50.1


