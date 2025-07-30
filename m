Return-Path: <linux-kernel+bounces-751130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0056B16591
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA273B2477
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB12E040C;
	Wed, 30 Jul 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dI7qi9ta"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023D26772C;
	Wed, 30 Jul 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896873; cv=none; b=jJOl7GdwrvqoVe4v80CNA3stFhT3uYSACEJLr5wETYNCDReXeRB/VMJkkLgt5cUIfjIgcxMhMvMM8XFUrLsyaFr6udc1s2SFuupvzsyBVFcj81lxnyUtlXvbD2iGaMaGatsRgWteVnMihDoSuwNmwiWLcaf+fcvPJ8BJdIxWoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896873; c=relaxed/simple;
	bh=qROHV8QAjlKk2BZfIN3V1oodso6OXMbUwATS8tsy8dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZCldPhPFMvbHku/SPiGOLEJtlE7G+JOJLuRm6fsQwFtgCNv1Kwf6EiCnwlDBB8f3bQLn4WqpyVaIfWSSqgCpOnIA9Bvq5VEoDY7iO7uz/OQzoRCt+CzTJ/o7CYqovU8BgLjya36Vns5CgXs/CzBxFL3XYyR3NMFQirAsk1XYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dI7qi9ta; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=iB/v2d2x1kId8kyTKYQeOnnWd4h8f1+afsPq9BK3y+0=; b=dI7qi9taoIY9oqN7C9hXm472j9
	EwDTQ6s1hwCKlUS/hIa5famkBJGChS7Gkz8DGd5JguD4H4hBIKlQS/rYx7zk5EjUQW5W5CLTfJDE2
	bOBhGPSI2METJe+OhK+VgTjwC9UpRNWTZqwim7E0V3Igdk3pgCkTLTTf4ap4tvNmY6uYr4BNxe/GR
	jM0723laewJZzAQluqrix9Oc5GAzkXz2xQX3Ml08HFUQnVmAKcRgDoe500RH/Z30qQ3qa0+8MkQWC
	0ZPVeuQsp5HF8iWux6R/0rjxD17hIcbXjGK9PwJA97VEEvRm2jswiIzx9UMZr6UhdPfQAh0YRYJF7
	QkNHOVAQ==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAhC-0001cx-C0; Wed, 30 Jul 2025 19:34:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] qnap-mcu: add ts233 support
Date: Wed, 30 Jul 2025 19:34:21 +0200
Message-ID: <20250730173423.1878599-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a better return on all the investigating I did into that MCU,
I got myself a 2nd device - the 2-bay TS233 this time.

Add the necessary driver-data and compatible for it to the MCU.

Heiko Stuebner (2):
  dt-bindings: mfd: qnap,ts433-mcu: add qnap,ts233-mcu compatible
  mfd: qnap-mcu: add driver data for ts233 variant

 .../devicetree/bindings/mfd/qnap,ts433-mcu.yaml          | 1 +
 drivers/mfd/qnap-mcu.c                                   | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.47.2


