Return-Path: <linux-kernel+bounces-841080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1ABB6381
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E275619E7741
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF12673B0;
	Fri,  3 Oct 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/tNuh+z"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5C248F58
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759479011; cv=none; b=ChNOHfPK2x1JVON71SFlPLX7+VJyHwzbChFqz8vgPvbpR4bzuDKod2BQpYP0FUXCAXdwci62f2tDspQ/qCXJI1TQ+rSDxPnfAiTjYRDz7nVatTwTUMZDYJ9uGl5lGyy6euMfAMNoOqKvUNYzJ0cCqucBvyatk0TVOswJgOg4vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759479011; c=relaxed/simple;
	bh=FzgDnW0LHkuoqjWLgilY6g+m63WHYz7SU/ljq6issTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFlYtVKL70UlK+aBhl/G9O6UhHXcBoVNC8tD01ujd9fXX4bG5USI5pEEdJb7yk+YLPoCqiSpFb4NJj/qm3cdBl+Fk1U7zRQqoEIYJKdJb3vQDDaaG5pBk8SIKlDxngsJHxOZkEzzCxwXXtcWtPz17QpFDH4hrNOimBJWhrMo7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/tNuh+z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so3864768a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759479007; x=1760083807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEZw1xZN8Gwz84nw3aSSSOJI7RYFRhNHk+gh+sXEEnk=;
        b=e/tNuh+zsDEAlX6VcApxZnX2nGROEwZmiXTgoGJ8MmyHM158Wzl6IWPyec/OEycfXU
         vYpDdAEkAdDhnychZVxgog7e9Z8HibCv3cWXKc7tpVZ+orVL8r/mz3Slk1kjSe842tpF
         Av/1r9wUH5z0uzNl8SBbb1PWgIYTBUuAk6x7Zlll8FrkemyQoFX0K2Mpv9QX7dcG9/JJ
         EL4Z8NK+x41YBfbV5FVxwtkC6+PBCvpOb0Ugf8YpzYP6zrWZI9+RpnGBDLR7XHKKBUiE
         C5+/WVfgd3OqHw9PHozZOAn/PCuIWjJLqQab62zLZPp5fkljy4AXDLcqUvKV2GMCRtm9
         JdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759479007; x=1760083807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEZw1xZN8Gwz84nw3aSSSOJI7RYFRhNHk+gh+sXEEnk=;
        b=HykDwAFMLWtB3bCnYkx2D+zIlKT14Csw9urLwcIFrdRPsf6SzFQvh5bcZyiWH/eMpw
         QtiDgemZl/1dBZNZqiNkoukCZdEDtNJbsnvCsGvbGMiAIeuIrzfmL90OI0FH6OiB4r4g
         hV26xEB1qVFO+T0oS7jNPcVSG5Vu775th/XnlDFEC1BcYYyWjg5TZN4ZHRL7EdWIBhIo
         MW+I4blpm2nPJpy7GwAScU/6CEQGGcEDvaeUi8EfOyHR6o4VZAEH4cjYBoeRObHY9LNP
         wlmWlaAyiNS/OODqzhQlzDfBBU6qJ28HjuNeNZByELHrWCPerod6pCDNLl4TTvmUX8P6
         hfPw==
X-Forwarded-Encrypted: i=1; AJvYcCWa8l+HQMuHGfsLDjRAbjPFjPduYKT+trr3Rz2dU0/q0/ZKaqiyhKPKIQcha2cWqRTR26fJjfxAab7qRLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya60SYH2LLrizPsHfHcBdMKt+dcxSQYGBATT156n7t/1vfduhL
	6TI74Os8SFTfq+NL8F6qyenAoXU8JRzTZR4NnsuQC/F/gU+l1rxO4Y7RklCi04FTK0k=
X-Gm-Gg: ASbGncu3nmCrDDf1wEAGrq6Pvt+Ji+I2fIFQYdvz6/RJyO7FEeNd5D1jPlCO/dbrLSq
	QL6cdqkpsIgSORosETOHq/itESwcrVI8k5QfQ+1ilzbX2a9uADURSvvtymETWwZFLAwVhayw2QS
	stp2KgOB42yB5i9MN0hOJRiDUhTgQkEg3y6YcEHC2Sqh/oJWu4guvlecSrdL0+pKF7UnBJ15vQ1
	DpyZjd7ytedqXQ6bOdYFQTYTHqVzBAxEDqc1pfl/0wwup0KXHnGES03opStr4ZKFCb3nk89URhA
	v4XQNyMxYou7iT3bDWja8iqxtd2Q94zIIgq6+lm5T+06RINLxk7JpKvpNZQ/JPK5TkXlNjlOa+R
	O2LCD+7kLsq1vBnBakPG4ULeoIdJBQoxvHlnVsQb2a7GEA84hjAANV3xDGeEcGQyQW57Af87K8Z
	E21A==
X-Google-Smtp-Source: AGHT+IFPgJfqYIt3xEwZNIT1Msc5qVT7rxz+HOc3PPade29V+DzSAFRYs26WIggmAMRkNOXQP5q9JA==
X-Received: by 2002:a05:6402:2110:b0:637:e2b8:605b with SMTP id 4fb4d7f45d1cf-639346c7b36mr1995788a12.5.1759479007333;
        Fri, 03 Oct 2025 01:10:07 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637ef848199sm1990301a12.21.2025.10.03.01.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:10:06 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] (asus-ec-sensors) add two more boards
Date: Fri,  3 Oct 2025 10:07:55 +0200
Message-ID: <20251003081002.1013313-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches add two more boards, Pro WS TRX50-SAGE WIFI
and ROG STRIX X870E-H GAMING WIFI7.

Maximilian Luz (1):
  hwmon: (asus-ec-sensors) add ROG STRIX X870E-H GAMING WIFI7

Paul Heneghan (1):
  hwmon: (asus-ec-sensors) add Pro WS TRX50-SAGE WIFI

 Documentation/hwmon/asus_ec_sensors.rst |  2 ++
 drivers/hwmon/asus-ec-sensors.c         | 32 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.51.0


