Return-Path: <linux-kernel+bounces-887111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90546C374F6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164523B6E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A862836AF;
	Wed,  5 Nov 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="sMErECx/"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26227E06C;
	Wed,  5 Nov 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367341; cv=pass; b=VwECeQQ02OK0y78RwB9ESbC8Rrssm9hL0dhXJbGK5PAr7gR+yEo1TYL2R4dWFQLKIzuDAewpggqTr+SduNkYfAbvqk2SXn8H5PnIRq8xdUQft5uNnC4PrRvhelqdrsVTxWR3xqoffpChf3chcFfssNUQG9Zl3GlCXG4u14w3zQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367341; c=relaxed/simple;
	bh=9oGjFgRlnLnlHnPxSdOu1/cw1btfHzhQFaJHuJvAnAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mB3EKSVREz4b0dT++0JB12nRk94SvyEUa0EWsPFsJ8d+ZFrlkU+m7cNRaW+ctWLzGLnwia5oPwgMSHyS4Rou5hkato8aefvPT0R2XyT6neJCSUXe0f4yhN41NwcyUAeTNP/iAZ5P8QmwMvFOe6OMV+mnHX0anCCH947R5wofolM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=sMErECx/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762367325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GjHagHLN+V/tMrhcWgYb20IS/rc+k3FoRo1dByegtpN6hehPSfK39ITkuAoxkS5ov8jhFdJKPSBgYWisKkA57SeGx9f6QjPe1AVP/I82/582tl0iICIoEjI22p+c2rCqn2oX2XR6xlNxmWr1ebeGOMroJOyvGBePHMa8dopYmNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762367325; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f5EbMf0BPipvo3x173KhdlmoxQaV69HW6rrFDM+4gi8=; 
	b=UCrzw4YGS+W4TnQLlAIAbJbIn0a47lKQQMwa/JtkenVOdfPc2e2tuXJjduJ7zkpUMlEswCl8aY7FbQkoy8xrGSk2aEkbxgeO9rOjBkbV+jQ5juG6tmXtzOubY2kYmK5XXTLeAAifmy08PmdYb78y7z4LuOuSD7roMprPyQ5t29U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762367325;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=f5EbMf0BPipvo3x173KhdlmoxQaV69HW6rrFDM+4gi8=;
	b=sMErECx/3lg3cdJvGXIy8DrzEmztk6OGm4VB0f+Z4MhfSIAEQ8f10UmDK4OYNVF2
	6OLJPIawmHcPMTmv/fJQwDjuonRKqnCGUi1o/wrwDDNqXxEKPGaowyYi/RATo5cDvJD
	LVXFTMkmE5TlqjBWCiCUV2n9wPpBbK1rmXVBisLo=
Received: by mx.zohomail.com with SMTPS id 1762367322150103.11439414779909;
	Wed, 5 Nov 2025 10:28:42 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)
Date: Thu,  6 Nov 2025 02:28:23 +0800
Message-ID: <20251105182832.104946-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The GBMD/SBMC interface on recent devices supports Rapid Charge mode
(charge_types: Fast) in addition to Conservation Mode (charge_types:
Long_Life).

Query the GBMD interface on probe to determine if a device supports
Rapid Charge. If so, expose these two modes while carefully maintaining
their mutually exclusive state, which aligns with the behavior of
manufacturer utilities on Windows.

Tested on ThinkBook 14 G7+ ASP.

Changes in v2:
- Only expose Rapid Charge on devices that support it (thanks Jelle van
  der Waa)
- Support multiple power_supply_ext definitions to implement the change
  above
- Use str_on_off() helper (thanks Ilpo Järvinen)
- Link to v1: https://lore.kernel.org/r/20251020192443.33088-1-i@rong.moe/

Rong Zhang (4):
  platform/x86: ideapad-laptop: Use str_on_off() helper
  platform/x86: ideapad-laptop: Protect GBMD/SBMC calls with mutex
  platform/x86: ideapad-laptop: Support multiple power_supply_ext
    definitions
  platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)

 drivers/platform/x86/lenovo/ideapad-laptop.c | 218 ++++++++++++++-----
 1 file changed, 162 insertions(+), 56 deletions(-)


base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
-- 
2.51.0


