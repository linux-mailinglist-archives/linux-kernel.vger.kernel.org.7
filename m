Return-Path: <linux-kernel+bounces-875442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F43C19106
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A50564842
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B291329C6F;
	Wed, 29 Oct 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLIcek/N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C923329C4D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725732; cv=none; b=HReRf04vsxYxknnSTnX7TkuvkTrJB+YKlj1W3lQhW9hfznHc6K8jZzPj/FyMCHWNBzEhLgh9y9cjE1Eb8TEOQ7D+oI6p8n16p+mDiGxhY3/8ATgox9YJdZsi8jJW76zVjoZf26wJjsSp5gzowB617DZscf0jqGphlVXeoa+q1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725732; c=relaxed/simple;
	bh=wtJAyPPNUJSoG+tZe3t5bj8Phdu4BHHUQMRRI2v+zXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnh0pEvMIDXie/rYSY9vTWX0pT0GdFGngYaeRN4TERbWsK/FUiAeo0hlTYNK+24AsxTtc+HvdTT7PWe391TP6X+259zB5AMcRcP7Ob8H7rh7GzotIh520HSCVXTPF/QxiYymaKPc/nRnOK8nFCgZmFP0cFCxbh26chsBFjyek1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLIcek/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761725730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ff6OXw2ny4wHZ63fJoa48H6ku6dx6lxuxmUL0GeNKqE=;
	b=GLIcek/NoLSsXyyC1p2UT4i8h/Dumfu9ZBaD6nxnDak4Q8PNpdf+LuySuibLwrUtzxbsfc
	K1uKtV1Bz+rwlLoMMdeSDNet8r0ODIe40yJytXUzRAhw1siuKtYkq4YoxxVkBbMBAAHue1
	3gw7szC3lP2haaMVtxdHKi+AE6tNo3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-NP_wwzLbMZavHLAeE8mj4g-1; Wed, 29 Oct 2025 04:15:26 -0400
X-MC-Unique: NP_wwzLbMZavHLAeE8mj4g-1
X-Mimecast-MFC-AGG-ID: NP_wwzLbMZavHLAeE8mj4g_1761725725
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4298da9fc21so2294157f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725725; x=1762330525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff6OXw2ny4wHZ63fJoa48H6ku6dx6lxuxmUL0GeNKqE=;
        b=DWMJLiWlDsTSMz7mhBkPTJSC9DaEbcZXfCBUH5jfW+kmm3d1tpbwye1F0SomXSRk1c
         O6NmM6xZ3CAlulJOF2OedYQLVoXfaAT0dRPzdHQpZ4r3hysFN+gR+1ysGnL3luYBJMPn
         yL5aYTBC/6EoiEktyLYWsLT3Oh2KOVVSVjO+fmY4ClSqInNrYQ/x90Qus4Sly272JJix
         KfoBFNf7moBgkXRe23G3HvxIsAh7Cx6Z4kfw4pediHCbla0UexzOuEeCzcgDCQsrzAt2
         Laf68AOjQpvIt5BA6LyhiOCN7Dc8pk2cD2yMFyigMDhzoTcjqR8QqvK1r+1qACVvpffE
         0zcA==
X-Forwarded-Encrypted: i=1; AJvYcCVEX/8Lo/88nimGFU9ycJbjnRx6wcECoezpCn2B78FSFuqy8KinQatKbLKi23pDtz5IFbpFnUmdXKCXCGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpO4cY0fbncKK2rh2dLJNW3eIQaoo8qmZWBM1DUg8e/ODbLgb2
	VbehJKkJUEUZ9MXSz/P/Jq9gRs2NwTIL4dYBkVG5hLmH2TsGC2ua1drHj93UxXQlB9tThyCpuMH
	ODWorU0TrodElu9tIhgdIUJv4sOj0Ol/JgN7M1nYTKFRIxEPJtPJY9y35ajl86pULbg==
X-Gm-Gg: ASbGncvz46jXqlev8taLhBrcJjUURJQXggzP0ylPekInOeh4+OdcEYY1LMZBNqvZpKX
	wnIY0JS3RDow8Y3enMUav/+PJBFEx69Vn33lZcdo+p6IB2MRinggFteUXm8vIuh2AVEn82bCmy+
	uO1jolRkUFsnGxhJFxvfI0ctSM82wvXP5EV7V+pYrpReYSYYmrPUo+OiYvACQE0KaIn7e6UPDdd
	ufyL7c4TmmgfGSMTwuAgiard4cW0ORMCt6yLrX/Cd0kUJNEB8YHGXdjmhBUo5cYncrM/62zlc9N
	Nyuhhwz4DWod/S66gD4d+6jukyMst9rL3cd9oNiW+5Orm95mKDWUCtkfjcYbF9HoztpUSDSUlGQ
	dZJLSlfz0KhEJQ+mgflgxNrMMuT9wIeOaNsQiHu237GeRA5o9
X-Received: by 2002:a05:6000:2004:b0:405:8ef9:ee6e with SMTP id ffacd0b85a97d-429aef864e9mr1647190f8f.25.1761725725473;
        Wed, 29 Oct 2025 01:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyeojvasr6BooAy28GwhnCgQwf9+jW8RWuw46Y6Ps5/WvbTuvsqLh+jJH2JbliCLbpmi3Owg==
X-Received: by 2002:a05:6000:2004:b0:405:8ef9:ee6e with SMTP id ffacd0b85a97d-429aef864e9mr1647165f8f.25.1761725725081;
        Wed, 29 Oct 2025 01:15:25 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b7cb9sm40050385e9.15.2025.10.29.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:15:24 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	support.opensource@diasemi.com,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: remove obsolete file entry in DIALOG SEMICONDUCTOR DRIVERS
Date: Wed, 29 Oct 2025 09:15:16 +0100
Message-ID: <20251029081516.83298-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 6277a486a7fa ("regulator: dt-bindings: Convert Dialog DA9211
Regulators to DT schema") converts the last txt dt-binding in DIALOG
SEMICONDUCTOR DRIVERS to the yaml format. With that, there is no file,
which matches the pattern for the dt-binding txt file entry in that
section. The existing yaml files are already covered by the file entry with
the pattern dlg,da9*.yaml.

Remove the obsolete file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8085fdca7bcd..70de2f9c4a50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7213,7 +7213,6 @@ F:	Documentation/devicetree/bindings/input/dlg,da72??.yaml
 F:	Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml
-F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
-- 
2.51.0


