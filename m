Return-Path: <linux-kernel+bounces-844417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B8BC1DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A124119A4F59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FCD2E6CAC;
	Tue,  7 Oct 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="kxdUpqjF"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C02E36F8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849414; cv=pass; b=d5vSgmfeu76PkSdxeOBMzFDth66E5AyHnapCmDjNpsKhScRBC99BEGP+GqcWYErcXjcKK46r31CxtbWgJB0sfWXLN+ZPl8UpESZsmVqA2Fki0nzCz58cATFUbsB92DNXXHQ+flvI7jhc6zUCJrhRb1/wDKVLMDfyqf6KSCzQu24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849414; c=relaxed/simple;
	bh=tJ+S/o1ygQzRFQQq9CIsPmRo4wywLKXZxdgEEbSm8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK8kPzhmTOb9btyJL71wxxry2pRhPQGKWYOzkDuMUlNvo0pIOzJzbg6EZATci2PohjcTpz2nCO/kd5QQ5LXpGuKLtWYaA2xioOREDWCx4LRGJnQQib0dUBSP5iTgt3clbSDk/If9R+IduJ0LbTTqDDLgIJCWVj3T7UGZkIcjT94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=kxdUpqjF; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GIbgOgvrGdDH0MmO2iVCIAEElPMTCoUhX8twFtDo67qQVi2Va9GnTohiiXvgJYtEgHHXzigHGBQaHb2bl9FoteHChg84JjL6O2vBFCaPO2Z8diFQxagh4Ts3FwqMGp4H9xRh1jYk5nJwjKMyP88fSnZGopAWHItz3YGqK2NXfP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849400; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3Avom6u1bIcaE3ifbK/nKn1t6YtMx3UrDttb45nJwps=; 
	b=DzPJnQR4mEnCNgYqFArnw51Ukq9OBTcDCn23vtVBmRsYo045I6cM3HgbqKBCYqi902if1aIDo4SCWm7Qn4BQRi8H5OW0r67XlVhKMldwP9EE5qORlkNI2iSkdZevg6iq72gmI55NS5Bxn3E7O5mbviNbnXTd6x6iWh7KMNWAskw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849400;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3Avom6u1bIcaE3ifbK/nKn1t6YtMx3UrDttb45nJwps=;
	b=kxdUpqjFGMrCCto0BPvn6mJzGcdo84n7kpL7lQ1fkJxcL+UFi3j53VLD+8NMPyvA
	oeoKKVyn9OcyIaPTKsTQqfISQsoZ8SKg4yrUXV/4Shn+oWIUZbX7YJjpFSr+ud17z7X
	tZfU1yP7DQLUm4mBeUqMc38ZtMZeb2c68tG5IxgM=
Received: by mx.zohomail.com with SMTPS id 1759849398220392.1724335407879;
	Tue, 7 Oct 2025 08:03:18 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v5 12/12] MAINTAINERS: Add Adrian Larumbe as Panfrost driver maintainer
Date: Tue,  7 Oct 2025 16:01:54 +0100
Message-ID: <20251007150216.254250-13-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007150216.254250-1-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Adrian Larumbe as Panfrost driver maintainer.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5257d52679d6..cb68fdec3da4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2066,6 +2066,7 @@ F:	drivers/gpu/drm/arm/display/komeda/
 ARM MALI PANFROST DRM DRIVER
 M:	Boris Brezillon <boris.brezillon@collabora.com>
 M:	Rob Herring <robh@kernel.org>
+M:      Adrián Larumbe <adrian.larumbe@collabora.com>
 R:	Steven Price <steven.price@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.51.0


